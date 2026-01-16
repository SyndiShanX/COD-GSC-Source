/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_ball.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_oob;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using_animtree("generic");
#namespace ball;

function autoexec __init__sytem__() {
  system::register("ball", & __init__, & __main__, undefined);
}

function __init__() {
  clientfield::register("allplayers", "ballcarrier", 15000, 1, "int");
  clientfield::register("allplayers", "passoption", 15000, 1, "int");
  clientfield::register("world", "ball_away", 15000, 1, "int");
  clientfield::register("world", "ball_score_allies", 15000, 1, "int");
  clientfield::register("world", "ball_score_axis", 15000, 1, "int");
  clientfield::register("scriptmover", "ball_on_ground_fx", 15000, 1, "int");
  level.ballweapon = getweapon("ball");
  level.ballworldweapon = getweapon("ball_world");
  level.passingballweapon = getweapon("ball_world_pass");
  level._grab_minigun = & function_18041b1b;
  zm_hero_weapon::register_hero_weapon("ball");
  zm::register_zombie_damage_override_callback( & function_f1b94849);
}

function function_18041b1b(player) {
  player function_257ed160(player, 0);
}

function function_797c5146(weapon) {
  return weapon == level.ballworldweapon;
}

function function_3652dc9c(weapon) {
  return weapon == level.ballweapon;
}

function function_c004c2bd() {
  playfx("dlc4/genesis/fx_weapon_key_throw_impact", self.origin);
  playsoundatposition("wpn_summoning_key_impact", self.origin);
  zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 150);
  if(!isdefined(zombies)) {
    return;
  }
  dist_sq = 150 * 150;
  var_c8f67e5c = [];
  for (i = 0; i < zombies.size; i++) {
    if(isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke) {
      continue;
    }
    if(isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
      continue;
    }
    if(zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
      continue;
    }
    zombies[i].marked_for_death = 1;
    if(isvehicle(zombies[i])) {
      zombies[i] clientfield::increment(("zm_bgb_burned_out" + "_fire_torso") + "_vehicle");
    } else {
      zombies[i] clientfield::increment(("zm_bgb_burned_out" + "_fire_torso") + "_actor");
    }
    var_c8f67e5c[var_c8f67e5c.size] = zombies[i];
  }
  for (i = 0; i < var_c8f67e5c.size; i++) {
    util::wait_network_frame();
    if(!isdefined(var_c8f67e5c[i])) {
      continue;
    }
    if(zm_utility::is_magic_bullet_shield_enabled(var_c8f67e5c[i])) {
      continue;
    }
    if(!(isdefined(var_c8f67e5c[i].exclude_cleanup_adding_to_total) && var_c8f67e5c[i].exclude_cleanup_adding_to_total)) {
      level.zombie_total++;
    }
    var_c8f67e5c[i] dodamage(var_c8f67e5c[i].health + 666, var_c8f67e5c[i].origin);
  }
}

function function_f1b94849(willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(function_797c5146(weapon) && isdefined(self.var_c732138b)) {
    return self[[self.var_c732138b]]();
  }
  if(self.archetype === "mechz" || self.archetype === "margwa") {
    return 0;
  }
  if(self function_797c5146(weapon)) {
    launchvector = vectorscale(vdir, 0.1);
    self thread zm_spawner::zombie_ragdoll_then_explode(launchvector, attacker);
    self thread function_c004c2bd();
    playfxontag("dlc4/genesis/fx_weapon_key_impact_fire_torso_zmb", self, "j_spine4");
    return 1;
  }
  if(self function_3652dc9c(weapon)) {
    if(!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
      level.zombie_total++;
    }
    playfxontag("dlc4/genesis/fx_weapon_key_impact_fire_torso_zmb", self, "j_spine4");
    self dodamage(self.health + 666, self.origin);
    return 1;
  }
  return 0;
}

function __main__() {
  callback::on_connect( & function_cffd1019);
  level.ball_start = undefined;
  level.ball = undefined;
  level.objectivepingdelay = 1;
}

function function_cffd1019() {
  self flag::init("has_ball");
  self thread carry_think_ball();
}

function carry_think_ball() {
  self endon("disconnect");
  self flag::wait_till("has_ball");
  self thread ball_pass_watch();
  self thread ball_shoot_watch();
  self thread ball_weapon_change_watch();
}

function anyballsintheair() {
  if(isdefined(level.ball)) {
    if(isdefined(level.ball.carrier)) {
      return;
    }
    if(isdefined(level.ball.projectile)) {
      if(!level.ball.projectile isonground()) {
        return level.ball;
      }
    }
  }
}

function waitforballtocometorest() {
  self endon("reset");
  self endon("pickup_object");
  if(isdefined(self.projectile)) {
    if(self.projectile isonground()) {
      return;
    }
    self.projectile endon("death");
    self.projectile endon("stationary");
    self.projectile endon("grenade_bounce");
    while (true) {
      wait(1);
    }
  }
}

function freezeplayersforroundend() {
  self endon("disconnect");
  self waittill("spawned");
}

function waitforallballstocometorest() {
  ball = anyballsintheair();
  if(isdefined(ball)) {
    level notify("game_ended");
    foreach(player in level.players) {
      player thread freezeplayersforroundend();
    }
    ball waitforballtocometorest();
  }
}

function ball_ontimelimit() {
  waitforallballstocometorest();
}

function ballovertimeround2_ontimelimit() {
  waitforallballstocometorest();
  winner = undefined;
  if(level.teambased) {
    foreach(team in level.teams) {
      if(game["teamSuddenDeath"][team]) {
        winner = team;
        break;
      }
    }
  } else {
    print("" + winner.name);
    print("");
    if(isdefined(winner)) {} else {}
  }
  setdvar("ui_text_endreason", game["strings"]["time_limit_reached"]);
}

