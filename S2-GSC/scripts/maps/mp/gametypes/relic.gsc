/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\relic.gsc
***********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_func_133()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    _func_035("scr_relic_num_balls", 1);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  var_0 = getdvarint("scr_relic_num_balls", 1);
  _func_032("ui_uplink_num_balls", var_0);
  setdvarifuninitialized("spv_tesla_mp_active", 0);
  maps\mp\_utility::setovertimelimitdvar(3);

  if(isDefined(game["round_time_to_beat"])) {
    maps\mp\_utility::setovertimelimitdvar(game["round_time_to_beat"]);
    game["round_time_to_beat"] = undefined;
  }

  maps\mp\_utility::_id_873B(1);
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 0;
  level.disabledivisionchallenges = 0;
  level.disablewinlossstats = 1;
  level.mgnestsdisabled = 0;
  level._id_3FC9 = ::_id_6BBC;

  if(level._id_6031 || level._id_6035)
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;

  level._effect["mp_infected_zombie_vision_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_01");
  level._effect["infected_turn_lightning_01"] = loadfx("vfx/unique/infected_turn_lightning_01");
  level thread _id_1534();
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _func_035("scr_relic_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("ball", 0, 0, 9);
  _func_035("scr_relic_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("ball", 1);
  _func_035("scr_relic_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("ball", 1);
  _func_035("scr_relic_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("ball", 0);
  var_0 = _func_132("ballData", "numBalls");
  var_0 = max(1, var_0);
  _func_035("scr_relic_num_balls", var_0);
  _func_035("scr_relic_reset_time", _func_132("ballData", "ballResetTime"));
  _func_035("scr_relic_points_touchdown", _func_132("ballData", "carryScore"));
  _func_035("scr_relic_points_fieldgoal", _func_132("ballData", "throwScore"));
  _func_035("scr_relic_armor", _func_132("ballData", "armorValue"));
}

_id_6BAF() {
  level.reliccapturepercentage["allies"] = 0;
  level.reliccapturepercentage["axis"] = 0;
  level.reliccapturetime["allies"] = 0;
  level.reliccapturetime["axis"] = 0;
  updateallplayersstatusomnvars();
  _func_157("auto_change");

  if(game["status"] == "halftime")
    _func_032("ui_current_round", 2);
  else if(game["status"] == "overtime")
    _func_032("ui_current_round", 3);
  else if(game["status"] == "overtime_halftime")
    _func_032("ui_current_round", 4);

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(maps\mp\_utility::_id_576C(game["status"]))
    game["switchedsides"] = !game["switchedsides"];

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(game["status"] == "overtime") {
    game["teamScores"]["allies"] = 0;
    _func_156("allies", 0);
    game["teamScores"]["axis"] = 0;
    _func_156("axis", 0);
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
  _id_151C();
  var_2[0] = level.gametype;
  var_2[1] = "blocker_ball";
  _id_04D1::main(var_2);
  level thread _id_7F58();
  _id_050D::_id_10E4();
  level thread playerjoinedupdateomnvars();
}

_id_6B42(var_0) {
  foreach(var_2 in level._id_1562)
  var_2._id_A582[0] _meth_84E0();

  maps\mp\gametypes\_gamelogic::_id_2BAE(var_0);
}

_id_6BB6() {
  var_0 = undefined;
  level._id_3B5C = "none";

  foreach(var_2 in level._id_1562)
  var_2._id_A582[0] _meth_84E0();

  if(game["status"] == "halftime" || game["status"] == "overtime_halftime") {
    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level._id_3B5C = "axis";
      var_0 = "axis";
    } else if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      level._id_3B5C = "allies";
      var_0 = "allies";
    } else if(game["status"] == "halftime")
      var_0 = "overtime";
    else if(isDefined(game["ball_overtime_team"]))
      var_0 = game["ball_overtime_team"];
    else
      var_0 = "tie";
  } else if(game["status"] == "overtime")
    var_0 = "overtime_halftime";

  _func_18D("time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  level thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, game["end_reason"]["time_limit_reached"]);
}

updateallplayersstatusomnvars() {
  var_0 = level.reliccapturepercentage["allies"];
  var_1 = game["teamScores"]["allies"];
  var_2 = level.reliccapturepercentage["axis"];
  var_3 = game["teamScores"]["axis"];

  foreach(var_5 in level.players) {
    if(!isDefined(var_5) || isbot(var_5) || _func_1EF(var_5)) {
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

    var_5 _meth_82FF("ui_onevone_class_1", var_6);
    var_5 _meth_82FF("ui_onevone_class_2", var_7);
    var_5 _meth_82FF("ui_onevone_class_3", var_8);
    var_5 _meth_82FF("ui_onevone_class_4", var_9);
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

  var_0 _meth_82FF("ui_onevone_class_1", var_5);
  var_0 _meth_82FF("ui_onevone_class_2", var_6);
  var_0 _meth_82FF("ui_onevone_class_3", var_7);
  var_0 _meth_82FF("ui_onevone_class_4", var_8);
}

playerjoinedupdateomnvars() {
  level endon("game_ended");

  for(;;) {
    level waittill("joined_team", var_0);
    thread updateplayerstatusomnvars(var_0);
  }
}

awardgoal(var_0, var_1) {
  var_2 = common_scripts\utility::_id_44F5("infected_turn_lightning_01");
  _func_147(var_2, var_1, "tag_origin");
  level.previoussoulcaptureorigin = var_1.origin;
  _id_04D2::_id_47BD(var_0, 1, 1);
  level.reliccapturetime[var_0] = 0;
  level.reliccapturepercentage[var_0] = 0;
  thread updateallplayersstatusomnvars();

  if(!isDefined(var_1.souls_captured))
    var_1.souls_captured = 0;

  var_1.souls_captured = var_1.souls_captured + 1;
  var_1.pers["souls"] = var_1.souls_captured;
  var_1 maps\mp\_utility::_id_867C(var_1.pers["souls"]);
  var_1 thread _id_047A::relicgoalevent();
  level._id_1562[0]._id_5B7F = 1;
  level._id_1562[0].hasbeentouched = 0;
  level._id_1562[0] _id_1550(1);
  level._id_1562[0] _id_154E(var_1.origin);
  var_1 _id_0468::_id_0A22("soulCap");
}

_id_1455(var_0, var_1) {
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
    maps\mp\gametypes\_hostmigration::_id_A782();
    var_6 = var_6 + var_2;

    if(isDefined(level._id_1562[0]._id_2006) && level._id_1562[0]._id_2006 == var_1) {
      level.reliccapturetime[var_0] = level.reliccapturetime[var_0] + var_5;
      level.reliccapturepercentage[var_0] = int(100 * (level.reliccapturetime[var_0] / 30));

      if(!isDefined(var_1.time_holding_relic))
        var_1.time_holding_relic = 0;

      var_1.time_holding_relic = var_1.time_holding_relic + var_2;
      var_1.pers["time"] = var_1.time_holding_relic;
      var_1 maps\mp\_utility::_id_867B(var_1.pers["time"]);

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
  foreach(var_1 in level._id_1562) {
    if(isDefined(var_1._id_2006) && var_1._id_2006 == self) {
      self._id_A95F = _id_04D1::_id_466D(var_1);
      var_1 thread _id_04D1::_id_866E();
      return;
    }
  }

  if(self getcurrentweapon() == "relic_mp" && isDefined(self._id_20CC))
    self._id_A95F = self._id_20CC;
  else if(isDefined(self._id_6EA7) && self._id_6EA7) {
    var_3 = self getweaponlistprimaries();
    self._id_A95F = common_scripts\utility::_id_98E7(var_3.size, var_3[0], undefined);
  }

  self._id_1561 = undefined;
}

_id_6BBC(var_0) {
  forceballsfromplayer();
}

_id_6B5C(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._id_6C63[var_1.team]])
    var_1._id_3B4B = 1;
}

_id_1518() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_154B();
    var_0 thread _id_155A();
  }
}

_id_154B() {
  foreach(var_1 in level._id_1562)
  var_1 _id_1523(self);
}

_id_7F58() {
  level._id_1554 = [];
  level._id_1562 = [];
  var_0 = getdvarint("scr_relic_num_balls", 1);
  _id_1519(var_0);
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
  level thread _id_1518();
  _id_152E();

  for(var_1 = 0; var_1 < var_0 && var_1 < level._id_1554.size; var_1++)
    _id_1552(var_1);

  maps\mp\_utility::gameflagwait("prematch_done");

  foreach(var_3 in level.players)
  var_3 thread maps\mp\gametypes\_hud_message::_id_9102("relic_intro");
}

_id_151C() {
  level._id_2B9D = [];
  var_0 = getEntArray("flag_primary", "targetname");

  foreach(var_2 in var_0) {
    switch (var_2._id_81E8) {
      case "_a":
        level._id_2B9D[game["attackers"]] = var_2.origin;
        break;
      case "_b":
        level._id_2B93 = var_2.origin;
        break;
      case "_c":
        level._id_2B9D[game["defenders"]] = var_2.origin;
        break;
    }
  }
}

_id_152E() {
  level._id_1532 = (1000, 1000, 1000);
  level._id_1531 = (-1000, -1000, -1000);
  var_0 = _func_0B7();

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      level._id_1532 = _id_050D::_id_3915(level._id_1532, var_2.origin);
      level._id_1531 = _id_050D::_id_3914(level._id_1531, var_2.origin);
    }
  } else {
    level._id_1532 = level._id_907A;
    level._id_1531 = level._id_9077;
  }
}

