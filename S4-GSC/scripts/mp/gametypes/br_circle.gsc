/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_circle.gsc
*************************************************/

_id_8160() {
  if(scripts\mp\gametypes\br_gametypes::_id_8853("circle")) {
    level._id_2A1D = 1;
    return;
  }

  if(!isDefined(level._id_2A73)) {
    return;
  }
  level._id_2A1B = spawnStruct();
  level._id_2A1B._id_9AAA = level._id_2A73._id_2A78;

  if(level.mapname == "mp_quarry2" || level.mapname == "mp_prison" || level.mapname == "mp_lumber") {
    level._id_2A1B._id_4330 = [9, 9, 9, 9, 9];
  } else {
    level._id_2A1B._id_4330 = [9, 9, 9, 9, 9, 9, 9, 9];
  }

  var_0 = _func_0093("#x3af4a037d67f904c9", (0, 0, 0));

  if(length(var_0) > 0) {
    level._id_2A1B._id_2A45 = var_0;
  }

  setomnvar("ui_br_minimap_radius", level._id_2A73._id_2A24[0]);
  level._id_2A1B._id_372F = -1;
  _id_0C9D();
}

_id_6D02() {
  if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_CACA)) {
    return (level._id_2A1B._id_CACA.origin[0], level._id_2A1B._id_CACA.origin[1], 0);
  } else {
    return (0, 0, 0);
  }
}

_id_6D03() {
  if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_CACA)) {
    return level._id_2A1B._id_CACA.origin[2];
  } else {
    return 0;
  }
}

_id_69C5() {
  if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_433D)) {
    return (level._id_2A1B._id_433D.origin[0], level._id_2A1B._id_433D.origin[1], 0);
  } else {
    return (0, 0, 0);
  }
}

_id_69C6() {
  if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_433D)) {
    return level._id_2A1B._id_433D.origin[2];
  } else {
    return 0;
  }
}

_id_6B8C() {
  var_0 = level._id_2A1B._id_372F + 2;

  if(var_0 < level._id_2A73._id_2A1F.size) {
    return level._id_2A73._id_2A1F[var_0];
  } else {
    return undefined;
  }
}

_id_6B8D() {
  var_0 = level._id_2A1B._id_372F + 2;

  if(var_0 < level._id_2A73._id_2A25.size) {
    return level._id_2A73._id_2A25[var_0];
  } else {
    return undefined;
  }
}

_id_31D1() {
  return isDefined(level._id_2A1B._id_CACA) && !istrue(level._id_2A1B._id_CACA.hidden);
}

_id_31CB() {
  return isDefined(level._id_2A1B._id_433D) && !istrue(level._id_2A1B._id_433D.hidden);
}

_id_B671() {
  return !istrue(self._id_10A14) && !istrue(self._id_7263) && !istrue(self._id_7262) && _id_31CB();
}

_id_3166(var_0) {
  return var_0 _id_B671() && !istrue(var_0._id_82E1);
}

_id_F755() {
  var_0 = self;

  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(var_0._id_2B46) && gettime() < var_0._id_2B46) {
    return;
  }
  var_0._id_2B46 = gettime() + randomintrange(5000, 7000);

  if(!isai(var_0)) {
    var_0 playlocalsound("gas_player_cough");
  }

  var_1 = "allies_male_cough";
  var_2 = scripts\mp\gametypes\br_public::_id_2BBB(var_0);
  var_3 = var_0._id_AC3D._id_6285;

  if(var_2 == "axis") {
    if(isDefined(var_3) && var_3 == "female") {
      var_1 = "axis_female_cough";
    } else {
      var_1 = "axis_male_cough";
    }
  } else if(isDefined(var_3) && var_3 == "female")
    var_1 = "allies_female_cough";
  else {
    var_1 = "allies_male_cough";
  }

  var_4 = randomint(game["dialogue"][var_1].size);
  var_5 = game["dialogue"][var_1][var_4];
  var_0 _meth_827E(var_5);
}

