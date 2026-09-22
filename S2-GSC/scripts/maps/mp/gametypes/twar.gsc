/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\twar.gsc
**********************************************/

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
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 75);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  maps\mp\_utility::setovertimelimitdvar(3);
  maps\mp\_utility::_id_873B(1);
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_6BA7 = ::_id_6BA7;
  level._id_6BB6 = ::_id_6BB6;
  level._id_6B7B = ::_id_6B7B;
  level._id_0AA1 = 1;
  level._id_62AD = ::_id_6216;
  level._id_6A75 = ::_id_6AA5;
  level._id_3CBA = loadfx("vfx/unique/vfx_flag_project_neutral");
  level._id_188C = loadfx("vfx/unique/vfx_marker_dom_white");

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  game["dialog"]["gametype"] = "mom_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("311")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "mtm_alert";
  game["dialog"]["offense_obj"] = "mtm_alert";
  game["dialog"]["mtm_taking"] = "mtm_taking";
  game["dialog"]["mtm_etaking"] = "mtm_etaking";
  game["dialog"]["mtm_lastflg"] = "mtm_lastflg";
  game["dialog"]["mtm_elastflg"] = "mtm_elastflg";
  game["dialog"]["mtm_secured"] = "mtm_secured";
  game["dialog"]["mtm_captured"] = "mtm_captured";
  game["dialog"]["mtm_max"] = "mtm_max";
  game["dialog"]["mtm_gain"] = "mtm_gain";
  game["dialog"]["mtm_reset"] = "mtm_reset";
  game["dialog"]["mtm_clrd"] = "mtm_clrd";
  game["dialog"]["mtm_lost"] = "mtm_lost";

  if(!isDefined(game["shut_out"])) {
    game["shut_out"]["axis"] = 1;
    game["shut_out"]["allies"] = 1;
    game["max_meter"]["axis"] = 0;
    game["max_meter"]["allies"] = 0;
  }

  setDvar("5539", 1);
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _setdynamicdvar("scr_twar_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("twar", 0, 0, 9);
  _setdynamicdvar("scr_twar_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("twar", 1);
  _setdynamicdvar("scr_twar_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("twar", 1);
  _setdynamicdvar("scr_twar_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("twar", 0);
  _setdynamicdvar("scr_twar_halftime", 0);
  _setdynamicdvar("scr_twar_minionsmax", _getmatchrulesdata("twarData", "numMinions"));
  _setdynamicdvar("scr_twar_capture_time", _getmatchrulesdata("twarData", "captureTime"));
  _setdynamicdvar("scr_twar_zone_count", _getmatchrulesdata("twarData", "numFlags"));
  _setdynamicdvar("scr_twar_ot_zone_count", _getmatchrulesdata("twarData", "numOTFlags"));
  _setdynamicdvar("scr_twar_min_capture_players", 1);
  _setdynamicdvar("scr_twar_hud_momentum_bar", !_getmatchrulesdata("twarData", "hideMomentumBar"));
}

_id_6BAF() {
  _setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_TWAR");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_TWAR");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_TWAR");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_TWAR");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_TWAR_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_TWAR_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_TWAR_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_TWAR_HINT");
  game["dialog"]["lockouts"]["mtm_taking"] = 5;
  game["dialog"]["lockouts"]["mtm_etaking"] = 5;
  _id_050D::_id_10E4();
  var_2[0] = level.gametype;
  _id_04D1::main(var_2);
  level._id_AC8B = getdvarint("scr_twar_zone_radius", 150);
  level._id_AC87 = 60;
  level._id_62C4 = 3;
  _id_3B87();
  _id_2777();
  _id_520A("allies");
  _id_520A("axis");
  thread _id_A89E();
  thread _id_A139();
  thread _id_A0AE();
}

_id_A89E() {
  for(;;) {
    level waittill("joined_team");
    level notify("update_flag_outline");
    _id_A0B1();
  }
}

_id_6BB6() {
  level._id_3B5C = "none";

  if(game["status"] == "overtime") {
    var_0 = "tie";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_0 = "overtime";
    game["owned_flags"] = [];
    game["owned_flags"]["allies"] = 0;
    game["owned_flags"]["axis"] = 0;

    foreach(var_2 in level._id_9FC2) {
      if(var_2._id_0117 == "allies") {
        game["owned_flags"]["allies"]++;
        continue;
      }

      if(var_2._id_0117 == "axis") {
        game["owned_flags"]["axis"]++;
      }
    }
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level._id_3B5C = "axis";
    var_0 = "axis";
  } else {
    level._id_3B5C = "allies";
    var_0 = "allies";
  }

  if(maps\mp\_utility::_id_761E()) {
    var_0 = "none";
  }

  thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_8FA8(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("flag_holo_base_ground");
  return var_1;
}

_id_2777() {
  var_0[0] = _id_8FA8((0, 0, 0));
  var_1 = spawn("trigger_radius", (0, 0, 0), 0, level._id_AC8B, level._id_AC87);
  var_1.radius = level._id_AC8B;
  var_2 = getdvarfloat("scr_twar_capture_time", 20.0);
  var_3 = _id_04D1::_id_2837("neutral", var_1, var_0);
  var_3 _id_04D1::_id_0C30("any");
  var_3 _id_04D1::_id_8A5A(var_2);
  var_3 _id_04D1::_id_8A60("any");
  var_3._id_59DD = 1;
  var_3._id_681A = 1;
  var_3._id_502A = "twarZone";
  var_3._id_6ABC = ::_id_6ABC;
  var_3._id_6BBF = ::_id_6BBF;
  var_3._id_6AFA = ::_id_6AFA;
  var_3._id_6BBE = ::_id_6BBE;
  level._id_9FC0 = var_3;
  _id_7D4C();
}

_id_AC8E() {
  _id_04D1::_id_86EC("neutral");
  _id_04D1::_id_0C30("none");
  var_0 = "waypoint_waitfor_flag_neutral";
  _id_04D1::set2dicon("friendly", var_0);
  _id_04D1::playsoundtoteam("friendly", var_0);
  _id_04D1::set2dicon("enemy", var_0);
  _id_04D1::playsoundtoteam("enemy", var_0);
  maps\mp\_utility::_id_863F(self, "waypoint_waitfor_flag_neutral", 3);
  self._id_A6E5 = 1;
  _setomnvar("ui_twar_capture_team", 3);
}

_id_A0AA(var_0, var_1) {
  if(isDefined(self._id_A6E5)) {
    return;
  }
  if(var_0 > 0 && var_1 > 0) {
    var_2 = "waypoint_contested";
    _id_04D1::set2dicon("friendly", var_2);
    _id_04D1::playsoundtoteam("friendly", var_2);
    _id_04D1::set2dicon("enemy", var_2);
    _id_04D1::playsoundtoteam("enemy", var_2);
    maps\mp\_utility::_id_863F(self, "waypoint_contested", 3);
  } else if(var_0 == 0 && var_1 == 0) {
    var_2 = "waypoint_captureneutral";
    _id_04D1::set2dicon("friendly", var_2);
    _id_04D1::playsoundtoteam("friendly", var_2);
    _id_04D1::set2dicon("enemy", var_2);
    _id_04D1::playsoundtoteam("enemy", var_2);
    maps\mp\_utility::_id_863F(self, "waypoint_captureneutral", 3);
  } else {
    _id_04D1::set2dicon("enemy", "waypoint_losing");
    _id_04D1::playsoundtoteam("enemy", "waypoint_losing");
    _id_04D1::set2dicon("friendly", "waypoint_taking");
    _id_04D1::playsoundtoteam("friendly", "waypoint_taking");

    if(self._id_230F == "allies") {
      maps\mp\_utility::_id_863F(self, "waypoint_esports_taking_blue", 1);
    } else {
      maps\mp\_utility::_id_863F(self, "waypoint_esports_taking_red", 2);
    }
  }
}

_id_AC8C() {
  _id_04D1::_id_86EC("neutral");
  _id_04D1::_id_0C30("any");
  self._id_A6E5 = undefined;
  _setomnvar("ui_twar_capture_team", 0);
  _id_A0AA(0, 0);
}

_id_AC82() {
  _id_AC83();
  var_0 = level._id_9FC0._id_A582[0];
  self._id_3CB9 = _spawnlinkedfx(level._id_3CBA, var_0, "tag_fx_flag");
  setfxkillondelete(self._id_3CB9, 1);
  _triggerfx(self._id_3CB9);
}

_id_AC83() {
  if(isDefined(self._id_3CB9)) {
    self._id_3CB9 delete();
  }
}

_id_AC7D() {
  _id_AC7E();
  var_0 = level._id_9FC0._id_A582[0];
  self._id_188B = _spawnfx(level._id_188C, var_0.origin, anglestoup(var_0.angles));
  setfxkillondelete(self._id_188B, 1);
  _triggerfx(self._id_188B);
}

_id_AC7E() {
  if(isDefined(self._id_188B)) {
    self._id_188B delete();
  }
}

_id_AC8D(var_0) {
  _id_04D1::_id_86EC(var_0);
  _id_04D1::_id_0C30("any");
}

_id_A0A5() {
  for(;;) {
    level waittill("update_flag_outline");
    var_0 = getdvarint("scr_twar_flag_outline_color_friendly", -1);
    var_1 = getdvarint("scr_twar_flag_outline_color_enemy", -1);
    var_2 = getdvarint("scr_twar_flag_outline_color_neutral", -1);
    var_3 = getdvarint("scr_twar_flag_outline_depth", 0);
    self hudoutlinedisableforclients(level.players);
    var_4 = level._id_9FC0 _id_04D1::_id_445B();
    var_5 = [];
    var_6 = [];
    var_7 = [];

    foreach(var_9 in level.players) {
      if((var_4 == "allies" || var_4 == "axis") && (var_9.team == "allies" || var_9.team == "axis")) {
        if(var_4 == var_9.team) {
          var_5[var_5.size] = var_9;
        } else {
          var_6[var_6.size] = var_9;
        }

        continue;
      }

      var_7[var_7.size] = var_9;
    }

    if(var_5.size && var_0 >= 0) {
      self hudoutlineenableforclients(var_5, var_0, var_3);
    }

    if(var_6.size && var_1 >= 0) {
      self hudoutlineenableforclients(var_6, var_1, var_3);
    }

    if(var_7.size && var_2 >= 0) {
      self hudoutlineenableforclients(var_7, var_2, var_3);
    }
  }
}

_id_7D4C() {
  var_0 = int(level._id_9FC2.size / 2);

  foreach(var_3, var_2 in level._id_9FC2) {
    if(var_3 < var_0) {
      var_2._id_0117 = "allies";
      continue;
    }

    if(var_3 > var_0) {
      var_2._id_0117 = "axis";
      continue;
    }

    var_2._id_0117 = "none";
  }

  _id_843F(level._id_9FC2[var_0]);
}

_id_6ABC(var_0) {
  var_1 = var_0.team;
  var_2 = maps\mp\_utility::getotherteam(var_1);
  _id_AC8D(var_1);
  maps\mp\_utility::leaderdialog("mtm_taking", var_1);
  maps\mp\_utility::leaderdialog("mtm_etaking", var_2);
  level notify("update_flag_outline");
}

_id_6BBF(var_0) {
  var_1 = var_0.team;
  var_2 = maps\mp\_utility::getotherteam(var_1);
  var_3 = self._id_AC7C;
  var_3._id_0117 = var_1;
  var_4 = var_3._id_00D4;

  if(var_1 == "allies") {
    var_4++;
  } else if(var_1 == "axis") {
    var_4--;
  }

  game["shut_out"][var_2] = 0;

  if(getdvarint("scr_twar_momentum_clear_friendly_on_capture", 0)) {
    _id_23C3(var_1);
  } else {
    _id_0909(var_1);
  }

  if(getdvarint("scr_twar_momentum_clear_enemy_on_capture", 0)) {
    _id_23C3(var_2);
  } else {
    _id_0908(var_2);
  }

  var_0 thread _id_046C::_id_8DAE("mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
  thread _id_47C9(self._id_9AC3[var_1]);

  if(var_4 < 0 || var_4 >= level._id_6878) {
    _id_AC83();
    _id_AC7E();
    level _id_04D2::_id_47BD(var_1, 1, 1);
    maps\mp\_utility::leaderdialog("mtm_secured", var_1);

    if(level.gameended) {
      _id_04D1::_id_2F93();
    } else {
      _id_7D4C();
    }
  } else {
    _id_843F(level._id_9FC2[var_4]);

    if(var_4 == 0 || var_4 == level._id_6878 - 1) {
      _id_5C48("mtm_lastflg", var_2);
      _id_5C48("mtm_elastflg", var_1);
    } else
      _id_5C48("mtm_secured", var_1);
  }

  self._id_66D5 = gettime() + 50;
}

_id_5C48(var_0, var_1) {
  thread _id_0671(var_0, var_1);
}

_id_0671(var_0, var_1) {
  waitframe();
  maps\mp\_utility::leaderdialog(var_0, var_1);
}

_id_47C9(var_0) {
  level endon("game_ended");
  var_1 = _id_04D1::_id_44AF();

  if(isDefined(var_1._id_0117)) {
    var_1 = var_1._id_0117;
  }

  if(isPlayer(var_1)) {
    level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition", var_1);
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
    var_1 thread _id_047A::_id_320C(0);
    waitframe();
  }
}

_id_6AFA(var_0, var_1, var_2) {
  _id_AC8C();
  level notify("update_flag_outline");
}

_id_6BBE() {
  var_0 = self._id_A22B;
  var_1 = 0;
  var_2 = 0;
  var_3 = maps\mp\_utility::getotherteam(self._id_230F);

  foreach(var_5 in self._id_9AC3[var_3]) {
    var_6 = var_5.player;

    if(!isDefined(var_6)) {
      continue;
    }
    if(var_6.pers["team"] != var_3) {
      continue;
    }
    var_2++;
  }

  var_8 = getdvarint("scr_twar_capture_players_max", 3);

  foreach(var_5 in self._id_9AC3[self._id_230F]) {
    var_6 = var_5.player;

    if(!isDefined(var_6)) {
      continue;
    }
    if(var_6.pers["team"] != self._id_230F) {
      continue;
    }
    var_1++;

    if(var_1 >= var_8) {
      break;
    }
  }

  self._id_A22B = 0;
  self._id_915C = var_1 && var_2;
  var_11 = getdvarint("scr_twar_min_capture_players", 1);

  if(var_1 && !var_2 && var_1 >= var_11) {
    var_12 = level._id_9FBF[self._id_230F];
    self._id_A22B = var_1 * var_12;
  }

  var_13 = getdvarint("scr_twar_capture_rate_max", 9.0);
  self._id_A22B = _min(self._id_A22B, var_13);

  if(self._id_59DD && self._id_5B82 != self._id_230F) {
    self._id_A22B = self._id_A22B * -1;
  }

  _id_A0AA(var_1, var_2);
}

_id_843F(var_0) {
  var_0._id_0117 = "none";
  level._id_9FC0._id_AC7C = var_0;
  level._id_9FC0 _id_04D1::_id_6497(var_0.origin, (0, 0, 100));

  foreach(var_2 in level._id_9FC2) {
    if(var_2 != var_0) {
      var_2._id_776E show();
      continue;
    }

    var_2._id_776E hide();
  }

  if(level._id_9FC0._id_59DD) {
    level._id_9FC0._id_5B82 = "none";
  }

  level thread _id_8440(5);
  _id_10D9();
}

_id_8440(var_0) {
  waittillframeend;
  level._id_9FC0 _id_AC83();
  level._id_9FC0 _id_AC7D();
  level._id_9FC0 _id_AC8E();
  wait(var_0);
  level._id_9FC0 _id_AC82();
  level._id_9FC0 _id_AC8C();
}

_id_A0AE() {
  for(;;) {
    waittillframeend;
    var_0 = 0;

    foreach(var_2 in level._id_9FC2) {
      if(var_2._id_0117 == "allies") {
        var_0++;
      }
    }

    _setomnvar("ui_twar_ally_flag_count", var_0);
    var_4 = 0;
    var_5 = "";

    if(level._id_9FC0._id_59DD) {
      var_5 = level._id_9FC0._id_5B82;
    } else {
      var_5 = level._id_9FC0._id_230F;
    }

    if(var_5 == "axis") {
      var_4 = 1;
    } else if(var_5 == "allies") {
      var_4 = 2;
    }

    var_6 = getdvarint("scr_twar_hud_momentum_bar", 1);
    _setomnvar("ui_twar_momentum_bar_visible", var_6);

    if(_getomnvar("ui_twar_capture_team") != 3) {
      _setomnvar("ui_twar_capture_team", var_4);
    }

    var_7 = 0.0;

    if(var_5 != "none") {
      var_7 = level._id_9FC0._id_28D5 / level._id_9FC0._id_A23F;
    }

    _setomnvar("ui_twar_capture_progress", var_7);

    foreach(var_4 in level._id_985B) {
      var_9 = 0;

      if(level._id_9FC0._id_5412 == "any") {
        var_9 = level._id_9FC0._id_689F[var_4];
      }

      _setomnvar("ui_twar_touching_" + var_4, var_9);
    }

    waitframe();
  }
}

_id_55B5(var_0) {
  return level._id_9FBF[var_0] == level._id_62C4;
}

detonatebydoubletap(var_0, var_1) {
  thread _id_23C1(var_0, var_1);
  isgod(var_0, 0.0);
  _setomnvar("ui_twar_momentum_maxed_time", var_1);
  _setomnvar("ui_twar_momentum_end_time_" + var_0, gettime() + int(1000 * var_1));
}

_id_23C1(var_0, var_1) {
  level endon("clear_max_momentum_" + var_0);
  wait(var_1);
  thread _id_23C2(var_0);
}

_id_23C2(var_0) {
  level notify("clear_max_momentum_" + var_0);

  if(!_id_55B5(var_0)) {
    return;
  }
  isgod(var_0, 0.0);
  setagentcostumeindex(var_0, level._id_62C4 - 1);
  _setomnvar("ui_twar_momentum_end_time_" + var_0, 0);
}

_id_23C3(var_0) {
  if(level._id_9FBF[var_0] == 1) {
    maps\mp\_utility::leaderdialog("mtm_clrd", var_0, "momentum_down");
  } else {
    maps\mp\_utility::leaderdialog("mtm_reset", var_0, "momentum_down");
  }

  _id_23C2(var_0);
  var_1 = level._id_9FBE[var_0] + level._id_9FBF[var_0] - 1;
  _id_0941(var_0, -1 * var_1);
}

_id_0941(var_0, var_1, var_2) {
  if(var_1 == 0) {
    return;
  }
  if(level._id_62C4 <= 1) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!var_2 && _id_55B5(var_0)) {
    return;
  }
  var_3 = level._id_9FBE[var_0];
  var_4 = level._id_9FBF[var_0];
  var_5 = 0;

  for(var_3 = var_3 + var_1; var_3 <= 0.0 && var_4 > 1; var_5 = 1) {
    var_3 = var_3 + 1.0;
    var_4--;
  }

  if(!var_5) {
    while(var_3 >= 1.0 && var_4 < level._id_62C4) {
      var_3 = var_3 - 1.0;
      var_4++;
      var_5 = 1;
    }
  }

  isgod(var_0, var_3);

  if(var_5) {
    setagentcostumeindex(var_0, var_4);
  }

  if(_id_55B5(var_0)) {
    var_6 = getdvarfloat("scr_twar_maxed_time", 20.0);
    detonatebydoubletap(var_0, var_6);
  } else
    _setomnvar("ui_twar_momentum_" + var_0, level._id_9FBE[var_0]);
}

isgod(var_0, var_1) {
  var_1 = clamp(var_1, 0.0, 1.0);
  level._id_9FBE[var_0] = var_1;
  _setomnvar("ui_twar_momentum_" + var_0, level._id_9FBE[var_0]);
}

setagentcostumeindex(var_0, var_1) {
  var_2 = level._id_9FBF[var_0];
  level._id_9FBF[var_0] = var_1;

  if(var_2 != var_1) {
    _setomnvar("ui_twar_momentum_scale_" + var_0, var_1);
    level._id_9FC0 _id_04D1::_id_A18F();

    if(var_2 > var_1) {
      if(var_2 != level._id_62C4) {
        maps\mp\_utility::leaderdialog("mtm_lost", var_0, "momentum_down");
      }
    } else if(_id_55B5(var_0)) {
      maps\mp\_utility::leaderdialog("mtm_max", var_0);

      if(!game["max_meter"][var_0]) {
        game["max_meter"][var_0] = 1;

        foreach(var_4 in level.players) {
          if(var_4.team != var_0) {
            continue;
          }
          var_4 maps\mp\gametypes\_missions::processchallenge("ch_twar_blitzkrieg");
        }
      }
    } else
      maps\mp\_utility::leaderdialog("mtm_gain", var_0);
  }
}

_id_093D(var_0) {
  var_1 = getdvarfloat("scr_twar_momentum_kill_enemy", 0.1);
  _id_0941(var_0, var_1);
}

_id_093F(var_0) {
  var_1 = getdvarfloat("scr_twar_momentum_kill_friendly", -0.1);
  _id_0941(var_0, var_1);
}

_id_0909(var_0) {
  var_1 = getdvarfloat("scr_twar_momentum_capture_friendly", 0.2);
  _id_0941(var_0, var_1);
}

_id_0908(var_0) {
  var_1 = getdvarfloat("scr_twar_momentum_capture_enemy", -0.2);
  _id_0941(var_0, var_1);
}

_id_520A(var_0) {
  level._id_9FBF[var_0] = 1;
  level._id_9FBE[var_0] = 0;
  _setomnvar("ui_twar_momentum_end_time_" + var_0, 0);
  _setomnvar("ui_twar_momentum_" + var_0, level._id_9FBE[var_0]);
  _setomnvar("ui_twar_momentum_scale_" + var_0, level._id_9FBF[var_0]);

  if(level._id_62C4 <= 1) {
    return;
  }
  level thread _id_522D(var_0);
}

_id_522D(var_0) {
  maps\mp\_utility::gameflagwait("prematch_done");

  if(game["status"] == "overtime") {
    var_1 = 0;
    var_2 = game["owned_flags"][var_0];

    if(var_2 == 4) {
      var_1 = 2.0;
    } else if(var_2 == 3) {
      var_1 = 1.0;
    }

    _id_0941(var_0, var_1);
  }
}

_id_4484() {
  return level._id_9FC0._id_AC7C;
}

_id_6B5C(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    _id_093D(var_1.team);
  }

  if(isDefined(var_0.team)) {
    _id_093F(var_0.team);
  }
}

_id_434B(var_0) {
  var_1 = [];
  var_2 = ["allies", "axis"];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_3[var_5] = _id_050D::_id_46A0(var_5);
  }

  foreach(var_5 in var_2) {
    var_8 = (0, 0, 0);

    foreach(var_10 in var_3[var_5]) {
      var_8 = var_8 + var_10.origin;
    }

    var_8 = var_8 / var_3[var_5].size;
    var_1[var_5] = var_8;
  }

  if(var_0) {
    var_13 = _getallnodes();

    foreach(var_5, var_8 in var_1) {
      var_15 = 0;

      for(var_16 = 0; var_16 < 10 && var_16 < var_13.size; var_16++) {
        var_17 = _getpathdist(var_8, var_13[var_16].origin, 99999, 1);

        if(var_17 > 0) {
          var_15 = 1;
          break;
        }
      }

      if(!var_15) {
        var_1[var_5] = var_3[var_5][0].origin;
      }
    }
  }

  return var_1;
}

