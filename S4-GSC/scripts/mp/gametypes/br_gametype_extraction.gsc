/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_extraction.gsc
***********************************************************/

init() {
  scripts\mp\gametypes\br_gametypes::_id_4AB8("plunderSites");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("circle");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("gulag");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("littleBirdSpawns");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("oneLife");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("kiosk");
  scripts\mp\gametypes\br_gametypes::_id_C242("dropBagDelay", 120);
  scripts\mp\gametypes\br_gametypes::_id_C243("postPlunder", ::_id_B759);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerDropPlunderOnDeath", ::_id_B69D);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerShouldRespawn", ::_id_B7B0);
  scripts\mp\gametypes\br_gametypes::_id_C243("isValidSpectateTarget", ::_id_8AED);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerWelcomeSplashes", ::_id_B821);
  scripts\mp\gametypes\br_gametypes::_id_C243("spawnHandled", ::_id_E2F8);
  level._id_2BB5._id_9C6E = getdvarint("#x359df15ea9a12254b", 5);
  level._id_2BB5._id_A77F = 0;
  level._id_2BB5._id_5BDE = "tie";
  thread _id_8274();
}

_id_8274() {
  waittillframeend;
  _id_07D1::_id_60C0("collect_done", 0);
  _id_07D1::_id_60C0("helipad_wait_done", 0);
  level._id_9FE5 = ::_id_2BED;
  thread _id_D88D();
  thread _id_D86E();
  thread _id_D8B9();
  thread _id_D86F();
  thread _id_D8BB();
}

_id_B821(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome");

  if(!istrue(level._id_2A60)) {
    self waittill("br_jump");

    while(!self isonground()) {
      waitframe();
    }
  } else
    level waittill("prematch_done");

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_extract_welcome");
}

_id_E2F8(var_0) {
  return istrue(var_0._id_2A61) && _id_07D1::_id_60BE("prematch_done");
}

_id_69F6() {}

_id_2BED(var_0) {
  if(!_id_E2F8(var_0)) {
    return 1;
  }

  var_0 thread _id_B768();
  return 1;
}

_id_B768() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 1.0;
  wait(var_0);
  var_1 = getdvarint("#x3f52fcc2efe82bfa5", 20);

  if(var_1 > 0) {
    var_2 = 70;
    var_3 = 30;
    var_4 = 4;
    var_5 = -4;
    scripts\mp\playerlogic::_id_C673(self.origin, self.angles);
    var_6 = scripts\mp\hud_util::createfontstring("hudsmall", 1.0);
    var_6 scripts\mp\hud_util::setpoint("RIGHT", "CENTER", var_3 + var_5, var_2);
    var_6.label = &"MP/WAITING_TO_SPAWN";
    var_7 = scripts\mp\hud_util::_id_4065("hudsmall", 1.0);
    var_7 scripts\mp\hud_util::setpoint("LEFT", "CENTER", var_3 + var_4, var_2);
    var_7 _meth_8391(var_1);
    scripts\engine\utility::_id_108F5("teamExtractedSpawnSpectate", var_1);
    var_7 destroy();
    var_6 destroy();
  }

  if(_id_8A92(self.team)) {
    return;
  }
  var_8 = 1.0;
  thread scripts\mp\gametypes\br_gulag::_id_58BC(var_8);
  wait(var_8);

  if(_id_8A92(self.team)) {
    return;
  }
  scripts\mp\playerlogic::_id_E337(undefined, 0);
  _id_0790::_id_0B9E();
  scripts\mp\gametypes\br_pickups::_id_825B();
  thread scripts\mp\gametypes\br_gulag::_id_F631(4);
  scripts\mp\gametypes\br_gulag::_id_728C(1);
}

_id_B7B0(var_0) {
  return 1;
}

_id_8AED(var_0) {
  return !_id_8A92(var_0.team);
}

_id_D88D() {
  level._id_2BB5._id_5842 = _id_6A28();
  thread _id_99F0();
}

_id_6A28() {
  var_0 = 2500;
  var_1 = level._id_2A73._id_2A7A;
  var_2 = (0, randomfloatrange(0, 360), 0);
  var_3 = anglesToForward(var_2);
  var_4 = level._id_2A73._id_2A25[0] * 2;
  var_5 = var_1 + var_3 * var_4;
  var_5 = scripts\mp\gametypes\br_c130::_id_DEAF(var_1, var_5);
  var_6 = getent("airstrikeheight", "targetname");
  var_7 = (var_5[0], var_5[1], var_6.origin[2]);
  var_8 = _id_F3CB(var_7);
  var_5 = var_8 + (0, 0, var_0);
  return var_5;
}

_id_99F0() {
  var_0 = _id_07F9::_id_C57D(1);
  level._id_2BB5._id_A8DA = var_0;

  if(var_0 != -1) {
    _id_07F9::_id_A867(var_0, "current", level._id_2BB5._id_5842, "icon_waypoint_koth");
    _id_07F9::_id_FB98(var_0, 0);
    _id_07F9::_id_A89F(var_0);
  }
}

_id_D88E() {
  _id_07D1::_id_60C2("prematch_done");
  var_0 = _id_69B3();
  var_1 = scripts\mp\gametypes\br_quest_util::_id_6CA6("gt_extract_1");

  foreach(var_3 in level.players) {
    var_3 scripts\mp\gametypes\br_quest_util::_id_D68B(var_1);
    var_3 scripts\mp\gametypes\br_quest_util::_id_F920(var_0);
  }
}

