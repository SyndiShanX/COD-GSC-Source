/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1864.gsc
*************************************************/

_id_A8EA() {
  scripts\engine\utility::_id_5C11("objective_table_parsed");
  scripts\engine\utility::_id_5C11("objectives_registered");
  level._id_A8F6 = [];
  level._id_0F58 = [];
  level._id_BCD5 = [];
  level._id_CFE7 = [];
  level._id_7E91 = [];
  level._id_5D21 = [];
  level._id_7047 = [];
  level._id_3B21 = [];
  level._id_0F24 = "";
  _id_8246();

  if(scripts\engine\utility::_id_5C0C("strike_init_done")) {
    scripts\engine\utility::_id_5C24("strike_init_done");
  }

  if(isDefined(level._id_A8F3)) {
    [[level._id_A8F3]]();
  } else {
    _id_AE73();
  }

  scripts\engine\utility::_id_5C24("interactions_initialized");

  if(isDefined(level._id_A8E7)) {
    [[level._id_A8E7]]();
  }

  _id_8247();
  scripts\engine\utility::_id_5C1B("objectives_registered");
  level thread _id_A8D6();
}

_id_D898() {
  if(!_id_DACB()) {
    return;
  }
  level thread _id_CA4D();
  level thread _id_CA71();
  level thread _id_CA66();
}

_id_CA4D() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("objectives_registered");
  wait 2;
  var_0 = scripts\engine\utility::random(level._id_BCD5);
  level thread _id_C9E7(var_0, "primary");
}

_id_CA71() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("objectives_registered");
  wait 2;

  if(!isDefined(level._id_CFE7) || !isDefined(level._id_A760) || !level._id_CFE7.size) {
    return;
  }
  var_0 = scripts\engine\utility::_id_1BBD(level._id_CFE7);
  var_1 = int(clamp(var_0.size, 0, level._id_A760));
  var_2 = 0;

  for(;;) {
    while(var_2 < var_1) {
      thread _id_C9E7(var_0[var_2], "secondary");
      var_2++;
    }

    level waittill("secondary_objective_completed");
    var_2--;
  }
}

_id_CA66() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("objectives_registered");
  wait 2;

  if(!level._id_7E91.size) {
    return;
  }
  var_0 = scripts\engine\utility::_id_1BBD(level._id_7E91);
  var_1 = int(clamp(var_0.size, 0, level._id_A762));
  var_2 = 0;

  for(;;) {
    while(var_2 < var_1) {
      thread _id_C9E7(var_0[var_2], "infinite");
      var_2++;
    }

    level waittill("infinite_objective_completed");
    var_2--;
  }
}

_id_DACB() {
  if(level.gametype == "cp_pvpve") {
    return 0;
  }

  return 1;
}

_id_A8D6() {}

_id_AE73(var_0) {
  if(scripts\engine\utility::_id_5C0C("strike_init_done")) {
    scripts\engine\utility::_id_5C24("strike_init_done");
  }

  if(!isDefined(var_0)) {
    var_0 = "cp/cp_default_objectives.csv";
  }

  if(isDefined(level._id_A8F4)) {
    var_1 = level._id_A8F4;
  } else {
    var_1 = undefined;
  }

  var_2 = 0;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, 0);

    if(var_3 == "") {
      break;
    }

    var_4 = spawnStruct();
    var_4.index = int(var_3);
    var_4._id_C189 = _func_0222(var_0, 0, var_3, 1);
    var_4._id_0F01 = _func_0222(var_0, 0, var_3, 2);
    var_4.label = _func_0222(var_0, 0, var_3, 3);
    var_4._id_BEBD = _func_0222(var_0, 0, var_3, 5);
    var_4._id_A902 = _func_0222(var_0, 0, var_3, 6);
    var_4._id_DCCF = int(_func_0222(var_0, 0, var_3, 8));
    var_4._id_F246 = int(_func_0222(var_0, 0, var_3, 9));
    var_4._id_F247 = int(_func_0222(var_0, 0, var_3, 10));
    var_4._id_F248 = int(_func_0222(var_0, 0, var_3, 11));
    var_4._id_2506 = int(_func_0222(var_0, 0, var_3, 25));
    var_4._id_58D9 = _func_0222(var_0, 0, var_3, 24);
    var_4._id_FFC1 = int(_func_0222(var_0, 0, var_3, 12));
    var_4._id_FFC2 = int(_func_0222(var_0, 0, var_3, 13));
    var_4._id_FFC3 = int(_func_0222(var_0, 0, var_3, 14));
    var_4._id_DDAA = int(_func_0222(var_0, 0, var_3, 15));
    var_4._id_B9BE = int(_func_0222(var_0, 0, var_3, 16));
    var_4._id_56DA = int(_func_0222(var_0, 0, var_3, 17));
    var_4._id_A582 = int(_func_0222(var_0, 0, var_3, 18));
    var_4._id_40F0 = _func_0222(var_0, 0, var_3, 26);

    if(isDefined(var_4._id_40F0) && var_4._id_40F0 == "") {
      var_4._id_40F0 = undefined;
    }

    var_4._id_7C7C = _func_0222(var_0, 0, var_3, 7);
    var_4._id_4AB7 = int(_func_0222(var_0, 0, var_3, 27)) >= 1;
    var_4._id_56B7 = _func_0222(var_0, 0, var_3, 31);
    var_4._id_A8E3 = [];

    if(isDefined(var_4._id_56DA) && var_4._id_56DA >= 1) {
      var_4._id_56DA = 1;
    } else {
      var_4._id_56DA = 0;
    }

    switch (var_4._id_BEBD) {
      case "primary":
        level._id_BCD5[level._id_BCD5.size] = var_4._id_C189;
        break;
      case "secondary":
        level._id_CFE7[level._id_CFE7.size] = var_4._id_C189;
        break;
      case "infinite":
        level._id_7E91[level._id_7E91.size] = var_4._id_C189;
        break;
      case "floor":
        level._id_5D21[level._id_5D21.size] = var_4;
        break;
    }

    if(isDefined(var_1)) {
      var_4._id_A4DB = [];
      var_5 = 0;
      var_6 = 1;

      for(;;) {
        var_7 = _func_0222(var_1, var_5, var_4._id_C189, var_6);

        if(var_7 == "") {
          break;
        }

        var_4._id_A4DB[var_4._id_A4DB.size] = var_7;
        var_6++;
      }
    }

    level._id_A8F6[var_4._id_C189] = var_4;
    var_2++;
  }

  scripts\engine\utility::_id_5C1B("objective_table_parsed");
}

