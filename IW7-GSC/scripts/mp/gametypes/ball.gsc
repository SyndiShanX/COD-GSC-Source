/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ball.gsc
*****************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 20);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 5);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 2);
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 1, 0, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 0);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
  }

  level.carrierarmor = 100;
  updategametypedvars();
  level.teambased = 1;
  level.objectivebased = 0;
  level.var_112BF = 0;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onspawnplayer = ::onspawnplayer;
  level.spawnnodetype = "mp_ball_spawn";
  level.ballreset = 1;
  level.scorefrozenuntil = 0;
  level.ballpickupscorefrozen = 0;
  if(level.matchrules_damagemultiplier) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "uplink";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["drone_reset"] = "ul_obj_respawned";
  game["dialog"]["you_own_drone"] = "ally_own_drone";
  game["dialog"]["ally_own_drone"] = "ally_own_drone";
  game["dialog"]["enemy_own_drone"] = "enemy_own_drone";
  game["dialog"]["ally_throw_score"] = "ally_throw_score";
  game["dialog"]["ally_carry_score"] = "ally_carry_score";
  game["dialog"]["enemy_throw_score"] = "enemy_throw_score";
  game["dialog"]["enemy_carry_score"] = "enemy_carry_score";
  game["dialog"]["pass_complete"] = "friendly_pass";
  game["dialog"]["pass_intercepted"] = "pass_intercepted";
  game["dialog"]["ally_drop_drone"] = "ally_drop_drone";
  game["dialog"]["enemy_drop_drone"] = "enemy_drop_drone";
  game["dialog"]["ally_drone_half"] = "halfway_enemy";
  game["dialog"]["enemy_drone_half"] = "halfway_friendly";
  game["dialog"]["offense_obj"] = "capture_obj";
  game["dialog"]["defense_obj"] = "capture_obj";
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_ball_scoreCarry", getmatchrulesdata("ballData", "scoreCarry"));
  setdynamicdvar("scr_ball_scoreThrow", getmatchrulesdata("ballData", "scoreThrow"));
  setdynamicdvar("scr_ball_satelliteCount", getmatchrulesdata("ballData", "satelliteCount"));
  setdynamicdvar("scr_ball_practiceMode", getmatchrulesdata("ballData", "practiceMode"));
  setdynamicdvar("scr_ball_possessionResetCondition", getmatchrulesdata("ballCommonData", "possessionResetCondition"));
  setdynamicdvar("scr_ball_possessionResetTime", getmatchrulesdata("ballCommonData", "possessionResetTime"));
  setdynamicdvar("scr_ball_idleResetTime", getmatchrulesdata("ballCommonData", "idleResetTime"));
  setdynamicdvar("scr_ball_explodeOnExpire", getmatchrulesdata("ballCommonData", "explodeOnExpire"));
  setdynamicdvar("scr_ball_armorMod", getmatchrulesdata("ballCommonData", "armorMod"));
  setdynamicdvar("scr_ball_showEnemyCarrier", getmatchrulesdata("ballCommonData", "showEnemyCarrier"));
  setdynamicdvar("scr_ball_promode", 0);
}

onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_uplink_ball_pickedup_enemy";
  game["bomb_recovered_sound"] = "mp_uplink_ball_pickedup_friendly";
}

