/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2014.gsc
*************************************************/

_id_10B9(var_0) {
  var_1 = self._id_765C;

  if(!isDefined(self._id_EA6A)) {
    var_1 = spawnStruct(self._id_765C);
    var_1.player = self;
    var_1._id_7B13 = 0;
    self._id_765C = var_1;
    var_1._id_7B13 = var_1._id_7B13 + var_0;
    self notify("heavyArmor_added");
  } else
    var_1._id_7B13 = var_1._id_7B13 + var_0;
}

_id_EAC6(var_0) {
  var_1 = self._id_765C;

  if(istrue(var_1._id_7D4B)) {
    return;
  }
  if(var_1._id_7B13 > 0) {
    var_1._id_7B13 = max(0, var_1._id_7B13 - var_0);

    if(var_1._id_7B13 <= 0) {
      thread _id_765D();
    }
  }
}

_id_C4CE() {
  self notify("heavyArmor_removed");
  self._id_765C = undefined;
}

_id_765F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_2 <= 0 && var_3 <= 0) {
    return [0, var_2, var_3];
  }

  if(var_4 == "MOD_SUICIDE") {
    return [0, var_2, var_3];
  }

  if(isDefined(var_1) && (var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn")) {
    return [0, var_2, var_3];
  }

  if(!var_0 _id_756F()) {
    return [0, var_2, var_3];
  }

  if(scripts\mp\utility\weapon::_id_8787(var_5)) {
    return [0, var_2, var_3];
  }

  if(var_0 _id_7570()) {
    return [1, 1, 0];
  }

  var_11 = var_0 _id_6A96();
  var_12 = _id_765E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  var_13 = var_2 * var_12;
  var_14 = var_3 * var_12;
  var_15 = var_13 + var_14;

  if(!var_10) {
    var_0 _id_EAC6(var_15);
  }

  if(var_0 _id_7570()) {
    return [var_11, 1, 0];
  }

  return [var_2 + var_3, 1, 0];
}

_id_6A96() {
  if(!_id_756F()) {
    return 0;
  }

  return self._id_765C._id_7B13;
}

_id_756F() {
  return isDefined(self._id_765C) && (self._id_765C._id_7B13 > 0 || istrue(self._id_765C._id_852D));
}

_id_7570() {
  return isDefined(self._id_765C) && istrue(self._id_765C._id_852D);
}

_id_765D() {
  self endon("disconnect");
  self endon("heavyArmor_removed");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    self._id_765C._id_852D = 1;
  }

  self notify("heavyArmor_broken");
  waittillframeend;
  thread _id_C4CE();
}

_id_765E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = [];

  if(scripts\mp\utility\weapon::_id_8A7D(var_5)) {
    var_11[var_11.size] = 1.33;
  }

  if(_func_010F(var_4)) {
    var_11[var_11.size] = 1.5;
  }

  if(var_4 == "MOD_MELEE") {
    var_11[var_11.size] = 1.5;
  }

  if(_id_0A8B::_id_8891(var_5, var_8, var_4, var_1)) {
    var_11[var_11.size] = 1.5;
  }

  var_12 = 1;

  foreach(var_14 in var_11) {
    if(var_14 > var_12) {
      var_14 = var_12;
    }
  }

  return var_12;
}