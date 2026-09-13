/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_15de7dc4d21f1da3.gsc
***********************************************/

init() {
  if(!isDefined(level._id_170A29E0C0E257B7)) {
    level._id_170A29E0C0E257B7 = [];
    level._id_6D69E5FDE1AE8E9E = [];
  }

  level thread _id_5B1D60872D5F7D1F();
}

_id_5B1D60872D5F7D1F() {
  for(;;) {
    level waittill("connected", player);
    player thread _id_6B1FCEC8B1789D65();
    player thread _id_DF97371D5DCEE28C();
  }
}

_id_BA46CF958AE0CBDA(callback) {
  if(!isDefined(level._id_170A29E0C0E257B7))
    level._id_170A29E0C0E257B7 = [];

  level._id_170A29E0C0E257B7[level._id_170A29E0C0E257B7.size] = callback;
}

_id_7F4116EBA8C42FA0(_id_3CA8193AAA529C6F) {
  _id_50F783A5617F8940 = [];

  foreach(callback in level._id_170A29E0C0E257B7) {
    if(_id_3CA8193AAA529C6F != callback)
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = callback;
  }

  level._id_170A29E0C0E257B7 = _id_50F783A5617F8940;
}

_id_39027364B9C16127(callback) {
  if(!isDefined(level._id_6D69E5FDE1AE8E9E))
    level._id_6D69E5FDE1AE8E9E = [];

  level._id_6D69E5FDE1AE8E9E[level._id_6D69E5FDE1AE8E9E.size] = callback;
}

_id_E7AAE5B770C4747B(_id_2D2DEDDADD177B34) {
  _id_50F783A5617F8940 = [];

  foreach(callback in level._id_6D69E5FDE1AE8E9E) {
    if(_id_2D2DEDDADD177B34 != callback)
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = callback;
  }

  level._id_6D69E5FDE1AE8E9E = _id_50F783A5617F8940;
}

_id_6B1FCEC8B1789D65() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_dropped", _id_D6E009CADEDB95AE, _id_06B62DB6EEC868E2);

    foreach(callback in level._id_170A29E0C0E257B7)
    self[[callback]](_id_D6E009CADEDB95AE, _id_06B62DB6EEC868E2);
  }
}

_id_DF97371D5DCEE28C() {
  self endon("disconnect");

  for(;;) {
    self waittill("dropped_weapon_scriptable", _id_0D2346943E5CB1F5, _id_EA2C512C875AB6F6, _id_B947C76FCEF1AFDB);

    foreach(callback in level._id_6D69E5FDE1AE8E9E)
    self[[callback]](_id_0D2346943E5CB1F5, _id_EA2C512C875AB6F6, _id_B947C76FCEF1AFDB);
  }
}