/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\escort.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\gametypes\ctf;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_supplydrop;
#using scripts\mp\teams\_teams;
#using scripts\shared\ai\archetype_robot;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicleriders_shared;
#using scripts\shared\weapons\_heatseekingmissile;
#using scripts\shared\weapons\_weaponobjects;
#namespace escort;

function autoexec __init__sytem__() {
  system::register("escort", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("actor", "robot_state", 1, 2, "int");
  clientfield::register("actor", "escort_robot_burn", 1, 1, "int");
  callback::on_spawned(&on_player_spawned);
}

function main() {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerroundscorelimit(0, 2000);
  util::registerscorelimit(0, 5000);
  util::registerroundlimit(0, 12);
  util::registerroundswitch(0, 9);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  level.boottime = getgametypesetting("bootTime");
  level.reboottime = getgametypesetting("rebootTime");
  level.rebootplayers = getgametypesetting("rebootPlayers");
  level.moveplayers = getgametypesetting("movePlayers");
  level.robotshield = getgametypesetting("robotShield");
  level.robotspeed = "run";
  switch (getgametypesetting("shutdownDamage")) {
    case 1: {
      level.escortrobotkillstreakbundle = "escort_robot_low";
      break;
    }
    case 2: {
      level.escortrobotkillstreakbundle = "escort_robot";
      break;
    }
    case 3: {
      level.escortrobotkillstreakbundle = "escort_robot_high";
    }
    case 0:
    default: {
      level.shutdowndamage = 0;
    }
  }
  if(isDefined(level.escortrobotkillstreakbundle)) {
    killstreak_bundles::register_killstreak_bundle(level.escortrobotkillstreakbundle);
    level.shutdowndamage = killstreak_bundles::get_max_health(level.escortrobotkillstreakbundle);
  }
  switch (getdvarint("", 1)) {
    case 1: {
      level.robotspeed = "";
      break;
    }
    case 2: {
      level.robotspeed = "";
      break;
    }
    case 0:
    default: {
      level.robotspeed = "";
    }
  }
  globallogic_audio::set_leader_gametype_dialog("startSafeguard", "hcStartSafeguard", "sfgStartAttack", "sfgStartDefend");
  if(!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "escorts", "disables", "deaths");
  } else {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "escorts", "disables");
  }
  level.teambased = 1;
  level.overrideteamscore = 1;
  level.scoreroundwinbased = 1;
  level.doubleovertime = 1;
  level.onprecachegametype = &onprecachegametype;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onplayerkilled = &onplayerkilled;
  level.ontimelimit = &ontimelimit;
  level.onroundswitch = &onroundswitch;
  level.onendgame = &onendgame;
  level.shouldplayovertimeround = &shouldplayovertimeround;
  level.onroundendgame = &onroundendgame;
  gameobjects::register_allowed_gameobject(level.gametype);
  killstreak_bundles::register_killstreak_bundle("escort_robot");
}

function onprecachegametype() {}

function onstartgametype() {
  level.usestartspawns = 1;
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }
  setclientnamemode("auto_change");
  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }
  util::setobjectivetext(game["attackers"], &"OBJECTIVES_ESCORT_ATTACKER");
  util::setobjectivetext(game["defenders"], &"OBJECTIVES_ESCORT_DEFENDER");
  util::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ESCORT_ATTACKER_SCORE");
  util::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ESCORT_DEFENDER_SCORE");
  util::setobjectivehinttext(game["attackers"], &"OBJECTIVES_ESCORT_ATTACKER_HINT");
  util::setobjectivehinttext(game["defenders"], &"OBJECTIVES_ESCORT_DEFENDER_HINT");
  if(isDefined(game["overtime_round"])) {
    [[level._setteamscore]]("allies", 0);
    [[level._setteamscore]]("axis", 0);
    if(isDefined(game["escort_overtime_time_to_beat"])) {
      times = game["escort_overtime_time_to_beat"] / 1000;
      timem = int(times) / 60;
      util::registertimelimit(timem, timem);
    }
    if(game["overtime_round"] == 1) {
      level.ontimelimit = &ontimelimit_overtime1;
      util::setobjectivehinttext(game["attackers"], &"MP_ESCORT_OVERTIME_ROUND_1_ATTACKERS");
      util::setobjectivehinttext(game["defenders"], &"MP_ESCORT_OVERTIME_ROUND_1_DEFENDERS");
    } else {
      level.ontimelimit = &ontimelimit_overtime2;
      util::setobjectivehinttext(game["attackers"], &"MP_ESCORT_OVERTIME_ROUND_2_TIE_ATTACKERS");
      util::setobjectivehinttext(game["defenders"], &"MP_ESCORT_OVERTIME_ROUND_2_TIE_DEFENDERS");
    }
  }
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  spawnlogic::place_spawn_points("mp_escort_spawn_attacker_start");
  spawnlogic::place_spawn_points("mp_escort_spawn_defender_start");
  level.spawn_start = [];
  level.spawn_start["allies"] = spawnlogic::get_spawnpoint_array("mp_escort_spawn_attacker_start");
  level.spawn_start["axis"] = spawnlogic::get_spawnpoint_array("mp_escort_spawn_defender_start");
  spawnlogic::add_spawn_points("allies", "mp_escort_spawn_attacker");
  spawnlogic::add_spawn_points("axis", "mp_escort_spawn_defender");
  spawning::add_fallback_spawnpoints("allies", "mp_tdm_spawn");
  spawning::add_fallback_spawnpoints("axis", "mp_tdm_spawn");
  spawning::updateallspawnpoints();
  spawning::update_fallback_spawnpoints();
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level thread drop_robot();
}

function onspawnplayer(predictedspawn) {
  spawning::onspawnplayer(predictedspawn);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isDefined(attacker) || attacker == self || !isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(self.team == game["defenders"] && (isDefined(attacker.escortingrobot) && attacker.escortingrobot)) {
    attacker recordgameevent("attacking");
    scoreevents::processscoreevent("killed_defender", attacker);
  } else if(self.team == game["attackers"] && (isDefined(self.escortingrobot) && self.escortingrobot)) {
    attacker recordgameevent("defending");
    scoreevents::processscoreevent("killed_attacker", attacker);
  }
}