_id_152A() {
  foreach(var_2, var_1 in level._id_152B) {
    var_1._id_9D65 = spawn("trigger_radius", var_1.origin - (0, 0, var_1.radius), 0, var_1.radius, var_1.radius * 2);
    var_1._id_A223 = _id_04D1::_id_2837(var_2, var_1._id_9D65, [], (0, 0, var_1.radius * 2.1));
    var_1._id_A223._id_4800 = var_1;
    var_1._id_A223 _id_04D1::_id_860A("friendly", "waypoint_ball_defend");
    var_1._id_A223 _id_04D1::_id_860A("enemy", "waypoint_ball_goal");
    var_1._id_A223 _id_04D1::_id_860E("friendly", "waypoint_ball_defend");
    var_1._id_A223 _id_04D1::_id_860E("enemy", "waypoint_ball_goal");

    if(var_2 == "allies")
      maps\mp\_utility::_id_863F(var_1._id_A223, level.iconalliesgoal, 2);
    else
      maps\mp\_utility::_id_863F(var_1._id_A223, level.iconaxisgoal, 1);

    var_1._id_A223 _id_04D1::_id_8A60("any");
    var_1._id_A223 _id_04D1::_id_0C30("enemy");
    var_1._id_A223 _id_04D1::_id_86B5(level._id_1562);
    var_1._id_A223 _id_04D1::_id_8A5A(0);
    var_1._id_A223._id_6BBF = ::_id_1513;
    var_1._id_A223._id_1F84 = ::_id_1527;
    var_1 thread _id_8A29();
  }
}

_id_8A29() {
  var_0 = spawn("script_origin", self.origin);
  var_0.angles = self.angles;
  var_0 _meth_82BA(-45, 0.05);
  waitframe();
  var_1 = self.origin + (0, 0, 5);
  var_2 = self.origin + anglesToForward(var_0.angles) * 100 + (0, 0, 128);
  var_3 = bulletTrace(var_1, var_2, 0, self);
  var_4 = var_3["position"];

  if(var_3["fraction"] < 1.0)
    var_4 = var_4 + var_3["normal"] * 5;

  self._id_5A2C = spawn("script_model", var_4);
  self._id_5A2C _meth_834D("explosive");
  var_0 delete();
}

_id_1528() {
  foreach(var_2, var_1 in level._id_152B) {
    var_1._id_80A4["friendly"] = _func_14B(common_scripts\utility::_id_44F5("ball_goal_activated_blue"), var_1.origin, (1, 0, 0));
    var_1._id_80A4["enemy"] = _func_14B(common_scripts\utility::_id_44F5("ball_goal_activated_red"), var_1.origin, (1, 0, 0));

    if(var_2 == "allies") {
      var_1._id_80A4["broadcaster"] = _func_14B(common_scripts\utility::_id_44F5("ball_goal_activated_orange"), var_1.origin, (1, 0, 0));
      continue;
    }

    var_1._id_80A4["broadcaster"] = _func_14B(common_scripts\utility::_id_44F5("ball_goal_activated_yellow"), var_1.origin, (1, 0, 0));
  }

  level thread _id_1548();

  foreach(var_4 in level.players)
  _id_1529(var_4);
}

_id_1552(var_0) {
  var_1 = level._id_1554[var_0];
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("npc_soccer_ball_zombie_01");
  var_2 _meth_82C2();
  var_2 thread _id_6FA2();
  var_3 = 24;
  var_4 = _func_18E("ball_pickup_" + (var_0 + 1), "targetname");

  if(isDefined(var_4))
    var_4.origin = var_2.origin;
  else
    var_4 = spawn("trigger_radius", var_2.origin - (0, 0, var_3 / 2), 0, var_3, var_3);

  var_4 _meth_8070();
  var_4 _meth_8055(var_2);
  var_4._id_66F0 = 1;
  var_5 = [var_2];
  var_6 = _id_04D1::_id_27D6("any", var_4, var_5, (0, 0, 32), 1, 0, 1);
  var_6._id_695F = 1;
  var_6 _id_04D1::_id_0C1D("any");
  var_6 _id_155D();
  var_6 _id_04D1::_id_8A60("any");
  var_6._id_698F = 1;
  var_6._id_6993 = 1.0;
  var_6._id_0C33 = 0;
  var_6._id_201C = "relic_mp";
  var_6._id_59D8 = 1;
  var_6._id_A965 = 0;
  var_6._id_A581 = (0, 0, 30);
  var_6._id_1F84 = ::_id_150E;
  var_6._id_6B62 = ::_id_1535;
  var_6._id_866E = ::_id_1550;
  var_6._id_6B93 = ::_id_1538;
  var_6._id_201D = ::_id_153A;
  var_6._id_50CB = 0;
  var_6._id_5B7F = 0;
  var_6._id_7D25 = 1;
  var_6.hasbeentouched = 0;
  var_6 _id_150A(var_1);
  level._id_1562[level._id_1562.size] = var_6;
  var_6 _id_1522();
  var_6 thread _id_1530(var_0);
  _func_032("ui_broadcaster_game_mode_status_1", -1);
  _func_032("ui_broadcaster_game_mode_status_2", -1);
  _func_032("ui_broadcaster_game_mode_status_3", 3);
}

_id_6FA2() {
  self endon("death");

  for(;;) {
    self waittill("physics_impact", var_0, var_1, var_2, var_3);
    var_4 = level._effect["ball_physics_impact"];

    if(isDefined(var_3) && isDefined(level._effect["ball_physics_impact_" + var_3]))
      var_4 = level._effect["ball_physics_impact_" + var_3];

    playFX(var_4, var_0, var_1);
    var_5 = vectordot(var_2, var_1);

    if(var_5 > 0.5)
      self playSound("grid_ball_bounce");

    wait 0.3;
  }
}

