/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\hp.gsc
********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  setdvarifuninitialized("spv_enableHPBroadcasterMesh", 1);
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 30);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 300);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level._id_7A62 = maps\mp\_utility::getintproperty("scr_hp_radom_selection", 0);
  level._id_4F04 = 0;
  level._id_ACA0 = 60;
  level._id_530D = maps\mp\_utility::getintproperty("scr_hp_zone_delay", 0);
  level._id_73C0 = 6;
  level._id_80AD = 0;
  level._id_6BAF = ::_id_6BAF;
  level._id_6B7B = ::_id_6B7B;
  level._id_6B86 = ::_id_6B86;
  level._effect["hp_neutral"] = loadfx("vfx/unique/hardpoint_chevron_neutral");
  level._effect["hp_neutral_vertical"] = loadfx("vfx/unique/hardpoint_chevron_neutral_vertical");
  level._effect["hp_friendly"] = loadfx("vfx/unique/hardpoint_chevron_friendly");
  level._effect["hp_friendly_vertical"] = loadfx("vfx/unique/hardpoint_chevron_friendly_vertical");
  level._effect["hp_enemy"] = loadfx("vfx/unique/hardpoint_chevron_enemy");
  level._effect["hp_enemy_vertical"] = loadfx("vfx/unique/hardpoint_chevron_enemy_vertical");
  level._effect["hp_contested"] = loadfx("vfx/unique/hardpoint_chevron_contested");
  level._effect["hp_contested_vertical"] = loadfx("vfx/unique/hardpoint_chevron_contested_vertical");
  game["dialog"]["gametype"] = "hpt_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["objective_active"] = "mp_hp_new_hardpoint_active";
  game["objective_gained_sound"] = "mp_obj_notify_pos_sml";
  game["objective_lost_sound"] = "mp_obj_notify_neg_sml";
  game["objective_contested_sound"] = "mp_obj_notify_neg_sml";
  level._id_5B91 = 0;
  level._id_ACB9 = [];
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
  maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  _setdynamicdvar("scr_hp_radom_selection", _getmatchrulesdata("hpData", "randomZones"));
  _setdynamicdvar("scr_hp_zone_delay", _getmatchrulesdata("hpData", "initDelay"));
}

_id_6B86() {
  level._id_6947 = &"MP_CONTROL_KOTH";
  level._id_6945 = &"MP_CAPTURE_KOTH";
  level._id_6946 = &"MP_DEFEND_KOTH";
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level._id_5023 = "waypoint_caster_hardpoint";
  level._id_5009 = "waypoint_caster_contested";
  level._id_ACB8 = &"MP_KOTH_AVAILABLE_IN";
  level._id_AC9F = &"MP_KOTH_MOVING_IN";
}

_id_A141(var_0, var_1) {
  game["strings"]["objective_hint_allies"] = var_0;
  game["strings"]["objective_hint_axis"] = var_1;
}

_id_A140(var_0) {
  _id_A141(var_0, var_0);
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

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_KOTH");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_KOTH");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH_SCORE");
  }

  if(level._id_530D) {
    _id_A140(level._id_6947);
  } else {
    _id_A140(level._id_6945);
  }

  _setclientnamemode("auto_change");
  _id_050D::_id_10E4();
  var_2[0] = "hp";
  var_2[1] = "blocker_hp";
  _id_04D1::main(var_2);
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  _setomnvar("ui_broadcaster_game_mode_status_2", 0);
  level thread onplayerconnect();
  level thread _id_8A55();
  level thread _id_4B1C();
  level thread _id_5E9C();
  var_3 = getEntArray("hp_broadcaster_placeholder", "targetname");

  foreach(var_5 in var_3) {
    var_5 hide();
  }

  if(_func_37E() && maps\mp\_utility::inovertime() && !isDefined(level._id_501A)) {
    _id_6B86();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_3FCC = 0;
    var_0._id_0112 = 0;
    var_0._id_9AC5 = [];
    var_0 thread _id_A91F();
    var_0._id_4B1D = [];
    var_0.touchinghardpoint = 0;
  }
}

_id_A91F() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    _id_8A6F();
  }
}

_id_4F05() {
  level._id_AC7C._id_3FCA _id_04D1::_id_A190();
  _setomnvar("ui_broadcaster_game_mode_status_1", level._id_AC7C._id_3FCA._id_689F["allies"]);
  _setomnvar("ui_broadcaster_game_mode_status_2", level._id_AC7C._id_3FCA._id_689F["axis"]);
}