function ontimelimit() {
  winner = game["defenders"];
  globallogic_score::giveteamscoreforobjective_delaypostprocessing(winner, 1);
  level thread globallogic::endgame(winner, game["strings"]["time_limit_reached"]);
}

function ontimelimit_overtime1() {
  winner = game["defenders"];
  level thread globallogic::endgame(winner, game["strings"]["time_limit_reached"]);
}

function ontimelimit_overtime2() {
  winner = game["defenders"];
  prevwinner = game["escort_overtime_first_winner"];
  if(winner == prevwinner) {
    level thread globallogic::endgame(winner, game["strings"]["time_limit_reached"]);
  } else {
    level thread globallogic::endgame("tie", game["strings"]["time_limit_reached"]);
  }
}

function onroundswitch() {
  game["switchedsides"] = !game["switchedsides"];
}

function onendgame(winningteam) {
  if(isDefined(game["overtime_round"])) {
    if(game["overtime_round"] == 1) {
      game["escort_overtime_first_winner"] = winningteam;
      if(winningteam == game["defenders"]) {
        game["escort_overtime_time_to_beat"] = undefined;
      } else {
        game["escort_overtime_time_to_beat"] = globallogic_utils::gettimepassed();
      }
    } else {
      game["escort_overtime_second_winner"] = winningteam;
      if(isDefined(winningteam) && winningteam != "tie") {
        game["escort_overtime_best_time"] = globallogic_utils::gettimepassed();
      }
    }
  }
  level.robot thread delete_on_endgame_sequence();
}

function shouldplayovertimeround() {
  if(isDefined(game["overtime_round"])) {
    if(game["overtime_round"] == 1 || !level.gameended) {
      return true;
    }
    return false;
  }
  alliesroundswon = util::getroundswon("allies");
  axisroundswon = util::getroundswon("axis");
  if(util::hitroundlimit() && alliesroundswon == axisroundswon) {
    return true;
  }
  return false;
}

function onroundendgame(winningteam) {
  if(isDefined(game["overtime_round"])) {
    foreach(team in level.teams) {
      score = game["roundswon"][team];
      [[level._setteamscore]](team, score);
    }
    return winningteam;
  }
  return globallogic::determineteamwinnerbyteamscore();
}

function on_player_spawned() {
  self.escortingrobot = undefined;
}

function drop_robot() {
  globallogic::waitforplayers();
  movetrigger = getent("escort_robot_move_trig", "targetname");
  patharray = get_robot_path_array();
  startdir = patharray[0] - movetrigger.origin;
  startangles = vectortoangles(startdir);
  drop_origin = movetrigger.origin;
  drop_height = (isDefined(level.escort_drop_height) ? level.escort_drop_height : supplydrop::getdropheight(drop_origin));
  heli_drop_goal = (drop_origin[0], drop_origin[1], drop_height);
  goalpath = undefined;
  dropoffset = vectorscale((0, -1, 0), 120);
  goalpath = supplydrop::supplydrophelistartpath_v2_setup(heli_drop_goal, dropoffset);
  supplydrop::supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, dropoffset);
  drop_direction = vectortoangles((heli_drop_goal[0], heli_drop_goal[1], 0) - (goalpath.start[0], goalpath.start[1], 0));
  chopper = spawnhelicopter(getplayers()[0], heli_drop_goal, (0, 0, 0), "combat_escort_robot_dropship", "");
  chopper.maxhealth = 999999;
  chopper.health = 999999;
  chopper.spawntime = gettime();
  supplydropspeed = (isDefined(level.escort_drop_speed) ? level.escort_drop_speed : getdvarint("scr_supplydropSpeedStarting", 1000));
  supplydropaccel = (isDefined(level.escort_drop_accel) ? level.escort_drop_accel : getdvarint("scr_supplydropAccelStarting", 1000));
  chopper setspeed(supplydropspeed, supplydropaccel);
  maxpitch = getdvarint("scr_supplydropMaxPitch", 25);
  maxroll = getdvarint("scr_supplydropMaxRoll", 45);
  chopper setmaxpitchroll(0, maxroll);
  spawnposition = (0, 0, 0);
  spawnangles = (0, 0, 0);
  level.robot = spawn_robot(spawnposition, spawnangles);
  level.robot.onground = undefined;
  level.robot.team = game["attackers"];
  level.robot setforcenocull();
  level.robot.vehicle = chopper;
  level.robot.vehicle.ignore_seat_check = 1;
  level.robot vehicle::get_in(chopper, "driver", 1);
  level.robot.dropundervehicleoriginoverride = 1;
  level.robot.targetangles = startangles;
  chopper vehicle::unload("all");
  level.robot playSound("evt_safeguard_robot_land");
  chopper thread drop_heli_leave();
  while(level.robot flagsys::get("in_vehicle")) {
    wait(1);
  }
  level.robot.patharray = patharray;
  level.robot.pathindex = 0;
  level.robot.victimsoundmod = "safeguard_robot";
  level.robot.goaljustblocked = 0;
  level.robot thread update_stop_position();
  level.robot thread watch_robot_damaged();
  level.robot thread wait_robot_moving();
  level.robot thread wait_robot_stopped();
  level.robot.spawn_influencer_friendly = level.robot spawning::create_entity_friendly_influencer("escort_robot_attackers", game["attackers"]);
  debug_draw_robot_path();
  level thread debug_reset_robot_to_start();
  level.moveobject = setup_move_object(level.robot, "escort_robot_move_trig");
  level.goalobject = setup_goal_object(level.robot, "escort_robot_goal_trig");
  setup_reboot_object(level.robot, "escort_robot_reboot_trig");
  if(level.boottime) {
    level.robot clientfield::set("robot_state", 2);
    level.moveobject gameobjects::set_flags(2);
    blackboard::setblackboardattribute(level.robot, "_stance", "crouch");
    level.robot ai::set_behavior_attribute("rogue_control_speed", level.robotspeed);
    level.robot shutdown_robot();
  } else {
    objective_setprogress(level.moveobject.objectiveid, 1);
    level.moveobject gameobjects::allow_use("friendly");
  }
  level.robot thread wait_robot_shutdown();
  level.robot thread wait_robot_reboot();
  while(level.inprematchperiod) {
    wait(0.05);
  }
  level.robot.onground = 1;
  if(level.boottime) {
    level.robot thread auto_reboot_robot(level.boottime);
  } else if(level.moveplayers == 0) {
    level.robot move_robot();
  }
}