_id_1530(var_0) {
  if(var_0 > 4 || var_0 < 0) {
    return;
  }
  for(;;) {
    var_1 = common_scripts\utility::_id_A715("pickup_object", "dropped", "reset");

    switch (var_1) {
      case "pickup_object":
        _func_032("ui_uplink_ball_carrier" + (var_0 + 1), self._id_2006 getentitynumber());
        break;
      case "dropped":
        _func_032("ui_uplink_ball_carrier" + (var_0 + 1), -2);
        break;
      case "reset":
        _func_032("ui_uplink_ball_carrier" + (var_0 + 1), -1);
        break;
      default:
        break;
    }
  }
}

_id_155D() {
  _id_04D1::_id_860A("friendly", "waypoint_ball");
  _id_04D1::_id_860A("enemy", "waypoint_ball");
  _id_04D1::_id_860E("friendly", "waypoint_ball");
  _id_04D1::_id_860E("enemy", "waypoint_ball");
  maps\mp\_utility::_id_863F(self, level.iconneutralball, 3);
  _func_032("ui_hardpoint_status", 0);
}

_id_155C() {
  _id_04D1::_id_860A("friendly", "waypoint_ball_friendly");
  _id_04D1::_id_860A("enemy", "waypoint_ball_enemy");
  _id_04D1::_id_860E("friendly", "waypoint_ball_friendly");
  _id_04D1::_id_860E("enemy", "waypoint_ball_enemy");

  if(self._id_6DB2 == "allies") {
    maps\mp\_utility::_id_863F(self, level.iconheldball, 2);
    _func_032("ui_hardpoint_status", 2);
  } else {
    maps\mp\_utility::_id_863F(self, level.iconheldball, 1);
    _func_032("ui_hardpoint_status", 1);
  }
}

_id_155B() {
  _id_04D1::_id_860A("friendly", "waypoint_ball");
  _id_04D1::_id_860A("enemy", "waypoint_ball");
  _id_04D1::_id_860E("friendly", "waypoint_ball");
  _id_04D1::_id_860E("enemy", "waypoint_ball");
  maps\mp\_utility::_id_863F(self, level.iconneutralball, 3);
}

_id_155E() {
  _id_04D1::_id_860A("friendly", "waypoint_ball");
  _id_04D1::_id_860A("enemy", "waypoint_ball");
  _id_04D1::_id_860E("friendly", "waypoint_ball");
  _id_04D1::_id_860E("enemy", "waypoint_ball");
  maps\mp\_utility::_id_863F(self, level.iconneutralball, 3);
}

_id_151D() {
  self._id_A582[0] _meth_808C();
  self._id_1521 = 0;
}

_id_1522() {
  if(!_id_1521()) {
    var_0 = self._id_A582[0];
    _func_147(common_scripts\utility::_id_44F5("ball_trail"), var_0, "tag_weapon");
    _func_147(common_scripts\utility::_id_44F5("ball_vm"), var_0, "tag_weapon");
    self._id_1521 = 1;
  }
}

_id_1523(var_0) {
  if(_id_1521()) {
    var_1 = self._id_A582[0];
    _func_14D(common_scripts\utility::_id_44F5("ball_trail"), var_1, "tag_weapon", var_0);
    _func_14D(common_scripts\utility::_id_44F5("ball_vm"), var_1, "tag_weapon", var_0);
  }
}

_id_1524() {
  if(_id_1521()) {
    var_0 = self._id_A582[0];
    _func_148(common_scripts\utility::_id_44F5("ball_trail"), var_0, "tag_weapon");
    _func_148(common_scripts\utility::_id_44F5("ball_vm"), var_0, "tag_weapon");
  }

  self._id_1521 = 0;
}

_id_1521() {
  return isDefined(self._id_1521) && self._id_1521;
}

_id_153A() {
  self endon("disconnect");
  self _meth_84D2("none", 1);
  thread _id_153E();
  thread _id_1551();
  self._id_2016 waittill("dropped");
}

_id_153E() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  for(;;) {
    self waittill("ball_pass", var_0);

    if(var_0 != "relic_mp") {
      continue;
    }
    if(!isDefined(self._id_6EA9)) {
      self iprintlnbold("No Pass Target");
      continue;
    }

    break;
  }

  if(isDefined(self._id_2016)) {
    thread _id_153B();
    var_1 = self._id_6EA9;
    var_2 = self._id_6EA9.origin;
    wait 0.15;

    if(isDefined(self._id_6EA9))
      var_1 = self._id_6EA9;

    self._id_2016 thread _id_153C(self, var_1, var_2);
  }
}

_id_153C(var_0, var_1, var_2) {
  _id_1550(1);

  if(isDefined(var_1))
    var_2 = var_1.origin;

  var_3 = (0, 0, 40);
  var_4 = vectorNormalize(var_2 + var_3 - self._id_A582[0].origin);
  var_5 = var_4 * 1000;
  self._id_776C = _func_071("gamemode_ball", self._id_A582[0].origin, var_5, 30, var_0, 1, 1);

  if(isDefined(var_1))
    self._id_776C _meth_81D9(var_1);

  self._id_A582[0] _meth_8055(self._id_776C);
  _id_151D();
  _id_151A();
  _id_1517();
  thread _id_1537();
  thread _id_1536();
}

_id_151A() {
  if(isDefined(self._id_5A2C))
    self._id_5A2C delete();

  self._id_5A2C = spawn("script_model", self._id_A582[0].origin);
  self._id_5A2C _meth_8055(self._id_A582[0]);
  self._id_5A2C _meth_80B1();
  self._id_5A2C _meth_834D("explosive");
}

_id_1517() {
  self._id_A582[0]._id_6A2D = self._id_A582[0] _meth_80B1();
}

_id_154C() {
  if(isDefined(self._id_A582[0]._id_6A2D)) {
    self._id_A582[0] _meth_80B0(self._id_A582[0]._id_6A2D);
    self._id_A582[0]._id_6A2D = undefined;
  }
}

_id_1537() {
  self endon("pass_end");
  self._id_776C waittill("projectile_impact_player", var_0);
  self._id_9D65 notify("trigger", var_0);
}

_id_1536() {
  self._id_776C waittill("death");
  var_0 = self._id_A582[0];

  if(!isDefined(self._id_2006) && !self._id_50CB) {
    if(var_0.origin != var_0._id_162D + (0, 0, 4000))
      _id_1542((0, 0, 10));
  }

  _id_154C();
  var_0 notify("pass_end");
}

_id_1551() {
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

  if(isDefined(self._id_2016)) {
    var_3 = self getplayerangles();
    var_3 = var_3 + (var_0, 0, 0);
    var_3 = (clamp(var_3[0], -85, 85), var_3[1], var_3[2]);
    var_4 = anglesToForward(var_3);
    thread _id_153B();
    waitframe();
    self playSound("grid_ball_throw");
    thread _id_1515(self._id_2016);
    self._id_2016 _id_151A();
    self._id_2016 thread _id_1543(var_4 * var_1, self);
  }
}

_id_153B() {
  self endon("death");
  self endon("disconnect");
  self._id_6EA7 = 1;
  self _meth_812A(0);

  while("relic_mp" == self getcurrentweapon())
    waitframe();

  self _meth_812A(1);
  self._id_6EA7 = 0;
}

_id_1543(var_0, var_1) {
  _id_1550(1);
  _id_1542(var_0, var_1);
}

_id_1542(var_0, var_1) {
  var_2 = self._id_A582[0];
  var_2._id_6C43 = undefined;
  _id_1522();
  level notify("broadcaster_throw_ball", self._id_5B7E, self, vectorNormalize(var_0));
  var_2 _meth_8272(var_2.origin, var_0);
  thread _id_1544();
  thread _id_1545(var_1);
  thread _id_1540();
  thread _id_1546(var_1);
}