onstartgametype() {
  var_0 = scripts\mp\utility::inovertime();
  var_1 = game["overtimeRoundsPlayed"] == 0;
  var_2 = scripts\mp\utility::istimetobeatvalid();
  if(var_0) {
    if(var_1) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var_2) {
      setomnvar("ui_round_hint_override_attackers", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["attackers"], 2, 3));
      setomnvar("ui_round_hint_override_defenders", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["defenders"], 2, 3));
    } else {
      setomnvar("ui_round_hint_override_attackers", 4);
      setomnvar("ui_round_hint_override_defenders", 4);
    }
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_3 = game["attackers"];
    var_4 = game["defenders"];
    game["attackers"] = var_4;
    game["defenders"] = var_3;
  }

  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_BALL");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_BALL");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_BALL");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_BALL");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_BALL_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_BALL_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_BALL_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_BALL_HINT");
  setclientnamemode("auto_change");
  scripts\mp\gametypes\obj_ball::ball_default_origins();
  var_5[0] = level.gametype;
  var_5[1] = "dom";
  var_5[2] = "ball";
  scripts\mp\gameobjects::main(var_5);
  level thread run_ball();
  level thread onplayerconnect();
  if(level.possessionresetcondition != 0) {
    scripts\mp\gametypes\obj_ball::initballtimer();
  }
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.scorecarry = scripts\mp\utility::dvarintvalue("scoreCarry", 2, 1, 9);
  level.scorethrow = scripts\mp\utility::dvarintvalue("scoreThrow", 1, 1, 9);
  level.satellitecount = scripts\mp\utility::dvarintvalue("satelliteCount", 1, 1, 5);
  level.practicemode = scripts\mp\utility::dvarintvalue("practiceMode", 0, 0, 1);
  level.possessionresetcondition = scripts\mp\utility::dvarintvalue("possessionResetCondition", 0, 0, 2);
  level.possessionresettime = scripts\mp\utility::dvarfloatvalue("possessionResetTime", 0, 0, 150);
  level.explodeonexpire = scripts\mp\utility::dvarintvalue("explodeOnExpire", 0, 0, 1);
  level.idleresettime = scripts\mp\utility::dvarfloatvalue("idleResetTime", 15, 0, 60);
  level.armormod = scripts\mp\utility::dvarfloatvalue("armorMod", 1, 0, 2);
  level.showenemycarrier = scripts\mp\utility::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.carrierarmor = int(level.carrierarmor * level.armormod);
}

ball_goal_useobject() {
  foreach(var_2, var_1 in level.ball_goals) {
    var_1.trigger = spawn("trigger_radius", var_1.origin - (0, 0, var_1.fgetarg), 0, var_1.fgetarg, var_1.fgetarg * 2);
    var_1.useobject = scripts\mp\gameobjects::createuseobject(var_2, var_1.trigger, [], (0, 0, var_1.fgetarg * 2.1));
    var_1.useobject.objective_icon = var_1;
    var_1.useobject scripts\mp\gameobjects::set2dicon("friendly", "waypoint_blitz_defend");
    var_1.useobject scripts\mp\gameobjects::set2dicon("enemy", "waypoint_blitz_goal");
    var_1.useobject scripts\mp\gameobjects::set3dicon("friendly", "waypoint_blitz_defend");
    var_1.useobject scripts\mp\gameobjects::set3dicon("enemy", "waypoint_blitz_goal");
    var_1.useobject scripts\mp\gameobjects::setvisibleteam("any");
    var_1.useobject scripts\mp\gameobjects::allowuse("enemy");
    var_1.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
    var_1.useobject scripts\mp\gameobjects::setusetime(0);
    var_1.useobject scripts\mp\gameobjects::cancontestclaim(1);
    var_1.useobject.onuse = ::ball_carrier_touched_goal;
    var_1.useobject.canuseobject = ::ball_goal_can_use;
    var_1.useobject.oncontested = ::ball_goal_contested;
    var_1.useobject.onuncontested = ::ball_goal_uncontested;
    var_1.killcament = spawn("script_model", var_1.origin + (0, 0, 20));
    var_1.killcament setscriptmoverkillcam("explosive");
  }
}

ball_get_path_dist(var_0, var_1) {
  if(scripts\mp\spawnlogic::ispathdataavailable()) {
    var_2 = getpathdist(var_0, var_1, 999999);
    if(isDefined(var_2) && var_2 >= 0) {
      return var_2;
    }
  }

  return distance(var_0, var_1);
}