function onspawnplayer(predictedspawn) {
  self.isballcarrier = 0;
  self.ballcarried = undefined;
  self clientfield::set("ctf_flag_carrier", 0);
  self thread ballconsistencyswitchthread();
}

function ballconsistencyswitchthread() {
  self endon("death");
  self endon("delete");
  player = self;
  ball = getweapon("ball");
  while (true) {
    if(isdefined(ball) && player hasweapon(ball)) {
      curweapon = player getcurrentweapon();
      if(isdefined(curweapon) && curweapon != ball) {
        if(curweapon.isheroweapon) {
          slot = self gadgetgetslot(curweapon);
        }
        player switchtoweaponimmediate(ball);
        player disableweaponcycling();
        player disableoffhandweapons();
      }
    }
    wait(0.05);
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isdefined(self.carryobject)) {} else {}
  if(isdefined(level.ball)) {
    ballcarrier = level.ball.carrier;
    if(isdefined(ballcarrier)) {
      ballorigin = level.ball.carrier.origin;
      iscarried = 1;
    } else {
      ballorigin = level.ball.curorigin;
      iscarried = 0;
    }
    if(iscarried && isdefined(attacker) && isdefined(attacker.team) && attacker != self && ballcarrier != attacker) {
      if(attacker.team == level.ball.carrier.team) {
        dist = distance2dsquared(self.origin, ballorigin);
        if(dist < level.defaultoffenseradiussq) {
          attacker addplayerstat("defend_carrier", 1);
        }
      }
    }
  } else {
    victim = self;
  }
}

function get_real_ball_location(startpos, startangles, index, count, defaultdistance, rotation) {
  currentangle = startangles[1] + ((360 / count) * 0.5) + ((360 / count) * index);
  coscurrent = cos(currentangle + rotation);
  sincurrent = sin(currentangle + rotation);
  new_position = startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
  clip_mask = 1 | 8;
  trace = physicstrace(startpos, new_position, vectorscale((-1, -1, -1), 5), vectorscale((1, 1, 1), 5), self, clip_mask);
  return trace["position"];
}

function function_b4352e6c(player) {
  direction = player getplayerangles();
  direction_vec = anglestoforward(direction);
  eye = player geteye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bullettrace(eye, eye + direction_vec, 0, undefined);
  var_a1c100ee = trace["position"];
  function_4bff2a85(var_a1c100ee);
}

function function_7eb07bb0(player) {
  if(!isdefined(player) || !isdefined(player.carryobject)) {
    return;
  }
  var_e870556 = player.carryobject;
  function_257ed160(player, 0);
  var_e870556 function_a41df27c();
}

function function_a41df27c() {
  self notify("reset");
  visual = self.visuals[0];
  linkedparent = visual getlinkedent();
  if(isdefined(linkedparent)) {
    visual unlink();
  }
  visual delete();
  if(isdefined(self.projectile)) {
    self.projectile delete();
  }
  self gameobjects::allow_carry("none");
  level.ball_start delete();
  level.ball = undefined;
}

function function_5faeea5e(player) {
  level.ball_start = spawn("trigger_radius", player.origin + (0, 0, 0), 2, 50, 50);
  level.ball = spawn_ball(level.ball_start);
}

function function_257ed160(player, var_501dd320) {
  if(!isdefined(player) || !isdefined(player.carryobject)) {
    return;
  }
  if(isdefined(player.carryobject.scorefrozenuntil) && player.carryobject.scorefrozenuntil > gettime()) {
    return;
  }
  player.carryobject.scorefrozenuntil = gettime() + 10000;
  ball_check_assist(player, 1);
  team = self.team;
  otherteam = util::getotherteam(team);
  if(isdefined(player.shoot_charge_bar)) {
    player.shoot_charge_bar.inuse = 0;
  }
  ball = player.carryobject;
  ball.lastcarrierscored = 1;
  player gameobjects::take_carry_weapon(ball.carryweapon);
  ball ball_set_dropped(1);
  if(var_501dd320) {
    ball thread upload_ball(self);
  }
  if(isdefined(player.pers["carries"])) {
    player.pers["carries"]++;
    player.carries = player.pers["carries"];
  }
  ball_give_score(otherteam, level.carryscore);
}

function function_4bff2a85(v_pos) {
  level.ball_start = spawn("trigger_radius", v_pos, 2, 50, 50);
  level.ball = spawn_ball(level.ball_start);
}

function setup_goal(trigger, team) {
  useobj = gameobjects::create_use_object(team, trigger, [], (0, 0, trigger.height * 0.5), istring("ball_goal_" + team));
  useobj gameobjects::set_visible_team("any");
  useobj gameobjects::set_model_visibility(1);
  useobj gameobjects::allow_use("enemy");
  useobj gameobjects::set_use_time(0);
  if(isdefined(level.ball)) {
    useobj gameobjects::set_key_object(level.ball);
  }
  useobj.canuseobj = & can_use_goal;
  useobj.onuse = & on_use_goal;
  useobj.ball_in_goal = 0;
  useobj.radiussq = trigger.radius * trigger.radius;
  useobj.center = trigger.origin + (0, 0, trigger.height * 0.5);
  return useobj;
}

function can_use_goal(player) {
  return !self.ball_in_goal;
}

function on_use_goal(player) {
  if(!isdefined(player) || !isdefined(player.carryobject)) {
    return;
  }
  if(isdefined(player.carryobject.scorefrozenuntil) && player.carryobject.scorefrozenuntil > gettime()) {
    return;
  }
  self play_goal_score_fx();
  player.carryobject.scorefrozenuntil = gettime() + 10000;
  ball_check_assist(player, 1);
  team = self.team;
  otherteam = util::getotherteam(team);
  if(isdefined(player.shoot_charge_bar)) {
    player.shoot_charge_bar.inuse = 0;
  }
  ball = player.carryobject;
  ball.lastcarrierscored = 1;
  player gameobjects::take_carry_weapon(ball.carryweapon);
  ball ball_set_dropped(1);
  ball thread upload_ball(self);
  if(isdefined(player.pers["carries"])) {
    player.pers["carries"]++;
    player.carries = player.pers["carries"];
  }
  bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_capture", team, player.origin);
  player recordgameevent("capture");
  player addplayerstatwithgametype("CARRIES", 1);
  player addplayerstatwithgametype("captures", 1);
  ball_give_score(otherteam, level.carryscore);
}