_id_69B3() {
  var_0 = getdvarint("#x3670487661c5d4084", 5000);
  var_1 = getdvarint("#x3696c9bd3f5c507db", 2000);
  var_2 = getdvarint("#x3330633b82d578bd", 200);

  if(var_1 > 0) {
    var_0 = int(max(var_1, var_0 - level._id_2BB5._id_A77F * var_2));
  }

  return var_0;
}

_id_DCA6(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    _id_07F9::_id_A89D(level._id_2BB5._id_A8DA, var_3);
  }
}

_id_78F9(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    _id_07F9::_id_A89E(level._id_2BB5._id_A8DA, var_3);
  }
}

_id_77AF() {
  self endon("death");
  self endon("missionComplete");
  var_0 = _id_07F9::_id_C57D(1);
  self._id_A8DA = var_0;
  thread _id_77AB();

  if(var_0 != -1) {
    _id_07F9::_id_A867(var_0, "current", (0, 0, 0), "ui_mp_br_mapmenu_legend_littlebird");
    _id_07F9::_id_FB93(var_0, self);
    _id_07F9::_id_FB9D(var_0, 100);
    _id_07F9::_id_FB98(var_0, 1);
    _id_07F9::_id_A89F(var_0);
  }

  for(;;) {
    while(self._id_A924.size == 0 || !isDefined(self._id_ADAE)) {
      waitframe();
    }

    var_1 = self._id_ADAE;
    _id_DCA6(var_1);
    _id_07F9::_id_FB96(var_0, var_1);
    _id_07F9::_id_FB98(var_0, 0);
    _id_07F9::_id_A8A2(var_0);
    thread _id_77AE(self._id_ADAE);
    thread _id_77AA(self._id_ADAE);

    while(self._id_A924.size > 0) {
      waitframe();
    }

    _id_78F9(var_1);
    _id_07F9::_id_FB96(var_0, undefined);
    _id_07F9::_id_FB98(var_0, 1);
    _id_07F9::_id_A89F(var_0);
    self notify("heliDrivableSwitchTeams");
  }
}

_id_77AB() {
  level endon("game_ended");
  self endon("missionComplete");
  self waittill("death");
  thread _id_5030(self);
  _id_07F9::_id_A89F(self._id_A8DA);
  _id_07F9::_id_C799(self._id_A8DA);
}

_id_77AE(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("heliDrivableSwitchTeams");
  var_1 = 90000;

  for(;;) {
    var_2 = distance2dsquared(self.origin, level._id_2BB5._id_5842);

    if(var_2 < var_1) {
      if(level._id_2BB5._id_A77F == 0) {
        level._id_2BB5._id_5BDE = var_0;
      }

      _id_EF6F(var_0, self);

      if(level._id_2BB5._id_9C6E > 0 && level._id_2BB5._id_A77F >= level._id_2BB5._id_9C6E) {
        thread _id_2BAA();
      }

      break;
    }

    waitframe();
  }
}

_id_77AA(var_0) {
  level endon("game_ended");
  self endon("heliDrivableSwitchTeams");
  self waittill("death");
  _id_78F9(var_0);
}

_id_4E84() {
  level._id_2BB5._id_A77F++;
  level._id_2BB5._id_7B66 _meth_83A3(level._id_2BB5._id_A77F);
  level._id_2BB5._id_7B66 thread _id_7B61();
  level._id_2BB5._id_7B65 thread _id_7B61();
  var_0 = _id_698A();
  level._id_2BB5._id_7B5F _meth_83A3(var_0 * 100);

  foreach(var_3, var_2 in level._id_EF6A) {
    if(isDefined(var_2["teamCount"]) && var_2["teamCount"] > 0) {
      _id_FD59(var_3);
    }
  }

  var_4 = _id_69B3();

  foreach(var_6 in level.players) {
    if(!_id_8A92(var_6.team)) {
      var_6 thread scripts\mp\hud_message::showsplash("br_gametype_extract_extracted");
      var_6 scripts\mp\gametypes\br_quest_util::_id_F920(var_4);
    }
  }
}

_id_EF6F(var_0, var_1) {
  level endon("game_ended");
  _id_D70E(var_0);
  scripts\mp\outofbounds::enableoobimmunity(self);
  _id_78F9(var_0);

  if(isDefined(var_1)) {
    var_1 notify("missionComplete");
    _id_07F9::_id_A89F(var_1._id_A8DA);
    _id_07F9::_id_C799(var_1._id_A8DA);
  }

  scripts\mp\gametypes\br_public::_id_2BDE("team_victory", var_0);
  [var_3, var_4, var_5] = ::scripts\mp\gametypes\br::_id_2EDF(1);
  var_6 = level._id_EF6A[var_0]["players"];

  foreach(var_8 in var_6) {
    var_8 scripts\mp\gametypes\br_quest_util::_id_F91E();
    var_8 setclientomnvar("post_game_state", 9);
    var_8 setclientomnvar("ui_br_end_game_splash_type", 1);
    scripts\mp\outofbounds::enableoobimmunity(var_8);
    var_8._id_E355 = 1;
  }

  _id_4E84();
  thread _id_EF6E(var_0, var_1);
}

