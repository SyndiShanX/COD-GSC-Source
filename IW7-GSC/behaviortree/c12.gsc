/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\c12.gsc
**************************************/

_id_3643(var_0) {
  return _id_0C08::_id_8C25(var_0, 1);
}

_id_3644(var_0) {
  return _id_0A09::_id_5AEA(var_0, 50);
}

_id_3645(var_0) {
  return _id_0A09::_id_5AEA(var_0, 1000);
}

_id_3646(var_0) {
  return _id_0C08::_id_FB1E(var_0, "left");
}

_id_3647(var_0) {
  return _id_0C08::_id_A006(var_0, "minigun");
}

_id_3648(var_0) {
  return _id_0C08::_id_A006(var_0, "rocket");
}

_id_3649(var_0) {
  return _id_0C08::_id_FB1E(var_0, "right");
}

_id_2AD0() {
  if(isDefined(level._id_119E["c12"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0C0A::_id_35A6;
  var_0._id_1581[1] = _id_0C08::_id_12E90;
  var_0._id_1581[2] = _id_0A09::_id_9307;
  var_0._id_1581[3] = _id_0A16::_id_12F2C;
  var_0._id_1581[4] = _id_0A15::_id_9F3E;
  var_0._id_1581[5] = _id_0C08::_id_12F13;
  var_0._id_1581[6] = _id_0C08::_id_128A9;
  var_0._id_1581[7] = _id_0C08::_id_E602;
  var_0._id_1581[8] = ::scripts\aitypes\combat::_id_9E40;
  var_0._id_1581[9] = _id_0C08::_id_97EB;
  var_0._id_1581[10] = _id_0C08::_id_12E77;
  var_0._id_1581[11] = _id_0C08::_id_9D5B;
  var_0._id_1581[12] = _id_0C08::_id_B4EA;
  var_0._id_1581[13] = _id_0C08::_id_2CD6;
  var_0._id_1581[14] = ::_id_3643;
  var_0._id_1581[15] = _id_0C08::_id_F814;
  var_0._id_1581[16] = ::_id_3644;
  var_0._id_1581[17] = _id_0A09::_id_FAF6;
  var_0._id_1581[18] = _id_0C08::_id_12845;
  var_0._id_1581[19] = ::_id_3645;
  var_0._id_1581[20] = _id_0C08::_id_1382A;
  var_0._id_1581[21] = _id_0C08::_id_41B3;
  var_0._id_1581[22] = _id_0C08::_id_8C23;
  var_0._id_1581[23] = _id_0C08::_id_FE8F;
  var_0._id_1581[24] = _id_0C08::shouldshoot;
  var_0._id_1581[25] = _id_0C08::_id_FE8E;
  var_0._id_1581[26] = ::_id_3646;
  var_0._id_1581[27] = _id_0C08::_id_A005;
  var_0._id_1581[28] = ::_id_3647;
  var_0._id_1581[29] = _id_0C08::_id_FEE3;
  var_0._id_1581[30] = _id_0C08::_id_FEE6;
  var_0._id_1581[31] = _id_0C08::_id_FEE4;
  var_0._id_1581[32] = ::_id_3648;
  var_0._id_1581[33] = _id_0C08::_id_FEE7;
  var_0._id_1581[34] = _id_0C08::_id_FEEA;
  var_0._id_1581[35] = _id_0C08::_id_FEE8;
  var_0._id_1581[36] = ::_id_3649;
  var_0._id_1581[37] = _id_0C08::_id_40E9;
  level._id_119E["c12"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("c12");
}