_id_BD70(var_0) {
  var_1 = var_0._id_7C7C;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = strtok(var_1, ",");
  var_3 = undefined;

  if(var_2.size == 3) {
    var_3 = (int(var_2[0]), int(var_2[1]), int(var_2[2]));
  } else if(var_2.size == 2) {
    if(isDefined(level._id_EA70[var_2[1]]) && isDefined(level._id_EA70[var_2[1]][var_2[0]])) {
      var_3 = scripts\engine\utility::getstructarray(var_2[0], var_2[1]);
    } else {
      var_3 = getent(var_2[0], var_2[1]);
    }
  }

  if(isDefined(var_3)) {
    if(isvector(var_3)) {
      var_0._id_7C7B = var_3;
      var_0._id_A8E3[var_0._id_A8E3.size] = var_3;
    } else if(_func_0107(var_3)) {
      if(!isDefined(var_0._id_7C7B)) {
        var_0._id_7C7B = [];
      }

      foreach(var_5 in var_3) {
        var_0._id_7C7B[var_0._id_7C7B.size] = var_5.origin;
        var_0._id_A8E3[var_0._id_A8E3.size] = var_5.origin;
        var_0._id_8395 = var_5;
        var_5._id_A8F8 = var_0;
      }
    } else
      var_0._id_7C7B = var_3.origin;
  } else
    var_0._id_7C7B = var_3;
}

_id_D617(var_0, var_1) {
  if(_func_0107(var_1)) {
    var_0._id_A8E3 = var_1;
  } else {
    var_0._id_A8E3 = [];
    var_0._id_A8E3[0] = var_1;
  }
}

_id_6BC1(var_0) {
  if(isDefined(level._id_A8F6[var_0])) {
    return level._id_A8F6[var_0];
  } else {
    return undefined;
  }
}

_id_AD56(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_0._id_A4DB = undefined;
  } else {
    var_0._id_A4DB = [];

    if(_func_0107(var_1)) {
      var_0._id_A4DB = var_1;
      return;
    }

    var_0._id_A4DB[0] = var_1;
  }
}

_id_10B7(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "icon_waypoint_objective_general";
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_0._id_75F3 = thread scripts\cp\utility::_id_546A(var_0, var_2, self._id_41FD, var_1);
  _func_035C(var_0._id_75F3, 1);
  _func_035A(var_0._id_75F3, 0);

  if(!isDefined(self._id_75EF)) {
    self._id_75EF = [];
  }

  self._id_75EF[self._id_75EF.size] = var_0;
  return var_0._id_75F3;
}

_id_C4CD(var_0) {
  thread scripts\cp\utility::_id_546B(var_0, var_0._id_75F3);
  self._id_75EF = scripts\engine\utility::array_remove(self._id_75EF, var_0);
}

_id_C281(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level._id_A8F6[var_0])) {
    return;
  }
  var_9 = level._id_A8F6[var_0];
  var_9.init = var_1;
  var_9._id_E6AF = var_2;
  var_9._id_52F6 = var_3;
  var_9._id_AAAA = var_4;
  var_9._id_AAAB = var_5;
  var_9._id_56C8 = var_7;
  var_9._id_C189 = var_0;
  var_9._id_EA52 = var_6;
  var_9._id_87BA = 0;
  var_9._id_89F4 = 1;
  var_9._id_A910 = var_0;
  _id_3FBD(var_9);
}

_id_A8D2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level notify(var_0 + "_update_instance");
  level endon(var_0 + "_update_instance");
  level endon(var_0 + "_completed");
  level endon(var_0 + "_failed");
  level endon(var_0 + "objective_paused");
  var_8 = undefined;
  var_6 = undefined;
  var_9 = undefined;

  if(isDefined(level._id_A8EB)) {
    var_10 = _id_3448(var_0);

    if(istrue(var_10)) {
      thread _id_56B0(var_0, var_1, var_2, var_3, var_4, var_5);
      return;
    }

    var_8 = int(_func_0222(level._id_A8EB, 1, var_0, 0));
    var_9 = _id_349B(var_0);

    if(istrue(var_9)) {
      _id_C5CB();
    }

    if(!isDefined(var_6)) {
      var_6 = _id_660C(var_0);
    }

    _id_9906(var_0);
  }

  if(!isDefined(level._id_A8EB)) {
    var_8 = int(_func_0222("cp/cp_default_objectives.csv", 1, var_0, 0));
  }

  if(!isDefined(var_8)) {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_11 = 1;
  var_12 = _id_660E(var_0);

  if(isDefined(var_12)) {
    if(var_12 == "global") {
      var_11 = 0;
    }
  }

  if(istrue(var_11)) {
    _id_DC5A();

    switch (var_6) {
      case 1:
        setomnvar("cp_objective_sub_1_index", var_8);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_index", var_8);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_index", var_8);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_index", var_8);
        break;
    }

    if(isDefined(var_5)) {
      switch (var_6) {
        case 1:
          setomnvar("cp_objective_sub_count_1", var_5);
          break;
        case 2:
          setomnvar("cp_objective_sub_count_2", var_5);
          break;
        case 3:
          setomnvar("cp_objective_sub_count_3", var_5);
          break;
        case 4:
          setomnvar("cp_objective_sub_count_4", var_5);
          break;
      }
    }
  }

  if(_func_0205("ui_new_objective_popup")) {
    foreach(var_14 in level.players) {
      var_14 playsoundtoplayer("ui_new_objective_popup", var_14);
    }
  }

  if(isDefined(var_1) && var_1 > 0) {
    setomnvar("cp_countdown_color", 0);
    var_16 = var_6;

    if(istrue(var_7)) {
      var_16 = 5;
    }

    setomnvar("cp_countdown_timer_alpha", var_16);
    setomnvar("cp_countdown_timer", gettime() + var_1 * 1000);

    if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && !isDefined(var_3)) {
      wait(var_1 - var_2);
      setomnvar("cp_countdown_color", 1);
      wait(var_2);
    } else if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && isDefined(var_3) && var_3 < var_2) {
      wait(var_1 - var_2);
      setomnvar("cp_countdown_color", 1);
      wait(var_2 - var_3);
      setomnvar("cp_countdown_color", 2);
      wait(var_3);
    } else
      wait(var_1);

    if(!istrue(var_4)) {
      _id_58D0(var_0);
    } else {
      level notify(var_0 + "_timer_complete");
    }

    _id_C5CC();
  }
}

