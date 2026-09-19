/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\ctf.gsc
*********************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_func_133()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 3);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  maps\mp\_utility::setovertimelimitdvar(5);

  if(isDefined(game["round_time_to_beat"])) {
    maps\mp\_utility::setovertimelimitdvar(game["round_time_to_beat"]);
    game["round_time_to_beat"] = undefined;
  }

  _id_872E();
  level._id_80A8 = 1;
  maps\mp\_utility::_id_873B(1);
  level.objectivebased = 1;
  level._id_6CD1 = 1;
  level._id_6B54 = 1;
  level._id_6FEF = maps\mp\_utility::getintproperty("scr_ping_carrier", 1);
  level._id_AA24 = maps\mp\_utility::getintproperty("scr_ctf_win_by_captures", 0);
  level._id_6BAF = ::_id_6BAF;
  level._id_6B7B = ::_id_6B7B;
  level._id_6BB6 = ::_id_6BB6;
  level._id_6B42 = ::_id_6B42;

  if(!isDefined(game["shut_out"])) {
    game["shut_out"]["axis"] = 1;
    game["shut_out"]["allies"] = 1;
  }

  if(level._id_AA24)
    _func_035("scr_ctf_scorelimit", 0);

  if(level._id_6031 || level._id_6035)
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;

  level._id_3CC4 = maps\mp\_utility::getintproperty("scr_ctf_returntime", 30);
  game["dialog"]["gametype"] = "ctf_intro";

  if(getdvarint("2043"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";
  thread onplayerconnect();

  if(!isDefined(game["allies_side_caps"]))
    game["allies_side_caps"] = 0;

  if(!isDefined(game["axis_side_caps"]))
    game["axis_side_caps"] = 0;

  if(!isDefined(game["allies_side_pickups"]))
    game["allies_side_pickups"] = 0;

  if(!isDefined(game["axis_side_pickups"]))
    game["axis_side_pickups"] = 0;
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _func_035("scr_ctf_roundlimit", 2);
  maps\mp\_utility::registerroundlimitdvar("ctf", 1);
  _func_035("scr_ctf_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("ctf", 1);
  _func_035("scr_ctf_halftime", 1);
  maps\mp\_utility::registerhalftimedvar("ctf", 1);
  _func_035("scr_ctf_returntime", _func_132("ctfData", "returnTime"));
  _func_035("scr_ping_carrier", _func_132("ctfData", "enemyCarrierIcon"));
  _func_035("scr_ctf_win_by_captures", _func_132("ctfData", "winByCaptures"));
  _func_035("scr_ctf_flag_pick_up_time_friendly", _func_132("ctfData", "pickupTime"));
  _func_035("scr_ctf_flag_pick_up_time_enemy", _func_132("ctfData", "pickupTime"));
  _func_035("scr_ctf_extratime", _func_132("ctfData", "extraTime"));
}

_id_6BAF() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(maps\mp\_utility::_id_576C(game["status"]))
    game["switchedsides"] = !game["switchedsides"];

  if(game["status"] == "halftime")
    _func_032("ui_current_round", 2);
  else if(game["status"] == "overtime")
    _func_032("ui_current_round", 3);
  else if(game["status"] == "overtime_halftime")
    _func_032("ui_current_round", 4);

  if(!isDefined(game["original_defenders"]))
    game["original_defenders"] = game["defenders"];

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(!level._id_AA24) {
    game["teamScores"][game["attackers"]] = 0;
    _func_156(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    _func_156(game["defenders"], 0);
  }

  _func_157("auto_change");
  var_2 = _func_0EE("allieschar");

  if(!isDefined(var_2) || var_2 == "")
    var_2 = "allies";

  var_3 = _func_0EE("axischar");

  if(!isDefined(var_3) || var_3 == "")
    var_3 = "axis";

  level._id_3CB5[var_2][0] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level._id_3CB5[var_2][1] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level._id_3CB5[var_2][2] = loadfx("vfx/unique/vfx_marker_ctf_allies_blue");
  level._id_3CB5[var_2][3] = loadfx("vfx/unique/vfx_marker_ctf_allies_blue");
  level._id_3CB5[var_2][4] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level._id_3CB5[var_3][0] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");
  level._id_3CB5[var_3][1] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");
  level._id_3CB5[var_3][2] = loadfx("vfx/unique/vfx_marker_ctf_axis_blue");
  level._id_3CB5[var_3][3] = loadfx("vfx/unique/vfx_marker_ctf_axis_blue");
  level._id_3CB5[var_3][4] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_CTF");
  maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_CTF");
  maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  var_4[0] = "ctf";
  var_4[1] = "blocker_ctf";
  _id_04D1::main(var_4);
  level._id_3992 = maps\mp\_utility::dvarintvalue("extraTime", maps\mp\_utility::getintproperty("scr_ctf_extratime", 1), 0, 3);
  level._id_289F = 0;
  level thread _id_2896();
  level thread _id_A15F();
}

_id_A15F() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_A0F1();
    var_0 thread _id_A15B();
    var_0 thread _id_A108();
  }
}

_id_A0F1() {
  waittillframeend;
  maps\mp\_utility::_id_867B(self.pers["captures"]);
}

_id_A15B() {
  waittillframeend;
  self._id_0021 = self.pers["returns"];
}

_id_A108() {
  waittillframeend;
  maps\mp\_utility::_id_867C(self.pers["defends"]);
}