_id_8FDD() {
  _id_5A87();

  if(isDefined(level._id_AC7C.broadcastermesh)) {
    level._id_AC7C.broadcastermesh hide();
  }

  if(level._id_7A62) {
    level._id_AC7C = _id_45B0();
  } else {
    level._id_AC7C = _id_45AF();
  }

  _id_8A70();
  _id_86D4();
  maps\mp\gametypes\_gamelogic::_id_7DFC();
  _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  _id_0485::_id_5E91(game["roundsPlayed"], _getteamscore("axis"), _getteamscore("allies"));
  game["roundsPlayed"]++;
  level notify("round_switch", "next_zone");

  if(isDefined(level._id_AC7C._id_5E5D)) {
    _setomnvar("ui_hardpoint_minimap_location_callout", level._id_AC7C._id_5E5D);
  }

  maps\mp\_utility::_id_863E(5, "free");
}

_id_4484() {
  return level._id_AC7C;
}

_id_4F03() {
  level endon("game_ended");
  level endon("zone_moved");
  level._id_4F04 = gettime();
  var_0 = "none";

  for(;;) {
    level._id_AC7C._id_3FCA _id_04D1::_id_0C30("any");
    level._id_AC7C._id_3FCA _id_04D1::_id_8A5A(0);
    level._id_AC7C._id_3FCA _id_04D1::_id_8A59(&"MP_CAPTURING_OBJECTIVE");
    level._id_AC7C._id_3FCA _id_04D1::_id_8A60("any");
    level._id_AC7C._id_3FCA _id_04D1::_id_86CD(1);
    level._id_AC7C._id_3FCA _id_04D1::_id_65BF(0);
    level._id_AC7C._id_3FCA _id_04D1::_id_1F49(1);
    level._id_AC7C._id_3FCA._id_6BBF = ::_id_6BD8;
    var_1 = gettime();
    var_2 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();
    _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level._id_AC7C.origin, var_2);
    var_3 = level common_scripts\utility::waittill_any_return("zone_captured", "zone_destroyed");

    if(var_3 == "zone_destroyed") {
      continue;
    }
    var_4 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();
    var_1 = gettime();

    if(isDefined(var_4)) {
      var_2 = var_4;
    }

    _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level._id_AC7C.origin, var_2);

    if(var_0 != "none" && var_0 != var_4) {
      if(isDefined(game["objectiveFlipCount"])) {
        game["objectiveFlipCount"]++;
      } else {
        game["objectiveFlipCount"] = 1;
      }
    }

    var_0 = var_4;

    if(var_4 == "allies") {
      _id_A141(level._id_6946, level._id_6945);
    } else if(var_4 == "axis") {
      _id_A141(level._id_6945, level._id_6946);
    } else {
      _id_A141(level._id_6945, level._id_6945);
    }

    level._id_AC7C._id_3FCA _id_04D1::_id_0C30("none");
    level._id_AC7C._id_3FCA._id_6BBF = undefined;
    level._id_AC7C._id_3FCA._id_6BBD = ::_id_6BDB;
    level._id_AC7C._id_3FCA._id_6AD0 = ::_id_6BD9;
    level._id_AC7C._id_3FCA._id_6BBB = ::_id_6BDA;
    level waittill("zone_destroyed", var_5);
    thread _id_3E2D(var_4);

    if(isDefined(var_5)) {
      level._id_AC7C._id_3FCA _id_04D1::_id_86EC(var_5);
      continue;
    }

    level._id_AC7C._id_3FCA _id_04D1::_id_86EC("none");
  }
}

_id_A11F() {
  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1;

      if(!isDefined(var_1.team) || !isDefined(var_1.sessionstate)) {
        continue;
      }
      if(var_1.team == "spectator" || var_1.sessionstate == "spectator") {
        var_2 = var_1 getspectatingplayer();
      }

      if(var_1 ismlgspectator()) {
        if(var_1._id_1E99._id_A4A8 == "third_person") {
          var_1 _id_868F(var_1, 0);
          continue;
        }
      }

      if(!maps\mp\_utility::isreallyalive(var_2)) {
        var_1 _id_868F(var_1, 0);
        continue;
      }

      if(var_2._id_9AC5.size == 0) {
        var_1 _id_868F(var_1, 0);
        continue;
      }

      foreach(var_4 in var_2._id_9AC5) {
        if(var_4 == level._id_AC7C._id_3FCA._id_9D65) {
          var_1 _id_868F(var_1, 1);
          break;
        }

        var_1 _id_868F(var_1, 0);
      }
    }

    waitframe();
  }
}