_id_154D() {
  self._id_50CB = 0;
  var_0 = self._id_A582[0];
  playFX(common_scripts\utility::_id_44F5("ball_teleport"), var_0.origin);
  _id_0378::_id_8D74("aud_mp_zombie_relic_teleport", var_0.origin);
  thread _id_04D1::_id_7E30();
}

_id_1544() {
  self endon("reset");
  self endon("pickup_object");
  var_0 = self._id_A582[0];
  var_1[0] = 200;
  var_1[1] = 200;
  var_1[2] = 1000;
  var_2[0] = 200;
  var_2[1] = 200;
  var_2[2] = 200;

  for(;;) {
    for(var_3 = 0; var_3 < 2; var_3++) {
      if(var_0.origin[var_3] > level._id_1531[var_3] + var_1[var_3]) {
        level notify("broadcaster_ball_end", var_0, 1);
        _id_154D();
        return;
      }

      if(var_0.origin[var_3] < level._id_1532[var_3] - var_2[var_3]) {
        level notify("broadcaster_ball_end", var_0, 1);
        _id_154D();
        return;
      }
    }

    waitframe();
  }
}

_id_1545(var_0) {
  self endon("reset");
  self endon("pickup_object");
  self endon("score_event");
  var_1 = getdvarfloat("scr_relic_reset_time", 15);
  var_2 = 15;
  var_3 = 13;

  if(var_1 >= var_2) {
    _func_032("ui_broadcaster_game_mode_status_1", var_3);
    _func_032("ui_broadcaster_game_mode_status_2", -1);
    var_4 = _func_033("ui_broadcaster_game_mode_status_3");

    if(!isDefined(var_0)) {
      if(var_4 == 1 || var_4 == 4 || var_4 == 5)
        _func_032("ui_broadcaster_game_mode_status_3", 5);
      else
        _func_032("ui_broadcaster_game_mode_status_3", 7);
    } else if(var_4 == 1 || var_4 == 4 || var_4 == 5)
      _func_032("ui_broadcaster_game_mode_status_3", 4);
    else
      _func_032("ui_broadcaster_game_mode_status_3", 6);

    wait(var_3);
    var_1 = var_1 - var_3;
  }

  _func_032("ui_broadcaster_game_mode_status_1", int(var_1));
  _func_032("ui_broadcaster_game_mode_status_2", -1);
  _func_032("ui_broadcaster_game_mode_status_3", 0);

  if(var_1 > 15) {
    wait 15;
    level notify("broadcaster_ball_end", self._id_A582[0], 1);
    wait(var_1 - 15);
  } else {
    wait(var_1);
    level notify("broadcaster_ball_end", self._id_A582[0], 1);
  }

  _id_154D();
}

_id_1540() {
  self._id_A582[0] endon("physics_finished");
  thread _id_153F();
  wait 0.1;

  for(;;) {
    if(_id_04D1::_id_5808()) {
      level notify("broadcaster_ball_end", self._id_A582[0], 1);
      _id_154D();
      return;
    }

    waitframe();
  }
}

_id_153F() {
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = self._id_A582[0];
  var_0 endon("death");
  var_0 waittill("physics_finished");

  if(_id_04D1::_id_5808()) {
    _id_154D();
    return;
  }
}

_id_1547() {
  var_0 = self._id_A582[0];
  var_0 endon("physics_finished");
  _id_1558(var_0);
}

_id_1546(var_0) {
  var_1 = self._id_A582[0];
  var_2 = self._id_9D65;
  var_1 endon("physics_finished");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isDefined(var_0) && var_0 == var_3 && var_3 _id_72F0()) {
      continue;
    }
    if(self._id_34B1 >= gettime()) {
      continue;
    }
    if(var_1.origin == var_1._id_162D + (0, 0, 4000)) {
      continue;
    }
    if(!_id_150E(var_3))
      thread _id_1541();
  }
}

_id_1541() {
  var_0 = self._id_A582[0];

  if(!var_0 _meth_8524()) {
    return;
  }
  var_1 = var_0 _meth_841B();
  var_2 = length(var_1) / 10;
  var_3 = -1 * vectorNormalize(var_1);
  var_0 _meth_84E0();
  var_0 _meth_8272(var_0.origin, var_3 * var_2);
}

_id_153D() {
  var_0 = self._id_A582[0];
  var_0 endon("pass_end");
  _id_1558(var_0);
}

_id_1558(var_0) {
  for(;;) {
    foreach(var_5, var_2 in level._id_152B) {
      if(self._id_5B80 == var_5) {
        continue;
      }
      if(!var_2._id_A223 _id_1527()) {
        continue;
      }
      var_3 = distance(var_0.origin, var_2.origin);

      if(var_3 <= var_2.radius) {
        level notify("broadcaster_ball_end", var_0, 0);
        thread _id_1559(var_2);
        return;
      }

      if(isDefined(var_0._id_6C43)) {
        var_4 = _id_5D90(var_0._id_6C43, var_0.origin, var_2.origin, var_2.radius);

        if(var_4) {
          level notify("broadcaster_ball_end", var_0, 0);
          thread _id_1559(var_2);
          return;
        }
      }
    }

    waitframe();
  }
}

_id_1527(var_0) {
  var_1 = self._id_4800;

  if(var_1._id_152C)
    return 0;

  return 1;
}

_id_1513(var_0) {
  var_1 = getdvarint("scr_relic_points_touchdown", 2);

  if(!isDefined(var_0) || !isDefined(var_0._id_2016)) {
    return;
  }
  if(isDefined(var_0._id_2016._id_80AA) && var_0._id_2016._id_80AA > gettime()) {
    return;
  }
  var_0._id_2016._id_80AA = gettime() + 10000;
  var_0 _id_047A::_id_9ABB(var_1);
  _id_1514(var_0, 1);
  var_0 thread _id_155A();
  var_2 = self._id_4800.team;
  var_3 = maps\mp\_utility::getotherteam(var_2);
  thread _id_2CDB("enemy_throw_score", var_2, "status");
  thread _id_2CDB("ally_throw_score", var_3, "status");

  if(_id_8B6F(var_3, var_1)) {
    var_4 = self._id_4800._id_5A2C;
    var_5 = var_4 getentitynumber();
    var_6 = var_4._id_002B;

    if(!isDefined(var_6))
      var_6 = 0;

    var_0._id_2AB8 = gettime();
    level.ball_final_killcam = 1;
    _id_04CE::_id_7B32(5.0, var_0, var_0, var_0 getentitynumber(), var_5, var_6, "none", 0, 0, undefined, "score");
  }

  _id_154A(self._id_4800);

  if(isDefined(var_0._id_8B11))
    var_0._id_8B11._id_54F5 = 0;

  var_7 = var_0._id_2016;
  var_7._id_5B7F = 1;
  var_7 _id_1550(1);
  var_7 thread _id_154E(self._id_4800);
  _id_1526(var_3, var_1);
}

_id_155A() {
  waittillframeend;
  var_0 = maps\mp\_utility::getplayerstat("fieldgoal");
  var_1 = maps\mp\_utility::getplayerstat("touchdown");
  var_2 = getdvarint("scr_relic_points_fieldgoal", 1);
  var_3 = getdvarint("scr_relic_points_touchdown", 2);
  maps\mp\_utility::_id_867B(var_0 * var_2 + var_1 * var_3);
}

_id_8B6F(var_0, var_1) {
  var_2 = _id_04D2::_id_063E(var_0);
  var_3 = _id_04D2::_id_063E(maps\mp\_utility::getotherteam(var_0));
  return var_2 + var_1 >= var_3;
}