_id_2896() {
  level._id_3CBF["allies"]["allies"] = "usa_ctf_flag_physics_placed";
  level._id_3CBF["allies"]["axis"] = "usa_ctf_flag_physics_placed_red";
  level._id_2013["allies"]["allies"] = spawn("script_model", (0, 0, 0));
  level._id_2013["allies"]["allies"] setModel("usa_ctf_flag_physics_attach");
  level._id_2013["allies"]["axis"] = spawn("script_model", (0, 0, 0));
  level._id_2013["allies"]["axis"] setModel("usa_ctf_flag_physics_attach_red");
  level._id_2013["allies"]["allies"] _meth_805C();
  level._id_2013["allies"]["axis"] _meth_805C();
  level._id_3CBF["axis"]["axis"] = "ger_ctf_flag_physics_placed_blue";
  level._id_3CBF["axis"]["allies"] = "ger_ctf_flag_physics_placed";
  level._id_2013["axis"]["axis"] = spawn("script_model", (0, 0, 0));
  level._id_2013["axis"]["axis"] setModel("ger_ctf_flag_physics_attach_blue");
  level._id_2013["axis"]["allies"] = spawn("script_model", (0, 0, 0));
  level._id_2013["axis"]["allies"] setModel("ger_ctf_flag_physics_attach");
  level._id_2013["axis"]["axis"] _meth_805C();
  level._id_2013["axis"]["allies"] _meth_805C();
  level._id_5012 = "waypoint_escort_flag";
  level._id_5011 = "waypoint_escort_flag";
  level._id_5015 = "waypoint_kill";
  level._id_5014 = "waypoint_kill";
  level._id_4FFC = "waypoint_allies_flag_friendly";
  level._id_4FFB = "waypoint_allies_flag_friendly";
  level._id_4FFA = "waypoint_allies_flag_enemy";
  level._id_4FF9 = "waypoint_allies_flag_enemy";
  level._id_5002 = "waypoint_axis_flag_friendly";
  level._id_5001 = "waypoint_axis_flag_friendly";
  level._id_5000 = "waypoint_axis_flag_enemy";
  level._id_4FFF = "waypoint_axis_flag_enemy";
  level._id_5021 = "waypoint_return_flag";
  level._id_5020 = "waypoint_return_flag";
  level._id_5029 = "waypoint_waitfor_flag";
  level._id_5028 = "waypoint_waitfor_flag";
  level._id_4FFE = "waypoint_caster_flag_taken";
  level._id_500E = "waypoint_caster_flag_dropped";
  level._id_4FFD = "waypoint_caster_flag";
  level._id_5018 = "waypoint_caster_flag_missing";
  level._id_9853[game["defenders"]] = _id_282E(game["defenders"], level._id_6C63["allies"]);
  level._id_9853[game["attackers"]] = _id_282E(game["attackers"], "allies");
  level._id_1FC6[game["defenders"]] = _id_27D2(game["defenders"], level._id_6C63["allies"]);
  level._id_1FC6[game["attackers"]] = _id_27D2(game["attackers"], "allies");
  level._id_1FC6["allies"]._id_487A = level._id_1FC6["allies"]._id_28D4;
  level._id_1FC6["axis"]._id_487A = level._id_1FC6["axis"]._id_28D4;
  _id_050D::_id_10E4();
  _id_050D::_id_908D(level._id_1FC6["allies"], level._id_1FC6["axis"]);
  level thread _id_289C();
  _id_6B94("allies");
  _id_6B94("axis");
}

_id_289C() {
  level endon("game_ended");
  var_0 = level._id_9853["allies"];
  var_1 = level._id_9853["axis"];

  for(;;) {
    var_2 = gettime();
    var_3 = var_0._id_2006;
    var_4 = var_1._id_2006;
    var_5 = undefined;
    var_6 = undefined;

    if(!isDefined(var_3)) {
      var_7 = "none";
      var_5 = var_0.origin;
    } else {
      var_7 = var_3.name;
      var_5 = var_3.origin;
    }

    if(!isDefined(var_4)) {
      var_8 = "none";
      var_6 = var_1.origin;
    } else {
      var_8 = var_4.name;
      var_6 = var_4.origin;
    }

    _func_0F5("script_mp_ctf: gameTime %d, allies_flag_loc %v, axis_flag_loc %v, allies_carrier %s, axis_carrier %s", var_2, var_5, var_6, var_7, var_8);
    wait 0.2;
  }
}

_id_6B94(var_0) {
  if(var_0 == "allies") {
    level._id_0BF7 = 0;
    level._id_0BF6 = -1;
  } else {
    level._id_147E = 0;
    level._id_147D = -1;
  }

  level notify("update_flag_status");
}

_id_6B64(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == "allies") {
    var_0._id_0112 = 1;
    level._id_147E = 2;
    level._id_147D = var_0 getentitynumber();
  } else {
    var_0._id_0112 = 2;
    level._id_0BF7 = 2;
    level._id_0BF6 = var_0 getentitynumber();
  }

  level notify("update_flag_status");
}

_id_6AF0(var_0) {
  if(var_0 == "allies") {
    level._id_0BF7 = 1;
    level._id_0BF6 = -1;
  } else {
    level._id_147E = 1;
    level._id_147D = -1;
  }

  level notify("update_flag_status");
}

