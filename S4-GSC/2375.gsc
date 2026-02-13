/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2375.gsc
*************************************************/

_id_7F66() {
  self._id_AFAA = [];
  self._id_AFAA["health"] = _id_0948::_id_8041();
  self._id_AFAA["damagemod"] = _id_0948::_id_803E();
  self._id_AFAA["medic"] = _id_0948::_id_8045();
  self._id_AFAA["rigger"] = _id_0948::_id_8048();
  self._id_AFAA["robotics"] = _id_0948::_id_8049();
  self._id_AFAA["demolition"] = _id_0948::_id_803F();
  self._id_AFAA["gunslinger"] = _id_0948::_id_8040();
  self._id_AFAA["hybrid"] = _id_0948::_id_8042();
  self._id_AFAA["pistol"] = _id_0948::_id_8047();
  self._id_AFAA["none"] = _id_0948::_id_8046();
}

_id_AFBA() {
  if(isDefined(self._id_DD78)) {
    return self._id_DD78["melee"]._id_9D50;
  }

  return self._id_AFAA["health"]._id_9D50;
}

_id_AFB9() {
  if(isDefined(self._id_DD78)) {
    return self._id_DD78["health"]._id_9C21;
  }

  return self._id_AFAA["health"]._id_9C21;
}

_id_AFB2() {
  if(isDefined(self._id_DD78)) {
    return self._id_DD78["impact"]._id_2D25;
  }

  return self._id_AFAA["damagemod"]._id_2D25;
}

_id_AFC1() {
  if(isDefined(self._id_DD78)) {
    return self._id_DD78["medic"]._id_C7D3;
  }

  return self._id_AFAA["medic"]._id_C7D3;
}

_id_AFB7() {
  return self._id_AFAA["medic"]._id_6158;
}

_id_AFBB() {
  return self._id_AFAA["medic"]._id_A200;
}

_id_AFC0() {
  return self._id_AFAA["medic"]._id_C7BD;
}

_id_AFB4() {
  return self._id_AFAA["rigger"]._id_4F4D;
}

_id_AFB5() {
  return self._id_AFAA["rigger"]._id_4F4E;
}

_id_AFC2() {
  return self._id_AFAA["rigger"]._id_F4AF;
}

_id_AFC3() {
  return self._id_AFAA["rigger"]._id_F4B0;
}

_id_AFC4() {
  return self._id_AFAA["rigger"]._id_F4B7;
}

_id_AFB3() {
  return self._id_AFAA["rigger"]._id_414C;
}

_id_AFBF() {
  return self._id_AFAA["rigger"]._id_C543;
}

_id_AFB0() {
  return self._id_AFAA["robotics"]._id_1B37;
}

_id_AFB1() {
  return self._id_AFAA["robotics"]._id_1B38;
}

_id_AFB6() {
  if(isDefined(self._id_DD78)) {
    return self._id_DD78["demolition"]._id_57E2;
  }

  return self._id_AFAA["demolition"]._id_57E2;
}

_id_AFBC() {
  if(isDefined(self._id_DD78)) {
    return self._id_DD78["demolition"]._id_A943;
  }

  return self._id_AFAA["demolition"]._id_A943;
}

_id_AFB8() {
  if(isDefined(self._id_DD78)) {
    return self._id_DD78["demolition"]._id_90F2;
  }

  return self._id_AFAA["demolition"]._id_90F2;
}

_id_AFBE() {
  return self._id_AFAA["pistol"]._id_B128;
}

_id_AFBD() {
  return self._id_AFAA["pistol"]._id_B123;
}

_id_674E() {}

_id_674F() {
  var_0 = "perk_none";
  return var_0;
}

_id_C6F6() {
  var_0 = _id_674E();
  var_1 = _id_664F();
  _id_074E::_id_D2EB(_id_6656("perk_0", var_0, var_1));
  var_2 = _id_674F();

  if(var_2 != "perk_none") {
    var_3 = level._id_1455["perk_0"][var_2];
    _id_074E::_id_D2EB(_id_6656("perk_0", var_3._id_C189, var_1));
  }
}

_id_6656(var_0, var_1, var_2) {
  return level._id_1455[var_0][var_1]._id_FD9C[var_2]._id_C189;
}

_id_664F() {
  return self getplayerdata("cp", "alienSession", "perk_0_level");
}

_id_6650() {
  return self getplayerdata("cp", "alienSession", "perk_1_level");
}

_id_6651() {
  return self getplayerdata("cp", "alienSession", "perk_2_level");
}