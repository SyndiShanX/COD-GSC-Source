/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\ball.gsc
**************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 75);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 1);
    setdynamicdvar("scr_ball_num_balls", 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  var_0 = getdvarint("scr_ball_num_balls", 1);
  setomnvar("ui_uplink_num_balls", var_0);
  maps\mp\_utility::setovertimelimitdvar(3);

  if(isDefined(game["round_time_to_beat"])) {
    maps\mp\_utility::setovertimelimitdvar(game["round_time_to_beat"]);
    game["round_time_to_beat"] = undefined;
  }

  level.teambased = 1;
  level.onhalftime = ::onhalftime;
  level.ontimelimit = ::ontimelimit;
  level.halftimeonscorelimit = 1;
  level.overtimescorewinoverride = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.gamemodeonunderwater = ::onunderwater;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["drone_reset"] = "upl_dronereset";
  game["dialog"]["you_own_drone"] = "upl_allyowndrone";
  game["dialog"]["ally_own_drone"] = "upl_friend_holds";
  game["dialog"]["enemy_own_drone"] = "upl_enemyowndrone";
  game["dialog"]["ally_throw_score"] = "upl_uplinksuccess";
  game["dialog"]["ally_carry_score"] = "upl_dronedelievered";
  game["dialog"]["enemy_throw_score"] = "upl_enm_score_remote";
  game["dialog"]["enemy_carry_score"] = "upl_enm_score";
  game["dialog"]["pass_complete"] = "upl_dronetransfered";
  game["dialog"]["pass_intercepted"] = "upl_droneintercepted";
  game["dialog"]["ally_drop_drone"] = "upl_dronedropped";
  game["dialog"]["enemy_drop_drone"] = "upl_dronedropped";
  game["dialog"]["gametype"] = "upl_intro";

  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "upl_deliverdrone";
  game["dialog"]["defense_obj"] = "upl_deliverdrone";

  if(maps\mp\_utility::isgrapplinghookgamemode()) {
    game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
  }

  level thread ball_on_connect();
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_ball_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("ball", 0, 0, 9);
  setdynamicdvar("scr_ball_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("ball", 1);
  setdynamicdvar("scr_ball_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("ball", 1);
  setdynamicdvar("scr_ball_halftime", 1);
  maps\mp\_utility::registerhalftimedvar("ball", 1);
  var_0 = getmatchrulesdata("ballData", "numBalls");
  var_0 = max(1, var_0);
  setdynamicdvar("scr_ball_num_balls", var_0);
  setdynamicdvar("scr_ball_reset_time", getmatchrulesdata("ballData", "ballResetTime"));
  setdynamicdvar("scr_ball_points_touchdown", getmatchrulesdata("ballData", "carryScore"));
  setdynamicdvar("scr_ball_points_fieldgoal", getmatchrulesdata("ballData", "throwScore"));
  setdynamicdvar("scr_ball_armor", getmatchrulesdata("ballData", "armorValue"));
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(game["status"] == "halftime") {
    setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    setomnvar("ui_current_round", 4);
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(maps\mp\_utility::isovertimetext(game["status"])) {
    game["switchedsides"] = !game["switchedsides"];
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(game["status"] == "overtime") {
    game["teamScores"]["allies"] = 0;
    setteamscore("allies", 0);
    game["teamScores"]["axis"] = 0;
    setteamscore("axis", 0);
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_BALL");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_BALL");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_BALL");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_BALL");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_BALL_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_BALL_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_BALL_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_BALL_HINT");
  ball_default_origins();
  var_2[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_2);
  level thread run_ball();
  initspawns();
}

onhalftime(var_0) {
  foreach(var_2 in level.balls) {
    var_2.visuals[0] physicsstop();
  }

  maps\mp\gametypes\_gamelogic::default_onhalftime(var_0);
}

ontimelimit() {
  var_0 = undefined;
  level.finalkillcam_winner = "none";

  foreach(var_2 in level.balls) {
    var_2.visuals[0] physicsstop();
  }

  if(game["status"] == "halftime" || game["status"] == "overtime_halftime") {
    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.finalkillcam_winner = "axis";
      var_0 = "axis";
    } else if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      level.finalkillcam_winner = "allies";
      var_0 = "allies";
    } else if(game["status"] == "halftime") {
      var_0 = "overtime";
    } else if(isDefined(game["ball_overtime_team"])) {
      var_0 = game["ball_overtime_team"];
    } else {
      var_0 = "tie";
    }
  } else if(game["status"] == "overtime") {
    var_0 = "overtime_halftime";
  }

  logstring("time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  level thread maps\mp\gametypes\_gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

initspawns() {
  if(level.script == "mp_refraction") {
    setdvar("scr_disableClientSpawnTraces", "1");
  }

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.allies_start_spawn_name = "mp_ball_spawn_allies_start";
  level.axis_start_spawn_name = "mp_ball_spawn_axis_start";

  if(!getspawnarray(level.allies_start_spawn_name).size) {
    level.allies_start_spawn_name = "mp_dom_spawn_allies_start";
    level.axis_start_spawn_name = "mp_dom_spawn_axis_start";
  }

  maps\mp\gametypes\_spawnlogic::addstartspawnpoints(level.allies_start_spawn_name);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints(level.axis_start_spawn_name);
  level.spawn_name = "mp_ball_spawn";

  if(!getspawnarray(level.spawn_name).size) {
    level.spawn_name = "mp_dom_spawn";
  }

  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", level.spawn_name);
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", level.spawn_name);
  var_0 = level.ball_goals[game["attackers"]].origin;
  var_1 = 0;
  var_2 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.allies_start_spawn_name);

  foreach(var_4 in var_2) {
    var_1 = var_1 + distance(var_4.origin, var_0);
  }

  var_6 = 0;
  var_2 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.axis_start_spawn_name);

  foreach(var_4 in var_2) {
    var_6 = var_6 + distance(var_4.origin, var_0);
  }

  level.start_spawns_near_attackers = var_1 < var_6;
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(level.usestartspawns && level.ingraceperiod) {
    if(game["switchedsides"]) {
      var_0 = maps\mp\_utility::getotherteam(var_0);
    }

    if(!level.start_spawns_near_attackers) {
      var_0 = maps\mp\_utility::getotherteam(var_0);
    }

    var_1 = level.allies_start_spawn_name;

    if(var_0 == "axis") {
      var_1 = level.axis_start_spawn_name;
    }

    var_2 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(var_1);
    var_3 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn(var_2);
  } else {
    var_2 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_3 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_2, var_0);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_3);
  return var_3;
}

onunderwater(var_0) {
  foreach(var_2 in level.balls) {
    if(isDefined(var_2.carrier) && var_2.carrier == self) {
      self.water_last_weapon = maps\mp\gametypes\_gameobjects::getcarrierweaponcurrent(var_2);
      var_2 thread maps\mp\gametypes\_gameobjects::setdropped();
      return;
    }
  }

  if(self getcurrentweapon() == "iw5_carrydrone_mp" && isDefined(self.changingweapon)) {
    self.water_last_weapon = self.changingweapon;
  } else if(isDefined(self.pass_or_throw_active) && self.pass_or_throw_active) {
    var_4 = self getweaponslistprimaries();
    self.water_last_weapon = common_scripts\utility::ter_op(var_4.size, var_4[0], undefined);
  }

  self.balldropdelay = undefined;
}