ball_goal_fx() {
  foreach(var_1 in level.ball_goals) {
    var_1.score_fx["friendly"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_friendly"), var_1.origin, (1, 0, 0));
    var_1.score_fx["enemy"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_enemy"), var_1.origin, (1, 0, 0));
  }

  level thread ball_play_fx_joined_team();
  foreach(var_4 in level.players) {
    ball_goal_fx_for_player(var_4);
  }

  thread goal_watch_game_ended();
}

onplayerconnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    thread onplayerspawned(var_0);
    if(scripts\mp\utility::istrue(level.practicemode) && var_0 ishost()) {
      var_0 thread scripts\mp\gametypes\obj_ball::practicenotify();
      var_0 thread scripts\mp\gametypes\obj_ball::moveballtoplayer();
    }
  }
}

onplayerspawned(var_0) {
  var_0 waittill("spawned");
  var_0 scripts\mp\utility::setextrascore0(0);
  if(isDefined(var_0.pers["touchdowns"])) {
    var_0 scripts\mp\utility::setextrascore0(var_0.pers["touchdowns"]);
  }

  var_0 scripts\mp\utility::setextrascore1(0);
  if(isDefined(var_0.pers["fieldgoals"])) {
    var_0 scripts\mp\utility::setextrascore1(var_0.pers["fieldgoals"]);
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Uplink");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ball_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ball_spawn_axis_start");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_secondary");
  var_2 = assignteamspawns(var_0);
  var_3 = assignteamspawns(var_1);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var_2["allies"]);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var_3["allies"], 1);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var_2["axis"]);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var_3["axis"], 1);
}

assignteamspawns(var_0) {
  var_1 = [];
  var_1["allies"] = [];
  var_1["axis"] = [];
  if(!isDefined(level.maxspawndisttohomebase)) {
    level.maxspawndisttohomebase = [];
    level.maxspawndisttohomebase["allies"] = 0;
    level.maxspawndisttohomebase["axis"] = 0;
  }

  var_2 = level.ball_goals["allies"].origin;
  var_3 = level.ball_goals["axis"].origin;
  foreach(var_5 in var_0) {
    var_6 = getspawnpointdist(var_5, var_2);
    var_7 = getspawnpointdist(var_5, var_3);
    var_5.disttohomebase = [];
    var_5.disttohomebase["allies"] = var_6;
    var_5.disttohomebase["axis"] = var_7;
    var_8 = max(var_6, var_7);
    var_9 = min(var_6, var_7);
    if(abs(var_8 - var_9) / var_8 < 0.2) {
      var_1["allies"][var_1["allies"].size] = var_5;
      var_1["axis"][var_1["axis"].size] = var_5;
    } else if(var_7 < var_6) {
      var_1["axis"][var_1["axis"].size] = var_5;
    } else {
      var_1["allies"][var_1["allies"].size] = var_5;
    }

    if(var_6 > level.maxspawndisttohomebase["allies"]) {
      level.maxspawndisttohomebase["allies"] = var_6;
    }

    if(var_7 > level.maxspawndisttohomebase["axis"]) {
      level.maxspawndisttohomebase["axis"] = var_7;
    }
  }

  return var_1;
}

getspawnpointdist(var_0, var_1) {
  var_2 = getpathdist(var_0.origin, var_1, 16000);
  if(var_2 < 0) {
    var_2 = distance(var_0.origin, var_1);
  }

  return var_2;
}

getspawnpoint() {
  var_0 = self.pers["team"];
  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["switchedsides"]) {
      var_0 = scripts\mp\utility::getotherteam(var_0);
    }

    var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_2);
    var_3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_1);
    var_4 = [];
    var_5["homeBaseTeam"] = var_0;
    var_5["maxDistToHomeBase"] = level.maxspawndisttohomebase[var_0];
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_3, var_5);
  }

  return var_2;
}