_id_868F(var_0, var_1) {
  var_2 = 0;

  if(var_1) {
    var_2 = 1;

    if(isDefined(level._id_AC7C._id_3FCA._id_56B7) && level._id_AC7C._id_3FCA._id_56B7) {
      var_2 = 2;
    }

    if(!var_0.touchinghardpoint) {
      thread _id_0485::_id_5E93("hp_enter", var_0.origin, level._id_AC7C.setmovespeedscale);
      var_0.touchinghardpoint = 1;
    }
  } else if(var_0.touchinghardpoint) {
    thread _id_0485::_id_5E93("hp_exit", var_0.origin, level._id_AC7C.setmovespeedscale);
    var_0.touchinghardpoint = 0;
  }

  if(var_2 != var_0._id_3FCC) {
    var_0 setclientomnvar("ui_hardpoint", var_2);
    var_0._id_3FCC = var_2;
    var_0._id_0112 = var_2;
  }
}

_id_4B1C() {
  level endon("game_ended");
  level._id_ACB2 = -100000;
  level._id_AC7C = _id_44DE();
  _id_8A70();
  _setomnvar("ui_hardpoint_minimap_location_callout", level._id_AC7C._id_5E5D);
  var_0 = 1;
  maps\mp\_utility::gameflagwait("prematch_done");
  level childthread _id_A11F();

  for(;;) {
    maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
    maps\mp\_utility::_id_3D8C("gamemode_objective");
    level._id_AC7C._id_3FCA _id_04D1::_id_86CD(1);
    level._id_AC7C._id_3FCA._id_6BBE = ::_id_4F05;
    level._id_ACB2 = gettime();

    if(level._id_530D) {
      _id_8A63(level._id_AC7C);
      level._id_AC7C._id_3FCA _id_04D1::_id_8A60("any");
      _id_A140(level._id_6947);
      _setomnvar("ui_hardpoint_timer", gettime() + 1000 * level._id_530D);
      wait(level._id_530D);
    }

    if(var_0) {
      var_0 = 0;
      wait 5.0;
      maps\mp\_utility::_id_863E(5, "free");

      foreach(var_2 in level.players) {
        if(var_2 ismlgspectator() && getdvarint("spv_enableHPBroadcasterMesh") != 0 && (isDefined(var_2._id_1E99._id_A4A8) && var_2._id_1E99._id_A4A8 == "third_person")) {
          if(isDefined(level._id_AC7C.broadcastermesh)) {
            level._id_AC7C.broadcastermesh showtoplayer(var_2);
          }
        }
      }
    }

    waittillframeend;
    _id_86D4(level._id_AC7C);
    maps\mp\_utility::leaderdialog("hp_online", undefined, "gamemode_objective");
    _id_A140(level._id_6945);
    level thread maps\mp\_utility::playsoundonplayers(game["objective_active"]);
    level._id_AC7C._id_3FCA _id_04D1::_id_365D();
    level._id_AC7C._id_3FCA._id_1FB6 = 0;
    level._id_AC7C._id_3FCA thread _id_04D1::_id_9BA8();

    if(level._id_ACA0) {
      thread _id_64E2(level._id_ACA0);
      _setomnvar("ui_hardpoint_timer", gettime() + 1000 * level._id_ACA0);
    } else
      level._id_AC9E = 0;

    _id_4F03();
    var_4 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();
    level._id_AC7C._id_3FCA._id_5B78 = undefined;
    level._id_AC7C._id_3FCA _id_04D1::_id_2F93();
    level._id_AC7C._id_3FCA _id_04D1::_id_0C30("none");
    level._id_AC7C._id_3FCA _id_04D1::_id_86EC("neutral");
    level._id_AC7C._id_3FCA _id_04D1::_id_86CD(0);
    level._id_AC7C._id_3FCA _id_04D1::_id_65BF(0);
    level._id_AC7C._id_3FCA _id_04D1::set2dicon("broadcaster", undefined);
    level._id_AC7C._id_3FCA _id_04D1::playsoundtoteam("broadcaster", undefined);
    level notify("zone_reset");

    if(isDefined(level._id_4F01) && level._id_4F01 == 1) {
      level waittill("ready_for_next_hp_zone");
    }

    _id_8FDD();
    wait 0.5;
    thread _id_3E2D(var_4);
    wait 0.5;
  }
}

_id_3E2D(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3.pers["team"] == var_0) {
      var_3 notify("force_spawn");
      wait 0.1;
    }
  }
}