function drop_heli_leave() {
  chopper = self;
  wait(1);
  supplydropspeed = getdvarint("scr_supplydropSpeedLeaving", 250);
  supplydropaccel = getdvarint("scr_supplydropAccelLeaving", 60);
  chopper setspeed(supplydropspeed, supplydropaccel);
  goalpath = supplydrop::supplydropheliendpath_v2(chopper.origin);
  chopper airsupport::followpath(goalpath.path, undefined, 0);
  chopper delete();
}

function debug_draw_robot_path() {
  if((isDefined(getdvarint("")) ? getdvarint("") : 0) == 0) {
    return;
  }
  debug_duration = 999999999;
  pathnodes = level.robot.patharray;
  for(i = 0; i < (pathnodes.size - 1); i++) {
    currnode = pathnodes[i];
    nextnode = pathnodes[i + 1];
    util::debug_line(currnode, nextnode, vectorscale((0, 1, 0), 0.9), 0.9, 0, debug_duration);
  }
  foreach(path in pathnodes) {
    util::debug_sphere(path, 6, vectorscale((0, 0, 1), 0.9), 0.9, debug_duration);
  }
}

function debug_draw_approximate_robot_path_to_goal(&goalpatharray) {
  if((isDefined(getdvarint("")) ? getdvarint("") : 0) == 0) {
    return;
  }
  debug_duration = 60;
  pathnodes = goalpatharray;
  for(i = 0; i < (pathnodes.size - 1); i++) {
    currnode = pathnodes[i];
    nextnode = pathnodes[i + 1];
    util::debug_line(currnode, nextnode, vectorscale((1, 1, 0), 0.9), 0.9, 0, debug_duration);
  }
  foreach(path in pathnodes) {
    util::debug_sphere(path, 3, (0, 0.5, 0.5), 0.9, debug_duration);
  }
}

function debug_draw_current_robot_goal(goal) {
  if((isDefined(getdvarint("")) ? getdvarint("") : 0) == 0) {
    return;
  }
  if(isDefined(goal)) {
    debug_duration = 60;
    util::debug_sphere(goal, 8, vectorscale((0, 1, 0), 0.9), 0.9, debug_duration);
  }
}

function debug_draw_find_immediate_goal(pathgoal) {
  if((isDefined(getdvarint("")) ? getdvarint("") : 0) == 0) {
    return;
  }
  if(isDefined(pathgoal)) {
    debug_duration = 60;
    util::debug_sphere(pathgoal + vectorscale((0, 0, 1), 18), 6, vectorscale((1, 0, 0), 0.9), 0.9, debug_duration);
  }
}

function debug_draw_find_immediate_goal_override(immediategoal) {
  if((isDefined(getdvarint("")) ? getdvarint("") : 0) == 0) {
    return;
  }
  if(isDefined(immediategoal)) {
    debug_duration = 60;
    util::debug_sphere(immediategoal + vectorscale((0, 0, 1), 18), 6, vectorscale((1, 0, 1), 0.9), 0.9, debug_duration);
  }
}

function debug_draw_blocked_path_kill_radius(center, radius) {
  if((isDefined(getdvarint("")) ? getdvarint("") : 0) == 0) {
    return;
  }
  if(isDefined(center)) {
    debug_duration = 200;
    circle(center + vectorscale((0, 0, 1), 2), radius, vectorscale((1, 0, 0), 0.9), 1, 1, debug_duration);
    circle(center + vectorscale((0, 0, 1), 4), radius, vectorscale((1, 0, 0), 0.9), 1, 1, debug_duration);
  }
}

function wait_robot_moving() {
  level endon("game_ended");
  while(true) {
    self waittill("robot_moving");
    self recordgameeventnonplayer("robot_start");
    self clientfield::set("robot_state", 1);
    level.moveobject gameobjects::set_flags(1);
  }
}

function wait_robot_stopped() {
  level endon("game_ended");
  while(true) {
    self waittill("robot_stopped");
    if(self.active) {
      self recordgameeventnonplayer("robot_stop");
      self clientfield::set("robot_state", 0);
      level.moveobject gameobjects::set_flags(0);
    }
  }
}

function wait_robot_shutdown() {
  level endon("game_ended");
  while(true) {
    self waittill("robot_shutdown");
    level.moveobject gameobjects::allow_use("none");
    objective_setprogress(level.moveobject.objectiveid, -0.05);
    self clientfield::set("robot_state", 2);
    level.moveobject gameobjects::set_flags(2);
    otherteam = util::getotherteam(self.team);
    globallogic_audio::leader_dialog("sfgRobotDisabledAttacker", self.team, undefined, "robot");
    globallogic_audio::leader_dialog("sfgRobotDisabledDefender", otherteam, undefined, "robot");
    globallogic_audio::play_2d_on_team("mpl_safeguard_disabled_sting_friend", self.team);
    globallogic_audio::play_2d_on_team("mpl_safeguard_disabled_sting_enemy", otherteam);
    self thread auto_reboot_robot(level.reboottime);
  }
}

function wait_robot_reboot() {
  level endon("game_ended");
  while(true) {
    self waittill("robot_reboot");
    self recordgameeventnonplayer("robot_repair_complete");
    level.moveobject gameobjects::allow_use("friendly");
    otherteam = util::getotherteam(self.team);
    globallogic_audio::leader_dialog("sfgRobotRebootedAttacker", self.team, undefined, "robot");
    globallogic_audio::leader_dialog("sfgRobotRebootedDefender", otherteam, undefined, "robot");
    globallogic_audio::play_2d_on_team("mpl_safeguard_reboot_sting_friend", self.team);
    globallogic_audio::play_2d_on_team("mpl_safeguard_reboot_sting_enemy", otherteam);
    objective_setprogress(level.moveobject.objectiveid, 1);
    if(level.moveplayers == 0) {
      self move_robot();
    } else if(level.moveobject.numtouching[level.moveobject.ownerteam] == 0) {
      self clientfield::set("robot_state", 0);
      level.moveobject gameobjects::set_flags(0);
    }
  }
}

