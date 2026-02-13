/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_air.gsc
*************************************************/

main() {
  _id_997B();
  _id_07DC::init();
  _id_07DC::_id_D854();

  if(_func_0127()) {
    scripts\mp\utility\game::_id_D4E0();
  }

  _id_997C();
  level._id_E6A1 = 0;
  level._id_ABAD = ::_id_ABAD;
}

_id_997A() {
  _id_997B();
  _id_997C();
  level._id_E6A1 = 1;
  _id_ABAD(1);
}

_id_997B() {
  level._id_ED22 = "to_air";
  level._id_41D2 = "to_air";
  setomnvar("ui_tac_ops_submode", level._id_41D2);
}

_id_997C() {
  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA("to_air", 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1("to_air", 10);
    scripts\mp\utility\game::_id_C2AD("to_air", 65);
    scripts\mp\utility\game::_id_C2A9("to_air", 1);
    scripts\mp\utility\game::_id_C2D0("to_air", 1);
    scripts\mp\utility\game::_id_C27E("to_air", 0);
    scripts\mp\utility\game::_id_C25D("to_air", 0);
    scripts\mp\utility\game::_id_C250("to_air", 0);
    level._id_9BEB = 0;
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_ABC0 = scripts\mp\gamelogic::_id_4580;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3c63cadc9c022acc6", 5);
  setdynamicdvar("#x3ad38f02bd9a29456", 10);
  setdynamicdvar("#x3ea832f361e5f0f9e", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("#x3ee3025e722ce448c", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("#x3e1cf872f62a500", 0);
  scripts\mp\utility\game::_id_C25D("conf", 0);
  setdynamicdvar("#x3d628ca1e61295f94", 0);
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_5C41 = scripts\mp\utility\dvars::_id_509C("flagNeutralization", 0, 0, 1);
  level._id_3C6A = 1;
}

_id_ABAD(var_0) {
  var_1[0] = "dd";
  var_1[1] = "dd_bombzone";
  var_1[2] = "blocker";
  var_1[3] = "grind";
  var_1[4] = "dom";
  var_1[5] = "conf";
  _id_07D6::main(var_1);
  _id_D5AD();
  _id_D846();
  thread _id_D899();

  if(!istrue(var_0)) {
    scripts\mp\gametypes\tac_ops::_id_3AE4();
    _id_0EFE();
    level._id_15DA = 1;
  }

  level._id_5856 = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::_id_D633("timelimit", 10);
  _id_FBFD();
}

_id_8294() {
  var_0 = level._id_ED1E;
  _id_0817::_id_1136("allies", "mp_toair_spawn_allies");
  _id_0817::_id_1136("axis", "mp_toair_spawn_axis");
  var_0._id_F2A4 = [];
  var_0._id_F2A4["allies"] = _id_0817::_id_6D4E("mp_toair_spawn_allies");
  var_0._id_F2A4["axis"] = _id_0817::_id_6D4E("mp_toair_spawn_axis");
}

_id_6D4A() {
  var_0 = level._id_ED1E;
  var_1 = self.pers["team"];
  var_2 = undefined;
  var_2 = var_0._id_F2A4[var_1];
  var_2 = _id_081C::_id_5A54(var_2);
  var_3 = undefined;

  if(isDefined(self._id_ED18._id_50B4)) {
    var_4 = isDefined(level._id_5628[0]) && self._id_ED18._id_50B4 == level._id_5628[0];
    var_5 = isDefined(level._id_5628[1]) && self._id_ED18._id_50B4 == level._id_5628[1];
    var_6 = isDefined(level._id_5628[2]) && self._id_ED18._id_50B4 == level._id_5628[2];

    if(var_4 || var_5 && level._id_5628[1]._id_E330 || var_6 && level._id_5628[2]._id_E330) {
      var_7 = scripts\engine\utility::_id_B433(self._id_ED18._id_50B4.origin, 32, 0, -1500, (0, 0, 1));
      self._id_ED18._id_50B4._id_E332 = var_7;
    } else if(isDefined(level._id_5628[1]) && self._id_ED18._id_50B4 == level._id_5628[1]) {
      self._id_ED18._id_50B4._id_E332 = self._id_ED18._id_50B4.origin;
      level._id_5628[1].owner thread _id_54CD(level._id_5628[1]);
    } else if(isDefined(level._id_5628[2]) && self._id_ED18._id_50B4 == level._id_5628[2]) {
      self._id_ED18._id_50B4._id_E332 = self._id_ED18._id_50B4.origin;
      level._id_5628[2].owner thread _id_54CD(level._id_5628[2]);
    }

    var_8 = anglesToForward(self._id_ED18._id_50B4.angles);
    var_8 = var_8 * (1, 1, 0);
    var_9 = (0, 0, 1);
    var_10 = _func_025B(var_8, var_9);
    var_11 = _func_0017(var_8, var_10, var_9);
    self._id_ED18._id_50B4._id_E267 = var_11;
  } else {}

  return var_3;
}

_id_0EFE() {
  _id_0817::_id_D461("TDM");
  _id_081C::_id_D45F("to_air", "allies");
  _id_081C::_id_D45F("to_air", "axis");
  level._id_6D4A = ::_id_6D4A;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4);
}

_id_ABA4() {
  var_0 = 0;

  if(self.team == "allies") {
    var_0 = 1;

    if(!istrue(level._id_E2B8)) {
      level._id_E2B8 = 1;
      thread _id_D87D();
    }
  } else if(self.team == "axis")
    var_0 = 2;

  self setclientomnvar("ui_tacops_team", var_0);
  _id_0A76::_id_8E2C();
}

_id_D5AD() {
  level._id_7C8A = "waypoint_hardpoint_target";
  level._id_7C74 = "koth_neutral";
  level._id_7C42 = "koth_enemy";
  level._id_7C4B = "koth_friendly";
  level._id_7C48 = "waypoint_hardpoint_contested";
  level._id_7C87 = "waypoint_taking_chevron";
  level._id_7C6F = "waypoint_hardpoint_losing";
  level._id_7C40 = "waypoint_target";
  level._id_7C41 = "waypoint_defend";
}

_id_D846() {
  level._id_13B4 = [];
  _id_3B8F(0, "air_path_0");
  _id_3B8F(1, "air_path_1");
  _id_3B8F(2, "air_path_2");
}

_id_3B8F(var_0, var_1) {
  var_2 = getent(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_2.target)) {
    var_3 = getEntArray(var_2.target, "targetname");

    if(isDefined(var_3) && var_3.size > 0) {
      level._id_13B4[var_0] = [];

      foreach(var_5 in var_3) {
        var_6 = int(var_5._id_039B);
        level._id_13B4[var_0][var_6] = [];
        var_7 = var_5;

        for(;;) {
          level._id_13B4[var_0][var_6][level._id_13B4[var_0][var_6].size] = var_7;

          if(!isDefined(var_7.target)) {
            break;
          }

          var_7 = getent(var_7.target, "targetname");
        }
      }
    }
  }
}

_id_D87D() {
  level._id_5628 = [];
  level._id_5628[0] = _id_E2DD(level._id_13B4[0][0][0].origin);
  level._id_5628[0] thread _id_1FF0();
  level._id_5628[1] = _id_E2DD(level._id_13B4[1][0][0].origin);
  level._id_5628[2] = _id_E2DD(level._id_13B4[2][0][0].origin);
  _id_081C::_id_10A5("to_air", level._id_5628[0], "allies", "to_air_allies_blackhawk");
  _id_081C::_id_10A5("to_air", level._id_5628[1], "allies", "to_air_allies_ah64_left");
  _id_081C::_id_10A5("to_air", level._id_5628[2], "allies", "to_air_allies_ah64_right");
  level._id_5628[0]._id_E330 = 0;
  level._id_5628[1]._id_E330 = 0;
  level._id_5628[2]._id_E330 = 0;
  _id_FBFD();
  level._id_5628[0]._id_F3FE = level._id_5628[0] _id_07D6::_id_4069(level._id_5628[0], (0, 0, 0));
  level._id_5628[0]._id_F3FE _id_07D6::_id_C300();
  level._id_5628[0]._id_F3FE _id_07D6::_id_C579(0, 1);
  level._id_5628[0]._id_F3FE _id_07D6::_id_D639("allies");
  level._id_5628[0]._id_F3FE _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  level._id_5628[0]._id_F3FE _id_07D6::_id_D8E0("any");
  level._id_13B3 = 0;
  level._id_5628[0] waittill("goal");
  _id_5E25();
}

_id_E2DD(var_0) {
  var_1 = var_0;
  var_2 = (0, 0, 0);
  var_3 = 24000;
  var_4 = undefined;
  var_5 = var_0[2];
  var_6 = _id_09AB::_id_6A21(var_5);
  var_7 = 8000;
  var_8 = "jackal";
  var_9 = _id_09AB::_id_6A4E(var_1, var_2, var_3, var_4, var_5, var_7, var_6, var_8);
  var_10 = _id_5954();
  var_11 = _id_0A4F::_id_24AC(0, var_9["startPoint"], var_1, var_10, undefined);
  return var_11;
}

_id_5954() {
  var_0 = spawnStruct();
  var_0._id_1F84 = 1;
  var_0._id_5B70 = "offhand_fired";
  var_0._id_887C = 1;
  var_0._id_8CED = 5;
  var_0._id_936C = 0;
  var_0._id_9925 = gettime();
  var_0._id_CF97 = "gesture_script_weapon";
  var_0.streakname = "jackal";
  var_0._id_EA15 = undefined;
  var_0._id_04CC = -1;
  var_0._id_04FE = "s4_ks_gesture_generic_mp";
  var_0.objweapon = makeweapon(var_0._id_04FE);
  return var_0;
}

_id_D899() {
  level._id_41DE = 0;
  level._id_41DC = undefined;
  level._id_A8E8 = [];
  wait 2.0;
  _id_D871();
}

_id_D871() {
  var_0 = getEntArray("flag_primary", "targetname");
  var_1 = getEntArray("flag_secondary", "targetname");

  if(var_0.size + var_1.size == 0) {
    return;
  }
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2[var_2.size] = var_0[var_3];
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2[var_2.size] = var_1[var_3];
  }

  var_4 = [];
  var_4[0] = 10;
  var_4[1] = 20;
  var_4[2] = 30;
  var_5 = [];
  var_5[0] = 0;
  var_5[1] = 0;
  var_5[2] = 0;
  level._id_A8E8 = [];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_6 = 0;

    switch (var_2[var_3]._id_CD99) {
      case "_a":
        var_6 = 0;
        break;
      case "_b":
        var_6 = 1;
        break;
      case "_c":
        var_6 = 2;
        break;
    }

    var_2[var_3]._id_CD99 = undefined;
    level._id_A8E8[var_6] = var_2[var_3];
    var_7 = scripts\mp\gametypes\obj_dom::_id_D896(level._id_A8E8[var_6]);
    var_7 _id_4D48();
    var_7._id_AA79 = ::_id_4D46;
    var_7._id_ABCB = ::_id_4D4F;
    var_7._id_AAC2 = ::_id_4D4A;
    var_7._id_AA8D = ::_id_4D47;
    var_7._id_ABC7 = ::_id_4D4C;
    var_7._id_AAB5 = ::_id_4D48;
    var_7._id_AAC1 = ::_id_4D49;
    var_7._id_AA6E = ::_id_4D45;
    level._id_A8E8[var_6] = var_7;
    level._id_A8E8[var_6]._id_F1E5 = var_6;
    level._id_A8E8[var_6]._id_322D = var_4[var_6];
    level._id_A8E8[var_6]._id_79D4 = var_5[var_6];

    if(var_6 != 0) {
      level._id_A8E8[var_6] scripts\engine\utility::delaythread(2.0, ::_id_4D48);
    }
  }
}

