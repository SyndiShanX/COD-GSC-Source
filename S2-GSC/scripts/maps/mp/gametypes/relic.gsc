/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\relic.gsc
***********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    _setdynamicdvar("scr_relic_num_balls", 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  var_0 = getdvarint("scr_relic_num_balls", 1);
  _setomnvar("ui_uplink_num_balls", var_0);
  setdvarifuninitialized("spv_tesla_mp_active", 0);
  maps\mp\_utility::setovertimelimitdvar(3);

  if(isDefined(game["round_time_to_beat"])) {
    maps\mp\_utility::setovertimelimitdvar(game["round_time_to_beat"]);
    game["round_time_to_beat"] = undefined;
  }

  maps\mp\_utility::_id_873B(1);
  level.onstartgametype = ::onstartgametype;
  level.onnormaldeath = ::onnormaldeath;
  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 0;
  level.disabledivisionchallenges = 0;
  level.disablewinlossstats = 1;
  level.mgnestsdisabled = 0;
  level.gamemodeonunderwater = ::onunderwater;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  level._effect["mp_infected_zombie_vision_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_01");
  level._effect["infected_turn_lightning_01"] = loadfx("vfx/unique/infected_turn_lightning_01");
  level thread ball_on_connect();
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  _setdynamicdvar("scr_relic_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("ball", 0, 0, 9);
  _setdynamicdvar("scr_relic_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("ball", 1);
  _setdynamicdvar("scr_relic_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("ball", 1);
  _setdynamicdvar("scr_relic_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("ball", 0);
  var_0 = _getmatchrulesdata("ballData", "numBalls");
  var_0 = max(1, var_0);
  _setdynamicdvar("scr_relic_num_balls", var_0);
  _setdynamicdvar("scr_relic_reset_time", _getmatchrulesdata("ballData", "ballResetTime"));
  _setdynamicdvar("scr_relic_points_touchdown", _getmatchrulesdata("ballData", "carryScore"));
  _setdynamicdvar("scr_relic_points_fieldgoal", _getmatchrulesdata("ballData", "throwScore"));
  _setdynamicdvar("scr_relic_armor", _getmatchrulesdata("ballData", "armorValue"));
}

onstartgametype() {
  level.reliccapturepercentage["allies"] = 0;
  level.reliccapturepercentage["axis"] = 0;
  level.reliccapturetime["allies"] = 0;
  level.reliccapturetime["axis"] = 0;
  updateallplayersstatusomnvars();
  _setclientnamemode("auto_change");

  if(game["status"] == "halftime") {
    _setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    _setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    _setomnvar("ui_current_round", 4);
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
    _setteamscore("allies", 0);
    game["teamScores"]["axis"] = 0;
    _setteamscore("axis", 0);
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
  level.iconalliesgoal = "waypoint_caster_friendly_goal";
  level.iconaxisgoal = "waypoint_caster_enemy_goal";
  level.iconneutralball = "waypoint_caster_neutral_ball";
  level.iconheldball = "waypoint_caster_held_ball";
  ball_default_origins();
  var_2[0] = level.gametype;
  var_2[1] = "blocker_ball";
  _id_04D1::main(var_2);
  level thread run_ball();
  _id_050D::_id_10E4();
  level thread playerjoinedupdateomnvars();
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
    } else if(game["status"] == "halftime")
      var_0 = "overtime";
    else if(isDefined(game["ball_overtime_team"])) {
      var_0 = game["ball_overtime_team"];
    } else {
      var_0 = "tie";
    }
  } else if(game["status"] == "overtime")
    var_0 = "overtime_halftime";

  _logstring("time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  level thread maps\mp\gametypes\_gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

updateallplayersstatusomnvars() {
  var_0 = level.reliccapturepercentage["allies"];
  var_1 = game["teamScores"]["allies"];
  var_2 = level.reliccapturepercentage["axis"];
  var_3 = game["teamScores"]["axis"];

  foreach(var_5 in level.players) {
    if(!isDefined(var_5) || isbot(var_5) || _isagent(var_5)) {
      continue;
    }
    if(var_5.team == "allies") {
      var_6 = var_0;
      var_7 = var_1;
      var_8 = var_2;
      var_9 = var_3;
    } else {
      var_6 = var_2;
      var_7 = var_3;
      var_8 = var_0;
      var_9 = var_1;
    }

    var_5 setclientomnvar("ui_onevone_class_1", var_6);
    var_5 setclientomnvar("ui_onevone_class_2", var_7);
    var_5 setclientomnvar("ui_onevone_class_3", var_8);
    var_5 setclientomnvar("ui_onevone_class_4", var_9);
  }
}

updateplayerstatusomnvars(var_0) {
  var_1 = level.reliccapturepercentage["allies"];
  var_2 = game["teamScores"]["allies"];
  var_3 = level.reliccapturepercentage["axis"];
  var_4 = game["teamScores"]["axis"];

  if(var_0.team == "allies") {
    var_5 = var_1;
    var_6 = var_2;
    var_7 = var_3;
    var_8 = var_4;
  } else {
    var_5 = var_3;
    var_6 = var_4;
    var_7 = var_1;
    var_8 = var_2;
  }

  var_0 setclientomnvar("ui_onevone_class_1", var_5);
  var_0 setclientomnvar("ui_onevone_class_2", var_6);
  var_0 setclientomnvar("ui_onevone_class_3", var_7);
  var_0 setclientomnvar("ui_onevone_class_4", var_8);
}

playerjoinedupdateomnvars() {
  level endon("game_ended");

  for(;;) {
    level waittill("joined_team", var_0);
    thread updateplayerstatusomnvars(var_0);
  }
}

awardgoal(var_0, var_1) {
  var_2 = common_scripts\utility::getfx("infected_turn_lightning_01");
  _playFXOnTag(var_2, var_1, "tag_origin");
  level.previoussoulcaptureorigin = var_1.origin;
  _id_04D2::giveteamscoreforobjective(var_0, 1, 1);
  level.reliccapturetime[var_0] = 0;
  level.reliccapturepercentage[var_0] = 0;
  thread updateallplayersstatusomnvars();

  if(!isDefined(var_1.souls_captured)) {
    var_1.souls_captured = 0;
  }

  var_1.souls_captured = var_1.souls_captured + 1;
  var_1.pers["souls"] = var_1.souls_captured;
  var_1 maps\mp\_utility::setextrascore1(var_1.pers["souls"]);
  var_1 thread _id_047A::relicgoalevent();
  level.balls[0].lastcarrierscored = 1;
  level.balls[0].hasbeentouched = 0;
  level.balls[0] ball_set_dropped(1);
  level.balls[0] ball_score_event(var_1.origin);
  var_1 _id_0468::_id_0A22("soulCap");
}

awardcapturepoints(var_0, var_1) {
  level endon("game_ended");
  level endon("relicDropped");
  level endon("relicReset");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_2 = 1;
  var_3 = 4;
  var_4 = 1;
  var_5 = 1;
  var_6 = 0;

  while(!level.gameended) {
    wait(var_2);
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    var_6 = var_6 + var_2;

    if(isDefined(level.balls[0].carrier) && level.balls[0].carrier == var_1) {
      level.reliccapturetime[var_0] = level.reliccapturetime[var_0] + var_5;
      level.reliccapturepercentage[var_0] = int(100 * (level.reliccapturetime[var_0] / 30));

      if(!isDefined(var_1.time_holding_relic)) {
        var_1.time_holding_relic = 0;
      }

      var_1.time_holding_relic = var_1.time_holding_relic + var_2;
      var_1.pers["time"] = var_1.time_holding_relic;
      var_1 maps\mp\_utility::setextrascore0(var_1.pers["time"]);

      if(level.reliccapturetime[var_0] >= 30) {
        thread awardgoal(var_0, var_1);
        return;
      }

      updateallplayersstatusomnvars();

      if(var_4 && var_6 % var_3 == 0) {
        var_1 thread _id_047A::heldrelicevent();
        var_1 playlocalsound("ui_tap");
      }

      continue;
    }

    break;
  }
}

forceballsfromplayer() {
  foreach(var_1 in level.balls) {
    if(isDefined(var_1.carrier) && var_1.carrier == self) {
      self.water_last_weapon = _id_04D1::_id_466D(var_1);
      var_1 thread _id_04D1::setdropped();
      return;
    }
  }

  if(self getcurrentweapon() == "relic_mp" && isDefined(self.changingweapon)) {
    self.water_last_weapon = self.changingweapon;
  } else if(isDefined(self.pass_or_throw_active) && self.pass_or_throw_active) {
    var_3 = self getweaponlistprimaries();
    self.water_last_weapon = common_scripts\utility::ter_op(var_3.size, var_3[0], undefined);
  }

  self.balldropdelay = undefined;
}

onunderwater(var_0) {
  forceballsfromplayer();
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
  var_0 = getdvarint("scr_relic_num_balls", 1);
  ball_create_ball_starts(var_0);
  level._effect["ball_vm"] = loadfx("vfx/unique/mp_relic_vm_01");
  level._effect["ball_trail"] = loadfx("vfx/trail/vfx_relic_ball_trl");
  level._effect["ball_download"] = loadfx("vfx/trail/vfx_relic_ball_trl2");
  level._effect["ball_download_end"] = loadfx("vfx/unique/vfx_uplink_ball_impact");
  level._effect["ball_goal_allies_blue"] = loadfx("vfx/unique/gridiron_goal_allies_blue");
  level._effect["ball_goal_allies_red"] = loadfx("vfx/unique/gridiron_goal_allies_red");
  level._effect["ball_goal_axis_blue"] = loadfx("vfx/unique/gridiron_goal_axis_blue");
  level._effect["ball_goal_axis_red"] = loadfx("vfx/unique/gridiron_goal_axis_red");
  level._effect["ball_goal_activated_red"] = loadfx("vfx/unique/vfx_uplink_ball_score");
  level._effect["ball_goal_activated_green"] = loadfx("vfx/unique/vfx_uplink_ball_score");
  level._effect["ball_goal_activated_blue"] = loadfx("vfx/unique/vfx_uplink_ball_score_friendly");
  level._effect["ball_goal_activated_orange"] = loadfx("vfx/unique/vfx_uplink_ball_score_friendly");
  level._effect["ball_goal_activated_yellow"] = loadfx("vfx/unique/vfx_uplink_ball_score");
  level._effect["ball_teleport"] = loadfx("vfx/unique/vfx_uplink_ball_glow");
  level._effect["ball_physics_impact"] = loadfx("vfx/treadfx/footstep_dust");
  level._effect["tesla_gun_glow"] = loadfx("vfx/unique/mp_loot_ray_01");
  level thread ball_connect_watch();
  ball_init_map_min_max();

  for(var_1 = 0; var_1 < var_0 && var_1 < level.ball_starts.size; var_1++) {
    ball_spawn(var_1);
  }

  maps\mp\_utility::gameflagwait("prematch_done");

  foreach(var_3 in level.players) {
    var_3 thread maps\mp\gametypes\_hud_message::splashnotify("relic_intro");
  }
}

ball_default_origins() {
  level.default_goal_origins = [];
  var_0 = getEntArray("flag_primary", "targetname");

  foreach(var_2 in var_0) {
    switch (var_2.shootblank) {
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
  var_0 = _getallnodes();

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      level.ball_mins = _id_050D::expandmins(level.ball_mins, var_2.origin);
      level.ball_maxs = _id_050D::expandmaxs(level.ball_maxs, var_2.origin);
    }
  } else {
    level.ball_mins = level.spawnmins;
    level.ball_maxs = level.spawnmaxs;
  }
}

ball_goal_useobject() {
  foreach(var_2, var_1 in level.ball_goals) {
    var_1.trigger = spawn("trigger_radius", var_1.origin - (0, 0, var_1.radius), 0, var_1.radius, var_1.radius * 2);
    var_1.useobject = _id_04D1::createuseobject(var_2, var_1.trigger, [], (0, 0, var_1.radius * 2.1));
    var_1.useobject.goal = var_1;
    var_1.useobject _id_04D1::set2dicon("friendly", "waypoint_ball_defend");
    var_1.useobject _id_04D1::set2dicon("enemy", "waypoint_ball_goal");
    var_1.useobject _id_04D1::playsoundtoteam("friendly", "waypoint_ball_defend");
    var_1.useobject _id_04D1::playsoundtoteam("enemy", "waypoint_ball_goal");

    if(var_2 == "allies") {
      maps\mp\_utility::_id_863F(var_1.useobject, level.iconalliesgoal, 2);
    } else {
      maps\mp\_utility::_id_863F(var_1.useobject, level.iconaxisgoal, 1);
    }

    var_1.useobject _id_04D1::setvisibleteam("any");
    var_1.useobject _id_04D1::_id_0C30("enemy");
    var_1.useobject _id_04D1::setkeyobject(level.balls);
    var_1.useobject _id_04D1::setusetime(0);
    var_1.useobject.onuse = ::ball_carrier_touched_goal;
    var_1.useobject.canuseobject = ::ball_goal_can_use;
    var_1 thread setupkillcament();
  }
}

setupkillcament() {
  var_0 = spawn("script_origin", self.origin);
  var_0.angles = self.angles;
  var_0 rotateYaw(-45, 0.05);
  waitframe();
  var_1 = self.origin + (0, 0, 5);
  var_2 = self.origin + anglesToForward(var_0.angles) * 100 + (0, 0, 128);
  var_3 = bulletTrace(var_1, var_2, 0, self);
  var_4 = var_3["position"];

  if(var_3["fraction"] < 1.0) {
    var_4 = var_4 + var_3["normal"] * 5;
  }

  self.killcament = spawn("script_model", var_4);
  self.killcament setscriptmoverkillcam("explosive");
  var_0 delete();
}

ball_goal_fx() {
  foreach(var_2, var_1 in level.ball_goals) {
    var_1.laseron["friendly"] = _spawnfx(common_scripts\utility::getfx("ball_goal_activated_blue"), var_1.origin, (1, 0, 0));
    var_1.laseron["enemy"] = _spawnfx(common_scripts\utility::getfx("ball_goal_activated_red"), var_1.origin, (1, 0, 0));

    if(var_2 == "allies") {
      var_1.laseron["broadcaster"] = _spawnfx(common_scripts\utility::getfx("ball_goal_activated_orange"), var_1.origin, (1, 0, 0));
      continue;
    }

    var_1.laseron["broadcaster"] = _spawnfx(common_scripts\utility::getfx("ball_goal_activated_yellow"), var_1.origin, (1, 0, 0));
  }

  level thread ball_play_fx_joined_team();

  foreach(var_4 in level.players) {
    ball_goal_fx_for_player(var_4);
  }
}

ball_spawn(var_0) {
  var_1 = level.ball_starts[var_0];
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("npc_soccer_ball_zombie_01");
  var_2 notsolid();
  var_2 thread physics_impact_watch();
  var_3 = 24;
  var_4 = _getEnt("ball_pickup_" + (var_0 + 1), "targetname");

  if(isDefined(var_4)) {
    var_4.origin = var_2.origin;
  } else {
    var_4 = spawn("trigger_radius", var_2.origin - (0, 0, var_3 / 2), 0, var_3, var_3);
  }

  var_4 enablelinkTo();
  var_4 linkTo(var_2);
  var_4.no_moving_platfrom_unlink = 1;
  var_5 = [var_2];
  var_6 = _id_04D1::createcarryobject("any", var_4, var_5, (0, 0, 32), 1, 0, 1);
  var_6.objectiveonvisuals = 1;
  var_6 _id_04D1::_id_0C1D("any");
  var_6 ball_waypoint_neutral();
  var_6 _id_04D1::setvisibleteam("any");
  var_6.objidpingenemy = 1;
  var_6.objpingdelay = 1.0;
  var_6._id_0C33 = 0;
  var_6.carryweapon = "relic_mp";
  var_6._id_59D8 = 1;
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
  var_6.hasbeentouched = 0;
  var_6 ball_assign_start(var_1);
  level.balls[level.balls.size] = var_6;
  var_6 ball_fx_start();
  var_6 thread ball_location_hud(var_0);
  _setomnvar("ui_broadcaster_game_mode_status_1", -1);
  _setomnvar("ui_broadcaster_game_mode_status_2", -1);
  _setomnvar("ui_broadcaster_game_mode_status_3", 3);
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
    var_5 = vectordot(var_2, var_1);

    if(var_5 > 0.5) {
      self playSound("grid_ball_bounce");
    }

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
        _setomnvar("ui_uplink_ball_carrier" + (var_0 + 1), self.carrier getentitynumber());
        break;
      case "dropped":
        _setomnvar("ui_uplink_ball_carrier" + (var_0 + 1), -2);
        break;
      case "reset":
        _setomnvar("ui_uplink_ball_carrier" + (var_0 + 1), -1);
        break;
      default:
        break;
    }
  }
}

ball_waypoint_neutral() {
  _id_04D1::set2dicon("friendly", "waypoint_ball");
  _id_04D1::set2dicon("enemy", "waypoint_ball");
  _id_04D1::playsoundtoteam("friendly", "waypoint_ball");
  _id_04D1::playsoundtoteam("enemy", "waypoint_ball");
  maps\mp\_utility::_id_863F(self, level.iconneutralball, 3);
  _setomnvar("ui_hardpoint_status", 0);
}

ball_waypoint_held() {
  _id_04D1::set2dicon("friendly", "waypoint_ball_friendly");
  _id_04D1::set2dicon("enemy", "waypoint_ball_enemy");
  _id_04D1::playsoundtoteam("friendly", "waypoint_ball_friendly");
  _id_04D1::playsoundtoteam("enemy", "waypoint_ball_enemy");

  if(self.ownerteam == "allies") {
    maps\mp\_utility::_id_863F(self, level.iconheldball, 2);
    _setomnvar("ui_hardpoint_status", 2);
  } else {
    maps\mp\_utility::_id_863F(self, level.iconheldball, 1);
    _setomnvar("ui_hardpoint_status", 1);
  }
}

ball_waypoint_download() {
  _id_04D1::set2dicon("friendly", "waypoint_ball");
  _id_04D1::set2dicon("enemy", "waypoint_ball");
  _id_04D1::playsoundtoteam("friendly", "waypoint_ball");
  _id_04D1::playsoundtoteam("enemy", "waypoint_ball");
  maps\mp\_utility::_id_863F(self, level.iconneutralball, 3);
}

ball_waypoint_upload() {
  _id_04D1::set2dicon("friendly", "waypoint_ball");
  _id_04D1::set2dicon("enemy", "waypoint_ball");
  _id_04D1::playsoundtoteam("friendly", "waypoint_ball");
  _id_04D1::playsoundtoteam("enemy", "waypoint_ball");
  maps\mp\_utility::_id_863F(self, level.iconneutralball, 3);
}

ball_dont_interpolate() {
  self.visuals[0] dontinterpolate();
  self.ball_fx_active = 0;
}

ball_fx_start() {
  if(!ball_fx_active()) {
    var_0 = self.visuals[0];
    _playFXOnTag(common_scripts\utility::getfx("ball_trail"), var_0, "tag_weapon");
    _playFXOnTag(common_scripts\utility::getfx("ball_vm"), var_0, "tag_weapon");
    self.ball_fx_active = 1;
  }
}

ball_fx_start_player(var_0) {
  if(ball_fx_active()) {
    var_1 = self.visuals[0];
    _playfxontagforclients(common_scripts\utility::getfx("ball_trail"), var_1, "tag_weapon", var_0);
    _playfxontagforclients(common_scripts\utility::getfx("ball_vm"), var_1, "tag_weapon", var_0);
  }
}

ball_fx_stop() {
  if(ball_fx_active()) {
    var_0 = self.visuals[0];
    _stopFXOnTag(common_scripts\utility::getfx("ball_trail"), var_0, "tag_weapon");
    _stopFXOnTag(common_scripts\utility::getfx("ball_vm"), var_0, "tag_weapon");
  }

  self.ball_fx_active = 0;
}

ball_fx_active() {
  return isDefined(self.ball_fx_active) && self.ball_fx_active;
}

ball_pass_or_shoot() {
  self endon("disconnect");
  self refreshshieldmodels("none", 1);
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

    if(var_0 != "relic_mp") {
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
  var_4 = vectorNormalize(var_2 + var_3 - self.visuals[0].origin);
  var_5 = var_4 * 1000;
  self.projectile = _magicgrenademanual("gamemode_ball", self.visuals[0].origin, var_5, 30, var_0, 1, 1);

  if(isDefined(var_1)) {
    self.projectile missile_settargetEnt(var_1);
  }

  self.visuals[0] linkTo(self.projectile);
  ball_dont_interpolate();
  ball_create_killcam_ent();
  ball_clear_contents();
  thread ball_on_projectile_hit_client();
  thread ball_on_projectile_death();
}

ball_create_killcam_ent() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self.killcament = spawn("script_model", self.visuals[0].origin);
  self.killcament linkTo(self.visuals[0]);
  self.killcament _meth_80B1();
  self.killcament setscriptmoverkillcam("explosive");
}

ball_clear_contents() {
  self.visuals[0].old_contents = self.visuals[0] _meth_80B1();
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
  var_0 = getdvarfloat("scr_relic_shoot_extra_pitch", -4);
  var_1 = getdvarfloat("scr_relic_shoot_force", 500);

  for(;;) {
    self waittill("weapon_fired", var_2);

    if(var_2 != "relic_mp") {
      continue;
    }
    break;
  }

  if(isDefined(self.carryobject)) {
    var_3 = self getplayerangles();
    var_3 = var_3 + (var_0, 0, 0);
    var_3 = (clamp(var_3[0], -85, 85), var_3[1], var_3[2]);
    var_4 = anglesToForward(var_3);
    thread ball_pass_or_throw_active();
    waitframe();
    self playSound("grid_ball_throw");
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

  while("relic_mp" == self getcurrentweapon()) {
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
  level notify("broadcaster_throw_ball", self.lastcarrier, self, vectorNormalize(var_0));
  var_2 physicslaunchserver(var_2.origin, var_0);
  thread ball_physics_out_of_level();
  thread ball_physics_timeout(var_1);
  thread ball_physics_bad_trigger_watch();
  thread _id_1546(var_1);
}

ball_return_home() {
  self.in_goal = 0;
  var_0 = self.visuals[0];
  playFX(common_scripts\utility::getfx("ball_teleport"), var_0.origin);
  _id_0378::snd_message("aud_mp_zombie_relic_teleport", var_0.origin);
  thread _id_04D1::returnhome();
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
        level notify("broadcaster_ball_end", var_0, 1);
        ball_return_home();
        return;
      }

      if(var_0.origin[var_3] < level.ball_mins[var_3] - var_2[var_3]) {
        level notify("broadcaster_ball_end", var_0, 1);
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
  var_1 = getdvarfloat("scr_relic_reset_time", 15);
  var_2 = 15;
  var_3 = 13;

  if(var_1 >= var_2) {
    _setomnvar("ui_broadcaster_game_mode_status_1", var_3);
    _setomnvar("ui_broadcaster_game_mode_status_2", -1);
    var_4 = _getomnvar("ui_broadcaster_game_mode_status_3");

    if(!isDefined(var_0)) {
      if(var_4 == 1 || var_4 == 4 || var_4 == 5) {
        _setomnvar("ui_broadcaster_game_mode_status_3", 5);
      } else {
        _setomnvar("ui_broadcaster_game_mode_status_3", 7);
      }
    } else if(var_4 == 1 || var_4 == 4 || var_4 == 5)
      _setomnvar("ui_broadcaster_game_mode_status_3", 4);
    else {
      _setomnvar("ui_broadcaster_game_mode_status_3", 6);
    }

    wait(var_3);
    var_1 = var_1 - var_3;
  }

  _setomnvar("ui_broadcaster_game_mode_status_1", int(var_1));
  _setomnvar("ui_broadcaster_game_mode_status_2", -1);
  _setomnvar("ui_broadcaster_game_mode_status_3", 0);

  if(var_1 > 15) {
    wait 15;
    level notify("broadcaster_ball_end", self.visuals[0], 1);
    wait(var_1 - 15);
  } else {
    wait(var_1);
    level notify("broadcaster_ball_end", self.visuals[0], 1);
  }

  ball_return_home();
}

ball_physics_bad_trigger_watch() {
  self.visuals[0] endon("physics_finished");
  thread ball_physics_bad_trigger_at_rest();
  wait 0.1;

  for(;;) {
    if(_id_04D1::istouchingbadtrigger()) {
      level notify("broadcaster_ball_end", self.visuals[0], 1);
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

  if(_id_04D1::istouchingbadtrigger()) {
    ball_return_home();
    return;
  }
}

ball_physics_touch_goal() {
  var_0 = self.visuals[0];
  var_0 endon("physics_finished");
  ball_touch_goal_watch(var_0);
}

_id_1546(var_0) {
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
  var_3 = -1 * vectorNormalize(var_1);
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
        level notify("broadcaster_ball_end", var_0, 0);
        thread ball_touched_goal(var_2);
        return;
      }

      if(isDefined(var_0.origin_prev)) {
        var_4 = line_interect_sphere(var_0.origin_prev, var_0.origin, var_2.origin, var_2.radius);

        if(var_4) {
          level notify("broadcaster_ball_end", var_0, 0);
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
  var_1 = getdvarint("scr_relic_points_touchdown", 2);

  if(!isDefined(var_0) || !isDefined(var_0.carryobject)) {
    return;
  }
  if(isDefined(var_0.carryobject.thermalvisionfofoverlayon) && var_0.carryobject.thermalvisionfofoverlayon > gettime()) {
    return;
  }
  var_0.carryobject.thermalvisionfofoverlayon = gettime() + 10000;
  var_0 _id_047A::touchdownevent(var_1);
  ball_check_assist(var_0, 1);
  var_0 thread ball_update_extrascore0();
  var_2 = self.goal.team;
  var_3 = maps\mp\_utility::getotherteam(var_2);
  thread delayedleaderdialog("enemy_throw_score", var_2, "status");
  thread delayedleaderdialog("ally_throw_score", var_3, "status");

  if(should_record_final_score_cam(var_3, var_1)) {
    var_4 = self.goal.killcament;
    var_5 = var_4 getentitynumber();
    var_6 = var_4._id_002B;

    if(!isDefined(var_6)) {
      var_6 = 0;
    }

    var_0.deathtime = gettime();
    level.ball_final_killcam = 1;
    _id_04CE::recordfinalkillcam(5.0, var_0, var_0, var_0 getentitynumber(), var_5, var_6, "none", 0, 0, undefined, "score");
  }

  ball_play_score_fx(self.goal);

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
  var_2 = getdvarint("scr_relic_points_fieldgoal", 1);
  var_3 = getdvarint("scr_relic_points_touchdown", 2);
  maps\mp\_utility::setextrascore0(var_0 * var_2 + var_1 * var_3);
}

should_record_final_score_cam(var_0, var_1) {
  var_2 = _id_04D2::_id_063E(var_0);
  var_3 = _id_04D2::_id_063E(maps\mp\_utility::getotherteam(var_0));
  return var_2 + var_1 >= var_3;
}

line_interect_sphere(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = vectordot(var_4, var_0 - var_2);
  var_5 = var_5 * var_5;
  var_6 = var_0 - var_2;
  var_6 = var_6 * var_6;
  var_7 = var_3 * var_3;
  return var_5 - var_6 + var_7 >= 0;
}

ball_touched_goal(var_0) {
  ball_play_score_fx(var_0);
  var_1 = getdvarint("scr_relic_points_fieldgoal", 1);

  if(isDefined(self.thermalvisionfofoverlayon) && self.thermalvisionfofoverlayon > gettime()) {
    return;
  }
  self.thermalvisionfofoverlayon = gettime() + 10000;
  var_2 = var_0.team;
  var_3 = maps\mp\_utility::getotherteam(var_2);
  thread delayedleaderdialog("enemy_throw_score", var_2, "status");
  thread delayedleaderdialog("ally_throw_score", var_3, "status");

  if(isDefined(self.lastcarrier)) {
    self.lastcarrierscored = 1;
    self.lastcarrier _id_047A::fieldgoalevent(var_1);
    ball_check_assist(self.lastcarrier, 0);
    self.lastcarrier thread ball_update_extrascore0();

    if(isDefined(self.killcament) && should_record_final_score_cam(var_3, var_1)) {
      var_4 = self.killcament;
      var_5 = var_4 getentitynumber();
      var_6 = var_4._id_002B;

      if(!isDefined(var_6)) {
        var_6 = 0;
      }

      var_7 = self.lastcarrier;
      var_0.killcament.deathtime = gettime();
      level.ball_final_killcam = 1;
      _id_04CE::recordfinalkillcam(5.0, var_0.killcament, var_7, var_7 getentitynumber(), var_5, var_6, "none", 0, 0, undefined, "score");
    }
  }

  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }

  thread ball_score_event(var_0);
  ball_give_score(var_3, var_1);
  _setomnvar("ui_broadcaster_game_mode_status_1", -1);

  if(isDefined(self.lastcarrier)) {
    _setomnvar("ui_broadcaster_game_mode_status_2", self.lastcarrier getentitynumber());
  } else {
    _setomnvar("ui_broadcaster_game_mode_status_2", -1);
  }

  if(var_3 == "allies") {
    _setomnvar("ui_broadcaster_game_mode_status_3", 1);
  } else {
    _setomnvar("ui_broadcaster_game_mode_status_3", 2);
  }
}

ball_give_score(var_0, var_1) {
  level _id_04D2::giveteamscoreforobjective(var_0, var_1, 1);

  if(game["status"] == "overtime") {
    game["ball_overtime_team"] = var_0;
    game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
    level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime", game["end_reason"]["switching_sides"]);
  } else if(game["status"] == "overtime_halftime") {
    var_2 = _id_04D2::_id_063E(var_0);
    var_3 = _id_04D2::_id_063E(maps\mp\_utility::getotherteam(var_0));

    if(var_2 >= var_3) {
      level thread maps\mp\gametypes\_gamelogic::endgame(var_0, game["end_reason"]["score_limit_reached"]);
    }
  }
}

ball_score_event(var_0) {
  self notify("score_event");
  self.in_goal = 1;
  var_1 = self.visuals[0];

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var_1 physicsstop();
  _id_04D1::_id_0C1D("none");
  ball_waypoint_upload();
  var_2 = 0.4;
  var_3 = 1.2;
  var_4 = 1.0;
  _id_0378::snd_message("aud_mp_zombie_relic_soul_captured", var_0);
  relic_soul_capture_local_team_sound("mp_zombie_relic_soul_captured", "mp_obj_notify_neg_sml");
  var_5 = var_2 + var_4;
  var_6 = var_5 + var_3;
  var_1 moveTo(var_0, var_2, 0, var_2);
  var_1 rotatevelocity((1080, 1080, 0), var_6, var_6, 0);
  wait(var_5);
  var_1 movez(4000, var_3, var_3 * 0.1, 0);
  wait(var_3);
  _id_04D1::_id_0C1D("any");
  ball_return_home();
}

ball_check_assist(var_0, var_1) {
  if(!isDefined(var_0.passtime) || !isDefined(var_0.passplayer)) {
    return;
  }
  if(var_0.passtime + 3000 < gettime()) {
    return;
  }
  var_0.passplayer _id_047A::ballscoreassistevent();

  if(var_1) {
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_ball_alleyoop");
  }
}

ball_play_score_fx(var_0) {
  var_0.laseron["friendly"] hide();
  var_0.laseron["enemy"] hide();
  var_0.laseron["broadcaster"] hide();

  foreach(var_2 in level.players) {
    var_3 = ball_get_view_team(var_2);

    if(var_3 == "broadcaster") {
      var_0.laseron["broadcaster"] showtoplayer(var_2);
      continue;
    }

    if(var_3 == var_0.team) {
      var_0.laseron["friendly"] showtoplayer(var_2);
      continue;
    }

    var_0.laseron["enemy"] showtoplayer(var_2);
  }

  _triggerfx(var_0.laseron["friendly"]);
  _triggerfx(var_0.laseron["enemy"]);
  _triggerfx(var_0.laseron["broadcaster"]);
}

relic_soul_capture_local_team_sound(var_0, var_1) {
  var_2 = level.player.team;
  var_3 = maps\mp\_utility::getotherteam(level.player.team);

  foreach(var_5 in level.players) {
    if(var_5.team == var_2) {
      var_5 playlocalsound(var_0);
      continue;
    }

    if(var_5.team == var_3) {
      var_5 playlocalsound(var_1);
    }
  }
}

relic_pickup_local_team_sound(var_0, var_1, var_2) {
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
  if(var_0 same_color_code_as_last_time()) {
    return 0;
  }

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

  if(isDefined(var_2) && var_0 isswitchingweapon()) {
    if(!valid_ball_pickup_weapon(var_2)) {
      return 0;
    }
  }

  if(isDefined(var_0.exo_shield_on) && var_0.exo_shield_on == 1) {
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

  if(var_0 == "relic_mp") {
    return 0;
  }

  if(maps\mp\_utility::iskillstreakweapon(var_0) && var_0 != "flamethrower_mp" && var_0 != "flamethrower_german_mp" && var_0 != "flamethrower_grenadier_mp" && var_0 != "flamethrower_german_grenadier_mp" && var_0 != "killstreak_molotov_cocktail_mp" && var_0 != "killstreak_molotov_cocktail_grenadier_mp") {
    return 0;
  }

  return 1;
}

player_no_pickup_time() {
  return isDefined(self.nopickuptime) && self.nopickuptime > gettime();
}

playzombienoises() {
  self endon("death");
  self endon("disconnect");
  level endon("relicDropped");
  level endon("relicReset");
  level endon("game_ended");
  wait 2.5;

  for(;;) {
    switch (randomint(7)) {
      case 0:
        self playSound("zvox_gen_snarl");
        break;
      case 1:
        self playSound("zvox_gen_growl_lev1");
        break;
      case 3:
        self playSound("zvox_gen_pain_lrg");
        break;
      case 5:
        self playSound("zvox_gen_sneakattack_success");
        break;
      case 6:
        self playSound("zvox_gen_taunt");
        break;
      default:
        self playSound("zvox_gen_snarl");
        break;
    }

    wait(_randomfloatrange(3, 6));
  }
}

ball_on_pickup(var_0) {
  maps\mp\gametypes\_gamelogic::pausetimer();
  _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  level.previoussoulcaptureorigin = undefined;

  if(!self.hasbeentouched) {
    var_0 thread _id_047A::firsttouchrelicevent();
  }

  self.hasbeentouched = 1;
  level notify("broadcaster_ball_end", self.visuals[0], 1);
  level.usestartspawns = 0;
  var_1 = self.visuals[0] getlinkedparent();

  if(isDefined(var_1)) {
    self.visuals[0] unlink();
  }

  self.visuals[0] physicsstop();
  self.visuals[0] _id_0488::notify_moving_platform_invalid();
  self.visuals[0] show();
  self.visuals[0] ghost();
  self.trigger _id_0488::stop_handling_moving_platforms();
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
      var_0 thread _id_0485::loggameevent("pass", var_0.origin);
    } else {
      maps\mp\_utility::leaderdialog("you_own_drone", var_3, "status");
      maps\mp\_utility::leaderdialog("enemy_own_drone", var_4, "status");
      var_0 _id_047A::relicinterceptionevent();
    }
  } else {
    maps\mp\_utility::leaderdialog("you_own_drone", var_3, "status");
    maps\mp\_utility::leaderdialog("enemy_own_drone", var_4, "status");
    var_0 thread _id_0485::loggameevent("pickup", var_0.origin);
  }

  var_0 _id_0378::snd_message("aud_mp_zombie_relic_pickup");
  relic_pickup_local_team_sound(var_3, "mp_obj_notify_pos_sml", "mp_obj_notify_neg_sml");
  ball_fx_stop();
  self.lastcarrierscored = 0;
  self.lastcarrier = var_0;
  self.lastcarrierteam = var_0.team;
  self.ownerteam = var_0.team;
  ball_waypoint_held();
  level thread awardcapturepoints(self.ownerteam, var_0);

  if(!isDefined(var_0._id_200D)) {
    var_0._id_200D = 1;
  } else {
    var_0._id_200D = var_0._id_200D + 1;
  }

  var_0 setweaponammoclip("relic_mp", 1);
  var_0 set_grenadeammo([492, 492, 0, 0, 0], var_0.team, 1, 1);
  var_0 thread playzombienoises();
  var_0.hideshieldmodels = 1;

  if(!_isai(var_0) && !istestclient(var_0)) {
    var_5 = common_scripts\utility::getfx("mp_infected_zombie_vision_01");
    _playfxontagforclients(var_5, var_0, "j_head", var_0);
    var_6 = self.visuals[0];
    _playfxontagforclients(common_scripts\utility::getfx("ball_vm"), var_6, "tag_weapon", var_0);
  }

  var_0.balldropdelay = getdvarint("scr_relic_water_drop_delay", 10);
  var_0 maps\mp\_utility::giveperk("specialty_ballcarrier");
  var_0.ball_carried = self;
  var_0._id_0112 = 1;
  _setomnvar("ui_broadcaster_game_mode_status_1", -1);
  _setomnvar("ui_broadcaster_game_mode_status_2", self.carrier getentitynumber());

  if(self.carrier.team == "allies") {
    _setomnvar("ui_broadcaster_game_mode_status_3", 1);
  } else {
    _setomnvar("ui_broadcaster_game_mode_status_3", 2);
  }

  var_0.hasperksprintfire = var_0 hasperk("specialty_sprintfire", 1);
  var_0 maps\mp\_utility::giveperk("specialty_sprintfire");
  var_0 common_scripts\utility::_id_0601();
  var_7 = getdvarint("scr_relic_armor", 25);

  if(var_7 > 0) {
    var_0 thread _id_052C::setlightarmor(var_7);
  } else {
    var_0 thread _id_052C::unsetlightarmor();
  }

  var_0 thread player_update_pass_target(self);
  maps\mp\gametypes\_gamelogic::sethasdonecombat(var_0, 1);
  var_0 thread drop_ball_if_invalid_carrier(self);
}

drop_ball_if_invalid_carrier(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  common_scripts\utility::waittill_notify_or_timeout("mount_force_drop", 2.0);

  if(isDefined(var_0.carrier) && var_0.carrier == self) {
    var_1 = self getcurrentweapon();

    if(var_1 != "relic_mp") {
      var_0 ball_set_dropped();
    }
  }
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
  _id_047A::relicpasskillevent();
  self.relicpasskill = 1;
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
  var_1 = 0.8;

  for(;;) {
    var_2 = undefined;

    if(!self isonladder()) {
      var_3 = anglesToForward(self getplayerangles());
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
        var_10 = vectorNormalize(var_8 - var_4);
        var_11 = vectordot(var_3, var_10);

        if(var_11 > var_1) {
          var_7.pass_dot = var_11;
          var_7.pass_origin = var_8;
          var_5[var_5.size] = var_7;
        }
      }

      var_5 = common_scripts\utility::quicksort(var_5, ::compare_player_pass_dot);

      foreach(var_7 in var_5) {
        if(_sighttracepassed(var_4, var_7.pass_origin, 0, self, var_7)) {
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
        var_1 hudoutlineenableforclient(self, 0, 0);
      }
    }

    if(isDefined(self.pass_target)) {
      self.pass_target hudoutlineenableforclient(self, 2, 0);
    }

    if(var_4.size > 0) {
      self hudoutlineenableforclients(var_4, 1, 1);
    }

    if(var_3.size > 0) {
      self hudoutlineenableforclients(var_3, 2, 0);
    }
  }
}

player_set_pass_target(var_0) {
  if(isDefined(self.pass_target) && isDefined(var_0) && self.pass_target == var_0) {
    return;
  }
  if(!isDefined(self.pass_target) && !_isremovedentity(self.pass_target) && !isDefined(var_0)) {
    return;
  }
  player_clear_pass_target();

  if(isDefined(var_0)) {
    var_1 = (0, 0, 70);
    self.pass_icon = var_0 _id_0479::setheadicon(self, "waypoint_relic_pass_oh", var_1, 30, 30, 0, 0.05, 0, 1, 0, 0);
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
  level notify("relicDropped");

  if(isDefined(level.timerstoppedforgamemode) && level.timerstoppedforgamemode) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  }

  var_1 = self.carrier;

  if(isDefined(var_1) && var_1.team != "spectator") {
    var_2 = var_1.origin;

    if(var_1 getstance() == "stand") {
      if(var_0 == 1) {
        var_2 = var_2 + (0, 0, 60);
      } else {
        var_2 = var_2 + (0, 0, 40);
      }
    } else if(var_1 getstance() == "crouch")
      var_2 = var_2 + (0, 0, 40);
    else {
      var_2 = var_2 + (0, 0, 20);
    }
  } else {
    var_2 = self.detachall;
    var_2 = var_2 + (0, 0, 40);
  }

  var_3 = (0, 0, 0);

  for(var_4 = 0; var_4 < self.visuals.size; var_4++) {
    self.visuals[var_4].origin = var_2;
    self.visuals[var_4].angles = var_3;
    self.visuals[var_4] show();
  }

  self.trigger.origin = var_2;
  ball_dont_interpolate();
  self.curorigin = self.trigger.origin;
  var_1 _id_0378::snd_message("aud_mp_zombie_relic_drop");
  ball_carrier_cleanup();
  ball_fx_start();
  self.ownerteam = "any";
  ball_waypoint_neutral();
  _id_04D1::clearcarrier();
  _id_04D1::updatecompassicons();
  _id_04D1::updateworldicons();
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
  self.trigger thread _id_0488::handle_moving_platforms(var_7);
  return 1;
}

ball_overridemovingplatformdeath(var_0) {}

ball_assign_random_start() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level.previoussoulcaptureorigin) || isDefined(level.previousrelicusedspawns) && level.previousrelicusedspawns.size == level.ball_starts.size) {
    level.previousrelicusedspawns = [];
  }

  var_4 = common_scripts\utility::array_randomize(level.ball_starts);

  foreach(var_6 in var_4) {
    if(var_6.in_use) {
      continue;
    }
    if(isDefined(level.previoussoulcaptureorigin)) {
      var_7 = _distance2d(level.previoussoulcaptureorigin, var_6.origin);

      if(!isDefined(var_3) || var_2 < var_7) {
        var_2 = var_7;
        var_3 = var_6;
      }
    } else if(isDefined(level.previousrelicusedspawns) && level.previousrelicusedspawns.size > 0) {
      if(!common_scripts\utility::_id_0F79(level.previousrelicusedspawns, var_6.origin)) {
        var_1 = var_6;
      }
    }

    var_0 = var_6;
  }

  if(isDefined(var_1)) {
    var_0 = var_1;
  }

  if(isDefined(var_3)) {
    var_0 = var_3;
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

  if(!isDefined(level.previousrelicusedspawns)) {
    level.previousrelicusedspawns = [];
  }

  level.previousrelicusedspawns[level.previousrelicusedspawns.size] = var_0.origin;
}

ball_on_reset() {
  level notify("relicReset");

  if(isDefined(level.timerstoppedforgamemode) && level.timerstoppedforgamemode) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  }

  self.current_start.in_use = 0;
  ball_assign_random_start();
  var_0 = self.visuals[0];
  var_0 _id_0488::notify_moving_platform_invalid();
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

  thread ball_carrier_cleanup();
  _setomnvar("ui_broadcaster_game_mode_status_1", -1);
  _setomnvar("ui_broadcaster_game_mode_status_2", -1);
  _setomnvar("ui_broadcaster_game_mode_status_3", 3);
  self.trigger _id_0488::stop_handling_moving_platforms();
  ball_waypoint_download();
  _id_04D1::setposition(var_0.baseorigin + (0, 0, 4000), (0, 0, 0));

  if(!self.hasbeentouched) {
    var_4 = 12;
  } else {
    var_4 = 6;
  }

  var_0 moveTo(var_0.baseorigin, var_4, 0, var_4);
  var_0 rotatevelocity((0, 720, 0), var_4, 0, var_4);

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
  _playFXOnTag(level._effect["ball_download"], var_0, "tag_weapon");
  common_scripts\utility::waittill_notify_or_timeout("pickup_object", var_1);
  _stopFXOnTag(level._effect["ball_download"], var_0, "tag_weapon");
  self.thermalvisionfofoverlayon = 0;
}

ball_download_wait(var_0) {
  self endon("pickup_object");
  wait(var_0);
  ball_waypoint_neutral();
  level.previoussoulcaptureorigin = undefined;
  playFX(level._effect["ball_download_end"], self.current_start.ground_origin);
  ball_fx_start();
}

ball_carrier_cleanup() {
  if(isDefined(self.carrier)) {
    var_0 = self.carrier;
    var_0.balldropdelay = undefined;
    var_0.nopickuptime = gettime() + 500;
    var_0 player_clear_pass_target();
    var_0 notify("cancel_update_pass_target");
    var_0 maps\mp\_utility::_id_0735("specialty_ballcarrier");
    var_0.ball_carried = undefined;
    var_0 thread _id_052C::unsetlightarmor();

    if(!var_0.hasperksprintfire) {
      var_0 maps\mp\_utility::_id_0735("specialty_sprintfire");
    }

    var_0 common_scripts\utility::_id_0615();
    var_0.hideshieldmodels = 0;
    var_0 setballpassallowed(0);
    var_0 setclientomnvar("ui_uplink_can_pass", 0);
    var_0._id_0112 = 0;

    if(!_isai(var_0) && !istestclient(var_0)) {
      var_1 = common_scripts\utility::getfx("mp_infected_zombie_vision_01");
      _killfxontagforclient(var_1, var_0, "j_head", var_0);
      var_2 = self.visuals[0];
      _killfxontagforclient(common_scripts\utility::getfx("ball_vm"), var_2, "tag_weapon", var_0);
      waitframe();
    }

    if(maps\mp\_utility::getmapname() != "mp_sandbox_01") {
      var_3 = maps\mp\gametypes\_class::_id_1F93(var_0._id_0079, var_0.team);
      var_0 setplayerdata(common_scripts\utility::_id_46A9(), "activeCostume", var_3);
      var_0.costume = var_0 maps\mp\gametypes\_class::cao_getcostumebyindex(var_3);
      var_4 = var_0 maps\mp\gametypes\_class::_id_1F95();
      var_0.costume[1] = var_4[1];
      var_0 maps\mp\gametypes\_class::checkforcostumeset();
      var_0 _id_0510::playercostume();
    }

    var_0 notify("applyLoadout");
  }
}

ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  self.ground_origin = _playerphysicstrace(var_1, var_2);
}

ball_create_team_goal(var_0) {
  var_1 = var_0;

  if(game["switchedsides"]) {
    var_1 = maps\mp\_utility::getotherteam(var_1);
  }

  var_2 = common_scripts\utility::getstruct("ball_goal_" + var_1, "targetname");

  if(isDefined(var_2)) {
    var_2 ball_find_ground();
    var_2.origin = var_2.ground_origin;
  } else {
    var_2 = spawnStruct();

    switch (level._id_015D) {
      default:
        break;
    }

    if(!isDefined(var_2.origin)) {
      var_2.origin = level.default_goal_origins[var_0];
    }

    var_2 ball_find_ground();
    var_2.origin = var_2.ground_origin;
  }

  var_2.radius = 70;
  var_2.team = var_0;
  var_2.ball_in_goal = 0;
  var_2._id_4D3F = 0;
  var_2._id_645F = -1;
  level.ball_goals[var_0] = var_2;
}

ball_create_ball_starts(var_0) {
  var_1 = common_scripts\utility::getstructarray("ball_start", "targetname");
  var_1 = common_scripts\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.setmovespeedscale)) {
      var_3.setmovespeedscale = 100;
    }
  }

  var_1 = common_scripts\utility::quicksort(var_1, ::compare_script_index);

  foreach(var_3 in var_1) {
    ball_add_start(var_3.origin);
  }

  var_7 = 30;

  if(var_1.size == 0) {
    var_8 = (0, 0, 0);

    switch (level._id_015D) {
      default:
        break;
    }

    if(!isDefined(var_8)) {
      var_8 = level.default_ball_origin;
    }

    ball_add_start(var_8);
  }

  var_9 = common_scripts\utility::getstruct("ball_goal_allies", "targetname");
  var_10 = common_scripts\utility::getstruct("ball_goal_axis", "targetname");
  var_11 = [var_9, level.ball_starts[0], var_10];
  var_12 = level.ball_starts[0].origin;
  level.ball_starts = [];
  ball_add_start(var_12);
  var_13 = var_12;
  var_14 = [];
  var_14[var_14.size] = var_13;

  foreach(var_16 in var_11) {
    var_17 = 2;
    var_18 = _getnodesinradius(var_16.origin, 2000, 700, 1200);
    var_18 = common_scripts\utility::array_randomize(var_18);
    var_19 = 0;

    for(var_20 = 0; var_19 < var_17 && var_20 < var_18.size; var_20++) {
      var_21 = var_18[var_20].origin;
      var_22 = 1;

      for(var_23 = 0; var_22 && var_23 < var_14.size; var_23++) {
        if(_distance2d(var_14[var_23], var_21) < 700) {
          var_22 = 0;
        }
      }

      if(var_22 && _distance2d(var_13, var_21) > 800) {
        ball_add_start(var_21);
        var_19++;
        var_13 = var_21;
        var_14[var_14.size] = var_13;
      }
    }
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
  return var_0.setmovespeedscale <= var_1.setmovespeedscale;
}