run_ball() {
  level.ball_starts = [];
  level.balls = [];
  level.ballbases = [];
  scripts\mp\utility::func_98D3();
  ball_create_team_goal("allies");
  ball_create_team_goal("axis");
  level._effect["ball_trail"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_trail.vfx");
  level._effect["ball_idle"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_idle.vfx");
  level._effect["ball_download_end"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_download_end.vfx");
  level._effect["ball_goal_enemy"] = loadfx("vfx\core\mp\core\vfx_uplink_goal_orng.vfx");
  level._effect["ball_goal_friendly"] = loadfx("vfx\core\mp\core\vfx_uplink_goal_cyan.vfx");
  level._effect["ball_goal_activated_enemy"] = loadfx("vfx\core\mp\core\vfx_uplink_goal_actv_orng.vfx");
  level._effect["ball_goal_activated_friendly"] = loadfx("vfx\core\mp\core\vfx_uplink_goal_actv_cyan.vfx");
  level._effect["ball_teleport"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_teleport.vfx");
  level thread ball_connect_watch();
  scripts\mp\gametypes\obj_ball::ball_init_map_min_max();
  scripts\mp\gametypes\obj_ball::ball_create_ball_starts();
  for(var_0 = 0; var_0 < level.satellitecount; var_0++) {
    scripts\mp\gametypes\obj_ball::ball_spawn(var_0);
  }

  thread scripts\mp\gametypes\obj_ball::hideballsongameended();
  ball_goal_useobject();
  ball_goal_fx();
  initspawns();
  thread removeuplinkgoal();
  thread placeuplinkgoal();
  level.ball = level.balls[0];
}

ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\common\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

ball_create_team_goal(var_0) {
  var_1 = var_0;
  if(game["switchedsides"]) {
    var_1 = scripts\mp\utility::getotherteam(var_1);
  }

  var_2 = scripts\engine\utility::getstruct("ball_goal_" + var_1, "targetname");
  if(isDefined(var_2)) {
    var_2 = checkpostshipgoalplacement(var_2, var_0);
    var_2 ball_find_ground();
  } else {
    var_2 = spawnStruct();
    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_2.origin)) {
      var_2.origin = level.default_goal_origins[var_0];
    }

    var_2 ball_find_ground();
  }

  if(scripts\mp\utility::istrue(level.tactical)) {
    var_2.origin = var_2.ground_origin + (0, 0, 130);
  } else if(scripts\mp\utility::istrue(level.supportdoublejump_MAYBE)) {
    if(level.mapname == "mp_frontier") {
      var_2.origin = var_2.ground_origin + (0, 0, 180);
    } else {
      var_2.origin = var_2.ground_origin + (0, 0, 190);
    }
  } else {
    var_2.origin = var_2.ground_origin + (0, 0, 130);
  }

  var_2.fgetarg = 60;
  var_2.team = var_0;
  var_2.ball_in_goal = 0;
  var_2.highestspawndistratio = 0;
  level.ball_goals[var_0] = var_2;
}

checkpostshipgoalplacement(var_0, var_1) {
  if(level.mapname == "mp_desert") {
    var_2 = (2125, 71, 370.344);
    if(!game["switchedsides"] && var_1 == "axis") {
      var_0.origin = var_2;
    } else if(game["switchedsides"] && var_1 == "allies") {
      var_0.origin = var_2;
    }
  }

  if(level.mapname == "mp_metropolis") {
    if(!game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (-2039, -1464, 123);
    } else if(game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (-2039, -1464, 123);
    }
  }

  if(level.mapname == "mp_fallen") {
    if(!game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (2752, 1429, 988);
    } else if(game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (2752, 1429, 988);
    }

    if(!game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (-1866, 1698, 988);
    } else if(game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (-1866, 1698, 988);
    }
  }

  return var_0;
}

ball_connect_watch() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread scripts\mp\gametypes\obj_ball::ball_player_on_connect();
  }
}

ball_physics_touch_goal() {
  var_0 = self.visuals[0];
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");
  if(level.gametype != "tdef") {
    ball_touch_goal_watch(var_0);
  }
}