_id_4AA5() {
  scripts\mp\gametypes\obj_dom::_id_FC64("off", 0);
}

_id_5E25() {
  level._id_41DC = level._id_A8E8[level._id_41DE];

  if(isDefined(level._id_41DC)) {
    level._id_41DC[[level._id_41DC._id_AAC1]]();
  }

  thread _id_77B9(0);
  thread _id_77B9(1);
  thread _id_77B9(2);
}

_id_77B9(var_0) {
  var_1 = level._id_5628[var_0];
  var_2 = level._id_13B4[var_0][level._id_13B3];

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  for(var_3 = 1; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_1)) {
      return;
    }
    var_4 = var_2[var_3];
    var_5 = var_4.origin;
    var_1._id_010D = "guard_location";
    var_1 notify(var_1._id_010D);
    var_1 thread _id_0A4F::_id_7257(var_5);

    if(isDefined(var_1)) {
      var_1 waittill("goal");
    }
  }

  if(isDefined(level._id_41DC) && isDefined(level._id_41DC.trigger)) {
    var_1 thread _id_0A4F::_id_7257(undefined, level._id_41DC.trigger);
  }

  if(var_0 == 0) {
    if(isDefined(level._id_41DC)) {
      level._id_41DC[[level._id_41DC._id_AA6E]]();
    } else {
      scripts\mp\gamescore::_id_0CF2("allies", 1, 0);
      thread scripts\mp\gamelogic::_id_52F7("allies", game["end_reason"]["objective_completed"]);
    }

    level._id_13B3++;
  }
}