_id_3729() {
  level endon("game_ended");

  while(level._id_2A1B._id_372F < 0) {
    waitframe();
  }

  var_0 = getdvarfloat("#x35c1f014a34d9a6f7", 2400.0);

  for(;;) {
    if(isDefined(level._id_2A1B._id_433D)) {
      var_1 = level._id_2A1B._id_372F;

      if(var_1 > level._id_2A1B._id_4330.size - 1) {
        var_1 = level._id_2A1B._id_4330.size - 1;
      }

      var_2 = level._id_2A1B._id_4330[var_1];

      if(isDefined(level._id_3728)) {
        var_2 = var_2 * level._id_3728;
      }

      if(var_2 > 0) {
        var_3 = _id_69C5();
        var_4 = _id_69C6();

        foreach(var_6 in level.players) {
          if(!isDefined(var_6) || !isDefined(var_6.origin)) {
            continue;
          }
          if(distance2dsquared(var_3, var_6.origin) > var_4 * var_4) {
            if(_id_3166(var_6)) {
              var_6 _id_FC8D(1);

              if(_id_0792::_id_7567(var_6)) {
                if(!istrue(var_6._id_61D4)) {
                  var_6 notify("toggle_gasmask");
                }

                var_6 _id_0792::_id_BD65(var_2);
              } else {
                var_6 dodamage(var_2, var_6.origin, var_6, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

                if(var_6 scripts\mp\gametypes\br_public::_id_753A()) {
                  var_6 scripts\mp\gametypes\br_public::_id_42E2(var_2);
                }

                var_6 _id_F755();
              }
            }

            continue;
          }

          var_6 _id_FC8D(0);

          if(_id_0792::_id_7567(var_6)) {
            if(istrue(var_6._id_61D4)) {
              var_6 notify("toggle_gasmask");
            }
          }
        }

        var_8 = var_4 + var_0;
        scripts\mp\gametypes\br_plunder::_id_433F(var_3, var_8);
        scripts\mp\gametypes\br_respawn::_id_433F(var_3, var_8);
        scripts\mp\gametypes\br_quest_util::_id_433F(var_3, var_4, var_8);
        scripts\mp\gametypes\br_armory_kiosk::_id_433F(var_3, var_8);
        scripts\mp\gametypes\br_vehicles::_id_433F(var_3, var_4);
        scripts\mp\gametypes\br_pickups::_id_433F(var_3, var_4);
      }
    }

    wait 1;
  }
}

_id_FC8D(var_0) {
  if(!isDefined(self._id_88BA)) {
    self._id_88BA = var_0;
    self._id_8FAB = gettime();
  }

  if(self._id_88BA != var_0) {
    self._id_88BA = var_0;
    var_1 = gettime();

    if(var_0) {
      _id_07BC::_id_E68C("alive_in_gas");
      scripts\mp\gametypes\br_analytics::_id_2AE4(self, var_1 - self._id_8FAB);
    } else {
      _id_07BC::_id_E901("alive_in_gas");
      scripts\mp\gametypes\br_analytics::_id_2AE5(self, var_1 - self._id_8FAB);
    }

    self._id_8FAB = var_1;
  }
}

_id_E735(var_0, var_1, var_2) {
  level endon("game_ended");
  setomnvar("ui_hardpoint_timer", gettime() + int(var_0 * 1000));

  if(!var_1) {
    foreach(var_4 in level.players) {
      if(!isbot(var_4) && !var_4 scripts\mp\gametypes\br_public::_id_8990()) {
        if(istrue(var_2)) {
          var_4 thread scripts\mp\hud_message::showsplash("br_final_circle");
          continue;
        }

        var_4 thread scripts\mp\hud_message::showsplash("br_new_circle");
      }
    }
  }

  if(istrue(var_2)) {
    setomnvar("ui_br_circle_state", 3);
  } else {
    setomnvar("ui_br_circle_state", 0);
  }

  var_6 = [60, 30, 20, 10, 0];
  var_7 = var_6.size - 1;

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    if(var_0 > var_6[var_8]) {
      var_7 = var_8;
      break;
    }
  }

  if(var_0 < var_6[var_7]) {
    return;
  }
  wait(var_0 - var_6[var_7]);

  for(var_8 = var_7; var_8 < var_6.size - 1; var_8++) {
    if(var_8 == 3) {
      setomnvar("ui_br_circle_state", 2);
    }

    wait(var_6[var_8] - var_6[var_8 + 1]);
  }

  foreach(var_4 in level.players) {
    if(!isbot(var_4) && !var_4 scripts\mp\gametypes\br_public::_id_8990()) {
      var_4 thread scripts\mp\hud_message::showsplash("br_circle_moving");
      var_4 playlocalsound("br_circle_closing");
    }
  }

  setomnvar("ui_br_circle_state", 1);
}

_id_0C27() {
  var_0 = self;
  var_0 setclientomnvar("ui_br_circle0_start_time", 0);
}

_id_D689(var_0) {
  foreach(var_2 in level.players) {
    if(!isbot(var_2)) {
      var_2 setclientomnvar("ui_br_circle0_start_entity", var_0);
      var_2 setclientomnvar("ui_br_circle0_end_entity", var_0);
    }
  }
}

_id_D6ED(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isbot(var_5)) {
      var_6 = _id_0CD1(var_5, var_0);
      var_5 setclientomnvar("ui_br_circle0_start_time", gettime());
      var_5 setclientomnvar("ui_br_circle0_duration", var_6);
      var_5 setclientomnvar("ui_br_circle0_start_entity", var_1);
      var_5 setclientomnvar("ui_br_circle0_end_entity", var_1);

      if(istrue(var_3)) {
        var_5 _id_0C27();
      }

      var_6 = _id_0BB0(var_5, var_0);
      var_5 setclientomnvar("ui_br_circle1_start_time", gettime());
      var_5 setclientomnvar("ui_br_circle1_duration", var_6);
      var_5 setclientomnvar("ui_br_circle1_start_entity", var_2);
      var_5 setclientomnvar("ui_br_circle1_end_entity", var_2);
    }
  }

  thread _id_FC2D(var_0, var_1, var_2);
}