_id_5D90(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = vectordot(var_4, var_0 - var_2);
  var_5 = var_5 * var_5;
  var_6 = var_0 - var_2;
  var_6 = var_6 * var_6;
  var_7 = var_3 * var_3;
  return var_5 - var_6 + var_7 >= 0;
}

_id_1559(var_0) {
  _id_154A(var_0);
  var_1 = getdvarint("scr_relic_points_fieldgoal", 1);

  if(isDefined(self._id_80AA) && self._id_80AA > gettime()) {
    return;
  }
  self._id_80AA = gettime() + 10000;
  var_2 = var_0.team;
  var_3 = maps\mp\_utility::getotherteam(var_2);
  thread _id_2CDB("enemy_throw_score", var_2, "status");
  thread _id_2CDB("ally_throw_score", var_3, "status");

  if(isDefined(self._id_5B7E)) {
    self._id_5B7F = 1;
    self._id_5B7E _id_047A::_id_3AA1(var_1);
    _id_1514(self._id_5B7E, 0);
    self._id_5B7E thread _id_155A();

    if(isDefined(self._id_5A2C) && _id_8B6F(var_3, var_1)) {
      var_4 = self._id_5A2C;
      var_5 = var_4 getentitynumber();
      var_6 = var_4._id_002B;

      if(!isDefined(var_6))
        var_6 = 0;

      var_7 = self._id_5B7E;
      var_0._id_5A2C._id_2AB8 = gettime();
      level.ball_final_killcam = 1;
      _id_04CE::_id_7B32(5.0, var_0._id_5A2C, var_7, var_7 getentitynumber(), var_5, var_6, "none", 0, 0, undefined, "score");
    }
  }

  if(isDefined(self._id_5A2C))
    self._id_5A2C _meth_8057();

  thread _id_154E(var_0);
  _id_1526(var_3, var_1);
  _func_032("ui_broadcaster_game_mode_status_1", -1);

  if(isDefined(self._id_5B7E))
    _func_032("ui_broadcaster_game_mode_status_2", self._id_5B7E getentitynumber());
  else
    _func_032("ui_broadcaster_game_mode_status_2", -1);

  if(var_3 == "allies")
    _func_032("ui_broadcaster_game_mode_status_3", 1);
  else
    _func_032("ui_broadcaster_game_mode_status_3", 2);
}

_id_1526(var_0, var_1) {
  level _id_04D2::_id_47BD(var_0, var_1, 1);

  if(game["status"] == "overtime") {
    game["ball_overtime_team"] = var_0;
    game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
    level thread maps\mp\gametypes\_gamelogic::_id_36B9("overtime_halftime", game["end_reason"]["switching_sides"]);
  } else if(game["status"] == "overtime_halftime") {
    var_2 = _id_04D2::_id_063E(var_0);
    var_3 = _id_04D2::_id_063E(maps\mp\_utility::getotherteam(var_0));

    if(var_2 >= var_3)
      level thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, game["end_reason"]["score_limit_reached"]);
  }
}

_id_154E(var_0) {
  self notify("score_event");
  self._id_50CB = 1;
  var_1 = self._id_A582[0];

  if(isDefined(self._id_776C))
    self._id_776C delete();

  var_1 _meth_84E0();
  _id_04D1::_id_0C1D("none");
  _id_155E();
  var_2 = 0.4;
  var_3 = 1.2;
  var_4 = 1.0;
  _id_0378::_id_8D74("aud_mp_zombie_relic_soul_captured", var_0);
  relic_soul_capture_local_team_sound("mp_zombie_relic_soul_captured", "mp_obj_notify_neg_sml");
  var_5 = var_2 + var_4;
  var_6 = var_5 + var_3;
  var_1 _meth_82B1(var_0, var_2, 0, var_2);
  var_1 _meth_82C0((1080, 1080, 0), var_6, var_6, 0);
  wait(var_5);
  var_1 _meth_82B4(4000, var_3, var_3 * 0.1, 0);
  wait(var_3);
  _id_04D1::_id_0C1D("any");
  _id_154D();
}

_id_1514(var_0, var_1) {
  if(!isDefined(var_0._id_6EB4) || !isDefined(var_0._id_6EB3)) {
    return;
  }
  if(var_0._id_6EB4 + 3000 < gettime()) {
    return;
  }
  var_0._id_6EB3 _id_047A::_id_1563();

  if(var_1)
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_ball_alleyoop");
}

_id_154A(var_0) {
  var_0._id_80A4["friendly"] _meth_805C();
  var_0._id_80A4["enemy"] _meth_805C();
  var_0._id_80A4["broadcaster"] _meth_805C();

  foreach(var_2 in level.players) {
    var_3 = _id_1525(var_2);

    if(var_3 == "broadcaster") {
      var_0._id_80A4["broadcaster"] _meth_8005(var_2);
      continue;
    }

    if(var_3 == var_0.team) {
      var_0._id_80A4["friendly"] _meth_8005(var_2);
      continue;
    }

    var_0._id_80A4["enemy"] _meth_8005(var_2);
  }

  _func_14C(var_0._id_80A4["friendly"]);
  _func_14C(var_0._id_80A4["enemy"]);
  _func_14C(var_0._id_80A4["broadcaster"]);
}

relic_soul_capture_local_team_sound(var_0, var_1) {
  var_2 = level.player.team;
  var_3 = maps\mp\_utility::getotherteam(level.player.team);

  foreach(var_5 in level.players) {
    if(var_5.team == var_2) {
      var_5 playlocalsound(var_0);
      continue;
    }

    if(var_5.team == var_3)
      var_5 playlocalsound(var_1);
  }
}

relic_pickup_local_team_sound(var_0, var_1, var_2) {
  var_3 = maps\mp\_utility::getotherteam(var_0);

  foreach(var_5 in level.players) {
    if(var_5.team == var_0) {
      var_5 playlocalsound(var_1);
      continue;
    }

    if(var_5.team == var_3)
      var_5 playlocalsound(var_2);
  }
}

_id_150E(var_0) {
  if(var_0 _meth_803D())
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0._id_A019) && var_0._id_A019)
    return 0;

  if(isDefined(self._id_34B1) && self._id_34B1 >= gettime())
    return 0;

  if(!var_0 common_scripts\utility::_id_5851())
    return 0;

  if(var_0 _meth_8347())
    return 0;

  if(isDefined(var_0._id_5FDD) && var_0._id_5FDD)
    return 0;

  if(isDefined(var_0._id_A255) && var_0._id_A255)
    return 0;

  var_1 = var_0 getcurrentweapon();

  if(isDefined(var_1)) {
    if(!_id_A267(var_1))
      return 0;
  }

  var_2 = var_0._id_20CC;

  if(isDefined(var_2) && var_0 _meth_833B()) {
    if(!_id_A267(var_2))
      return 0;
  }

  if(isDefined(var_0._id_3905) && var_0._id_3905 == 1)
    return 0;

  if(var_0 _id_72F0())
    return 0;

  return 1;
}

_id_A267(var_0) {
  if(var_0 == "none")
    return 0;

  if(var_0 == "relic_mp")
    return 0;

  if(maps\mp\_utility::iskillstreakweapon(var_0) && var_0 != "flamethrower_mp" && var_0 != "flamethrower_german_mp" && var_0 != "flamethrower_grenadier_mp" && var_0 != "flamethrower_german_grenadier_mp" && var_0 != "killstreak_molotov_cocktail_mp" && var_0 != "killstreak_molotov_cocktail_grenadier_mp")
    return 0;

  return 1;
}