_id_3B87() {
  if(!isDefined(game["zone_origins"]) || game["status"] == "overtime") {
    game["zone_origins"] = _id_43F5();
  }

  var_0 = 5;
  level._id_6878 = getdvarint("scr_twar_zone_count", var_0);

  if(level._id_6878 <= 0) {
    level._id_6878 = var_0;
  }

  if(game["status"] == "overtime") {
    level._id_6878 = getdvarint("scr_twar_ot_zone_count", 3);
  }

  if(game["zone_origins"].size > level._id_6878) {
    var_1 = int((game["zone_origins"].size - level._id_6878) / 2);
    var_2 = [];

    for(var_3 = var_1; var_3 <= game["zone_origins"].size - 1 - var_1; var_3++) {
      var_2[var_2.size] = game["zone_origins"][var_3];
    }

    game["zone_origins"] = var_2;
  }

  _setomnvar("ui_twar_flag_count", level._id_6878);
  level._id_9FC2 = [];

  foreach(var_3, var_5 in game["zone_origins"]) {
    var_6 = _id_9FC1(var_3, var_5.origin, var_5.angles, _id_24E8(var_3));
    level._id_9FC2[var_3] = var_6;
  }
}

_id_43F5() {
  var_0 = [];
  var_1 = common_scripts\utility::_id_46B7("twar_zone", "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.setmovespeedscale)) {
      return var_0;
    }
  }

  if(var_1.size < 3 || var_1.size > 7) {
    return var_0;
  }

  var_1 = common_scripts\utility::_id_7897(var_1, ::_id_789A);

  foreach(var_3 in var_1) {
    var_6 = _id_9FC3(var_3);
    var_7 = spawnStruct();
    var_7.origin = var_3.origin;

    if(isDefined(var_6)) {
      var_7.angles = var_6;
    } else {
      var_7.angles = var_3.setflaggedanimknobrestart;
    }

    var_0[var_0.size] = var_7;
  }

  level._id_6878 = var_0.size;
  return var_0;
}