ball_pass_touch_goal() {
  var_0 = self.visuals[0];
  self endon("pass_end");
  if(level.gametype != "tdef") {
    ball_touch_goal_watch(var_0);
  }
}

ball_touch_goal_watch(var_0) {
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");
  for(;;) {
    foreach(var_5, var_2 in level.ball_goals) {
      if(self.lastcarrierteam == var_5) {
        continue;
      }

      if(!var_2.useobject ball_goal_can_use()) {
        continue;
      }

      var_3 = distance(var_0.origin, var_2.origin);
      if(var_3 <= var_2.fgetarg) {
        thread ball_touched_goal(var_2);
        var_0 notify("pass_end");
        return;
      }

      if(isDefined(var_0.origin_prev)) {
        var_4 = line_interect_sphere(var_0.origin_prev, var_0.origin, var_2.origin, var_2.fgetarg);
        if(var_4) {
          thread ball_touched_goal(var_2);
          var_0 notify("pass_end");
          return;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

ball_goal_can_use(var_0) {
  var_1 = self.objective_icon;
  if(var_1.ball_in_goal) {
    return 0;
  }

  return 1;
}

ball_goal_contested() {
  ball_waypoint_contest();
}

ball_goal_uncontested(var_0) {
  goal_waypoint();
}

ball_carrier_touched_goal(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.carryobject)) {
    return;
  }

  if(isDefined(level.scorefrozenuntil) && level.scorefrozenuntil > gettime()) {
    return;
  }

  if(istimeup()) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var_0 notify("goal_scored");
  var_1 = level.scorecarry;
  var_0 thread scripts\mp\awards::givemidmatchaward("mode_uplink_dunk");
  ball_check_assist(var_0, 1);
  var_0 scripts\mp\utility::incperstat("touchdowns", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "touchdowns", var_0.pers["touchdowns"]);
  if(isplayer(var_0)) {
    var_0 scripts\mp\utility::setextrascore0(var_0.pers["touchdowns"]);
    var_0 thread scripts\mp\matchdata::loggameevent("dunk", var_0.origin);
  }

  var_2 = self.objective_icon.team;
  var_3 = scripts\mp\utility::getotherteam(var_2);
  scripts\mp\utility::statusdialog("enemy_carry_score", var_2, 1);
  scripts\mp\utility::statusdialog("ally_carry_score", var_3, 1);
  ball_play_score_fx(self.objective_icon);
  ball_score_sound(var_3, 1);
  var_4 = var_0.carryobject;
  var_4.lastcarrierscored = 1;
  var_4 scripts\mp\gametypes\obj_ball::ball_set_dropped(1, self.trigger.origin, 1);
  var_4 thread ball_score_event(self.objective_icon);
  ball_give_score(var_3, var_1);
  scripts\mp\utility::setmlgannouncement(1, var_3, var_0 getentitynumber());
}

should_record_final_score_cam(var_0, var_1) {
  var_2 = scripts\mp\gamescore::_getteamscore(var_0);
  var_3 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility::getotherteam(var_0));
  return var_2 + var_1 >= var_3;
}

line_interect_sphere(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = vectordot(var_4, var_0 - var_2);
  var_5 = var_5 * var_5;
  var_6 = var_0 - var_2;
  var_6 = var_6 * var_6;
  var_7 = var_3 * var_3;
  return var_5 - var_6 + var_7 >= 0;
}

ball_touched_goal(var_0) {
  if(isDefined(level.scorefrozenuntil) && level.scorefrozenuntil > gettime()) {
    return;
  }

  if(istimeup()) {
    return;
  }

  if(level.gameended) {
    return;
  }

  ball_play_score_fx(var_0);
  var_1 = level.scorethrow;
  var_2 = var_0.team;
  var_3 = scripts\mp\utility::getotherteam(var_2);
  scripts\mp\utility::statusdialog("enemy_throw_score", var_2, 1);
  scripts\mp\utility::statusdialog("ally_throw_score", var_3, 1);
  if(isDefined(self.lastcarrier)) {
    self.lastcarrierscored = 1;
    self.lastcarrier thread scripts\mp\awards::givemidmatchaward("mode_uplink_fieldgoal");
    ball_check_assist(self.lastcarrier, 0);
    self.lastcarrier scripts\mp\utility::incperstat("fieldgoals", 1);
    self.lastcarrier scripts\mp\persistence::statsetchild("round", "fieldgoals", self.lastcarrier.pers["fieldgoals"]);
    if(isplayer(self.lastcarrier)) {
      self.lastcarrier scripts\mp\utility::setextrascore1(self.lastcarrier.pers["fieldgoals"]);
      self.lastcarrier thread scripts\mp\matchdata::loggameevent("fieldgoal", self.lastcarrier.origin);
    }
  }

  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }

  ball_score_sound(var_3, 0);
  thread ball_score_event(var_0);
  ball_give_score(var_3, var_1);
  if(isDefined(self.lastcarrier)) {
    scripts\mp\utility::setmlgannouncement(0, var_3, self.lastcarrier getentitynumber());
    return;
  }

  scripts\mp\utility::setmlgannouncement(0, var_3);
}

istimeup() {
  var_0 = scripts\mp\utility::getwatcheddvar("timelimit");
  if(var_0 != 0) {
    var_1 = scripts\mp\gamelogic::gettimeremaining();
    if(var_1 <= 0) {
      return 1;
    }
  }

  return 0;
}

ball_give_score(var_0, var_1) {
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_1, 0);
}