_id_7482() {
  if(!isDefined(self.team) || !isDefined(level._id_0BF7)) {
    return;
  }
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  _func_032("ui_broadcaster_ctf_allies_status", level._id_0BF7);
  _func_032("ui_broadcaster_ctf_allies_carrier_clientnum", level._id_0BF6);
  _func_032("ui_broadcaster_ctf_axis_status", level._id_147E);
  _func_032("ui_broadcaster_ctf_axis_carrier_clientnum", level._id_147D);

  if(self.team == "allies" || self.team == "spectator") {
    var_0 = level._id_0BF7;
    var_1 = level._id_0BF6;
    var_2 = level._id_147E;
    var_3 = level._id_147D;
  } else if(self.team == "axis") {
    var_0 = level._id_147E;
    var_1 = level._id_147D;
    var_2 = level._id_0BF7;
    var_3 = level._id_0BF6;
  } else
    return;

  self _meth_82FF("ui_ctf_friendly_status", var_0);
  self _meth_82FF("ui_ctf_friendly_carrier_clientnum", var_1);
  self _meth_82FF("ui_ctf_enemy_status", var_2);
  self _meth_82FF("ui_ctf_enemy_carrier_clientnum", var_3);
  self _meth_82FF("ui_ctf_status_changed", 1);
}

_id_7483() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    _id_7482();
  }
}

_id_748E() {
  level endon("game_ended");
  self endon("disconnect");
  _id_7482();
  thread _id_7483();

  for(;;) {
    common_scripts\utility::_id_A70C(level, "update_flag_status", self, "spawned_player");
    _id_7482();
  }
}

_id_4D0B(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0))
    var_0.alpha = 0;
}

_id_282E(var_0, var_1) {
  var_2 = _func_18E("ctf_zone_" + var_1, "targetname");

  if(!isDefined(var_2))
    common_scripts\utility::_id_3809("No ctf_zone_" + var_1 + " trigger found in map.");
  else {
    var_3[0] = _func_18E("ctf_flag_" + var_1, "targetname");

    if(!isDefined(var_3[0])) {
      common_scripts\utility::_id_3809("No ctf_flag_" + var_1 + " script_model found in map.");
      return;
    }

    var_4 = (0, 0, 0);

    if(var_1 == "allies") {
      if(isDefined(level.allies_ctf_flag_offset))
        var_4 = level.allies_ctf_flag_offset;
    } else if(var_1 == "axis") {
      if(isDefined(level.axis_ctf_flag_offset))
        var_4 = level.axis_ctf_flag_offset;
    }

    var_5 = spawn("trigger_radius", var_2.origin + var_4, 0, 32, var_2._id_00BD);
    var_2 = var_5;
    var_3[0] setModel(level._id_3CBF[var_0][var_0]);
    var_3[0]._id_6A55 = var_3[0] _meth_80B1();
    var_3[1] = spawn("script_model", var_3[0].origin);
    var_3[1] setModel(level._id_3CBF[var_0][maps\mp\_utility::getotherteam(var_0)]);
    var_3[1]._id_6A55 = var_3[1] _meth_80B1();
    var_6 = var_3[0].origin + (0, 0, 32) + var_4;
    var_7 = var_3[0].origin + (0, 0, -32) + var_4;
    var_8 = bulletTrace(var_6, var_7, 0, undefined);
    var_3[0].origin = var_8["position"];
    var_3[1].origin = var_8["position"];
    var_3[1].angles = var_3[0].angles;
    var_9 = _id_04D1::_id_27D6(var_0, var_2, var_3, (0, 0, 85), 1, 0, 1);
    var_9 thread _id_8BF8(var_0);
    var_10 = getdvarfloat("scr_ctf_flag_pick_up_time_friendly", 0.0);

    if(var_10 > 0)
      var_9 _id_04D1::_id_8740("friendly", var_10);

    var_11 = getdvarfloat("scr_ctf_flag_pick_up_time_enemy", 0.0);

    if(var_11 > 0)
      var_9 _id_04D1::_id_8740("enemy", var_11);

    var_9 _id_04D1::_id_873F("enemy", &"MP_GRABBING_FLAG");
    var_9 _id_04D1::_id_873F("friendly", &"MP_RETURNING_FLAG");
    var_9 _id_04D1::_id_0C1D("enemy");
    var_9 _id_04D1::_id_8A60("none");
    var_9 _id_04D1::_id_860A("enemy", level._id_5011);
    var_9 _id_04D1::_id_860E("enemy", level._id_5012, undefined, 1);

    if(level._id_6FEF != 2) {
      var_9 _id_04D1::_id_860A("friendly", level._id_5014);
      var_9 _id_04D1::_id_860E("friendly", level._id_5015, undefined, 1);
    } else {
      var_9 _id_04D1::_id_860A("friendly", undefined);
      var_9 _id_04D1::_id_860E("friendly", undefined);
    }

    var_9._id_6990 = 1;
    var_9._id_0C33 = 1;
    var_9._id_7D25 = 1;
    var_9._id_6B62 = ::_id_6B62;
    var_9._id_6B63 = ::_id_6B62;
    var_9._id_6AEF = ::_id_6AEF;
    var_9._id_6B93 = ::_id_6B93;
    var_9._id_6A68 = var_2.radius;
    var_9.origin = var_2.origin;

    if(level._id_6FEF == 0)
      var_9._id_6990 = 0;

    if(var_0 == "axis") {
      maps\mp\_utility::_id_863F(var_9, level._id_4FFD, 1, 1);
      _func_032("ui_broadcaster_game_mode_status_1", 0);
    } else {
      maps\mp\_utility::_id_863F(var_9, level._id_4FFD, 2, 1);
      _func_032("ui_broadcaster_game_mode_status_2", 0);
    }
  }
}