_id_EF6E(var_0, var_1) {
  wait 2;
  var_2 = spawnStruct();

  if(isDefined(var_1)) {
    var_2.origin = var_1.origin;
  } else {
    var_2.origin = (0, 0, 0);
  }

  var_2.angles = (0, 0, 0);
  var_3 = level._id_EF6A[var_0]["players"];

  foreach(var_5 in var_3) {
    var_5 setclientomnvar("post_game_state", 0);
    var_5 setclientomnvar("ui_br_end_game_splash_type", -1);
    var_5 notify("teamExtractedSpawnSpectate");
    var_5 thread scripts\mp\gametypes\br_spectate::_id_E37D(var_2, 1, 1);
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_D70E(var_0) {
  level._id_EF6A[var_0]["extracted"] = 1;
}

_id_8A92(var_0) {
  return istrue(level._id_EF6A[var_0]["extracted"]);
}

_id_2BAA() {
  wait 1.5;
  _id_7440();
  scripts\mp\gamelogic::_id_52FD(level._id_2BB5._id_5BDE, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

_id_7440() {
  foreach(var_1 in level.players) {
    if(!_id_8A92(var_1.team)) {
      var_1 setclientomnvar("post_game_state", 2);
    }
  }
}

_id_D8BB() {
  level endon("game_ended");
  var_0 = 120;
  _id_07D1::_id_60C2("prematch_done");

  if(!istrue(level._id_2A60)) {
    level waittill("br_ready_to_jump");
  }

  waitframe();
  var_1 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_COLLECT_PLUNDER", undefined, "CENTER", "CENTER", 0, -170);
  var_1.alpha = 1;
  var_2 = scripts\mp\hud_util::_id_404A("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  var_3 = getdvarint("#x3967585697dd1a039", 180);

  if(var_3 > 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(var_3 * 1000));
    var_2 _meth_8391(var_3);
    wait(var_3);
  }

  _id_07D1::_id_60C1("collect_done");
  var_4 = getdvarint("#x3c4f6c08326d3e472", 180);

  if(var_4 > 0) {
    var_1.label = &"MP_BR_INGAME/EXTRACT_HELIPADS_ACTIVE";
    var_1 thread _id_7B61();
    setomnvar("ui_hardpoint_timer", gettime() + int(var_4 * 1000));
    var_2 _meth_8391(var_4);
    wait(var_4);
  }

  _id_07D1::_id_60C1("helipad_wait_done");
  var_5 = getdvarint("#x31e23d084874cbce6", 840);
  var_1.label = &"MP_BR_INGAME/EXTRACT_HELIPAD";
  var_1 thread _id_7B61();
  setomnvar("ui_hardpoint_timer", gettime() + int(var_5 * 1000));
  var_2 _meth_8391(var_5);
  var_6 = max(var_5 - var_0, 0);
  wait(var_6);
  var_7 = max(var_5 - var_6, 0);
  var_2.color = (1, 0, 0);
  var_2 thread _id_7B61();
  thread _id_39B3(var_7);
  wait(var_7);
  var_2 destroy();
  thread _id_2BAA();
}

_id_39B3(var_0) {
  level endon("game_ended");
  _func_01EA("ui_final_moments_notify", gettime() + var_0 * 1000);

  while(var_0 > 0) {
    var_1 = 0;
    var_2 = scripts\mp\gamelogic::_id_6966(var_0);

    if(var_0 > 60 && var_0 % 10 == 0 || var_0 <= 60 && var_0 > 30 && var_0 % 2 == 0 || var_0 <= 30) {
      var_1 = 1;
    }

    if(var_1) {
      foreach(var_4 in level.players) {
        var_4 playlocalsound(var_2);
      }
    }

    var_0 = var_0 - 1;
    wait 1;
  }
}

_id_D86F() {
  var_0 = -120;
  var_1 = -170;
  var_2 = 2;
  var_3 = -2;
  level._id_2BB5._id_7B66 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_NUM", 0, "RIGHT", "CENTER", var_0 + var_3, var_1, (0, 1, 0));
  level._id_2BB5._id_7B65 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_MAX", level._id_2BB5._id_9C6E, "LEFT", "CENTER", var_0 + var_2, var_1, (0, 1, 0));
  _id_07D1::_id_60C2("helipad_wait_done");
  level._id_2BB5._id_7B66.alpha = 1;

  if(level._id_2BB5._id_9C6E > 0) {
    level._id_2BB5._id_7B65.alpha = 1;
  }
}

_id_D8B9() {
  var_0 = 145;
  var_1 = 20;
  var_2 = -3;
  var_3 = 3;
  var_4 = _id_698A();
  level._id_2BB5._id_7B60 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_COST_TEXT", undefined, "LEFT", "CENTER", var_3, var_0);
  level._id_2BB5._id_7B5F = _id_3FF3(&"MP_BR_INGAME/EXTRACT_COST", var_4 * 100, "LEFT", "CENTER", var_3, var_0 + var_1);
  level._id_2BB5._id_7B91 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", var_2, var_0);

  foreach(var_6 in level._id_EF89) {
    var_7 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_PLUNDER", 0, "RIGHT", "CENTER", var_2, var_0 + var_1, (1, 0, 0), var_6);
    _id_D717(var_6, var_7);
  }

  _id_07D1::_id_60C2("prematch_done");

  if(!istrue(level._id_2A60)) {
    level waittill("br_ready_to_jump");
  }

  level._id_2BB5._id_7B60.alpha = 1;
  level._id_2BB5._id_7B5F.alpha = 1;
  level._id_2BB5._id_7B91.alpha = 1;

  foreach(var_6 in level._id_EF89) {
    var_7 = _id_6DD6(var_6);
    var_7.alpha = 1;
  }
}

_id_D717(var_0, var_1) {
  level._id_EF6A[var_0]["hudPlunder"] = var_1;
  var_1._id_B956 = 0;
  var_1._id_B95C = 0;
}

_id_6DD6(var_0) {
  return level._id_EF6A[var_0]["hudPlunder"];
}

_id_3FF3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1.5;

  if(isDefined(var_7)) {
    var_9 = newteamhudelem(var_7);
  } else {
    var_9 = newhudelem();
  }

  var_9.elemtype = "font";
  var_9.font = "default";
  var_9.fontscale = var_8;
  var_9._id_22B8 = var_8;
  var_9.x = 0;
  var_9.y = 0;
  var_9.width = 0;
  var_9.height = int(level.fontheight * var_8);
  var_9.xoffset = 0;
  var_9.yoffset = 0;
  var_9.children = [];
  var_9 scripts\mp\hud_util::setparent(level.uiparent);
  var_9.hidden = 0;
  var_9.alpha = 0;
  var_9 scripts\mp\hud_util::setpoint(var_2, var_3, var_4, var_5);

  if(isDefined(var_0)) {
    var_9.label = var_0;
  }

  if(isDefined(var_1)) {
    var_9 _meth_83A3(var_1);
  }

  if(isDefined(var_6)) {
    var_9.color = var_6;
  }

  return var_9;
}

_id_6DD5(var_0) {
  var_1 = 0;
  var_2 = level._id_EF6A[var_0]["players"];

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_B956)) {
      var_1 = var_1 + var_4._id_B956;
    }

    if(isDefined(var_4._id_B955)) {
      var_1 = var_1 + var_4._id_B955;
    }
  }

  return var_1;
}