_id_D4D6(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isbot(var_5)) {
      var_6 = _id_0CD1(var_5, var_0);
      var_5 setclientomnvar("ui_br_circle0_start_time", gettime());
      var_5 setclientomnvar("ui_br_circle0_duration", var_6);
      var_5 setclientomnvar("ui_br_circle0_start_entity", var_1);
      var_5 setclientomnvar("ui_br_circle0_end_entity", var_1);

      if(istrue(var_3)) {
        var_5 _id_0C27();
      }

      var_6 = _id_0BB0(var_5, var_0);
      var_5 setclientomnvar("ui_br_circle1_start_time", gettime());
      var_5 setclientomnvar("ui_br_circle1_duration", var_6);
      var_5 setclientomnvar("ui_br_circle1_start_entity", var_2);
      var_5 setclientomnvar("ui_br_circle1_end_entity", var_1);
    }
  }

  thread _id_FC2D(var_0, var_1, var_2);
}

_id_FC2D(var_0, var_1, var_2) {
  level notify("update_circle_omnvars");
  level endon("update_circle_omnvars");

  for(;;) {
    level waittill("update_circle_hide");

    foreach(var_4 in level.players) {
      if(!isbot(var_4)) {
        var_5 = _id_0CD1(var_4, var_0);
        var_4 setclientomnvar("ui_br_circle0_duration", var_5);
        var_5 = _id_0BB0(var_4, var_0);
        var_4 setclientomnvar("ui_br_circle1_duration", var_5);
      }
    }
  }
}

_id_0BB0(var_0, var_1) {
  if(_id_31CB()) {
    return int(var_1 * 1000);
  } else {
    return 0;
  }
}

_id_0CD1(var_0, var_1) {
  if(_id_31D1()) {
    return int(var_1 * 1000);
  } else {
    return 0;
  }
}

_id_88FF() {
  return level._id_2A1B._id_372F >= level._id_2A73._id_2A25.size - 1 || !(level._id_2A73._id_2A25[level._id_2A1B._id_372F + 1] > 0);
}

_id_8AEA(var_0, var_1, var_2) {
  if(!scripts\mp\gametypes\br_c130::_id_89B2(var_0, 1)) {
    return 0;
  }

  if(istrue(var_1) && _id_0C3F(var_0)) {
    return 0;
  }

  if(isDefined(var_2)) {
    var_3 = _id_6B5E(var_0);

    if(var_2 > var_3) {
      return 0;
    }
  }

  return 1;
}

_id_6CC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 8;
  var_9 = var_0;
  var_10 = 0;
  var_11 = 0;

  for(var_12 = 360; var_10 < var_8; var_10++) {
    var_13 = _id_6CC7(var_0, var_1, var_2, var_3, 1, 0, var_11, var_12);

    if(_id_8AEA(var_13, var_6, var_7)) {
      var_9 = var_13;

      if(istrue(var_5) && _func_03DC()) {
        var_13 = _func_02AB(var_9);

        if(_id_8AEA(var_13, var_6, var_7)) {
          break;
        }
      } else
        break;
    }

    var_14 = level._id_2A73._id_2A1F[0] - var_0;
    var_14 = (var_14[0], var_14[1], 0);
    var_15 = vectortoangles(var_14)[1];
    var_16 = (1.0 - var_10 / var_8) * 180;
    var_11 = var_15 - var_16;
    var_12 = var_15 + var_16;
  }

  return var_9;
}

_id_6CC7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0.0;

  if(isDefined(var_2)) {
    var_8 = var_2;
  }

  var_9 = 1.0;

  if(isDefined(var_3)) {
    var_9 = var_3;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 360;
  }

  var_10 = _func_0219(var_1 * var_8);
  var_11 = _func_0219(var_1 * var_9);
  var_12 = undefined;

  if(var_10 == var_11) {
    var_12 = _func_0218(var_10);
  } else {
    var_12 = _func_0218(randomfloatrange(var_10, var_11));
  }

  var_13 = var_6 + randomfloat(var_7 - var_6);
  var_14 = (var_12 * cos(var_13), var_12 * sin(var_13), 0);
  var_15 = var_0 + var_14;

  if(var_4) {
    var_15 = scripts\engine\utility::_id_5000((var_0[0], var_0[1], 4000) + var_14);
  }

  if(var_5 && _func_03DC()) {
    var_15 = _func_02AB(var_15);
  }

  return var_15;
}

_id_6CCB(var_0, var_1) {
  var_2 = _id_69C5();
  var_3 = level._id_2A73._id_2A25[level._id_2A1B._id_372F + 1];
  return _id_6CC7(var_2, var_3, var_0, var_1);
}

_id_89B5(var_0) {
  if(!isDefined(level._id_2A1B._id_433D)) {
    return 0;
  }

  var_1 = (level._id_2A1B._id_433D.origin[0], level._id_2A1B._id_433D.origin[1], 0);
  var_2 = level._id_2A73._id_2A25[level._id_2A1B._id_372F + 1];
  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2) {
    return 1;
  }

  return 0;
}

_id_89B7(var_0) {
  var_1 = _id_6B8C();
  var_2 = _id_6B8D();

  if(!isDefined(var_1) || !isDefined(var_2)) {
    return 0;
  }

  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2) {
    return 1;
  }

  return 0;
}