onnormaldeath(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]]) {
    var_1.finalkill = 1;
  }
}

ball_connect_watch() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread ball_player_on_connect();
    var_0 thread ball_update_extrascore0();
  }
}

ball_player_on_connect() {
  foreach(var_1 in level.balls) {
    var_1 ball_fx_start_player(self);
  }
}

run_ball() {
  level.ball_starts = [];
  level.balls = [];
  var_0 = getdvarint("scr_ball_num_balls", 1);
  ball_create_ball_starts(var_0);
  ball_create_team_goal("allies");
  ball_create_team_goal("axis");
  level._effect["ball_trail"] = loadfx("vfx/trail/vfx_uplink_ball_trl");
  level._effect["ball_idle"] = loadfx("vfx/unique/vfx_uplink_ball_idle");
  level._effect["ball_download"] = loadfx("vfx/trail/vfx_uplink_ball_trl2");
  level._effect["ball_download_end"] = loadfx("vfx/unique/vfx_uplink_ball_impact");
  level._effect["ball_goal_enemy"] = loadfx("vfx/unique/vfx_uplink_goal");
  level._effect["ball_goal_friendly"] = loadfx("vfx/unique/vfx_uplink_goal_friendly");
  level._effect["ball_goal_activated_enemy"] = loadfx("vfx/unique/vfx_uplink_ball_score");
  level._effect["ball_goal_activated_friendly"] = loadfx("vfx/unique/vfx_uplink_ball_score_friendly");
  level._effect["ball_teleport"] = loadfx("vfx/unique/vfx_uplink_ball_glow");
  level._effect["ball_physics_impact"] = loadfx("vfx/treadfx/footstep_dust");
  level thread ball_connect_watch();
  ball_init_map_min_max();

  for(var_1 = 0; var_1 < var_0 && var_1 < level.ball_starts.size; var_1++) {
    ball_spawn(var_1);
  }

  ball_goal_useobject();
  ball_goal_fx();
  maps\mp\_utility::gameflagwait("prematch_done");
  ball_assign_team_spawns();
}

ball_default_origins() {
  level.default_goal_origins = [];
  var_0 = getEntArray("flag_primary", "targetname");

  foreach(var_2 in var_0) {
    switch (var_2.script_label) {
      case "_a":
        level.default_goal_origins[game["attackers"]] = var_2.origin;
        break;
      case "_b":
        level.default_ball_origin = var_2.origin;
        break;
      case "_c":
        level.default_goal_origins[game["defenders"]] = var_2.origin;
        break;
    }
  }
}

ball_init_map_min_max() {
  level.ball_mins = (1000, 1000, 1000);
  level.ball_maxs = (-1000, -1000, -1000);
  var_0 = getallnodes();

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      level.ball_mins = maps\mp\gametypes\_spawnlogic::expandmins(level.ball_mins, var_2.origin);
      level.ball_maxs = maps\mp\gametypes\_spawnlogic::expandmaxs(level.ball_maxs, var_2.origin);
    }
  } else {
    level.ball_mins = level.spawnmins;
    level.ball_maxs = level.spawnmaxs;
  }
}

ball_goal_useobject() {
  foreach(var_2, var_1 in level.ball_goals) {
    var_1.trigger = spawn("trigger_radius", var_1.origin - (0, 0, var_1.radius), 0, var_1.radius, var_1.radius * 2);
    var_1.useobject = maps\mp\gametypes\_gameobjects::createuseobject(var_2, var_1.trigger, [], (0, 0, var_1.radius * 2.1));
    var_1.useobject.goal = var_1;
    var_1.useobject maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_ball_defend");
    var_1.useobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_ball_goal");
    var_1.useobject maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_ball_defend");
    var_1.useobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_ball_goal");

    if(var_2 == "allies") {
      maps\mp\_utility::setmlgicons(var_1.useobject, "waypoint_esports_uplink_blue");
    } else {
      maps\mp\_utility::setmlgicons(var_1.useobject, "waypoint_esports_uplink_red");
    }

    var_1.useobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    var_1.useobject maps\mp\gametypes\_gameobjects::allowuse("enemy");
    var_1.useobject maps\mp\gametypes\_gameobjects::setkeyobject(level.balls);
    var_1.useobject maps\mp\gametypes\_gameobjects::setusetime(0);
    var_1.useobject.onuse = ::ball_carrier_touched_goal;
    var_1.useobject.canuseobject = ::ball_goal_can_use;
    var_1.killcament = spawn("script_model", var_1.origin);
    var_1.killcament setscriptmoverkillcam("large explosive");
  }
}

ball_assign_team_spawns() {
  var_0 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.spawn_name);
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  var_1 = level.ball_goals["allies"].ground_origin;
  var_2 = level.ball_goals["axis"].ground_origin;

  foreach(var_4 in var_0) {
    var_4.teambase = undefined;
    var_5 = ball_get_path_dist(var_1, var_4.origin);
    var_6 = ball_get_path_dist(var_2, var_4.origin);

    if(isDefined(var_4.script_noteworthy)) {
      if(game["switchedsides"] && var_4.script_noteworthy == "axis_override" || !game["switchedsides"] && var_4.script_noteworthy == "allies_override") {
        var_4.teambase = "allies";
        var_4.friendlyflag = level.ball_goals["allies"];
        var_4.friendlyflagdist = var_5;
        var_4.enemyflagdist = var_6;
      } else if(game["switchedsides"] && var_4.script_noteworthy == "allies_override" || !game["switchedsides"] && var_4.script_noteworthy == "axis_override") {
        var_4.teambase = "axis";
        var_4.friendlyflag = level.ball_goals["axis"];
        var_4.friendlyflagdist = var_6;
        var_4.enemyflagdist = var_5;
      }
    }

    if(!isDefined(var_4.teambase)) {
      var_4.teambase = common_scripts\utility::ter_op(var_5 < var_6, "allies", "axis");
      var_4.friendlyflag = common_scripts\utility::ter_op(var_5 < var_6, level.ball_goals["allies"], level.ball_goals["axis"]);
      var_4.friendlyflagdist = common_scripts\utility::ter_op(var_5 < var_6, var_5, var_6);
      var_4.enemyflagdist = common_scripts\utility::ter_op(var_5 > var_6, var_5, var_6);
    }

    var_7 = var_4.friendlyflagdist / var_4.enemyflagdist;

    if(var_4.friendlyflag.highestspawndistratio < var_7) {
      var_4.friendlyflag.highestspawndistratio = var_7;
    }

    level.teamspawnpoints[var_4.teambase][level.teamspawnpoints[var_4.teambase].size] = var_4;
  }
}

ball_get_path_dist(var_0, var_1) {
  if(maps\mp\gametypes\_spawnlogic::ispathdataavailable()) {
    var_2 = getpathdist(var_0, var_1, 999999);

    if(isDefined(var_2) && var_2 >= 0) {
      return var_2;
    }
  }

  return distance(var_0, var_1);
}

