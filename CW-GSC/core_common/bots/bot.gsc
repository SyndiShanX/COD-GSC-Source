/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\bots\bot.gsc
***********************************************/

#using script_34e162235fb08844;
#using script_3d703ef87a841fe4;
#using script_4e44ad88a2b0f559;
#using script_5e6a760c6f43dd12;
#using script_74453936abc39adf;
#using script_79b47c663155f8bd;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_difficulty;
#using scripts\core_common\bots\bot_orders;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\bots\bot_stance;
#using scripts\core_common\bots\bot_traversals;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\map;
#using scripts\core_common\player\player_role;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace bot;

function private autoexec __init__system__() {
  system::register(#"bot", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::is_frontend_map()) {
    return;
  }

  if(currentsessionmode() == 4 || currentsessionmode() == 2) {
    return;
  }

  level.var_fa5cacde = getgametypesetting(#"hash_77b7734750cd75e9") || is_true(level.var_fa5cacde);

  if(getdvarint(#"hash_7140b31f7170f18b", 0)) {
    setDvar(#"scr_player_ammo", "<dev string:x38>");
  }

  if(is_true(level.var_fa5cacde)) {
    namespace_ffbf548b::preinit();
    callback::on_spawned(&function_abe38e0f);
    callback::on_player_killed(&function_96dddf6f);
    return;
  }

  namespace_87549638::preinit();
  bot_action::preinit();
  bot_difficulty::preinit();
  namespace_38ee089b::preinit();
  bot_orders::preinit();
  namespace_ffbf548b::preinit();
  bot_position::preinit();
  bot_stance::preinit();
  namespace_255a2b21::preinit();
  bot_traversals::preinit();
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_player_killed);
  callback::add_callback(#"hash_6efb8cec1ca372dc", &function_7291a729);
  callback::add_callback(#"hash_6280ac8ed281ce3c", &function_99a2ecf5);
  callback::add_callback(#"hash_730d00ef91d71acf", &function_8481733a);
  level.var_38c34301 = 500 / function_60d95f53();
}

function is_bot_ranked_match() {
  return false;
}

function add_bot(team, name = undefined, clanabbrev = undefined) {
  bot = addtestclient(name, clanabbrev);

  if(!isDefined(bot)) {
    return undefined;
  }

  bot init_bot();

  if(is_true(level.disableclassselection)) {
    bot.pers[# "class"] = level.defaultclass;
    bot.curclass = level.defaultclass;
  }

  if(level.teambased && isDefined(team) && isDefined(level.teams[team])) {
    bot.botteam = team;
  } else if(isDefined(team) && team == # "spectator") {
    bot.botteam = # "spectator";
  } else {
    bot.botteam = "autoassign";
  }

  return bot;
}

function add_bots(count = 1, team) {
  level endon(#"game_ended", #"remove_bot");

  for(i = 0; i < count; i++) {
    bot = add_bot(team);

    if(!isDefined(bot)) {
      return;
    }

    waitframe(1);
  }
}

function remove_bots(team) {
  bots = function_b16926ea(team);

  foreach(bot in bots) {
    remove_bot(bot);
  }
}

function remove_random_bot() {
  bots = function_b16926ea();

  if(bots.size) {
    bot = bots[randomint(bots.size)];
    remove_bot(bot);
  }
}

function remove_bot(bot) {
  if(!isbot(bot) || isautocontrolledplayer(bot)) {
    return;
  }

  level notify(#"remove_bot");
  bot botdropclient();
}

function private function_abe38e0f() {
  if(!isbot(self)) {
    return;
  }

  self thread fixed_spawn_override();
  waitframe(1);
  self bottakemanualcontrol();
}

function private function_96dddf6f(params) {
  if(!isbot(self)) {
    return;
  }

  self thread respawn();
}

function private on_player_connect() {
  if(!isbot(self)) {
    return;
  }

  self endon(#"disconnect");

  if(!isDefined(self.bot)) {
    self init_bot();
    self bot_difficulty::assign();
  }

  if(isDefined(self.var_29b433bd) && player_role::is_valid(self.var_29b433bd)) {
    player_role::set(self.var_29b433bd);
    self.var_29b433bd = undefined;
  } else if(isDefined(self.pers[# "characterindex"])) {
    self player_role::set(self.pers[# "characterindex"]);
  }

  if(!getdvarint(#"hash_1f80dbba75375e3d", 0)) {
    customloadoutindex = self.pers[# "loadoutindex"];

    if(isDefined(customloadoutindex)) {
      self[[level.curclass]]("custom" + customloadoutindex);
    }
  }
}

function private on_player_spawned() {
  if(!isbot(self)) {
    return;
  }

  self setgoal(self.origin);
  self forceupdategoalpos();
  self botreleasemanualcontrol();
  self thread function_b781f1e5();
  self thread fixed_spawn_override();

  if(is_true(self.bot.var_261b9ab3)) {
    waitframe(1);
    self bottakemanualcontrol();
  }
}

function private on_player_killed(params) {
  if(!isbot(self)) {
    return;
  }

  self thread respawn();
}

function private respawn() {
  level endon(#"game_ended");
  self endon(#"disconnect", #"spawned", #"bot_shutdown");
  self waittilltimeout(3, #"death_delay_finished");
  wait 0.1;

  if(is_true(getgametypesetting(#"hash_2b1f40bc711c41f3"))) {
    self thread squad_spawn(0.1);
    return;
  }

  while(true) {
    self bottapbutton(3);
    wait 0.1;
  }
}

function private squad_spawn(respawninterval) {
  level endon(#"game_ended");
  self endon(#"death", #"disconnect", #"spawned");

  while(!isDefined(self.spawn.var_e8f87696) || self.spawn.var_e8f87696 <= 0) {
    wait respawninterval;
  }

  aliveplayers = function_a1cff525(self.squad);
  var_f2cc505e = [];

  foreach(player in aliveplayers) {
    if(!isDefined(player.var_83de62a2) || player.var_83de62a2 != 0) {
      continue;
    }

    var_f2cc505e[var_f2cc505e.size] = player;
  }

  if(var_f2cc505e.size > 0) {
    targetplayer = var_f2cc505e[randomint(var_f2cc505e.size)];
    self.spawn.var_e8f87696 = 0;
    self.spawn.response = "spawnOnPlayer";
    self.var_d690fc0b = targetplayer;
    return;
  }

  self.spawn.var_e8f87696 = 0;
  self.spawn.response = "autoSpawn";
}

function private function_7291a729() {
  force = getdvarint(#"hash_5c4685215b35dda2", 0);
  self setgoal(self.origin, force);
  self forceupdategoalpos();
  self init_bot();
  self bot_difficulty::assign();
  self thread function_b781f1e5();
}

function private function_99a2ecf5() {
  self notify(#"bot_shutdown");
  self.bot = undefined;
}

function private function_8481733a() {
  if(!isDefined(self.bot.difficulty) || is_true(self.bot.difficulty.var_ea800f8)) {
    self function_3ca49c4e(0.8);
    return;
  }

  self function_3ca49c4e(0.1);
}

function private function_b781f1e5() {
  self endoncallback(&function_de8f0d0e, #"death", #"bot_shutdown");
  level endon(#"game_ended");
  self thread function_ef59c9e();
  self thread bot_position::startup();

  while(game.state != # "playing") {
    waitframe(1);
  }

  while(true) {
    pixbeginevent(#"");

    self function_ef4e01f();
    self function_cf9ffac7();
    self function_f76a8ac4();
    self function_4c0124cd();

    self function_a9fd7b4b();
    self function_4fb21bb4();
    self function_7d5bb412();
    self function_47281162();
    self function_ca477c1f();
    self function_1f098eb();
    self.bot.tpoint = getclosesttacpoint(self.origin);
    self function_66749735();
    self function_1b14ddcf();
    self bot_orders::think();
    self namespace_87549638::think();
    self bot_action::think();
    self bot_stance::think();
    self bot_position::think();
    self namespace_94e44221::update();
    self.bot.lastenemy = self.enemy;
    self check_stuck();
    self function_e4055765();
    pixendevent();
    waitframe(1);
  }
}

function private function_de8f0d0e(notifyhash) {
  self.bot.lastenemy = undefined;
  self.bot.var_b73d5099 = undefined;
  self.bot.var_538135ed = undefined;
  self.bot.var_9d03fb75 = undefined;
  self.bot.var_fad934a1 = undefined;
  self.bot.var_36df6398 = undefined;
  self function_f9a34a68();
  self bot_action::shutdown();
  self bot_orders::shutdown();
  self bot_position::shutdown();
}

function private function_a9fd7b4b() {
  self.bot.flashed = self getplayerresistance(1) <= 0 && isDefined(self.flashendtime) && self.flashendtime + 1500 > gettime();
}

function private function_4fb21bb4() {
  if(isDefined(self.enemy) && self.bot.lastenemy !== self.enemy) {
    self.bot.var_b73d5099 = undefined;
  }

  pixbeginevent(#"");

  if(self.combatstate == # "combat_state_idle" || !isDefined(self.enemy) || !isalive(self.enemy) || self.bot.flashed || self function_ce3dfcfc(self.enemy)) {
    self.bot.enemyvisible = 0;
    self.bot.enemyseen = 0;
  } else if(isPlayer(self.enemy) && self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
    vehicle = self.enemy getvehicleoccupied();
    visible = self cansee(vehicle, 250);
    self.bot.enemyvisible = visible;
    self.bot.enemyseen = visible;
  } else if(isPlayer(self.enemy) && isDefined(self.enemy.prop)) {
    prop = self.enemy.prop;
    visible = self cansee(prop, 250);
    self.bot.enemyvisible = visible;

    if(visible) {
      self.bot.var_b73d5099 = gettime() + 4500;
      self.bot.enemyseen = 1;
    } else {
      var_ae19a93d = self.bot.var_b73d5099;
      self.bot.enemyseen = isDefined(var_ae19a93d) && gettime() < var_ae19a93d;
    }

    self.bot.enemyseen = visible || self cansee(prop, 4500);
  } else if(self cansee(self.enemy, 250)) {
    self.bot.enemyvisible = 1;
    self.bot.enemyseen = 1;
  } else if(isDefined(self.enemylastseentime)) {
    self.bot.enemyvisible = 0;
    self.bot.enemyseen = self.enemylastseentime + 4500 >= gettime();
  } else {
    self.bot.enemyvisible = 0;
    self.bot.enemyseen = 0;
  }

  if(!self.bot.enemyseen || self.bot.enemyvisible || !isDefined(self.enemylastseenpos)) {
    self.bot.var_a0b6205e = undefined;
  } else if(self.bot.enemyseen) {
    if(!isDefined(self.bot.var_a0b6205e) || isDefined(self.enemy) && self.bot.lastenemy !== self.enemy) {
      var_32bdb70 = self.origin - self.enemylastseenpos;
      normal = vectornormalize((var_32bdb70[0], var_32bdb70[1], 0));
      self.bot.var_a0b6205e = normal;
    }
  }

  if(self should_record(#"hash_44dd65804e74042e") && isDefined(self.bot.var_a0b6205e)) {
    recordbox(self.enemylastseenpos, (0, -96, -64), (0, 96, 64), vectortoangles(self.bot.var_a0b6205e)[1], (1, 1, 0), "<dev string:x3d>", self);
    recordcircle(self.enemylastseenpos + (0, 0, -64), 96, (1, 1, 0), "<dev string:x3d>", self);
  }

  pixendevent();
}

function private function_ce3dfcfc(enemy) {
  if(!isDefined(enemy.targetname)) {
    return false;
  }

  if(enemy.targetname != "uav" && enemy.targetname != "counteruav" && enemy.targetname != "recon_plane" && enemy.targetname != "chopper_gunner" && enemy.targetname != "ac130" && enemy.targetname != "hoverjet") {
    return false;
  }

  if(is_true(enemy.leaving)) {
    return true;
  }

  if(isDefined(enemy.incoming_missile) && enemy.incoming_missile > 1) {
    return true;
  }

  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    if(weapon.lockontype == # "legacy single" && self getammocount(weapon) > 0) {
      return false;
    }
  }

  return true;
}

function private function_7d5bb412() {
  if(self.bot.enemyvisible) {
    self.bot.enemydist = distance(self.origin, self.enemy.origin);
    return;
  }

  if(self.bot.enemyseen) {
    self.bot.enemydist = distance(self.origin, self.enemylastseenpos);
    return;
  }

  self.bot.enemydist = 1000;
}

function private function_47281162() {
  if(!isDefined(self.enemy)) {
    self.bot.var_e9ff4b76 = 0;
    return;
  }

  dir = self.enemy.origin - self.origin;
  enemyfwd = anglesToForward(self.enemy.angles);
  self.bot.var_e9ff4b76 = vectordot(enemyfwd, dir) > 0;
}

function private function_ca477c1f() {
  if(!isDefined(self.enemy) || !issentient(self.enemy)) {
    self.bot.var_faa25d47 = 0;
    return;
  }

  self.bot.var_faa25d47 = self attackedrecently(self.enemy, 10) || self.enemy attackedrecently(self, 10);
}

function private function_1f098eb() {
  if(self.bot.enemyseen) {
    self.bot.var_494658cd = getclosesttacpoint(self.enemy.origin);
    return;
  }

  self.bot.var_494658cd = undefined;
}

function private function_66749735() {
  pixbeginevent(#"");

  if(!isDefined(level.var_934fb97)) {
    pixendevent();
    return;
  }

  if(self.bot.enemyseen || self.bot.flashed || self function_e8e1d88e() > 0) {
    self.bot.var_538135ed = undefined;
    pixendevent();
    return;
  }

  if(!(!isDefined(self.bot.var_fad934a1) || self.bot.var_fad934a1 <= gettime()) && (!isDefined(self.bot.var_9d03fb75) || self.bot.var_9d03fb75 <= gettime())) {
    self.bot.var_538135ed = undefined;
    pixendevent();
    return;
  }

  var_23d5b7a6 = self.bot.var_538135ed;

  if(isDefined(var_23d5b7a6) && isDefined(var_23d5b7a6.gameobject) && !is_true(var_23d5b7a6.var_8d834202) && distance2dsquared(self.origin, var_23d5b7a6.origin) <= 600 * 600) {
    if(!isDefined(var_23d5b7a6.gameobject.canuseobject) || var_23d5b7a6.gameobject[[var_23d5b7a6.gameobject.canuseobject]](self)) {
      pixendevent();
      return;
    }
  }

  tpoint = self.bot.tpoint;

  if(!isDefined(tpoint)) {
    self.bot.var_538135ed = undefined;
    pixendevent();
    return;
  }

  pods = [];
  ents = getentitiesinradius(self.origin, 600, 6);
  weapon = level.var_934fb97.weapon;

  foreach(ent in ents) {
    if(!isDefined(ent.item) || !isDefined(ent.team) || ent.item != weapon || is_true(ent.var_9863caa6) || !isDefined(ent.gameobject)) {
      continue;
    }

    if(ent.team != self.team && distance2dsquared(self.origin, ent.origin) > 120 * 120) {
      continue;
    }

    if(!ent.gameobject gameobjects::can_interact_with(self)) {
      continue;
    }

    if(isDefined(ent.gameobject.canuseobject) && !ent.gameobject[[ent.gameobject.canuseobject]](self)) {
      continue;
    }

    pods[pods.size] = ent;
  }

  if(pods.size <= 0) {
    self.bot.var_538135ed = undefined;
    pixendevent();
    return;
  }

  self.bot.var_538135ed = pods[randomint(pods.size)];
  pixendevent();
}

function private function_1b14ddcf() {
  if(!isDefined(level.dogtags)) {
    return;
  }

  var_ab80d451 = self getentitiesinrange(level.dogtags, 500, self.origin);

  if(var_ab80d451.size <= 0) {
    self.bot.var_36df6398 = undefined;
    return;
  }

  var_2a981f95 = arraysortclosest(var_ab80d451, self.origin);

  foreach(tag in var_2a981f95) {
    if(isDefined(tag.interactteam) && tag gameobjects::can_interact_with(self)) {
      self.bot.var_36df6398 = tag;
      return;
    }
  }

  self.bot.var_36df6398 = undefined;
}

function private function_f9a34a68() {
  self.bot.var_4208fe0e = undefined;
  self.bot.var_fc10153f = undefined;
  self.bot.var_ad331541 = undefined;
  self.bot.var_510b1057 = undefined;
}

function private check_stuck() {
  pixbeginevent(#"");
  movedir = self move_dir();

  if(length2dsquared(movedir) <= 0 || self status_effect::function_4617032e(2)) {
    self function_f9a34a68();
    pixendevent();
    return;
  }

  if(!isDefined(self.bot.var_383e17de)) {
    self.bot.var_383e17de = [];
  }

  history = self.bot.var_383e17de;
  history[history.size] = self.origin;

  if(history.size < level.var_38c34301) {
    pixendevent();
    return;
  } else if(history.size > level.var_38c34301) {
    arrayremoveindex(history, 0);
  }

  var_ed68443 = 0;

  foreach(point in history) {
    distsq = distancesquared(self.origin, point);

    if(distsq > var_ed68443) {
      var_ed68443 = distsq;
    }
  }

  if(var_ed68443 > 5 * 5) {
    pixendevent();
    return;
  }

  self notify(#"bot_stuck");

  record3dtext(function_9e72a96(#"stuck"), self.origin, (1, 0, 1), "<dev string:x3d>", undefined, 5);
  recordbox(self.origin, self getmaxs(), self getmins(), self.angles[1], (1, 0, 1), "<dev string:x3d>");
  recordbox(self.origin, (64, 64, 0), (64 * -1, 64 * -1, 0), 0, (1, 0, 1), "<dev string:x3d>");
  recordline(self.origin, self.origin + movedir * 128, (1, 0, 1), "<dev string:x3d>");

  foreach(point in history) {
    recordstar(point, (1, 0, 1), "<dev string:x3d>", self);
  }

  ents = getentitiesinradius(self.origin, 64);
  ents = arraysortclosest(ents, self.origin);

  foreach(ent in ents) {
    if(ent == self || vectordot(ent.origin - self.origin, movedir) <= 0) {
      continue;
    }

    recordbox(ent.origin, ent getmins(), ent getmaxs(), ent.angles[1], (1, 0, 0), "<dev string:x3d>");

    if(isDefined(ent.targetname)) {
      record3dtext(ent.targetname, ent.origin, (1, 0, 0), "<dev string:x3d>");
    }

    if(isDefined(ent.targetname) && ent.targetname == # "smart_cover") {
      self.bot.var_ad331541 = ent;
      break;
    }

    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == # "care_package" && ent isusable()) {
      self.bot.var_510b1057 = ent;
      break;
    }
  }

  if(isDefined(self.bot.var_510b1057) || isDefined(self.bot.var_ad331541)) {
    pixendevent();
    return;
  }

  eye = self.origin + (0, 0, self getplayerviewheight());

  if(!isDefined(self.bot.var_8e60176d)) {
    self.bot.var_8e60176d = 0;
  }

  var_c40ef0b0 = anglesToForward(self getplayerangles() + (0, self.bot.var_8e60176d, 0));
  self.bot.var_8e60176d = (self.bot.var_8e60176d + 36) % 360;
  end = eye + var_c40ef0b0 * 20;
  trace = bulletTrace(eye, end, 0, self);
  surfacetype = trace[# "surfacetype"];

  if(isDefined(surfacetype) && surfacetype == # "glass" && !isDefined(trace[# "entity"])) {
    self notify(#"glass", {
      #position: trace[# "position"]
    });
    pixendevent();
    return;
  }

  var_901218a3 = self.origin + (0, 0, 16);
  glassradiusdamage(var_901218a3, 64, 3000, 3000);

  recordcircle(var_901218a3, 64, (1, 0, 0), "<dev string:x3d>", self);

  pixendevent();
}

function private function_ef59c9e() {
  self endon(#"death", #"bot_shutdown");
  level endon(#"game_ended");
  self.bot.glasstouch = undefined;

  while(true) {
    result = self waittill(#"glass");
    self.bot.glasstouch = result.position;
    wait 0.2;
    self.bot.glasstouch = undefined;
  }
}

function init_bot() {
  self.bot = {};
  self.bot.var_458ddbc0 = [];
  self.maxsightdistsqrd = 0 * 0;
  self.highlyawareradius = 96;
  self.fovcosine = fov_angle_to_cosine(179);
  self.fovcosinebusy = fov_angle_to_cosine(110);
  self botsetlooksensitivity(1, 1);
  self function_4f0b9564(7.5, 15);
  self function_3ca49c4e(1);
  self.goalradius = 512;
}

function fov_angle_to_cosine(fovangle = 0) {
  if(fovangle >= 180) {
    return 0;
  }

  return cos(fovangle / 2);
}

function move_dir() {
  move = self getnormalizedmovement();
  fwd = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  return fwd * move[0] + right * move[1];
}

function function_f0c35734(trigger) {
  assert(isbot(self));
  assert(isDefined(trigger));
  radius = self getpathfindingradius();
  height = self function_6a9ae71();
  heightoffset = (0, 0, height * -1 / 2);
  var_e790dc87 = (radius, radius, height / 2);
  obb = ai::function_470c0597(trigger.origin + heightoffset, trigger.maxs + var_e790dc87, trigger.angles);
  return obb;
}

function function_52947b70(trigger) {
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

function private function_e4055765() {
  var_458ddbc0 = self.bot.var_458ddbc0;

  foreach(bit, val in var_458ddbc0) {
    self bottapbutton(bit);

    if(val > 1) {
      var_458ddbc0[bit] = undefined;
    }
  }

  if(isshipbuild()) {
    return;
  }

  if(getdvarint(#"bot_forcefire", 0)) {
    weapon = self getcurrentweapon();

    if(weapon.firetype == # "full auto" || weapon.firetype == # "auto burst" || weapon.firetype == # "minigun" || !self attackButtonPressed()) {
      self bottapbutton(0);

      if(weapon.dualwieldweapon != level.weaponnone) {
        self bottapbutton(11);
      }
    } else {
      self botreleasebutton(0);

      if(weapon.dualwieldweapon != level.weaponnone) {
        self botreleasebutton(11);
      }
    }
  }

  if(getdvarint(#"bot_forcemelee", 0)) {
    if(!self ismeleeing()) {
      self bottapbutton(2);
    }
  }

  if(getdvarint(#"bot_forcestand", 0)) {
    self botreleasebutton(9);
    self botreleasebutton(8);
    return;
  }

  if(getdvarint(#"bot_forcecrouch", 0)) {
    self bottapbutton(9);
    self botreleasebutton(8);
    return;
  }

  if(getdvarint(#"bot_forceprone", 0)) {
    self botreleasebutton(9);
    self bottapbutton(8);
    return;
  }

  if(getdvarint(#"hash_3049c8687f66a426", 0)) {
    self botreleasebutton(9);
    self botreleasebutton(8);

    if(self isonground() && !self jumpbuttonPressed()) {
      self bottapbutton(10);
    }
  }
}

function add_fixed_spawn_bot(team, origin, yaw, roleindex = undefined) {
  bot = add_bot(team);

  if(isDefined(bot)) {
    if(isDefined(roleindex) && roleindex >= 0) {
      bot.var_29b433bd = int(roleindex);
    }

    bot.ignoreall = 1;
    bot function_bab12815(origin, yaw);
  }

  return bot;
}

function function_bab12815(origin, yaw) {
  if(!isstruct(self.bot)) {
    return;
  }

  self.pers[# "hash_63201776738fc052"] = origin;
  self.pers[# "hash_777e40938cf10f50"] = (0, yaw, 0);
  self.bot.var_6af67fd1 = 1;
}

function function_39d30bb6(forcegoal) {
  if(!isstruct(self.bot)) {
    return;
  }

  self.bot.var_7280cc1b = forcegoal;
}

function function_bcc79b86(vehicle, seatindex = undefined) {
  if(!isstruct(self.bot)) {
    return;
  }

  self.bot.var_22989bf = vehicle;
  self.bot.var_a3d475e5 = seatindex;
}

function private fixed_spawn_override() {
  self endon(#"death", #"hash_6280ac8ed281ce3c");
  waittillframeend();

  if(!isstruct(self.bot)) {
    return;
  }

  origin = self.pers[# "hash_63201776738fc052"];
  angles = self.pers[# "hash_777e40938cf10f50"];
  forcegoal = isDefined(self.bot.var_7280cc1b) ? self.bot.var_7280cc1b : 1;

  if(isDefined(origin)) {
    self.ignoreall = 1;
    self dontinterpolate();
    self setorigin(origin);

    if(isDefined(angles)) {
      self setplayerangles(angles);
    }

    self setgoal(origin, forcegoal);
  }

  self function_50c012c9();
}

function private function_50c012c9() {
  if(!isstruct(self.bot)) {
    return;
  }

  vehicle = self.bot.var_22989bf;
  seatindex = self.bot.var_a3d475e5;

  if(!isvehicle(vehicle)) {
    return;
  }

  if(isint(seatindex) && !vehicle isvehicleseatoccupied(seatindex)) {
    vehicle usevehicle(self, seatindex);
    return;
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

function should_record(dvarstr) {
  if(getdvarint(#"recorder_enablerec", 0) < 1 || getdvarint(dvarstr, 0) <= 0) {
    return 0;
  }

  botnum = getdvarint(#"hash_457b3d0b71e0fd8a", 0);

  if(botnum < 0) {
    return 1;
  }

  return self getentitynumber() == botnum;
}

function record_text(text, textcolor, dvarstr) {
  if(self should_record(dvarstr)) {
    record3dtext(text, self.origin, textcolor, "<dev string:x3d>", self, 0.5);
  }
}

function private function_ef4e01f() {
  if(!self should_record(#"hash_1919da6e381816f7")) {
    return;
  }

  if(!isDefined(self.bot.difficulty)) {
    record3dtext(function_9e72a96(#"hash_34d3ed856dad1a43"), self.origin, (1, 1, 1), "<dev string:x3d>", self, 0.5);
    return;
  }

  record3dtext(self.bot.difficulty.name, self.origin, (1, 1, 1), "<dev string:x3d>", self, 0.5);
}

function private function_cf9ffac7() {
  if(!self should_record(#"hash_44dd65804e74042e") && !self should_record(#"hash_15e4429f6d6deb52")) {
    return;
  }

  color = function_5d55f3c9(self.combatstate);
  record3dtext(function_9e72a96(self.combatstate), self.origin, color, "<dev string:x3d>", self, 0.5);
}

function private function_5d55f3c9(combatstate) {
  switch (combatstate) {
    case # "combat_state_in_combat":
      return (1, 0, 0);
    case # "combat_state_has_visible_enemy":
      return (1, 0.5, 0);
    case # "combat_state_aware_of_enemies":
      return (1, 1, 0);
    case # "combat_state_idle":
      return (0, 1, 0);
  }

  return (1, 1, 1);
}

function private function_f76a8ac4() {
  if(!self should_record(#"bot_recordgoal") || !isDefined(self get_revive_target())) {
    return;
  }

  target = self get_revive_target().origin;
  recordline(self.origin, target, (0, 1, 1), "<dev string:x3d>", self);
  recordcircle(target, 32, (0, 1, 1), "<dev string:x3d>", self);
}

function private function_4c0124cd() {
  if(!self should_record(#"hash_609739e47080f375")) {
    return;
  }

  sessionmode = currentsessionmode();
  characterindex = self getspecialistindex();
  assetname = function_ac0419ac(characterindex, sessionmode);
  displayname = makelocalizedstring(getcharacterdisplayname(characterindex, sessionmode));
  characterfields = getcharacterfields(characterindex, sessionmode);
  rolefields = getplayerrolefields(characterindex, sessionmode);
  var_270eb160 = is_true(rolefields.var_ae8ab113) ? (0, 1, 0) : (1, 0, 0);
  record3dtext(characterindex + "<dev string:x47>" + function_9e72a96(assetname) + "<dev string:x4c>" + displayname, self.origin, var_270eb160, "<dev string:x3d>", self);
  factioncolor = (1, 1, 1);
  var_99dffb44 = isDefined(characterfields.superfaction) ? characterfields.superfaction : "<dev string:x52>";
  teamfaction = undefined;
  var_501b8f06 = "<dev string:x52>";

  if(is_true(level.var_d1455682.var_67bfde2a)) {
    teamfaction = teams::function_20cfd8b5(self.team);
  }

  if(isDefined(teamfaction.superfaction)) {
    var_501b8f06 = teamfaction.superfaction;
    factioncolor = var_501b8f06 == var_99dffb44 ? (0, 1, 0) : (1, 0, 0);
  }

  record3dtext("<dev string:x5a>" + function_9e72a96(var_99dffb44), self.origin, factioncolor, "<dev string:x3d>", self);
  record3dtext(function_9e72a96(self.team) + "<dev string:x6c>" + function_9e72a96(var_501b8f06), self.origin, factioncolor, "<dev string:x3d>", self);
}

function map_color(val, maxval, ...) {
  if(val <= 0) {
    return vararg[0];
  } else if(val >= maxval) {
    return vararg[vararg.size - 1];
  }

  var_c0dabf48 = val * vararg.size / maxval;
  var_c0dabf48 -= 1;
  colorindex = int(var_c0dabf48);
  colorfrac = var_c0dabf48 - colorindex;
  return vectorlerp(vararg[colorindex], vararg[colorindex + 1], colorfrac);
}

function function_e5d7f472() {
  return isDefined(self.bot.revivetarget) && isDefined(self.bot.revivetarget.revivetrigger);
}

function get_revive_target() {
  return self.bot.revivetarget;
}

function function_85bfe6d3() {
  if(isDefined(self.bot.revivetarget)) {
    return self.bot.revivetarget.revivetrigger;
  }

  return undefined;
}

function set_revive_target(target) {
  self.bot.revivetarget = target;
}

function clear_revive_target() {
  self.bot.revivetarget = undefined;
}