_id_D5A4(var_0) {
  var_1 = distance(level._id_1DE6.origin, var_0);
  var_2 = var_1 / 150;
  var_3 = 0.25;
  var_4 = 0.25;
  level._id_1DE6 moveto(var_0, var_2, var_3, var_4);
  var_5 = anglesToForward(level._id_1DE6.angles);
  var_6 = vectornormalize(var_0 - level._id_1DE6.origin);
  thread _id_33DD(var_5, var_6, 2.0);
  return var_2;
}

_id_33DD(var_0, var_1, var_2) {
  var_3 = gettime();
  var_4 = var_3;
  var_2 = int(var_2 * 1000);

  for(var_5 = var_4 + var_2; var_3 < var_5; var_3 = gettime()) {
    var_6 = clamp((var_3 - var_4) / var_2, 0.0, 1.0);
    var_7 = _func_025E(var_0, var_1, var_6);
    level._id_1DE6.angles = scripts\mp\utility\script::_id_FFE3(var_7, (0, 0, 1));
    waitframe();
  }
}

_id_4D46(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D50(var_0);
}

_id_4D4F(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);
  var_1 = _id_07D6::_id_6C02();
  var_2 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  thread scripts\mp\utility\print::_id_BD0C(var_1, var_2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);
  thread _id_4D44(var_1);
}