function auto_reboot_robot(time) {
  self endon("robot_reboot");
  self endon("game_ended");
  shutdowntime = 0;
  while(shutdowntime < time) {
    rate = 0;
    friendlycount = level.moveobject.numtouching[level.moveobject.ownerteam];
    if(!level.rebootplayers) {
      rate = 0.05;
    } else if(friendlycount > 0) {
      rate = 0.05;
      if(friendlycount > 1) {
        bonusrate = ((friendlycount - 1) * 0.05) * 0;
        rate = rate + bonusrate;
      }
    }
    if(rate > 0) {
      shutdowntime = shutdowntime + rate;
      percent = min(1, shutdowntime / time);
      objective_setprogress(level.moveobject.objectiveid, percent);
    }
    wait(0.05);
  }
  if(level.rebootplayers > 0) {
    foreach(struct in level.moveobject.touchlist[game["attackers"]]) {
      scoreevents::processscoreevent("escort_robot_reboot", struct.player);
    }
  }
  self thread reboot_robot();
}

function watch_robot_damaged() {
  level endon("game_ended");
  while(true) {
    self waittill("robot_damaged");
    percent = min(1, self.shutdowndamage / level.shutdowndamage);
    objective_setprogress(level.moveobject.objectiveid, 1 - percent);
    health = level.shutdowndamage - self.shutdowndamage;
    lowhealth = killstreak_bundles::get_low_health(level.escortrobotkillstreakbundle);
    if(!(isDefined(self.playeddamage) && self.playeddamage) && health <= lowhealth) {
      globallogic_audio::leader_dialog("sfgRobotUnderFire", self.team, undefined, "robot");
      self.playeddamage = 1;
    } else if(health > lowhealth) {
      self.playeddamage = 0;
    }
  }
}

function delete_on_endgame_sequence() {
  self endon("death");
  level waittill("endgame_sequence");
  self delete();
}

function get_robot_path_array() {
  if(isDefined(level.escortrobotpath)) {
    println("");
    return level.escortrobotpath;
  }
  println("");
  patharray = [];
  currnode = getnode("escort_robot_path_start", "targetname");
  patharray[patharray.size] = currnode.origin;
  while(isDefined(currnode.target)) {
    currnode = getnode(currnode.target, "targetname");
    patharray[patharray.size] = currnode.origin;
  }
  if(isDefined(level.update_escort_robot_path)) {
    [[level.update_escort_robot_path]](patharray);
  }
  return patharray;
}

function calc_robot_path_length(robotorigin, patharray) {
  distance = 0;
  lastpoint = robotorigin;
  for(i = 0; i < patharray.size; i++) {
    distance = distance + distance(lastpoint, patharray[i]);
    lastpoint = patharray[i];
  }
  println("" + distance);
}

function spawn_robot(position, angles) {
  robot = spawnactor("spawner_bo3_robot_grunt_assault_mp_escort", position, angles, "", 1);
  robot ai::set_behavior_attribute("rogue_allow_pregib", 0);
  robot ai::set_behavior_attribute("rogue_allow_predestruct", 0);
  robot ai::set_behavior_attribute("rogue_control", "forced_level_2");
  robot ai::set_behavior_attribute("rogue_control_speed", level.robotspeed);
  robot ai::set_ignoreall(1);
  robot.allowdeath = 0;
  robot ai::set_behavior_attribute("can_become_crawler", 0);
  robot ai::set_behavior_attribute("can_be_meleed", 0);
  robot ai::set_behavior_attribute("can_initiateaivsaimelee", 0);
  robot ai::set_behavior_attribute("traversals", "procedural");
  aiutility::clearaioverridedamagecallbacks(robot);
  robot.active = 1;
  robot.canwalk = 1;
  robot.moving = 0;
  robot.shutdowndamage = 0;
  robot.propername = "";
  robot.ignoretriggerdamage = 1;
  robot.allowpain = 0;
  robot clientfield::set("robot_mind_control", 0);
  robot ai::set_behavior_attribute("robot_lights", 3);
  robot.pushable = 0;
  robot pushactors(1);
  robot pushplayer(1);
  robot setavoidancemask("avoid none");
  robot disableaimassist();
  robot setsteeringmode("slow steering");
  blackboard::setblackboardattribute(robot, "_robot_locomotion_type", "alt1");
  if(level.robotshield) {
    aiutility::attachriotshield(robot, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_stowed_back");
  }
  robot asmsetanimationrate(1.1);
  if(isDefined(level.shutdowndamage) && level.shutdowndamage) {
    target_set(robot, vectorscale((0, 0, 1), 50));
  }
  robot.overrideactordamage = &robot_damage;
  robot thread robot_move_chatter();
  robot.missiletargetmissdistance = 64;
  robot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile();
  return robot;
}

function robot_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(!(isDefined(self.onground) && self.onground)) {
    return false;
  }
  if(level.shutdowndamage <= 0 || !self.active || eattacker.team == game["attackers"]) {
    return false;
  }
  level.usestartspawns = 0;
  weapon_damage = killstreak_bundles::get_weapon_damage(level.escortrobotkillstreakbundle, level.shutdowndamage, eattacker, weapon, smeansofdeath, idamage, idflags, undefined);
  if(!isDefined(weapon_damage)) {
    weapon_damage = idamage;
  }
  if(!weapon_damage) {
    return false;
  }
  self.shutdowndamage = self.shutdowndamage + weapon_damage;
  self notify("robot_damaged");
  if(!isDefined(eattacker.damagerobot)) {
    eattacker.damagerobot = 0;
  }
  eattacker.damagerobot = eattacker.damagerobot + weapon_damage;
  if(self.shutdowndamage >= level.shutdowndamage) {
    origin = (0, 0, 0);
    if(isPlayer(eattacker)) {
      level thread popups::displayteammessagetoall(&"MP_ESCORT_ROBOT_DISABLED", eattacker);
      level.robot recordgameeventnonplayer("robot_disabled");
      if(distance2dsquared(self.origin, level.goalobject.trigger.origin) < (level.goalobject.trigger.radius + 50) * (level.goalobject.trigger.radius + 50)) {
        scoreevents::processscoreevent("escort_robot_disable_near_goal", eattacker);
      } else {
        scoreevents::processscoreevent("escort_robot_disable", eattacker);
      }
      if(isDefined(eattacker.pers["disables"])) {
        eattacker.pers["disables"]++;
        eattacker.disables = eattacker.pers["disables"];
      }
      eattacker addplayerstatwithgametype("DISABLES", 1);
      eattacker recordgameevent("return");
      origin = eattacker.origin;
    }
    foreach(player in level.players) {
      if(player == eattacker || player.team == self.team || !isDefined(player.damagerobot)) {
        continue;
      }
      damagepercent = player.damagerobot / level.shutdowndamage;
      if(damagepercent >= 0.5) {
        scoreevents::processscoreevent("escort_robot_disable_assist_50", player);
      } else if(damagepercent >= 0.25) {
        scoreevents::processscoreevent("escort_robot_disable_assist_25", player);
      }
      player.damagerobot = undefined;
    }
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "escort_shutdown", game["defenders"], origin);
    self shutdown_robot();
    if(isDefined(eattacker) && eattacker != self && isDefined(weapon)) {
      if(weapon.name == "planemortar") {
        if(!isDefined(eattacker.planemortarbda)) {
          eattacker.planemortarbda = 0;
        }
        eattacker.planemortarbda++;
      } else {
        if(weapon.name == "dart" || weapon.name == "dart_turret") {
          if(!isDefined(eattacker.dartbda)) {
            eattacker.dartbda = 0;
          }
          eattacker.dartbda++;
        } else {
          if(weapon.name == "straferun_rockets" || weapon.name == "straferun_gun") {
            if(isDefined(eattacker.straferunbda)) {
              eattacker.straferunbda++;
            }
          } else if(weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet") {
            if(!isDefined(eattacker.remotemissilebda)) {
              eattacker.remotemissilebda = 0;
            }
            eattacker.remotemissilebda++;
          }
        }
      }
    }
  }
  self.health = self.health + 1;
  return true;
}

