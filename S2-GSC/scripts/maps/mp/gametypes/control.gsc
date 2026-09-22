/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\control.gsc
*************************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 30);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 100);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 2);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level._id_0C27 = 0;
  level._id_6BAF = ::_id_6BAF;
  level._id_6B7B = ::_id_6B7B;
  level._id_6BA7 = ::_id_6BA7;
  level._id_260B = gettime();
  level._id_2606 = 5;
  level._id_0BDB["axis"]["time"] = 0;
  level._id_0BDB["axis"]["awarded"] = 0;
  level._id_0BDB["allies"]["time"] = 0;
  level._id_0BDB["allies"]["awarded"] = 0;
  level._id_0BF4 = [];
  level._id_147A = [];
  level._id_3208 = spawnStruct();

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  game["dialog"]["gametype"] = "dom_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";
  level._id_501B = "waypoint_captureneutral";
  level._id_501A = "waypoint_captureneutral";
  level._id_5004 = "waypoint_capture";
  level._id_5003 = "waypoint_capture";
  level._id_500B = "waypoint_defend";
  level._id_500A = "waypoint_defend";
  level._id_5008 = "waypoint_contested";
  level._id_5007 = "waypoint_contested";
  level._id_5025 = "waypoint_taking";
  level._id_5026 = "waypoint_taking";
  level._id_5016 = "waypoint_losing";
  level._id_5017 = "waypoint_losing";
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _setdynamicdvar("scr_control_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("control", 0);
  _setdynamicdvar("scr_control_winlimit", 2);
  maps\mp\_utility::registerwinlimitdvar("control", 1);
  _setdynamicdvar("scr_control_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("control", 0);
  _setdynamicdvar("scr_dom_allowNeutral", 0);
  _setdynamicdvar("scr_dom_halftimeswitchsides", 0);
}

_id_6BAF() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(game["status"] == "halftime") {
    _setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    _setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    _setomnvar("ui_current_round", 4);
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DOM");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DOM");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_DOM_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_DOM_HINT");
  _setclientnamemode("auto_change");
  _id_5353();
  _id_7651();
  var_2[0] = "control";
  _id_04D1::main(var_2);
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  _setomnvar("ui_broadcaster_game_mode_status_2", 0);
  _setomnvar("ui_broadcaster_game_mode_status_3", 0);
  level thread _id_3211();
  level thread _id_A109();
  level thread _id_A160();
  level._id_4958 = maps\mp\_utility::dvarintvalue("halftimeswitchsides", 1, 0, 1);
  level._id_0C27 = maps\mp\_utility::dvarintvalue("allowNeutral", 0, 0, 1);
}

_id_A160() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_A0F1();
    var_0 thread _id_A108();
  }
}

_id_A0F1() {
  waittillframeend;
  maps\mp\_utility::_id_867B(self.pers["captures"]);
}

_id_A108() {
  waittillframeend;
  maps\mp\_utility::_id_867C(self.pers["defends"]);
}

_id_A0EA() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      var_1._id_0112 = 0;

      foreach(var_3 in level._id_3211) {
        if(var_1 istouching(var_3.levelflag)) {
          if(var_3._id_689F["axis"] * var_3._id_689F["allies"] > 0) {
            var_1._id_0112 = 1;
          } else if(var_3._id_6DB2 == "neutral") {
            if(var_1.team == "allies") {
              var_1._id_0112 = 2;
            } else {
              var_1._id_0112 = 3;
            }
          } else if(var_3._id_6DB2 == "allies") {
            if(var_1.team == "allies") {
              var_1._id_0112 = 4;
            } else {
              var_1._id_0112 = 5;
            }
          } else if(var_3._id_6DB2 == "axis") {
            if(var_1.team == "axis") {
              var_1._id_0112 = 6;
            } else {
              var_1._id_0112 = 7;
            }
          }

          if(var_1._id_0112 > 0) {
            if(var_3.label == "_b") {
              var_1._id_0112 = var_1._id_0112 + 7;
              continue;
            }

            if(var_3.label == "_c") {
              var_1._id_0112 = var_1._id_0112 + 14;
            }
          }
        }
      }
    }

    waitframe();
  }
}