_id_9FC3(var_0) {
  var_1 = maps\mp\_utility::_id_4571();
  var_2 = undefined;
  var_3 = var_0.setmovespeedscale;

  switch (var_1) {
    case "mp_detroit":
      if(var_3 == 5) {
        var_2 = (0, 215, 0);
      }

      if(var_3 == 1) {
        var_2 = (0, 245, 0);
      }

      break;
    case "mp_instinct":
      if(var_3 == 1) {
        var_2 = (0, 190, 0);
      }

      if(var_3 == 2) {
        var_2 = (0, 285, 0);
      }

      if(var_3 == 4) {
        var_2 = (0, 340, 0);
      }

      if(var_3 == 5) {
        var_2 = (0, 350, 0);
      }

      break;
    default:
      break;
  }

  return var_2;
}

_id_789A(var_0, var_1) {
  return var_0.setmovespeedscale <= var_1.setmovespeedscale;
}

_id_43F6() {
  level._id_6878 = getdvarint("scr_twar_zone_count", 5);
  var_0 = _id_434B(1);
  var_1 = ["allies", "axis"];
  var_2 = _getallnodes();
  var_3 = level._id_6878;
  var_4 = getdvarfloat("scr_twar_auto_zone_spacing", 0.15);
  var_5 = getdvarfloat("scr_twar_auto_zone_zig_zag", 0.1);
  var_6 = getdvarint("scr_twar_auto_zone_allow_traversals", 0);
  var_7 = getdvarint("scr_twar_auto_zone_sky_only", 1);
  var_8 = [];

  for(var_9 = 0; var_9 < level._id_6878; var_9++) {
    var_10 = (var_9 + 1) / (level._id_6878 + 1 - (var_9 + 1));
    var_11 = (2 * (var_9 + 1) - 1) / (2 * (level._id_6878 + 1 - (var_9 + 1)) + 1);
    var_12 = (2 * (var_9 + 1) + 1) / (2 * (level._id_6878 + 1 - (var_9 + 1)) - 1);
    var_8[var_9]["min"] = var_10 - var_4 * (var_10 - var_11);
    var_8[var_9]["max"] = var_10 + var_4 * (var_12 - var_10);
  }

  var_13 = [];

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_13[var_9] = [];
  }

  foreach(var_15 in var_2) {
    if(var_7 && !_nodeexposedtosky(var_15, 1)) {
      continue;
    }
    var_16 = [];

    foreach(var_18 in var_1) {
      var_16[var_18] = _getpathdist(var_0[var_18], var_15.origin, 99999, var_6);
    }

    if(var_16["allies"] <= 0 || var_16["axis"] <= 0) {
      continue;
    }
    var_20 = var_16["allies"] / var_16["axis"];

    for(var_9 = 0; var_9 < var_8.size; var_9++) {
      if(var_20 > var_8[var_9]["min"] && var_20 < var_8[var_9]["max"]) {
        var_13[var_9][var_13[var_9].size] = var_15;
      }
    }
  }

  var_22 = [];
  var_23 = var_0["allies"];

  foreach(var_9, var_25 in var_13) {
    var_25 = _sortbydistance(var_25, var_23);
    var_26 = int(clamp(2 * var_25.size * var_5 - var_25.size, 0, var_25.size));
    var_27 = int(clamp(2 * var_25.size * var_5, 0, var_25.size));

    if(var_26 < var_27) {
      var_28 = _randomintrange(var_26, var_27);
    } else {
      var_28 = int(clamp(var_26, 0, var_25.size - 1));
    }

    var_29 = spawnStruct();
    var_29.origin = var_25[var_28].origin;
    var_22[var_9] = var_29;
    var_23 = var_25[var_28].origin;
  }

  return var_22;
}