function robot_damage_none(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  return false;
}

function shutdown_robot() {
  self.active = 0;
  self ai::set_ignoreme(1);
  self.canwalk = 0;
  self stop_robot();
  self notify("robot_shutdown");
  if(target_istarget(self)) {
    target_remove(self);
  }
  if(isDefined(self.riotshield)) {
    self asmchangeanimmappingtable(1);
    self detach(self.riotshield.model, self.riotshield.tag);
    aiutility::attachriotshield(self, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_weapon_left");
  }
  self ai::set_behavior_attribute("shutdown", 1);
}

function reboot_robot() {
  self endon("robot_shutdown");
  level endon("game_ended");
  self.active = 1;
  self.shutdowndamage = 0;
  self ai::set_ignoreme(0);
  self notify("robot_reboot");
  if(isDefined(level.shutdowndamage) && level.shutdowndamage) {
    target_set(self, vectorscale((0, 0, 1), 50));
  }
  if(isDefined(self.riotshield)) {
    self asmchangeanimmappingtable(0);
    self detach(self.riotshield.model, self.riotshield.tag);
    aiutility::attachriotshield(self, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_stowed_back");
  }
  self ai::set_behavior_attribute("shutdown", 0);
  wait(getanimlength("ai_robot_rogue_ctrl_crc_shutdown_2_alert"));
  self.canwalk = 1;
}

function move_robot() {
  if(self.active == 0 || self.moving || !isDefined(self.pathindex)) {
    return;
  }
  if(self check_blocked_goal_and_kill()) {
    return;
  }
  if(gettime() < (isDefined(self.blocked_wait_end_time) ? self.blocked_wait_end_time : 0)) {
    return;
  }
  self notify("robot_moving");
  self.moving = 1;
  self set_goal_to_point_on_path();
  self thread robot_wait_next_point();
}

function get_current_goal() {
  return (isDefined(self.immediategoaloverride) ? self.immediategoaloverride : self.patharray[self.pathindex]);
}

function reached_closest_nav_mesh_goal_but_still_too_far_and_blocked(goalonnavmesh) {
  if(isDefined(self.immediategoaloverride)) {
    return false;
  }
  distsqr = distancesquared(goalonnavmesh, self.origin);
  robotreachedclosestgoalonnavmesh = distsqr <= (24 * 24);
  if(robotreachedclosestgoalonnavmesh) {
    closestgoalonnavmeshtoofarfrompathgoal = distancesquared(goalonnavmesh, self.patharray[self.pathindex]) > (1 * 1);
    if(closestgoalonnavmeshtoofarfrompathgoal) {
      robotisblockedfromgettingtopathgoal = self check_if_goal_is_blocked(self.origin, self.patharray[self.pathindex]);
      if(robotisblockedfromgettingtopathgoal) {
        return true;
      }
    }
  }
  return false;
}

function check_blocked_goal_and_kill() {
  if(!self.canwalk) {
    return 0;
  }
  if(gettime() < (isDefined(self.blocked_wait_end_time) ? self.blocked_wait_end_time : 0)) {
    wait((self.blocked_wait_end_time - gettime()) / 1000);
  }
  goalonnavmesh = self get_closest_point_on_nav_mesh_for_current_goal();
  previousgoal = (!isDefined(self.immediategoaloverride) ? self.patharray[self.pathindex - 1] : self.origin);
  if(self.goaljustblocked || self reached_closest_nav_mesh_goal_but_still_too_far_and_blocked(goalonnavmesh) || self check_if_goal_is_blocked(previousgoal, goalonnavmesh)) {
    self.goaljustblocked = 0;
    stillblocked = 1;
    killedsomething = self kill_anything_blocking_goal(goalonnavmesh);
    if(killedsomething) {
      stillblocked = self check_if_goal_is_blocked(previousgoal, goalonnavmesh);
      if(stillblocked) {
        self.blocked_wait_end_time = gettime() + 200;
        self stop_robot();
      }
    } else {
      self find_immediate_goal();
    }
    return stillblocked;
  }
  return 0;
}

function find_immediate_goal() {
  pathgoal = self.patharray[self.pathindex];
  currpos = self.origin;
  debug_draw_find_immediate_goal(pathgoal);
  immediategoal = get_closest_point_on_nav_mesh(vectorlerp(currpos, pathgoal, 0.5));
  while(self check_if_goal_is_blocked(currpos, immediategoal)) {
    immediategoal = get_closest_point_on_nav_mesh(vectorlerp(currpos, immediategoal, 0.5));
  }
  self.immediategoaloverride = immediategoal;
  debug_draw_find_immediate_goal_override(self.immediategoaloverride);
}

function check_if_goal_is_blocked(previousgoal, goal) {
  approxpatharray = self calcapproximatepathtoposition(goal);
  distancetonextgoal = min(distance(self.origin, goal), distance(previousgoal, goal));
  approxpathtoolong = is_path_distance_to_goal_too_long(approxpatharray, distancetonextgoal * 2.5);
  return approxpathtoolong;
}

function watch_goal_becoming_blocked(goal) {
  self notify("end_watch_goal_becoming_blocked_singleton");
  self endon("end_watch_goal_becoming_blocked_singleton");
  self endon("robot_stopped");
  self endon("goal");
  level endon("game_ended");
  disttogoalsqr = 1E+09;
  while(true) {
    wait(0.1);
    if(isDefined(self.traversestartnode)) {
      self waittill("traverse_end");
      continue;
    }
    if(self asmistransdecrunning()) {
      continue;
    }
    if(!self.canwalk) {
      continue;
    }
    newdisttogoalsqr = distancesquared(self.origin, goal);
    if(newdisttogoalsqr < disttogoalsqr) {
      disttogoalsqr = newdisttogoalsqr;
    } else {
      self.goaljustblocked = 1;
      self notify("goal_blocked");
    }
  }
}

function watch_becoming_blocked_at_goal() {
  self notify("end_watch_becoming_blocked_at_goal");
  self endon("end_watch_becoming_blocked_at_goal");
  self endon("robot_stop");
  level endon("game_ended");
  while(isDefined(self.traversestartnode)) {
    self waittill("traverse_end");
  }
  self.watch_becoming_blocked_at_goal_established = 1;
  startpos = self.origin;
  atsameposcount = 0;
  iterationcount = 0;
  while(self.moving) {
    wait(0.1);
    if(distancesquared(startpos, self.origin) < 1) {
      atsameposcount++;
    }
    if(atsameposcount >= 2) {
      self.goaljustblocked = 1;
      self notify("goal_blocked");
    }
    iterationcount++;
    if(iterationcount >= 3) {
      break;
    }
  }
  self.watch_becoming_blocked_at_goal_established = 0;
}

function stop_robot() {
  if(!self.moving) {
    return;
  }
  if(isDefined(self.traversestartnode)) {
    self thread check_robot_on_travesal_end();
    return;
  }
  self.moving = 0;
  self.mostrecentclosestpathpointgoal = undefined;
  self.watch_becoming_blocked_at_goal_established = 0;
  velocity = self getvelocity();
  deltapos = velocity * 0.05;
  stopgoal = (isDefined(getclosestpointonnavmesh(self.origin + deltapos, 48, 15)) ? getclosestpointonnavmesh(self.origin + deltapos, 48, 15) : self.origin);
  self setgoal(stopgoal, 0);
  self notify("robot_stopped");
}

function check_robot_on_travesal_end() {
  self notify("check_robot_on_travesal_end_singleton");
  self endon("check_robot_on_travesal_end_singleton");
  self endon("death");
  self waittill("traverse_end");
  numowners = (isDefined(level.moveobject.numtouching[level.moveobject.ownerteam]) ? level.moveobject.numtouching[level.moveobject.ownerteam] : 0);
  if(numowners < level.moveplayers) {
    self stop_robot();
  } else {
    self move_robot();
  }
}

function update_stop_position() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self waittill("traverse_end");
    if(!self.moving) {
      self setgoal(self.origin, 1);
    }
  }
}