_id_7651() {
  game["neutral"] = "neutral";
  level._id_188C[_getmapcustom("allieschar")]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level._id_188C[_getmapcustom("allieschar")]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level._id_188C[_getmapcustom("axischar")]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level._id_188C[_getmapcustom("axischar")]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level._id_188C["neutral"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom_white");
  level._id_188C["neutral"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_white");
}

_id_5353() {
  _id_050D::_id_10E4();
}

_id_46C8(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_3211) {
    if(var_3._id_6DB2 == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_454E() {
  return "_c";
}

_id_45DB() {
  return "_b";
}

_id_3211() {
  level._id_5BFF["allies"] = 0;
  level._id_5BFF["axis"] = 0;
  var_0 = 1;
  var_1 = getEntArray("control_zone", "targetname");

  foreach(var_3 in var_1) {
    var_3._id_ACB1 = _getEnt(var_3.target, "targetname");
    var_3._id_ACB1 hide();
  }

  if(!isDefined(game["controlPointOrder"])) {
    game["controlPointOrder"] = ["_a", "_b", "_c"];
    game["controlPointOrder"] = common_scripts\utility::array_randomize(game["controlPointOrder"]);
    game["controlRoundNum"] = 0;
  }

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(var_1[var_5].shootblank == game["controlPointOrder"][game["controlRoundNum"]]) {
      level._id_2609 = var_1[var_5];
      level._id_AC7C = level._id_2609;
      break;
    }
  }

  game["controlRoundNum"]++;
  level._id_3211 = [];
  var_6[0] = _getEnt(level._id_2609._id_ACB1.target, "targetname");
  var_6[1] = _getEnt(var_6[0].target, "targetname");
  var_6[1] scriptmodelplayanim("ctf_flag_flap");
  var_6[0].origin = var_6[0].origin + (0, 0, -10000);
  var_6[1].origin = var_6[1].origin + (0, 0, -10000);
  level._id_2609._id_ACB1 show();
  var_7 = _id_04D1::_id_2837("neutral", level._id_2609, var_6, (0, 0, 0));
  var_7 _id_04D1::_id_8A5A(level._id_2606);
  var_7 _id_04D1::_id_8A59(&"MP_SECURING_POSITION");
  var_8 = var_7 _id_04D1::_id_454C();
  var_7.label = var_8;
  var_7 _id_04D1::set2dicon("friendly", level._id_500A);
  var_7 _id_04D1::playsoundtoteam("friendly", level._id_500B);
  var_7 _id_04D1::set2dicon("enemy", level._id_501A);
  var_7 _id_04D1::playsoundtoteam("enemy", level._id_501B);
  var_7 _id_04D1::set2dicon("broadcaster", "waypoint_esports_dom_white" + var_8);
  var_7 _id_04D1::playsoundtoteam("broadcaster", "waypoint_esports_dom_white" + var_8, 3);
  var_7 _id_04D1::_id_8A60("any");
  var_7._id_6BBF = ::_id_6BBF;
  var_7._id_6ABC = ::_id_6ABC;
  var_7._id_6BCB = ::_id_6BCB;
  var_7._id_6AFA = ::_id_6AFA;
  var_7._id_681A = 1;
  var_7._id_502A = "domFlag";
  var_7._id_4B25 = 0;
  var_7._id_3C66 = 1;
  var_9 = var_6[0].origin + (0, 0, 32);
  var_10 = var_6[0].origin + (0, 0, -32);
  var_11 = bulletTrace(var_9, var_10, 0, var_6[0]);
  var_12 = vectortoangles(var_11["normal"]);
  var_7._id_15F9 = anglesToForward(var_12);
  var_7._id_15FB = anglestoright(var_12);
  var_7._id_15FA = var_11["position"];
  var_6[0].origin = var_11["position"];
  var_7 thread _id_A192(1);
  level._id_2609._id_A222 = var_7;
  var_7.levelflag = level._id_2609;
  level._id_3211[level._id_3211.size] = var_7;
  var_13 = _id_050D::_id_46A0("axis");
  var_14 = _id_050D::_id_46A0("allies");
  level._id_92FA["allies"] = var_14[0].origin;
  level._id_92FA["axis"] = var_13[0].origin;
  _id_3CC7();
  wait 1;
  var_15 = gettime();

  for(var_16 = 0; var_16 < level._id_3211.size; var_16++) {
    _reconspatialevent(level._id_3211[var_16]._id_A582[0].origin, "script_mp_captures: team %s, gameTime %d", "neutral", var_15);
    _reconspatialevent(level._id_3211[var_16]._id_A582[0].origin, "script_mp_dom: gameTime %d, label %s, owner %s", var_15, level._id_3211[var_16].label, level._id_3211[var_16]._id_6DB2);
  }

  thread _id_260A(var_7);
}

_id_260A(var_0) {
  maps\mp\_utility::gameflagwait("prematch_done");
  _setomnvar("ui_control_countdown_time", gettime() + 30000);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(30);
  var_0 _id_04D1::_id_0C30("enemy");
  _setomnvar("ui_control_countdown_time", 1);
  wait 2;
  _setomnvar("ui_control_countdown_time", 0);
}

_id_6ABC(var_0) {
  var_1 = _id_04D1::_id_45F7();
  self._id_2EE9 = 0;
  _id_04D1::_id_8A5A(level._id_2606);

  if(var_1 == "neutral") {
    _id_933E("securing" + self.label, var_0.team);

    if(self._id_3C66 || self._id_28D5 == 0) {
      _id_04D1::_id_8A5A(level._id_2606);
    }
  } else {
    if(var_1 == "allies") {
      level._id_0BF4[level._id_0BF4.size] = self.label;
      var_2 = "axis";
      return;
    }

    level._id_147A[level._id_147A.size] = self.label;
    var_2 = "allies";
  }
}

_id_6BCB(var_0, var_1, var_2) {
  var_3 = _id_04D1::_id_45F7();

  if(var_1 > 0.05 && var_2 && !self._id_2EE9) {
    if(var_3 == "neutral") {
      _id_933E("securing" + self.label, var_0);

      if(var_0 == "allies") {
        _id_04D1::set2dicon("broadcaster", "waypoint_esports_dom_blue_taking" + self.label);
        _id_04D1::playsoundtoteam("broadcaster", "waypoint_esports_dom_blue_taking" + self.label, 3);
      } else {
        _id_04D1::set2dicon("broadcaster", "waypoint_esports_dom_red_taking" + self.label);
        _id_04D1::playsoundtoteam("broadcaster", "waypoint_esports_dom_red_taking" + self.label, 3);
      }
    } else {
      _id_933E("losing" + self.label, var_3, 1);
      _id_933E("securing" + self.label, var_0);

      if(var_3 == "allies") {
        _id_04D1::set2dicon("broadcaster", "waypoint_esports_dom_blue_losing" + self.label);
        _id_04D1::playsoundtoteam("broadcaster", "waypoint_esports_dom_blue_losing" + self.label, 3);
      } else {
        _id_04D1::set2dicon("broadcaster", "waypoint_esports_dom_red_losing" + self.label);
        _id_04D1::playsoundtoteam("broadcaster", "waypoint_esports_dom_red_losing" + self.label, 3);
      }
    }

    _id_04D1::set2dicon("enemy", level._id_5025);
    _id_04D1::playsoundtoteam("enemy", level._id_5026);
    _id_04D1::set2dicon("friendly", level._id_5016);
    _id_04D1::playsoundtoteam("friendly", level._id_5017);
    self._id_2EE9 = 1;
  } else if(level._id_0C27 && var_1 > 0.49 && var_2 && self._id_2EE9 && var_3 != "neutral") {
    var_4 = _id_04D1::_id_44AF();
    var_5 = gettime();
    _reconspatialevent(self._id_A582[0].origin, "script_mp_captures: player_name %s, life_id %d, team %s, gameTime %d", var_4.name, var_4._id_5CC6, "neutral", var_5);
    _id_04D1::_id_86EC("neutral");
    _id_A192();
    _id_933E("lost" + self.label, var_3, 1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_0);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_3);
    _id_A189(self.label, "neutral");
    thread _id_4787(self._id_9AC3[var_0]);
  }
}

_id_933E(var_0, var_1, var_2) {
  var_3 = gettime();

  if(gettime() < level._id_5BFF[var_1] + 5000 && (!isDefined(var_2) || !var_2)) {
    return;
  }
  thread _id_2CDB(var_0, var_1);
  level._id_5BFF[var_1] = gettime();
}

_id_6AFA(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_capture_icon", 0);
  }

  var_3 = _id_04D1::_id_45F7();

  if(var_3 != "neutral") {
    _id_04D1::set2dicon("enemy", level._id_5003);
    _id_04D1::playsoundtoteam("enemy", level._id_5004);
    _id_04D1::set2dicon("friendly", level._id_500A);
    _id_04D1::playsoundtoteam("friendly", level._id_500B);
  } else {
    _id_04D1::set2dicon("enemy", level._id_501A);
    _id_04D1::playsoundtoteam("enemy", level._id_501B);
    _id_04D1::set2dicon("friendly", level._id_501A);
    _id_04D1::playsoundtoteam("friendly", level._id_501B);
  }

  if(var_0 == "allies") {
    common_scripts\utility::_id_0F93(level._id_0BF4, self.label);
  } else {
    common_scripts\utility::_id_0F93(level._id_0BF4, self.label);
  }
}

_id_A192(var_0) {
  if(isDefined(var_0) && var_0) {
    waittillframeend;
  }

  if(!_isremovedentity(self._id_A582[0])) {
    var_1 = self._id_A582[0];
    _id_3EC2(var_1.origin, anglestoup(var_1.angles));
  }
}

_id_3EC2(var_0, var_1) {
  var_2 = self._id_6DB2;

  if(var_2 == "allies") {
    self._id_A582[1] setModel("usa_ctf_flag_anim");
  } else if(var_2 == "axis") {
    self._id_A582[1] setModel("ger_ctf_flag_anim");
  }

  var_3 = gettime();
  _reconspatialevent(self._id_A582[0].origin, "script_mp_dom: gameTime %d, label %s, owner %s", var_3, self.label, self._id_6DB2);
}

_id_3EC3() {
  if(isDefined(self._id_3ED3)) {
    self._id_3ED3 delete();
  }

  if(isDefined(self._id_3EBE)) {
    self._id_3EBE delete();
  }

  if(isDefined(self._id_1C94)) {
    self._id_1C94 delete();
  }

  if(isDefined(self._id_1C90)) {
    self._id_1C90 delete();
  }

  if(isDefined(self._id_3768)) {
    self._id_3768 delete();
  }

  if(isDefined(self._id_3766)) {
    self._id_3766 delete();
  }
}

_id_A189(var_0, var_1) {
  var_2 = "ui_broadcaster_game_mode_status_1";

  if(var_0 == "_b") {
    var_2 = "ui_broadcaster_game_mode_status_2";
  }

  if(var_0 == "_c") {
    var_2 = "ui_broadcaster_game_mode_status_3";
  }

  if(var_1 == "allies") {
    _setomnvar(var_2, -1);
  } else if(var_1 == "axis") {
    _setomnvar(var_2, 1);
  } else {
    _setomnvar(var_2, 0);
  }
}

_id_6BBF(var_0) {
  var_1 = gettime();
  var_2 = var_0.team;
  var_3 = _id_04D1::_id_45F7();
  var_4 = 0;
  var_5 = 0;

  if(self._id_3C66 && self.label == _id_45DB()) {
    var_4 = 1;
  } else if(self._id_3C66 && self.label != _id_45DB()) {
    var_5 = 1;
  }

  self._id_1FC1 = gettime();
  self._id_3C66 = 0;
  self._id_4B25 = 1;

  if(isDefined(self._id_6DA9)) {
    self._id_6DA9 = 0;
  } else {
    self._id_6DA9 = 1;
  }

  _reconspatialevent(self._id_A582[0].origin, "script_mp_captures: player_name %s, life_id %d, team %s, gameTime %d", var_0.name, var_0._id_5CC6, var_2, var_1);
  _id_04D1::_id_86EC(var_2);
  _id_04D1::set2dicon("enemy", level._id_5003);
  _id_04D1::playsoundtoteam("enemy", level._id_5004);
  _id_04D1::set2dicon("friendly", level._id_500A);
  _id_04D1::playsoundtoteam("friendly", level._id_500B);
  _id_A192();
  level._id_A239 = 0;

  if(var_3 == "neutral") {
    var_6 = maps\mp\_utility::getotherteam(var_2);
    _id_933E("secured" + self.label, var_2, 1);
    _id_933E("enemy_has" + self.label, var_6, 1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_2);
  } else {
    _id_933E("secured" + self.label, var_2, 1);
    _id_933E("lost" + self.label, var_3, 1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_2);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_3);
    level._id_1731[var_3] = self.levelflag;
  }

  _id_A189(self.label, var_2);
  var_0 thread _id_046C::_id_8DAE("mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
  thread _id_4786(self._id_9AC3[var_2], var_4, var_5);
}

_id_4786(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = _id_04D1::_id_44AF();

  if(isDefined(var_3._id_0117)) {
    var_3 = var_3._id_0117;
  }

  if(isPlayer(var_3)) {
    level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition" + self.label, var_3);
  }

  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_3 = var_0[var_4[var_5]].player;

    if(isDefined(var_3._id_0117)) {
      var_3 = var_3._id_0117;
    }

    if(!isPlayer(var_3)) {
      continue;
    }
    var_3 thread _id_047A::_id_320C(var_1, var_2);
    var_3 thread _id_A101();
    waitframe();
  }
}