_id_24E8(var_0) {
  return (var_0 & 4, var_0 & 2, var_0 & 1);
}

_id_9FC1(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_5 = var_1 + (0, 0, 32);
  var_6 = var_1 + (0, 0, -64);
  var_7 = bulletTrace(var_5, var_6, 0, undefined);
  var_4.origin = var_7["position"];
  var_4._id_0117 = "none";
  var_4._id_00D4 = var_0;
  var_4.angles = var_2;
  var_4._id_2AC6 = var_3;
  var_4._id_776E = _id_8FA8(var_4.origin);
  return var_4;
}

_id_33C8(var_0, var_1, var_2) {
  level endon(var_2);
  var_3 = anglesToForward(var_0.angles);
  level thread maps\mp\_utility::_id_33C0(var_0.origin, var_0.origin + var_3 * 50, var_1, var_2);
  var_0._id_2AD0 = 1;

  for(;;) {
    waitframe();
  }
}

_id_43F3(var_0) {
  if(isDefined(var_0.angles)) {
    return anglesToForward(var_0.angles);
  } else {
    var_1 = _id_434B(0);
    var_2 = var_1["axis"] - var_1["allies"];
    var_2 = (var_2[0], var_2[1], 0);
    return vectorNormalize(var_2);
  }
}

_id_10D9() {
  var_0 = _id_050D::_id_448A();

  foreach(var_2 in var_0) {
    var_2._id_9849 = undefined;
  }

  var_4 = _id_4484();
  var_4._id_2F0C = _id_43F3(var_4);
  var_5 = 9;
  var_6 = _id_459F(var_4, 24, level._id_AC8B * 3, 0.0);

  foreach(var_2 in var_6) {
    var_8 = vectorNormalize(var_4.origin - var_2.origin);
    var_2._id_32B1 = vectordot(var_8, var_4._id_2F0C);
  }

  var_6 = common_scripts\utility::_id_7897(var_6, ::_id_9FBD);
  var_10["allies"] = 0;
  var_10["axis"] = 0;

  for(var_11 = 0; var_11 < var_6.size; var_11++) {
    var_12 = int(var_11 / 2);
    var_13 = "axis";

    if(var_11 % 2 == 1) {
      var_12 = var_6.size - int((var_11 + 1) / 2);
      var_13 = "allies";
    }

    var_14 = undefined;
    var_2 = var_6[var_12];

    if(var_10[var_13] < var_5) {
      var_14 = var_13;
    } else if(var_2._id_32B1 > 0) {
      var_14 = "allies";
    } else {
      var_14 = "axis";
    }

    if(isDefined(var_14)) {
      var_2._id_9849 = var_14;
      var_2._id_984B = var_10[var_14];
      var_10[var_14]++;
    }
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_9849)) {
      var_2._id_984A = var_10[var_2._id_9849];
    }
  }
}