_id_4D4A(var_0, var_1, var_2) {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);
}

_id_4D47() {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D47();
}

_id_4D4C(var_0) {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D4C(var_0);
}

_id_4D48() {
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_4AD1();
  _id_07D6::_id_C60A();
  _id_07D6::_id_C300();
  scripts\engine\utility::delaythread(0.1, ::_id_4AA5);
}

_id_4D49() {
  _id_07D6::_id_C579(1, 1);
  _id_07D6::_id_5260();
  _id_07D6::_id_D8E0("friendly");
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_D61B(level._id_7C4B, level._id_7C8A);
  _id_07D6::_id_D639("axis");
  scripts\mp\gametypes\obj_dom::_id_FC64("axis", 0);
}

_id_4D45() {
  level._id_5C3B = self._id_322D;
  _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  _id_07D6::_id_D8E0("any");
  _id_07D6::_id_15DF("enemy");
}

_id_4D44(var_0) {
  level endon("gameEnded");
  self notify("domPoint_HoldTimer");
  self endon("domPoint_HoldTimer");
  var_1 = level._id_41DC._id_79D4;

  if(var_1 > 0) {
    wait(var_1);

    if(istrue(level._id_3C6A)) {
      var_2 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

      for(;;) {
        if(level._id_41DC._id_F396[var_2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  if(var_0 == "allies") {
    level._id_41DC[[level._id_41DC._id_AAB5]]();
    level._id_41DE++;
    _id_FBFD();
    _id_5E25();
  }
}

_id_FBFD() {
  if(!isDefined(level._id_15B0)) {
    level._id_15B0 = [];
  }

  level._id_15B0["allies"] = [];
  level._id_15B0["axis"] = [];

  if(isDefined(level._id_5628)) {
    level._id_15B0["allies"][level._id_15B0["allies"].size] = "to_air_allies_blackhawk";

    if(isDefined(level._id_5628[1]) && !istrue(level._id_5628[1]._id_E330)) {
      level._id_15B0["allies"][level._id_15B0["allies"].size] = "to_air_allies_ah64_left";
    }

    if(isDefined(level._id_5628[2]) && !istrue(level._id_5628[2]._id_E330)) {
      level._id_15B0["allies"][level._id_15B0["allies"].size] = "to_air_allies_ah64_right";
    }
  }

  switch (level._id_41DE) {
    case 0:
      level._id_15B0["allies"][level._id_15B0["allies"].size] = "to_air_allies_0";
      level._id_15B0["axis"][level._id_15B0["axis"].size] = "to_air_axis_0";
      break;
    case 1:
      level._id_15B0["axis"][level._id_15B0["axis"].size] = "to_air_axis_1";
      break;
    case 2:
      level._id_15B0["axis"][level._id_15B0["axis"].size] = "to_air_axis_2";
      break;
  }

  foreach(var_9, var_1 in level._id_15B0) {
    foreach(var_3 in level._id_ED16._id_0F39[var_9]._id_E269[var_9]) {
      var_4 = 0;

      foreach(var_6 in level._id_15B0[var_9]) {
        if(var_6 == var_3._id_039B) {
          var_4 = 1;
          break;
        }
      }

      var_3._id_523F = var_4;
    }
  }

  level notify("tac_ops_map_changed");
}

_id_54CD(var_0) {
  self waittill("spawned_player");
  self playerlinkto(var_0, "tag_origin");
  self _meth_828F(var_0._id_F81F);
  var_0._id_E330 = 1;
  _id_FBFD();
  thread _id_10AD5(var_0);
  thread _id_10B7B(var_0);
}

_id_10AD5(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("leaving");
  var_0 thread scripts\mp\killstreaks\killstreaks::_id_15CF();
  var_0 waittill("killstreakExit");
  self _meth_8290(var_0._id_F81F);
  var_1 = scripts\engine\utility::_id_B433(var_0.origin, 32, 0, -1500, (0, 0, 1));
  self unlink();
  self dontinterpolate();
  self setorigin(var_1);
  var_2 = anglesToForward(var_0.angles);
  var_2 = var_2 * (1, 1, 0);
  var_3 = (0, 0, 1);
  var_4 = _func_025B(var_2, var_3);
  var_5 = _func_0017(var_2, var_4, var_3);
  self setplayerangles(var_5);
  var_0._id_E330 = 0;
  _id_FBFD();
  self notify("exited_heli");
}

_id_10B7B(var_0) {
  self endon("exited_heli");
  var_0 waittill("death");
  self suicide();
  _id_FBFD();
}

_id_1FF0() {
  level endon("game_ended");
  self waittill("death");
  wait 5.0;
  scripts\mp\gamescore::_id_0CF2("axis", 1, 0);
  thread scripts\mp\gamelogic::_id_52F7("axis", game["end_reason"]["objective_completed"]);
}