_id_6BD8(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = maps\mp\_utility::getotherteam(var_1);
  var_3 = gettime();
  var_0 logstring("zone captured");
  level._id_AC7C._id_3FCA._id_56B7 = 0;
  level._id_A239 = 0;
  _id_873D(var_1);
  maps\mp\gametypes\_gamelogic::_id_6F27();
  _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);

  if(!isDefined(self._id_5B78) || self._id_5B78 != var_1) {
    var_4 = [];
    var_5 = getarraykeys(self._id_9AC3[var_1]);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_4[var_5[var_6]] = self._id_9AC3[var_1][var_5[var_6]];
    }

    level thread _id_4756(var_4, var_3, var_1, self._id_5B78);
    level thread maps\mp\_utility::leaderdialog("hp_secured", var_1, "gamemode_objective");
    level thread maps\mp\_utility::leaderdialog("hp_lost", var_2, "gamemode_objective");
  }

  level thread maps\mp\_utility::playsoundonplayers(game["objective_gained_sound"], var_1);
  level thread maps\mp\_utility::playsoundonplayers(game["objective_lost_sound"], var_2);
  level._id_4F02 = var_1;

  if(!isDefined(level._id_5B78) || var_1 != level._id_5B78) {
    maps\mp\_utility::_id_863E(6, var_1, var_0 getentitynumber());
  }

  _id_04D1::_id_86EC(var_1);

  if(isDefined(self._id_5B78) && self._id_5B78 != var_1) {
    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      var_0 = level.players[var_7];

      if(var_0.pers["team"] == var_1) {
        if(isDefined(var_0._id_5BAF) && var_0._id_5BAF + 500 > gettime()) {
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_hp_killedLastContester");
        }
      }
    }
  }

  level thread _id_1455(var_1, self._id_5B78);
  self._id_1FB6++;
  self._id_5B78 = var_1;
  _id_04D1::_id_65BF(1);
  level notify("zone_captured");
  level notify("zone_captured" + var_1);
}

_id_4756(var_0, var_1, var_2, var_3) {
  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_0[var_4[var_5]].player;
    var_6 _id_A0F0(var_3);

    if(!_id_57B8(var_6)) {
      var_6 maps\mp\gametypes\_missions::processchallenge("ch_hp_capturedObjective");

      if(level._id_4F04 + 500 > var_1) {
        var_6 maps\mp\gametypes\_missions::processchallenge("ch_hp_immediateCapture");
      }

      var_6 thread _id_047A::botgetdifficulty(level._id_AC7C.setmovespeedscale);
      var_6 notify("ch_capture", level._id_AC7C);
    } else {}

    waitframe();
  }
}

_id_6BDB() {
  level notify("zone_destroyed");
  level._id_4F02 = "neutral";
  level._id_AC7C._id_3FCA._id_56B7 = 0;

  if(self._id_689F["axis"] == 0 && self._id_689F["allies"] == 0) {
    level._id_AC7C._id_3FCA._id_A873 = 1;
    _id_86D4();

    if(isDefined(level._id_9A13) && level._id_9A13) {
      maps\mp\gametypes\_gamelogic::_id_7DFC();
      _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
    }
  }
}

_id_6BD9() {
  maps\mp\_utility::_id_863E(7, "free");
  var_0 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();
  level._id_AC7C._id_3FCA._id_A86C = 1;
  level._id_AC7C._id_3FCA._id_56B7 = 1;
  _id_8654();

  if(isDefined(level._id_9A13) && level._id_9A13) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  }

  level thread maps\mp\_utility::playsoundonplayers(game["objective_contested_sound"]);
  maps\mp\_utility::leaderdialog("hp_contested", undefined, "gamemode_objective");
  var_1 = gettime();
  var_2 = "contested";
  _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level._id_AC7C.origin, var_2);
}

_id_6BDA(var_0) {
  level._id_AC7C._id_3FCA._id_56B7 = 0;
  _id_873D(var_0);
  maps\mp\gametypes\_gamelogic::_id_6F27();
  _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  level._id_AC7C._id_3FCA _id_04D1::_id_864E(var_0);
  var_1 = gettime();
  var_2 = var_0;
  _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level._id_AC7C.origin, var_2);
}

_id_86D4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_AC7C;
  }

  if(!isDefined(level._id_AC7C) || var_0 == level._id_AC7C) {
    thread _id_74EF(0);
    _setomnvar("ui_hardpoint_status", 0);
    thread setbroadcastermesh("neutral");
  }

  var_0._id_3FCA _id_04D1::set2dicon("friendly", level.iconneutral);
  var_0._id_3FCA _id_04D1::playsoundtoteam("friendly", level.iconneutral);
  var_0._id_3FCA _id_04D1::set2dicon("enemy", level.iconneutral);
  var_0._id_3FCA _id_04D1::playsoundtoteam("enemy", level.iconneutral);
  maps\mp\_utility::_id_863F(var_0._id_3FCA, level.iconneutral, 0, 1);
}