ball_goal_fx() {
  foreach(var_2, var_1 in level.ball_goals) {
    var_1.score_fx["friendly"] = spawnfx(common_scripts\utility::getfx("ball_goal_activated_friendly"), var_1.origin, (1, 0, 0));
    var_1.score_fx["enemy"] = spawnfx(common_scripts\utility::getfx("ball_goal_activated_enemy"), var_1.origin, (1, 0, 0));
  }

  level thread ball_play_fx_joined_team();

  foreach(var_4 in level.players) {
    ball_goal_fx_for_player(var_4);
  }
}

ball_spawn(var_0) {
  var_1 = level.ball_starts[var_0];
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("prop_drone_sphere");
  var_2 thread physics_impact_watch();
  var_3 = 24;
  var_4 = getent("ball_pickup_" + (var_0 + 1), "targetname");

  if(isDefined(var_4)) {
    var_4.origin = var_2.origin;
  } else {
    var_4 = spawn("trigger_radius", var_2.origin - (0, 0, var_3 / 2), 0, var_3, var_3);
  }

  var_4 enablelinkto();
  var_4 linkto(var_2);
  var_4.no_moving_platfrom_unlink = 1;
  var_5 = [var_2];
  var_6 = maps\mp\gametypes\_gameobjects::createcarryobject("any", var_4, var_5, (0, 0, 32));
  var_6.objectiveonvisuals = 1;
  var_6 maps\mp\gametypes\_gameobjects::allowcarry("any");
  var_6 ball_waypoint_neutral();
  var_6 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
  var_6.objidpingenemy = 1;
  var_6.objpingdelay = 1.0;
  var_6.allowweapons = 0;
  var_6.carryweapon = "iw5_carrydrone_mp";
  var_6.keepcarryweapon = 1;
  var_6.waterbadtrigger = 0;
  var_6.visualgroundoffset = (0, 0, 30);
  var_6.canuseobject = ::ball_can_pickup;
  var_6.onpickup = ::ball_on_pickup;
  var_6.setdropped = ::ball_set_dropped;
  var_6.onreset = ::ball_on_reset;
  var_6.carryweaponthink = ::ball_pass_or_shoot;
  var_6.in_goal = 0;
  var_6.lastcarrierscored = 0;
  var_6.requireslos = 1;
  var_6 ball_assign_start(var_1);
  level.balls[level.balls.size] = var_6;
  var_6 ball_fx_start();
  var_6 thread ball_location_hud(var_0);
  setomnvar("ui_mlg_game_mode_status_1", -1);
  setomnvar("ui_mlg_game_mode_status_2", -1);
  setomnvar("ui_mlg_game_mode_status_3", 3);
}

physics_impact_watch() {
  self endon("death");

  for(;;) {
    self waittill("physics_impact", var_0, var_1, var_2, var_3);
    var_4 = level._effect["ball_physics_impact"];

    if(isDefined(var_3) && isDefined(level._effect["ball_physics_impact_" + var_3])) {
      var_4 = level._effect["ball_physics_impact_" + var_3];
    }

    playFX(var_4, var_0, var_1);
    wait 0.3;
  }
}

ball_location_hud(var_0) {
  if(var_0 > 4 || var_0 < 0) {
    return;
  }
  for(;;) {
    var_1 = common_scripts\utility::waittill_any_return("pickup_object", "dropped", "reset");

    switch (var_1) {
      case "pickup_object":
        setomnvar("ui_uplink_ball_carrier" + (var_0 + 1), self.carrier getentitynumber());
        break;
      case "dropped":
        setomnvar("ui_uplink_ball_carrier" + (var_0 + 1), -2);
        break;
      case "reset":
        setomnvar("ui_uplink_ball_carrier" + (var_0 + 1), -1);
        break;
      default:
        break;
    }
  }
}

ball_waypoint_neutral() {
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_ball");
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_ball");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_ball");
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_ball");
  maps\mp\_utility::setmlgicons(self, "waypoint_esports_uplink_ball_white");
}

ball_waypoint_held() {
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_ball_friendly");
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_ball_enemy");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_ball_friendly");
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_ball_enemy");

  if(self.ownerteam == "allies") {
    maps\mp\_utility::setmlgicons(self, "waypoint_esports_uplink_ball_blue");
  } else {
    maps\mp\_utility::setmlgicons(self, "waypoint_esports_uplink_ball_red");
  }
}

ball_waypoint_download() {
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_ball_download");
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_ball_download");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_ball_download");
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_ball_download");
  maps\mp\_utility::setmlgicons(self, "waypoint_esports_uplink_ball_white");
}

ball_waypoint_upload() {
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_ball_upload");
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_ball_upload");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_ball_upload");
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_ball_upload");
  maps\mp\_utility::setmlgicons(self, "waypoint_esports_uplink_ball_white");
}

ball_dont_interpolate() {
  self.visuals[0] dontinterpolate();
  self.ball_fx_active = 0;
}

ball_fx_start() {
  if(!ball_fx_active()) {
    var_0 = self.visuals[0];
    playFXOnTag(common_scripts\utility::getfx("ball_trail"), var_0, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("ball_idle"), var_0, "tag_origin");
    self.ball_fx_active = 1;
  }
}

ball_fx_start_player(var_0) {
  if(ball_fx_active()) {
    var_1 = self.visuals[0];
    playfxontagforclients(common_scripts\utility::getfx("ball_trail"), var_1, "tag_origin", var_0);
    playfxontagforclients(common_scripts\utility::getfx("ball_idle"), var_1, "tag_origin", var_0);
  }
}

ball_fx_stop() {
  if(ball_fx_active()) {
    var_0 = self.visuals[0];
    stopFXOnTag(common_scripts\utility::getfx("ball_trail"), var_0, "tag_origin");
    killfxontag(common_scripts\utility::getfx("ball_idle"), var_0, "tag_origin");
  }

  self.ball_fx_active = 0;
}

ball_fx_active() {
  return isDefined(self.ball_fx_active) && self.ball_fx_active;
}

ball_pass_or_shoot() {
  self endon("disconnect");
  thread ball_pass_watch();
  thread ball_shoot_watch();
  self.carryobject waittill("dropped");
}

ball_pass_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  for(;;) {
    self waittill("ball_pass", var_0);

    if(var_0 != "iw5_carrydrone_mp") {
      continue;
    }
    if(!isDefined(self.pass_target)) {
      self iprintlnbold("No Pass Target");
      continue;
    }

    break;
  }

  if(isDefined(self.carryobject)) {
    thread ball_pass_or_throw_active();
    var_1 = self.pass_target;
    var_2 = self.pass_target.origin;
    wait 0.15;

    if(isDefined(self.pass_target)) {
      var_1 = self.pass_target;
    }

    self.carryobject thread ball_pass_projectile(self, var_1, var_2);
  }
}

