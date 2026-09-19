/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_weapon_plant.gsc
*******************************************************/

_id_5285() {
  setdvarifuninitialized("weapon_plant_stand_upper_limit", 4.0);
  setdvarifuninitialized("weapon_plant_crouch_lower_limit", 4.0);

  if(!isDefined(level._id_A9B1)) {
    level._id_A9B1 = spawnStruct();
    level._id_A9B1._id_4295 = ::_id_4295;
    level._id_A9B1._id_707B = ::_id_707B;
    level._id_A9B1._id_2FEE = ::_id_2FEE;
    level._id_A9B1._id_3A66 = ::_id_3A66;
    level._id_A9B1._id_6518 = ::_id_6518;
    level._id_A9B1._id_8B6B = ::_id_8B6B;
    level._id_A9B1._id_43DE = ::_id_43DE;
    level._id_A9B1._id_43DA = ::_id_43DA;
    level._id_A9B1._id_941B = ::_id_941B;
    level._id_A9B1._id_4355 = ::_id_4355;
    level._id_A9B1._id_2373 = ::_id_2373;
    level._id_A9B1._id_4074 = ::_id_4074;
    level._id_A9B1._id_43DC = ::_id_43DC;
    level._id_A9B1._id_8B53 = ::_id_8B53;
    level._id_A9B1._id_439E = ::_id_439E;
    level._id_A9B1._id_41C4 = ::_id_41C4;
    level._id_A9B1._id_41B5 = ::_id_41B5;
    level._id_A9B1._id_43D9 = ::_id_43D9;
    level._id_A9B1._id_5778 = ::_id_5778;
    level._id_A9B1._id_8BAF = ::_id_8BAF;
    level._id_A9B1.get_weapon_paintjobid = ::get_weapon_paintjobid;
    level._id_A9B1.get_weapon_charmguid = ::get_weapon_charmguid;
  }
}

_id_6518(var_0) {
  self _meth_85BF(var_0);
}

_id_43DC(var_0) {
  return "SCRIPTED_SWAP";
}

_id_4295(var_0) {
  var_1 = _id_04CB::_id_0995(self, 2, var_0, 1, 0);
  return var_1;
}

_id_707B(var_0, var_1, var_2) {
  _id_0380::_id_288B("mg_deploy_mount", self, self);
  _id_0380::_id_288B("mg_deploy_rattle", self, self);
}

_id_2FEE() {
  _id_0380::_id_288B("mg_deploy_release", self, self);
  _id_0380::_id_288B("mg_deploy_rattle", self, self);
}

_id_3A66() {
  self iprintlnbold(&"WEAPON_PLANT_BLOCKED");
}

_id_8B6B() {
  return 1;
}

_id_43DE() {
  return getdvarfloat("weapon_plant_stand_upper_limit", 4.0);
}

_id_43DA() {
  return getdvarfloat("weapon_plant_crouch_lower_limit", 4.0);
}

_id_941B(var_0, var_1, var_2, var_3) {}

_id_2373() {}

get_weapon_paintjobid() {
  return self _meth_86CE();
}

get_weapon_charmguid() {
  return self _meth_86CF();
}

_id_4355(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 15;
  var_4 = 15;

  if(var_0 == "prone") {
    var_1 = 40;
    var_2 = 40;
  } else {
    var_1 = 45;
    var_2 = 45;
  }

  return [var_1, var_2, var_3, var_4];
}

_id_8B53() {
  return 1;
}

_id_4074() {
  return getdvarfloat("5099", -14.03);
}

_id_439E(var_0) {
  return undefined;
}

_id_41C4() {
  return 0.0;
}

_id_41B5() {
  return 10.0;
}

_id_43D9() {
  return getdvarfloat("4485", 32.98);
}

_id_5778(var_0) {
  return 0;
}

_id_8BAF() {
  return 0;
}