function robot_wait_next_point() {
  self endon("robot_stopped");
  self endon("death");
  level endon("game_ended");
  while(true) {
    self util::waittill_any("goal", "goal_blocked");
    if(!isDefined(self.watch_becoming_blocked_at_goal_established) || self.watch_becoming_blocked_at_goal_established == 0) {
      self thread watch_becoming_blocked_at_goal();
    }
    if(distancesquared(self.origin, get_current_goal()) < (24 * 24)) {
      self.pathindex = self.pathindex + (isDefined(self.immediategoaloverride) ? 0 : 1);
      self.immediategoaloverride = undefined;
    }
    while(self.pathindex < self.patharray.size && distancesquared(self.origin, self.patharray[self.pathindex]) < (48 + 1) * (48 + 1)) {
      self.pathindex++;
    }
    if(self.pathindex >= self.patharray.size) {
      self.pathindex = undefined;
      self stop_robot();
      return;
    }
    if((self.pathindex + 1) >= self.patharray.size) {
      otherteam = util::getotherteam(self.team);
      globallogic_audio::leader_dialog("sfgRobotCloseAttacker", self.team, undefined, "robot");
      globallogic_audio::leader_dialog("sfgRobotCloseDefender", otherteam, undefined, "robot");
    }
    if(self check_blocked_goal_and_kill()) {
      self stop_robot();
    }
    set_goal_to_point_on_path();
  }
}

function get_closest_point_on_nav_mesh_for_current_goal() {
  immediategoal = get_current_goal();
  closestpathpoint = getclosestpointonnavmesh(immediategoal, 48, 15);
  if(!isDefined(closestpathpoint)) {
    closestpathpoint = getclosestpointonnavmesh(immediategoal, 96, 15);
  }
  return (isDefined(closestpathpoint) ? closestpathpoint : immediategoal);
}