_id_433E() {
  self endon("death");

  for(;;) {
    self show();

    foreach(var_1 in level.players) {
      if(!var_1 _id_B671()) {
        self hidefromplayer(var_1);
      }
    }

    level waittill("update_circle_hide");
  }
}

_id_0C3F(var_0) {
  if(getdvarint("#x33c09cc0e2884eec", 0) == 1) {
    return 0;
  }

  if(!isDefined(level._id_2A15) || level._id_2A15.size == 0) {
    return 0;
  }

  foreach(var_2 in level._id_2A15) {
    var_3 = distance2dsquared(var_0, var_2.origin);

    if(var_3 < var_2._id_BF43) {
      return 1;
    }
  }

  return 0;
}

_id_0C9D(var_0, var_1) {
  level._id_2A73._id_2A1F = [];
  var_2 = (level._id_2A1B._id_9AAA[0] + level._id_2A1B._id_9AAA[1]) * 0.5;
  level._id_2A73._id_2A1F[0] = (var_2[0], var_2[1], 0.0);
  var_3 = getdvarfloat("#x3703c330a999eabf2", 0.0);
  var_4 = var_3 * level._id_2A73._id_2A25[1];
  var_5 = [];
  var_5[0] = level._id_2A1B._id_9AAA[0][0] - var_4;
  var_5[1] = level._id_2A1B._id_9AAA[0][1] - var_4;
  var_5[2] = level._id_2A1B._id_9AAA[1][0] + var_4;
  var_5[3] = level._id_2A1B._id_9AAA[1][1] + var_4;
  var_6 = min(var_5[0], var_5[2]);
  var_7 = max(var_5[0], var_5[2]);
  var_8 = min(var_5[1], var_5[3]);
  var_9 = max(var_5[1], var_5[3]);
  var_10 = var_2[0];
  var_11 = var_2[1];

  if(isDefined(level._id_2A1B._id_2A45)) {
    var_12 = level._id_2A1B._id_2A45[0];
    var_13 = level._id_2A1B._id_2A45[1];

    if(scripts\mp\gametypes\br_c130::_id_89B2((var_12, var_13, 0), 1) && !_id_0C3F((var_12, var_13, 0))) {
      var_10 = var_12;
      var_11 = var_13;
    }
  } else {
    var_14 = 8;

    for(var_15 = 0; var_15 < var_14; var_15++) {
      var_12 = randomfloatrange(var_6, var_7);
      var_13 = randomfloatrange(var_8, var_9);

      if(scripts\mp\gametypes\br_c130::_id_89B2((var_12, var_13, 0), 1) && !_id_0C3F((var_12, var_13, 0))) {
        var_10 = var_12;
        var_11 = var_13;
        break;
      }

      var_6 = var_6 * 0.9;
      var_7 = var_7 * 0.9;
      var_8 = var_8 * 0.9;
      var_9 = var_9 * 0.9;
    }
  }

  var_16 = level._id_2A73._id_2A25.size - 1;
  level._id_2A73._id_2A1F[var_16] = ::scripts\engine\utility::_id_5000((var_10, var_11, 4000));

  if(istrue(var_1)) {
    return;
  }
  var_17 = getdvarfloat("#x3d88c237fb0d984f7", 200);
  var_18 = getdvarint("#x377ea178d8310617c", 0);
  var_19 = getdvarint("#x3705610f902c9dad", 0);

  if(!var_19 && scripts\mp\gametypes\br_gametypes::_id_8854("circleSnapToNavMesh")) {
    var_19 = 1;
  }

  for(var_20 = var_16 - 1; var_20 >= 0; var_20--) {
    var_21 = level._id_2A73._id_2A1F[var_20 + 1];
    var_22 = level._id_2A73._id_2A25[var_20];
    var_23 = 0.0;
    var_24 = 1.0 - level._id_2A73._id_2A25[var_20 + 1] / var_22;
    var_25 = var_23 + randomfloat(var_24 - var_23);
    var_26 = level._id_2A73._id_2A20[var_20];
    var_27 = level._id_2A73._id_2A25[var_20 + 1];
    var_28 = var_22 - var_27;
    var_29 = var_28 / var_26;
    var_30 = max(0, var_17 - var_29);
    var_31 = var_30 * var_26;
    var_32 = var_31 / var_22;
    var_33 = var_25 > var_32;

    if(var_33 && !istrue(var_0)) {
      var_34 = var_29 + var_25 * var_22 / var_26;
      _func_03BF("dlog_event_br_circle_speed_warning", ["player_speed", var_17, "circle_speed", var_34, "circle_close_time", float(var_26), "circle_current_radius", float(var_22), "circle_next_radius", float(var_27)]);
    }

    if(var_20) {
      if(var_18 && var_33) {
        var_25 = var_23 + randomfloat(var_32 - var_23);
      }

      level._id_2A73._id_2A1F[var_20] = _id_6CC6(var_21, var_22, var_25, var_25, 1, var_19, 1);
      continue;
    }
  }

  level notify("calc_circle_centers");
}