ball_pass_projectile(var_0, var_1, var_2) {
  ball_set_dropped(1);

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
  }

  var_3 = (0, 0, 40);
  var_4 = vectornormalize(var_2 + var_3 - self.visuals[0].origin);
  var_5 = var_4 * 1000;
  self.projectile = magicgrenademanual("gamemode_ball", self.visuals[0].origin, var_5, 30, var_0, 1);

  if(isDefined(var_1)) {
    self.projectile missile_settargetent(var_1);
  }

  self.visuals[0] linkto(self.projectile);
  ball_dont_interpolate();
  ball_create_killcam_ent();
  ball_clear_contents();
  thread ball_on_projectile_hit_client();
  thread ball_on_projectile_death();
  thread ball_pass_touch_goal();
}

ball_create_killcam_ent() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self.killcament = spawn("script_model", self.visuals[0].origin);
  self.killcament linkto(self.visuals[0]);
  self.killcament setcontents(0);
  self.killcament setscriptmoverkillcam("explosive");
}

ball_clear_contents() {
  self.visuals[0].old_contents = self.visuals[0] setcontents(0);
}

ball_restore_contents() {
  if(isDefined(self.visuals[0].old_contents)) {
    self.visuals[0] setcontents(self.visuals[0].old_contents);
    self.visuals[0].old_contents = undefined;
  }
}

ball_on_projectile_hit_client() {
  self endon("pass_end");
  self.projectile waittill("projectile_impact_player", var_0);
  self.trigger notify("trigger", var_0);
}

ball_on_projectile_death() {
  self.projectile waittill("death");
  var_0 = self.visuals[0];

  if(!isDefined(self.carrier) && !self.in_goal) {
    if(var_0.origin != var_0.baseorigin + (0, 0, 4000)) {
      ball_physics_launch((0, 0, 10));
    }
  }

  ball_restore_contents();
  var_0 notify("pass_end");
}

ball_shoot_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  var_0 = getdvarfloat("scr_ball_shoot_extra_pitch", -12);
  var_1 = getdvarfloat("scr_ball_shoot_force", 320);

  for(;;) {
    self waittill("weapon_fired", var_2);

    if(var_2 != "iw5_carrydrone_mp") {
      continue;
    }
    break;
  }

  if(isDefined(self.carryobject)) {
    var_3 = self getangles();
    var_3 = var_3 + (var_0, 0, 0);
    var_3 = (clamp(var_3[0], -85, 85), var_3[1], var_3[2]);
    var_4 = anglesToForward(var_3);
    thread ball_pass_or_throw_active();
    wait 0.25;
    self playSound("mp_ul_ball_throw");
    thread ball_check_pass_kill_pickup(self.carryobject);
    self.carryobject ball_create_killcam_ent();
    self.carryobject thread ball_physics_launch_drop(var_4 * var_1, self);
  }
}

ball_pass_or_throw_active() {
  self endon("death");
  self endon("disconnect");
  self.pass_or_throw_active = 1;
  self allowmelee(0);

  while("iw5_carrydrone_mp" == self getcurrentweapon()) {
    waitframe();
  }

  self allowmelee(1);
  self.pass_or_throw_active = 0;
}

ball_physics_launch_drop(var_0, var_1) {
  ball_set_dropped(1);
  ball_physics_launch(var_0, var_1);
}

ball_physics_launch(var_0, var_1) {
  var_2 = self.visuals[0];
  var_2.origin_prev = undefined;
  ball_fx_start();
  var_2 physicslaunchserver(var_2.origin, var_0);
  thread ball_physics_out_of_level();
  thread ball_physics_timeout(var_1);
  thread ball_physics_bad_trigger_watch();
  thread ball_physics_touch_goal();
  thread ball_physics_touch_cant_pickup_player(var_1);
}

ball_return_home() {
  self.in_goal = 0;
  var_0 = self.visuals[0];
  playsoundatpos(var_0.origin, "uplink_out_of_bounds");
  playFX(common_scripts\utility::getfx("ball_teleport"), var_0.origin);

  if(isDefined(self.carrier)) {
    self.carrier maps\mp\_utility::delaythread(0.05, ::player_update_pass_target_hudoutline);
  }

  thread maps\mp\gametypes\_gameobjects::returnhome();
}

ball_physics_out_of_level() {
  self endon("reset");
  self endon("pickup_object");
  var_0 = self.visuals[0];
  var_1[0] = 200;
  var_1[1] = 200;
  var_1[2] = 1000;
  var_2[0] = 200;
  var_2[1] = 200;
  var_2[2] = 200;

  for(;;) {
    for(var_3 = 0; var_3 < 2; var_3++) {
      if(var_0.origin[var_3] > level.ball_maxs[var_3] + var_1[var_3]) {
        ball_return_home();
        return;
      }

      if(var_0.origin[var_3] < level.ball_mins[var_3] - var_2[var_3]) {
        ball_return_home();
        return;
      }
    }

    waitframe();
  }
}

ball_physics_timeout(var_0) {
  self endon("reset");
  self endon("pickup_object");
  self endon("score_event");
  var_1 = getdvarfloat("scr_ball_reset_time", 15);
  var_2 = 10;
  var_3 = 3;

  if(var_1 >= var_2) {
    setomnvar("ui_mlg_game_mode_status_1", var_3);
    setomnvar("ui_mlg_game_mode_status_2", -1);
    var_4 = getomnvar("ui_mlg_game_mode_status_3");

    if(!isDefined(var_0)) {
      if(var_4 == 1 || var_4 == 4 || var_4 == 5) {
        setomnvar("ui_mlg_game_mode_status_3", 5);
      } else {
        setomnvar("ui_mlg_game_mode_status_3", 7);
      }
    } else if(var_4 == 1 || var_4 == 4 || var_4 == 5) {
      setomnvar("ui_mlg_game_mode_status_3", 4);
    } else {
      setomnvar("ui_mlg_game_mode_status_3", 6);
    }

    wait(var_3);
    var_1 = var_1 - var_3;
  }

  setomnvar("ui_mlg_game_mode_status_1", int(var_1));
  setomnvar("ui_mlg_game_mode_status_2", -1);
  setomnvar("ui_mlg_game_mode_status_3", 0);
  wait(var_1);
  ball_return_home();
}

ball_physics_bad_trigger_watch() {
  self.visuals[0] endon("physics_finished");
  thread ball_physics_bad_trigger_at_rest();
  wait 0.1;

  for(;;) {
    if(maps\mp\gametypes\_gameobjects::istouchingbadtrigger()) {
      ball_return_home();
      return;
    }

    waitframe();
  }
}

ball_physics_bad_trigger_at_rest() {
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = self.visuals[0];
  var_0 endon("death");
  var_0 waittill("physics_finished");

  if(maps\mp\gametypes\_gameobjects::istouchingbadtrigger()) {
    ball_return_home();
    return;
  }
}

ball_physics_touch_goal() {
  var_0 = self.visuals[0];
  var_0 endon("physics_finished");
  ball_touch_goal_watch(var_0);
}

ball_physics_touch_cant_pickup_player(var_0) {
  var_1 = self.visuals[0];
  var_2 = self.trigger;
  var_1 endon("physics_finished");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isDefined(var_0) && var_0 == var_3 && var_3 player_no_pickup_time()) {
      continue;
    }
    if(self.droptime >= gettime()) {
      continue;
    }
    if(var_1.origin == var_1.baseorigin + (0, 0, 4000)) {
      continue;
    }
    if(!ball_can_pickup(var_3)) {
      thread ball_physics_fake_bounce();
    }
  }
}