function spawn_ball(trigger) {
  visuals = [];
  visuals[0] = spawn("script_model", trigger.origin);
  visuals[0] setmodel("wpn_t7_zmb_dlc4_summoning_key_world");
  visuals[0] notsolid();
  trigger enablelinkto();
  trigger linkto(visuals[0]);
  trigger.no_moving_platfrom_unlink = 1;
  ballobj = gameobjects::create_carry_object("neutral", trigger, visuals, (0, 0, 0), istring("ball_ball"), "mpl_hit_alert_ballholder");
  ballobj gameobjects::allow_carry("any");
  ballobj gameobjects::set_drop_offset(16);
  ballobj.objectiveonvisuals = 1;
  ballobj.allowweapons = 0;
  ballobj.carryweapon = getweapon("ball");
  ballobj.keepcarryweapon = 1;
  ballobj.waterbadtrigger = 0;
  ballobj.disallowremotecontrol = 1;
  ballobj.disallowplaceablepickup = 1;
  ballobj gameobjects::update_objective();
  ballobj.canuseobject = & can_use_ball;
  ballobj.onpickup = & on_pickup_ball;
  ballobj.setdropped = & ball_set_dropped;
  ballobj.onreset = & on_reset_ball;
  ballobj.pickuptimeoutoverride = & ball_physics_timeout;
  ballobj.carryweaponthink = & carry_think_ball;
  ballobj.onuse = & function_756cbdda;
  ballobj.in_goal = 0;
  ballobj.lastcarrierscored = 0;
  ballobj.lastcarrierteam = "neutral";
  if(isdefined(level.idleflagreturntime) && level.idleflagreturntime > 0) {
    ballobj.autoresettime = level.idleflagreturntime;
  } else {
    ballobj.autoresettime = 15;
  }
  playfxontag("ui/fx_uplink_ball_trail", ballobj.visuals[0], "tag_origin");
  return ballobj;
}

function function_756cbdda(player) {
  if(!isalive(player)) {
    return;
  }
  while (!zm_laststand::laststand_has_players_weapons_returned(player)) {
    wait(0.05);
  }
  if(self.type == "carryObject") {
    if(isdefined(player.carryobject)) {
      if(isdefined(player.carryobject.swappable) && player.carryobject.swappable) {
        player.carryobject thread gameobjects::set_dropped();
      } else {
        if(isdefined(self.onpickupfailed)) {
          self[[self.onpickupfailed]](player);
        }
        return;
      }
    }
    player gameobjects::give_object(self);
  } else if(self.type == "packObject") {
    if(isdefined(level.max_packobjects) && level.max_packobjects <= player.packobject.size) {
      if(isdefined(self.onpickupfailed)) {
        self[[self.onpickupfailed]](player);
      }
      return;
    }
    player gameobjects::give_pack_object(self);
  }
  self gameobjects::set_carrier(player);
  self gameobjects::ghost_visuals();
  self.trigger.origin = self.trigger.origin + vectorscale((0, 0, 1), 10000);
  self notify("pickup_object");
  level notify("po");
  if(isdefined(self.onpickup)) {
    self[[self.onpickup]](player);
  }
  self gameobjects::update_compass_icons();
  self gameobjects::update_world_icons();
}

function can_use_ball(player) {
  if(!isdefined(player)) {
    return false;
  }
  if(!self gameobjects::can_interact_with(player)) {
    return false;
  }
  if(isdefined(self.droptime) && self.droptime >= gettime()) {
    return false;
  }
  if(isdefined(player.resurrect_weapon) && player getcurrentweapon() == player.resurrect_weapon) {
    return false;
  }
  if(player iscarryingturret()) {
    return false;
  }
  currentweapon = player getcurrentweapon();
  if(isdefined(currentweapon)) {
    if(!valid_ball_pickup_weapon(currentweapon)) {
      return false;
    }
  }
  nextweapon = player.changingweapon;
  if(isdefined(nextweapon) && player isswitchingweapons()) {
    if(!valid_ball_pickup_weapon(nextweapon)) {
      return false;
    }
  }
  if(player player_no_pickup_time()) {
    return false;
  }
  ball = self.visuals[0];
  thresh = 15;
  dist2 = distance2dsquared(ball.origin, player.origin);
  if(dist2 < (thresh * thresh)) {
    return true;
  }
  ball = self.visuals[0];
  start = player geteye();
  end = (self.curorigin[0], self.curorigin[1], self.curorigin[2] + 5);
  if(isdefined(self.carrier) && isplayer(self.carrier)) {
    end = self.carrier geteye();
  }
  if(!sighttracepassed(end, start, 0, ball) && !sighttracepassed(end, player.origin, 0, ball)) {
    return false;
  }
  return true;
}

function chief_mammal_reset() {
  self.isresetting = 1;
  self notify("reset");
  origin = self.curorigin;
  if(isdefined(self.projectile)) {
    origin = self.projectile.origin;
  }
  foreach(visual in self.visuals) {
    visual.origin = origin;
    visual.angles = visual.baseangles;
    visual dontinterpolate();
    visual show();
  }
  if(isdefined(self.projectile)) {
    self.projectile delete();
  }
  self gameobjects::clear_carrier();
  gameobjects::update_world_icons();
  gameobjects::update_compass_icons();
  gameobjects::update_objective();
  self.isresetting = 0;
}

