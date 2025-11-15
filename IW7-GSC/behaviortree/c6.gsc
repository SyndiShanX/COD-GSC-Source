/*******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: behaviortree\c6.gsc
*******************************/

func_33C0(param_00) {
  return lib_0A09::func_5AEA(param_00, 5);
}

func_33C1(param_00) {
  return lib_0A0A::shouldrefundsuper(param_00, 0.3);
}

func_33C2(param_00) {
  return lib_0A0A::func_4746(param_00, "hide");
}

func_33C3(param_00) {
  return lib_0A0A::func_B4ED(param_00, 1);
}

func_33C4(param_00) {
  return lib_0A0A::shouldrefundsuper(param_00, 0);
}

func_33C5(param_00) {
  return lib_0A09::func_E478(param_00, isDefined(self.a.var_2411) && self.a.var_2411 && scripts\anim\utility_common::canseeenemy());
}

func_33C6(param_00) {
  return lib_0A09::func_E478(param_00, scripts\anim\utility_common::cansuppressenemyfromexposed());
}

func_33C7(param_00) {
  return lib_0A09::func_9FEE(param_00, level.var_11813);
}

func_33C8(param_00) {
  return lib_0A09::func_9309(param_00, level.player);
}

func_33C9(param_00) {
  return lib_0A0A::shouldrefundsuper(param_00, 0.1);
}

func_33CA(param_00) {
  return lib_0A09::func_E478(param_00, isDefined(self.var_190C) || scripts\anim\utility_common::enemyishiding());
}

func_33CB(param_00) {
  return lib_0A12::func_9ED9(param_00, "continue");
}

func_33CC(param_00) {
  return lib_0A12::allowreload(param_00, self.objective_playermask_showto);
}

func_33CD(param_00) {
  return lib_0A12::func_9ED9(param_00, "stop");
}

func_33CE(param_00) {
  return lib_0A12::allowreload(param_00, 0);
}