_id_B759(var_0) {
  var_1 = _id_6DD5(self.team);
  var_2 = _id_6DD6(self.team);
  var_2._id_B956 = var_1;
  thread _id_4CF5(var_2, self.team);
}

_id_4CF5(var_0, var_1) {
  var_0 notify("doHudPlunderRoll");
  var_0 endon("doHudPlunderRoll");
  var_2 = 2.0;
  var_3 = var_0._id_B956 * 100;
  var_4 = var_3 - var_0._id_B95C;
  var_5 = scripts\engine\utility::_id_DD3F(var_4);
  var_6 = var_4 / var_2;
  var_7 = int(var_6 * level._id_5F3A);

  if(var_7 == 0) {
    return;
  }
  _id_4CF6(var_5, var_1);
  var_8 = _id_698A() * 100;
  var_9 = var_5 > 0 && var_0._id_B95C > var_8;
  var_10 = level._id_EF6A[var_1]["players"];

  while(var_0._id_B95C != var_3) {
    if(!var_9 && (var_5 > 0 && var_0._id_B95C + var_7 >= var_8)) {
      var_9 = 1;

      foreach(var_12 in var_10) {
        var_12 playlocalsound("br_plunder_atm_deposit_gtr");
      }

      var_0.color = (0, 1, 0);
      thread _id_4CF4(var_1);
    }

    if(var_5 < 0 && var_0._id_B95C < var_8 && var_0.color != (1, 0, 0)) {
      var_0.color = (1, 0, 0);
    }

    var_0._id_B95C = var_0._id_B95C + var_7;

    if(var_5 > 0 && var_0._id_B95C > var_3 || var_5 < 0 && var_0._id_B95C < var_3) {
      var_0._id_B95C = var_3;
    }

    var_0 _meth_83A3(var_0._id_B95C);
    wait(level._id_5F3A);
  }

  foreach(var_12 in var_10) {
    var_12._id_7B90 = undefined;
    var_12 _meth_83EF("br_plunder_atm_use");
  }
}

_id_FD59(var_0) {
  var_1 = _id_6DD6(var_0);
  var_2 = _id_6DD5(var_0);
  var_3 = _id_698A();

  if(var_2 >= var_3 && var_1.color != (0, 1, 0)) {
    var_1.color = (0, 1, 0);
    var_4 = level._id_EF6A[var_0]["players"];

    foreach(var_6 in var_4) {
      var_6 playlocalsound("br_plunder_atm_deposit_gtr");
    }
  }
}

_id_4CF6(var_0, var_1) {
  var_2 = level._id_EF6A[var_1]["players"];

  foreach(var_4 in var_2) {
    if(var_0 > 0) {
      if(isDefined(var_4._id_7B90)) {
        var_5 = gettime() - var_4._id_7B90;

        if(var_5 <= 6000) {
          break;
        }
      }

      var_4._id_7B90 = gettime();

      if(isalive(var_4)) {
        var_4 playlocalsound("br_plunder_atm_use");
      }

      continue;
    }

    var_4._id_7B90 = undefined;
    var_4 _meth_83EF("br_plunder_atm_use");
  }
}

_id_B69D(var_0) {
  var_1 = int(self._id_B956 * 0.5);
  var_2 = self._id_B956 - var_1;

  if(var_2 <= 0) {
    var_2 = 1;
  }

  self._id_B95B = var_1;
  scripts\mp\gametypes\br_plunder::_id_B7A3(var_1);
  _id_5052(var_2, var_0);
  return 1;
}