_id_72F0() {
  return isDefined(self._id_6735) && self._id_6735 > gettime();
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

    wait(_func_0A5(3, 6));
  }
}

_id_1535(var_0) {
  maps\mp\gametypes\_gamelogic::_id_6F27();
  _func_137(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  level.previoussoulcaptureorigin = undefined;

  if(!self.hasbeentouched)
    var_0 thread _id_047A::firsttouchrelicevent();

  self.hasbeentouched = 1;
  level notify("broadcaster_ball_end", self._id_A582[0], 1);
  level._id_A239 = 0;
  var_1 = self._id_A582[0] _meth_83F2();

  if(isDefined(var_1))
    self._id_A582[0] _meth_8057();

  self._id_A582[0] _meth_84E0();
  self._id_A582[0] _id_0488::_id_67F9();
  self._id_A582[0] _meth_805B();
  self._id_A582[0] _meth_8511();
  self._id_9D65 _id_0488::_id_93CE();
  self._id_2915._id_50D5 = 0;
  var_2 = 0;

  if(isDefined(self._id_776C)) {
    var_2 = 1;
    self._id_776C delete();
  }

  var_3 = var_0.team;
  var_4 = maps\mp\_utility::getotherteam(var_0.team);

  if(var_2) {
    if(self._id_5B80 == var_0.team) {
      maps\mp\_utility::leaderdialog("pass_complete", var_3, "status");
      var_0._id_6EB4 = gettime();
      var_0._id_6EB3 = self._id_5B7E;
      var_0 thread _id_0485::_id_5E93("pass", var_0.origin);
    } else {
      maps\mp\_utility::leaderdialog("you_own_drone", var_3, "status");
      maps\mp\_utility::leaderdialog("enemy_own_drone", var_4, "status");
      var_0 _id_047A::relicinterceptionevent();
    }
  } else {
    maps\mp\_utility::leaderdialog("you_own_drone", var_3, "status");
    maps\mp\_utility::leaderdialog("enemy_own_drone", var_4, "status");
    var_0 thread _id_0485::_id_5E93("pickup", var_0.origin);
  }

  var_0 _id_0378::_id_8D74("aud_mp_zombie_relic_pickup");
  relic_pickup_local_team_sound(var_3, "mp_obj_notify_pos_sml", "mp_obj_notify_neg_sml");
  _id_1524();
  self._id_5B7F = 0;
  self._id_5B7E = var_0;
  self._id_5B80 = var_0.team;
  self._id_6DB2 = var_0.team;
  _id_155C();
  level thread _id_1455(self._id_6DB2, var_0);

  if(!isDefined(var_0._id_200D))
    var_0._id_200D = 1;
  else
    var_0._id_200D = var_0._id_200D + 1;

  var_0 setweaponammoclip("relic_mp", 1);
  var_0 _meth_84C7([492, 492, 0, 0, 0], var_0.team, 1, 1);
  var_0 thread playzombienoises();
  var_0.hideshieldmodels = 1;

  if(!_func_0C1(var_0) && !istestclient(var_0)) {
    var_5 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_01");
    _func_14D(var_5, var_0, "j_head", var_0);
    var_6 = self._id_A582[0];
    _func_14D(common_scripts\utility::_id_44F5("ball_vm"), var_6, "tag_weapon", var_0);
  }

  var_0._id_1561 = getdvarint("scr_relic_water_drop_delay", 10);
  var_0 maps\mp\_utility::giveperk("specialty_ballcarrier");
  var_0._id_1510 = self;
  var_0._id_0112 = 1;
  _func_032("ui_broadcaster_game_mode_status_1", -1);
  _func_032("ui_broadcaster_game_mode_status_2", self._id_2006 getentitynumber());

  if(self._id_2006.team == "allies")
    _func_032("ui_broadcaster_game_mode_status_3", 1);
  else
    _func_032("ui_broadcaster_game_mode_status_3", 2);

  var_0._id_4B7F = var_0 _meth_82AA("specialty_sprintfire", 1);
  var_0 maps\mp\_utility::giveperk("specialty_sprintfire");
  var_0 common_scripts\utility::_id_0601();
  var_7 = getdvarint("scr_relic_armor", 25);

  if(var_7 > 0)
    var_0 thread _id_052C::_id_86BB(var_7);
  else
    var_0 thread _id_052C::_id_A06E();

  var_0 thread _id_7389(self);
  maps\mp\gametypes\_gamelogic::_id_869D(var_0, 1);
  var_0 thread drop_ball_if_invalid_carrier(self);
}

drop_ball_if_invalid_carrier(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  common_scripts\utility::waittill_notify_or_timeout("mount_force_drop", 2.0);

  if(isDefined(var_0._id_2006) && var_0._id_2006 == self) {
    var_1 = self getcurrentweapon();

    if(var_1 != "relic_mp")
      var_0 _id_1550();
  }
}

_id_1515(var_0) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("reset");
  var_1 = spawnStruct();
  var_1 endon("timer_done");
  var_1 thread _id_9A0F(1.5);
  var_0 waittill("pickup_object");
  var_1 _id_9A09();

  if(!isDefined(var_0._id_2006) || var_0._id_2006.team == self.team) {
    return;
  }
  var_0._id_2006 endon("disconnect");
  var_1 thread _id_9A0F(5);
  var_0._id_2006 waittill("death", var_2);
  var_1 _id_9A09();

  if(!isDefined(var_2) || var_2 != self) {
    return;
  }
  _id_047A::relicpasskillevent();
  self.relicpasskill = 1;
}

_id_9A0F(var_0) {
  self endon("cancel_timer");
  wait(var_0);
  self notify("timer_done");
}

_id_9A09() {
  self notify("cancel_timer");
}

_id_7389(var_0) {
  self endon("disconnect");
  self endon("cancel_update_pass_target");
  var_1 = 0.8;

  for(;;) {
    var_2 = undefined;

    if(!self _meth_801D()) {
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
        if(!var_0 _id_150E(var_7)) {
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
          var_7._id_6EA4 = var_11;
          var_7._id_6EA8 = var_8;
          var_5[var_5.size] = var_7;
        }
      }

      var_5 = common_scripts\utility::_id_7897(var_5, ::_id_2553);

      foreach(var_7 in var_5) {
        if(_func_07F(var_4, var_7._id_6EA8, 0, self, var_7)) {
          var_2 = var_7;
          break;
        }
      }
    }

    _id_7321(var_2);
    waitframe();
  }
}

_id_72CC() {
  for(;;)
    level waittill("joined_team", var_0);
}

_id_738A() {
  if(!isDefined(self)) {
    return;
  }
  self _meth_842A(level.players);

  foreach(var_1 in level.players)
  var_1 _meth_8428(self);

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

    if(var_1.team == var_5)
      var_4[var_4.size] = var_1;
  }

  if(isDefined(self._id_2016)) {
    foreach(var_1 in var_3) {
      var_9 = isDefined(self._id_6EA9) && self._id_6EA9 == var_1;

      if(!var_9)
        var_1 _meth_8427(self, 0, 0);
    }

    if(isDefined(self._id_6EA9))
      self._id_6EA9 _meth_8427(self, 2, 0);

    if(var_4.size > 0)
      self _meth_8429(var_4, 1, 1);

    if(var_3.size > 0)
      self _meth_8429(var_3, 2, 0);
  }
}