_id_27D2(var_0, var_1) {
  var_2 = _func_18E("ctf_zone_" + var_1, "targetname");
  var_3 = (0, 0, 0);

  if(var_1 == "allies") {
    if(isDefined(level.allies_ctf_flag_offset))
      var_3 = level.allies_ctf_flag_offset;
  } else if(var_1 == "axis") {
    if(isDefined(level.axis_ctf_flag_offset))
      var_3 = level.axis_ctf_flag_offset;
  }

  var_4 = spawn("trigger_radius", var_2.origin + var_3, 0, 32, var_2._id_00BD);
  var_2 = var_4;
  var_5 = [];
  var_6 = _id_04D1::_id_2837(var_0, var_2, var_5, (0, 0, 85));
  var_6 _id_04D1::_id_0C30("friendly");
  var_6 _id_04D1::_id_8A60("any");
  var_6 _id_04D1::_id_860A("friendly", level._id_500C);
  var_6 _id_04D1::_id_860E("friendly", level._id_500D, undefined, 1);
  var_6 _id_04D1::_id_860A("enemy", level._id_5005);
  var_6 _id_04D1::_id_860E("enemy", level._id_5006, undefined, 1);

  if(var_0 == "allies") {
    var_6 _id_04D1::_id_860A("friendly", level._id_4FFB);
    var_6 _id_04D1::_id_860E("friendly", level._id_4FFC, undefined, 1);
    var_6 _id_04D1::_id_860A("enemy", level._id_4FF9);
    var_6 _id_04D1::_id_860E("enemy", level._id_4FFA, undefined, 1);
  } else {
    var_6 _id_04D1::_id_860A("friendly", level._id_5001);
    var_6 _id_04D1::_id_860E("friendly", level._id_5002, undefined, 1);
    var_6 _id_04D1::_id_860A("enemy", level._id_4FFF);
    var_6 _id_04D1::_id_860E("enemy", level._id_5000, undefined, 1);
  }

  var_6 _id_04D1::_id_8A5A(0);
  var_6 _id_04D1::_id_86B5(level._id_9853[maps\mp\_utility::getotherteam(var_0)]);
  var_6._id_6BBF = ::_id_6BBF;
  var_6._id_6AC9 = ::_id_6AC9;
  var_7 = var_2.origin + (0, 0, 32);
  var_8 = var_2.origin + (0, 0, -32);
  var_9 = bulletTrace(var_7, var_8, 0, undefined);
  var_6._id_15FA = var_9["position"];
  var_6._id_15F9 = var_9["normal"];
  var_6 thread _id_1FC4();
  var_6._id_4D3F = 0.0;
  var_6._id_645F = -1;
  return var_6;
}

_id_6ABC(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == _id_04D1::_id_45F7())
    self._id_9D65.radius = 1024;
  else
    self._id_9D65.radius = self._id_6A68;
}

_id_6AFA(var_0, var_1, var_2) {
  self._id_9D65.radius = self._id_6A68;
}

