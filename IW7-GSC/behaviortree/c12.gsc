/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: behaviortree\c12.gsc
********************************/

func_3643(param_00) {
  return lib_0C08::func_8C25(param_00, 1);
}

func_3644(param_00) {
  return lib_0A09::func_5AEA(param_00, 50);
}

func_3645(param_00) {
  return lib_0A09::func_5AEA(param_00, 1000);
}

func_3646(param_00) {
  return lib_0C08::func_FB1E(param_00, "left");
}

func_3647(param_00) {
  return lib_0C08::func_A006(param_00, "minigun");
}

func_3648(param_00) {
  return lib_0C08::func_A006(param_00, "rocket");
}

func_3649(param_00) {
  return lib_0C08::func_FB1E(param_00, "right");
}

func_2AD0() {
  if(isDefined(level.var_119E["c12"])) {
    return;
  }

  var_00 = spawnStruct();
  var_00.var_1581 = [];
  var_00.var_1581[0] = ::lib_0C0A::func_35A6;
  var_00.var_1581[1] = ::lib_0C08::func_12E90;
  var_00.var_1581[2] = ::lib_0A09::func_9307;
  var_00.var_1581[3] = ::lib_0A16::func_12F2C;
  var_00.var_1581[4] = ::lib_0A15::func_9F3E;
  var_00.var_1581[5] = ::lib_0C08::func_12F13;
  var_00.var_1581[6] = ::lib_0C08::func_128A9;
  var_00.var_1581[7] = ::lib_0C08::func_E602;
  var_00.var_1581[8] = ::scripts\aitypes\combat::func_9E40;
  var_00.var_1581[9] = ::lib_0C08::func_97EB;
  var_00.var_1581[10] = ::lib_0C08::func_12E77;
  var_00.var_1581[11] = ::lib_0C08::func_9D5B;
  var_00.var_1581[12] = ::lib_0C08::func_B4EA;
  var_00.var_1581[13] = ::lib_0C08::func_2CD6;
  var_00.var_1581[14] = ::func_3643;
  var_00.var_1581[15] = ::lib_0C08::func_F814;
  var_00.var_1581[16] = ::func_3644;
  var_00.var_1581[17] = ::lib_0A09::func_FAF6;
  var_00.var_1581[18] = ::lib_0C08::func_12845;
  var_00.var_1581[19] = ::func_3645;
  var_00.var_1581[20] = ::lib_0C08::func_1382A;
  var_00.var_1581[21] = ::lib_0C08::func_41B3;
  var_00.var_1581[22] = ::lib_0C08::func_8C23;
  var_00.var_1581[23] = ::lib_0C08::func_FE8F;
  var_00.var_1581[24] = ::lib_0C08::shouldshoot;
  var_00.var_1581[25] = ::lib_0C08::func_FE8E;
  var_00.var_1581[26] = ::func_3646;
  var_00.var_1581[27] = ::lib_0C08::func_A005;
  var_00.var_1581[28] = ::func_3647;
  var_00.var_1581[29] = ::lib_0C08::func_FEE3;
  var_00.var_1581[30] = ::lib_0C08::func_FEE6;
  var_00.var_1581[31] = ::lib_0C08::func_FEE4;
  var_00.var_1581[32] = ::func_3648;
  var_00.var_1581[33] = ::lib_0C08::func_FEE7;
  var_00.var_1581[34] = ::lib_0C08::func_FEEA;
  var_00.var_1581[35] = ::lib_0C08::func_FEE8;
  var_00.var_1581[36] = ::func_3649;
  var_00.var_1581[37] = ::lib_0C08::func_40E9;
  level.var_119E["c12"] = var_00;
}

func_DEE8() {
  func_2AD0();
  btregistertree("c12");
}