ball_physics_fake_bounce() {
  var_0 = self.visuals[0];

  if(!var_0 physicsisactive()) {
    return;
  }
  var_1 = var_0 physicsgetlinvel();
  var_2 = length(var_1) / 10;
  var_3 = -1 * vectornormalize(var_1);
  var_0 physicsstop();
  var_0 physicslaunchserver(var_0.origin, var_3 * var_2);
}

ball_pass_touch_goal() {
  var_0 = self.visuals[0];
  var_0 endon("pass_end");
  ball_touch_goal_watch(var_0);
}

ball_touch_goal_watch(var_0) {
  for(;;) {
    foreach(var_5, var_2 in level.ball_goals) {
      if(self.lastcarrierteam == var_5) {
        continue;
      }
      if(!var_2.useobject ball_goal_can_use()) {
        continue;
      }
      var_3 = distance(var_0.origin, var_2.origin);

      if(var_3 <= var_2.radius) {
        thread ball_touched_goal(var_2);
        return;
      }

      if(isDefined(var_0.origin_prev)) {
        var_4 = line_interect_sphere(var_0.origin_prev, var_0.origin, var_2.origin, var_2.radius);

        if(var_4) {
          thread ball_touched_goal(var_2);
          return;
        }
      }
    }

    waitframe();
  }
}

ball_goal_can_use(var_0) {
  var_1 = self.goal;

  if(var_1.ball_in_goal) {
    return 0;
  }

  return 1;
}

ball_carrier_touched_goal(var_0) {
  var_1 = getdvarint("scr_ball_points_touchdown", 2);

  if(!isDefined(var_0) || !isDefined(var_0.carryobject)) {
    return;
  }
  if(isDefined(var_0.carryobject.scorefrozenuntil) && var_0.carryobject.scorefrozenuntil > gettime()) {
    return;
  }
  var_0.carryobject.scorefrozenuntil = gettime() + 10000;
  var_0 maps\mp\_events::touchdownevent(var_1);
  ball_check_assist(var_0, 1);
  var_0 thread ball_update_extrascore0();
  var_2 = self.goal.team;
  var_3 = maps\mp\_utility::getotherteam(var_2);
  maps\mp\_utility::leaderdialog("enemy_carry_score", var_2, "status");
  maps\mp\_utility::leaderdialog("ally_carry_score", var_3, "status");

  if(should_record_final_score_cam(var_3, var_1)) {
    var_4 = self.goal.killcament;
    var_5 = var_4 getentitynumber();
    var_6 = var_4.birthtime;

    if(!isDefined(var_6)) {
      var_6 = 0;
    }

    var_0.deathtime = gettime();
    maps\mp\gametypes\_damage::recordfinalkillcam(5.0, var_0, var_0, var_0 getentitynumber(), var_5, var_6, "none", 0, 0, undefined, "score");
  }

  ball_play_score_fx(self.goal);
  ball_score_sound(var_3);

  if(isDefined(var_0.shoot_charge_bar)) {
    var_0.shoot_charge_bar.inuse = 0;
  }

  var_7 = var_0.carryobject;
  var_7.lastcarrierscored = 1;
  var_7 ball_set_dropped(1);
  var_7 thread ball_score_event(self.goal);
  ball_give_score(var_3, var_1);
}

ball_update_extrascore0() {
  waittillframeend;
  var_0 = maps\mp\_utility::getplayerstat("fieldgoal");
  var_1 = maps\mp\_utility::getplayerstat("touchdown");
  var_2 = getdvarint("scr_ball_points_fieldgoal", 1);
  var_3 = getdvarint("scr_ball_points_touchdown", 2);
  maps\mp\_utility::setextrascore0(var_0 * var_2 + var_1 * var_3);
}

should_record_final_score_cam(var_0, var_1) {
  var_2 = maps\mp\gametypes\_gamescore::_getteamscore(var_0);
  var_3 = maps\mp\gametypes\_gamescore::_getteamscore(maps\mp\_utility::getotherteam(var_0));
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
  ball_play_score_fx(var_0);
  var_1 = getdvarint("scr_ball_points_fieldgoal", 1);

  if(isDefined(self.scorefrozenuntil) && self.scorefrozenuntil > gettime()) {
    return;
  }
  self.scorefrozenuntil = gettime() + 10000;
  var_2 = var_0.team;
  var_3 = maps\mp\_utility::getotherteam(var_2);
  maps\mp\_utility::leaderdialog("enemy_throw_score", var_2, "status");
  maps\mp\_utility::leaderdialog("ally_throw_score", var_3, "status");

  if(isDefined(self.lastcarrier)) {
    self.lastcarrierscored = 1;
    self.lastcarrier maps\mp\_events::fieldgoalevent(var_1);
    ball_check_assist(self.lastcarrier, 0);
    self.lastcarrier thread ball_update_extrascore0();

    if(isDefined(self.killcament) && should_record_final_score_cam(var_3, var_1)) {
      var_4 = self.killcament;
      var_5 = var_4 getentitynumber();
      var_6 = var_4.birthtime;

      if(!isDefined(var_6)) {
        var_6 = 0;
      }

      var_7 = self.lastcarrier;
      var_0.killcament.deathtime = gettime();
      maps\mp\gametypes\_damage::recordfinalkillcam(5.0, var_0.killcament, var_7, var_7 getentitynumber(), var_5, var_6, "none", 0, 0, undefined, "score");
    }
  }

  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }

  ball_score_sound(var_3);
  thread ball_score_event(var_0);
  ball_give_score(var_3, var_1);
  setomnvar("ui_mlg_game_mode_status_1", -1);

  if(isDefined(self.lastcarrier)) {
    setomnvar("ui_mlg_game_mode_status_2", self.lastcarrier getentitynumber());
  } else {
    setomnvar("ui_mlg_game_mode_status_2", -1);
  }

  if(var_3 == "allies") {
    setomnvar("ui_mlg_game_mode_status_3", 1);
  } else {
    setomnvar("ui_mlg_game_mode_status_3", 2);
  }
}

ball_give_score(var_0, var_1) {
  level maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_0, var_1);

  if(game["status"] == "overtime") {
    game["ball_overtime_team"] = var_0;
    game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
    level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime", game["end_reason"]["switching_sides"]);
  } else if(game["status"] == "overtime_halftime") {
    var_2 = maps\mp\gametypes\_gamescore::_getteamscore(var_0);
    var_3 = maps\mp\gametypes\_gamescore::_getteamscore(maps\mp\_utility::getotherteam(var_0));

    if(var_2 >= var_3) {
      level thread maps\mp\gametypes\_gamelogic::endgame(var_0, game["end_reason"]["score_limit_reached"]);
    }
  }
}