_id_9FBB(var_0, var_1) {
  var_2 = _id_050D::_id_5770();
  var_3 = -1;

  if(var_2) {
    var_3 = _getpathdist(var_0, var_1, 999999);
  }

  if(var_3 == -1) {
    var_3 = distance(var_0, var_1);
  }

  return var_3;
}

_id_459F(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = _id_050D::_id_5770();
  var_5 = _id_050D::_id_44F9();

  foreach(var_7 in var_5) {
    var_7._id_3018 = -1;

    if(var_4) {
      var_7._id_3018 = _getpathdist(var_7.origin, var_0.origin, 999999);
    }

    if(var_7._id_3018 == -1) {
      var_7._id_3018 = distance(var_0.origin, var_7.origin);
    }
  }

  var_5 = common_scripts\utility::_id_7897(var_5, ::_id_9FBC);
  var_9 = maps\mp\_utility::_id_4571();
  var_10 = game["status"] == "overtime";
  var_11 = var_0._id_00D4;

  if(var_10) {
    var_11 = var_11 + 1;
  }

  var_12 = [];

  for(var_13 = 0; var_13 < var_5.size && var_12.size < var_1; var_13++) {
    var_7 = var_5[var_13];

    if(var_7._id_3018 < var_2) {
      continue;
    }
    switch (var_9) {
      case "mp_instinct":
        if(var_11 == 0) {
          if(var_7._id_00D4 == 1) {
            continue;
          }
        } else if(var_11 == 1) {
          if(var_7._id_00D4 == 14) {
            continue;
          }
        } else if(var_11 == 3) {
          if(var_7._id_00D4 == 16) {
            continue;
          }
        } else if(var_11 == 4) {
          if(var_7._id_00D4 == 16) {
            continue;
          }
        }

        break;
    }

    var_12[var_12.size] = var_7;
  }

  return var_12;
}