_id_56B0(var_0, var_1, var_2, var_3, var_4, var_5) {
  level notify(var_0 + "_update_instance");
  level endon(var_0 + "_update_instance");
  level endon(var_0 + "_completed");
  level endon(var_0 + "_failed");
  level endon(var_0 + "objective_paused");
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(level._id_A8EB)) {
    var_6 = int(_func_0222(level._id_A8EB, 1, var_0, 0));
    var_7 = _id_349B(var_0);

    if(istrue(var_7)) {
      _id_C5CB();
    }

    _id_9906(var_0);
  }

  if(!isDefined(level._id_A8EB)) {
    var_6 = int(_func_0222("cp/cp_default_objectives.csv", 1, var_0, 0));
  }

  if(!isDefined(var_6)) {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_8 = 1;
  var_9 = _id_660E(var_0);

  if(isDefined(var_9)) {
    if(var_9 == "global") {
      var_8 = 0;
    }
  }

  if(istrue(var_8)) {
    setomnvar("cp_objective_event_index", var_6);

    if(isDefined(var_5)) {
      setomnvar("cp_objective_event_count", var_5);
    }
  }

  if(_func_0205("iw8_new_objective_sfx")) {
    playsoundatpos((0, 0, 0), "iw8_new_objective_sfx");
  }

  if(isDefined(var_1) && var_1 > 0) {
    setomnvar("cp_countdown_event_color", 0);
    setomnvar("cp_countdown_event_timer_alpha", 1);
    setomnvar("cp_countdown_event_timer", gettime() + var_1 * 1000);

    if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && !isDefined(var_3)) {
      wait(var_1 - var_2);
      setomnvar("cp_countdown_event_color", 1);
      wait(var_2);
    } else if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && isDefined(var_3) && var_3 < var_2) {
      wait(var_1 - var_2);
      setomnvar("cp_countdown_event_color", 1);
      wait(var_2 - var_3);
      setomnvar("cp_countdown_event_color", 2);
      wait(var_3);
    } else
      wait(var_1);

    if(!istrue(var_4)) {
      _id_58D0(var_0);
      _id_C5B4();
    } else
      level notify(var_0 + "_timer_complete");
  } else
    setomnvar("cp_countdown_event_timer_alpha", 0);
}

_id_DC5A() {
  setomnvar("cp_objective_index", 1);
}

_id_78C9() {
  setomnvar("cp_objective_index", 0);
}

_id_660C(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_A8EB)) {
    var_1 = _func_0222(level._id_A8EB, 1, var_0, 29);
  }

  if(isDefined(var_1) && var_1 != "") {
    return int(var_1);
  } else {
    return 1;
  }
}

_id_349B(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_A8EB)) {
    var_1 = _func_0222(level._id_A8EB, 1, var_0, 30);
  }

  if(isDefined(var_1) && var_1 != "") {
    return 1;
  } else {
    return 0;
  }
}

_id_58D0(var_0) {
  level notify(var_0 + "_failed");
  _id_C5CA(var_0);
}

_id_C9E7(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("debug_beat_" + var_0 + "_objective");
  level endon(var_0 + "_failed");

  if(getdvarint("#x351c8b582a4a594e4", 0)) {
    return;
  }
  if(!isDefined(level._id_A8F6[var_0])) {
    return;
  }
  var_3 = level._id_A8F6[var_0];
  var_3._id_A910 = var_0;
  var_3._id_87BA = 0;

  if(isDefined(var_3._id_40F0) && var_3._id_40F0 != "") {
    if(!scripts\engine\utility::_id_5C0C(var_3._id_40F0)) {
      scripts\engine\utility::_id_5C11(var_3._id_40F0);
    }

    if(!scripts\engine\utility::_id_5C00(var_3._id_40F0)) {
      scripts\engine\utility::_id_5C1B(var_3._id_40F0);
    }

    scripts\engine\utility::_id_5C24(var_3._id_40F0 + "_completed");
  }

  _id_BD70(var_3);

  if(!isDefined(var_2)) {
    var_3._id_41FD = "allies";
  } else {
    var_3._id_41FD = var_2;
  }

  if(isDefined(var_1) && var_1 == "primary") {
    var_3._id_165B = 1;
  } else if(isDefined(var_1) && var_1 == "global") {
    var_3._id_165B = 1;
  }

  level thread _id_10B04(var_3, var_0, var_1);
  level thread _id_10B32(var_3, var_0, var_1);
  _id_81E6(var_3, var_0, var_1);
  _id_E6FE(var_3, var_0, var_1);
  _id_3B30(var_3, var_0, var_1);

  if(isDefined(var_1)) {
    level notify(var_1 + "_objective_completed");
  }
}

_id_10B32(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("debug_beat_" + var_1 + "_objective");
  var_0 endon(var_1 + "_completed");
  level waittill(var_1 + "_failed");
  var_3 = var_0._id_C189;

  if(isDefined(var_0._id_7B6A)) {
    _id_4838(var_0._id_7B6A);
  }

  if(isDefined(var_0._id_41FD)) {
    var_0._id_41FD = undefined;
  }

  if(isDefined(var_0._id_75EF)) {
    foreach(var_5 in var_0._id_75EF) {
      var_0 _id_C4CD(var_5);
    }

    var_0._id_75EF = undefined;
  }

  _id_C3BF(var_0);
  _id_9B1E(var_3);
  _id_C5CA(var_3);
  _id_F757(var_0, 0);
}

_id_9B1E(var_0) {
  var_1 = _id_6BC1(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_A8DE;

  if(!isDefined(var_2)) {
    return;
  }
  _func_016B(var_2, "failed");
}

_id_9905(var_0) {
  var_1 = _id_3448(var_0);

  if(!istrue(var_1)) {
    var_2 = _id_660C(var_0);
    var_3 = _id_3461(var_0);

    if(var_3) {
      _id_C5CC();
    }

    switch (var_2) {
      case 1:
        setomnvar("cp_objective_sub_1_complete", 1);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_complete", 1);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_complete", 1);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_complete", 1);
        break;
    }
  } else {
    setomnvar("cp_objective_event_complete", 1);
    _id_C5B4();
  }
}

_id_9906(var_0, var_1) {
  var_1 = _id_3448(var_0);

  if(!istrue(var_1)) {
    var_2 = _id_660C(var_0);
    var_3 = _id_3461(var_0);

    if(var_3) {
      _id_C5CC();
    }

    switch (var_2) {
      case 1:
        setomnvar("cp_objective_sub_1_complete", 0);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_complete", 0);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_complete", 0);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_complete", 0);
        break;
    }
  } else {
    setomnvar("cp_objective_event_complete", 0);
    _id_C5B4();
  }
}