_id_6B62(var_0) {
  self notify("picked_up");
  var_1 = var_0.pers["team"];

  if(var_1 == "allies")
    var_2 = "axis";
  else
    var_2 = "allies";

  if(var_1 == _id_04D1::_id_45F7()) {
    maps\mp\_utility::_id_863E(11, var_0.team, var_0 getentitynumber());
    thread _id_7E2F(0);
    maps\mp\_utility::leaderdialog("flag_returned", var_1, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med", var_1);
    maps\mp\_utility::leaderdialog("enemy_flag_returned", var_2, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med", var_2);
    var_0 thread _id_047A::_id_3CC3();
    _id_6B94(var_1);
  } else {
    if(isDefined(level._id_2899) && isDefined(level._id_2899[var_1]))
      var_0 thread _id_0F32(self);
    else
      var_0 _id_1148(self);

    var_3 = 0;

    if(var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_3 = 20;
      self._id_6993 = 7.5;
    } else
      self._id_6993 = 5.0;

    if(var_3 > 0)
      var_0 thread _id_052C::_id_86BB(var_3);
    else
      var_0 thread _id_052C::_id_A06E();

    maps\mp\_utility::_id_863E(8, var_0.team, var_0 getentitynumber());
    thread _id_1C82(var_0, var_1);
    thread _id_44DF(var_2);
    _id_6B64(var_0);
    _id_04D1::_id_8A60("any");
    _id_04D1::_id_860A("enemy", level._id_5011);
    _id_04D1::_id_860E("enemy", level._id_5012, undefined, 1);

    if(level._id_6FEF != 2) {
      _id_04D1::_id_860A("friendly", level._id_5014);
      _id_04D1::_id_860E("friendly", level._id_5015, undefined, 1);
    } else {
      _id_04D1::_id_860A("friendly", undefined);
      _id_04D1::_id_860E("friendly", undefined);
    }

    level._id_1FC6[var_2] _id_04D1::_id_0C30("none");
    level._id_1FC6[var_2] _id_04D1::_id_8A60("friendly");
    level._id_1FC6[var_2] _id_04D1::_id_860A("friendly", level._id_5028);
    level._id_1FC6[var_2] _id_04D1::_id_860E("friendly", level._id_5029, undefined, 1);
    var_4 = [var_0];
    maps\mp\_utility::leaderdialog("enemy_flag_taken", var_1, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml", var_1, var_4);
    var_0 playlocalsound("mp_ctf_flag_pickup");
    maps\mp\_utility::leaderdialog("flag_taken", var_2, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml", var_2);

    if(_id_04D1::_id_45F7() == "axis") {
      maps\mp\_utility::_id_863F(level._id_1FC6[var_2], level._id_5018, 1, 1);
      maps\mp\_utility::_id_863F(self, level._id_4FFE, 1, 1);
      _func_032("ui_broadcaster_game_mode_status_1", var_0 getentitynumber());
    } else {
      maps\mp\_utility::_id_863F(level._id_1FC6[var_2], level._id_5018, 2, 1);
      maps\mp\_utility::_id_863F(self, level._id_4FFE, 2, 1);
      _func_032("ui_broadcaster_game_mode_status_2", var_0 getentitynumber());
    }

    var_0 _meth_8608(1);
    var_0 thread _id_047A::_id_3CC1();

    if(var_1 == game["attackers"])
      game["allies_side_pickups"]++;
    else if(var_1 == game["defenders"])
      game["axis_side_pickups"]++;
  }
}

_id_1C82(var_0, var_1) {
  level endon("game_ended");
  self endon("reset");
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    wait 15;

    if(level._id_9853[var_1] _id_04D1::_id_5715())
      var_0 maps\mp\_utility::leaderdialogonplayer("enemy_flag_bringhome", "status");
  }
}

_id_44DF(var_0) {
  level endon("game_ended");
  self endon("reset");
  var_1 = _id_44E2(var_0);

  if(var_1 == 1) {
    return;
  }
  for(;;) {
    wait 15;
    maps\mp\_utility::leaderdialog("flag_getback", var_0, "status");
  }
}

_id_44E2(var_0) {
  if(var_0 == "allies")
    return level._id_0BF7;

  if(var_0 == "axis")
    return level._id_147E;
}

_id_7E2F(var_0) {
  if(!var_0)
    maps\mp\_utility::_id_863E(11, _id_04D1::_id_45F7());

  _id_04D1::_id_7E30();

  if(level._id_289F) {
    var_1 = _id_44E2("allies");
    var_2 = _id_44E2("axis");

    if(var_1 == 0 && var_2 == 0)
      _id_6BB6();
  }
}

_id_6AEF(var_0) {
  var_1 = _id_04D1::_id_45F7();
  var_2 = level._id_6C63[var_1];
  _id_04D1::_id_0C1D("any");
  _id_04D1::_id_8A60("any");
  _id_04D1::_id_860A("friendly", level._id_5020);
  _id_04D1::_id_860E("friendly", level._id_5021, undefined, 1);

  if(var_1 == "allies") {
    _id_04D1::_id_860A("enemy", level._id_4FF9);
    _id_04D1::_id_860E("enemy", level._id_4FFA, undefined, 1);
  } else {
    _id_04D1::_id_860A("enemy", level._id_4FFF);
    _id_04D1::_id_860E("enemy", level._id_5000, undefined, 1);
  }

  self._id_A582[0] _id_8BF9(var_1);
  self._id_A582[1] _id_8BF9(maps\mp\_utility::getotherteam(var_1));
  _id_6AF0(var_1);

  if(var_1 == "axis") {
    maps\mp\_utility::_id_863F(self, level._id_500E, 1, 1);
    _func_032("ui_broadcaster_game_mode_status_1", 0 - level._id_3CC4);
  } else {
    maps\mp\_utility::_id_863F(self, level._id_500E, 2, 1);
    _func_032("ui_broadcaster_game_mode_status_2", 0 - level._id_3CC4);
  }

  if(isDefined(var_0)) {
    var_0._id_0112 = 0;

    if(isDefined(var_0._id_2013))
      var_0 _id_2E40();

    var_0 _meth_8608(0);
    var_0 thread _id_052C::_id_A06E();
  }

  maps\mp\_utility::leaderdialog("flag_dropped", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml", var_1);
  maps\mp\_utility::leaderdialog("enemy_flag_dropped", var_2, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml", var_2);
  thread _id_7E2C();
}

_id_7E2C() {
  self endon("picked_up");
  self endon("reset");
  wait(level._id_3CC4);
  var_0 = _id_04D1::_id_45F7();
  var_1 = level._id_6C63[var_0];
  maps\mp\_utility::leaderdialog("flag_returned", var_0, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med", var_0);
  maps\mp\_utility::leaderdialog("enemy_flag_returned", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med", var_1);
  maps\mp\_utility::_id_863E(11, _id_04D1::_id_45F7());
  thread _id_7E2F(0);
}

_id_6B93() {
  var_0 = _id_04D1::_id_45F7();
  var_1 = level._id_6C63[var_0];
  _id_04D1::_id_0C1D("enemy");
  _id_04D1::_id_8A60("none");
  _id_04D1::_id_860A("enemy", level._id_5011);
  _id_04D1::_id_860E("enemy", level._id_5012, undefined, 1);

  if(level._id_6FEF != 2) {
    _id_04D1::_id_860A("friendly", level._id_5014);
    _id_04D1::_id_860E("friendly", level._id_5015, undefined, 1);
  } else {
    _id_04D1::_id_860A("friendly", undefined);
    _id_04D1::_id_860E("friendly", undefined);
  }

  _id_6B94(var_0);
  level._id_1FC6[var_0] _id_04D1::_id_0C30("friendly");
  level._id_1FC6[var_0] _id_04D1::_id_8A60("any");

  if(var_0 == "allies") {
    level._id_1FC6[var_0] _id_04D1::_id_860A("friendly", level._id_4FFB);
    level._id_1FC6[var_0] _id_04D1::_id_860E("friendly", level._id_4FFC, undefined, 1);
    level._id_1FC6[var_0] _id_04D1::_id_860A("enemy", level._id_4FF9);
    level._id_1FC6[var_0] _id_04D1::_id_860E("enemy", level._id_4FFA, undefined, 1);
    maps\mp\_utility::_id_863F(level._id_1FC6[var_0], undefined);
    maps\mp\_utility::_id_863F(self, level._id_4FFD, 2, 1);
    _func_032("ui_broadcaster_game_mode_status_1", 0);
  } else {
    level._id_1FC6[var_0] _id_04D1::_id_860A("friendly", level._id_5001);
    level._id_1FC6[var_0] _id_04D1::_id_860E("friendly", level._id_5002, undefined, 1);
    level._id_1FC6[var_0] _id_04D1::_id_860A("enemy", level._id_4FFF);
    level._id_1FC6[var_0] _id_04D1::_id_860E("enemy", level._id_5000, undefined, 1);
    maps\mp\_utility::_id_863F(level._id_1FC6[var_0], undefined);
    maps\mp\_utility::_id_863F(self, level._id_4FFD, 1, 1);
    _func_032("ui_broadcaster_game_mode_status_2", 0);
  }

  self._id_A582[0] _id_8BF9(var_0);
  self._id_A582[1] _id_8BF9(maps\mp\_utility::getotherteam(var_0));
}

_id_6BBF(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == "allies")
    var_2 = "axis";
  else
    var_2 = "allies";

  maps\mp\_utility::leaderdialog("enemy_flag_captured", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_1);
  maps\mp\_utility::leaderdialog("flag_captured", var_2, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_2);
  var_0 thread _id_052C::_id_A06E();
  var_0 thread _id_047A::_id_3CB7();
  var_0 notify("ch_capture", self);
  _id_04D2::_id_47BD(var_1, 1, 1);

  if(var_1 == game["attackers"])
    game["allies_side_caps"]++;
  else if(var_1 == game["defenders"])
    game["axis_side_caps"]++;

  game["shut_out"][var_2] = 0;
  maps\mp\_utility::_id_863E(9, var_1, var_0 getentitynumber());

  if(_id_04D1::_id_45F7() == "allies")
    _func_032("ui_broadcaster_game_mode_status_1", 0);
  else
    _func_032("ui_broadcaster_game_mode_status_2", 0);

  level thread _id_21E2(var_1);

  if(isDefined(var_0)) {
    var_0._id_0112 = 0;

    if(isDefined(var_0._id_2013))
      var_0 _id_2E40();

    var_0 _meth_8608(0);
  }

  if(isDefined(level._id_2899) && isDefined(level._id_2899[var_1]))
    var_0 thread _id_7CDB();

  level._id_9853[var_2] _id_7E2F(1);
}

_id_21E2(var_0) {
  var_1 = "roundsWon";

  if(level._id_AA24)
    var_1 = "teamScores";

  if(maps\mp\_utility::inovertime()) {
    _id_A15D(var_0);

    if(game["status"] == "overtime") {
      game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
      level thread maps\mp\gametypes\_gamelogic::_id_36B9("overtime_halftime", game["end_reason"]["score_limit_reached"]);
    } else if(game["status"] == "overtime_halftime") {
      if(game["roundsWon"]["axis"] == game["roundsWon"]["allies"])
        _id_A15D(var_0);

      if(game["teamScores"]["axis"] == game["teamScores"]["allies"])
        game["teamScores"][var_0]++;

      if(var_0 == "allies" || var_0 == "axis" || var_0 == "tie")
        _func_0F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_0, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);

      level thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, game["end_reason"]["score_limit_reached"]);
    }
  } else if(game["teamScores"][var_0] == maps\mp\_utility::getwatcheddvar("scorelimit")) {
    _id_A15D(var_0);

    if(game["status"] == "normal") {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
      level thread maps\mp\gametypes\_gamelogic::_id_36B9("halftime", game["end_reason"]["score_limit_reached"]);
    } else if(game["status"] == "halftime") {
      var_2 = var_0;

      if(game[var_1]["axis"] == game[var_1]["allies"]) {
        var_2 = "overtime";
        level._id_3B5C = "none";
      }

      if(var_2 == "allies" || var_2 == "axis")
        _func_0F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_2, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);

      level thread maps\mp\gametypes\_gamelogic::_id_36B9(var_2, game["end_reason"]["switching_sides"]);
    }
  }
}

_id_A15D(var_0) {
  level._id_3B5C = var_0;
  game["roundsWon"][var_0]++;
}

_id_6B42(var_0) {
  _id_6BB6();
}

_id_6BB6() {
  level._id_3B5C = "none";
  var_0 = "roundsWon";

  if(level._id_AA24)
    var_0 = "teamScores";

  if(maps\mp\_utility::inovertime()) {
    if(game["status"] == "overtime")
      level thread maps\mp\gametypes\_gamelogic::_id_36B9("overtime_halftime", game["end_reason"]["time_limit_reached"]);
    else if(game["status"] == "overtime_halftime") {
      var_1 = "tie";

      if(game[var_0]["axis"] > game[var_0]["allies"])
        var_1 = "axis";

      if(game[var_0]["allies"] > game[var_0]["axis"])
        var_1 = "allies";

      _func_0F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_1, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
      level thread maps\mp\gametypes\_gamelogic::_id_36B9(var_1, game["end_reason"]["time_limit_reached"]);
    }
  } else if(game["status"] == "halftime") {
    if(level._id_3992 > 0 && level._id_289F == 0) {
      var_2 = 0;
      var_3 = _id_44E2("allies");
      var_4 = _id_44E2("axis");
      var_5 = game[var_0]["allies"];
      var_6 = game[var_0]["axis"];
      var_7 = game["teamScores"]["allies"];
      var_8 = game["teamScores"]["axis"];
      var_9 = var_8 - var_7 <= 1 && var_8 - var_7 >= 0;
      var_10 = var_7 - var_8 <= 1 && var_7 - var_8 >= 0;
      var_11 = var_6 - var_5 <= 1 && var_6 - var_5 >= 0;
      var_12 = var_5 - var_6 <= 1 && var_5 - var_6 >= 0;

      if(var_12 && var_3 != 0 || var_11 && var_4 != 0) {
        if(level._id_AA24)
          var_2 = 1;
        else if(var_10 && var_3 != 0 || var_9 && var_4 != 0)
          var_2 = 1;
      }

      if(var_2) {
        level._id_289F = 1;

        foreach(var_14 in level.players)
        var_14 thread maps\mp\gametypes\_hud_message::_id_9102("ctf_extratime");

        return;
      }
    }

    var_1 = "tie";

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      var_1 = "axis";

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
      var_1 = "allies";

    if(var_1 == "axis" || var_1 == "allies")
      _id_A15D(var_1);

    if(game[var_0]["axis"] == game[var_0]["allies"])
      var_1 = "overtime";

    if(var_1 == "allies" || var_1 == "axis" || var_1 == "tie")
      _func_0F5("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_1, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);

    level thread maps\mp\gametypes\_gamelogic::_id_36B9(var_1, game["end_reason"]["time_limit_reached"]);
  } else {
    if(level._id_3992 > 0 && level._id_289F == 0) {
      var_2 = 0;
      var_3 = _id_44E2("allies");
      var_4 = _id_44E2("axis");
      var_7 = game["teamScores"]["allies"];
      var_8 = game["teamScores"]["axis"];
      var_16 = var_8 - var_7 <= 1 && var_8 - var_7 >= 0;
      var_17 = var_7 - var_8 <= 1 && var_7 - var_8 >= 0;

      if(var_3 != 0 || var_4 != 0) {
        if(level._id_AA24)
          var_2 = 1;
        else if(var_17 && var_3 != 0 || var_16 && var_4 != 0)
          var_2 = 1;
      }

      if(var_2) {
        level._id_289F = 1;

        foreach(var_14 in level.players)
        var_14 thread maps\mp\gametypes\_hud_message::_id_9102("ctf_extratime");

        return;
      }
    }

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      _id_A15D("axis");

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
      _id_A15D("allies");

    level thread maps\mp\gametypes\_gamelogic::_id_36B9("halftime", game["end_reason"]["time_limit_reached"]);
  }
}

_id_0F32(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self._id_56A3) && self._id_56A3 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level._id_2899[self.team];
  self._id_3FC5 = self.class;
  self._id_3FC4 = 1;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  maps\mp\gametypes\_class::_id_4773(self.team, "gamemode");

  if(self._id_5DF6)
    _id_051E::_id_A129(1);

  _id_7B84();
  thread _id_A687(var_0);
}

_id_7B84() {
  var_0 = self _meth_82D1();

  foreach(var_2 in var_0)
  self _meth_84AF(var_2);
}

_id_A687(var_0) {
  level endon("game_ende");
  self endon("disconnect");
  self endon("death");
  self waittill("spawned_player");
  _id_1148(var_0);
}

_id_7CDB() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self._id_56A3) && self._id_56A3 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  self.pers["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::_id_4773(self.team, self.class);

  if(self._id_5DF6)
    _id_051E::_id_A129(1);

  _id_7B84();
}

_id_6AC9(var_0) {}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != self.pers["team"]) {
    if(isDefined(var_1._id_2013))
      var_1 thread _id_047A::_id_5A84(var_4);

    if(isDefined(self._id_2013)) {
      var_1 thread _id_047A::_id_5A46(var_9);
      maps\mp\_utility::_id_863E(10, var_1.team, var_1 getentitynumber());
      _id_2E40();
      self._id_2EF1 = 1;
      return;
    } else
      self._id_2EF1 = 0;

    var_10 = 65536;

    foreach(var_12 in level._id_1FC6) {
      var_13 = _func_211(var_1.origin, var_12._id_28D4);
      var_14 = _func_211(self.origin, var_12._id_28D4);

      if(var_14 < var_10)
        var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);

      if(var_12._id_6DB2 == var_1.team) {
        if(var_13 < var_10 || var_14 < var_10) {
          var_1 thread _id_047A::_id_2C80(self, var_9, var_4);
          var_1 maps\mp\_utility::_id_867C(var_1.pers["defends"]);
          var_1._id_62A1["defendObjective"] = var_12;
        }
      }

      if(var_12._id_6DB2 == self.team) {
        if(var_13 < var_10 || var_14 < var_10) {
          var_1 thread _id_047A::_id_10BA(self, var_9, var_4);
          var_1._id_62A1["assaultObjective"] = var_12;
        }
      }
    }
  } else if(isDefined(self._id_2013))
    _id_2E40();
}