_id_8A63(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_AC7C;
  }

  var_1 = "waypoint_waitfor_flag_neutral";
  var_0._id_3FCA _id_04D1::set2dicon("friendly", var_1);
  var_0._id_3FCA _id_04D1::playsoundtoteam("friendly", var_1);
  var_0._id_3FCA _id_04D1::set2dicon("enemy", var_1);
  var_0._id_3FCA _id_04D1::playsoundtoteam("enemy", var_1);
  maps\mp\_utility::_id_863F(var_0._id_3FCA, var_1, 0, 1);
}

_id_8654() {
  thread _id_74EF(-1);
  thread setbroadcastermesh("contested");
  _setomnvar("ui_hardpoint_status", -1);
  level._id_AC7C._id_3FCA _id_04D1::set2dicon("friendly", level.iconcontested);
  level._id_AC7C._id_3FCA _id_04D1::playsoundtoteam("friendly", level.iconcontested);
  level._id_AC7C._id_3FCA _id_04D1::set2dicon("enemy", level.iconcontested);
  level._id_AC7C._id_3FCA _id_04D1::playsoundtoteam("enemy", level.iconcontested);
  maps\mp\_utility::_id_863F(level._id_AC7C._id_3FCA, level.iconcontested, 3, 1);
}

_id_873D(var_0) {
  level._id_AC7C._id_3FCA _id_04D1::set2dicon("friendly", level.icondefend);
  level._id_AC7C._id_3FCA _id_04D1::playsoundtoteam("friendly", level.icondefend);
  level._id_AC7C._id_3FCA _id_04D1::set2dicon("enemy", level.iconcapture);
  level._id_AC7C._id_3FCA _id_04D1::playsoundtoteam("enemy", level.iconcapture);

  if(var_0 == "allies") {
    thread _id_74EF(2);
    thread setbroadcastermesh("allies");
    _setomnvar("ui_hardpoint_status", 2);
    maps\mp\_utility::_id_863F(level._id_AC7C._id_3FCA, level.iconcapture, 2, 1);
  } else {
    thread _id_74EF(1);
    thread setbroadcastermesh("axis");
    _setomnvar("ui_hardpoint_status", 1);
    maps\mp\_utility::_id_863F(level._id_AC7C._id_3FCA, level.iconcapture, 1, 1);
  }
}

_id_8A70() {
  if(!isDefined(level._id_AC7C) || !isDefined(level._id_AC7C._id_356F)) {
    return;
  }
  foreach(var_1 in level.players) {
    var_1 _id_8A6F();
  }
}

_id_8A6F() {
  if(!isDefined(level._id_AC7C) || !isDefined(level._id_AC7C._id_356F)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.team)) {
    return;
  }
  foreach(var_1 in getarraykeys(level._id_AC7C._id_356F)) {
    foreach(var_3 in level._id_AC7C._id_356F[var_1]) {
      if(var_1 == self.team) {
        var_3 showtoplayer(self);
        continue;
      }

      var_3 _meth_8006(self);
    }
  }

  if(self ismlgspectator() && (isDefined(self._id_1E99._id_A4A8) && self._id_1E99._id_A4A8 == "third_person")) {
    if(isDefined(level._id_AC7C.broadcastermesh) && getdvarint("spv_enableHPBroadcasterMesh") != 0) {
      level._id_AC7C.broadcastermesh showtoplayer(self);
    }
  }
}

_id_5A87() {
  if(!isDefined(level._id_AC7C) || !isDefined(level._id_AC7C._id_356F)) {
    return;
  }
  foreach(var_1 in level._id_AC7C._id_356F) {
    foreach(var_3 in var_1) {
      var_3 hide();
    }
  }
}

_id_74EF(var_0) {
  level notify("zoneFxChanged");
  level endon("zoneFxChanged");

  if(!isDefined(level._id_AC7C) || !isDefined(level._id_AC7C._id_356F)) {
    return;
  }
  foreach(var_2 in getarraykeys(level._id_AC7C._id_356F)) {
    foreach(var_4 in level._id_AC7C._id_356F[var_2]) {
      var_5 = isDefined(var_4._id_A419) && var_4._id_A419;

      if(var_0 == 0) {
        if(var_5) {
          var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_neutral_vertical"));
        } else {
          var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_neutral"));
        }

        continue;
      }

      if(var_0 == -1) {
        if(var_5) {
          var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_contested_vertical"));
        } else {
          var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_contested"));
        }

        continue;
      }

      if(var_0 == 1 && var_2 == "allies" || var_0 == 2 && var_2 == "axis" || var_2 == "spectator" && var_0 == 1) {
        if(var_5) {
          var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_enemy_vertical"));
        } else {
          var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_enemy"));
        }

        continue;
      }

      if(var_0 == 1 && var_2 == "axis" || var_0 == 2 && var_2 == "allies" || var_2 == "spectator" && var_0 == 2) {
        if(var_5) {
          var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_friendly_vertical"));
          continue;
        }

        var_4 _meth_8688(common_scripts\utility::_id_44F5("hp_friendly"));
      }
    }
  }
}