_id_3461(var_0) {
  var_1 = int(_func_0222(level._id_A8EB, 1, var_0, 9));

  if(isDefined(var_1) && var_1 > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_C5CB() {
  setomnvar("cp_objective_sub_1_index", 0);
  setomnvar("cp_objective_sub_count_1", -1);
  setomnvar("cp_objective_sub_2_index", 0);
  setomnvar("cp_objective_sub_count_2", -1);
  setomnvar("cp_objective_sub_3_index", 0);
  setomnvar("cp_objective_sub_count_3", -1);
  setomnvar("cp_objective_sub_4_index", 0);
  setomnvar("cp_objective_sub_count_4", -1);
}

_id_C5CC() {
  setomnvar("cp_countdown_timer", 0);
  setomnvar("cp_countdown_timer_alpha", 0);
  setomnvar("cp_countdown_color", 0);
}

_id_C5B4() {
  setomnvar("cp_countdown_event_timer", 0);
  setomnvar("cp_countdown_event_timer_alpha", 0);
  setomnvar("cp_countdown_event_color", 0);
}

_id_C5EC(var_0) {
  var_1 = _id_660C(var_0);
  setomnvar("cp_objective_sub_" + var_1 + "_index", 0);
  setomnvar("cp_objective_sub_count_" + var_1, -1);
}

_id_3448(var_0) {
  var_1 = int(_func_0222(level._id_A8EB, 1, var_0, 31));

  if(isDefined(var_1) && var_1 == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_C5CA(var_0) {
  var_1 = _id_3448(var_0);

  if(!istrue(var_1)) {
    var_2 = _id_660C(var_0);

    switch (var_2) {
      case 1:
        setomnvar("cp_objective_sub_1_index", 0);
        setomnvar("cp_objective_sub_count_1", -1);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_index", 0);
        setomnvar("cp_objective_sub_count_2", -1);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_index", 0);
        setomnvar("cp_objective_sub_count_3", -1);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_index", 0);
        setomnvar("cp_objective_sub_count_4", -1);
        break;
    }
  } else {
    setomnvar("cp_objective_event_index", 0);
    setomnvar("cp_objective_event_count", -1);
  }
}

_id_10B04(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon(var_1 + "_failed");
  var_0 endon(var_1 + "_completed");
  level waittill("debug_beat_" + var_0._id_A910 + "_objective");
  wait 1;

  if(isDefined(var_0._id_AAAA)) {
    [[var_0._id_AAAA]](var_0);
  }

  if(!var_0._id_87BA) {
    _id_3B30(var_0, var_1, var_2);
  }

  if(isDefined(var_2)) {
    level notify(var_2 + "_objective_completed");
  }
}

_id_44BA(var_0) {
  level notify("debug_beat_" + var_0 + "_objective");
}

_id_3FBD(var_0) {
  if(!isDefined(level._id_3B21)) {
    var_1 = 0;
  } else {
    var_1 = level._id_3B21.size + 1;
  }

  var_2 = "devgui_cmd \"CP Debug:2 / Objectives / Complete / Beat " + var_0._id_A910 + " Objective:" + var_1 + "\" \"set start_objective_debug notify-debug_beat_" + var_0._id_A910 + "_objective\" \n";
  scripts\cp\utility::_id_10A9(var_2);

  if(!istrue(var_0._id_56DA)) {
    var_2 = "devgui_cmd \"CP Debug:2 / Objectives / Start / Start " + var_0._id_A910 + " Objective:" + var_1 + "\" \"set start_objective_debug notify-debug-start_-" + var_0._id_A910 + "-objective\" \n";
    scripts\cp\utility::_id_10A9(var_2);
  }
}

_id_1117(var_0) {}

_id_81E6(var_0, var_1, var_2) {
  level endon("debug_beat_" + var_0._id_A910 + "_objective");
  _id_4574(var_0, var_2);

  if(isDefined(var_0.init)) {
    [[var_0.init]](var_0);
  }

  var_0 notify("objective_initialized");
}

_id_E6FE(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("debug_beat_" + var_0._id_A910 + "_objective");
  _func_03BF("dlog_event_cpdata_level_progression", ["levelname", level.script, "active_objective", var_1, "time_stamp", gettime(), "description", "Started"]);
  level._id_0F58[level._id_0F58.size] = var_0;

  if(level._id_0F24.size <= 0) {
    level._id_0F24 = var_1;
  } else {
    level._id_0F24 = level._id_0F24 + "," + var_1;
  }

  if(isDefined(var_0._id_E6AF)) {
    [[var_0._id_E6AF]](var_0);
  }
}

_id_3B30(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(level._id_BC30, var_0._id_A910)) {
    level._id_BC30 = scripts\engine\utility::array_add(level._id_BC30, var_0._id_A910);
  }

  _id_C3BF(var_0);

  if(isDefined(var_2) && var_2 == "global" && !istrue(_id_0749::_id_85C1(var_0._id_C189))) {
    if(isDefined(var_0._id_7B6A)) {
      _id_4838(var_0._id_7B6A);
    }

    _id_4729(var_0._id_A910);
    return;
  }

  var_0 notify("objective_completed");
  var_0._id_87BA = 1;
  _id_45AA(var_0);
  _id_7DE5();
  _func_03BF("dlog_event_cpdata_level_progression", ["levelname", level.script, "active_objective", var_1, "time_stamp", gettime(), "description", "Completed"]);

  if(isDefined(var_0._id_B9BE) && var_0._id_B9BE > 0) {
    var_3 = var_0._id_B9BE;

    if(level.gametype == "cp_survival") {
      var_3 = 100;
    }

    foreach(var_5 in level.players) {
      var_5 _id_074E::_id_6F28(var_3, "large");
    }
  }

  if(isDefined(var_0._id_52F6)) {
    [[var_0._id_52F6]](var_0);
  }

  _id_F757(var_0, 1);
  level notify(var_1 + "_completed");
  var_0 notify(var_1 + "_completed");
}

_id_4729(var_0) {
  var_1 = _id_6BC1(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_A8DE;

  if(!isDefined(var_2)) {
    return;
  }
  _func_015C(var_2);
}

_id_F757(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(getDvar("#x3a30c33efc8281eb1") == "cp_survival" && var_0._id_BEBD == "primary") {
    if(var_1 && isDefined(var_0._id_A4DB) && var_0._id_A4DB.size > 0) {
      thread _id_C9E7(var_0._id_A4DB[0], var_0._id_BEBD);
    }
  } else if(var_1) {
    if(isDefined(var_0._id_A4DB) && var_0._id_A4DB.size > 0) {
      thread _id_C9E7(scripts\engine\utility::random(var_0._id_A4DB), var_0._id_BEBD);
    }
  }
}

_id_C3BF(var_0) {
  level._id_0F58 = scripts\engine\utility::array_remove(level._id_0F58, var_0);
  var_1 = strtok(level._id_0F24, ",");

  if(var_1.size > 0) {
    var_2 = "";
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(var_5 == var_0._id_C189) {
        continue;
      } else {
        if(var_3 == 0) {
          var_2 = var_5;
        } else {
          var_2 = var_2 + "," + var_5;
        }

        var_3++;
      }
    }

    level._id_0F24 = var_2;
  }
}

_id_5ADC() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level._id_A8F6) {
    if(var_3._id_BEBD == "primary" && !scripts\engine\utility::array_contains(level._id_3B21, var_3) && istrue(var_3._id_89F4) && !istrue(var_3._id_56DA)) {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size <= 0) {
    return;
  } else {
    wait 5;
    thread _id_C9E7(scripts\engine\utility::random(var_1)._id_C189);
  }
}

_id_8246() {}

_id_D5DD(var_0) {}

_id_395F() {}

_id_D61D(var_0, var_1) {}

_id_3960(var_0) {}

_id_2541() {
  level endon("new_objective_chosen");
}

_id_D625(var_0) {
  foreach(var_2 in level._id_A8F6) {
    if(int(var_0) == int(var_2.index)) {
      setomnvar("cp_objective_index", var_0);
      return;
    }
  }

  setomnvar("cp_objective_index", 0);
}

_id_D61E(var_0, var_1) {
  var_0._id_3B20 = 1;
}

_id_3F54(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 1.0;
  }

  var_5 = undefined;

  if(var_1 != "all") {
    var_5 = newteamhudelem(var_1);
  } else {
    var_5 = newhudelem();
  }

  var_5._id_7C8C = level._id_10CC7;
  var_5.x = var_0[0];
  var_5.y = var_0[1];
  var_5._id_050C = var_0[2];
  var_5.team = var_1;
  var_5._id_8864 = 0;
  var_5._id_8A30 = 1;
  level._id_10CC7++;

  if(isDefined(var_2)) {
    var_5 setshader(var_2, level._id_10CCA, level._id_10CCA);
    var_5 _meth_83B2(1, 1);
  }

  if(isDefined(var_3)) {
    var_5.alpha = var_3;
  } else {
    var_5.alpha = level._id_10CC1;
  }

  var_5._id_22AE = var_5.alpha;
  return var_5;
}

_id_4838(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    level thread[[var_1]](var_0);
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    var_0 scripts\engine\utility::_id_108A7(var_2, "destroy_objective_icon");
  } else if(isDefined(var_1)) {
    var_0 waittill("destroy_objective_icon");
  } else if(isDefined(var_2)) {
    wait(var_2);
  }

  var_0 destroy();
}

