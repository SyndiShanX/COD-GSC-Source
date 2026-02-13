/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_functional_poi.gsc
******************************************************/

init() {
  scripts\mp\gametypes\br_plunder::init();
  scripts\mp\gametypes\br_mobile_armory::init();
  scripts\mp\gametypes\br_satellite_truck::init();
  scripts\mp\gametypes\br_armory_kiosk::init();
  scripts\mp\gametypes\br_bank::init();
  _id_07D1::_id_60C0("POIs_spawned", 0);
  level thread _id_0D7F();
}

_id_825B() {
  var_0 = self;
  var_0 scripts\mp\gametypes\br_plunder::_id_825B();
}

_id_AB80() {
  _id_07D1::_id_60C2("POIs_spawned");
  scripts\mp\gametypes\br_mobile_armory::_id_AB80();
  scripts\mp\gametypes\br_satellite_truck::_id_AB80();
  scripts\mp\gametypes\br_armory_kiosk::_id_AB80();
}

_id_6AC4() {
  return "outline_depth_red";
}

_id_0D7F() {
  level endon("game_ended");
  var_0 = 0.05;
  var_1 = 5;
  var_2 = 5;
  var_3 = 65;
  var_4 = 7;
  var_5 = 7;

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    level._id_11A1 = getdvarint("#x31bba2c95ae423a2b", 35);
    level._id_BE50 = getdvarint("#x3d96fab095eb20b28", 1);
    level._id_2DE5 = getdvarint("#x35463443953f4a5a3", 0);
    level thread _id_D889();
  }

  level._id_9F34 = getdvarint("#x3d93517109281a1bb", var_5);
  level._id_9C99 = getdvarint("#x3d83317231334cf9", var_4);

  if(level._id_9F34 < level._id_9C99) {
    level._id_9C99 = randomintrange(level._id_9F34, level._id_9C99 + 1);
  }

  var_6 = getdvarint("#x3e10fa0e0185b3250", var_3);
  var_7 = scripts\mp\gametypes\br_armory_kiosk::_id_68AD();

  if(isDefined(var_7) && var_7.size > 0) {
    var_7 = _id_0C02(var_7, var_6, level._id_2DE5);
    scripts\mp\gametypes\br_armory_kiosk::_id_D6D7(var_7);
  }

  var_8 = scripts\mp\gametypes\br_plunder::_id_68A6();

  if(isDefined(var_8) && var_8.size > 0) {
    var_8 = _id_0C02(var_8, level._id_9C99, 1);
    scripts\mp\gametypes\br_plunder::_id_D54C(var_8);
  }

  var_9 = scripts\engine\utility::getstructarray("br_respawn_station", "targetname");

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    wait(var_0);
    scripts\mp\gametypes\br_respawn::_id_E264(var_9[var_10]);
  }

  var_11 = getdvarint("#x3dc55207d8be70603", var_1);
  var_12 = scripts\engine\utility::getstructarray("br_mobile_armory_location", "targetname");

  if(var_12.size > 0) {
    var_13 = _id_0C09(var_12, var_11);

    for(var_10 = 0; var_10 < var_13.size; var_10++) {
      wait(var_0);
      scripts\mp\gametypes\br_mobile_armory::_id_E328(var_13[var_10]);
    }
  }

  var_14 = getdvarint("#x3153b72b463993f87", var_2);
  var_15 = scripts\engine\utility::getstructarray("br_satellite_truck_location", "targetname");

  if(var_15.size > 0) {
    var_16 = _id_0C09(var_15, var_14);

    for(var_10 = 0; var_10 < var_16.size; var_10++) {
      wait(var_0);
      scripts\mp\gametypes\br_satellite_truck::_id_E365(var_16[var_10]);
    }
  }

  _id_07D1::_id_60C1("POIs_spawned");
}