_id_5052(var_0, var_1) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = 0;

  for(var_5 = level._id_2A9B._id_BE99.size - 1; var_5 >= 0; var_5--) {
    var_3[var_5] = int(var_0 / level._id_2A9B._id_BE99[var_5]);
    var_4 = var_4 + var_3[var_5];

    if(var_0 <= 0) {
      break;
    } else
      var_0 = var_0 - var_3[var_5] * level._id_2A9B._id_BE99[var_5];
  }

  for(var_6 = level._id_2A9B._id_BE99.size - 1; var_6 >= 0; var_6--) {
    if(!isDefined(var_3[var_6])) {
      continue;
    }
    for(var_7 = 0; var_7 < var_3[var_6]; var_7++) {
      [var_9, var_10, var_11] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_1 + var_2.size, self.origin, self.angles, self);
      var_12 = scripts\mp\gametypes\br_pickups::_id_E336(level._id_2A9B._id_A3D1[var_6], var_9, var_10, level._id_2A9B._id_BE99[var_6], 1, var_11);
      scripts\mp\gametypes\br_plunder::_id_A003(level._id_2A9B._id_A3D1[var_6], 1);

      if(isDefined(var_12)) {
        var_2[var_2.size] = var_12;

        if(scripts\mp\gametypes\br_plunder::_id_82D6()) {
          level._id_2A9D[level._id_2A9D.size] = var_12;
        }
      }
    }
  }

  level._id_2A9B._id_B936 = level._id_2A9B._id_B936 + var_4;
  level._id_2A9B._id_B952 = level._id_2A9B._id_B952 + var_0;
  level thread scripts\mp\gametypes\br_plunder::_id_5053(self.origin, var_2.size);
  return var_2;
}

_id_D86E() {
  level._id_2BB5._id_DD68 = _id_6A29();

  foreach(var_1 in level._id_2BB5._id_DD68) {
    var_1 setscriptablepartstate(var_1.type, var_1._id_4AAB);
  }

  _id_07D1::_id_60C2("prematch_done");
  level._id_2BB5._id_9C8E = getdvarint("#x3f478ef1891c194b5", 8);
  level._id_2BB5._id_CB88 = getdvarfloat("#x32e22e64e0e203699", 0.16);

  if(level._id_2BB5._id_CB88 > 0) {
    var_3 = _id_688B();
    level._id_2BB5._id_9C8E = int(_func_0037(level._id_2BB5._id_CB88 * var_3));
  }

  if(level._id_2BB5._id_DD68.size < level._id_2BB5._id_9C8E) {
    level._id_2BB5._id_9C8E = level._id_2BB5._id_DD68.size;
  } else {
    level._id_2BB5._id_DD68 = scripts\engine\utility::_id_1BD6(level._id_2BB5._id_DD68, ::_id_E039);
  }

  for(var_4 = 0; var_4 < level._id_2BB5._id_DD68.size; var_4++) {
    var_1 = level._id_2BB5._id_DD68[var_4];

    if(var_4 >= level._id_2BB5._id_9C8E) {
      var_1 setscriptablepartstate(var_1.type, "hidden");
    }
  }

  _id_07D1::_id_60C2("collect_done");

  for(var_4 = 0; var_4 < level._id_2BB5._id_DD68.size; var_4++) {
    var_1 = level._id_2BB5._id_DD68[var_4];

    if(var_4 < level._id_2BB5._id_9C8E) {
      var_1 setscriptablepartstate(var_1.type, var_1._id_10418);
    }
  }

  _id_07D1::_id_60C2("helipad_wait_done");

  for(var_4 = 0; var_4 < level._id_2BB5._id_DD68.size; var_4++) {
    var_1 = level._id_2BB5._id_DD68[var_4];

    if(var_4 < level._id_2BB5._id_9C8E) {
      var_1 setscriptablepartstate(var_1.type, var_1._id_0F60);
    }
  }

  _id_07A1::_id_CECB(::_id_DD69);
}

_id_688B() {
  var_0 = 0;

  foreach(var_2 in level._id_EF6A) {
    if(isDefined(var_2["teamCount"]) && var_2["teamCount"] > 0) {
      var_0++;
    }
  }

  return var_0;
}

_id_E039(var_0, var_1) {
  return distancesquared(var_0.origin, level._id_2A73._id_2A7A) < distancesquared(var_1.origin, level._id_2A73._id_2A7A);
}

_id_6A29() {
  var_0 = _func_03C0("plunder_extraction_01", "targetname");
  var_1 = _func_03C0("plunder_extraction_02", "targetname");

  if(var_0.size > 0 || var_1.size > 0) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);

    foreach(var_4 in var_2) {
      var_4._id_0F60 = "active2";
      var_4._id_4AAB = "visible";
      var_4._id_10418 = "visible2";
    }

    return var_2;
  } else {
    var_2 = _func_03C0("plunder_extraction", "targetname");

    foreach(var_4 in var_2) {
      var_4._id_0F60 = "visible";
      var_4._id_4AAB = "hidden";
      var_4._id_10418 = "visible";
    }

    return var_2;
  }
}

_id_698A() {
  var_0 = getdvarint("#x31d612510c03263f1", 300);
  var_1 = getdvarint("#x37fa4ccb862b7363e", 40);
  var_2 = getdvarint("#x38e228328b0182c02", 20);

  if(var_1 > 0) {
    var_0 = int(max(var_1, var_0 - level._id_2BB5._id_A77F * var_2));
  }

  return var_0;
}

_id_B7F2(var_0) {
  if(self._id_B956 < var_0) {
    var_0 = self._id_B956;
  }

  if(!isDefined(self._id_B962)) {
    self._id_B962 = 0;
  }

  self._id_B962 = self._id_B962 + var_0;
  scripts\mp\gametypes\br_plunder::_id_B7A3(self._id_B956 - var_0);
  return var_0;
}