function on_pickup_ball(player) {
  if(!isalive(player)) {
    self chief_mammal_reset();
    return;
  }
  player disableusability();
  player disableoffhandweapons();
  level.usestartspawns = 0;
  level clientfield::set("ball_away", 1);
  self.visuals[0] clientfield::set("ball_on_ground_fx", 0);
  linkedparent = self.visuals[0] getlinkedent();
  if(isdefined(linkedparent)) {
    self.visuals[0] unlink();
  }
  player resetflashback();
  pass = 0;
  ball_velocity = 0;
  if(isdefined(self.projectile)) {
    pass = 1;
    ball_velocity = self.projectile getvelocity();
    self.projectile delete();
  }
  if(pass) {
    if(self.lastcarrierteam == player.team) {
      if(self.lastcarrier != player) {
        player.passtime = gettime();
        player.passplayer = self.lastcarrier;
      }
    } else {}
  }
  otherteam = util::getotherteam(player.team);
  self.lastcarrierscored = 0;
  self.lastcarrier = player;
  self.lastcarrierteam = player.team;
  self function_74db1ec9(player.team);
  player.balldropdelay = getdvarint("scr_ball_water_drop_delay", 10);
  player.objective = 1;
  player.hasperksprintfire = player hasperk("specialty_sprintfire");
  player setperk("specialty_sprintfire");
  player clientfield::set("ballcarrier", 1);
  player thread player_update_pass_target(self);
  player recordgameevent("pickup");
  player flag::set("has_ball");
}

function private function_a472302d(team) {
  self.ownerteam = team;
  if(team != "any") {
    self.team = team;
    foreach(visual in self.visuals) {
      visual.team = team;
    }
  }
}

function function_74db1ec9(team) {
  self function_a472302d(team);
  self gameobjects::update_trigger();
}

function ball_carrier_cleanup() {
  self function_74db1ec9("neutral");
  if(isdefined(self.carrier)) {
    self.carrier clientfield::set("ballcarrier", 0);
    self.carrier.balldropdelay = undefined;
    self.carrier.nopickuptime = gettime() + 500;
    self.carrier player_clear_pass_target();
    self.carrier notify("cancel_update_pass_target");
    if(!self.carrier.hasperksprintfire) {
      self.carrier unsetperk("specialty_sprintfire");
    }
    self.carrier enableusability();
    self.carrier enableoffhandweapons();
    self.carrier setballpassallowed(0);
    self.carrier.objective = 0;
  }
}

function function_8f5b30b3(origin, angles) {
  self.isresetting = 1;
  foreach(visual in self.visuals) {
    visual.origin = origin;
    visual.angles = angles;
    visual dontinterpolate();
    visual show();
  }
  self.trigger.origin = origin;
  self.curorigin = self.trigger.origin;
  self gameobjects::clear_carrier();
  gameobjects::update_world_icons();
  gameobjects::update_compass_icons();
  self.isresetting = 0;
}

function ball_set_dropped(skip_physics = 0) {
  self.isresetting = 1;
  self.droptime = gettime();
  self notify("dropped");
  dropangles = (0, 0, 0);
  carrier = self.carrier;
  if(isdefined(carrier) && carrier.team != "spectator") {
    droporigin = carrier.origin;
    dropangles = carrier.angles;
  } else {
    droporigin = self.origin;
  }
  if(!isdefined(droporigin)) {
    droporigin = self.safeorigin;
  }
  droporigin = droporigin + vectorscale((0, 0, 1), 40);
  if(isdefined(self.projectile)) {
    self.projectile delete();
  }
  self ball_carrier_cleanup();
  self gameobjects::clear_carrier();
  self function_8f5b30b3(droporigin, dropangles);
  self thread gameobjects::pickup_timeout(droporigin[2], droporigin[2] - 40);
  self.isresetting = 0;
  if(!skip_physics) {
    angles = (0, dropangles[1], 0);
    forward = anglestoforward(angles);
    velocity = (forward * 250) + vectorscale((0, 0, 1), 140);
    ball_physics_launch(velocity);
  }
  return true;
}

function on_reset_ball(prev_origin, var_fd894ecd = 1, var_6f3d4b2e) {
  if(isdefined(level.gameended) && level.gameended) {
    return;
  }
  visual = self.visuals[0];
  linkedparent = visual getlinkedent();
  if(isdefined(linkedparent)) {
    visual unlink();
  }
  if(isdefined(self.projectile)) {
    self.projectile delete();
  }
  if(!self gameobjects::get_flags(1)) {
    playfx("ui/fx_uplink_ball_vanish", prev_origin);
    self play_return_vo();
  }
  self.lastcarrierteam = "none";
  self thread download_ball(var_fd894ecd, var_6f3d4b2e);
}

function ball_return_home(var_fd894ecd, var_6f3d4b2e) {
  self.isresetting = 1;
  prev_origin = self.trigger.origin;
  self notify("reset");
  self gameobjects::move_visuals_to_base();
  self.trigger.origin = self.trigger.baseorigin;
  self.curorigin = self.trigger.origin;
  if(isdefined(self.onreset)) {
    self[[self.onreset]](prev_origin, var_fd894ecd, var_6f3d4b2e);
  }
  self gameobjects::clear_carrier();
  gameobjects::update_world_icons();
  gameobjects::update_compass_icons();
  self.isresetting = 0;
}

function reset_ball(var_fd894ecd = 1, var_a987c5a2, var_6f3d4b2e) {
  self.visuals[0] clientfield::set("ball_on_ground_fx", 0);
  if(isdefined(var_a987c5a2)) {
    self.trigger.baseorigin = var_a987c5a2;
    foreach(visual in self.visuals) {
      visual.baseorigin = var_a987c5a2;
    }
  } else if(zm_utility::is_player_valid(self.lastcarrier)) {
    while (isdefined(self.lastcarrier.is_flung) && self.lastcarrier.is_flung) {
      wait(0.1);
    }
    if(!self.lastcarrier isonground()) {
      var_195da49c = (bullettrace(self.lastcarrier.origin, self.lastcarrier.origin + (vectorscale((0, 0, -1), 100000)), 0, self.lastcarrier)["position"]) + vectorscale((0, 0, 1), 16);
    } else {
      var_195da49c = self.lastcarrier.origin;
    }
    self.trigger.baseorigin = var_195da49c;
    foreach(visual in self.visuals) {
      visual.baseorigin = var_195da49c;
    }
  }
  self thread ball_return_home(var_fd894ecd, var_6f3d4b2e);
}