_id_6F1B() {
  foreach(var_1 in level.players) {
    var_1 _id_0913::_id_6F4F(1);
  }
}

_id_4574(var_0, var_1) {
  if(isDefined(var_0._id_A582) && var_0._id_A582 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  if(!istrue(var_0._id_2506)) {
    var_0._id_2506 = 0;
  }

  if(!istrue(var_0._id_DDAA)) {
    setomnvar("cp_objective_desc_index", 1);

    if(isDefined(var_0._id_F246) && isDefined(var_0._id_F247) && isDefined(var_0._id_F248)) {
      level thread scripts\cp\utility::_id_A8D1(var_0._id_A910, var_0._id_F246, var_0._id_F247, var_0._id_F248, var_2);
    } else if(isDefined(var_0._id_F246) && isDefined(var_0._id_F247)) {
      level thread scripts\cp\utility::_id_A8D1(var_0._id_A910, var_0._id_F246, var_0._id_F247, undefined, var_2);
    } else if(isDefined(var_0._id_F246)) {
      level thread scripts\cp\utility::_id_A8D1(var_0._id_A910, var_0._id_F246, undefined, undefined, var_2);
    } else {
      level thread scripts\cp\utility::_id_A8D1(var_0._id_A910);
    }
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_0._id_A910), var_0._id_A910, undefined);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_0._id_7C7B), var_0._id_7C7B, undefined);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_0._id_0F01), var_0._id_0F01, undefined);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_0.label), var_0.label, undefined);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_0._id_A902), var_0._id_A902, undefined);
  var_8 = scripts\engine\utility::ter_op(isDefined(var_0._id_BEBD), var_0._id_BEBD, undefined);
  var_9 = "icon_regular";

  if(isDefined(var_5) && var_5 == "" || istrue(var_0._id_DDAA)) {
    var_5 = undefined;
  }

  if(isDefined(var_0._id_7C7B) && isDefined(var_0._id_A902)) {
    var_10 = "current";
  } else {
    var_10 = "active";
  }

  var_10 = "current";
  level._id_4194 = var_0._id_A910;

  if(_func_0107(var_4)) {
    var_0._id_A8DF = [];
    _id_0FFC(var_3, var_10, undefined, var_5, var_6, var_7, var_9, var_8, var_0, var_1);

    foreach(var_13, var_12 in var_4) {
      _func_0164(var_0._id_A8DE, var_13, var_12);
      var_0._id_A8DF[var_0._id_A8DF.size] = var_13;
    }
  } else
    _id_0FFC(var_3, var_10, var_4, var_5, var_6, var_7, var_9, var_8, var_0, var_1);
}

_id_45AA(var_0, var_1) {
  thread _id_06F4::_id_FBC9();

  if(isDefined(var_0._id_7B6A)) {
    _id_4838(var_0._id_7B6A);
  }

  if(isDefined(var_0._id_75EF)) {
    foreach(var_3 in var_0._id_75EF) {
      var_0 _id_C4CD(var_3);
    }

    var_0._id_75EF = undefined;
  }

  if(isDefined(var_0._id_A910)) {
    _id_5F56(var_0._id_A910);
    var_5 = var_0._id_A8DE;

    if(isDefined(var_0._id_3B16)) {
      if(isDefined(var_5)) {
        _func_016B(var_5, var_0._id_3B16);
      }
    } else {
      if(isDefined(var_5)) {
        _func_016B(var_5, "done");
      }

      if(isDefined(var_0._id_A8DF)) {
        foreach(var_7 in var_0._id_A8DF) {
          _func_0165(var_0._id_A8DE, var_7);
        }
      }
    }

    if(_id_660E(var_0._id_A910) == "global") {
      _id_4654(var_0._id_A8DE, 0.15);
      var_0 notify(var_0._id_A910 + "_completed");
      level notify("debug_beat_" + var_0._id_A910 + "_objective");
    }

    if(isDefined(var_0._id_41FD)) {
      var_9 = var_0._id_41FD;

      if(_id_4C76(var_9)) {
        if(!isDefined(var_0._id_A4DB) || var_0._id_A4DB.size <= 0) {
          _id_1045(var_0, var_9);
          _id_46F8(var_9);
        } else
          _id_1045(var_0, var_9);
      } else if(isDefined(var_0._id_A4DB))
        _id_1045(var_0, var_9);
      else {
        _func_015C(var_5);
      }

      var_0._id_41FD = undefined;
    }

    _id_9905(var_0._id_C189);
  }

  if(istrue(var_1) || istrue(var_0._id_354A)) {
    _id_3548();
  }

  if(istrue(var_1) || istrue(var_0._id_354A)) {
    _id_6F1B();
  }

  foreach(var_11 in level._id_3B21) {}

  level._id_3B21[level._id_3B21.size] = var_0;
}

_id_4C76(var_0) {
  return isDefined(level._id_41FE) && isDefined(level._id_41FE[var_0]) && level._id_41FE[var_0].size > 0;
}

_id_1045(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level._id_41FE)) {
    level._id_41FE = [];
  }

  if(!isDefined(level._id_41FE[var_1])) {
    level._id_41FE[var_1] = [];
  }

  level._id_41FE[var_1][level._id_41FE[var_1].size] = var_0;
}

_id_46F8(var_0) {
  if(!isDefined(level._id_41FE) || !isDefined(level._id_41FE[var_0])) {
    return;
  }
  foreach(var_2 in level._id_41FE[var_0]) {
    _func_015C(var_2._id_A8DE);
  }
}

_id_4654(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1)) {
    wait(var_1);
  }

  _func_015C(var_0);
}

_id_3548() {
  foreach(var_1 in level.players) {
    if(_id_073B::_id_B4EF(var_1)) {
      var_1 _id_073B::_id_8302(var_1);

      if(isDefined(var_1._id_4CDE)) {
        var_1._id_4CDE delete();
      }
    }
  }
}