ball_score_event(var_0) {
  level thread scorefrozentimer();
  self notify("score_event");
  if(scripts\mp\utility::istrue(level.practicemode)) {
    foreach(var_2 in level.players) {
      if(var_2 ishost()) {
        var_2 thread scripts\mp\gametypes\obj_ball::moveballtoplayer();
        break;
      }
    }
  }

  self.in_goal = 1;
  var_0.ball_in_goal = 1;
  var_4 = self.visuals[0];
  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var_4 physicslaunchserver(var_4.origin, (0, 0, 0));
  var_4 physicsstopserver();
  scripts\mp\gameobjects::allowcarry("none");
  scripts\mp\gametypes\obj_ball::ball_waypoint_upload();
  var_5 = 0.4;
  var_6 = 1.2;
  var_7 = 1;
  var_8 = var_5 + var_7;
  var_9 = var_8 + var_6;
  var_4 moveto(var_0.origin, var_5, 0, var_5);
  var_4 rotatevelocity((1080, 1080, 0), var_9, var_9, 0);
  wait(var_8);
  var_4 movez(4000, var_6, var_6 * 0.1, 0);
  wait(var_6);
  var_0.ball_in_goal = 0;
  scripts\mp\gametypes\obj_ball::ball_return_home(0, 0);
}

ball_check_assist(var_0, var_1) {
  if(!isDefined(var_0.passtime) || !isDefined(var_0.passplayer)) {
    return;
  }

  if(var_0.passtime + 3000 < gettime()) {
    return;
  }

  if(var_1) {
    var_0.passplayer thread scripts\mp\awards::givemidmatchaward("mode_uplink_allyoop");
  }
}

ball_play_score_fx(var_0) {
  var_0.score_fx["friendly"] hide();
  var_0.score_fx["enemy"] hide();
  foreach(var_2 in level.players) {
    var_3 = ball_get_view_team(var_2);
    if(var_3 == var_0.team) {
      var_0.score_fx["friendly"] showtoplayer(var_2);
      continue;
    }

    var_0.score_fx["enemy"] showtoplayer(var_2);
  }

  triggerfx(var_0.score_fx["friendly"]);
  triggerfx(var_0.score_fx["enemy"]);
}

ball_waypoint_reset() {
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_reset_marker");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_reset_marker");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_reset_marker");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_reset_marker");
}