ball_score_event(var_0) {
  self notify("score_event");
  self.in_goal = 1;
  var_0.ball_in_goal = 1;
  var_1 = self.visuals[0];

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var_1 physicsstop();
  maps\mp\gametypes\_gameobjects::allowcarry("none");
  ball_waypoint_upload();
  var_2 = 0.4;
  var_3 = 1.2;
  var_4 = 1.0;
  playsoundatpos(var_0.origin, "uplink_goal_point");
  var_5 = var_2 + var_4;
  var_6 = var_5 + var_3;
  var_1 moveto(var_0.origin, var_2, 0, var_2);
  var_1 rotatevelocity((1080, 1080, 0), var_6, var_6, 0);
  wait(var_5);
  var_0.ball_in_goal = 0;
  var_1 movez(4000, var_3, var_3 * 0.1, 0);
  wait(var_3);
  maps\mp\gametypes\_gameobjects::allowcarry("any");
  ball_return_home();
}

ball_check_assist(var_0, var_1) {
  if(!isDefined(var_0.passtime) || !isDefined(var_0.passplayer)) {
    return;
  }
  if(var_0.passtime + 3000 < gettime()) {
    return;
  }
  var_0.passplayer maps\mp\_events::ballscoreassistevent();

  if(var_1) {
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_ball_alleyoop");
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

ball_score_sound(var_0) {
  ball_play_local_team_sound(var_0, "mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
}

ball_play_local_team_sound(var_0, var_1, var_2) {
  var_3 = maps\mp\_utility::getotherteam(var_0);

  foreach(var_5 in level.players) {
    if(var_5.team == var_0) {
      var_5 playlocalsound(var_1);
      continue;
    }

    if(var_5.team == var_3) {
      var_5 playlocalsound(var_2);
    }
  }
}

ball_can_pickup(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0.underwater) && var_0.underwater) {
    return 0;
  }

  if(isDefined(self.droptime) && self.droptime >= gettime()) {
    return 0;
  }

  if(!var_0 common_scripts\utility::isweaponenabled()) {
    return 0;
  }

  if(var_0 isusingturret()) {
    return 0;
  }

  if(isDefined(var_0.manuallyjoiningkillstreak) && var_0.manuallyjoiningkillstreak) {
    return 0;
  }

  if(isDefined(var_0.using_remote_turret) && var_0.using_remote_turret) {
    return 0;
  }

  var_1 = var_0 getcurrentweapon();

  if(isDefined(var_1)) {
    if(!valid_ball_pickup_weapon(var_1)) {
      return 0;
    }
  }

  var_2 = var_0.changingweapon;

  if(isDefined(var_2) && var_0 isreloading()) {
    if(!valid_ball_pickup_weapon(var_2)) {
      return 0;
    }
  }

  if(isDefined(var_0.exo_shield_on) && var_0.exo_shield_on == 1) {
    return 0;
  }

  if(var_0 maps\mp\_utility::isjuggernaut()) {
    return 0;
  }

  if(var_0 player_no_pickup_time()) {
    return 0;
  }

  return 1;
}

valid_ball_pickup_weapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(var_0 == "iw5_carrydrone_mp") {
    return 0;
  }

  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return 0;
  }

  if(var_0 == "iw5_combatknifegoliath_mp") {
    return 0;
  }

  return 1;
}

player_no_pickup_time() {
  return isDefined(self.nopickuptime) && self.nopickuptime > gettime();
}

ball_on_pickup(var_0) {
  level.usestartspawns = 0;
  var_1 = self.visuals[0] getlinkedparent();

  if(isDefined(var_1)) {
    self.visuals[0] unlink();
  }

  self.visuals[0] physicsstop();
  self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
  self.visuals[0] show();
  self.visuals[0] ghost();
  self.visuals[0] _meth_8568(0);
  self.trigger maps\mp\_movers::stop_handling_moving_platforms();
  self.current_start.in_use = 0;
  var_2 = 0;

  if(isDefined(self.projectile)) {
    var_2 = 1;
    self.projectile delete();
  }

  var_3 = var_0.team;
  var_4 = maps\mp\_utility::getotherteam(var_0.team);

  if(var_2) {
    if(self.lastcarrierteam == var_0.team) {
      maps\mp\_utility::leaderdialog("pass_complete", var_3, "status");
      var_0.passtime = gettime();
      var_0.passplayer = self.lastcarrier;
    } else {
      maps\mp\_utility::leaderdialog("pass_intercepted", var_3, "status");
      var_0 maps\mp\_events::interceptionevent();
    }
  } else {
    maps\mp\_utility::leaderdialog("ally_own_drone", var_3, "status", [var_0]);
    var_0 maps\mp\_utility::leaderdialogonplayer("you_own_drone", "status");
    maps\mp\_utility::leaderdialog("enemy_own_drone", var_4, "status");
  }

  var_0 playSound("mp_ul_ball_catch");
  ball_play_local_team_sound(var_3, "mp_obj_notify_pos_sml", "mp_obj_notify_neg_sml");
  ball_fx_stop();
  self.lastcarrierscored = 0;
  self.lastcarrier = var_0;
  self.lastcarrierteam = var_0.team;
  self.ownerteam = var_0.team;
  ball_waypoint_held();
  var_0 setweaponammoclip("iw5_carrydrone_mp", 1);
  var_0.balldropdelay = getdvarint("scr_ball_water_drop_delay", 10);
  var_0 maps\mp\_utility::giveperk("specialty_ballcarrier", 0);
  var_0.ball_carried = self;
  var_0.objective = 1;
  setomnvar("ui_mlg_game_mode_status_1", -1);
  setomnvar("ui_mlg_game_mode_status_2", self.carrier getentitynumber());

  if(self.carrier.team == "allies") {
    setomnvar("ui_mlg_game_mode_status_3", 1);
  } else {
    setomnvar("ui_mlg_game_mode_status_3", 2);
  }

  var_0.hasperksprintfire = var_0 hasperk("specialty_sprintfire", 1);
  var_0 maps\mp\_utility::giveperk("specialty_sprintfire", 0);
  var_0 common_scripts\utility::_disableusability();
  var_0 maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
  var_5 = getdvarint("scr_ball_armor", 100);

  if(var_5 > 0) {
    var_0 thread maps\mp\perks\_perkfunctions::setlightarmor(var_5);
  } else {
    var_0 thread maps\mp\perks\_perkfunctions::unsetlightarmor();
  }

  var_0 thread player_update_pass_target(self);
  maps\mp\gametypes\_gamelogic::sethasdonecombat(var_0, 1);
}

ball_check_pass_kill_pickup(var_0) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("reset");
  var_1 = spawnStruct();
  var_1 endon("timer_done");
  var_1 thread timer_run(1.5);
  var_0 waittill("pickup_object");
  var_1 timer_cancel();

  if(!isDefined(var_0.carrier) || var_0.carrier.team == self.team) {
    return;
  }
  var_0.carrier endon("disconnect");
  var_1 thread timer_run(5);
  var_0.carrier waittill("death", var_2);
  var_1 timer_cancel();

  if(!isDefined(var_2) || var_2 != self) {
    return;
  }
  var_1 thread timer_run(2);
  var_0 waittill("pickup_object");
  var_1 timer_cancel();

  if(isDefined(var_0.carrier) && var_0.carrier == self) {
    maps\mp\_events::passkillpickupevent();
  }
}

timer_run(var_0) {
  self endon("cancel_timer");
  wait(var_0);
  self notify("timer_done");
}