_id_CA29(var_0) {
  level endon("game_ended");
  level endon("br_ending_start");
  level._id_2A1B._id_CACA = spawn("script_model", (level._id_2A73._id_2A1F[1][0], level._id_2A73._id_2A1F[1][1], level._id_2A73._id_2A25[1]));
  level._id_2A1B._id_CACA.hidden = 0;
  level._id_2A1B._id_CACB = spawn("script_model", level._id_2A1B._id_CACA.origin);
  level._id_2A1B._id_CACB.hidden = 0;
  level._id_2A1B._id_433D = _func_020B(level._id_2A73._id_2A1F[0][0], level._id_2A73._id_2A1F[0][1], level._id_2A73._id_2A25[0]);
  level._id_2A1B._id_433D.hidden = 0;
  level._id_2A1B._id_433D thread _id_433E();
  level._id_2A1B._id_4340 = spawn("script_model", level._id_2A1B._id_433D.origin);
  level._id_2A1B._id_4340.hidden = 0;
  _id_D689(level._id_2A1B._id_CACA);
  _id_78F2();

  if(istrue(var_0)) {
    level waittill("infils_ready");
  }

  if(istrue(level._id_FE76)) {
    scripts\mp\gametypes\br_gulag::_id_D87A();
  }

  _id_DC95();
  level._id_2A1B thread _id_3729();

  for(var_1 = 0; var_1 < level._id_2A73._id_2A21.size; var_1++) {
    _id_3734(var_1);
  }

  scripts\mp\gametypes\br_armory_kiosk::_id_4A7A();
}

_id_695A(var_0) {
  if(!isDefined(level._id_2A1B)) {
    return -1;
  }

  var_1 = -1;

  for(var_2 = 0; var_2 < level._id_2A73._id_2A1F.size; var_2++) {
    var_3 = level._id_2A73._id_2A1F[var_2];
    var_4 = level._id_2A73._id_2A25[var_2];
    var_5 = distance2d(var_0, var_3);

    if(var_5 > var_4) {
      break;
    }

    var_1 = var_2;
  }

  return var_1;
}

_id_6B5E(var_0) {
  if(istrue(level._id_2A1D)) {
    return 99999;
  }

  if(!isDefined(level._id_2A1B)) {
    return -1;
  }

  var_1 = 0.0;

  if(level._id_2A1B._id_372F >= 0) {
    var_2 = level._id_2A1B._id_372F;
    var_3 = level._id_2A1B._id_E72D;
    var_4 = level._id_2A1B._id_433D.origin[2];
    var_5 = level._id_2A1B._id_433D.origin;
  } else {
    var_2 = 0;
    var_3 = gettime();
    var_4 = level._id_2A73._id_2A25[0];
    var_5 = level._id_2A73._id_2A1F[0];
  }

  var_6 = _id_695A(var_0);

  if(var_6 < 0) {
    return var_1;
  } else if(var_6 < var_2) {
    return var_1;
  } else if(var_6 == var_2) {
    if(distance2d(var_5, var_0) > var_4) {
      return var_1;
    }
  }

  for(var_7 = var_2 + 1; var_7 < var_6; var_7++) {
    var_1 = var_1 + level._id_2A73._id_2A20[var_7];
    var_1 = var_1 + level._id_2A73._id_2A21[var_7];
  }

  var_8 = level._id_2A73._id_2A21[var_2];
  var_9 = level._id_2A73._id_2A20[var_2];
  var_10 = (gettime() - var_3) / 1000;

  if(var_6 > var_2) {
    var_11 = var_8 + var_9;
    var_1 = var_1 + (var_11 - var_10);
    var_1 = var_1 + level._id_2A73._id_2A21[var_6];
    var_12 = level._id_2A73._id_2A20[var_6];
    var_13 = level._id_2A73._id_2A1F[var_6];
    var_14 = level._id_2A73._id_2A1F[var_6 + 1];
    var_15 = level._id_2A73._id_2A25[var_6];
    var_16 = level._id_2A73._id_2A25[var_6 + 1];
  } else {
    if(var_10 < var_8) {
      var_1 = var_1 + (var_8 - var_10);
      var_12 = var_9;
    } else
      var_12 = var_9 - (var_10 - var_8);

    var_13 = var_5;
    var_14 = level._id_2A73._id_2A1F[var_2 + 1];
    var_15 = var_4;
    var_16 = level._id_2A73._id_2A25[var_2 + 1];
  }

  var_15 = float(var_15);
  var_16 = float(var_16);
  var_17 = var_0[0];
  var_18 = var_17 * var_17;
  var_19 = var_13[0];
  var_20 = var_19 * var_19;
  var_21 = (var_14[0] - var_13[0]) / var_12;
  var_22 = var_21 * var_21;
  var_23 = var_0[1];
  var_24 = var_23 * var_23;
  var_25 = var_13[1];
  var_26 = var_25 * var_25;
  var_27 = (var_14[1] - var_13[1]) / var_12;
  var_28 = var_27 * var_27;
  var_29 = var_15;
  var_30 = var_29 * var_29;
  var_31 = (var_16 - var_15) / var_12;
  var_32 = var_31 * var_31;
  var_33 = _func_0218(_func_01A6(2 * var_17 * var_21 - 2 * var_19 * var_21 + 2 * var_23 * var_27 - 2 * var_25 * var_27 + 2 * var_29 * var_31, 2) - 4 * (-1 * var_22 - var_28 + var_32) * (-1 * var_18 + 2 * var_17 * var_19 - var_20 - var_24 + 2 * var_23 * var_25 - var_26 + var_30));
  var_34 = -2 * var_17 * var_21 + 2 * var_19 * var_21 - 2 * var_23 * var_27 + 2 * var_25 * var_27 - 2 * var_29 * var_31;
  var_35 = 2 * (-1 * var_22 - var_28 + var_32);
  var_36 = (-1 * var_33 + var_34) / var_35;
  var_37 = (var_33 + var_34) / var_35;

  if(var_36 < 0) {
    var_38 = var_37;
  } else if(var_37 < 0) {
    var_38 = var_36;
  } else {
    var_38 = min(var_36, var_37);
  }

  var_1 = var_1 + var_38;
  return var_1;
}