ball_waypoint_contest() {
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_uplink_contested");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_uplink_contested");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_uplink_contested");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_uplink_contested");
}

goal_waypoint() {
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_blitz_defend");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_blitz_goal");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_blitz_defend");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_blitz_goal");
}

ball_score_sound(var_0, var_1) {
  if(var_1) {
    scripts\mp\gametypes\obj_ball::ball_play_local_team_sound(var_0, "mp_uplink_goal_carried_friendly", "mp_uplink_goal_carried_enemy");
    return;
  }

  scripts\mp\gametypes\obj_ball::ball_play_local_team_sound(var_0, "mp_uplink_goal_friendly", "mp_uplink_goal_enemy");
}

scorefrozentimer() {
  level endon("game_ended");
  level.scorefrozenuntil = gettime() + 10000;
  foreach(var_1 in level.ball_goals) {
    var_1 thread dogoalreset();
  }
}

dogoalreset() {
  self.useobject ball_waypoint_reset();
  level scripts\engine\utility::waittill_any_timeout_1(10, "goal_ready");
  self.useobject goal_waypoint();
}

ball_on_connect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.ball_goal_fx = [];
    var_0 thread player_on_disconnect();
  }
}

player_on_disconnect() {
  self waittill("disconnect");
  player_delete_ball_goal_fx();
}

ball_goal_fx_for_player(var_0) {
  var_1 = ball_get_view_team(var_0);
  var_0 player_delete_ball_goal_fx();
  foreach(var_6, var_3 in level.ball_goals) {
    var_4 = scripts\engine\utility::ter_op(var_6 == var_1, "ball_goal_friendly", "ball_goal_enemy");
    var_5 = spawnfxforclient(scripts\engine\utility::getfx(var_4), var_3.origin, var_0, (1, 0, 0));
    var_5 setfxkilldefondelete();
    var_0.ball_goal_fx[var_4] = var_5;
    triggerfx(var_5);
  }
}

ball_get_view_team(var_0) {
  var_1 = var_0.team;
  if(var_1 != "allies" && var_1 != "axis") {
    if(var_0 ismlgspectator()) {
      var_1 = var_0 getmlgspectatorteam();
    } else {
      var_1 = "allies";
    }
  }

  return var_1;
}