_id_EF67(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    var_3._id_B962 = 0;
  }
}

_id_EF9B(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_B962)) {
      var_3._id_B962 = 0;
      var_3 iprintlnbold("Extraction refunded, chopper shot down.");
    }
  }
}

_id_EDDA(var_0) {
  var_1 = _id_698A();
  var_2 = level._id_EF6A[var_0]["aliveCount"];
  var_3 = int(var_1 / var_2);
  var_4 = level._id_EF6A[var_0]["alivePlayers"];

  foreach(var_6 in var_4) {
    var_7 = var_6 _id_B7F2(var_3);
    var_1 = var_1 - var_7;
  }

  if(var_1 > 0) {
    foreach(var_6 in var_4) {
      var_7 = var_6 _id_B7F2(var_1);
      var_1 = var_1 - var_7;

      if(var_1 <= 0) {
        break;
      }
    }
  }
}

_id_DD69(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }
  if(var_1 == "brloot_plunder_extraction_site_01" || var_1 == "brloot_plunder_extraction_site_02" || var_1 == "brloot_plunder_extraction_site") {
    var_6 = _id_6DD5(var_3.team);
    var_7 = _id_698A();

    if(var_6 < var_7) {
      thread _id_4CF4(var_3.team);
      var_3 playlocalsound("br_pickup_deny");
      return;
    }

    _id_EDDA(var_3.team);
    var_8 = level._id_EF6A[var_3.team]["players"];

    foreach(var_3 in var_8) {
      var_3 playlocalsound("br_plunder_atm_deposit_gtr");
    }

    if(var_1 == "brloot_plunder_extraction_site_01" || var_1 == "brloot_plunder_extraction_site_02" || var_1 == "brloot_plunder_extraction_site") {
      thread _id_DD6A(var_0, var_1, var_2, var_3);
    }
  }
}

_id_4CF4(var_0) {
  var_1 = _id_6DD6(var_0);
  var_1 _id_7B61();
}

_id_7B61() {
  self endon("death");

  if(istrue(self._id_BE2A)) {
    return;
  }
  var_0 = 0.5;
  var_1 = 4;
  self._id_BE2A = 1;
  var_2 = self.fontscale;
  self changefontscaleovertime(var_0);
  self.fontscale = var_1;
  wait(var_0);
  self changefontscaleovertime(var_0);
  self.fontscale = var_2;
  self._id_BE2A = undefined;
}

_id_DD6A(var_0, var_1, var_2, var_3) {
  var_0 setscriptablepartstate(var_0.type, "inuse2");
  var_4 = getgroundposition(var_0.origin, 1) + (0, 0, 2);
  thread _id_4C85(var_0, var_3, var_4);
}

_id_4C85(var_0, var_1, var_2) {
  var_3 = var_1 _id_B7CF(var_2);

  if(isDefined(var_3)) {
    var_4 = spawnStruct();
    var_4.origin = var_2;
    var_4.angles = var_3.angles;
    var_4.spawntype = "GAME_MODE";
    var_5 = spawnStruct();
    var_6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("little_bird", var_4, var_5);

    if(isDefined(var_6)) {
      var_3._id_DD67 = var_0;
      var_3._id_77A9 = var_6;
      var_6 hide();
      var_3 _id_7797(var_2);
      thread _id_583F(var_3);
      level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_requested", var_1.team, 1);
      level thread scripts\mp\gametypes\br_public::_id_2B3F("br_gametype_extract_heli_incoming");
      return;
    }
  }

  var_1 _id_B691(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

  if(isDefined(var_0)) {
    var_0 setscriptablepartstate(var_0.type, var_0._id_0F60);
  }

  waitframe();

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_77B4(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = var_0._id_10D0C;
  var_0 waittill("explode", var_2);

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_31E1()) {
    _id_B691(var_1, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
  } else {
    var_3 = _id_B7CF(var_2);

    if(isDefined(var_3)) {
      var_3 _id_7797(var_2);
      thread _id_583F(var_3);
      return;
    }

    _id_B691(var_1, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
  }
}

_id_B691(var_0, var_1) {
  self iprintlnbold(var_1);
  self playlocalsound("br_pickup_deny");

  if(isDefined(var_0)) {
    var_2 = self getweaponammoclip(var_0);
    self setweaponammoclip(var_0, var_2 + 1);
  }
}

_id_B7CF(var_0) {
  var_1 = var_0;
  var_2 = getent("airstrikeheight", "targetname");
  var_3 = var_2.origin[2] - 300;
  var_4 = (var_1[0], var_1[1], var_3);
  var_5 = (0, randomfloat(360), 0);
  var_6 = var_4 + -1 * anglesToForward(var_5) * 30000;
  var_7 = var_4 + anglesToForward(var_5) * 30000;
  var_8 = _id_E2FA(self, var_6, var_4, var_7);
  return var_8;
}

_id_5030(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("military_skyhook_backpack");
  var_2 = var_0.origin;
  var_3 = (var_2[0], var_2[1], -12000);
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0, var_4);
  var_6 = var_5["position"];
  var_7 = var_2[2] - var_6[2];

  if(var_7 > 0) {
    var_8 = _func_0218(2 * var_7 / 800);
    var_1 moveto(var_6, var_8, var_8, 0);
    wait(var_8);
  }

  var_1.origin = var_6;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_6);
  var_1 _id_3E87();
  var_1 delete();
}

_id_3E87() {
  var_0 = _id_698A();
  scripts\mp\gametypes\br_plunder::_id_5052(var_0, 0);
}

_id_2EEA(var_0, var_1, var_2) {
  var_3 = var_0 * 0.0000157828;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + _func_0218(var_5 * var_5 - 4 * var_4 * var_6)) / (2 * var_4);
  var_7 = var_7 * 3600;
  var_7 = var_7 + 1.5;
  return var_7;
}