_id_7321(var_0) {
  if(isDefined(self._id_6EA9) && isDefined(var_0) && self._id_6EA9 == var_0) {
    return;
  }
  if(!isDefined(self._id_6EA9) && !_func_279(self._id_6EA9) && !isDefined(var_0)) {
    return;
  }
  _id_7245();

  if(isDefined(var_0)) {
    var_1 = (0, 0, 70);
    self._id_6EA5 = var_0 _id_0479::_id_869E(self, "waypoint_relic_pass_oh", var_1, 30, 30, 0, 0.05, 0, 1, 0, 0);
    self._id_6EA9 = var_0;
    var_2 = [];

    foreach(var_4 in level.players) {
      if(var_4.team == self.team && var_4 != self && var_4 != var_0)
        var_2[var_2.size] = var_4;
    }

    self _meth_82FF("ui_uplink_can_pass", 1);
    self _meth_850F(1);
  }
}

_id_7245() {
  if(isDefined(self._id_6EA5))
    self._id_6EA5 destroy();

  self _meth_82FF("ui_uplink_can_pass", 0);
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.team == self.team && var_2 != self)
      var_0[var_0.size] = var_2;
  }

  self._id_6EA9 = undefined;
  self _meth_850F(0);
}

_id_2553(var_0, var_1) {
  return var_0._id_6EA4 >= var_1._id_6EA4;
}

_id_1550(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  self._id_57A6 = 1;
  self._id_34B1 = gettime();
  self notify("dropped");
  level notify("relicDropped");

  if(isDefined(level._id_9A13) && level._id_9A13) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    _func_137(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  }

  var_1 = self._id_2006;

  if(isDefined(var_1) && var_1.team != "spectator") {
    var_2 = var_1.origin;

    if(var_1 _meth_8178() == "stand") {
      if(var_0 == 1)
        var_2 = var_2 + (0, 0, 60);
      else
        var_2 = var_2 + (0, 0, 40);
    } else if(var_1 _meth_8178() == "crouch")
      var_2 = var_2 + (0, 0, 40);
    else
      var_2 = var_2 + (0, 0, 20);
  } else {
    var_2 = self._id_802F;
    var_2 = var_2 + (0, 0, 40);
  }

  var_3 = (0, 0, 0);

  for(var_4 = 0; var_4 < self._id_A582.size; var_4++) {
    self._id_A582[var_4].origin = var_2;
    self._id_A582[var_4].angles = var_3;
    self._id_A582[var_4] _meth_805B();
  }

  self._id_9D65.origin = var_2;
  _id_151D();
  self._id_28D4 = self._id_9D65.origin;
  var_1 _id_0378::_id_8D74("aud_mp_zombie_relic_drop");
  _id_1511();
  _id_1522();
  self._id_6DB2 = "any";
  _id_155D();
  _id_04D1::_id_23DA();
  _id_04D1::_id_A0FE();
  _id_04D1::_id_A19B();
  self._id_57A6 = 0;

  if(!var_0) {
    var_5 = self._id_5B80;
    var_6 = maps\mp\_utility::getotherteam(var_5);
    maps\mp\_utility::leaderdialog("ally_drop_drone", var_5, "status");
    maps\mp\_utility::leaderdialog("enemy_drop_drone", var_6, "status");
    _id_1542((0, 0, 80));
  }

  var_7 = spawnStruct();
  var_7._id_2016 = self;
  var_7._id_2AA8 = ::_id_1539;
  self._id_9D65 thread _id_0488::_id_4A27(var_7);
  return 1;
}

_id_1539(var_0) {}

_id_1509() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level.previoussoulcaptureorigin) || isDefined(level.previousrelicusedspawns) && level.previousrelicusedspawns.size == level._id_1554.size)
    level.previousrelicusedspawns = [];

  var_4 = common_scripts\utility::array_randomize(level._id_1554);

  foreach(var_6 in var_4) {
    if(var_6._id_50D5) {
      continue;
    }
    if(isDefined(level.previoussoulcaptureorigin)) {
      var_7 = _func_0E1(level.previoussoulcaptureorigin, var_6.origin);

      if(!isDefined(var_3) || var_2 < var_7) {
        var_2 = var_7;
        var_3 = var_6;
      }
    } else if(isDefined(level.previousrelicusedspawns) && level.previousrelicusedspawns.size > 0) {
      if(!common_scripts\utility::_id_0F79(level.previousrelicusedspawns, var_6.origin))
        var_1 = var_6;
    }

    var_0 = var_6;
  }

  if(isDefined(var_1))
    var_0 = var_1;

  if(isDefined(var_3))
    var_0 = var_3;

  if(!isDefined(var_0)) {
    return;
  }
  _id_150A(var_0);
}

_id_150A(var_0) {
  foreach(var_2 in self._id_A582)
  var_2._id_162D = var_0.origin;

  self._id_9D65._id_162D = var_0.origin;
  self._id_2915 = var_0;
  var_0._id_50D5 = 1;

  if(!isDefined(level.previousrelicusedspawns))
    level.previousrelicusedspawns = [];

  level.previousrelicusedspawns[level.previousrelicusedspawns.size] = var_0.origin;
}

_id_1538() {
  level notify("relicReset");

  if(isDefined(level._id_9A13) && level._id_9A13) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    _func_137(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  }

  self._id_2915._id_50D5 = 0;
  _id_1509();
  var_0 = self._id_A582[0];
  var_0 _id_0488::_id_67F9();
  var_1 = var_0 _meth_83F2();

  if(isDefined(var_1))
    var_0 _meth_8057();

  var_0 _meth_84E0();
  _id_151D();

  if(isDefined(self._id_776C))
    self._id_776C delete();

  var_2 = "none";
  var_3 = self._id_5B80;

  if(isDefined(var_3))
    var_2 = maps\mp\_utility::getotherteam(var_3);

  thread _id_1511();
  _func_032("ui_broadcaster_game_mode_status_1", -1);
  _func_032("ui_broadcaster_game_mode_status_2", -1);
  _func_032("ui_broadcaster_game_mode_status_3", 3);
  self._id_9D65 _id_0488::_id_93CE();
  _id_155B();
  _id_04D1::_id_870A(var_0._id_162D + (0, 0, 4000), (0, 0, 0));

  if(!self.hasbeentouched)
    var_4 = 12;
  else
    var_4 = 6;

  var_0 _meth_82B1(var_0._id_162D, var_4, 0, var_4);
  var_0 _meth_82C0((0, 720, 0), var_4, 0, var_4);

  if(!self._id_5B7F && isDefined(var_3) && isDefined(var_2)) {
    maps\mp\_utility::leaderdialog("drone_reset", var_3, "status");
    maps\mp\_utility::leaderdialog("drone_reset", var_2, "status");

    if(isDefined(self._id_5B7E))
      thread maps\mp\_utility::teamplayercardsplash("callout_ballreset", self._id_5B7E);
  }

  self._id_6DB2 = "any";
  _id_155B();
  thread _id_151F(var_4);
  thread _id_151E(var_0, var_4);
}

_id_151E(var_0, var_1) {
  _func_147(level._effect["ball_download"], var_0, "tag_weapon");
  common_scripts\utility::waittill_notify_or_timeout("pickup_object", var_1);
  _func_148(level._effect["ball_download"], var_0, "tag_weapon");
  self._id_80AA = 0;
}

_id_151F(var_0) {
  self endon("pickup_object");
  wait(var_0);
  _id_155D();
  level.previoussoulcaptureorigin = undefined;
  playFX(level._effect["ball_download_end"], self._id_2915._id_487A);
  _id_1522();
}