_id_64E2(var_0) {
  level endon("game_ended");
  level endon("zone_reset");
  level._id_ACAF = gettime() + var_0 * 1000;
  level._id_AC9E = 0;
  wait(var_0);

  if(!isDefined(level._id_AC7C._id_3FCA._id_A86C) || level._id_AC7C._id_3FCA._id_A86C == 0) {
    if(!isDefined(level._id_AC7C._id_3FCA._id_A873) || level._id_AC7C._id_3FCA._id_A873 == 0) {
      var_1 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();

      foreach(var_3 in level.players) {
        if(var_3.pers["team"] == var_1) {
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_hp_controlZoneEntirely");
        }
      }
    }
  }

  level._id_AC9E = 1;
  level notify("zone_moved");
}

_id_1455(var_0, var_1) {
  level endon("game_ended");
  level endon("zone_destroyed");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_2 = 1;
  var_3 = 5;
  var_4 = 1;
  var_5 = [];

  while(!level.gameended) {
    wait(var_2);
    maps\mp\gametypes\_hostmigration::_id_A782();

    if(!level._id_AC7C._id_3FCA._id_56B7) {
      if(level._id_80AD) {
        var_4 = level._id_AC7C._id_3FCA._id_689F[var_0];
      }

      _id_04D2::_id_47BD(var_0, var_4, 1);
      var_6 = [];

      foreach(var_8 in level.players) {
        if(var_8.pers["team"] != var_0) {
          continue;
        }
        if(var_8 istouching(level._id_AC7C._id_9D5E)) {
          if(!isDefined(var_8._id_99DE)) {
            var_8._id_99DE = 0;
          }

          if(!isDefined(var_8._id_4B1D[level._id_AC7C.setmovespeedscale])) {
            var_8._id_4B1D[level._id_AC7C.setmovespeedscale] = 0;
          }

          var_8._id_4B1D[level._id_AC7C.setmovespeedscale] = var_8._id_4B1D[level._id_AC7C.setmovespeedscale] + 1;
          var_8._id_99DE = var_8._id_99DE + 1;
          var_8.pers["time"] = var_8._id_99DE;
          var_8 maps\mp\_utility::_id_867B(var_8.pers["time"]);

          if(isDefined(var_5) && var_5.size > 0 && common_scripts\utility::_id_0F79(var_5, var_8)) {
            if(isDefined(var_8._id_4C67) && var_8._id_4C67 + var_3 * 1000 <= gettime()) {
              if(var_8 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
                var_8 thread _id_047A::_id_4C68();
              }

              var_8._id_4C67 = gettime();
            }
          } else
            var_8._id_4C67 = gettime() - 1000;

          var_6[var_6.size] = var_8;
        }
      }

      var_5 = var_6;
      continue;
    }

    var_5 = [];
  }
}