_id_2EE9(var_0) {
  var_1 = _id_2EEA(30000, 100, 125);
  var_2 = _id_2EEA(var_0, 25.0, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

_id_77E3(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level._id_EF6A[self.team]["alivePlayers"];

  foreach(var_5 in var_3) {
    var_5 setclientomnvar("ui_br_plunder_extract_state", var_0);
    var_5 setclientomnvar("ui_br_plunder_extract_end_time", var_2);
  }
}

_id_583F(var_0) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 setvehgoalpos(var_0._id_AEDC, 1);
  var_0 _meth_838A(var_0._id_7092);
  var_1 = var_0 _id_F3C9(var_0._id_AEDC);
  var_2 = var_0._id_AEDC[2] - var_1;
  var_0._id_5D49 = _id_2EE9(var_2);
  var_0 _id_77E3(1, var_0._id_5D49);
  var_0 waittill("goal");
  var_0 thread _id_77EA();
  var_0 thread _id_77A0();
  var_0 _id_779A(var_0._id_533D, var_1);
  level thread scripts\mp\gametypes\br_public::_id_2B3F("br_gametype_extract_heli_arrived");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_chopper_arrive", var_0.team, 1);
  var_0 _id_776C(0);
  thread _id_EC07(var_0);
}

_id_EC07(var_0) {
  var_1 = var_0.team;
  var_2 = var_0._id_DD67;
  _id_EF67(var_1);
  var_0 notify("swapped");
  var_3 = var_0._id_77A9;
  var_3.origin = var_0.origin;
  var_3.angles = var_0.angles;
  var_3 show();
  var_0 delete();

  if(isDefined(var_2)) {
    var_3 thread _id_77AD(var_2);
    var_3 thread _id_77AC(var_2);
  }

  var_3 thread _id_77AF();
}

_id_77AD(var_0) {
  level endon("game_ended");
  self endon("death");
  var_0 endon("siteEnabled");
  var_1 = 90000;

  for(;;) {
    var_2 = distance2dsquared(self.origin, var_0.origin);

    if(var_2 > var_1) {
      break;
    }

    waitframe();
  }

  var_0 setscriptablepartstate(var_0.type, var_0._id_0F60);
  var_0 notify("siteEnabled");
}

_id_77AC(var_0) {
  level endon("game_ended");
  var_0 endon("siteEnabled");
  self waittill("death");
  var_0 setscriptablepartstate(var_0.type, var_0._id_0F60);
}

_id_77C3() {
  self._id_87F9 = 1;
  self._id_FDB2 = self._id_3E6D;
  var_0 = self._id_FDB2;
  var_0 makeuseable();
  var_0 setcursorhint("HINT_NOICON");
  var_0 setuseholdduration("duration_medium");
  var_0 sethintrequiresholding(1);
  var_0 setuserange(230);
  var_0 sethintstring(&"MP/BR_USE_PLUNDER_CACHE");
  var_1 = level._id_2A35.size;
  level._id_2A35[var_1] = var_0;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
  }

  thread _id_776B();
  thread _id_7799(var_0);
  _id_77E3(2, 30);
  wait 30;
  self._id_87F9 = 0;
  _id_77E8();
}

_id_7799(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 playlocalsound("br_plunder_atm_deposit_gtr");
    _id_77E4(var_1);
  }
}

_id_77E4(var_0) {
  if(!isDefined(self._id_B929)) {
    self._id_B929 = [];
  }

  var_1 = var_0._id_B956;
  var_0 scripts\mp\gametypes\br_analytics::_id_2B04(var_0, "little_bird", self.origin, var_1);
  var_2 = 0;

  if(isDefined(self._id_B929)) {
    foreach(var_4 in self._id_B929) {
      if(isDefined(var_4.player) && var_4.player == var_0) {
        var_4._id_B956 = var_4._id_B956 + var_1;
        var_2 = 1;
        break;
      }
    }
  }

  if(!var_2) {
    var_4 = spawnStruct();
    var_4.player = var_0;
    var_4.team = var_0.team;
    var_4._id_B956 = var_1;
    self._id_B929[self._id_B929.size] = var_4;
  }
}

_id_7768() {
  if(!isDefined(self._id_B929)) {
    return;
  }
  level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_success", self.team, 1);
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in self._id_B929) {
    var_0 = var_0 + var_3._id_B956;

    if(var_3.player.team != self.team) {
      var_1 = 1;
    }
  }

  scripts\mp\gametypes\br_analytics::_id_2B03(self._id_B929.size, var_0, "little_bird", var_1, self._id_533D);
  level._id_2A9B._id_582A = level._id_2A9B._id_582A + var_0;
  level._id_2A9B._id_5829++;
}

_id_77E8() {
  if(isDefined(self._id_FDB2)) {
    level._id_2A35 = scripts\engine\utility::array_remove(level._id_2A35, self._id_FDB2);
    self._id_FDB2 = undefined;
  }
}

_id_776B(var_0) {
  self._id_FDB2 endon("death");
  scripts\engine\utility::_id_108C5("leaving", "death");
  _id_77E8();
}