_id_4787(var_0) {
  level endon("game_ended");
  var_1 = _id_04D1::_id_44AF();

  if(isDefined(var_1._id_0117)) {
    var_1 = var_1._id_0117;
  }

  if(isPlayer(var_1)) {
    level thread maps\mp\_utility::teamplayercardsplash("callout_neutralized_position" + self.label, var_1);
  }

  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_1 = var_0[var_2[var_3]].player;

    if(isDefined(var_1._id_0117)) {
      var_1 = var_1._id_0117;
    }

    if(!isPlayer(var_1)) {
      continue;
    }
    var_1 thread _id_047A::_id_3218();
    waitframe();
  }
}

_id_2CDB(var_0, var_1) {
  level endon("game_ended");
  wait 0.1;
  maps\mp\_utility::waittillslowprocessallowed();
  maps\mp\_utility::leaderdialog(var_0, var_1);
}

_id_2CDC(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  wait 0.1;
  maps\mp\_utility::waittillslowprocessallowed();
  maps\mp\_utility::leaderdialogbothteams(var_0, var_1, var_2, var_3);
}

_id_A109() {
  level endon("game_ended");

  while(!level.gameended) {
    var_0 = _id_45F5();

    if(var_0.size) {
      var_1 = undefined;
      var_2 = undefined;

      foreach(var_4 in var_0) {
        var_5 = var_4 _id_04D1::_id_45F7();
        _id_04D2::_id_47BD(var_5, 1, 0);

        if(!isDefined(var_1) || var_1 < var_4._id_1FC1) {
          var_1 = var_4._id_1FC1;
        }

        if(!isDefined(var_2)) {
          var_2 = var_5;
        }

        if(var_2 != var_5) {
          var_2 = "none";
        }
      }

      if(level._id_3211.size == var_0.size && var_2 != "none" && level.players.size > 5) {
        level._id_0BDB[var_2]["time"] = gettime() - var_1;
        level._id_0BDB[maps\mp\_utility::getotherteam(var_2)]["time"] = 0;

        if(level._id_0BDB[var_2]["time"] > 60000 && level._id_0BDB["axis"]["awarded"] == 0) {
          level._id_0BDB["axis"]["awarded"] = 1;

          foreach(var_8 in level.players) {
            if(var_8.team != var_2) {
              continue;
            }
            var_8 maps\mp\gametypes\_missions::processchallenge("ch_dom_tripcap");
          }
        }
      } else {
        level._id_0BDB["axis"]["time"] = 0;
        level._id_0BDB["allies"]["time"] = 0;
      }
    }

    var_10 = 1;
    var_11 = _id_454E();

    foreach(var_13 in level._id_3211) {
      if((var_13.label == "_a" || var_13.label == var_11) && var_13._id_4B25 == 0) {
        var_10 = 0;
        break;
      }
    }

    if(maps\mp\_utility::matchmakinggame() && !level._id_0C27 && !var_10 && _id_4473() > 120000 && !getdvarint("850")) {
      level._id_3B5C = "none";
      thread maps\mp\gametypes\_gamelogic::_id_36B9("none", game["end_reason"]["time_limit_reached"]);
      return;
    }

    thread maps\mp\gametypes\_gamelogic::_id_21E3();
    wait 1.5;
    maps\mp\gametypes\_hostmigration::_id_A782();
  }
}