timer_cancel() {
  self notify("cancel_timer");
}

player_update_pass_target(var_0) {
  self endon("disconnect");
  self endon("cancel_update_pass_target");
  player_update_pass_target_hudoutline();
  childthread player_joined_update_pass_target_hudoutline();
  var_1 = 0.8;

  for(;;) {
    var_2 = undefined;

    if(!self isonladder()) {
      var_3 = anglesToForward(self getangles());
      var_4 = self getEye();
      var_5 = [];

      foreach(var_7 in level.players) {
        if(var_7.team != self.team) {
          continue;
        }
        if(!maps\mp\_utility::isreallyalive(var_7)) {
          continue;
        }
        if(!var_0 ball_can_pickup(var_7)) {
          continue;
        }
        var_8 = var_7 getEye();
        var_9 = distancesquared(var_8, var_4);

        if(var_9 > 1000000) {
          continue;
        }
        var_10 = vectornormalize(var_8 - var_4);
        var_11 = vectordot(var_3, var_10);

        if(var_11 > var_1) {
          var_7.pass_dot = var_11;
          var_7.pass_origin = var_8;
          var_5[var_5.size] = var_7;
        }
      }

      var_5 = maps\mp\_utility::quicksort(var_5, ::compare_player_pass_dot);

      foreach(var_7 in var_5) {
        if(sighttracepassed(var_4, var_7.pass_origin, 0, self, var_7)) {
          var_2 = var_7;
          break;
        }
      }
    }

    player_set_pass_target(var_2);
    waitframe();
  }
}

player_joined_update_pass_target_hudoutline() {
  for(;;) {
    level waittill("joined_team", var_0);
    player_update_pass_target_hudoutline();
  }
}

player_update_pass_target_hudoutline() {
  if(!isDefined(self)) {
    return;
  }
  self hudoutlinedisableforclients(level.players);

  foreach(var_1 in level.players) {
    var_1 hudoutlinedisableforclient(self);
  }

  var_3 = [];
  var_4 = [];
  var_5 = maps\mp\_utility::getotherteam(self.team);

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    if(var_1.team == self.team) {
      var_3[var_3.size] = var_1;
      continue;
    }

    if(var_1.team == var_5) {
      var_4[var_4.size] = var_1;
    }
  }

  if(isDefined(self.carryobject)) {
    foreach(var_1 in var_3) {
      var_9 = isDefined(self.pass_target) && self.pass_target == var_1;

      if(!var_9) {
        var_1 hudoutlineenableforclient(self, 4, 0);
      }
    }

    if(isDefined(self.pass_target)) {
      self.pass_target hudoutlineenableforclient(self, 5, 0);
    }

    if(var_4.size > 0) {
      self hudoutlineenableforclients(var_4, 0, 1);
    }

    if(var_3.size > 0) {
      self hudoutlineenableforclients(var_3, 5, 0);
    }
  }
}

player_set_pass_target(var_0) {
  if(isDefined(self.pass_target) && isDefined(var_0) && self.pass_target == var_0) {
    return;
  }
  if(!isDefined(self.pass_target) && !isremovedentity(self.pass_target) && !isDefined(var_0)) {
    return;
  }
  player_clear_pass_target();

  if(isDefined(var_0)) {
    var_1 = (0, 0, 80);
    self.pass_icon = var_0 maps\mp\_entityheadicons::setheadicon(self, "waypoint_ball_pass", var_1, 10, 10, 0, 0.05, 0, 1, 0, 0, "tag_origin");
    self.pass_target = var_0;
    var_2 = [];

    foreach(var_4 in level.players) {
      if(var_4.team == self.team && var_4 != self && var_4 != var_0) {
        var_2[var_2.size] = var_4;
      }
    }

    self setclientomnvar("ui_uplink_can_pass", 1);
    self setballpassallowed(1);
  }

  player_update_pass_target_hudoutline();
}

player_clear_pass_target() {
  if(isDefined(self.pass_icon)) {
    self.pass_icon destroy();
  }

  self setclientomnvar("ui_uplink_can_pass", 0);
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.team == self.team && var_2 != self) {
      var_0[var_0.size] = var_2;
    }
  }

  self.pass_target = undefined;
  self setballpassallowed(0);
  player_update_pass_target_hudoutline();
}

compare_player_pass_dot(var_0, var_1) {
  return var_0.pass_dot >= var_1.pass_dot;
}

ball_set_dropped(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self.isresetting = 1;
  self.droptime = gettime();
  self notify("dropped");
  var_1 = self.carrier;

  if(isDefined(var_1) && var_1.team != "spectator") {
    var_2 = var_1.origin;
  } else {
    var_2 = self.safeorigin;
  }

  var_2 = var_2 + (0, 0, 40);
  var_3 = (0, 0, 0);

  for(var_4 = 0; var_4 < self.visuals.size; var_4++) {
    self.visuals[var_4].origin = var_2;
    self.visuals[var_4].angles = var_3;
    self.visuals[var_4] show();
    self.visuals[var_4] _meth_8568(1);
  }

  self.trigger.origin = var_2;
  ball_dont_interpolate();
  self.curorigin = self.trigger.origin;
  ball_carrier_cleanup();
  ball_fx_start();
  self.ownerteam = "any";
  ball_waypoint_neutral();
  maps\mp\gametypes\_gameobjects::clearcarrier();

  if(isDefined(var_1)) {
    var_1 player_update_pass_target_hudoutline();
  }

  maps\mp\gametypes\_gameobjects::updatecompassicons();
  maps\mp\gametypes\_gameobjects::updateworldicons();
  self.isresetting = 0;

  if(!var_0) {
    var_5 = self.lastcarrierteam;
    var_6 = maps\mp\_utility::getotherteam(var_5);
    maps\mp\_utility::leaderdialog("ally_drop_drone", var_5, "status");
    maps\mp\_utility::leaderdialog("enemy_drop_drone", var_6, "status");
    ball_physics_launch((0, 0, 80));
  }

  var_7 = spawnStruct();
  var_7.carryobject = self;
  var_7.deathoverridecallback = ::ball_overridemovingplatformdeath;
  self.trigger thread maps\mp\_movers::handle_moving_platforms(var_7);
  return 1;
}

ball_overridemovingplatformdeath(var_0) {}

ball_assign_random_start() {
  var_0 = undefined;
  var_1 = common_scripts\utility::array_randomize(level.ball_starts);

  foreach(var_3 in var_1) {
    if(var_3.in_use) {
      continue;
    }
    var_0 = var_3;
    break;
  }

  if(!isDefined(var_0)) {
    return;
  }
  ball_assign_start(var_0);
}

ball_assign_start(var_0) {
  foreach(var_2 in self.visuals) {
    var_2.baseorigin = var_0.origin;
  }

  self.trigger.baseorigin = var_0.origin;
  self.current_start = var_0;
  var_0.in_use = 1;
}