function upload_ball(goal) {
  self notify("score_event");
  self.in_goal = 1;
  goal.ball_in_goal = 1;
  if(isdefined(self.projectile)) {
    self.projectile delete();
  }
  self gameobjects::allow_carry("none");
  move_to_center_time = 0.4;
  move_up_time = 1.2;
  rotate_time = 1;
  in_enemygoal_time = move_to_center_time + rotate_time;
  total_time = in_enemygoal_time + move_up_time;
  visual = self.visuals[0];
  visual moveto(self.trigger.origin, move_to_center_time, 0, move_to_center_time);
  visual rotatevelocity(vectorscale((1, 1, 0), 1080), total_time, total_time, 0);
  wait(in_enemygoal_time);
  goal.ball_in_goal = 0;
  self.visibleteam = "neutral";
  self gameobjects::update_world_icon("friendly", 0);
  self gameobjects::update_world_icon("enemy", 0);
  self gameobjects::update_objective();
  visual movez(4000, move_up_time, move_up_time * 0.1, 0);
  wait(move_up_time);
  self thread ball_return_home();
}

function download_ball(var_fd894ecd, var_6f3d4b2e = 0) {
  self endon("pickup_object");
  self gameobjects::allow_carry("any");
  self function_74db1ec9("neutral");
  visual = self.visuals[0];
  if(var_fd894ecd) {
    visual.origin = visual.baseorigin + vectorscale((0, 0, 1), 4000);
    visual dontinterpolate();
    fall_time = 3;
    visual moveto(visual.baseorigin, fall_time, 0, fall_time);
    visual rotatevelocity(vectorscale((0, 1, 0), 720), fall_time, 0, fall_time);
    visual thread function_c2bef09f();
  }
  self.visibleteam = "any";
  self gameobjects::update_world_icon("friendly", 1);
  self gameobjects::update_world_icon("enemy", 1);
  if(var_fd894ecd) {
    wait(fall_time);
  }
  level clientfield::set("ball_away", 0);
  visual clientfield::set("ball_on_ground_fx", 1);
  if(!(isdefined(var_6f3d4b2e) && var_6f3d4b2e) && isdefined(level.var_1c0253f1)) {
    self thread[[level.var_1c0253f1]]();
  }
  playfxontag("ui/fx_uplink_ball_trail", visual, "tag_origin");
  self thread ball_download_fx(visual, fall_time);
  self.in_goal = 0;
}

function function_c2bef09f() {
  self playloopsound("prj_ball_loop");
  level waittill("po");
  self stoploopsound();
}

function function_b8faebaf(var_dbefa1ce) {
  self notify("reset");
  visual = self.visuals[0];
  linkedparent = visual getlinkedent();
  if(isdefined(linkedparent)) {
    visual unlink();
  }
  if(isdefined(self.projectile)) {
    self.projectile delete();
  }
  self gameobjects::allow_carry("none");
  wait(var_dbefa1ce);
  self gameobjects::allow_carry("any");
}

function ball_pass_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  while (true) {
    self waittill("ball_pass", weapon);
    if(!isdefined(self.pass_target)) {
      playerangles = self getplayerangles();
      playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
      dir = anglestoforward(playerangles);
      force = 90;
      self.carryobject thread ball_physics_launch_drop(dir * force, self);
      return;
    }
    break;
  }
  if(isdefined(self.carryobject)) {
    self thread ball_pass_or_throw_active();
    pass_target = self.pass_target;
    last_target_origin = self.pass_target.origin;
    wait(0.15);
    if(isdefined(self.pass_target)) {
      pass_target = self.pass_target;
      self.carryobject thread ball_pass_projectile(self, pass_target, last_target_origin);
    } else {
      playerangles = self getplayerangles();
      playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
      dir = anglestoforward(playerangles);
      force = 90;
      self.carryobject thread ball_physics_launch_drop(dir * force, self);
    }
  }
}

function ball_shoot_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  extra_pitch = getdvarfloat("scr_ball_shoot_extra_pitch", -6);
  force = getdvarfloat("scr_ball_shoot_force", 1200);
  playsoundatposition("wpn_ball_pickup", self.origin);
  self playloopsound("prj_ball_loop_idle");
  while (true) {
    self waittill("weapon_fired", weapon);
    self stoploopsound();
    self playsound("wpn_throw_ball");
    if(weapon != getweapon("ball")) {
      continue;
    }
    break;
  }
  if(isdefined(self.carryobject)) {
    playerangles = self getplayerangles();
    playerangles = playerangles + (extra_pitch, 0, 0);
    playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
    dir = anglestoforward(playerangles);
    self thread ball_pass_or_throw_active();
    self thread ball_check_pass_kill_pickup(self.carryobject);
    self.carryobject ball_create_killcam_ent();
    self.carryobject thread ball_physics_launch_drop(dir * force, self, 1);
  }
}

function ball_weapon_change_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  ballweapon = getweapon("ball");
  while (true) {
    if(ballweapon == self getcurrentweapon()) {
      break;
    }
    self waittill("weapon_change");
  }
  while (true) {
    self waittill("weapon_change", weapon, lastweapon);
    if(isdefined(weapon) && weapon.gadget_type == 14) {
      break;
    }
    if(weapon === level.weaponnone && lastweapon === ballweapon) {
      break;
    }
  }
  playerangles = self getplayerangles();
  playerangles = (math::clamp(playerangles[0], -85, 85), absangleclamp360(playerangles[1] + 20), playerangles[2]);
  dir = anglestoforward(playerangles);
  force = 90;
  self.carryobject thread ball_physics_launch_drop(dir * force, self);
}