_id_1511() {
  if(isDefined(self._id_2006)) {
    var_0 = self._id_2006;
    var_0._id_1561 = undefined;
    var_0._id_6735 = gettime() + 500;
    var_0 _id_7245();
    var_0 notify("cancel_update_pass_target");
    var_0 maps\mp\_utility::_id_0735("specialty_ballcarrier");
    var_0._id_1510 = undefined;
    var_0 thread _id_052C::_id_A06E();

    if(!var_0._id_4B7F)
      var_0 maps\mp\_utility::_id_0735("specialty_sprintfire");

    var_0 common_scripts\utility::_id_0615();
    var_0.hideshieldmodels = 0;
    var_0 _meth_850F(0);
    var_0 _meth_82FF("ui_uplink_can_pass", 0);
    var_0._id_0112 = 0;

    if(!_func_0C1(var_0) && !istestclient(var_0)) {
      var_1 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_01");
      _func_295(var_1, var_0, "j_head", var_0);
      var_2 = self._id_A582[0];
      _func_295(common_scripts\utility::_id_44F5("ball_vm"), var_2, "tag_weapon", var_0);
      waitframe();
    }

    if(maps\mp\_utility::_id_4571() != "mp_sandbox_01") {
      var_3 = maps\mp\gametypes\_class::_id_1F93(var_0._id_0079, var_0.team);
      var_0 setplayerdata(common_scripts\utility::_id_46A9(), "activeCostume", var_3);
      var_0._id_267E = var_0 maps\mp\gametypes\_class::_id_1F97(var_3);
      var_4 = var_0 maps\mp\gametypes\_class::_id_1F95();
      var_0._id_267E[1] = var_4[1];
      var_0 maps\mp\gametypes\_class::_id_21B9();
      var_0 _id_0510::_id_73CA();
    }

    var_0 notify("applyLoadout");
  }
}

_id_1520(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  self._id_487A = _func_081(var_1, var_2);
}

_id_151B(var_0) {
  var_1 = var_0;

  if(game["switchedsides"])
    var_1 = maps\mp\_utility::getotherteam(var_1);

  var_2 = common_scripts\utility::_id_46B5("ball_goal_" + var_1, "targetname");

  if(isDefined(var_2)) {
    var_2 _id_1520();
    var_2.origin = var_2._id_487A;
  } else {
    var_2 = spawnStruct();

    switch (level._id_015D) {
      default:
        break;
    }

    if(!isDefined(var_2.origin))
      var_2.origin = level._id_2B9D[var_0];

    var_2 _id_1520();
    var_2.origin = var_2._id_487A;
  }

  var_2.radius = 70;
  var_2.team = var_0;
  var_2._id_152C = 0;
  var_2._id_4D3F = 0;
  var_2._id_645F = -1;
  level._id_152B[var_0] = var_2;
}

_id_1519(var_0) {
  var_1 = common_scripts\utility::_id_46B7("ball_start", "targetname");
  var_1 = common_scripts\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_81E1))
      var_3._id_81E1 = 100;
  }

  var_1 = common_scripts\utility::_id_7897(var_1, ::_id_2554);

  foreach(var_3 in var_1)
  _id_1508(var_3.origin);

  var_7 = 30;

  if(var_1.size == 0) {
    var_8 = (0, 0, 0);

    switch (level._id_015D) {
      default:
        break;
    }

    if(!isDefined(var_8))
      var_8 = level._id_2B93;

    _id_1508(var_8);
  }

  var_9 = common_scripts\utility::_id_46B5("ball_goal_allies", "targetname");
  var_10 = common_scripts\utility::_id_46B5("ball_goal_axis", "targetname");
  var_11 = [var_9, level._id_1554[0], var_10];
  var_12 = level._id_1554[0].origin;
  level._id_1554 = [];
  _id_1508(var_12);
  var_13 = var_12;
  var_14 = [];
  var_14[var_14.size] = var_13;

  foreach(var_16 in var_11) {
    var_17 = 2;
    var_18 = _func_0B8(var_16.origin, 2000, 700, 1200);
    var_18 = common_scripts\utility::array_randomize(var_18);
    var_19 = 0;

    for(var_20 = 0; var_19 < var_17 && var_20 < var_18.size; var_20++) {
      var_21 = var_18[var_20].origin;
      var_22 = 1;

      for(var_23 = 0; var_22 && var_23 < var_14.size; var_23++) {
        if(_func_0E1(var_14[var_23], var_21) < 700)
          var_22 = 0;
      }

      if(var_22 && _func_0E1(var_13, var_21) > 800) {
        _id_1508(var_21);
        var_19++;
        var_13 = var_21;
        var_14[var_14.size] = var_13;
      }
    }
  }
}

_id_1508(var_0) {
  var_1 = 30;
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2 _id_1520();
  var_2.origin = var_2._id_487A + (0, 0, var_1);
  var_2._id_50D5 = 0;
  level._id_1554[level._id_1554.size] = var_2;
}

_id_2554(var_0, var_1) {
  return var_0._id_81E1 <= var_1._id_81E1;
}

_id_1534() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_1528 = [];
    var_0 thread _id_72F2();
    var_0 thread _id_0513::initteslagun();
  }
}

_id_72F2() {
  self waittill("disconnect");
}

_id_1529(var_0) {
  var_1 = _id_1525(var_0);

  if(var_1 == "broadcaster") {}

  var_0 _id_7255();

  foreach(var_6, var_3 in level._id_152B) {
    if(var_1 == "broadcaster")
      var_4 = common_scripts\utility::_id_98E7(var_6 == "allies", "ball_goal_allies_blue", "ball_goal_axis_red");
    else if(var_3.team == "allies") {
      if(var_1 == "axis")
        var_4 = "ball_goal_allies_red";
      else
        var_4 = "ball_goal_allies_blue";
    } else if(var_1 == "axis")
      var_4 = "ball_goal_axis_blue";
    else
      var_4 = "ball_goal_axis_red";

    var_5 = _func_258(common_scripts\utility::_id_44F5(var_4), var_3.origin + (0, 0, 15), var_0);
    setfxkillondelete(var_5, 1);
    var_0._id_1528[var_4] = var_5;
    _func_14C(var_5);
  }
}

_id_1525(var_0) {
  var_1 = var_0.team;

  if(var_0 _meth_8436())
    var_1 = "broadcaster";
  else if(var_1 != "allies" && var_1 != "axis")
    var_1 = "allies";

  return var_1;
}

monitorbroadcasterfxchanged() {
  self endon("disconnect");
  self endon("game_ended");

  for(;;) {
    self waittill("changeGoalFx");
    _id_7255();

    foreach(var_4, var_1 in level._id_152B) {
      var_2 = common_scripts\utility::_id_98E7(var_4 == "allies", "ball_goal_allies_blue", "ball_goal_axis_red");

      if(self._id_1E99._id_A4A8 == "first_person") {
        if(var_1.team == "allies") {
          if(var_4 == self._id_1E99._id_9815.team)
            var_2 = "ball_goal_allies_blue";
          else
            var_2 = "ball_goal_allies_red";
        } else if(var_4 == self._id_1E99._id_9815.team)
          var_2 = "ball_goal_axis_blue";
        else
          var_2 = "ball_goal_axis_red";
      }

      var_3 = _func_258(common_scripts\utility::_id_44F5(var_2), var_1.origin + (0, 0, 15), self);
      setfxkillondelete(var_3, 1);
      self._id_1528[var_2] = var_3;
      _func_14C(var_3);
    }

    waitframe();
  }
}

_id_7255() {
  foreach(var_1 in self._id_1528) {
    if(isDefined(var_1))
      var_1 delete();
  }
}

_id_1548() {
  for(;;)
    level waittill("joined_team", var_0);
}

_id_2CDB(var_0, var_1, var_2) {
  level endon("game_ended");
  wait 1.2;
  maps\mp\_utility::leaderdialog(var_0, var_1, var_2);
}

attemptdropteslagun(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(getdvarint("spv_tesla_mp_active", 0) == 1)
    level thread _id_0513::potentiallyspawnteslagun(var_0, 100);
}