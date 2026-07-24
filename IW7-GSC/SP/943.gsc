/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 943.gsc
**************************************/

_id_A3C3(var_0) {
  return _id_0A0D::_id_F711(var_0, "fly");
}

_id_A3C4(var_0) {
  return _id_0A0D::_id_F711(var_0, "hover");
}

_id_A3C5(var_0) {
  return _id_0A0D::_id_F706(var_0, "shoot_at_will");
}

_id_A3C6(var_0) {
  return _id_0A0D::_id_F7C9(var_0, "face enemy");
}

_id_A3C7(var_0) {
  return _id_0A0D::_id_6CAB(var_0, "spline");
}

_id_A3C8(var_0) {
  return _id_0A0D::_id_F85B(var_0, "escape");
}

_id_A3C9(var_0) {
  return _id_0A0D::_id_E7B8(var_0, 1.3);
}

_id_A3CA(var_0) {
  return _id_0A0D::_id_6CAB(var_0, "escape");
}

_id_A3CB(var_0) {
  return _id_0A0D::_id_F72A(var_0, 2048);
}

_id_A3CC(var_0) {
  return _id_0A0D::_id_F7C9(var_0, "face motion");
}

_id_A3CD(var_0) {
  return _id_0A0D::_id_6CAB(var_0, "attack");
}

_id_A3CE(var_0) {
  return _id_0A0D::_id_F672(var_0, "face motion");
}

_id_A3CF(var_0) {
  return _id_0A0D::_id_F85B(var_0, "combat");
}

_id_A3D0(var_0) {
  return _id_0A0D::_id_F85B(var_0, "patrol");
}

_id_A3D1(var_0) {
  return _id_0A0D::_id_E7B8(var_0, 0.7);
}

_id_2AD0() {
  if(isDefined(level._id_119E["jackal"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0A0D::_id_9D44;
  var_0._id_1581[1] = _id_0A0D::_id_593B;
  var_0._id_1581[2] = _id_0A0D::_id_41E4;
  var_0._id_1581[3] = _id_0A0D::_id_10015;
  var_0._id_1581[4] = _id_0A0D::_id_9E76;
  var_0._id_1581[5] = _id_0A0D::_id_9E00;
  var_0._id_1581[6] = _id_0A0D::_id_61C4;
  var_0._id_1581[7] = _id_0A0D::_id_10016;
  var_0._id_1581[8] = ::_id_A3C3;
  var_0._id_1581[9] = _id_0A0D::_id_7232;
  var_0._id_1581[10] = _id_0A0D::_id_7234;
  var_0._id_1581[11] = _id_0A0D::_id_9E77;
  var_0._id_1581[12] = ::_id_A3C4;
  var_0._id_1581[13] = _id_0A0D::follow;
  var_0._id_1581[14] = _id_0A0D::_id_7221;
  var_0._id_1581[15] = _id_0A0D::_id_7231;
  var_0._id_1581[16] = _id_0A0D::_id_10027;
  var_0._id_1581[17] = _id_0A0D::_id_10028;
  var_0._id_1581[18] = _id_0A0D::_id_10075;
  var_0._id_1581[19] = _id_0A0D::_id_F748;
  var_0._id_1581[20] = _id_0A0D::_id_136C0;
  var_0._id_1581[21] = _id_0A0D::_id_98E0;
  var_0._id_1581[22] = _id_0A0D::_id_11704;
  var_0._id_1581[23] = _id_0A0D::_id_41B6;
  var_0._id_1581[24] = ::_id_A3C5;
  var_0._id_1581[25] = ::_id_A3C6;
  var_0._id_1581[26] = _id_0A0D::_id_1002B;
  var_0._id_1581[27] = _id_0A0D::_id_90F2;
  var_0._id_1581[28] = _id_0A09::_id_E475;
  var_0._id_1581[29] = _id_0A0D::_id_1003F;
  var_0._id_1581[30] = _id_0A0D::_id_9DE3;
  var_0._id_1581[31] = _id_0A0D::_id_8C2C;
  var_0._id_1581[32] = _id_0A0D::_id_10017;
  var_0._id_1581[33] = _id_0A0D::_id_B4DB;
  var_0._id_1581[34] = _id_0A0D::_id_7248;
  var_0._id_1581[35] = _id_0A0D::_id_724A;
  var_0._id_1581[36] = _id_0A0D::_id_724B;
  var_0._id_1581[37] = ::_id_A3C7;
  var_0._id_1581[38] = _id_0A0D::_id_1000C;
  var_0._id_1581[39] = ::_id_A3C8;
  var_0._id_1581[40] = _id_0A0D::_id_F6EC;
  var_0._id_1581[41] = _id_0A0D::validatehighpriorityflag;
  var_0._id_1581[42] = ::_id_A3C9;
  var_0._id_1581[43] = _id_0A0D::_id_1289A;
  var_0._id_1581[44] = ::_id_A3CA;
  var_0._id_1581[45] = ::_id_A3CB;
  var_0._id_1581[46] = ::_id_A3CC;
  var_0._id_1581[47] = _id_0A0D::_id_8C3A;
  var_0._id_1581[48] = _id_0A0D::_id_FFBE;
  var_0._id_1581[49] = _id_0A0D::_id_FFD6;
  var_0._id_1581[50] = _id_0A0D::_id_10E66;
  var_0._id_1581[51] = ::_id_A3CD;
  var_0._id_1581[52] = ::_id_A3CE;
  var_0._id_1581[53] = _id_0A0D::_id_98DF;
  var_0._id_1581[54] = _id_0A0D::_id_11703;
  var_0._id_1581[55] = _id_0A0D::_id_1003E;
  var_0._id_1581[56] = _id_0A0D::_id_C936;
  var_0._id_1581[57] = _id_0A0D::_id_1006C;
  var_0._id_1581[58] = ::_id_A3CF;
  var_0._id_1581[59] = ::_id_A3D0;
  var_0._id_1581[60] = _id_0A0D::_id_FFD8;
  var_0._id_1581[61] = ::_id_A3D1;
  level._id_119E["jackal"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("jackal");
}