_id_9FBD(var_0, var_1) {
  return var_0._id_32B1 <= var_1._id_32B1;
}

_id_9FBC(var_0, var_1) {
  return var_0._id_3018 <= var_1._id_3018;
}

_id_45A1(var_0) {
  var_1 = _id_050D::_id_5770();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_9FC2) {
    var_6 = undefined;

    if(var_1) {
      var_6 = _getpathdist(var_0.origin, var_5.origin, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distance(var_5.origin, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2;
}

_id_6BA7() {
  self._id_6219 = 0;
}

_id_A139() {
  level endon("game_ended");

  while(!isDefined(level._id_0A4E)) {
    waitframe();
  }

  maps\mp\_utility::gameflagwait("prematch_done");
  var_0 = getdvarint("scr_twar_minionsmax", 18);

  if(var_0 <= 0) {
    return;
  }
  _id_A0B1();
  var_1 = ["allies", "axis"];
  var_2 = getdvarfloat("scr_twar_minionspawndelay", 10.0);
  var_3 = [];
  var_4 = undefined;
  var_5 = undefined;
  var_6 = getdvarint("scr_twar_minionspawnhud", 0);

  if(var_6 > 0) {
    var_4 = _id_6218();
    var_4 _id_4F67();

    if(var_6 > 1) {
      var_5 = _id_6217();

      foreach(var_8 in var_1) {
        foreach(var_10 in var_1) {
          var_3[var_8][var_10] = _id_6215(var_8, var_10);
        }
      }
    }
  }

  while(!level.gameended) {
    if(isDefined(var_4)) {
      var_4 settimer(var_2);
    }

    wait(var_2);
    maps\mp\gametypes\_hostmigration::_id_A782();
    var_13 = _id_4588();
    var_14 = level._id_6878 - 1;

    if(var_13 + var_14 < var_0) {
      var_15 = [];

      foreach(var_17 in var_1) {
        var_15[var_17] = 0;
      }

      foreach(var_20 in level._id_9FC2) {
        var_17 = var_20._id_0117;

        if(var_17 != "allies" && var_17 != "axis") {
          continue;
        }
        var_21 = undefined;
        var_22 = undefined;
        var_23 = [[level._id_0A4D]]("player", var_17, "minion", var_21, var_22, undefined, 0, 0, "recruit");

        if(isDefined(var_23)) {
          var_23 takeallweapons();
          var_24 = getdvarint("scr_twar_minionweapon", 0);
          var_25 = "";

          switch (var_24) {
            case 2:
              var_25 = "thompson_mp";
              break;
            case 1:
              var_25 = "m1garand_mp";
              break;
            case 0:
            default:
              var_25 = "m1919_mp";
              break;
          }

          var_23 maps\mp\_utility::_giveweapon(var_25);
          var_23 switchtoweaponimmediate(var_25);
          var_23 maps\mp\_utility::giveperk("specialty_minion");
          var_23.agentspeedscale = getdvarfloat("scr_twar_minionmovespeedscale", 0.85);
          var_23._id_29AA = getdvarfloat("scr_twar_miniondamagescale", 0.5);
          var_23._id_0009 = &"MP_MINION";
          var_23._id_672C = 1;
          var_23 thread _id_6214();
          _id_A0B1();
          var_23 detachall();
          var_23 setModel("kva_hazmat_body_infected_mp");
          var_23 attach("kva_hazmat_head_infected");
          var_23 setclothtype("cloth");
          var_26 = getdvarfloat("scr_twar_minionhealthscale", 0.75);
          var_23 maps\mp\agents\_agent_common::_id_83FD(int(var_23.health * var_26));
          var_15[var_17]++;
        }
      }

      foreach(var_8, var_29 in var_3) {
        foreach(var_10, var_31 in var_29) {
          var_31 _id_4F67();
          var_31 setvalue(var_15[var_10]);
          var_31 maps\mp\_utility::_id_2CED(3.0, ::_id_4F66);
        }
      }

      continue;
    }

    if(isDefined(var_5)) {
      var_5 _id_4F67();
      var_5 maps\mp\_utility::_id_2CED(3.0, ::_id_4F66);
    }
  }
}

_id_55B9() {
  return self hasperk("specialty_minion", 1);
}

_id_4F67() {
  self.alpha = 1.0;
}

_id_4F66() {
  self.alpha = 0.0;
}

_id_6217() {
  var_0 = maps\mp\gametypes\_hud_util::_id_2829("hudbig", 1.0);
  var_0 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, -20);
  var_0.label = &"MP_DOMAI_MINIONS_SPAWNED_MAX";
  var_0.color = (1, 0, 0);
  var_0.archived = 1;
  var_0._id_0180 = 1;
  var_0.alpha = 0.0;
  return var_0;
}

_id_6215(var_0, var_1) {
  var_2 = maps\mp\gametypes\_hud_util::_id_2829("hudbig", 1.0, var_0);
  var_2 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, common_scripts\utility::_id_98E7(var_0 == var_1, -40, -20));
  var_2.label = common_scripts\utility::_id_98E7(var_0 == var_1, &"MP_DOMAI_MINIONS_SPAWNED_FRIENDLY", &"MP_DOMAI_MINIONS_SPAWNED_ENEMY");
  var_2.color = common_scripts\utility::_id_98E7(var_0 == var_1, (0.157, 0.392, 0.784), (0.784, 0.49, 0.157));
  var_2.archived = 1;
  var_2._id_0180 = 1;
  var_2.alpha = 0.0;
  return var_2;
}

_id_6218() {
  var_0 = maps\mp\gametypes\_hud_util::_id_282B("hudbig", 1.0);
  var_0 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, -60);
  var_0.label = &"MP_DOMAI_MINIONS_SPAWN_TIMER";
  var_0.color = (1, 1, 1);
  var_0.archived = 1;
  var_0._id_0180 = 1;
  return var_0;
}