function get_closest_point_on_nav_mesh(point) {
  closestpathpoint = getclosestpointonnavmesh(point, 48, 15);
  if(!isDefined(closestpathpoint)) {
    closestpathpoint = getclosestpointonnavmesh(point, 96, 15);
  }
  if(!isDefined(closestpathpoint)) {
    itercount = 0;
    lowerpoint = point - vectorscale((0, 0, 1), 36);
    while(!isDefined(closestpathpoint) && itercount < 5) {
      closestpathpoint = getclosestpointonnavmesh(lowerpoint, 48, 15);
      lowerpoint = lowerpoint - vectorscale((0, 0, 1), 36);
      itercount++;
    }
  }
  return (isDefined(closestpathpoint) ? closestpathpoint : point);
}

function set_goal_to_point_on_path(recursioncount = 0) {
  self.goaljustblocked = 0;
  closestpathpoint = self get_closest_point_on_nav_mesh_for_current_goal();
  if(isDefined(closestpathpoint)) {
    if(!isDefined(self.mostrecentclosestpathpointgoal) || distancesquared(closestpathpoint, self.mostrecentclosestpathpointgoal) > 1) {
      self setgoal(closestpathpoint, 0, 24);
      self thread watch_goal_becoming_blocked(closestpathpoint);
      self.mostrecentclosestpathpointgoal = closestpathpoint;
    }
  } else {
    if(recursioncount < 3) {
      self find_immediate_goal();
      self set_goal_to_point_on_path(recursioncount + 1);
    } else {
      self stop_robot();
    }
  }
  debug_draw_current_robot_goal(closestpathpoint);
}

function is_path_distance_to_goal_too_long(&patharray, toolongthreshold) {
  debug_draw_approximate_robot_path_to_goal(patharray);
  if(toolongthreshold < 20) {
    toolongthreshold = 20;
  }
  goaldistance = 0;
  lastindextocheck = patharray.size - 1;
  for(i = 0; i < lastindextocheck; i++) {
    goaldistance = goaldistance + (distance(patharray[i], patharray[i + 1]));
    if(goaldistance >= toolongthreshold) {
      return true;
    }
  }
  return false;
}

function debug_reset_robot_to_start() {
  level endon("game_ended");
  while(true) {
    if((isDefined(getdvarint("")) ? getdvarint("") : 0) > 0) {
      if(isDefined(level.robot)) {
        pathindex = (isDefined(getdvarint("")) ? getdvarint("") : 0) - 1;
        pathpoint = level.robot.patharray[pathindex];
        robotangles = (0, 0, 0);
        if(pathindex < (level.robot.patharray.size - 1)) {
          nextpoint = level.robot.patharray[pathindex + 1];
          robotangles = vectortoangles(nextpoint - pathpoint);
        }
        level.robot forceteleport(pathpoint, robotangles);
        level.robot.pathindex = pathindex;
        level.robot.immediategoaloverride = undefined;
        while(isDefined(self.traversestartnode)) {
          wait(0.05);
        }
        level.robot stop_robot();
        level.robot setgoal(level.robot.origin, 0);
      }
      setDvar("", 0);
    }
    wait(0.5);
  }
}

function explode_robot() {
  self clientfield::set("escort_robot_burn", 1);
  clientfield::set("robot_mind_control_explosion", 1);
  self thread wait_robot_corpse();
  if(randomint(100) >= 50) {
    gibserverutils::gibleftarm(self);
  } else {
    gibserverutils::gibrightarm(self);
  }
  gibserverutils::giblegs(self);
  gibserverutils::gibhead(self);
  velocity = self getvelocity() * 0.125;
  self startragdoll();
  self launchragdoll((velocity[0] + (randomfloatrange(-20, 20)), velocity[1] + (randomfloatrange(-20, 20)), randomfloatrange(60, 80)), "j_mainroot");
  playFXOnTag("weapon/fx_c4_exp_metal", self, "tag_origin");
  if(target_istarget(self)) {
    target_remove(self);
  }
  physicsexplosionsphere(self.origin, 200, 1, 1, 1, 1);
  radiusdamage(self.origin, 200, 1, 1, undefined, "MOD_EXPLOSIVE");
  playrumbleonposition("grenade_rumble", self.origin);
}

function wait_robot_corpse() {
  archetype = self.archetype;
  self waittill("actor_corpse", corpse);
  corpse clientfield::set("escort_robot_burn", 1);
}

function robot_move_chatter() {
  level endon("game_ended");
  while(true) {
    if(self.moving) {
      self playsoundontag("vox_robot_chatter", "J_Head");
    }
    wait(randomfloatrange(1.5, 2.5));
  }
}

function setup_move_object(robot, triggername) {
  trigger = getent(triggername, "targetname");
  useobj = gameobjects::create_use_object(game["attackers"], trigger, [], (0, 0, 0), &"escort_robot");
  useobj gameobjects::set_objective_entity(robot);
  useobj gameobjects::allow_use("none");
  useobj gameobjects::set_visible_team("any");
  useobj gameobjects::set_use_time(0);
  trigger enablelinkto();
  trigger linkto(robot);
  useobj.onuse = &on_use_robot_move;
  useobj.onupdateuserate = &on_update_use_rate_robot_move;
  useobj.robot = robot;
  if(isDefined(level.levelescortdisable)) {
    if(!isDefined(useobj.exclusions)) {
      useobj.exclusions = [];
    }
    foreach(trigger in level.levelescortdisable) {
      useobj.exclusions[useobj.exclusions.size] = trigger;
    }
  }
  return useobj;
}

function on_use_robot_move(player) {
  level.usestartspawns = 0;
  if(self.robot.moving || !self.robot.active || self.numtouching[self.ownerteam] < level.moveplayers) {
    return;
  }
  self thread track_escorting_players();
  self.robot move_robot();
}

function on_update_use_rate_robot_move(team, progress, change) {
  numowners = self.numtouching[self.ownerteam];
  if(numowners < level.moveplayers) {
    self.robot stop_robot();
  }
}

function track_escorting_players() {
  level endon("game_ended");
  self.robot endon("robot_stopped");
  while(true) {
    foreach(touch in self.touchlist[self.team]) {
      if(!(isDefined(touch.player.escortingrobot) && touch.player.escortingrobot)) {
        self thread track_escort_time(touch.player);
      }
    }
    wait(0.05);
  }
}