_id_0C02(var_0, var_1, var_2) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }
  if(var_1 > var_0.size) {
    var_1 = var_0.size;
  }

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    return scripts\mp\gametypes\br_gametype_dmz::_id_0C07(var_0, var_1, var_2);
  } else if(!isDefined(level._id_2A1B) || !isDefined(level._id_2A73)) {
    return _id_0C09(var_0, var_1);
  }

  var_3 = level._id_2A73._id_2A1F.size - 1;
  var_4 = int(max(1, var_3 * getdvarfloat("#x325fb5b26a8ca336e", 1.0)));

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    var_7 = randomintrange(-1 * var_4, var_4 + 1);
    var_6._id_038F = scripts\mp\gametypes\br_circle::_id_695A(var_6.origin) + var_7;
  }

  var_8 = scripts\engine\utility::_id_1BD6(var_0, ::_id_3AFD);
  var_9 = [];

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_9[var_5] = var_8[var_5];
  }

  return scripts\engine\utility::_id_1BD4(var_8, 0, var_1);
}

_id_3AFD(var_0, var_1) {
  return var_0._id_038F > var_1._id_038F;
}

_id_0C09(var_0, var_1) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }
  var_2 = [];

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_3 = int(min(var_1, var_0.size));

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_2[var_2.size] = var_0[var_4];
    }
  }

  return var_2;
}

_id_DCC7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_4 = "mp/hints.csv";
    var_5 = 1;
    var_6 = 0;
    var_7 = -1;
    var_8 = tablelookuprownum(var_4, var_5, var_1);

    if(isDefined(var_8) && var_8 >= 0) {
      var_7 = int(tablelookupbyrow(var_4, var_8, var_6));
    }

    if(var_7 < 0) {
      return;
    }
    var_9 = undefined;

    if(isDefined(var_3)) {
      var_9 = gettime() + var_3;
    }

    var_12 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");

    foreach(var_14 in var_12) {
      var_14 _id_0A99::_id_D5EA(var_7, var_9, var_2);
    }
  }
}

_id_829C(var_0) {
  if(!isDefined(level._id_B9C5)) {
    level._id_B9C5 = [];
  }

  level._id_B9C5[var_0] = [];
}

_id_C2BB(var_0, var_1, var_2, var_3, var_4) {
  level._id_B9C5[var_0][var_1] = spawnStruct();
  level._id_B9C5[var_0][var_1]._id_AAC4 = var_2;
  level._id_B9C5[var_0][var_1]._id_ABCA = var_3;
  level._id_B9C5[var_0][var_1]._id_AADC = var_4;
}

_id_7103(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2._id_41F6)) {
    var_3 = level._id_B9C5[var_0][var_2._id_41F6];

    if(isDefined(var_3) && isDefined(var_3._id_AADC)) {
      level[[var_3._id_AADC]](var_2);
    }
  }

  var_2 notify("poi_state_change");
  var_2._id_41F6 = var_1;
  var_3 = level._id_B9C5[var_0][var_2._id_41F6];

  if(isDefined(var_3)) {
    if(isDefined(var_3._id_AAC4)) {
      level[[var_3._id_AAC4]](var_2);
    }

    if(isDefined(var_3._id_ABCA)) {
      var_2 thread _id_0C97(var_3._id_ABCA);
    }
  }
}

_id_7104(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("poi_state_change");
  wait(var_2);
  var_3 thread _id_7103(var_0, var_1);
}

_id_69A8() {
  var_0 = self;
  return var_0._id_41F6;
}

_id_0C97(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_2 = var_1._id_41F6;

  while(var_2 == var_1._id_41F6) {
    level[[var_0]](var_1);
    waitframe();
  }
}