_id_A0B1() {
  var_0 = [];
  var_1 = [];
  var_2 = getdvarint("scr_twar_minionoutline", 0);

  foreach(var_4 in level.players) {
    if(var_4.team == "allies") {
      var_0[var_0.size] = var_4;
      continue;
    }

    var_1[var_1.size] = var_4;
  }

  foreach(var_7 in level._id_0A4E) {
    if(var_7 _id_55B9()) {
      if(level.players.size > 0) {
        var_7 hudoutlinedisableforclients(level.players);
      }

      if(var_2) {
        if(var_0.size > 0) {
          var_7 hudoutlineenableforclients(var_0, common_scripts\utility::_id_98E7(var_7.team == "allies", 2, 3), 1);
        }

        if(var_1.size > 0) {
          var_7 hudoutlineenableforclients(var_1, common_scripts\utility::_id_98E7(var_7.team == "axis", 2, 3), 1);
        }
      }
    }
  }
}

_id_6214() {
  self endon("death");

  for(;;) {
    if(isDefined(level._id_9FC0)) {
      var_0 = level._id_9FC0._id_9D65.origin;
      self botsetscriptgoal(var_0, level._id_AC8B * 0.9, "objective");
    }

    wait 0.1;
  }
}

_id_4588() {
  var_0 = 0;

  foreach(var_2 in level._id_0A4E) {
    if(isDefined(var_2._id_565F) && var_2._id_565F && var_2._id_0A4B == "player" && var_2 _id_55B9()) {
      var_0++;
    }
  }

  return var_0;
}

