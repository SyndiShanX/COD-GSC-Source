/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_skill.gsc
**************************************/

init() {
  level._id_8C73 = getdvarint("skill_rdur_min", 60);
  level._id_8C74 = _float(getdvarint("skill_recent_sosc", 1000)) / 1000.0;
  level._id_8C76 = getdvarint("skill_sos_max_weight", 5);
  level._id_8C77 = _float(getdvarint("skill_sos_tanh_scale", 1000)) / 1000.0;
  level._id_8C75 = _float(getdvarint("skill_sos_default_rating", 500)) / 1000.0;
  level thread onplayerspawned();
}

_id_534E(var_0) {
  if(!var_0 _id_57D1()) {
    return;
  }
  if(isDefined(var_0._id_8F28)) {
    return;
  }
  var_0._id_8F28 = level._id_8F28;
  level._id_8F28++;
  var_1 = spawnStruct();
  var_1._id_170A = maps\mp\_utility::_id_44FB();
  var_1._id_1708 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "sosRating");
  var_1._id_1709 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "sosWeight");

  if(var_1._id_1709 <= 0.5)
    var_1._id_1708 = level._id_8C75;

  var_1._id_1704 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "gdfRating");
  var_1._id_1705 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "gdfVariance");
  var_1._id_5C17 = var_1._id_170A;
  var_1._id_80A6 = undefined;
  level._id_8F29[var_0._id_8F28] = var_1;
}

_id_7743() {
  foreach(var_1 in level.players)
  var_1 _id_0738();
}

_id_775A() {
  _id_0738();
}

onplayerspawned() {
  level._id_8F29 = [];
  level._id_8F28 = 0;

  for(;;) {
    level waittill("player_spawned", var_0);
    _id_534E(var_0);
  }
}

_id_57D1() {
  if(!isDefined(self))
    return 0;

  if(isbot(self))
    return 0;

  if(!maps\mp\_utility::rankingenabled())
    return 0;

  return 1;
}

_id_0663(var_0, var_1) {
  for(var_2 = 1; var_1; var_0 = var_0 * var_0) {
    if(var_1 & 1)
      var_2 = var_2 * var_0;

    var_1 = var_1 >> 1;
  }

  return var_2;
}

_id_05F3(var_0) {
  var_1 = common_scripts\utility::_id_8C4F(var_0);
  var_2 = _exp(_log(_abs(var_0)) / 3);
  var_2 = var_2 * var_1;
  return var_2;
}

_id_06AC(var_0) {
  if(var_0 <= -3)
    return -1;

  if(var_0 >= 3)
    return 1;

  var_1 = var_0 * var_0;
  var_2 = var_0 * (27 + var_1) / (27 + 9 * var_1);
  return var_2;
}

_id_0661(var_0) {
  if(var_0 <= -1)
    return -3;

  if(var_0 >= 1)
    return 3;

  var_1 = var_0 * var_0;
  var_2 = var_1 * var_0;
  var_3 = 27 * (var_2 + (var_1 - 1) - var_0);
  var_4 = _id_05F3(var_3);
  var_5 = 3 * var_0;
  var_6 = 9 * (1 - var_1);
  var_7 = var_4;
  var_8 = -1 * var_6 / var_7;
  var_9 = var_4 + var_5 + var_8;
  return var_9;
}

_id_0662(var_0) {
  var_1 = var_0;
  var_1 = var_1 * 2.0;
  var_1 = var_1 - 1.0;
  var_1 = _id_0661(var_1) / level._id_8C77;
  return var_1;
}

_id_062B(var_0) {
  var_0 = clamp(var_0, -3.14159, 3.14159);
  var_1 = var_0;
  var_1 = _id_06AC(var_1 * level._id_8C77);
  var_1 = var_1 + 1.0;
  var_1 = var_1 * 0.5;
  return var_1;
}

_id_0595(var_0, var_1) {
  var_2 = _id_0662(var_0);
  var_2 = var_2 + var_1;
  var_3 = _id_062B(var_2);
  return var_3;
}

_id_05EB(var_0) {
  var_1 = var_0 * 2000;
  return int(var_1);
}

_id_05EC(var_0) {
  var_1 = _float(var_0) / 2000.0;
  var_1 = clamp(var_1, 0.0, 1.0);
  return var_1;
}

_id_05D7(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + var_2 * 0.5 + var_3;
  var_5 = var_0 + var_2 + var_1 + 2.0 * var_3;

  if(var_5 == 0)
    return 0.5;

  var_6 = var_4 / var_5;
  return var_6;
}

_id_05D8(var_0, var_1) {
  var_2 = var_0 - 0.5;
  var_2 = var_2 * 1.0;
  var_3 = _id_0595(var_1, var_2);
  return var_3;
}

_id_0685(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0)
  var_1 = var_1 + _abs(var_4);

  if(var_1 != 0)
    var_2 = 1.0 / var_1;

  foreach(var_7, var_4 in var_0)
  var_0[var_7] = var_0[var_7] * var_2;

  return var_0;
}

_id_060A(var_0, var_1) {
  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    if(isDefined(var_1[var_5]))
      var_2 = var_2 + var_4 * var_1[var_5];
  }

  return var_2;
}