_id_1148(var_0) {
  var_1 = level._id_6C63[self.pers["team"]];
  level._id_2013[var_1][self.pers["team"]] linktosynchronizedparent(self, "J_spine4", (0, 0, 0), (0, 0, 0));
  self._id_2013 = level._id_2013[var_1][self.pers["team"]];
  level._id_2013[var_1][self.pers["team"]] _id_8BF9(self.pers["team"]);
  level._id_2013[var_1][var_1] linktosynchronizedparent(self, "J_spine4", (0, 0, 0), (0, 0, 0));
  self._id_2014 = level._id_2013[var_1][var_1];
  level._id_2013[var_1][var_1] _id_8BF9(var_1);
  thread _id_2E41(self._id_2013, self._id_2014);
}

_id_2E40() {
  self notify("lost_ctf_flag");
  self._id_2013 _meth_8057();
  self._id_2013 _meth_805C();
  self._id_2013 = undefined;
  self._id_2014 _meth_8057();
  self._id_2014 _meth_805C();
  self._id_2014 = undefined;
}

_id_872E() {
  if(_func_133() && _func_132("defaultClasses", "axis", "defaultClass", 5, "class", "inUse"))
    level._id_2899["axis"] = maps\mp\_utility::_id_4573("axis", 5);

  if(_func_133() && _func_132("defaultClasses", "allies", "defaultClass", 5, "class", "inUse"))
    level._id_2899["allies"] = maps\mp\_utility::_id_4573("allies", 5);
}