_id_0FFC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 20;

  if(var_7 == "global") {
    var_10 = 15;
  }

  var_11 = _id_C583(var_0, var_10);
  _id_0B1B(var_11, var_1, var_2, var_5, var_6);

  if(isDefined(var_7) && var_7 != "primary" && isDefined(var_2)) {
    if(var_7 != "global") {
      level thread _id_10B2F(var_11, var_2, var_8);
    }
  }

  _id_A8B1(var_11, 1);

  if(isDefined(var_3)) {
    if(isDefined(level._id_4B6B)) {
      level thread[[level._id_4B6B]](var_0, var_3, var_8._id_41FD, 5);
    }

    _func_0171(var_11, var_3);
  }

  if(isDefined(var_4)) {
    _func_0167(var_11, var_4);
  }

  _func_0170(var_11, "allies");
  _func_0176(var_11, 1);
  _func_017A(var_11, 0);
  _func_0178(var_11, 1);
  _func_0175(var_11, 1);

  if(isDefined(var_8._id_4AB7)) {
    _func_018E(var_11, var_8._id_4AB7);
  }

  if(!isDefined(var_2)) {
    _func_016B(var_11, "invisible");
  }

  var_8._id_A904 = var_11;
  var_8._id_7C73 = var_8._id_A910;
  var_8._id_A8DE = var_11;

  if(istrue(var_8._id_DCCF)) {
    _id_A8C4(var_8._id_A8DE, 1);

    if(_id_660E(var_8._id_A910) == "global") {
      var_8._id_DCCF = var_8._id_DCD0;
    }

    if(var_8._id_DCCF > 1) {
      _id_A8B4(var_8._id_A8DE, 0);
      var_8 thread _id_E714(var_8, var_8._id_DCCF);
    } else if(var_8._id_DCCF < -1) {
      _id_A8B4(var_8._id_A8DE, 1);
      var_8 thread _id_E714(var_8, var_8._id_DCCF * -1, 1);
    }
  }
}

_id_E714(var_0, var_1, var_2) {
  level endon("debug_beat_" + var_0._id_A910 + "_objective");
  var_0 endon(var_0._id_A910 + "_completed");
  var_0 endon("stop_timer");

  if(var_1 > 3) {
    var_1 = var_1 - 3;
    wait 3;
  }

  var_3 = 0;
  var_4 = 1;

  if(istrue(var_2)) {
    var_3 = 1;
    var_4 = 0;
  }

  var_5 = 0;
  var_6 = 0.1;
  var_7 = gettime() + var_1 * 1000;
  _id_A8B4(var_0._id_A8DE, var_3);

  while(gettime() < var_7) {
    if(!istrue(var_2)) {
      _id_A8B4(var_0._id_A8DE, var_5 / var_1);
    } else {
      _id_A8B4(var_0._id_A8DE, 1 - var_5 / var_1);
    }

    if(!isDefined(var_0._id_AF63)) {
      var_5 = var_5 + var_6;
    } else {
      var_7 = var_7 + 1000 * var_6;
    }

    if(var_5 <= 0) {
      break;
    }

    wait(var_6);
  }

  _id_A8B4(var_0._id_A8DE, var_4);
}

_id_D298(var_0) {
  var_0._id_A3F2[var_0._id_A3F2.size] = self;
}

_id_DC74(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("objective_completed");
  var_2 endon("stop_watching");
  var_4 = 0;
  _id_9F14(var_0);
  _id_9F0E(var_0, 0);

  if(isDefined(var_3)) {
    var_5 = var_3 * var_3;
  } else {
    var_5 = 1048576;
  }

  var_2._id_DCF4 = 0;

  for(;;) {
    if(istrue(var_2._id_DCF4)) {
      if(!var_4) {
        var_4 = 1;
        _id_9F16(var_0);
      }
    } else if(istrue(var_2._id_78FA)) {
      if(var_4) {
        var_4 = 0;
        _id_9F14(var_0);
      }
    } else {
      _id_9F0E(var_0, 0);
      var_2._id_A3F2 = [];
      var_6 = scripts\engine\utility::_id_6369(var_1, level.players, undefined, undefined, var_5);
      scripts\engine\utility::_id_1B98(var_6, ::_id_D298, var_2);
      var_4 = 0;

      foreach(var_8 in level.players) {
        if(istrue(var_8._id_4A2B)) {
          _id_A8B2(var_0, 0);
          _id_9F13(var_0, var_8);
          continue;
        }

        if(var_8 scripts\cp\utility::_id_8708() && distancesquared(var_8.origin, var_1) <= var_5) {
          _id_A8B1(var_0, 0);
          _id_9F15(var_0, var_8);
          continue;
        }

        _id_A8B2(var_0, 0);
        _id_9F13(var_0, var_8);
      }
    }

    var_2 scripts\engine\utility::_id_108A7(0.5, "update_nearby_thread");
  }
}

_id_10B2F(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("objective_completed");
  var_2 endon("stop_watching");
  var_4 = 0;
  _id_9F14(var_0);

  if(isDefined(var_3)) {
    var_5 = var_3 * var_3;
  } else {
    var_5 = 1056784;
  }

  for(;;) {
    while(!istrue(var_2._id_DCF4) && !scripts\cp\utility::_id_190A(var_1, var_5)) {
      if(var_4) {
        _id_9F14(var_0);
        var_4 = 0;
      }

      var_2 scripts\engine\utility::_id_108A7(0.5, "update_nearby_thread");
    }

    if(!var_4) {
      var_4 = 1;
      _id_9F16(var_0);
    }

    var_2 scripts\engine\utility::_id_108A7(0.5, "update_nearby_thread");
  }
}

_id_F9B4(var_0) {
  for(var_1 = 0; var_1 <= 7; var_1++) {
    _func_0165(var_0, var_1);
  }
}

_id_8247() {
  var_0 = spawnStruct();
  var_0._id_0026 = [];
  var_0._id_C112 = [];
  var_0.index = 0;
  level._id_9F27 = var_0;
  var_1 = spawnStruct();
  var_1._id_0026 = [];
  var_1._id_C112 = [];
  var_1.index = 0;
  level._id_10F4E = var_1;
}

_id_C57A(var_0) {
  var_1 = _id_6B86(var_0);

  if(var_1 == -1) {
    return -1;
  }

  var_2 = spawnStruct();
  var_2._id_BD27 = var_0;
  var_2._id_C582 = gettime();
  var_2._id_A906 = var_1;
  level._id_9F27._id_0026[var_1] = var_2;
  return var_1;
}