_id_255D(var_0, var_1) {
  var_2 = var_0.setmovespeedscale;
  var_3 = var_1.setmovespeedscale;

  if(!isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(var_2 > var_3) {
    return 1;
  }

  return 0;
}

_id_4749(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = 1;

  for(var_3 = var_1.size; var_2; var_3--) {
    var_2 = 0;

    for(var_4 = 0; var_4 < var_3 - 1; var_4++) {
      if(_id_255D(var_1[var_4], var_1[var_4 + 1])) {
        var_5 = var_1[var_4];
        var_1[var_4] = var_1[var_4 + 1];
        var_1[var_4 + 1] = var_5;
        var_2 = 1;
      }
    }
  }

  return var_1;
}

_id_8A55() {
  var_0 = _id_4749("hp_zone_center");
  var_1 = getEntArray("hp_zone_trigger", "targetname");
  level._id_ACB3 = _id_603B(var_0, var_1);
  level._id_0BCF = level._id_ACB3;
  return 1;
}

_id_603B(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 0;
    var_4 = var_0[var_2];
    var_4._id_9D5E = undefined;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(var_1[var_5] _meth_858B(var_4.origin)) {
        if(isDefined(var_4._id_9D5E)) {
          var_3 = 1;
          break;
        }

        var_4._id_9D5E = var_1[var_5];
        break;
      }
    }

    if(!isDefined(var_4._id_9D5E)) {
      if(!var_3) {
        continue;
      }
    }

    var_4._id_9DC6 = var_4._id_9D5E.origin;
    var_6 = [];
    var_6[0] = var_4;

    if(isDefined(var_4.target)) {
      var_7 = getEntArray(var_4.target, "targetname");

      for(var_5 = 0; var_5 < var_7.size; var_5++) {
        if(isDefined(var_7[var_5]._id_0165) && var_7[var_5]._id_0165 == "broadcaster_visual") {
          var_4.broadcastermesh = var_7[var_5];
          var_7[var_5] hide();
          var_7[var_5] _meth_80B1();
          continue;
        }

        var_6[var_6.size] = var_7[var_5];
      }
    }

    var_8 = [];
    var_8["allies"] = [];
    var_8["axis"] = [];
    var_8["spectator"] = [];
    var_9 = common_scripts\utility::_id_46B7(var_4.target, "targetname");

    foreach(var_11 in var_9) {
      var_12 = undefined;
      var_13 = 0;

      if(isDefined(var_11._id_0165) && var_11._id_0165 == "vertical") {
        var_13 = 1;
      }

      if(var_13) {
        var_12 = common_scripts\utility::_id_44F5("hp_neutral_vertical");
      } else {
        var_12 = common_scripts\utility::_id_44F5("hp_neutral");
      }

      var_14 = anglesToForward(var_11.angles);
      var_15 = anglestoup(var_11.angles);
      var_16 = _spawnfx(var_12, var_11.origin, var_14, var_15);
      var_17 = _spawnfx(var_12, var_11.origin, var_14, var_15);
      var_18 = _spawnfx(var_12, var_11.origin, var_14, var_15);

      if(var_13) {
        var_16._id_A419 = 1;
        var_17._id_A419 = 1;
        var_18._id_A419 = 1;
      }

      var_16 hide();
      var_17 hide();
      var_8["allies"][var_8["allies"].size] = var_16;
      var_8["axis"][var_8["axis"].size] = var_17;
      var_8["spectator"][var_8["spectator"].size] = var_18;
    }

    var_4._id_356F = var_8;
    var_4._id_3FCA = _id_04D1::_id_2837("neutral", var_4._id_9D5E, var_6, (0, 0, 0));
    var_4._id_3FCA _id_04D1::_id_2F93();
    _id_86D4(var_4);
    maps\mp\_utility::_id_863F(var_4._id_3FCA, undefined);
    var_4._id_3FCA _id_04D1::_id_86CD(0);
    var_4._id_9D5E._id_A222 = var_4._id_3FCA;
    var_4._id_3FCA._id_6996["allies"] sethidetrigger(var_4._id_9D5E);
    var_4._id_3FCA._id_6996["axis"] sethidetrigger(var_4._id_9D5E);
    var_4 _id_8A33();

    if(isDefined(var_4._id_9D5E._id_0165)) {
      var_4._id_5E5D = int(var_4._id_9D5E._id_0165);
      continue;
    }

    var_4._id_5E5D = -1;
  }

  return var_0;
}

_id_8A33() {
  var_0 = _id_050D::_id_448A();

  if(var_0.size == 0) {
    return;
  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1]._id_3046 = distancesquared(var_0[var_1].origin, self.origin);
  }

  for(var_1 = 1; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    for(var_3 = var_1 - 1; var_3 >= 0 && var_2._id_3046 < var_0[var_3]._id_3046; var_3--) {
      var_0[var_3 + 1] = var_0[var_3];
    }

    var_0[var_3 + 1] = var_2;
  }

  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = var_0.size / 3;

  for(var_1 = 0; var_1 <= var_8; var_1++) {
    var_4[var_4.size] = var_0[var_1];
  }

  while(var_1 < var_0.size) {
    var_7[var_7.size] = var_0[var_1];

    if(var_1 <= var_8 * 2) {
      var_5[var_5.size] = var_0[var_1];
    } else {
      var_6[var_6.size] = var_0[var_1];
    }

    var_1++;
  }

  self._id_3FCA._id_663F = var_4;
  self._id_3FCA._id_6163 = var_5;
  self._id_3FCA._id_3A51 = var_6;
  self._id_3FCA._id_6C70 = var_7;
}

_id_44DE() {
  var_0 = level._id_ACB3[0];
  level._id_76EE = 0;
  level.currentzoneindex = 0;
  return var_0;
}

_id_45AF() {
  var_0 = (level._id_76EE + 1) % level._id_ACB3.size;
  var_1 = level._id_ACB3[var_0];
  level._id_76EE = var_0;
  level.currentzoneindex = var_0;
  return var_1;
}

_id_8C31() {
  level._id_ACB9 = common_scripts\utility::array_randomize(level._id_ACB3);

  if(level._id_AC7C == level._id_ACB9[0]) {
    level._id_ACB9 = common_scripts\utility::_id_9530(level._id_ACB9, 0, _randomintrange(1, level._id_ACB9.size));
  }
}