ball_on_connect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.ball_goal_fx = [];
    var_0 thread player_on_disconnect();
    var_0 thread _id_0513::initteslagun();
  }
}

player_on_disconnect() {
  self waittill("disconnect");
}

ball_goal_fx_for_player(var_0) {
  var_1 = ball_get_view_team(var_0);

  if(var_1 == "broadcaster") {}

  var_0 player_delete_ball_goal_fx();

  foreach(var_6, var_3 in level.ball_goals) {
    if(var_1 == "broadcaster") {
      var_4 = common_scripts\utility::ter_op(var_6 == "allies", "ball_goal_allies_blue", "ball_goal_axis_red");
    } else if(var_3.team == "allies") {
      if(var_1 == "axis") {
        var_4 = "ball_goal_allies_red";
      } else {
        var_4 = "ball_goal_allies_blue";
      }
    } else if(var_1 == "axis")
      var_4 = "ball_goal_axis_blue";
    else {
      var_4 = "ball_goal_axis_red";
    }

    var_5 = _spawnfxforclient(common_scripts\utility::getfx(var_4), var_3.origin + (0, 0, 15), var_0);
    setfxkillondelete(var_5, 1);
    var_0.ball_goal_fx[var_4] = var_5;
    _triggerfx(var_5);
  }
}