_id_78F2() {
  if(!isDefined(level._id_2A1B) || !isDefined(level._id_2A1B._id_4340)) {
    return;
  }
  level._id_2A1B._id_4340.hidden++;
  level._id_2A1B._id_433D.hidden++;
  level notify("update_circle_hide");
}

_id_7915() {
  level._id_2A1B._id_CACB.hidden++;
  level._id_2A1B._id_CACA.hidden++;
  level notify("update_circle_hide");
}

_id_DC95() {
  var_0 = level._id_2A1B._id_433D.hidden || level._id_2A1B._id_433D.hidden;
  level._id_2A1B._id_4340.hidden--;
  level._id_2A1B._id_433D.hidden--;
  var_1 = level._id_2A1B._id_4340.hidden || level._id_2A1B._id_433D.hidden;

  if(var_0 && !var_1) {
    level notify("update_circle_hide");
  }
}

_id_DCE1() {
  var_0 = level._id_2A1B._id_CACB.hidden || level._id_2A1B._id_CACA.hidden;
  level._id_2A1B._id_CACB.hidden--;
  level._id_2A1B._id_CACA.hidden--;
  var_1 = level._id_2A1B._id_CACB.hidden || level._id_2A1B._id_CACA.hidden;

  if(var_0 && !var_1) {
    level notify("update_circle_hide");
  }
}

_id_3734(var_0) {
  if(istrue(scripts\mp\gametypes\br_gametypes::_id_CA24("circleTimer", var_0))) {
    return;
  }
  level._id_2A1B._id_E72D = gettime();
  level._id_2A1B._id_372F = var_0;
  var_1 = var_0 == 0;
  var_2 = var_0 == level._id_2A73._id_2A20.size - 1;
  var_3 = level._id_2A73._id_2A21[var_0];
  var_4 = level._id_2A73._id_2A20[var_0];
  var_5 = level._id_2A73._id_2A25[var_0 + 1];
  setomnvar("ui_br_circle_num", var_0 + 1);
  thread scripts\mp\gametypes\br_gulag::_id_3734(var_0);
  level thread _id_2A72(var_0);
  var_6 = level._id_2A73._id_2A1F[var_0 + 1];
  level._id_2A1B._id_3394 = var_6;
  level._id_2A1B._id_CACA.origin = (level._id_2A1B._id_3394[0], level._id_2A1B._id_3394[1], var_5);
  level._id_C69D = _id_6214(var_6, var_5);
  _id_3896();
  _id_6213(var_6, var_5);
  var_7 = level._id_2A73._id_2A27[var_0];

  if(var_7 > 0) {
    _id_78F2();
    scripts\engine\utility::delaythread(var_7, ::_id_DC95);
  }

  var_8 = level._id_2A73._id_2A28[var_0];

  if(var_8 > 0) {
    _id_7915();
    scripts\engine\utility::delaythread(var_8, ::_id_DCE1);
  }

  level thread _id_E735(var_3, var_1, var_2);
  level._id_2A1B._id_CACB.origin = level._id_2A1B._id_CACA.origin;
  level._id_2A1B._id_4340.origin = _id_69C5() + (0, 0, _id_69C6());
  _id_D6ED(var_3, level._id_2A1B._id_CACB, level._id_2A1B._id_4340, var_2);
  level thread _id_0CD7(var_3);

  if(var_1) {
    scripts\mp\gametypes\br_public::_id_2BDC("first_circle", 1);
  } else {
    scripts\mp\gametypes\br_public::_id_2BDC("new_circle", 1);
  }

  if(istrue(level._id_FE76)) {
    level thread scripts\mp\gametypes\br_gulag::_id_F492(var_5, var_3);
  }

  level notify("br_circle_set");
  wait(var_3);
  level notify("br_circle_started");

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    level._id_3727 = 1;
  }

  setomnvar("ui_hardpoint_timer", gettime() + int(var_4 * 1000));

  if(var_2) {
    scripts\mp\gametypes\br_public::_id_2BDC("final_circle", 1);
  } else {
    scripts\mp\gametypes\br_public::_id_2BDC("circle_closing", 1);
  }

  thread _id_2B45(var_0);
  level._id_2A1B._id_CACB.origin = level._id_2A1B._id_CACA.origin;
  level._id_2A1B._id_4340.origin = _id_69C5() + (0, 0, _id_69C6());
  _id_D4D6(int(var_4), level._id_2A1B._id_CACA, level._id_2A1B._id_4340, var_2);
  level._id_2A1B._id_433D _meth_86DD(level._id_2A1B._id_3394[0], level._id_2A1B._id_3394[1], var_5, var_4);
  wait(var_4);
  var_9 = 5;

  if(var_9 > 0 && var_0 < var_9) {
    scripts\mp\rank::_id_10B3(1.2, "cirlceMult_" + scripts\engine\utility::_id_EA52(var_0));
    _id_0826::_id_1188(1.2, "cirlceMult_" + scripts\engine\utility::_id_EA52(var_0));
  }

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    level._id_3727 = 0;
  }

  _id_3897(var_6, var_5);
}