player_delete_ball_goal_fx() {
  if(isDefined(self.ball_goal_fx)) {
    foreach(var_1 in self.ball_goal_fx) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

goal_watch_game_ended() {
  level waittill("bro_shot_start");
  foreach(var_1 in level.players) {
    var_1 player_delete_ball_goal_fx();
  }
}

ball_play_fx_joined_team() {
  for(;;) {
    level waittill("joined_team", var_0);
    ball_goal_fx_for_player(var_0);
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = self;
  var_0B = 0;
  if(!isDefined(var_1) || !isDefined(var_1.team) || !isDefined(var_0A) || !isDefined(var_0A.team)) {
    return;
  }

  if(var_1 == var_0A) {
    return;
  }

  if(var_1.team == var_0A.team) {
    return;
  }

  var_0C = var_1.origin;
  var_0D = 0;
  if(isDefined(var_0)) {
    var_0C = var_0.origin;
    var_0D = var_0 == var_1;
  }

  if(isDefined(var_1) && isplayer(var_1) && var_1.pers["team"] != var_0A.pers["team"]) {
    if(isDefined(var_1.ball_carried) && var_0D) {
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_uplink_kill_with_ball");
      var_0B = 1;
    }

    if(isDefined(var_0A.ball_carried)) {
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_uplink_kill_carrier");
      var_1 scripts\mp\utility::incperstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      thread scripts\mp\matchdata::loginitialstats(var_9, "carrying");
      scripts\mp\gametypes\obj_ball::updatetimers("neutral", 1, 0);
      var_0B = 1;
    }
  }

  if(!var_0B) {
    var_0E = 0;
    foreach(var_10 in level.balls) {
      var_0E = distsquaredcheck(var_0C, var_0A.origin, var_10.curorigin);
      if(var_0E && var_1.team != var_0A.team) {
        if(var_10.ownerteam == var_0A.team) {
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        } else if(var_10.ownerteam == var_1.team) {
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }

        break;
      }
    }

    if(!var_0E) {
      foreach(var_15, var_13 in level.ball_goals) {
        var_14 = distsquaredcheck(var_0C, var_0A.origin, var_13.trigger.origin);
        if(var_14) {
          if(var_15 == var_0A.team) {
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            continue;
          }

          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }
      }
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);
  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  }

  return 0;
}

onspawnplayer() {
  self.teleporting = 0;
}

hidehudelementongameend(var_0) {
  level waittill("game_ended");
  if(isDefined(var_0)) {
    var_0.alpha = 0;
  }
}

removeuplinkgoal() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getdvar("scr_devRemoveDomFlag", "");
      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      level.ball_goals[var_1].useobject scripts\mp\gameobjects::allowuse("none");
      level.ball_goals[var_1].useobject.trigger = undefined;
      level.ball_goals[var_1].useobject notify("deleted");
      foreach(var_3 in level.players) {
        var_3 player_delete_ball_goal_fx();
      }

      level.ball_goals[var_1].useobject.visibleteam = "none";
      level.ball_goals[var_1].useobject scripts\mp\gameobjects::set2dicon("friendly", undefined);
      level.ball_goals[var_1].useobject scripts\mp\gameobjects::set3dicon("friendly", undefined);
      level.ball_goals[var_1].useobject scripts\mp\gameobjects::set2dicon("enemy", undefined);
      level.ball_goals[var_1].useobject scripts\mp\gameobjects::set3dicon("enemy", undefined);
      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait(1);
  }
}

placeuplinkgoal() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getdvar("scr_devPlaceDomFlag", "");
      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      var_2 = spawnStruct();
      var_2.origin = level.players[0].origin;
      var_2.origin = var_2.origin + (0, 0, 190);
      var_2.fgetarg = 50;
      var_2.team = var_1;
      var_2.ball_in_goal = 0;
      var_2.highestspawndistratio = 0;
      level.ball_goals[var_1] = var_2;
      var_2.trigger = spawn("trigger_radius", var_2.origin - (0, 0, var_2.fgetarg), 0, var_2.fgetarg, var_2.fgetarg * 2);
      var_2.useobject = scripts\mp\gameobjects::createuseobject(var_1, var_2.trigger, [], (0, 0, var_2.fgetarg * 2.1));
      var_2.useobject.objective_icon = var_2;
      var_2.useobject scripts\mp\gameobjects::set2dicon("friendly", "waypoint_blitz_defend");
      var_2.useobject scripts\mp\gameobjects::set2dicon("enemy", "waypoint_blitz_goal");
      var_2.useobject scripts\mp\gameobjects::set3dicon("friendly", "waypoint_blitz_defend");
      var_2.useobject scripts\mp\gameobjects::set3dicon("enemy", "waypoint_blitz_goal");
      var_2.useobject scripts\mp\gameobjects::setvisibleteam("any");
      var_2.useobject scripts\mp\gameobjects::allowuse("enemy");
      var_2.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
      var_2.useobject scripts\mp\gameobjects::setusetime(0);
      var_2.useobject scripts\mp\gameobjects::cancontestclaim(1);
      var_2.useobject.onuse = ::ball_carrier_touched_goal;
      var_2.useobject.canuseobject = ::ball_goal_can_use;
      var_2.useobject.oncontested = ::ball_goal_contested;
      var_2.useobject.onuncontested = ::ball_goal_uncontested;
      var_2.killcament = spawn("script_model", var_2.origin + (0, 0, 20));
      var_2.killcament setscriptmoverkillcam("explosive");
      ball_goal_fx();
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}