ball_get_view_team(var_0) {
  var_1 = var_0.team;

  if(var_0 ismlgspectator()) {
    var_1 = "broadcaster";
  } else if(var_1 != "allies" && var_1 != "axis") {
    var_1 = "allies";
  }

  return var_1;
}

monitorbroadcasterfxchanged() {
  self endon("disconnect");
  self endon("game_ended");

  for(;;) {
    self waittill("changeGoalFx");
    player_delete_ball_goal_fx();

    foreach(var_4, var_1 in level.ball_goals) {
      var_2 = common_scripts\utility::ter_op(var_4 == "allies", "ball_goal_allies_blue", "ball_goal_axis_red");

      if(self.camera._id_A4A8 == "first_person") {
        if(var_1.team == "allies") {
          if(var_4 == self.camera._id_9815.team) {
            var_2 = "ball_goal_allies_blue";
          } else {
            var_2 = "ball_goal_allies_red";
          }
        } else if(var_4 == self.camera._id_9815.team)
          var_2 = "ball_goal_axis_blue";
        else {
          var_2 = "ball_goal_axis_red";
        }
      }

      var_3 = _spawnfxforclient(common_scripts\utility::getfx(var_2), var_1.origin + (0, 0, 15), self);
      setfxkillondelete(var_3, 1);
      self.ball_goal_fx[var_2] = var_3;
      _triggerfx(var_3);
    }

    waitframe();
  }
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
  }
}

delayedleaderdialog(var_0, var_1, var_2) {
  level endon("game_ended");
  wait 1.2;
  maps\mp\_utility::leaderdialog(var_0, var_1, var_2);
}

attemptdropteslagun(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(getdvarint("spv_tesla_mp_active", 0) == 1) {
    level thread _id_0513::potentiallyspawnteslagun(var_0, 100);
  }
}