_id_4473() {
  return gettime() - level._id_260B;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::_id_56FA(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  var_10 = 0;
  var_11 = self;

  foreach(var_13 in var_1._id_9AC5) {
    var_14 = 0;

    if(var_13 == level._id_2609) {
      var_14 = 1;
      break;
    }

    if(!var_14) {
      continue;
    }
    var_15 = var_13._id_A222._id_6DB2;

    if(var_1.team != var_15) {
      var_1 thread _id_047A::_id_5A82(var_11, var_9, var_4);
      var_10 = 1;
    }
  }

  var_17 = 90000;
  var_15 = level._id_2609._id_A222._id_6DB2;
  var_18 = distancesquared(level._id_2609.origin, var_11.origin);
  var_19 = distancesquared(level._id_2609.origin, var_1.origin);

  if(var_18 < var_17) {
    var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);
  }

  if(var_15 == var_1.team) {
    if(var_18 < var_17 || var_19 < var_17) {
      var_1 thread _id_047A::_id_2C80(var_11, var_9, var_4);
      var_1 maps\mp\_utility::_id_867C(var_1.pers["defends"]);
    }
  }

  if(var_10) {
    return;
  }
  if(var_15 == var_11.team) {
    if(var_19 < var_17 || var_18 < var_17) {
      var_1 thread _id_047A::_id_10BA(self, var_9, var_4);
    }
  }
}