_id_D889() {
  if(!isDefined(level._id_9AB1)) {
    waitframe();
  }

  var_0 = level._id_9AB1[0].origin[0];
  var_1 = level._id_9AB1[1].origin[0];
  var_2 = (level._id_9AB1[0].origin[0], level._id_9AB1[0].origin[1], level._id_9AB1[0].origin[2]);
  var_3 = (level._id_9AB1[1].origin[0], level._id_9AB1[0].origin[1], level._id_9AB1[1].origin[2]);

  if(var_1 < var_0) {
    var_2 = (level._id_9AB1[1].origin[0], level._id_9AB1[0].origin[1], level._id_9AB1[1].origin[2]);
    var_3 = (level._id_9AB1[0].origin[0], level._id_9AB1[0].origin[1], level._id_9AB1[0].origin[2]);
  }

  var_4 = level._id_9AB1[0].origin[1];
  var_5 = level._id_9AB1[1].origin[1];
  var_6 = (level._id_9AB1[0].origin[0], level._id_9AB1[1].origin[1], level._id_9AB1[0].origin[2]);
  var_7 = (level._id_9AB1[1].origin[0], level._id_9AB1[1].origin[1], level._id_9AB1[1].origin[2]);

  if(var_5 < var_4) {
    var_6 = (level._id_9AB1[1].origin[0], level._id_9AB1[1].origin[1], level._id_9AB1[1].origin[2]);
    var_7 = (level._id_9AB1[0].origin[0], level._id_9AB1[1].origin[1], level._id_9AB1[0].origin[2]);
  }

  var_8 = [];

  if(level.mapname == "mp_donetsk") {
    level._id_3D6B = abs(distance(var_7, var_2));
    var_9 = level._id_3D6B / 10;
    var_2 = (var_2[0] + var_9, var_2[1] - var_9, var_2[2]);
    var_3 = (var_3[0] - var_9, var_3[1] - var_9, var_3[2]);
    var_6 = (var_6[0] - var_9, var_6[1] + var_9, var_6[2]);
    var_7 = (var_7[0] + var_9, var_7[1] + var_9, var_7[2]);
    level._id_3D6B = abs(distance(var_7, var_2));

    for(var_10 = 1; var_10 < 4; var_10 = var_10 + 2) {
      var_11 = var_10 * level._id_3D6B / 2;

      for(var_12 = 1; var_12 < 4; var_12 = var_12 + 2) {
        var_13 = var_12 * level._id_3D6B / 2;
        var_14 = (var_7[0] + var_11 / 2, var_7[1] + var_13 / 2, 0);
        var_8[var_8.size] = var_14;
      }
    }
  }

  level._id_BE95 = [];

  if(level.mapname == "mp_br_mechanics") {
    level._id_BE95[level._id_BE95.size] = (3965, 4054, 0);
    level._id_BE95[level._id_BE95.size] = (4069, -4150, 0);
    level._id_BE95[level._id_BE95.size] = (-4035, -4074, 0);
    level._id_BE95[level._id_BE95.size] = (-4009, 4105, 0);
  } else if(level.mapname == "mp_br_money") {
    level._id_BE95[level._id_BE95.size] = (46569.5, -8170, 0);
    level._id_BE95[level._id_BE95.size] = (56849.5, -8170, 0);
    level._id_BE95[level._id_BE95.size] = (67081.5, -17919.5, 0);
    level._id_BE95[level._id_BE95.size] = (46593, -17919.5, 0);
  } else {
    level._id_BE95[level._id_BE95.size] = (-21299.2, 41779.2, 0);
    level._id_BE95[level._id_BE95.size] = (37683.2, 41779.2, 0);
    level._id_BE95[level._id_BE95.size] = (37683.2, -17203.2, 0);
    level._id_BE95[level._id_BE95.size] = (-21299.2, -17203.2, 0);
  }

  level._id_BE95 = scripts\engine\utility::array_randomize(level._id_BE95);
  var_15 = 33704;
  level._id_BE96 = abs(var_15 * var_15);

  if(level._id_11A1 > 0 && level.mapname == "mp_donetsk") {
    level._id_BFF7 = randomintrange(0, 5);
    var_9 = level._id_3D6B / 10;
    var_16 = level._id_3D6B / (100 / level._id_11A1);

    switch (level._id_BFF7) {
      case 0:
        var_17 = (var_2[0] + var_9, var_2[1] - var_9, var_2[2]);
        var_18 = (var_3[0] - var_16, var_3[1] - var_9, var_3[2]);
        var_19 = (var_6[0] - var_16, var_6[1] + var_16, var_6[2]);
        var_20 = (var_7[0] + var_9, var_7[1] + var_16, var_7[2]);
        break;
      case 1:
        var_17 = (var_2[0] + var_16, var_2[1] - var_9, var_2[2]);
        var_18 = (var_3[0] - var_9, var_3[1] - var_9, var_3[2]);
        var_19 = (var_6[0] - var_16, var_6[1] + var_9, var_6[2]);
        var_20 = (var_7[0] + var_16, var_7[1] + var_16, var_7[2]);
        break;
      case 2:
        var_17 = (var_2[0] + var_16, var_2[1] - var_16, var_2[2]);
        var_18 = (var_3[0] - var_9, var_3[1] - var_16, var_3[2]);
        var_19 = (var_6[0] - var_9, var_6[1] + var_9, var_6[2]);
        var_20 = (var_7[0] + var_16, var_7[1] + var_9, var_7[2]);
        break;
      case 3:
        var_17 = (var_2[0] + var_9, var_2[1] - var_16, var_2[2]);
        var_18 = (var_3[0] - var_16, var_3[1] - var_16, var_3[2]);
        var_19 = (var_6[0] - var_16, var_6[1] + var_9, var_6[2]);
        var_20 = (var_7[0] + var_9, var_7[1] + var_9, var_7[2]);
        break;
      case 4:
        var_17 = (var_2[0] + var_16, var_2[1] - var_16, var_2[2]);
        var_18 = (var_3[0] - var_16, var_3[1] - var_16, var_3[2]);
        var_19 = (var_6[0] - var_16, var_6[1] + var_16, var_6[2]);
        var_20 = (var_7[0] + var_16, var_7[1] + var_16, var_7[2]);
        break;
      default:
        var_17 = (var_2[0] + var_16, var_2[1] - var_16, var_2[2]);
        var_18 = (var_3[0] - var_16, var_3[1] - var_16, var_3[2]);
        var_19 = (var_6[0] - var_16, var_6[1] + var_16, var_6[2]);
        var_20 = (var_7[0] + var_16, var_7[1] + var_16, var_7[2]);
        break;
    }

    var_21 = [];
    level._id_ADD2 = [];
    level._id_ADD1 = abs(distance(var_20, var_17));
    level._id_B9BC = level._id_ADD1 / 2;

    for(var_10 = 1; var_10 < 4; var_10 = var_10 + 2) {
      var_11 = var_10 * level._id_ADD1 / 2;

      for(var_12 = 1; var_12 < 4; var_12 = var_12 + 2) {
        var_13 = var_12 * level._id_ADD1 / 2;
        var_14 = (var_20[0] + var_11 / 2, var_20[1] + var_13 / 2, 0);
        var_21[var_21.size] = var_14;
      }
    }

    if(level._id_BE50 == 2) {
      level._id_ADD2 = scripts\engine\utility::array_randomize(var_21);
    } else {
      switch (level._id_BFF7) {
        case 0:
          if(level._id_BE50) {
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
          } else {
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
          }

          break;
        case 1:
          if(level._id_BE50) {
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
          } else {
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
          }

          break;
        case 2:
          if(level._id_BE50) {
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
          } else {
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
          }

          break;
        case 3:
          if(level._id_BE50) {
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
          } else {
            level._id_ADD2[level._id_ADD2.size] = var_21[0];
            level._id_ADD2[level._id_ADD2.size] = var_21[1];
            level._id_ADD2[level._id_ADD2.size] = var_21[3];
            level._id_ADD2[level._id_ADD2.size] = var_21[2];
          }

          break;
        case 4:
          level._id_ADD2 = scripts\engine\utility::array_randomize(var_21);
          break;
        default:
          level._id_ADD2 = scripts\engine\utility::array_randomize(var_21);
          break;
      }
    }

    var_22 = abs(distance(var_17, var_19));
    level._id_3D6A = var_22;
    var_23 = var_22 / 4.5;
    level._id_ADD3 = var_23 * var_23;
  }
}