function valid_ball_pickup_weapon(weapon) {
  if(weapon == level.weaponnone) {
    return false;
  }
  if(weapon == getweapon("ball")) {
    return false;
  }
  return true;
}

function player_no_pickup_time() {
  return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

function watchunderwater(trigger) {
  self endon("death");
  self endon("disconnect");
  while (true) {
    if(self isplayerunderwater()) {
      if(isdefined(level.ball)) {
        if(isdefined(level.ball.carrier) && level.ball.carrier == self) {
          level.ball gameobjects::set_dropped();
          return;
        }
      }
    }
    self.balldropdelay = undefined;
    wait(0.05);
  }
}

function ball_physics_launch_drop(force, droppingplayer, switchweapon) {
  ball_set_dropped(1);
  ball_physics_launch(force, droppingplayer);
}

function ball_check_pass_kill_pickup(carryobj) {
  self endon("death");
  self endon("disconnect");
  carryobj endon("reset");
  timer = spawnstruct();
  timer endon("timer_done");
  timer thread timer_run(1.5);
  carryobj waittill("pickup_object");
  timer timer_cancel();
  if(!isdefined(carryobj.carrier) || carryobj.carrier.team == self.team) {
    return;
  }
  carryobj.carrier endon("disconnect");
  timer thread timer_run(5);
  carryobj.carrier waittill("death", attacker);
  timer timer_cancel();
  if(!isdefined(attacker) || attacker != self) {
    return;
  }
  timer thread timer_run(2);
  carryobj waittill("pickup_object");
  timer timer_cancel();
}

function timer_run(time) {
  self endon("cancel_timer");
  wait(time);
  self notify("timer_done");
}

function timer_cancel() {
  self notify("cancel_timer");
}

function adjust_for_stance(ball) {
  target = self;
  target endon("pass_end");
  offs = 0;
  while (isdefined(target) && isdefined(ball)) {
    newoffs = 50;
    switch (target getstance()) {
      case "crouch": {
        newoffs = 30;
        break;
      }
      case "prone": {
        newoffs = 15;
        break;
      }
    }
    if(newoffs != offs) {
      ball ballsettarget(target, (0, 0, newoffs));
      newoffs = offs;
    }
    wait(0.05);
  }
}

function ball_pass_projectile(passer, target, last_target_origin) {
  ball_set_dropped(1);
  if(isdefined(target)) {
    last_target_origin = target.origin;
  }
  offset = vectorscale((0, 0, 1), 60);
  if(target getstance() == "prone") {
    offset = vectorscale((0, 0, 1), 15);
  } else if(target getstance() == "crouch") {
    offset = vectorscale((0, 0, 1), 30);
  }
  playerangles = passer getplayerangles();
  playerangles = (0, playerangles[1], 0);
  dir = anglestoforward(playerangles);
  delta = dir * 50;
  origin = self.visuals[0].origin + delta;
  size = 5;
  trace = physicstrace(self.visuals[0].origin, origin, (size * -1, size * -1, size * -1), (size, size, size), passer, 1);
  if(trace["fraction"] < 1) {
    t = 0.7 * trace["fraction"];
    self function_8f5b30b3(self.visuals[0].origin + (delta * t), self.visuals[0].angles);
  } else {
    self function_8f5b30b3(trace["position"], self.visuals[0].angles);
  }
  pass_dir = vectornormalize((last_target_origin + offset) - self.visuals[0].origin);
  pass_vel = pass_dir * 850;
  passer flag::clear("has_ball");
  self.projectile = passer magicmissile(level.passingballweapon, self.visuals[0].origin, pass_vel);
  target thread adjust_for_stance(self.projectile);
  self.visuals[0] linkto(self.projectile);
  self gameobjects::ghost_visuals();
  self ball_create_killcam_ent();
  self ball_clear_contents();
  self thread ball_on_projectile_hit_client(passer);
  self thread ball_on_projectile_death();
  self thread ball_watch_touch_enemy_goal();
}

function ball_on_projectile_death() {
  self.projectile waittill("death");
  ball = self.visuals[0];
  if(!isdefined(self.carrier) && !self.in_goal) {
    if(ball.origin != (ball.baseorigin + vectorscale((0, 0, 1), 4000))) {
      self ball_physics_launch(vectorscale((0, 0, 1), 10));
    }
  }
  self ball_restore_contents();
  ball notify("pass_end");
}

function ball_restore_contents() {
  if(isdefined(self.visuals[0].old_contents)) {
    self.visuals[0] setcontents(self.visuals[0].old_contents);
    self.visuals[0].old_contents = undefined;
  }
}

function ball_on_projectile_hit_client(passer) {
  self endon("pass_end");
  self.projectile waittill("projectile_impact_player", player);
  self.trigger notify("trigger", player);
  if(isdefined(passer)) {
    passer recordgameevent("pass");
  }
}

function ball_clear_contents() {
  self.visuals[0].old_contents = self.visuals[0] setcontents(0);
}

function ball_create_killcam_ent() {
  if(isdefined(self.killcament)) {
    self.killcament delete();
  }
  self.killcament = spawn("script_model", self.visuals[0].origin);
  self.killcament linkto(self.visuals[0]);
  self.killcament setcontents(0);
}

function ball_pass_or_throw_active() {
  self endon("death");
  self endon("disconnect");
  self.pass_or_throw_active = 1;
  self allowmelee(0);
  while (getweapon("ball") == self getcurrentweapon()) {
    wait(0.05);
  }
  self allowmelee(1);
  self.pass_or_throw_active = 0;
}

function ball_download_fx(ball_model, waittime) {
  self.scorefrozenuntil = 0;
}

function ball_assign_random_start() {
  ball_assign_start(level.ball_start);
}

function ball_assign_start(start) {
  foreach(vis in self.visuals) {
    vis.baseorigin = start.origin;
  }
  self.trigger.baseorigin = start.origin;
  self.current_start = start;
  start.in_use = 1;
}

function ball_physics_launch(force, droppingplayer) {
  visuals = self.visuals[0];
  visuals.origin_prev = undefined;
  origin = visuals.origin;
  owner = visuals;
  if(isdefined(droppingplayer)) {
    owner = droppingplayer;
    owner flag::clear("has_ball");
    origin = droppingplayer getweaponmuzzlepoint();
    right = anglestoright(force);
    origin = origin + ((right[0], right[1], 0) * 7);
    startpos = origin;
    delta = vectornormalize(force) * 80;
    size = 5;
    trace = physicstrace(startpos, startpos + delta, (size * -1, size * -1, size * -1), (size, size, size), droppingplayer, 1);
    if(trace["fraction"] < 1) {
      t = 0.7 * trace["fraction"];
      self function_8f5b30b3(startpos + (delta * t), visuals.angles);
    } else {
      self function_8f5b30b3(trace["position"], visuals.angles);
    }
  }
  grenade = owner magicmissile(level.ballworldweapon, visuals.origin, force);
  grenade playloopsound("prj_ball_loop");
  visuals linkto(grenade);
  self gameobjects::ghost_visuals();
  self.projectile = grenade;
  visuals dontinterpolate();
  self thread ball_physics_out_of_level();
  self thread ball_watch_touch_enemy_goal();
  self thread ball_physics_touch_cant_pickup_player(droppingplayer);
  self thread ball_check_oob();
  self.var_b4c16cba = 0;
  self thread function_1b26c689();
}

function function_1b26c689() {
  self endon("death");
  while (true) {
    self.projectile waittill("grenade_bounce", pos, normal);
    if(self.var_b4c16cba == 0) {
      dot = vectordot(normal, (0, 0, 1));
      self.projectile thread function_c004c2bd();
    }
    self.var_b4c16cba++;
  }
}

function function_fed77788(var_bdc0f958, v_force) {
  visuals = self.visuals[0];
  visuals unlink();
  wait(0.05);
  if(isdefined(self.projectile)) {
    self.projectile delete();
  }
  grenade = visuals magicmissile(level.ballworldweapon, var_bdc0f958, v_force);
  visuals linkto(grenade);
  self gameobjects::ghost_visuals();
  self.projectile = grenade;
  visuals dontinterpolate();
  self thread ball_physics_out_of_level();
  self thread ball_check_oob();
  self thread gameobjects::pickup_timeout(var_bdc0f958[2], var_bdc0f958[2] - 400);
}

function ball_check_oob() {
  self endon("reset");
  self endon("pickup_object");
  visual = self.visuals[0];
  while (true) {
    skip_oob_check = isdefined(self.in_goal) && self.in_goal || (isdefined(self.isresetting) && self.isresetting);
    if(!skip_oob_check) {
      if(!isdefined(visual)) {
        return;
      }
      if(visual oob::istouchinganyoobtrigger() || visual is_touching_any_ball_return_trigger() || self gameobjects::should_be_reset(visual.origin[2], visual.origin[2] + 10, 1)) {
        self reset_ball();
        return;
      }
    }
    wait(0.05);
  }
}

function ball_physics_touch_cant_pickup_player(droppingplayer) {
  self endon("reset");
  self endon("pickup_object");
  ball = self.visuals[0];
  trigger = self.trigger;
  while (true) {
    trigger waittill("trigger", player);
    if(isactor(player)) {
      continue;
    }
    if(isdefined(droppingplayer) && droppingplayer == player && player player_no_pickup_time()) {
      continue;
    }
    if(self.droptime >= gettime()) {
      continue;
    }
    if(ball.origin == (ball.baseorigin + vectorscale((0, 0, 1), 4000))) {
      continue;
    }
  }
}

function ball_physics_fake_bounce() {
  ball = self.visuals[0];
  vel = ball getvelocity();
  bounceforce = length(vel) / 10;
  bouncedir = -1 * vectornormalize(vel);
}

function ball_watch_touch_enemy_goal() {}

function line_intersect_sphere(line_start, line_end, sphere_center, sphere_radius) {
  dir = vectornormalize(line_end - line_start);
  a = vectordot(dir, line_start - sphere_center);
  a = a * a;
  b = line_start - sphere_center;
  b = b * b;
  c = sphere_radius * sphere_radius;
  return ((a - b) + c) >= 0;
}

function ball_touched_goal(goal) {
  if(isdefined(self.claimplayer)) {
    return;
  }
  if(isdefined(self.scorefrozenuntil) && self.scorefrozenuntil > gettime()) {
    return;
  }
  self gameobjects::allow_carry("none");
  goal play_goal_score_fx();
  self.scorefrozenuntil = gettime() + 10000;
  team = goal.team;
  otherteam = util::getotherteam(team);
  if(isdefined(self.lastcarrier)) {
    if(isdefined(self.lastcarrier.pers["throws"])) {
      self.lastcarrier.pers["throws"]++;
      self.lastcarrier.throws = self.lastcarrier.pers["throws"];
    }
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_throw", team, self.lastcarrier.origin);
    self.lastcarrier recordgameevent("throw");
    self.lastcarrier addplayerstatwithgametype("THROWS", 1);
    self.lastcarrierscored = 1;
    ball_check_assist(self.lastcarrier, 0);
    self.lastcarrier addplayerstatwithgametype("CAPTURES", 1);
  }
  if(isdefined(self.killcament)) {
    self.killcament unlink();
  }
  self thread upload_ball(goal);
  ball_give_score(otherteam, level.throwscore);
}

function ball_give_score(team, score) {
  if(isdefined(game["overtime_round"])) {
    if(game["overtime_round"] == 1) {} else {
      team_score = [
        [level._getteamscore]
      ](team);
      other_team_score = [
        [level._getteamscore]
      ](util::getotherteam(team));
    }
  }
}

function should_record_final_score_cam(team, score_to_add) {
  team_score = [[level._getteamscore]](team);
  other_team_score = [[level._getteamscore]](util::getotherteam(team));
  return (team_score + score_to_add) >= other_team_score;
}

function ball_check_assist(player, wasdunk) {
  if(!isdefined(player.passtime) || !isdefined(player.passplayer)) {
    return;
  }
  if((player.passtime + 3000) < gettime()) {
    return;
  }
}

function ball_physics_timeout() {
  self endon("reset");
  self endon("pickup_object");
  self endon("score_event");
  if(isdefined(self.autoresettime) && self.autoresettime > 15) {
    physicstime = self.autoresettime;
  } else {
    physicstime = 15;
  }
  if(isdefined(self.projectile)) {
    timeoutreason = self.projectile util::waittill_any_ex(physicstime, "stationary", self, "reset", "pickup_object", "score_event");
    if(!isdefined(timeoutreason)) {
      return;
    }
    if(timeoutreason == "stationary") {
      str_zone_name = self.projectile zm_utility::get_current_zone();
      if(isdefined(str_zone_name) && ispointonnavmesh(self.projectile.origin)) {
        self.visuals[0] clientfield::set("ball_on_ground_fx", 1);
        if(isdefined(level.var_1c0253f1)) {
          self thread[[level.var_1c0253f1]]();
        }
        return;
      }
    }
  }
  self reset_ball();
}

function ball_physics_out_of_level() {
  self endon("reset");
  self endon("pickup_object");
  ball = self.visuals[0];
  self waittill("entity_oob");
  self reset_ball(0);
}

function player_update_pass_target(ballobj) {
  self notify("update_pass_target");
  self endon("update_pass_target");
  self endon("disconnect");
  self endon("cancel_update_pass_target");
  test_dot = 0.8;
  while (true) {
    new_target = undefined;
    if(!self isonladder()) {
      playerdir = anglestoforward(self getplayerangles());
      playereye = self geteye();
      possible_pass_targets = [];
      foreach(target in level.players) {
        if(target.team != self.team) {
          continue;
        }
        if(!isalive(target)) {
          continue;
        }
        if(!ballobj can_use_ball(target)) {
          continue;
        }
        targeteye = target geteye();
        distsq = distancesquared(targeteye, playereye);
        if(distsq > 1000000) {
          continue;
        }
        dirtotarget = vectornormalize(targeteye - playereye);
        dot = vectordot(playerdir, dirtotarget);
        if(dot > test_dot) {
          target.pass_dot = dot;
          target.pass_origin = targeteye;
          possible_pass_targets[possible_pass_targets.size] = target;
        }
      }
      possible_pass_targets = array::quicksort(possible_pass_targets, & compare_player_pass_dot);
      foreach(target in possible_pass_targets) {
        if(sighttracepassed(playereye, target.pass_origin, 0, target)) {
          new_target = target;
          break;
        }
      }
    }
    self player_set_pass_target(new_target);
    wait(0.05);
  }
}

function play_return_vo() {}

function compare_player_pass_dot(left, right) {
  return left.pass_dot >= right.pass_dot;
}

function player_set_pass_target(new_target) {
  if(isdefined(self.pass_target) && isdefined(new_target) && self.pass_target == new_target) {
    return;
  }
  if(!isdefined(self.pass_target) && !isdefined(new_target)) {
    return;
  }
  self player_clear_pass_target();
  if(isdefined(new_target)) {
    offset = vectorscale((0, 0, 1), 80);
    new_target clientfield::set("passoption", 1);
    self.pass_target = new_target;
    team_players = [];
    foreach(player in level.players) {
      if(player.team == self.team && player != self && player != new_target) {
        team_players[team_players.size] = player;
      }
    }
    self setballpassallowed(1);
  }
}

function player_clear_pass_target() {
  if(isdefined(self.pass_icon)) {
    self.pass_icon destroy();
  }
  team_players = [];
  foreach(player in level.players) {
    if(player.team == self.team && player != self) {
      team_players[team_players.size] = player;
    }
  }
  if(isdefined(self.pass_target)) {
    self.pass_target clientfield::set("passoption", 0);
  }
  self.pass_target = undefined;
  self setballpassallowed(0);
}

function ballfindground(z_offset) {
  tracestart = self.origin + vectorscale((0, 0, 1), 32);
  traceend = self.origin + (vectorscale((0, 0, -1), 1000));
  trace = bullettrace(tracestart, traceend, 0, undefined);
  self.ground_origin = trace["position"];
  return trace["fraction"] != 0 && trace["fraction"] != 1;
}

function play_goal_score_fx() {
  key = "ball_score_" + self.team;
  level clientfield::set(key, !level clientfield::get(key));
}

function is_touching_any_ball_return_trigger() {
  if(!isdefined(level.ball_return_trigger)) {
    return 0;
  }
  triggers_to_remove = [];
  result = 0;
  foreach(trigger in level.ball_return_trigger) {
    if(!isdefined(trigger)) {
      if(!isdefined(triggers_to_remove)) {
        triggers_to_remove = [];
      } else if(!isarray(triggers_to_remove)) {
        triggers_to_remove = array(triggers_to_remove);
      }
      triggers_to_remove[triggers_to_remove.size] = trigger;
      continue;
    }
    if(!trigger istriggerenabled()) {
      continue;
    }
    if(self istouching(trigger)) {
      result = 1;
      break;
    }
  }
  foreach(trigger in triggers_to_remove) {
    arrayremovevalue(level.ball_return_trigger, trigger);
  }
  triggers_to_remove = [];
  triggers_to_remove = undefined;
  return result;
}