_id_45F5() {
  var_0 = [];

  foreach(var_2 in level._id_3211) {
    if(var_2 _id_04D1::_id_45F7() != "neutral" && isDefined(var_2._id_1FC1)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_46CC(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_3211.size; var_2++) {
    if(level._id_3211[var_2] _id_04D1::_id_45F7() == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_44E3() {
  return self._id_A222 _id_04D1::_id_45F7();
}

_id_3CC7() {
  var_0 = _id_050D::_id_448A();

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0165) && issubstr(var_2._id_0165, "_override")) {
      var_2._id_766F = "_" + getsubstr(var_2._id_0165, 0, 1);
      continue;
    }

    var_2._id_663E = _id_459D(var_2);
    var_2._id_766F = var_2._id_663E._id_A222.label;
  }
}

_id_459D(var_0) {
  var_1 = _id_050D::_id_5770();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_3211) {
    var_6 = undefined;

    if(var_1) {
      var_6 = _getpathdist(var_0.origin, var_5.levelflag.origin, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5.levelflag.origin, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2.levelflag;
}

_id_6BA7() {}

_id_A101() {
  if(!isDefined(self._id_270D)) {
    self._id_6885 = 0;
    self._id_270D = 0;
  }

  self._id_6885++;

  if(maps\mp\_utility::getminutespassed() < 1) {
    return;
  }
  self._id_270D = self._id_6885 / maps\mp\_utility::getminutespassed();
}

_id_444A() {
  if(self._id_270D < 4) {
    return 1;
  } else {
    return 0.25;
  }
}