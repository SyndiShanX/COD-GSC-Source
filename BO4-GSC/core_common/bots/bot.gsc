/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\bots\bot_chain;
#include scripts\core_common\bots\bot_interface;
#include scripts\core_common\bots\bot_position;
#include scripts\core_common\bots\bot_stance;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace bot;

autoexec __init__system__() {
  system::register(#"bot", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_damage(&on_player_damage);
  callback::on_player_killed(&on_player_killed);
  callback::on_disconnect(&on_player_disconnect);
  level.var_fa5cacde = getgametypesetting(#"hash_77b7734750cd75e9");
  setdvar(#"bot_maxmantleheight", 200);

  level thread devgui_bot_loop();
  level thread bot_joinleave_loop();

  botinterface::registerbotinterfaceattributes();
}

is_bot_ranked_match() {
  return false;
}

add_bot(team, name = undefined, clanabbrev = undefined) {
  bot = addtestclient(name, clanabbrev);

  if(!isDefined(bot)) {
    return undefined;
  }

  bot init_bot();
  bot.goalradius = 512;

  if(isDefined(level.disableclassselection) && level.disableclassselection) {
    bot.pers[#"class"] = level.defaultclass;
    bot.curclass = level.defaultclass;
  }

  if(level.teambased && isDefined(team) && isDefined(level.teams[team])) {
    bot.botteam = team;
  } else if(isDefined(team) && team == #"spectator") {
    bot.botteam = #"spectator";
  } else {
    bot.botteam = "autoassign";
  }

  return bot;
}

add_bots(count = 1, team) {
  level endon(#"game_ended");

  for(i = 0; i < count; i++) {
    bot = add_bot(team);

    if(!isDefined(bot)) {
      return;
    }

    waitframe(1);
  }
}

add_fixed_spawn_bot(team, origin, yaw, roleindex = undefined) {
  bot = add_bot(team);

  if(isDefined(bot)) {
    if(isDefined(roleindex) && roleindex >= 0) {
      bot.var_29b433bd = int(roleindex);
    }

    bot allow_all(0);
    node = bot get_nearest_node(origin);
    bot thread fixed_spawn_override(origin, yaw, node);
  }

  return bot;
}

add_balanced_bot(allies, maxallies, axis, maxaxis) {
  bot = undefined;

  if(allies.size < maxallies && (allies.size <= axis.size || axis.size >= maxaxis)) {
    bot = add_bot(#"allies");
  } else if(axis.size < maxaxis) {
    bot = add_bot(#"axis");
  }

  return isDefined(bot);
}

fixed_spawn_override(origin, yaw, node = undefined, force = 1) {
  self endon(#"disconnect");
  angles = (0, yaw, 0);

  while(isDefined(self.bot)) {
    self waittill(#"spawned_player");

    if(isDefined(node)) {
      self setorigin(node.origin);
      self setplayerangles(node.angles);
      self setgoal(node, force);
    } else {
      self setorigin(origin);
      self setplayerangles(angles);
      self setgoal(origin, force);
    }

    self dontinterpolate();
  }
}

function_7dc6049e(vehicle, seatindex = undefined) {
  self endon(#"disconnect");
  level endon(#"game_ended");

  while(isDefined(vehicle)) {
    self waittill(#"spawned_player");

    if(isDefined(vehicle) && isDefined(seatindex) && !vehicle isvehicleseatoccupied(seatindex)) {
      vehicle usevehicle(self, seatindex);
      continue;
    }

    for(i = 0; i < 11; i++) {
      if(vehicle function_dcef0ba1(i)) {
        var_3693c73b = vehicle function_defc91b2(i);

        if(isDefined(var_3693c73b) && var_3693c73b >= 0 && !vehicle isvehicleseatoccupied(i)) {
          vehicle usevehicle(self, i);
          break;
        }
      }
    }
  }
}

remove_bots(team) {
  players = getplayers();

  foreach(player in players) {
    if(!player istestclient()) {
      continue;
    }

    if(isDefined(team) && player.team != team) {
      continue;
    }

    remove_bot(player);
  }
}

remove_random_bot() {
  bots = get_bots();

  if(!bots.size) {
    return;
  }

  bot = bots[randomint(bots.size)];
  remove_bot(bot);
}

remove_bot(bot) {
  if(!bot istestclient()) {
    return;
  }

  if(isDefined(level.onbotremove)) {
    bot[[level.onbotremove]]();
  }

  bot botdropclient();
}

get_bots() {
  players = getplayers();
  return filter_bots(players);
}

filter_bots(players) {
  bots = [];

  foreach(player in players) {
    if(isbot(player)) {
      bots[bots.size] = player;
    }
  }

  return bots;
}

get_friendly_bots() {
  players = getplayers(self.team);
  bots = [];

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    bots[bots.size] = player;
  }

  return bots;
}

get_enemy_bots() {
  players = getplayers();
  bots = [];

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    if(util::function_fbce7263(player.team, self.team)) {
      bots[bots.size] = player;
    }
  }

  return bots;
}

function_a0f5b7f5(team) {
  players = getplayers(team);
  bots = [];

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    bots[bots.size] = player;
  }

  return bots;
}

get_bot_by_entity_number(entnum) {
  players = getplayers();

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    if(player getentitynumber() == entnum) {
      return player;
    }
  }

  return undefined;
}

bot_count() {
  count = 0;

  foreach(player in level.players) {
    if(player istestclient()) {
      count++;
    }
  }

  return count;
}

on_player_connect() {
  if(!self istestclient()) {
    return;
  }

  self endon(#"disconnect");

  self thread add_bot_devgui_menu();

  if(!self initialized()) {
    self init_bot();
  }

  waitframe(1);

  if(isDefined(level.onbotconnect)) {
    self thread[[level.onbotconnect]]();
  }

  if(isDefined(self.var_29b433bd) && player_role::is_valid(self.var_29b433bd)) {
    player_role::set(self.var_29b433bd);
    self.var_29b433bd = undefined;
  }
}

on_player_spawned() {
  if(!isbot(self)) {
    return;
  }

  weapon = undefined;

  if(getdvarstring(#"bot_spawn_weapon", "<dev string:x38>") != "<dev string:x38>") {
    weapon = util::get_weapon_by_name(getdvarstring(#"bot_spawn_weapon"), getdvarstring(#"hash_c6e51858c88a5ee"));

    if(isDefined(weapon)) {
      self function_35e77034(weapon);
    }
  }

  self.var_2925fedc = undefined;

  if(self bot_chain::function_58b429fb()) {
    self bot_chain::function_34a84039();
  } else if(ai::getaiattribute(self, "control") === "autonomous" && isDefined(self.bot.var_bd883a25)) {
    self setgoal(self.bot.var_bd883a25, self.bot.var_4e3a654);
  } else {
    self setgoal(self.origin);
  }

  self function_acc4267f();

  if(isDefined(level.onbotspawned)) {
    self thread[[level.onbotspawned]]();
  }

  self thread update_loop();

  if(getdvarint(#"bots_invulnerable", 0)) {
    self val::set(#"devgui", "takedamage", 0);
  }

  self.bot.var_f9954cf6 = undefined;
  self.bot.var_44114a0e = undefined;
  self.bot.currentflag = undefined;
}

on_player_damage(params) {
  if(!isbot(self)) {
    return;
  }

  if(function_ffa5b184(self.enemy)) {
    self clearentitytarget();
    self.bot.var_2a98e9ea = 0;
  }
}

on_player_killed() {
  if(!isbot(self)) {
    return;
  }

  self clear_interact();
  self clear_revive_target();

  if(isDefined(level.onbotkilled)) {
    self thread[[level.onbotkilled]]();
  }

  self clearentitytarget();
  self.bot.var_2a98e9ea = 0;
  self botreleasemanualcontrol();
}

on_player_disconnect() {
  if(!self istestclient()) {
    return;
  }

  self clear_bot_devgui_menu();
}

function_c6e29bdf() {
  self thread add_bot_devgui_menu();

  if(!self initialized()) {
    self init_bot();
  }

  self.goalradius = 512;
  self thread update_loop();

  if(isDefined(level.onbotspawned)) {
    self thread[[level.onbotspawned]]();
  }
}

function_3d575aa3() {
  self clear_bot_devgui_menu();

  self notify(#"hash_a729d7d4c6847f6");
  self.bot = undefined;
}

update_loop() {
  if(getdvarint(#"hash_40d23c5b73e8bad4", 0)) {
    waitframe(1);
    self bottakemanualcontrol();
    return;
  }

  self endon(#"death", #"bled_out");
  level endon(#"game_ended");

  if(isDefined(level.var_fa5cacde) && level.var_fa5cacde) {
    waitframe(1);
    self bottakemanualcontrol();
    return;
  }

  self bot_action::start();
  self bot_position::start();
  self bot_stance::start();

  while(isDefined(self.bot)) {
    if(!isbot(self) || !self initialized()) {
      self bot_action::stop();
      self bot_position::stop();
      self bot_stance::stop();
      return;
    }

    tacbundle = self function_d473f7de();

    if(!isDefined(tacbundle)) {
      record3dtext("<dev string:x3b>", self.origin, (1, 0, 0), "<dev string:x46>", self, 0.5);
      waitframe(1);
      continue;
    }

    record3dtext("<dev string:x4f>" + tacbundle.name + "<dev string:x54>", self.origin, (1, 1, 1), "<dev string:x46>", self, 0.5);

    if(isDefined(self get_revive_target())) {
      target = self get_revive_target().origin;
      recordline(self.origin, target, (0, 1, 1), "<dev string:x46>", self);
      recordcircle(target, 32, (0, 1, 1), "<dev string:x46>", self);
    }

    if(self should_record(#"hash_16eb77415dcf6054")) {
      self function_d45e8714();
    }

    self function_ec403901();
    self function_23c46f6e();
    self function_92b0ec6b();

    if(!self isplayinganimscripted() && !self arecontrolsfrozen() && !self function_5972c3cf() && !self isinvehicle() && !self util::isflashed() && isDefined(self.sessionstate) && self.sessionstate == "playing") {
      self bot_action::update();
      self thread bot_position::update(tacbundle);
      self bot_stance::update(tacbundle);
      self update_swim();
    } else {
      self bot_action::reset();
      self bot_position::reset();
      self bot_stance::reset();

      if(self function_dd750ead()) {
        gameobject = self get_interact();

        if(isDefined(gameobject.inuse) && gameobject.inuse && isDefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger) {
          self bottapbutton(3);
        }
      }
    }

    waitframe(1);
  }
}

function_23c46f6e() {
  if(self function_dd750ead()) {
    gameobject = self get_interact();

    if(!isDefined(gameobject.trigger) || !gameobject.trigger istriggerenabled() || !gameobject gameobjects::can_interact_with(self)) {
      self clear_interact();
    } else if(isDefined(gameobject.inuse) && gameobject.inuse && self.claimtrigger !== gameobject.trigger) {
      self clear_interact();
    }

    return;
  }

  if(self function_914feddd()) {
    return;
  }

  if(self function_43a720c7()) {
    return;
  }

  if(self has_interact()) {
    self botprinterror("<dev string:x59>");

    self clear_interact();
  }
}

function_92b0ec6b() {
  if(!has_visible_enemy()) {
    self.bot.var_ea5b64df = isDefined(self.bot.tacbundle.inaccuracy) ? self.bot.tacbundle.inaccuracy : 0;
    self.bot.aimoffset = (0, 0, 0);
    self.bot.var_9492fdcb = (0, 0, 0);
    self.bot.var_67b4ea54 = undefined;
  }

  if(self playerads() < 1) {
    self.bot.var_ddc0e12b = undefined;
    self.bot.var_f2b47a08 = undefined;
  }
}

function_ec403901() {
  if(isDefined(self.revivetrigger)) {
    if(isstring(level.var_258cdebb) && self.bot.tacbundle.name != level.var_258cdebb) {
      self function_678e7c0(level.var_258cdebb);
    }

    return;
  }

  if(isDefined(self.var_81c43c)) {
    self function_678e7c0(self.var_81c43c);
    return;
  }

  self function_acc4267f();
}

function_ffbfd83b() {
  if(isDefined(self.bot.var_2a98e9ea) && self.bot.var_2a98e9ea && !function_ffa5b184(self.enemy)) {
    self.bot.var_2a98e9ea = 0;
    self clearentitytarget();
    return;
  }

  if(!isDefined(self.enemy) || !function_ffa5b184(self.enemy)) {
    return;
  }

  if(self.ignoreall || isDefined(self.enemy.var_becd4d91) && self.enemy.var_becd4d91 || self.enemy ai::function_41b04632()) {
    self clearentitytarget();
    return;
  }

  targetpoint = isDefined(self.enemy.var_88f8feeb) ? self.enemy.var_88f8feeb : self.enemy getcentroid();

  if(!sighttracepassed(self getEye(), targetpoint, 0, self.enemy)) {
    self clearentitytarget();
  }
}

update_swim() {
  if(!self isplayerswimming()) {
    self.bot.resurfacetime = undefined;
    return;
  }

  if(isDefined(self.drownstage) && self.drownstage != 0) {
    self bottapbutton(67);
    return;
  }

  if(self isplayerunderwater()) {
    if(!isDefined(self.bot.resurfacetime)) {
      self.bot.resurfacetime = gettime() + int((self.playerrole.swimtime - 1) * 1000);
    }
  } else {
    if(isDefined(self.bot.resurfacetime) && gettime() - self.bot.resurfacetime < int(2 * 1000)) {
      self bottapbutton(67);
      return;
    }

    self.bot.resurfacetime = undefined;
  }

  if(self botundermanualcontrol()) {
    return;
  }

  goalposition = self.goalpos;

  if(distance2dsquared(goalposition, self.origin) <= 16384 && getwaterheight(goalposition) > 0) {
    self bottapbutton(68);
    return;
  }

  if(isDefined(self.bot.resurfacetime) && self.bot.resurfacetime <= gettime()) {
    self bottapbutton(67);
    return;
  }

  bottomtrace = groundtrace(self.origin, self.origin + (0, 0, -1000), 0, self, 1);
  swimheight = self.origin[2] - bottomtrace[#"position"][2];

  if(swimheight < 25) {
    self bottapbutton(67);
    return;
  }

  if(swimheight > 45) {
    self bottapbutton(68);
  }
}

init_bot() {
  self.bot = spawnStruct();
  ai::createinterfaceforentity(self);
  self function_acc4267f();
  self.bot.var_b2b8f0b6 = 300;
  self.bot.var_e8c941d6 = 470;
  self.bot.var_51cee2ad = 0;
  self.bot.var_af11e334 = 0;
  self.bot.var_bdbba2cd = 0;
  self.bot.var_18fa994c = 0;
  self.bot.var_857c5ea8 = 0;
  blackboard::createblackboardforentity(self);
  self function_eaf7ef38(#"hash_1b029888c4965031", #"hash_41b1340b7efb3261");
}

initialized() {
  return isDefined(self.bot);
}

function_acc4267f() {
  self function_678e7c0(isDefined(level.var_df0a0911) ? level.var_df0a0911 : "bot_tacstate_default");
}

function_678e7c0(bundlename) {
  tacbundle = getscriptbundle(bundlename);

  if(!isDefined(tacbundle)) {
    self botprinterror("<dev string:x7a>" + bundlename);

    return;
  }

  if(self.bot.tacbundle === tacbundle) {
    return;
  }

  maxsightdist = isDefined(tacbundle.maxsightdist) ? tacbundle.maxsightdist : 0;
  self.maxsightdistsqrd = maxsightdist * maxsightdist;
  self.highlyawareradius = isDefined(tacbundle.highlyawareradius) ? tacbundle.highlyawareradius : 0;
  self.fovcosine = fov_angle_to_cosine(tacbundle.fov);
  self.fovcosinebusy = fov_angle_to_cosine(tacbundle.fovbusy);
  self.perfectaim = isDefined(tacbundle.perfectaim) ? tacbundle.perfectaim : 0;
  self.accuracy = isDefined(tacbundle.accuracy) ? tacbundle.accuracy : 0;
  self.pacifist = isDefined(tacbundle.pacifist) ? tacbundle.pacifist : 0;
  self.pacifistwait = isDefined(tacbundle.pacifistwait) ? tacbundle.pacifistwait : 0;
  self botsetlooksensitivity(isDefined(tacbundle.pitchsensitivity) ? tacbundle.pitchsensitivity : 0, isDefined(tacbundle.yawsensitivity) ? tacbundle.yawsensitivity : 0);
  self function_4f0b9564(isDefined(tacbundle.pitchacceleration) ? tacbundle.pitchacceleration : 0, isDefined(tacbundle.yawacceleration) ? tacbundle.yawacceleration : 0);
  self function_a6b577cd(isDefined(tacbundle.var_2b02e26a) ? tacbundle.var_2b02e26a : 0, isDefined(tacbundle.var_69610dbe) ? tacbundle.var_69610dbe : 0);
  self function_400c9c63(isDefined(tacbundle.var_4333f343) ? tacbundle.var_4333f343 : 0, isDefined(tacbundle.var_b392418) ? tacbundle.var_b392418 : 0);
  self.bot.tacbundle = tacbundle;
}

fov_angle_to_cosine(fovangle = 0) {
  if(fovangle >= 180) {
    return 0;
  }

  return cos(fovangle / 2);
}

function_d473f7de() {
  return self.bot.tacbundle;
}

set_interact(interact) {
  self.bot.interact = interact;
}

clear_interact() {
  self.bot.interact = undefined;
}

get_interact() {
  return self.bot.interact;
}

has_interact() {
  return isDefined(self.bot.interact);
}

function_dd750ead() {
  return isDefined(self.bot.interact) && isDefined(self.bot.interact.trigger) && self.bot.interact.triggertype === "use";
}

function_914feddd() {
  return isDefined(self.bot.interact) && isDefined(self.bot.interact.zombie_weapon_upgrade);
}

function_e8a17817() {
  return isDefined(self.bot.interact) && isDefined(self.bot.interact.zombie_cost) && self.bot.interact._door_open !== 1;
}

function_2d99e476() {
  return isDefined(self.bot.interact) && self.bot.interact.objectid === "magicbox_struct" && self.bot.interact.hidden !== 1;
}

function_4e55eb5d() {
  return isDefined(self.bot.interact) && self.bot.interact.targetname === "use_elec_switch";
}

function_ca9fb875() {
  return isDefined(self.bot.interact) && self.bot.interact.script_unitrigger_type === "unitrigger_box_use";
}

function_43a720c7() {
  return function_e8a17817() || function_2d99e476() || function_4e55eb5d() || function_ca9fb875();
}

function_bba89736() {
  if(!self has_interact()) {
    return undefined;
  }

  interact = self get_interact();

  if(self function_dd750ead()) {
    return interact.trigger;
  } else if(self function_914feddd() || self function_43a720c7()) {
    if(isentity(interact)) {
      return interact;
    } else if(isDefined(interact.trigger_stub) && isDefined(interact.trigger_stub.playertrigger)) {
      return interact.trigger_stub.playertrigger[self getentitynumber()];
    } else if(isDefined(interact.unitrigger_stub) && isDefined(interact.unitrigger_stub.playertrigger)) {
      return interact.unitrigger_stub.playertrigger[self getentitynumber()];
    } else if(isDefined(interact.playertrigger)) {
      return interact.playertrigger[self getentitynumber()];
    }
  }

  return undefined;
}

get_revive_target() {
  return self.bot.revivetarget;
}

set_revive_target(target) {
  self.bot.revivetarget = target;
}

clear_revive_target() {
  self set_revive_target(undefined);
}

menu_cancel(menukey) {
  self notify(#"menuresponse", {
    #menu: game.menu[menukey], 
    #response: "cancel", 
    #intpayload: 0
  });
}

has_visible_enemy() {
  if(self in_combat()) {
    return (isalive(self.enemy) && self cansee(self.enemy));
  }

  return false;
}

in_combat() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  switch (self.combatstate) {
    case #"combat_state_aware_of_enemies":
    case #"combat_state_in_combat":
    case #"combat_state_has_visible_enemy":
      return true;
  }

  return false;
}

fwd_dot(point) {
  angles = self getplayerangles();
  fwd = anglesToForward(angles);
  eye = self getEye();
  dir = point - eye;
  dir = vectornormalize(dir);
  dot = vectordot(fwd, dir);
  return dot;
}

function_7aeb27f1(smin, smax) {
  return gettime() + 1000 * randomfloatrange(smin, smax);
}

eye_trace(hitents = 0) {
  direction = self getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = self getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  return bulletTrace(eye, eye + direction_vec, hitents, self);
}

function_343d7ef4() {
  if(!isbot(self)) {
    return false;
  }

  if(self isinvehicle()) {
    vehicle = self getvehicleoccupied();

    if(isDefined(vehicle.goalforced) && vehicle.goalforced || isDefined(vehicle.ignoreall) && vehicle.ignoreall) {
      return false;
    }
  } else if(self.ignoreall) {
    return false;
  }

  return true;
}

function_b5dd2fd2(entity, attribute, oldvalue, value) {}

get_nearest_node(pos, maxradius = 24, minradius = 0, height = 64) {
  nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Scripted");

  if(nodes.size > 0) {
    return nodes[0];
  }

  nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Cover");

  if(nodes.size > 0) {
    return nodes[0];
  }

  nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Path");

  if(nodes.size > 0) {
    return nodes[0];
  }

  return undefined;
}

get_position_node() {
  if(isDefined(self.node)) {
    return self.node;
  } else if(!isDefined(self.overridegoalpos) && isDefined(self.goalnode)) {
    return self.goalnode;
  }

  return undefined;
}

allow_all(allow) {
  self.ignoreall = !allow;
  self ai::set_behavior_attribute("allowprimaryoffhand", allow);
  self ai::set_behavior_attribute("allowsecondaryoffhand", allow);
  self ai::set_behavior_attribute("allowspecialoffhand", allow);
  self ai::set_behavior_attribute("allowscorestreak", allow);

  if(allow) {
    self ai::set_behavior_attribute("control", "commander");
    self clearforcedgoal();
    return;
  }

  self ai::set_behavior_attribute("control", "autonomous");
  self setgoal(self.origin, 1);
}

function_f0c35734(trigger) {
  assert(isbot(self));
  assert(isDefined(trigger));
  radius = self getpathfindingradius();
  height = self function_6a9ae71();
  heightoffset = (0, 0, height * -1 / 2);
  var_e790dc87 = (radius, radius, height / 2);
  obb = ai::function_470c0597(trigger.origin + heightoffset, trigger.maxs + var_e790dc87, trigger.angles);
  return obb;
}

function_52947b70(trigger) {
  assert(isbot(self));
  assert(isstruct(trigger));
  radius = self getpathfindingradius();
  height = self function_6a9ae71();
  heightoffset = (0, 0, height * -1 / 2);
  var_e790dc87 = (radius, radius, height / 2);
  maxs = (trigger.script_width, trigger.script_length, trigger.script_height);
  obb = ai::function_470c0597(trigger.origin + heightoffset, maxs + var_e790dc87, trigger.angles);
  return obb;
}

function_e0aceb0c(tacbundle, dvarstr) {
  healthratio = self.health / self.maxhealth;

  if(healthratio <= tacbundle.lowhealthratio) {
    self record_text("<dev string:xbd>", (1, 0, 0), dvarstr);

    return false;
  }

  if(self isreloading()) {
    self record_text("<dev string:xcc>", (1, 0, 0), dvarstr);

    return false;
  }

  weapon = self getcurrentweapon();

  if(weapon != level.weaponnone && self getweaponammoclip(weapon) <= 0) {
    self record_text("<dev string:xda>", (1, 0, 0), dvarstr);

    return false;
  }

  return true;
}

function_b78e1ebf(lefthand = 0) {
  weapon = self get_current_weapon(lefthand);
  buttonbit = lefthand ? 24 : 0;
  self bottapbutton(buttonbit);

  if(isDefined(level.var_32ae304)) {
    self[[level.var_32ae304]](lefthand);
    return;
  }

  if(weapon function_7f23578e()) {
    var_51cee2ad = gettime() + randomintrange(self.bot.var_b2b8f0b6, self.bot.var_e8c941d6);

    if(lefthand) {
      self.bot.var_af11e334 = var_51cee2ad;
      return;
    }

    self.bot.var_51cee2ad = var_51cee2ad;
  }
}

function_e2c892a5(lefthand = 0) {
  if(function_a7106162(lefthand)) {
    function_b78e1ebf(lefthand);
    return true;
  }

  return false;
}

function_a7106162(lefthand = 0) {
  weapon = get_current_weapon(lefthand);

  if(weapon == level.weaponnone) {
    return 0;
  }

  if(self getweaponammoclip(weapon) <= 0) {
    return 0;
  }

  if(isDefined(level.var_bddfddcf)) {
    return self[[level.var_bddfddcf]](lefthand);
  } else if(weapon function_7f23578e()) {
    if(self isweaponready(lefthand) || self isplayerswimming()) {
      return (gettime() > (lefthand ? self.bot.var_af11e334 : self.bot.var_51cee2ad));
    }

    return 0;
  } else if(weapon function_903ea2a5()) {
    return (self isweaponready(lefthand) || self isplayerswimming());
  }

  return 1;
}

get_current_weapon(lefthand = 0) {
  weapon = self getcurrentweapon();

  if(lefthand) {
    return weapon.dualwieldweapon;
  }

  return weapon;
}

weapon_loaded(weapon) {
  return self getweaponammoclip(weapon) > 0 || self getweaponammoclip(weapon.dualwieldweapon) > 0;
}

function_7f23578e() {
  return self.firetype == "Single Shot";
}

function_903ea2a5() {
  return self.firetype == "Burst";
}

devgui_bot_loop() {
  sessionmode = currentsessionmode();

  if(sessionmode != 4) {
    var_48c9cde3 = getallcharacterbodies(sessionmode);

    foreach(index in var_48c9cde3) {
      if(index == 0) {
        continue;
      }

      displayname = makelocalizedstring(getcharacterdisplayname(index, sessionmode));
      assetname = function_9e72a96(getcharacterassetname(index, sessionmode));
      name = displayname + "<dev string:xe9>" + assetname + "<dev string:xee>";
      cmd = "<dev string:xf2>" + name + "<dev string:x126>" + index + "<dev string:x12a>" + index + "<dev string:x158>";
      adddebugcommand(cmd);
      cmd = "<dev string:x15c>" + name + "<dev string:x126>" + index + "<dev string:x18d>" + index + "<dev string:x158>";
      adddebugcommand(cmd);
    }
  }

  while(true) {
    wait 0.25;
    dvarstr = getdvarstring(#"devgui_bot", "<dev string:x38>");

    if(dvarstr == "<dev string:x38>") {
      continue;
    }

    args = strtok(dvarstr, "<dev string:x1b8>");
    host = util::gethostplayerforbots();

    switch (args[0]) {
      case #"add":
        level devgui_add_bots(host, args[1], int(args[2]));
        break;
      case #"spawn_enemy":
        level devgui_add_bots(host, #"enemy", 1);
        break;
      case #"remove":
        level devgui_remove_bots(host, args[1]);
        break;
      case #"kill":
        level devgui_kill_bots(host, args[1]);
        break;
      case #"invulnerable":
        level devgui_invulnerable(host, args[1], args[2]);
        break;
      case #"ignoreall":
        level devgui_ignoreall(host, args[1], int(args[2]));
        break;
      case #"primaryoffhand":
        level devgui_attribute(host, "<dev string:x1bc>", args[1], int(args[2]));
        break;
      case #"secondaryoffhand":
        level devgui_attribute(host, "<dev string:x1d2>", args[1], int(args[2]));
        break;
      case #"specialoffhand":
        level devgui_attribute(host, "<dev string:x1ea>", args[1], int(args[2]));
        break;
      case #"scorestreak":
        level devgui_attribute(host, "<dev string:x200>", args[1], int(args[2]));
        break;
      case #"usegadget":
        level devgui_use_gadget(host, args[1], int(args[2]));
        break;
      case #"usekillstreak":
        level function_8042b78a(host, args[1]);
        break;
      case #"tpose":
        level devgui_tpose(host, args[1]);
        break;
    }

    if(isDefined(host)) {
      switch (args[0]) {
        case #"add_fixed_spawn":
          host devgui_add_fixed_spawn_bots(args[1], args[2], args[3]);
          break;
        case #"set_target":
          host devgui_set_target(args[1], args[2]);
          break;
        case #"goal":
          host devgui_goal(args[1], args[2]);
          break;
        case #"companion":
          host function_5524bfd5(args[1]);
          break;
        case #"give_player_weapon":
          host function_263ca697();
          break;
      }
    }

    level notify(#"devgui_bot", {
      #host: host, 
      #args: args
    });
    setdvar(#"devgui_bot", "<dev string:x38>");
  }
}

add_bot_devgui_menu() {
  entnum = self getentitynumber();

  if(level.var_fa5cacde && entnum > 12) {
    return;
  }

  i = 0;
  self add_bot_devgui_cmd(entnum, "<dev string:x213>" + i + "<dev string:x21c>", 0, "<dev string:x223>", "<dev string:x22f>");
  self add_bot_devgui_cmd(entnum, "<dev string:x213>" + i + "<dev string:x233>", 1, "<dev string:x223>", "<dev string:x23b>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x23f>" + i + "<dev string:x24d>", 0, "<dev string:x25f>", "<dev string:x26c>");
  self add_bot_devgui_cmd(entnum, "<dev string:x23f>" + i + "<dev string:x278>", 1, "<dev string:x25f>", "<dev string:x285>");
  self add_bot_devgui_cmd(entnum, "<dev string:x23f>" + i + "<dev string:x28a>", 2, "<dev string:x25f>", "<dev string:x293>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x29b>" + i + "<dev string:x24d>", 0, "<dev string:x2a7>", "<dev string:x2ae>");
  self add_bot_devgui_cmd(entnum, "<dev string:x29b>" + i + "<dev string:x2b4>", 1, "<dev string:x2a7>", "<dev string:x285>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x2c1>" + i + "<dev string:x24d>", 0, "<dev string:x2a7>", "<dev string:x2d4>");
  self add_bot_devgui_cmd(entnum, "<dev string:x2c1>" + i + "<dev string:x28a>", 1, "<dev string:x2a7>", "<dev string:x293>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x2dc>" + i + "<dev string:x2ec>", 0, "<dev string:x2f2>", "<dev string:x301>");
  self add_bot_devgui_cmd(entnum, "<dev string:x2dc>" + i + "<dev string:x306>", 1, "<dev string:x2f2>", "<dev string:x30d>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x313>" + i + "<dev string:x321>", 0, "<dev string:x32c>", "<dev string:x22f>");
  self add_bot_devgui_cmd(entnum, "<dev string:x313>" + i + "<dev string:x338>", 1, "<dev string:x32c>", "<dev string:x23b>");
  self add_bot_devgui_cmd(entnum, "<dev string:x313>" + i + "<dev string:x345>", 2, "<dev string:x32c>", "<dev string:x350>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x354>", i, "<dev string:x365>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x375>", i, "<dev string:x37e>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x386>", i, "<dev string:x38d>");
  i++;
  self add_bot_devgui_cmd(entnum, "<dev string:x394>", i, "<dev string:x39d>");
  i++;
}

add_bot_devgui_cmd(entnum, path, sortkey, devguiarg, cmdargs) {
  if(!isDefined(cmdargs)) {
    cmdargs = "<dev string:x38>";
  }

  cmd = "<dev string:x3a6>" + entnum + "<dev string:x1b8>" + self.name + "<dev string:x126>" + entnum + "<dev string:x3ba>" + path + "<dev string:x126>" + sortkey + "<dev string:x3be>" + devguiarg + "<dev string:x1b8>" + entnum + "<dev string:x1b8>" + cmdargs + "<dev string:x158>";
  util::add_debug_command(cmd);
}

clear_bot_devgui_menu() {
  entnum = self getentitynumber();

  if(level.var_fa5cacde && entnum > 12) {
    return;
  }

  cmd = "<dev string:x3d3>" + entnum + "<dev string:x1b8>" + self.name + "<dev string:x158>";
  util::add_debug_command(cmd);
}

devgui_add_bots(host, botarg, count) {
  team = devgui_relative_team(host, botarg);
  level thread add_bots(count, team);
}

function_2d5436be(origin, spiral) {
  spacing = getdvarint(#"hash_6053b2f7b8096ff5", 75);
  a = getdvarint(#"hash_451261221fa2d2d7", 14);
  b = getdvarint(#"hash_451262221fa2d48a", 35);
  c = getdvarfloat(#"hash_451263221fa2d63d", 1);
  min = getdvarfloat(#"hash_6eab9c95ab563fcb", 50);
  radius = max(spiral.radius, min);
  degrees = spacing * 360 / 6.28319 * radius;
  spiral.angle += degrees;
  spiral.radius = math::function_b1820790(a, b, c, spiral.angle);
  var_17e94d83 = rotatepointaroundaxis((spiral.radius, 0, 0), (0, 0, 1), spiral.angle + spiral.var_2b9d3922);
  spawn_point = var_17e94d83 + origin;
  trace = bulletTrace(spawn_point + (0, 0, 100), spawn_point, 0, self);
  return trace[#"position"];
}

devgui_add_fixed_spawn_bots(botarg, var_b27e53da, countarg) {
  team = devgui_relative_team(self, botarg);
  trace = self eye_trace();
  spawndir = self.origin - trace[#"position"];
  spawnangles = vectortoangles(spawndir);

  if(!isDefined(countarg)) {
    countarg = 1;
  }

  count = max(int(countarg), 1);
  bots = [];
  offset = (0, 0, 5);
  origin = trace[#"position"] + offset;

  if(!isDefined(bots)) {
    bots = [];
  } else if(!isarray(bots)) {
    bots = array(bots);
  }

  bots[bots.size] = self add_fixed_spawn_bot(team, origin, spawnangles[1], var_b27e53da);
  spiral = {
    #var_2b9d3922: spawnangles[1], 
    #angle: 0, 
    #radius: 100
  };
  spiral.angle = getdvarint(#"hash_6d616a1ec2c5b8f0", 0);
  spiral.radius = getdvarint(#"hash_64cb6c7e56b66cab", 0);

  for(i = 0; i < count - 1; i++) {
    origin = function_2d5436be(trace[#"position"] + offset, spiral);

    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = self add_fixed_spawn_bot(team, origin, spiral.angle + spiral.var_2b9d3922, var_b27e53da);
  }

  if(isvehicle(trace[#"entity"])) {
    foreach(bot in bots) {
      if(isDefined(bot)) {
        vehicle = trace[#"entity"];
        pos = trace[#"position"];
        seatindex = undefined;
        seatdist = undefined;

        for(i = 0; i < 11; i++) {
          if(vehicle function_dcef0ba1(i)) {
            var_3693c73b = vehicle function_defc91b2(i);

            if(isDefined(var_3693c73b) && var_3693c73b >= 0 && !vehicle isvehicleseatoccupied(i)) {
              dist = distance(pos, vehicle function_5051cc0c(i));

              if(!isDefined(seatindex) || seatdist > dist) {
                seatindex = i;
                seatdist = dist;
              }
            }
          }
        }

        bot thread function_7dc6049e(vehicle, seatindex);
      }
    }
  }
}

devgui_relative_team(host, botarg) {
  if(isDefined(host)) {
    team = host.team != #"spectator" ? host.team : #"allies";

    if(botarg == "enemy") {
      team = team == #"allies" ? #"axis" : #"allies";
    }

    return team;
  }

  if(botarg == "friendly") {
    return #"allies";
  }

  return #"axis";
}

devgui_remove_bots(host, botarg) {
  level notify(#"hash_d3e36871aa6829f");
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    level thread remove_bot(bot);
  }
}

devgui_ignoreall(host, botarg, cmdarg) {
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    bot allow_all(cmdarg);
  }
}

devgui_attribute(host, attribute, botarg, cmdarg) {
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    foreach(bot in bots) {
      bot ai::set_behavior_attribute(attribute, cmdarg);
    }
  }
}

devgui_use_gadget(host, botarg, cmdarg) {
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    bot bot_action::function_ee2eaccc(cmdarg);
  }
}

function_8042b78a(host, botarg) {
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    bot bot_action::function_4a53ae1f();
  }
}

devgui_tpose(host, botarg) {
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    setdvar(#"bg_boastenabled", 1);
    bot playboast("dev_boast_tpose");
  }
}

devgui_kill_bots(host, botarg) {
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    if(!isalive(bot)) {
      continue;
    }

    bot val::set(#"devgui_kill", "takedamage", 1);
    bot dodamage(bot.health + 1000, bot.origin);
    bot val::reset(#"devgui_kill", "takedamage");
  }
}

devgui_invulnerable(host, botarg, cmdarg) {
  bots = devgui_get_bots(host, botarg);

  foreach(bot in bots) {
    if(cmdarg == "on") {
      bot val::set(#"devgui", "takedamage", 0);
      continue;
    }

    bot val::reset(#"devgui", "takedamage");
  }
}

devgui_set_target(botarg, cmdarg) {
  target = undefined;

  switch (cmdarg) {
    case #"crosshair":
      target = self function_7090aa98();
      break;
    case #"me":
      target = self;
      break;
    case #"clear":
      break;
    default:
      return;
  }

  bots = devgui_get_bots(self, botarg);

  foreach(bot in bots) {
    if(isDefined(target)) {
      if(target != bot) {
        bot setentitytarget(target);
      }

      continue;
    }

    bot clearentitytarget();
  }
}

devgui_goal(botarg, cmdarg) {
  switch (cmdarg) {
    case #"set":
      self function_bbc3f17e(botarg, 0);
      return;
    case #"me":
      self devgui_goal_me(botarg);
      return;
    case #"force":
      self function_bbc3f17e(botarg, 1);
      return;
    case #"clear":
      self devgui_goal_clear(botarg);
      return;
  }
}

function_bbc3f17e(botarg, force = 0) {
  trace = self eye_trace(1);
  bots = devgui_get_bots(self, botarg);
  pos = trace[#"position"];
  node = self get_nearest_node(pos);

  if(isDefined(node)) {
    pos = node;
  }

  foreach(bot in bots) {
    bot ai::set_behavior_attribute("control", "autonomous");
    bot setgoal(pos, force);
  }
}

devgui_goal_clear(botarg) {
  bots = devgui_get_bots(self, botarg);

  foreach(bot in bots) {
    bot ai::set_behavior_attribute("control", "commander");
    bot clearforcedgoal();
  }
}

devgui_goal_me(botarg) {
  bots = devgui_get_bots(self, botarg);

  foreach(bot in bots) {
    bot ai::set_behavior_attribute("control", "autonomous");
    bot setgoal(self);
  }
}

devgui_get_bots(host, botarg) {
  if(strisnumber(botarg)) {
    bots = [];
    bot = get_bot_by_entity_number(int(botarg));

    if(isDefined(bot)) {
      bots[0] = bot;
    }

    return bots;
  }

  if(isDefined(host)) {
    if(botarg == "friendly") {
      return host get_friendly_bots();
    }

    if(botarg == "enemy") {
      return host get_enemy_bots();
    }
  } else if(level.teambased) {
    if(botarg == "friendly") {
      return function_a0f5b7f5(#"allies");
    }

    return function_a0f5b7f5(#"axis");
  }

  return get_bots();
}

function_7090aa98() {
  targetentity = undefined;
  targetdot = undefined;
  players = getplayers();

  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }

    dot = self fwd_dot(player.origin);

    if(dot < 0.997) {
      continue;
    }

    if(!self cansee(player)) {
      continue;
    }

    if(!isDefined(targetentity) || dot > targetdot) {
      targetentity = player;
      targetdot = dot;
    }
  }

  if(!isDefined(targetentity)) {
    trace = self eye_trace(1);
    targetentity = trace[#"entity"];
  }

  if(isDefined(targetentity) && !isalive(targetentity)) {
    return undefined;
  }

  return targetentity;
}

function_5524bfd5(companionname) {
  setdvar(#"companion", companionname);
}

function_263ca697() {
  weapon = self getcurrentweapon();
  setdvar(#"bot_spawn_weapon", getweaponname(weapon.rootweapon));
  setdvar(#"hash_c6e51858c88a5ee", util::function_2146bd83(weapon));
  bots = get_bots();

  foreach(bot in bots) {
    bot function_35e77034(weapon);
  }
}

function_35e77034(weapon) {
  if(!isDefined(weapon) || weapon == level.weaponnone) {
    return;
  }

  self function_85e7342b();
  self giveweapon(weapon);
  self givemaxammo(weapon);
  self switchtoweaponimmediate(weapon);
  self setspawnweapon(weapon);
}

function_85e7342b() {
  weapons = self getweaponslistprimaries();

  foreach(weapon in weapons) {
    self takeweapon(weapon);
  }
}

should_record(dvarstr) {
  if(getdvarint(dvarstr, 0) <= 0) {
    return 0;
  }

  if(self == level) {
    return 1;
  }

  botnum = getdvarint(#"hash_457b3d0b71e0fd8a", 0);

  if(botnum < 0) {
    return 1;
  }

  ent = getentbynum(botnum);
  return isDefined(ent) && ent == self;
}

record_text(text, textcolor, dvarstr) {
  if(self should_record(dvarstr)) {
    record3dtext(text, self.origin, textcolor, "<dev string:x46>", self, 0.5);
  }
}

function_d45e8714() {
  if(!self has_interact()) {
    return;
  }

  interact = self get_interact();
  var_dda174e9 = self function_bba89736();
  origin = interact.origin;
  desc = "<dev string:x3ea>";

  if(self function_dd750ead()) {
    desc = "<dev string:x3fd>";
  } else if(self function_914feddd()) {
    desc = "<dev string:x40a>";
  } else if(self function_e8a17817()) {
    desc = "<dev string:x423>";
  } else if(self function_ca9fb875()) {
    desc = "<dev string:x435>";
  }

  if(isDefined(var_dda174e9)) {
    self function_1744d303(var_dda174e9, (0, 1, 0), "<dev string:x46>");
  }

  if(!isvec(origin)) {
    if(isDefined(var_dda174e9)) {
      origin = var_dda174e9.origin;
    } else {
      origin = self.origin;
    }
  }

  recordline(self.origin, origin, (0, 1, 0), "<dev string:x46>", self);
  recordsphere(origin, 8, (0, 1, 0), "<dev string:x46>", self);
  record3dtext(desc, origin, (1, 1, 1), "<dev string:x46>", undefined, 0.5);
}

function_1744d303(trigger, color, channel) {
  maxs = trigger getmaxs();
  mins = trigger getmins();

  if(issubstr(trigger.classname, "<dev string:x44a>")) {
    radius = max(maxs[0], maxs[1]);
    top = trigger.origin + (0, 0, maxs[2]);
    bottom = trigger.origin + (0, 0, mins[2]);
    recordcircle(bottom, radius, color, channel, self);
    recordcircle(top, radius, color, channel, self);
    recordline(bottom, top, color, channel, self);
    return;
  }

  recordbox(trigger.origin, mins, maxs, trigger.angles[0], color, channel, self);
}

bot_joinleave_loop() {
  active = 0;

  while(true) {
    wait 1;
    joinleavecount = getdvarint(#"debug_bot_joinleave", 0);

    if(!joinleavecount) {
      if(active) {
        active = 0;
        remove_bots();
      }

      continue;
    }

    if(!active) {
      adddebugcommand("<dev string:x453>");
      active = 1;
    }

    botcount = bot_count();

    if(botcount > 0 && randomint(100) < 30) {
      remove_random_bot();
      wait 2;
    } else if(botcount < joinleavecount) {
      add_bot();
      wait 2;
    }

    wait randomintrange(1, 3);
  }
}

function_301f229d(team) {
  var_9e7013f = [];
  var_52e61055 = [];
  players = getplayers(team);

  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }

    if(isDefined(player.revivetrigger)) {
      if(!(isDefined(player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived)) {
        var_9e7013f[var_9e7013f.size] = player;
      }

      continue;
    }

    if(isbot(player)) {
      if(!(isDefined(player.is_reviving_any) && player.is_reviving_any) && player ai::get_behavior_attribute("revive")) {
        var_52e61055[var_52e61055.size] = player;
      }
    }
  }

  assignments = [];

  foreach(bot in var_52e61055) {
    radius = bot getpathfindingradius();

    foreach(player in var_9e7013f) {
      distance = undefined;
      navmeshpoint = getclosestpointonnavmesh(player.origin, 64, radius);

      if(!isDefined(navmeshpoint)) {
        continue;
      }

      if(tracepassedonnavmesh(bot.origin, navmeshpoint, 15)) {
        distance = distance2d(bot.origin, navmeshpoint);
      } else {
        var_65c8979b = getclosestpointonnavmesh(bot.origin, 64, radius);

        if(!isDefined(var_65c8979b)) {
          continue;
        }

        path = generatenavmeshpath(var_65c8979b, navmeshpoint, bot);

        if(!isDefined(path) || !isDefined(path.pathpoints) || path.pathpoints.size == 0) {
          continue;
        }

        distance = path.pathdistance;
      }

      if(distance > 2000) {
        continue;
      }

      for(i = 0; i < assignments.size; i++) {
        if(distance < assignments[i].distance) {
          break;
        }
      }

      arrayinsert(assignments, {
        #bot: bot, 
        #target: player, 
        #distance: distance
      }, i);
    }
  }

  for(i = 0; i < assignments.size; i++) {
    assignment = assignments[i];

    if(assignment.bot get_revive_target() !== assignment.target) {
      assignment.bot set_revive_target(assignment.target);
      assignment.bot bot_position::reset();
    }

    arrayremovevalue(var_52e61055, assignment.bot);

    for(j = i + 1; j < assignments.size; j++) {
      var_ecf75b21 = assignments[j];

      if(var_ecf75b21.bot == assignment.bot || var_ecf75b21.target == assignment.target) {
        arrayremoveindex(assignments, j);
        continue;
      }
    }
  }

  foreach(bot in var_52e61055) {
    if(isDefined(bot get_revive_target())) {
      bot clear_revive_target();
      bot bot_position::reset();
    }
  }
}

populate_bots() {
  level endon(#"game_ended", #"hash_d3e36871aa6829f");
  botfill = getdvarint(#"botfill", 0);

  if(botfill > 0) {
    for(i = 0; i < botfill; i++) {
      bot = add_bot();

      if(!isDefined(bot)) {
        return;
      }

      wait 0.5;
    }

    return;
  }

  if(level.teambased) {
    maxallies = getdvarint(#"bot_maxallies", 0);
    maxaxis = getdvarint(#"bot_maxaxis", 0);
    level thread monitor_bot_team_population(maxallies, maxaxis);
    return;
  }

  maxfree = getdvarint(#"bot_maxfree", 0);
  level thread monitor_bot_population(maxfree);
}

monitor_bot_team_population(maxallies, maxaxis) {
  level endon(#"game_ended", #"hash_d3e36871aa6829f");

  if(!maxallies && !maxaxis) {
    return;
  }

  fill_balanced_teams(maxallies, maxaxis);

  while(true) {
    wait 3;
    allies = getplayers(#"allies");
    axis = getplayers(#"axis");

    if(allies.size > maxallies && remove_best_bot(allies)) {
      continue;
    }

    if(axis.size > maxaxis && remove_best_bot(axis)) {
      continue;
    }

    if(allies.size < maxallies || axis.size < maxaxis) {
      add_balanced_bot(allies, maxallies, axis, maxaxis);
    }
  }
}

fill_balanced_teams(maxallies, maxaxis) {
  allies = getplayers(#"allies");

  for(axis = getplayers(#"axis");
    (allies.size < maxallies || axis.size < maxaxis) && add_balanced_bot(allies, maxallies, axis, maxaxis); axis = getplayers(#"axis")) {
    waitframe(1);
    allies = getplayers(#"allies");
  }
}

monitor_bot_population(maxfree) {
  level endon(#"game_ended", #"hash_d3e36871aa6829f");

  if(!maxfree) {
    return;
  }

  for(players = getplayers(); players.size < maxfree; players = getplayers()) {
    add_bot();
    waitframe(1);
  }

  while(true) {
    wait 3;
    players = getplayers();

    if(players.size < maxfree) {
      add_bot();
      continue;
    }

    if(players.size > maxfree) {
      remove_best_bot(players);
    }
  }
}

remove_best_bot(players) {
  bots = filter_bots(players);

  if(!bots.size) {
    return false;
  }

  bestbots = [];

  foreach(bot in bots) {
    if(bot.sessionstate == "spectator") {
      continue;
    }

    if(bot.sessionstate == "dead") {
      bestbots[bestbots.size] = bot;
    }
  }

  if(bestbots.size) {
    remove_bot(bestbots[randomint(bestbots.size)]);
  } else {
    remove_bot(bots[randomint(bots.size)]);
  }

  return true;
}