_id_7797(var_0) {
  self._id_103BE = spawn("script_model", var_0);
  self._id_103BE setModel("scr_smoke_grenade");
  self._id_103BE.angles = (0, 90, 90);
  self._id_103BE playLoopSound("smoke_carepackage_smoke_lp");
  self._id_103BE setscriptablepartstate("smoke", "on");
}

_id_776C(var_0) {
  if(isDefined(self._id_103BE)) {
    self._id_103BE stoploopsound();
    self._id_103BE delete();
  }

  if(istrue(var_0) && isDefined(self._id_DD67)) {
    self._id_DD67 setscriptablepartstate(self._id_DD67.type, self._id_DD67._id_0F60);
  }
}

_id_77A0() {
  self endon("death");

  if(!isDefined(self._id_103BE)) {
    return;
  }
  wait 5;
  self._id_103BE endon("death");
  self._id_103BE setscriptablepartstate("smoke", "dissipate");
  self._id_103BE playSound("smoke_canister_tail_dissipate");
  wait 1;
  self._id_103BE stoploopsound();
  wait 4.5;
  self._id_103BE delete();
}

_id_E2FA(var_0, var_1, var_2, var_3) {
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = 1;
  var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_1, var_4, "veh_apache_plunder_mp", "veh8_mil_air_lbravo_personnel_mp_flyable");

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = var_2 * (1, 1, 0);
  var_6._id_42E9 = ::_id_2F40;
  var_6.speed = 100;
  var_6.accel = 125;
  var_6.health = 1000;
  var_6.maxhealth = var_6.health;
  var_6.team = var_0.team;
  var_6.owner = var_0;
  var_6._id_461E = var_2;
  var_6._id_936C = 0;
  var_6._id_5C8A = var_5;
  var_6._id_AEDC = var_2;
  var_6._id_AEDB = var_3;
  var_6._id_533D = var_7;
  var_6._id_7092 = var_4[1];
  var_6._id_1031E = "magma_plunder_chopper";
  var_6 setCanDamage(1);
  var_6 setmaxpitchroll(10, 25);
  var_6 vehicle_setspeed(var_6.speed, var_6.accel);
  var_6 sethoverparams(50, 100, 50);
  var_6 setturningability(0.05);
  var_6 setyawspeed(45, 25, 25, 0.5);
  var_6 setotherent(var_0);
  var_6 thread _id_0A44::_id_5C7F(undefined, undefined);
  var_6 thread _id_7435();
  var_6 thread _id_779B();
  return var_6;
}

_id_779B() {
  self endon("heli_gone");
  self endon("swapped");
  var_0 = self.owner;
  var_1 = self.team;
  self waittill("death", var_2, var_3, var_4, var_5);
  _id_EF9B(var_1);
  _id_776A();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_8EE2) && !istrue(self._id_87F9)) {
    self vehicle_setspeed(25, 5);
    thread _id_7795(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  _id_77B3(var_2);
}

_id_776A() {
  if(isDefined(self._id_C918)) {
    self._id_C918 delete();
  }

  if(isDefined(self._id_3E6D)) {
    self._id_3E6D delete();
  }
}

_id_77B3(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread scripts\mp\gametypes\br::_id_EFAD("br_gametype_extract_heli_shot_down", self.owner, self.owner.team);
  _id_776C(1);
  _id_7798();
}

_id_7798() {
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_7795(var_0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self _meth_838A(self.angles[1] + var_0 * 2.5);
}

_id_7435() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::_id_9ACB(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      _id_2F40(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
      _id_776C(1);
    }
  }
}

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level._id_5FA5 && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::_id_8DD6(var_1, var_5, self, var_4, var_2);
  var_1 _id_07C4::_id_FC47("");

  if(self.health - var_2 <= 900 && (!isDefined(self._id_DE57) || !self._id_DE57)) {
    self._id_DE57 = 1;
  }

  self _meth_842C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_77C2() {
  self endon("death");
  self notify("leaving");
  self._id_916C = 1;
  self setvehgoalpos(self._id_AEDC, 1);
  self _meth_838A(self._id_7092);
  _id_77E3(3, self._id_5D49);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self._id_AEDB, 1);
  self _meth_838A(self._id_7092);
  self waittill("goal");
  self stoploopsound();
  _id_7768();
  _id_77E3(0, 0);
  self notify("heli_gone");
  _id_7798();
}

_id_779A(var_0, var_1) {
  self endon("death");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self _meth_838A(self._id_7092);
  self vehicle_setspeed(25.0, 31.25);
  thread _id_779C();
  thread _id_779D();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

_id_54EE() {
  return isalive(self) && (scripts\common\vehicle::_id_8AF5() || isDefined(self.classname) && self.classname == "script_vehicle");
}

_id_779C() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && var_0 _id_54EE()) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

_id_779D() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = _func_0098("script_vehicle", "classname", self.origin, getdvarfloat("#x34b8346a089ba183b", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::_id_3F87();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7036459ed3de1", var_2) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc6f86459ed25b0", var_3) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7076459ed46ad", var_4) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

_id_F3C9(var_0) {
  var_1 = 125;
  var_2 = _id_F3CB(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

_id_F3CB(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::_id_3F94();
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = scripts\engine\trace::_id_E409(var_0, var_4, var_1, var_2, var_5);
  } else {
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);
  }

  return var_6["position"];
}

_id_77EA() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread _id_77C2();
}