_id_1FC4() {
  waittillframeend;
  _id_3EC2(level._id_3CB5, self._id_15FA, self._id_15F9);
}

_id_3EC3() {
  if(isDefined(self._id_3ED4))
    self._id_3ED4 delete();

  if(isDefined(self._id_3769))
    self._id_3769 delete();

  if(isDefined(self._id_1C98))
    self._id_1C98 delete();
}

_id_3EC2(var_0, var_1, var_2) {
  var_3 = self._id_6DB2;
  var_4 = var_0[game[var_3]][2];
  var_5 = var_0[game[var_3]][0];

  if(game[var_3] == "allies")
    var_6 = var_0[game[var_3]][3];
  else
    var_6 = var_0[game[var_3]][4];

  _id_3EC3();
  self._id_3ED4 = maps\mp\_utility::_id_9067(var_4, var_3, var_1, var_2);
  self._id_3769 = maps\mp\_utility::_id_9067(var_5, maps\mp\_utility::getotherteam(var_3), var_1, var_2);
  self._id_1C98 = maps\mp\_utility::_id_9067(var_6, "broadcaster", var_1, var_2);
}

_id_1FC3() {
  foreach(var_1 in level._id_9853) {
    if(var_1._id_A582.size) {
      var_2 = var_1._id_A582[0].origin + (0, 0, 32);
      var_3 = var_1._id_A582[0].origin + (0, 0, -32);
      var_4 = bulletTrace(var_2, var_3, 0, undefined);
      var_5 = vectortoangles(var_4["normal"]);
      var_1._id_15F9 = anglesToForward(var_5);
      var_1._id_15FA = var_4["position"];
      var_6 = level._id_1FC6[var_1._id_6DB2];
      var_6._id_15F9 = var_1._id_15F9;
      var_6._id_15FA = var_1._id_15FA;
      var_6 thread _id_1FC4();
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_748E();
  }
}

_id_8BF8(var_0) {
  var_1 = maps\mp\_utility::getotherteam(var_0);
  self._id_A582[0] _meth_805C();
  self._id_A582[1] _meth_805C();

  foreach(var_3 in level.players) {
    if(var_3.team == var_0)
      self._id_A582[0] _meth_8005(var_3);

    if(var_3.team == "spectator" && var_0 == "allies")
      self._id_A582[0] _meth_8005(var_3);

    if(var_3.team == var_1)
      self._id_A582[1] _meth_8005(var_3);

    if(var_3.team == "spectator" && var_1 == "allies")
      self._id_A582[1] _meth_8005(var_3);
  }

  for(;;) {
    level waittill("joined_team");

    if(!isDefined(self._id_2006)) {
      self._id_A582[0] _meth_805C();
      self._id_A582[1] _meth_805C();

      foreach(var_3 in level.players) {
        if(var_3.team == var_0)
          self._id_A582[0] _meth_8005(var_3);

        if(var_3.team == "spectator" && var_0 == "allies")
          self._id_A582[0] _meth_8005(var_3);

        if(var_3.team == var_1)
          self._id_A582[1] _meth_8005(var_3);

        if(var_3.team == "spectator" && var_1 == "allies")
          self._id_A582[1] _meth_8005(var_3);
      }

      continue;
    }

    var_7 = _id_04D1::_id_45F7();
    var_1 = maps\mp\_utility::getotherteam(var_7);
    level._id_2013[var_7][var_7] _meth_805C();
    level._id_2013[var_7][var_1] _meth_805C();

    foreach(var_3 in level.players) {
      if(var_3.team == "allies" || var_3.team == "axis") {
        level._id_2013[var_7][var_3.team] _meth_8005(var_3);
        continue;
      }

      if(var_3.team == "spectator")
        level._id_2013[var_7]["allies"] _meth_8005(var_3);
    }
  }
}

_id_8BF9(var_0) {
  self _meth_805C();

  foreach(var_2 in level.players) {
    if(var_2.team == var_0)
      self _meth_8005(var_2);

    if(var_2.team == "spectator" && var_0 == "allies")
      self _meth_8005(var_2);
  }
}

_id_2E41(var_0, var_1) {
  level endon("game_ended");
  self endon("lost_ctf_flag");
  self waittill("disconnect");
  var_0 _meth_805C();
  var_1 _meth_805C();
}