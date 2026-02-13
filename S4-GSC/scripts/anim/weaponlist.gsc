/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\weaponlist.gsc
*************************************************/

_id_FF06() {
  return weaponisauto(self._id_04F6) || weaponisbeam(self._id_04F6) || weaponburstcount(self._id_04F6) > 0;
}

_id_FF1C() {
  return weaponissemiauto(self._id_04F6);
}

_id_1F7E() {
  if(_id_FF06()) {
    return 0.1 / weaponfiretime(self._id_04F6);
  } else {
    return 0.5;
  }
}

_id_2DB3() {
  if(_id_FF06()) {
    return 0.1 / weaponfiretime(self._id_04F6);
  } else if(scripts\anim\utility_common::_id_FF15()) {
    return 1;
  } else {
    return 0.2;
  }
}

_id_107D4() {
  return 0.25;
}

_id_DA21(var_0) {
  if(!_id_FF06() || isDefined(var_0) && var_0 == 1) {
    var_1 = 0.5 + randomfloat(1);
    return weaponfiretime(self._id_04F6) * var_1;
  } else
    return weaponfiretime(self._id_04F6);
}

_id_C194() {
  if(isnullweapon(self._id_04F6)) {
    self._id_00CC = 0;
    return 0;
  }

  if(!isDefined(self._id_00CC)) {
    self._id_00CC = weaponclipsize(self._id_04F6);
  } else {
    self._id_00CC = weaponclipsize(self._id_04F6);
  }

  var_0 = self._id_04F6.classname;

  if(isDefined(self._id_10D1F[var_0])) {
    self._id_10D1F[var_0]._id_5811 = int((self._id_10D1F[var_0]._id_3DEF - 1) * self._id_04F6._id_00EB);
  }

  if(self._id_00CC <= 0) {
    return 0;
  } else {
    return 1;
  }
}

_id_D8C8(var_0) {
  if(scripts\common\utility::_id_871D(var_0)) {
    self._id_10D1F[var_0] = spawnStruct();
    self._id_10D1F[var_0]._id_3DEF = scripts\common\utility::_id_6857(var_0, 12);
    self._id_10D1F[var_0]._id_5811 = int((self._id_10D1F[var_0]._id_3DEF - 1) * self._id_04F6._id_00EB);
    self._id_10D1F[var_0]._id_9F43 = scripts\common\utility::_id_6857(var_0, 8);
    self._id_10D1F[var_0]._id_9CB3 = scripts\common\utility::_id_6857(var_0, 9);
    self._id_10D1F[var_0].mintimebetweenpeekslostenemy = scripts\common\utility::_id_6857(var_0, 27);
    self._id_10D1F[var_0].maxtimebetweenpeekslostenemy = scripts\common\utility::_id_6857(var_0, 28);
    self._id_10D1F[var_0]._id_9EFC = scripts\common\utility::_id_6857(var_0, 4);
    self._id_10D1F[var_0]._id_9C6D = scripts\common\utility::_id_6857(var_0, 5);
    self._id_10D1F[var_0]._id_9F48 = scripts\common\utility::_id_6857(var_0, 6);
    self._id_10D1F[var_0]._id_9CBE = scripts\common\utility::_id_6857(var_0, 7);
    self._id_10D1F[var_0]._id_9EAF = scripts\common\utility::_id_6857(var_0, 2);
    self._id_10D1F[var_0]._id_9C59 = scripts\common\utility::_id_6857(var_0, 3);
    self._id_10D1F[var_0].minpercentcliptofire = scripts\common\utility::_id_6857(var_0, 10);
    self._id_10D1F[var_0].maxpercentcliptofire = scripts\common\utility::_id_6857(var_0, 11);
    self._id_10D1F[var_0]._id_9F2D = scripts\common\utility::_id_6857(var_0, 14);
    self._id_10D1F[var_0]._id_9C8B = scripts\common\utility::_id_6857(var_0, 15);
    self._id_10D1F[var_0]._id_9F40 = scripts\common\utility::_id_6857(var_0, 16);
    self._id_10D1F[var_0]._id_9CAC = scripts\common\utility::_id_6857(var_0, 17);
    self._id_10D1F[var_0]._id_EBAA = scripts\common\utility::_id_6857(var_0, 18);
    self._id_10D1F[var_0]._id_EBA9 = scripts\common\utility::_id_6857(var_0, 19);
    self._id_10D1F[var_0]._id_EBAB = scripts\common\utility::_id_6857(var_0, 20);
    self._id_10D1F[var_0]._id_EBAC = scripts\common\utility::_id_6857(var_0, 21);
    self._id_10D1F[var_0]._id_9F38 = scripts\common\utility::_id_6857(var_0, 22);
    self._id_10D1F[var_0]._id_9C9D = scripts\common\utility::_id_6857(var_0, 23);
    self._id_10D1F[var_0]._id_9CA8 = scripts\common\utility::_id_6857(var_0, 24);
    self._id_10D1F[var_0]._id_AC4A = scripts\common\utility::_id_6857(var_0, 13);
    self._id_10D1F[var_0]._id_39DD = scripts\common\utility::_id_6857(var_0, 25);
    self._id_10D1F[var_0]._id_39DE = scripts\common\utility::_id_6857(var_0, 26);
    self._id_10D1F[var_0].attackercountaccuracymodifier = scripts\common\utility::_id_6857(var_0, 29);
  }
}

_id_698F() {
  var_0 = self._id_04F6.classname;

  if(isDefined(self._id_10D1F[var_0])) {
    return int(self._id_10D1F[var_0]._id_3DEF * self._id_04F6._id_00EB % self._id_04F6._id_00EB);
  }

  return 0;
}

_id_6928() {
  var_0 = 10000;
  var_1 = 15000;
  var_2 = self._id_04F6.classname;

  if(isDefined(self._id_10D1F[var_2])) {
    var_0 = self._id_10D1F[var_2]._id_9F2D;
    var_1 = self._id_10D1F[var_2]._id_9C8B;

    if(var_0 > var_1) {}
  }

  var_3 = randomfloatrange(var_0, var_1);
  return var_3;
}

_id_107D(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 3.0;
  }

  if(!isDefined(var_3)) {
    var_2 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = "rifle";
  }

  var_0 = tolower(var_0);
  anim._id_13FE[var_0]["type"] = var_1;
  anim._id_13FE[var_0]["time"] = var_2;
  anim._id_13FE[var_0]["clipsize"] = var_3;
  anim._id_13FE[var_0]["anims"] = var_4;
}

_id_1181(var_0) {
  anim._id_13FE[tolower(var_0)]["type"] = "turret";
}