ball_on_reset() {
  ball_assign_random_start();
  var_0 = self.visuals[0];
  var_0 maps\mp\_movers::notify_moving_platform_invalid();
  var_1 = var_0 getlinkedparent();

  if(isDefined(var_1)) {
    var_0 unlink();
  }

  var_0 physicsstop();
  ball_dont_interpolate();

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var_2 = "none";
  var_3 = self.lastcarrierteam;

  if(isDefined(var_3)) {
    var_2 = maps\mp\_utility::getotherteam(var_3);
  }

  ball_carrier_cleanup();
  setomnvar("ui_mlg_game_mode_status_1", -1);
  setomnvar("ui_mlg_game_mode_status_2", -1);
  setomnvar("ui_mlg_game_mode_status_3", 3);
  self.trigger maps\mp\_movers::stop_handling_moving_platforms();
  ball_waypoint_download();
  maps\mp\gametypes\_gameobjects::setposition(var_0.baseorigin + (0, 0, 4000), (0, 0, 0));
  var_4 = 3;
  var_0 moveto(var_0.baseorigin, var_4, 0, var_4);
  var_0 rotatevelocity((0, 720, 0), var_4, 0, var_4);
  playsoundatpos(var_0.baseorigin, "uplink_ball_reset");

  if(!self.lastcarrierscored && isDefined(var_3) && isDefined(var_2)) {
    maps\mp\_utility::leaderdialog("drone_reset", var_3, "status");
    maps\mp\_utility::leaderdialog("drone_reset", var_2, "status");

    if(isDefined(self.lastcarrier)) {
      thread maps\mp\_utility::teamplayercardsplash("callout_ballreset", self.lastcarrier);
    }
  }

  self.ownerteam = "any";
  ball_waypoint_download();
  thread ball_download_wait(var_4);
  thread ball_download_fx(var_0, var_4);
}

ball_download_fx(var_0, var_1) {
  playFXOnTag(level._effect["ball_download"], var_0, "tag_origin");
  common_scripts\utility::waittill_notify_or_timeout("pickup_object", var_1);
  stopFXOnTag(level._effect["ball_download"], var_0, "tag_origin");
  self.scorefrozenuntil = 0;
}

ball_download_wait(var_0) {
  self endon("pickup_object");
  wait(var_0);
  ball_waypoint_neutral();
  playFX(level._effect["ball_download_end"], self.current_start.ground_origin);
  ball_fx_start();
}

ball_carrier_cleanup() {
  if(isDefined(self.carrier)) {
    self.carrier.balldropdelay = undefined;
    self.carrier.nopickuptime = gettime() + 500;
    self.carrier player_clear_pass_target();
    self.carrier notify("cancel_update_pass_target");
    self.carrier maps\mp\_utility::_unsetperk("specialty_ballcarrier");
    self.carrier.ball_carried = undefined;
    self.carrier thread maps\mp\perks\_perkfunctions::unsetlightarmor();

    if(!self.carrier.hasperksprintfire) {
      self.carrier maps\mp\_utility::_unsetperk("specialty_sprintfire");
    }

    self.carrier common_scripts\utility::_enableusability();
    self.carrier maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
    self.carrier setballpassallowed(0);
    self.carrier setclientomnvar("ui_uplink_can_pass", 0);
    self.carrier.objective = 0;
  }
}

ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = bulletTrace(var_1, var_2, 0, undefined);
  self.ground_origin = var_3["position"];
  return var_3["fraction"] != 0 && var_3["fraction"] != 1;
}

ball_create_team_goal(var_0) {
  var_1 = var_0;

  if(game["switchedsides"]) {
    var_1 = maps\mp\_utility::getotherteam(var_1);
  }

  var_2 = 0;
  var_3 = common_scripts\utility::getstruct("ball_goal_" + var_1, "targetname");

  if(!maps\mp\_utility::isaugmentedgamemode()) {
    var_4 = common_scripts\utility::getstruct("ball_goal_non_augmented_" + var_1, "targetname");

    if(isDefined(var_4)) {
      var_3 = var_4;
    } else {
      var_2 = 1;
    }
  }

  if(isDefined(var_3)) {
    var_3 ball_find_ground();

    if(var_2) {
      var_3.origin = var_3.ground_origin + (0, 0, 90);
    }
  } else {
    var_3 = spawnStruct();

    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_3.origin)) {
      var_3.origin = level.default_goal_origins[var_0];
    }

    var_3 ball_find_ground();

    if(maps\mp\_utility::isaugmentedgamemode()) {
      var_3.origin = var_3.ground_origin + (0, 0, 220);
    } else {
      var_3.origin = var_3.ground_origin + (0, 0, 90);
    }
  }

  var_3.radius = 70;
  var_3.team = var_0;
  var_3.ball_in_goal = 0;
  var_3.highestspawndistratio = 0;
  level.ball_goals[var_0] = var_3;
}

ball_create_ball_starts(var_0) {
  var_1 = common_scripts\utility::getstructarray("ball_start", "targetname");

  if(!maps\mp\_utility::isaugmentedgamemode()) {
    var_2 = common_scripts\utility::getstructarray("ball_start_non_augmented", "targetname");

    if(var_2.size > 0) {
      var_1 = var_2;
    }
  }

  var_1 = common_scripts\utility::array_randomize(var_1);

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.script_index)) {
      var_4.script_index = 100;
    }
  }

  var_1 = maps\mp\_utility::quicksort(var_1, ::compare_script_index);

  foreach(var_4 in var_1) {
    ball_add_start(var_4.origin);
  }

  var_8 = 30;

  if(var_1.size == 0) {
    var_9 = (0, 0, 0);

    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_9)) {
      var_9 = level.default_ball_origin;
    }

    ball_add_start(var_9);
  }

  var_10 = var_0 - level.ball_starts.size;

  if(var_10 <= 0) {
    return;
  }
  var_11 = level.ball_starts[0].origin;
  var_12 = getnodesinradius(var_11, 200, 20, 50);
  var_12 = common_scripts\utility::array_randomize(var_12);

  for(var_13 = 0; var_13 < var_10 && var_13 < var_12.size; var_13++) {
    ball_add_start(var_12[var_13].origin);
  }
}

ball_add_start(var_0) {
  var_1 = 30;
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2 ball_find_ground();
  var_2.origin = var_2.ground_origin + (0, 0, var_1);
  var_2.in_use = 0;
  level.ball_starts[level.ball_starts.size] = var_2;
}

compare_script_index(var_0, var_1) {
  return var_0.script_index <= var_1.script_index;
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
    var_4 = common_scripts\utility::ter_op(var_6 == var_1, "ball_goal_friendly", "ball_goal_enemy");
    var_5 = spawnfxforclient(common_scripts\utility::getfx(var_4), var_3.origin, var_0, (1, 0, 0));
    setfxkillondelete(var_5, 1);
    var_0.ball_goal_fx[var_4] = var_5;
    triggerfx(var_5);
  }
}

ball_get_view_team(var_0) {
  var_1 = var_0.team;

  if(var_1 != "allies" && var_1 != "axis") {
    var_1 = "allies";
  }

  return var_1;
}

player_delete_ball_goal_fx() {
  foreach(var_1 in self.ball_goal_fx) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

ball_play_fx_joined_team() {
  for(;;) {
    level waittill("joined_team", var_0);
    ball_goal_fx_for_player(var_0);
  }
}