_id_06AB(var_0) {
  if(var_0 < -10)
    return 0 - var_0;

  return _id_0684(var_0) / _id_0683(var_0);
}

_id_073D(var_0, var_1) {
  return var_0 * (var_0 + var_1);
}

_id_0684(var_0) {
  return 0.398942 * _exp(var_0 * var_0 * 0.5 * -1.0);
}

_id_0683(var_0) {
  var_1 = _abs(0.707107 * var_0);
  var_2 = 1.0 / (1.0 + 0.5 * var_1);
  var_3 = var_2 * _exp(var_1 * var_1 * -1 - 1.26551 + var_2 * (1.00002 + var_2 * (0.374092 + var_2 * (0.0967842 + var_2 * (-0.186288 + var_2 * (0.278868 + var_2 * (-1.1352 + var_2 * (1.48852 + var_2 * (-0.822152 + var_2 * 0.170873)))))))));

  if(var_0 >= 0)
    var_3 = 2.0 - var_3;

  return 0.5 * var_3;
}

_id_0739(var_0) {
  if(isbot(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_8F28)) {
    return;
  }
  level._id_8F29[var_0._id_8F28]._id_5C17 = maps\mp\_utility::_id_44FB();
  var_1 = level._id_8F29[var_0._id_8F28]._id_5C17 - level._id_8F29[var_0._id_8F28]._id_170A;

  if(var_1 > level._id_8C73 && isDefined(var_0.pers) && isDefined(var_0.pers["score"]))
    level._id_8F29[var_0._id_8F28]._id_80A6 = var_0.pers["score"] / var_1;
  else
    level._id_8F29[var_0._id_8F28]._id_80A6 = undefined;
}

_id_0738() {
  if(!_id_57D1()) {
    return;
  }
  if(isDefined(self._id_8C78) || !isDefined(self._id_8F28)) {
    return;
  }
  self._id_8C78 = 1;

  if(!isDefined(level._id_8F29[self._id_8F28])) {
    return;
  }
  foreach(var_1 in level.players)
  _id_0739(var_1);

  var_3 = level._id_8F29[self._id_8F28];

  if(!isDefined(var_3._id_80A6)) {
    return;
  }
  var_4 = var_3._id_5C17 - var_3._id_170A;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = var_3._id_1708 * var_4;
  var_9 = var_4;
  var_10 = var_3._id_1705;
  var_11 = var_3._id_1704;
  var_12 = 0;
  var_13 = 0;

  if(var_10 == 0.0)
    var_10 = _min(1.0, max(0.8596 + _abs(var_3._id_1704) * -0.18397, 0.05));

  foreach(var_22, var_15 in level._id_8F29) {
    if(var_22 == self._id_8F28) {
      continue;
    }
    if(!isDefined(var_15._id_80A6)) {
      continue;
    }
    var_16 = var_15._id_5C17 - max(var_3._id_170A, var_15._id_170A);

    if(var_16 <= 0) {
      continue;
    }
    var_17 = 7.0 + var_10;

    if(var_15._id_1705)
      var_17 = var_17 + var_15._id_1705;
    else
      var_17 = var_17 + _min(max(_abs(var_15._id_1704) * -0.18397 + 0.8596, 0.05), 1.0);

    var_18 = _sqrt(var_17);
    var_19 = (var_11 - var_15._id_1704) / var_18;
    var_20 = 0;

    if(var_3._id_80A6 > var_15._id_80A6) {
      var_5 = var_5 + 1.0;
      var_20 = 1.0;
    } else if(var_3._id_80A6 < var_15._id_80A6) {
      var_6 = var_6 + 1.0;
      var_20 = 0.0;
    } else {
      var_7 = var_7 + 1.0;
      var_20 = 0.5;
    }

    var_21 = 1.0 / (1.0 + _exp(var_19 * -1.0));
    var_12 = var_12 + (var_20 - var_21) / var_18;
    var_13 = var_13 + _sqrt(var_10) / var_18 * var_21 * (1.0 - var_21) / var_17;
    var_8 = var_8 + var_15._id_1708 * var_16;
    var_9 = var_9 + var_16;
  }

  var_10 = var_10 + 0.0001;
  var_11 = var_11 + var_10 * var_12;
  var_10 = max(0.05, var_10 * (1.0 - var_10 * var_13));
  self setplayerdata(common_scripts\utility::_id_46AE(), "gdfRating", var_11);
  self setplayerdata(common_scripts\utility::_id_46AE(), "gdfVariance", var_10);
  var_23 = var_8 / var_9;
  var_24 = 1.0;
  var_25 = _id_05D7(var_5, var_6, var_7, level._id_8C74);
  var_26 = _id_05D8(var_25, var_23);
  var_27 = var_26;
  var_28 = _min(var_3._id_1709, level._id_8C76);
  var_29 = var_28 + var_24;

  if(var_29 > 0) {
    var_27 = (var_3._id_1708 * var_28 + var_27 * var_24) / var_29;
    self setplayerdata(common_scripts\utility::_id_46AE(), "sosRating", var_27);
    self setplayerdata(common_scripts\utility::_id_46AE(), "sosWeight", var_3._id_1709 + var_24);
  }
}