function track_escort_time(player) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  self.robot endon("robot_shutdown");
  player.escortingrobot = 1;
  player recordgameevent("player_escort_start");
  self thread wait_escort_death(player);
  self thread wait_escort_shutdown(player);
  consecutiveescorts = 0;
  while(true) {
    wait(1);
    touching = 0;
    foreach(touch in self.touchlist[self.team]) {
      if(touch.player == player) {
        touching = 1;
        break;
      }
    }
    if(!touching) {
      break;
    }
    if(isDefined(player.pers["escorts"])) {
      player.pers["escorts"]++;
      player.escorts = player.pers["escorts"];
    }
    player addplayerstatwithgametype("ESCORTS", 1);
    consecutiveescorts++;
    if((consecutiveescorts % 3) == 0) {
      scoreevents::processscoreevent("escort_robot_escort", player);
    }
  }
  player player_stop_escort();
}

function player_stop_escort() {
  if(!isDefined(self)) {
    return;
  }
  self.escortingrobot = 0;
  self recordgameevent("player_escort_stop");
  self notify("escorting_stopped");
}

function wait_escort_death(player) {
  level endon("game_ended");
  player endon("escorting_stopped");
  player endon("disconnect");
  player waittill("death");
  player thread player_stop_escort();
}

function wait_escort_shutdown(player) {
  level endon("game_ended");
  player endon("escorting_stopped");
  player endon("disconnect");
  self.robot waittill("robot_shutdown");
  player thread player_stop_escort();
}

function setup_reboot_object(robot, triggername) {
  trigger = getent(triggername, "targetname");
  if(isDefined(trigger)) {
    trigger delete();
  }
}

function setup_goal_object(robot, triggername) {
  trigger = getent(triggername, "targetname");
  useobj = gameobjects::create_use_object(game["defenders"], trigger, [], (0, 0, 0), &"escort_goal");
  useobj gameobjects::set_visible_team("any");
  useobj gameobjects::allow_use("none");
  useobj gameobjects::set_use_time(0);
  fwd = (0, 0, 1);
  right = (0, -1, 0);
  useobj.fx = spawnfx("ui/fx_dom_marker_team_r120", trigger.origin, fwd, right);
  useobj.fx.team = game["defenders"];
  triggerfx(useobj.fx, 0.001);
  useobj thread watch_robot_enter(robot);
  return useobj;
}

function watch_robot_enter(robot) {
  robot endon("death");
  level endon("game_ended");
  radiussq = self.trigger.radius * self.trigger.radius;
  while(true) {
    if(robot.moving === 1 && distance2dsquared(self.trigger.origin, robot.origin) < radiussq) {
      level.moveplayers = 0;
      robot.overrideactordamage = &robot_damage_none;
      if(target_istarget(self)) {
        target_remove(self);
      }
      attackers = game["attackers"];
      self.fx.team = attackers;
      foreach(player in level.aliveplayers[attackers]) {
        if(isDefined(player.escortingrobot) && player.escortingrobot) {
          scoreevents::processscoreevent("escort_robot_escort_goal", player);
        }
      }
      level.robot recordgameeventnonplayer("robot_reached_objective");
      setgameendtime(0);
      robot ai::set_ignoreme(1);
      robot thread explode_robot_after_wait(1);
      globallogic_score::giveteamscoreforobjective(attackers, 1);
      level thread globallogic::endgame(attackers, game["strings"][attackers + "_mission_accomplished"]);
      return;
    }
    wait(0.05);
  }
}

function explode_robot_after_wait(wait_time) {
  robot = self;
  wait(wait_time);
  if(isDefined(robot)) {
    robot explode_robot();
  }
}

function kill_anything_blocking_goal(goal) {
  self endon("end_kill_anything");
  self.disablefinalkillcam = 1;
  dirtogoal = vectornormalize(goal - self.origin);
  atleastonedestroyed = 0;
  bestcandidate = undefined;
  bestcandidatedot = -1E+09;
  debug_draw_blocked_path_kill_radius(self.origin, 108);
  entities = getdamageableentarray(self.origin, 108);
  foreach(entity in entities) {
    if(isPlayer(entity)) {
      continue;
    }
    if(entity == self) {
      continue;
    }
    if(entity.classname == "grenade") {
      continue;
    }
    if(!isalive(entity)) {
      continue;
    }
    entitydot = vectordot(dirtogoal, entity.origin - self.origin);
    if(entitydot > bestcandidatedot) {
      bestcandidate = entity;
      bestcandidatedot = entitydot;
    }
  }
  if(isDefined(bestcandidate)) {
    entity = bestcandidate;
    if(isDefined(entity.targetname)) {
      if(entity.targetname == "talon") {
        entity notify("death");
        return 1;
      }
    }
    if(isDefined(entity.helitype) && entity.helitype == "qrdrone") {
      watcher = entity.owner weaponobjects::getweaponobjectwatcher("qrdrone");
      watcher thread weaponobjects::waitanddetonate(entity, 0, undefined);
      return 1;
    }
    if(entity.classname == "auto_turret") {
      if(!isDefined(entity.damagedtodeath) || !entity.damagedtodeath) {
        entity util::domaxdamage(self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
      }
      return 1;
    }
    if(isvehicle(entity) && (!isDefined(entity.team) || entity.team != "neutral")) {
      entity kill();
      return 1;
    }
    entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
    atleastonedestroyed = 1;
  }
  atleastonedestroyed = atleastonedestroyed || self destroy_supply_crate_blocking_goal(dirtogoal);
  return atleastonedestroyed;
}

function destroy_supply_crate_blocking_goal(dirtogoal) {
  crates = getEntArray("care_package", "script_noteworthy");
  bestcrate = undefined;
  bestcrateedot = -1E+09;
  foreach(crate in crates) {
    if(distancesquared(crate.origin, self.origin) > (108 * 108)) {
      continue;
    }
    cratedot = vectordot(dirtogoal, crate.origin - self.origin);
    if(cratedot > bestcrateedot) {
      bestcrate = crate;
      bestcrateedot = cratedot;
    }
  }
  if(isDefined(bestcrate)) {
    playFX(level._supply_drop_explosion_fx, bestcrate.origin);
    playsoundatposition("wpn_grenade_explode", bestcrate.origin);
    wait(0.1);
    bestcrate supplydrop::cratedelete();
    return true;
  }
  return false;
}