_id_C477(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_9F27._id_0026) {
    if(var_3._id_BD27 <= var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  scripts\engine\utility::_id_1BD6(var_1, ::_id_3AFC);
  return _id_C798(var_1[0]._id_A906);
}

_id_3AFC(var_0, var_1) {
  if(var_0._id_BD27 == var_1._id_BD27) {
    return var_0._id_C582 < var_1._id_C582;
  } else {
    return var_0._id_BD27 < var_1._id_BD27;
  }
}

_id_6B86(var_0) {
  if(level._id_9F27.index == 32) {
    if(!_id_C477(var_0)) {
      return -1;
    }
  }

  if(!level._id_9F27._id_C112.size) {
    if(level._id_9F27.index == 32) {
      return -1;
    } else {
      var_1 = level._id_9F27.index;
      level._id_9F27.index++;
    }
  } else {
    var_1 = level._id_9F27._id_C112[level._id_9F27._id_C112.size - 1];
    level._id_9F27._id_C112[level._id_9F27._id_C112.size - 1] = undefined;
  }

  return var_1;
}

_id_C798(var_0) {
  if(!isDefined(var_0) || var_0 == -1) {
    return 0;
  }

  for(var_1 = 0; var_1 < level._id_9F27._id_C112.size; var_1++) {
    if(var_0 == level._id_9F27._id_C112[var_1]) {
      return 0;
    }
  }

  level._id_9F27._id_0026[var_0] = undefined;
  _func_015C(var_0);
  level._id_9F27._id_C112[level._id_9F27._id_C112.size] = var_0;
  return 1;
}

_id_C583(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  var_2 = _id_6B95(var_1);

  if(var_2 == -1) {
    return undefined;
  }

  var_3 = spawnStruct();
  var_3._id_C582 = gettime();
  var_3._id_A906 = var_2;
  var_3._id_7C92 = var_0;
  level._id_10F4E._id_0026[var_2] = var_3;
  level notify("worldObjIDPool_requested", var_0, var_2);
  return var_2;
}

_id_5F56(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level._id_10F4E._id_0026) {
    if(var_2._id_7C92 == var_0) {
      _id_F9B4(var_2._id_A906);
      _id_83DD(var_2._id_A906);
    }
  }
}

_id_5F57(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level._id_10F4E._id_0026) {
    if(var_2._id_A906 == var_0) {
      _id_F9B4(var_2._id_A906);
      _id_83DD(var_2._id_A906);
    }
  }
}

_id_C47A(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_10F4E._id_0026) {
    if(var_3._id_BD27 < var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  scripts\engine\utility::_id_1BD6(var_1, ::_id_3AFC);
  return _id_83DD(var_1[0]._id_A906);
}

_id_6B95(var_0) {
  if(level._id_10F4E.index == 32) {
    if(!_id_C47A(var_0)) {
      return -1;
    }
  }

  if(level._id_10F4E._id_C112.size <= 0) {
    if(level._id_10F4E.index == 32) {
      return -1;
    } else {
      var_1 = level._id_10F4E.index;
      level._id_10F4E.index++;
    }
  } else {
    var_1 = level._id_10F4E._id_C112[level._id_10F4E._id_C112.size - 1];
    level._id_10F4E._id_C112[level._id_10F4E._id_C112.size - 1] = undefined;
  }

  return var_1;
}

_id_83DD(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0;

  for(var_2 = 0; var_2 < level._id_10F4E._id_C112.size; var_2++) {
    if(var_1 == level._id_10F4E._id_C112[var_2]) {
      return 0;
    }
  }

  _func_015C(var_1);
  level notify("objective_id_reclaimed_" + var_1);
  level._id_10F4E._id_0026[var_1] = undefined;
  level._id_10F4E._id_C112[level._id_10F4E._id_C112.size] = var_1;
  return 1;
}

_id_864A(var_0) {
  foreach(var_2 in level._id_0F58) {
    if(var_2._id_C189 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_0B1B(var_0, var_1, var_2, var_3, var_4) {
  _func_015C(var_0);

  if(isDefined(var_1)) {
    _func_016B(var_0, var_1);
  }

  if(isDefined(var_2)) {
    _func_0163(var_0, var_2);
  }

  if(isDefined(var_3) && var_3 != "") {
    _func_015D(var_0, var_3);
  }

  if(isDefined(var_4)) {
    _func_0179(var_0, var_4);
  }
}

_id_9F0A(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }
  _id_0B1B(var_0, var_1, var_2, var_3, var_4);
}

_id_9F1B(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016B(var_0, var_1);
}

_id_9F18(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0163(var_0, var_1);
}

_id_9F0B(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_015D(var_0, var_1);
}

_id_9F19(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017A(var_0, var_1);
}

_id_9F0C(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0160(var_0, var_1);
}

_id_9F0D(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0160(var_0, var_1);
  _func_0177(var_0, 1);
}

_id_9F1A(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0161(var_0, var_1);
}

_id_9F11(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);
  _func_0185(var_0, var_1);
  _func_018C(var_0);
}

_id_9F1C(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);
  _func_0187(var_0, var_1);
  _func_018C(var_0);
}

_id_9F14(var_0) {
  if(var_0 == -1) {
    return;
  }
  _func_0188(var_0);
  _func_018D(var_0);
}

_id_9F13(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018C(var_0);
  _func_0189(var_0, var_1);
}

_id_9F15(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018C(var_0);
  _func_0185(var_0, var_1);
}

_id_9F16(var_0) {
  if(var_0 == -1) {
    return;
  }
  _func_0188(var_0);
  _func_018C(var_0);
}

_id_9F17(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);

  if(level.teambased) {
    _func_0187(var_0, var_1.team);
  } else {
    _func_0185(var_0, var_1);
  }

  _func_018C(var_0);
}

_id_9F12(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);

  if(level.teambased) {
    _func_0187(var_0, var_1.team);
  } else {
    _func_0185(var_0, var_1);
  }

  _func_018D(var_0);
}

_id_9F1D(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0187(var_0, var_1);
  _func_018C(var_0);
}

_id_9F1E(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018A(var_0, var_1);
  _func_018C(var_0);
}

_id_9F0E(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016C(var_0, var_1);
}

_id_9F10(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016F(var_0, var_1);
}

_id_9F20(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0170(var_0, var_1);
}

_id_9F0F(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016D(var_0, var_1);
}

_id_9F1F(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016E(var_0, var_1);
}

_id_A8AD(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0174(var_0, var_1);
}

_id_A8C4(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017B(var_0, var_1);
}

_id_A8C5(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017E(var_0, var_1);
}

_id_A87B(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017F(var_0, var_1);
}

_id_A8C3(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017C(var_0, var_1);
}

_id_A87A(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017D(var_0, var_1);
}

_id_A8B4(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0180(var_0, var_1);
}

_id_A8B6(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0184(var_0, var_1);
}

_id_A8B5(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0183(var_0, var_1);
}

_id_A8B1(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0172(var_0, var_1);
}

_id_A8B2(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0173(var_0, var_1);
}

_id_A8B7(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0175(var_0, var_1);
}