_id_45B0() {
  if(level._id_ACB9.size == 0) {
    _id_8C31();
  }

  var_0 = level._id_ACB9[0];

  for(var_1 = 0; var_1 < level._id_ACB3.size; var_1++) {
    if(var_0 == level._id_ACB3[var_1]) {
      level.currentzoneindex = var_1;
    }
  }

  var_2 = [];

  for(var_1 = 1; var_1 < level._id_ACB9.size; var_1++) {
    var_2[var_1 - 1] = level._id_ACB9[var_1];
  }

  level._id_ACB9 = var_2;
  return var_0;
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
  if(!isDefined(level._id_AC7C)) {
    return;
  }
  var_10 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();

  if(!isDefined(var_10) || var_10 == "neutral") {
    return;
  }
  self.touchinghardpoint = 0;
  var_11 = 0;
  var_12 = self;

  if(!level._id_AC7C._id_3FCA._id_56B7 && var_1 istouching(level._id_AC7C._id_9D5E)) {
    var_11 = 1;
    var_1 thread _id_047A::_id_5A82(self, var_9, var_4, level._id_AC7C.setmovespeedscale);
    var_1._id_62A1["assaultObjective"] = level._id_AC7C;
  }

  if(var_12 istouching(level._id_AC7C._id_9D5E)) {
    var_12._id_2EF1 = 1;
    var_1._id_5BAF = gettime();
    var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);
    var_12 thread _id_0485::_id_5E96(var_12._id_5CC6, "in_hardpoint");

    if(var_11) {
      return;
    }
    if(var_12.team == var_10) {
      var_1 thread _id_047A::_id_10BA(var_12, var_9, var_4);
      var_1._id_62A1["assaultObjective"] = level._id_AC7C;
    } else {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_hp_zoneDefense");
      var_1 thread _id_047A::_id_2C80(self, var_9, var_4, level._id_AC7C.setmovespeedscale);
      var_1 maps\mp\_utility::_id_867C(var_1.pers["defends"]);
      var_1._id_62A1["defendObjective"] = level._id_AC7C;
    }
  } else
    var_12._id_2EF1 = 0;
}

_id_6AF9(var_0) {
  for(var_1 = 0; var_1 < level._id_ACB3.size; var_1++) {
    level._id_ACB3[var_1]._id_3FCA _id_04D1::_id_0C30("none");
  }
}

_id_5E9C() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    foreach(var_5, var_3 in var_1._id_4B1D) {
      if(var_5 > 0 && var_5 < 6) {
        var_4 = getmatchdata("players", var_1.clientid, "hardpointScore", var_5);
        var_4 = var_4 + var_3;
        setmatchdata("players", var_1.clientid, "hardpointScore", var_5, var_4);
      }
    }
  }
}

_id_A0F0(var_0) {
  if(!isDefined(self._id_1FAB)) {
    self._id_6885 = 0;
    self._id_1FAB = 0;
  }

  if(!isDefined(var_0) || var_0 == "neutral") {
    return;
  }
  self._id_6885++;
  var_1 = maps\mp\_utility::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self._id_9A06["total"])) {
    var_1 = max(self._id_9A06["total"], 1) / 60;
  }

  self._id_1FAB = self._id_6885 / var_1;

  if(self._id_1FAB > self._id_6885) {
    self._id_1FAB = self._id_6885;
  }
}

_id_57B8(var_0) {
  if(!level.rankedmatch) {
    return 0;
  }

  if(var_0._id_1FAB > level._id_73C0) {
    return 1;
  }

  return 0;
}

setbroadcastermesh(var_0) {
  if(getdvarint("spv_enableHPBroadcasterMesh") == 0) {
    return;
  }
  if(!isDefined(level._id_AC7C) || !isDefined(level._id_AC7C.broadcastermesh)) {
    return;
  }
  if(!isDefined(level.broadcastercolorindexallies) || !isDefined(level.broadcastercolorindexaxis)) {
    return;
  }
  waittillframeend;
  var_1 = maps\mp\_utility::_id_4571();

  if(issubstr(var_1, "carentan_s2_winter")) {
    var_1 = "mp_carentan_s2";
  }

  if(var_0 == "allies") {
    level._id_AC7C.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1) + "_" + level.broadcastercolorindexallies);
  } else if(var_0 == "axis") {
    level._id_AC7C.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1) + "_" + level.broadcastercolorindexaxis);
  } else if(var_0 == "contested") {
    level._id_AC7C.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1) + "_contested");
  } else {
    level._id_AC7C.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1));
  }
}