func_2AD0() {
  if(isDefined(level.var_119E["c6"])) {
    return;
  }

  var_00 = spawnStruct();
  var_00.var_1581 = [];
  var_00.var_1581[0] = ::lib_0BF9::func_33FF;
  var_00.var_1581[1] = ::lib_0A08::func_97EC;
  var_00.var_1581[2] = ::func_33C0;
  var_00.var_1581[3] = ::lib_0A09::func_FAF6;
  var_00.var_1581[4] = ::scripts\aitypes\combat::func_12E90;
  var_00.var_1581[5] = ::lib_0A09::func_9307;
  var_00.var_1581[6] = ::scripts\aitypes\combat::func_93B6;
  var_00.var_1581[7] = ::lib_0BFE::func_8BE3;
  var_00.var_1581[8] = ::scripts\aitypes\combat::func_2753;
  var_00.var_1581[9] = ::scripts\aitypes\combat::func_1384E;
  var_00.var_1581[10] = ::scripts\aitypes\combat::func_275A;
  var_00.var_1581[11] = ::lib_0BFE::isnondismemberedmeleevsplayer;
  var_00.var_1581[12] = ::lib_0A0A::func_41A3;
  var_00.var_1581[13] = ::lib_0BFE::func_10072;
  var_00.var_1581[14] = ::lib_0BFE::func_F1FB;
  var_00.var_1581[15] = ::lib_0BFE::func_F1FC;
  var_00.var_1581[16] = ::lib_0BFE::func_5AA4;
  var_00.var_1581[17] = ::lib_0BFE::func_5AA5;
  var_00.var_1581[18] = ::lib_0BFE::func_10074;
  var_00.var_1581[19] = ::lib_0BFE::func_F20E;
  var_00.var_1581[20] = ::lib_0BFE::func_F20F;
  var_00.var_1581[21] = ::lib_0BFE::func_5AA6;
  var_00.var_1581[22] = ::lib_0BFE::func_9F3F;
  var_00.var_1581[23] = ::lib_0BFE::func_9F42;
  var_00.var_1581[24] = ::lib_0BFE::func_F20B;
  var_00.var_1581[25] = ::lib_0BFE::func_F20C;
  var_00.var_1581[26] = ::lib_0BFE::func_9F40;
  var_00.var_1581[27] = ::lib_0BFE::func_F202;
  var_00.var_1581[28] = ::lib_0BFE::func_F201;
  var_00.var_1581[29] = ::lib_0BFE::func_9F41;
  var_00.var_1581[30] = ::lib_0BFE::func_F209;
  var_00.var_1581[31] = ::lib_0BFE::func_F207;
  var_00.var_1581[32] = ::lib_0BFE::func_F206;
  var_00.var_1581[33] = ::lib_0BFE::func_F203;
  var_00.var_1581[34] = ::lib_0BFE::func_F205;
  var_00.var_1581[35] = ::lib_0BFE::func_F204;
  var_00.var_1581[36] = ::lib_0BFE::func_F208;
  var_00.var_1581[37] = ::lib_0BFE::func_9E21;
  var_00.var_1581[38] = ::lib_0BFE::func_8C54;
  var_00.var_1581[39] = ::lib_0BFE::func_8C53;
  var_00.var_1581[40] = ::scripts\aitypes\combat::func_B4EB;
  var_00.var_1581[41] = ::scripts\aitypes\combat::func_8BC6;
  var_00.var_1581[42] = ::scripts\aitypes\combat::func_FE88;
  var_00.var_1581[43] = ::scripts\aitypes\combat::func_FE6E;
  var_00.var_1581[44] = ::scripts\aitypes\combat::func_FE83;
  var_00.var_1581[45] = ::scripts\aitypes\combat::func_43EB;
  var_00.var_1581[46] = ::scripts\aitypes\combat::func_DF56;
  var_00.var_1581[47] = ::scripts\aitypes\combat::func_DF53;
  var_00.var_1581[48] = ::scripts\aitypes\combat::func_DF55;
  var_00.var_1581[49] = ::lib_0BFE::func_9FB8;
  var_00.var_1581[50] = ::lib_0BFE::func_12A76;
  var_00.var_1581[51] = ::lib_0BFE::func_12A75;
  var_00.var_1581[52] = ::scripts\aitypes\combat::func_8C0B;
  var_00.var_1581[53] = ::lib_0BFE::func_9D9F;
  var_00.var_1581[54] = ::lib_0BFD::func_487C;
  var_00.var_1581[55] = ::lib_0BFD::func_FFDD;
  var_00.var_1581[56] = ::scripts\aitypes\melee::melee_init;
  var_00.var_1581[57] = ::scripts\aitypes\melee::func_B5F0;
  var_00.var_1581[58] = ::lib_0BFD::func_4881;
  var_00.var_1581[59] = ::scripts\aitypes\melee::func_B5EE;
  var_00.var_1581[60] = ::lib_0BFD::func_487A;
  var_00.var_1581[61] = ::scripts\aitypes\melee::func_5903;
  var_00.var_1581[62] = ::scripts\aitypes\melee::func_9896;
  var_00.var_1581[63] = ::scripts\aitypes\melee::func_41C6;
  var_00.var_1581[64] = ::lib_0A0C::func_10020;
  var_00.var_1581[65] = ::lib_0BF9::_meth_846E;
  var_00.var_1581[66] = ::lib_0BF9::forceplaygestureviewmodel;
  var_00.var_1581[67] = ::lib_0BF9::_meth_85C3;
  var_00.var_1581[68] = ::lib_0BF9::_meth_85C1;
  var_00.var_1581[69] = ::lib_0BF9::_meth_85C2;
  var_00.var_1581[70] = ::lib_0A0C::func_1001E;
  var_00.var_1581[71] = ::lib_0BF9::func_336E;
  var_00.var_1581[72] = ::lib_0BF9::func_336F;
  var_00.var_1581[73] = ::lib_0BF9::func_3370;
  var_00.var_1581[74] = ::scripts\aitypes\combat::func_24D4;
  var_00.var_1581[75] = ::scripts\aitypes\combat::func_E84D;
  var_00.var_1581[76] = ::scripts\aitypes\combat::func_E84E;
  var_00.var_1581[77] = ::scripts\aitypes\combat::func_E84F;
  var_00.var_1581[78] = ::scripts\aitypes\combat::func_9E40;
  var_00.var_1581[79] = ::lib_0A19::func_12F5C;
  var_00.var_1581[80] = ::lib_0A0A::func_12E5D;
  var_00.var_1581[81] = ::lib_0A0A::func_12E92;
  var_00.var_1581[82] = ::lib_0A0A::func_9E43;
  var_00.var_1581[83] = ::lib_0A0A::func_97EF;
  var_00.var_1581[84] = ::lib_0A0A::func_FFE1;
  var_00.var_1581[85] = ::lib_0A0A::func_12DDF;
  var_00.var_1581[86] = ::func_33C1;
  var_00.var_1581[87] = ::lib_0A0A::func_4742;
  var_00.var_1581[88] = ::lib_0A0A::func_98C1;
  var_00.var_1581[89] = ::lib_0A0A::func_116FD;
  var_00.var_1581[90] = ::lib_0A09::func_E475;
  var_00.var_1581[91] = ::func_33C2;
  var_00.var_1581[92] = ::lib_0A0A::func_BDF3;
  var_00.var_1581[93] = ::lib_0A0A::func_4712;
  var_00.var_1581[94] = ::lib_0A0A::func_97E4;
  var_00.var_1581[95] = ::lib_0A0A::func_116F1;
  var_00.var_1581[96] = ::lib_0A09::func_E470;
  var_00.var_1581[97] = ::func_33C3;
  var_00.var_1581[98] = ::lib_0A0A::func_2546;
  var_00.var_1581[99] = ::func_33C4;
  var_00.var_1581[100] = ::lib_0A0A::func_9D97;
  var_00.var_1581[101] = ::lib_0A0A::func_4721;
  var_00.var_1581[102] = ::lib_0A0A::func_9814;
  var_00.var_1581[103] = ::lib_0A09::cointoss;
  var_00.var_1581[104] = ::lib_0A0A::func_B4ED;
  var_00.var_1581[105] = ::lib_0A0A::func_B019;
  var_00.var_1581[106] = ::func_33C5;
  var_00.var_1581[107] = ::lib_0A0A::func_9DDA;
  var_00.var_1581[108] = ::func_33C6;
  var_00.var_1581[109] = ::func_33C7;
  var_00.var_1581[110] = ::func_33C8;
  var_00.var_1581[111] = ::lib_0A0A::func_474F;
  var_00.var_1581[112] = ::lib_0A0A::func_98DB;
  var_00.var_1581[113] = ::lib_0A0A::func_11700;
  var_00.var_1581[114] = ::lib_0A0A::func_FFCC;
  var_00.var_1581[115] = ::lib_0A0A::func_4711;
  var_00.var_1581[116] = ::lib_0A0A::func_116F0;
  var_00.var_1581[117] = ::lib_0A0A::func_100AD;
  var_00.var_1581[118] = ::func_33C9;
  var_00.var_1581[119] = ::lib_0A0A::func_4726;
  var_00.var_1581[120] = ::lib_0A0A::func_9894;
  var_00.var_1581[121] = ::lib_0A0A::func_116F9;
  var_00.var_1581[122] = ::lib_0A0A::func_9D71;
  var_00.var_1581[123] = ::lib_0A0A::func_4749;
  var_00.var_1581[124] = ::lib_0A0A::func_471E;
  var_00.var_1581[125] = ::lib_0A0A::func_9803;
  var_00.var_1581[126] = ::lib_0A0A::func_116F4;
  var_00.var_1581[127] = ::func_33CA;
  var_00.var_1581[128] = ::lib_0A0A::func_9D40;
  var_00.var_1581[129] = ::lib_0A18::func_8BF7;
  var_00.var_1581[130] = ::lib_0A0A::func_10038;
  var_00.var_1581[131] = ::lib_0A0A::func_38CB;
  var_00.var_1581[132] = ::lib_0A0A::func_38E8;
  var_00.var_1581[133] = ::lib_0A0A::func_473E;
  var_00.var_1581[134] = ::lib_0A0A::func_116FC;
  var_00.var_1581[135] = ::lib_0A0A::func_453E;
  var_00.var_1581[136] = ::scripts\aitypes\combat::func_12F28;
  var_00.var_1581[137] = ::scripts\aitypes\melee::shouldmelee;
  var_00.var_1581[138] = ::scripts\aitypes\melee::func_B5E8;
  var_00.var_1581[139] = ::scripts\aitypes\combat::func_8BF6;
  var_00.var_1581[140] = ::lib_0BF9::func_335B;
  var_00.var_1581[141] = ::lib_0A18::func_11812;
  var_00.var_1581[142] = ::lib_0A18::func_1180F;
  var_00.var_1581[143] = ::lib_0A18::func_11811;
  var_00.var_1581[144] = ::scripts\aitypes\combat::func_2542;
  var_00.var_1581[145] = ::scripts\aitypes\combat::func_2544;
  var_00.var_1581[146] = ::scripts\aitypes\combat::func_2545;
  var_00.var_1581[147] = ::scripts\aitypes\combat::func_12E91;
  var_00.var_1581[148] = ::lib_0A12::func_C565;
  var_00.var_1581[149] = ::lib_0A12::func_F7B2;
  var_00.var_1581[150] = ::func_33CB;
  var_00.var_1581[151] = ::func_33CC;
  var_00.var_1581[152] = ::func_33CD;
  var_00.var_1581[153] = ::func_33CE;
  var_00.var_1581[154] = ::lib_0A12::func_D4A0;
  var_00.var_1581[155] = ::lib_0A09::func_E477;
  var_00.var_1581[156] = ::lib_09FC::func_57DF;
  level.var_119E["c6"] = var_00;
}

func_DEE8() {
  func_2AD0();
  btregistertree("c6");
}