_id_2A72(var_0) {
  level endon("game_ended");

  if(var_0 > 0) {
    var_1 = var_0 - 1;
    var_2 = level._id_2A73._id_2A24[var_0];
    var_3 = level._id_2A73._id_2A24[var_1];

    if(var_2 == var_3) {
      return;
    }
    var_4 = 0.05;
    var_5 = 2;
    var_6 = var_5 / var_4;
    var_7 = int((var_3 - var_2) / var_6);
    var_8 = level._id_2A73._id_2A24[var_1];

    for(var_9 = 0; var_9 < var_6; var_9++) {
      var_8 = var_8 - var_7;
      setomnvar("ui_br_minimap_radius", var_8);
      wait(var_4);
    }

    setomnvar("ui_br_minimap_radius", level._id_2A73._id_2A24[var_0]);
  } else
    setomnvar("ui_br_minimap_radius", level._id_2A73._id_2A24[var_0]);
}

_id_0CD7(var_0) {
  level endon("game_ended");

  if(!getdvarint("#x32b830f6bdd191c89", 0)) {
    return;
  }
  var_1 = var_0 - scripts\mp\gametypes\br_nuke::_id_692D() - 2.0;
  var_1 = max(0.05, var_1);
  wait(var_1);
  var_2 = _id_69C5();
  var_3 = _id_69C6();
  var_4 = getdvarint("#x335e4d1d70d4ede5f", 3);
  var_5 = getdvarint("#x38a080a386e85bd54", 5);
  var_6 = 360 / var_4;
  var_7 = [];
  var_8 = randomint(360);

  for(var_9 = 0; var_9 < var_4; var_9++) {
    var_10 = int(var_8 + var_6 * var_9) % 360 + randomintrange(-1 * var_5, var_5);
    var_11 = anglesToForward((0, var_10, 0));
    var_12 = var_2 + var_11 * randomfloatrange(var_3 + 8000, var_3 + 12000);
    var_12 = scripts\engine\utility::_id_5000(var_12 + (0, 0, 10000));
    var_7[var_7.size] = var_12;
  }

  level thread scripts\mp\gametypes\br_nuke::_id_90E8(var_7);
}

_id_3897(var_0, var_1) {
  var_2 = var_1 * var_1;

  if(isDefined(level._id_C7F4)) {
    foreach(var_6, var_4 in level._id_C7F4) {
      if(isDefined(var_4) && distance2dsquared(var_0, var_4.trigger.origin) > var_2) {
        var_5 = _id_6214(var_4.trigger.origin, var_1);

        if(isDefined(var_5) && var_5.size > 0) {
          var_4._id_103C2 _id_081F::_id_C31E(var_5[0].origin);
        } else {
          var_4._id_103C2 _id_081F::_id_C536(var_6);
        }
      }
    }
  }
}

_id_6214(var_0, var_1) {
  if(isDefined(level._id_C69D)) {
    var_2 = scripts\engine\utility::_id_6369(var_0, level._id_C69D, undefined, undefined, var_1);
    return var_2;
  }

  return undefined;
}

_id_6213(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level._id_2A95._id_3E9B) {
    if(isDefined(var_4) && distance2dsquared(var_0, var_4.origin) > var_2) {
      level._id_2A95._id_ACAD[level._id_2A95._id_ACAD.size] = var_4;
    }
  }
}

_id_3896() {
  foreach(var_1 in level._id_2A95._id_ACAD) {
    if(isDefined(var_1) && var_1._id_4143 == 0) {
      var_1 thread scripts\cp_mp\killstreaks\airdrop::_id_4843();
    }
  }

  level._id_2A95._id_ACAD = [];
}

_id_19CB() {
  var_0 = getdvarfloat("#x3fc188e897cbf957f", 1.0);
  var_1 = level._id_2A73;
  var_1._id_2A20 = _id_0B3B(var_1._id_2A20, "close_time", var_0);
  var_1._id_2A21 = _id_0B3B(var_1._id_2A21, "delay_time", var_0);
  var_1._id_2A27 = _id_0B3B(var_1._id_2A27, "show_delay_danger", var_0);
  var_1._id_2A28 = _id_0B3B(var_1._id_2A28, "show_delay_safe", var_0);

  if(!isDefined(var_1._id_2A26)) {
    var_1._id_2A26 = level._id_2A73._id_2A25[0];
  }

  _id_1CEC();
}