_id_FB8E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(level._id_A8F6[var_0])) {
    return;
  }
  var_10 = level._id_A8F6[var_0];
  var_11 = level._id_A8F6[var_0]._id_A8DE;

  if(isDefined(var_8) && var_8) {
    _func_015C(var_11);
  }

  if(isDefined(var_9)) {
    _func_0173(var_11, var_9);
  }

  if(isDefined(var_8)) {
    _func_0172(var_11, var_8);
  }

  if(isDefined(var_1)) {
    _func_016B(var_11, var_1);
  }

  if(isDefined(var_2)) {
    _func_0163(var_11, var_2);
  }

  if(isDefined(var_3)) {
    _func_0171(var_11, var_3);
  }

  if(isDefined(var_5)) {
    if(var_5 > 8) {
      var_5 = 8;
    }

    if(var_5 < 1) {
      var_5 = 1;
    }

    setomnvar("cp_objective_desc_index", var_5);
  }

  if(isDefined(var_4)) {
    _func_0167(var_11, var_4);
  }

  if(isDefined(var_6)) {
    _func_015D(var_11, var_6);
  }

  if(isDefined(var_7)) {
    _func_017A(var_11, var_7);
  }

  _id_D625(0);
  wait 0.5;
  _id_D625(var_10.index);
}

_id_6BBD(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_9AA6)) {
    var_1 = [[level._id_9AA6]](level._id_5D21, var_0);
  } else {
    var_1 = scripts\engine\utility::random(level._id_5D21);
  }

  thread _id_C9E7(var_1._id_C189, var_1._id_BEBD);
}

_id_62F6() {
  return level._id_0F58;
}

_id_660E(var_0) {
  if(!isDefined(level._id_A8F6)) {
    return;
  }
  foreach(var_2 in level._id_A8F6) {
    if(var_2._id_C189 == var_0) {
      if(isDefined(var_2._id_BEBD)) {
        return var_2._id_BEBD;
      }
    }
  }

  return undefined;
}

_id_3EDD(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::_id_6C61(var_0);
  var_5 = [];

  foreach(var_7 in var_4) {
    var_5[var_5.size] = _id_3EDC(var_7, var_1, var_2, var_3);
    wait 0.5;
  }

  return var_5;
}

_id_3EDC(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_0F38)) {
    level._id_0F38 = [];
  }

  var_4 = spawnStruct();
  var_4._id_E83C = [];
  var_4._id_E83D = [];
  var_5 = scripts\engine\utility::getstructarray(var_1, "script_noteworthy");

  if(var_5.size <= 0) {
    return undefined;
  }

  var_5 = scripts\engine\utility::_id_1BD6(var_5, ::_id_3AF2);

  foreach(var_7 in var_5) {
    var_8 = var_4._id_E83C.size;
    var_4._id_E83C[var_8] = var_7.origin;

    if(isDefined(var_7._id_03A0)) {
      var_4._id_E83D[var_8] = _func_0219(var_7._id_03A0);
    }
  }

  var_4._id_7C8C = _id_C583("breadcrumb_for_" + var_0.name, 2);

  if(isDefined(var_3) && var_3 != "") {
    var_4._id_7C73 = var_3;
  } else {
    var_4._id_7C73 = "icon_waypoint_objective_general";
  }

  if(isDefined(var_2)) {
    var_4.label = var_2;
  }

  var_4.player = var_0;
  var_8 = 0;

  if(isDefined(level._id_2B74)) {
    var_8 = [[level._id_2B74]](var_4);
  }

  _id_FB40(var_4, var_8);
  var_4 thread _id_10B3F(var_8);
  level._id_0F38[level._id_0F38.size] = var_4;
  return var_4;
}

_id_3AF2(var_0, var_1) {
  return int(var_0._id_0481) < int(var_1._id_0481);
}

_id_10B3F(var_0) {
  level endon("game_ended");
  self endon("breadcrumb_finished");
  var_1 = self.player;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  var_3 = self._id_E83C.size;
  var_4 = 90000;

  while(var_2 < var_3 && isPlayer(self.player)) {
    if(distancesquared(var_1.origin, self._id_E83C[var_2]) <= _id_6387(self, var_2)) {
      var_2++;

      if(var_2 >= var_3) {
        level notify("finished_last_breadcrumb", var_1);
        level _id_4700(self);
      } else
        _id_FB40(self, var_2);

      waitframe();
      continue;
    } else if(distancesquared(var_1.origin, self._id_E83C[var_3 - 1]) <= _id_6387(self, var_3 - 1)) {
      level notify("finished_last_breadcrumb", var_1);
      level _id_4700(self);
    }

    wait 0.1;
  }
}

_id_6387(var_0, var_1) {
  if(isDefined(var_0._id_E83D[var_1])) {
    return var_0._id_E83D[var_1];
  }

  return 90000;
}

_id_FB40(var_0, var_1) {
  if(!isPlayer(var_0.player) || !isDefined(var_0) || !isDefined(var_0._id_E83C[var_1])) {
    return 0;
  }

  _func_015C(var_0._id_7C8C);
  waitframe();

  if(isDefined(var_0.label)) {
    _func_0167(var_0._id_7C8C, var_0.label);
  }

  _func_0163(var_0._id_7C8C, var_0._id_E83C[var_1]);
  _func_015D(var_0._id_7C8C, var_0._id_7C73);
  _func_017A(var_0._id_7C8C, 1);

  foreach(var_3 in level.players) {
    if(var_3 != var_0.player) {
      _func_0189(var_0._id_7C8C, var_3);
      continue;
    }

    _func_0185(var_0._id_7C8C, var_3);
  }

  _func_016B(var_0._id_7C8C, "current");
}

_id_4700(var_0) {
  _func_015C(var_0._id_7C8C);
  _id_83DD(var_0._id_7C8C);
  var_0 notify("breadcrumb_finished");

  if(scripts\engine\utility::array_contains(level._id_0F38, var_0)) {
    level._id_0F38 = scripts\engine\utility::array_remove(level._id_0F38, var_0);
  }
}

_id_4701(var_0) {
  foreach(var_2 in var_0) {
    _id_4700(var_2);
  }
}

_id_A88E(var_0) {
  _func_016B(var_0, "current");
  _func_0178(var_0, 1);
  _func_0179(var_0, "icon_regular");
  level notify("objective_minimapUpdate");
}

_id_6F1C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "minor_objective";
  }

  foreach(var_2 in level.players) {
    var_2 thread _id_0756::giverankxp(var_0, _id_0756::getscoreinfovalue(var_0));
  }
}

_id_7DE5() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.pers["periodic_xp_participation"])) {
      var_1.pers["periodic_xp_participation"]++;
      continue;
    }

    var_1.pers["periodic_xp_participation"] = 1;
  }
}

_id_BBBA(var_0) {
  var_1 = _id_6BC1(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(level._id_A8F6) && isDefined(level._id_A8F6[var_1._id_A910])) {
    var_2 = level._id_A8F6[var_1._id_A910].index;
    var_3 = level._id_A8F6[var_1._id_A910]._id_58D9;

    if(isDefined(var_3) && var_3 != "") {
      foreach(var_5 in level.players) {
        var_5 setclientomnvar("ui_cp_mission_fail_index", var_2);
      }

      return;
    }

    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_cp_mission_fail_index", 0);
    }

    return;
  } else {
    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_cp_mission_fail_index", 0);
    }
  }
}