_id_6216(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_2) && isDefined(var_2._id_29AA)) {
    var_3 = int(var_3 * var_2._id_29AA);
  }

  return var_3;
}

_id_6AA5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isPlayer(var_1) && _id_55B9() && var_1.team != self.team) {
    var_9 = getdvarfloat("scr_twar_score_kill_minion_multipler", 0);

    if(var_9 > 0) {
      var_10 = getdvarfloat("scr_twar_score_kill_minion_base", 10);
      var_11 = int(var_1._id_6219 * var_9 + var_10);
      var_11 = _min(var_11, getdvarint("scr_twar_score_kill_minion_max", 150));
      setDvar("scr_twar_score_kill_minion", var_11);
    }

    var_1._id_6219++;
    level thread maps\mp\gametypes\_rank::_id_1457("kill_minion", var_1, var_4, self, var_3);

    if(isDefined(var_1)) {
      _id_093C(var_1.team);
    }

    if(isDefined(self.team)) {
      _id_093E(self.team);
    }
  }
}

_id_093C(var_0) {
  var_1 = getdvarfloat("scr_twar_momentum_kill_enemy_minion", 0.1);
  _id_0941(var_0, var_1);
}

_id_093E(var_0) {
  var_1 = getdvarfloat("scr_twar_momentum_kill_friendly_minion", -0.1);
  _id_0941(var_0, var_1);
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
    if(var_13 != level._id_9FC0._id_9D65) {
      continue;
    }
    var_1 thread _id_047A::_id_5A82(var_11, var_9, var_4);
    var_10 = 1;
    break;
  }

  if(!var_10) {
    foreach(var_13 in var_11._id_9AC5) {
      if(var_13 != level._id_9FC0._id_9D65) {
        continue;
      }
      var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);
      var_1 thread _id_047A::_id_10BA(self, var_9, var_4);
    }
  }
}