_id_0B3B(var_0, var_1, var_2) {
  var_3 = getdvarfloat(_func_0483("#x3359e77daa64aa403", var_1, "_scale"), 1.0);

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = getdvarfloat(_func_0483("#x3a3dec3a2649d0d7c", var_1, "_", scripts\engine\utility::_id_EA52(var_4)), -1.0);

    if(var_5 > 0) {
      var_0[var_4] = var_5;
    }

    var_0[var_4] = var_0[var_4] * var_2;
    var_0[var_4] = var_0[var_4] * var_3;
  }

  return var_0;
}

_id_1CEC() {
  _id_3733(isDefined(level._id_2A73._id_2A20), "level.br_level.br_circleCloseTimes not defined");
  _id_3733(isDefined(level._id_2A73._id_2A21), "level.br_level.br_circleDelayTimes not defined");
  _id_3733(isDefined(level._id_2A73._id_2A27), "level.br_level.br_circleShowDelayDanger not defined");
  _id_3733(isDefined(level._id_2A73._id_2A28), "level.br_level.br_circleShowDelaySafe not defined");
  _id_3733(isDefined(level._id_2A73._id_2A24), "level.br_level.br_circleMinimapRadii not defined");
  _id_3733(isDefined(level._id_2A73._id_2A25), "level.br_level.br_circleDelayTimes not defined");
  var_0 = level._id_2A73._id_2A20.size;
  _id_3733(var_0 == level._id_2A73._id_2A21.size, "level.br_level.br_circleDelayTimes size != " + var_0);
  _id_3733(var_0 == level._id_2A73._id_2A27.size, "level.br_level.br_circleShowDelayDanger size != " + var_0);
  _id_3733(var_0 == level._id_2A73._id_2A28.size, "level.br_level.br_circleShowDelaySafe size != " + var_0);
  _id_3733(var_0 == level._id_2A73._id_2A24.size, "level.br_level.br_circleMinimapRadii size != " + var_0);
  _id_3733(var_0 == level._id_2A73._id_2A25.size - 1, "level.br_level.br_circleRadii size-1 != " + var_0);

  for(var_1 = 0; var_1 < level._id_2A73._id_2A27.size; var_1++) {
    var_2 = level._id_2A73._id_2A21[var_1];
    var_3 = level._id_2A73._id_2A27[var_1];
    _id_3733(var_3 <= var_2, "level.br_level.br_circleShowDelayDanger[" + var_1 + "] " + var_2 + " > " + var_3);
  }

  for(var_1 = 0; var_1 < level._id_2A73._id_2A21.size; var_1++) {
    var_2 = level._id_2A73._id_2A21[var_1];
    var_3 = level._id_2A73._id_2A28[var_1];
    _id_3733(var_3 <= var_2, "level.br_level.br_circleDelayTimes[" + var_1 + "] " + var_2 + " > " + var_3);
  }

  _id_3733(level._id_2A73._id_2A25[0] == level._id_2A73._id_2A26, "Changing circle radius 0 is not supported");
}

_id_3733(var_0, var_1) {
  if(!var_0) {
    return;
  }
}

_id_6959(var_0) {
  if(!isDefined(level._id_2A73)) {
    return 0;
  }

  if(!isDefined(level._id_2A73._id_2A21) || !level._id_2A73._id_2A21.size) {
    return 0;
  }

  var_1 = level._id_2A73._id_2A21.size;

  if(var_0 >= var_1) {
    var_0 = var_1 - 1;
  }

  var_2 = 0;

  for(var_3 = 0; var_3 <= var_0; var_3++) {
    var_4 = level._id_2A73._id_2A21[var_3];
    var_5 = level._id_2A73._id_2A20[var_3];
    var_2 = var_2 + var_4 + var_5;
  }

  return var_2;
}

_id_2B45(var_0) {
  var_1 = level._id_2A73._id_2A21[var_0] / 5;
  wait(var_1);

  foreach(var_3 in level._id_EF89) {
    level thread _id_4E83(level._id_EF6A[var_3]);
  }
}

_id_4E83(var_0) {
  var_1 = _id_6D02();
  var_2 = _id_6D03();

  if(var_0["alivePlayers"].size <= 1) {
    return;
  }
  var_3 = _func_0204(var_0["alivePlayers"], var_1);
  var_4 = distance2dsquared(var_1, var_3[0].origin);

  if(var_4 > var_2 * var_2) {
    if(var_4 > var_2 * var_2 * 4) {
      level thread scripts\mp\battlechatter_mp::_id_F759(var_3[0], "obj_sitrep_circle_outfar");
    } else {
      level thread scripts\mp\battlechatter_mp::_id_F759(var_3[0], "obj_sitrep_circle_out");
    }
  } else {
    var_5 = distance2dsquared(var_1, var_3[var_3.size - 1].origin);

    if(var_5 > var_2 * var_2) {
      level thread scripts\mp\battlechatter_mp::_id_F759(var_3[0], "obj_sitrep_circle_mixed");
    } else {
      level thread scripts\mp\battlechatter_mp::_id_F759(var_3[0], "obj_sitrep_circle_in");
    }
  }
}

_id_3FFF(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2._id_0359 = var_1;
  var_2._id_BF43 = var_1 * var_1;
  return var_2;
}