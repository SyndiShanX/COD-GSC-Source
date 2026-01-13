/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\enemy_combatant.gsc
*********************************************/

func_63EC(var_0) {
  return lib_0A0A::shouldrefundsuper(var_0, 0.3);
}

func_63ED(var_0) {
  return lib_0A0A::func_4746(var_0, "hide");
}

func_63EE(var_0) {
  return lib_0A0A::func_B4ED(var_0, 1);
}

func_63EF(var_0) {
  return lib_0A0A::shouldrefundsuper(var_0, 0);
}

func_63F0(var_0) {
  return lib_0A09::func_E478(var_0, isDefined(self.a.var_2411) && self.a.var_2411 && scripts\anim\utility_common::canseeenemy());
}

func_63F1(var_0) {
  return lib_0A09::func_E478(var_0, scripts\anim\utility_common::cansuppressenemyfromexposed());
}

func_63F2(var_0) {
  return lib_0A09::func_9FEE(var_0, level.var_11813);
}

func_63F3(var_0) {
  return lib_0A09::func_9309(var_0, level.player);
}

func_63F4(var_0) {
  return lib_0A0A::shouldrefundsuper(var_0, 0.1);
}

func_63F5(var_0) {
  return lib_0A09::func_E478(var_0, isDefined(self.var_190C) || scripts\anim\utility_common::enemyishiding());
}

func_63F6(var_0) {
  return lib_0A12::func_9ED9(var_0, "continue");
}

func_63F7(var_0) {
  return lib_0A12::allowreload(var_0, self.objective_playermask_showto);
}

func_63F8(var_0) {
  return lib_0A12::func_9ED9(var_0, "stop");
}

func_63F9(var_0) {
  return lib_0A12::allowreload(var_0, 0);
}

func_2AD0() {
  if(isDefined(level.var_119E["enemy_combatant"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = ::lib_0A08::func_103F5;
  var_0.var_1581[1] = ::lib_0A10::func_9898;
  var_0.var_1581[2] = ::lib_0A08::func_97EC;
  var_0.var_1581[3] = ::scripts\aitypes\combat::func_12E90;
  var_0.var_1581[4] = ::lib_0A09::func_9307;
  var_0.var_1581[5] = ::scripts\aitypes\combat::func_93B6;
  var_0.var_1581[6] = ::scripts\aitypes\combat::func_2753;
  var_0.var_1581[7] = ::scripts\aitypes\combat::func_1384E;
  var_0.var_1581[8] = ::scripts\aitypes\combat::func_275A;
  var_0.var_1581[9] = ::scripts\aitypes\combat::func_24D4;
  var_0.var_1581[10] = ::lib_0A0A::func_41A3;
  var_0.var_1581[11] = ::scripts\aitypes\combat::func_E84D;
  var_0.var_1581[12] = ::scripts\aitypes\combat::func_E84E;
  var_0.var_1581[13] = ::scripts\aitypes\combat::func_E84F;
  var_0.var_1581[14] = ::lib_0A0C::func_10020;
  var_0.var_1581[15] = ::lib_0A0C::func_85D3;
  var_0.var_1581[16] = ::lib_0A0C::func_85D4;
  var_0.var_1581[17] = ::lib_0A0C::func_1001E;
  var_0.var_1581[18] = ::lib_0A0C::isspectatingplayer;
  var_0.var_1581[19] = ::lib_0A0C::spectateclientnum;
  var_0.var_1581[20] = ::lib_0A0C::_meth_85B1;
  var_0.var_1581[21] = ::lib_0A17::func_9308;
  var_0.var_1581[22] = ::lib_0A17::func_12F2D;
  var_0.var_1581[23] = ::scripts\aitypes\combat::func_9E40;
  var_0.var_1581[24] = ::scripts\aitypes\combat::func_12F64;
  var_0.var_1581[25] = ::scripts\aitypes\combat::func_12F1D;
  var_0.var_1581[26] = ::scripts\aitypes\combat::func_12E93;
  var_0.var_1581[27] = ::lib_0A19::func_12F5C;
  var_0.var_1581[28] = ::lib_0A0A::func_12E92;
  var_0.var_1581[29] = ::lib_0A0A::func_9E43;
  var_0.var_1581[30] = ::lib_0A0A::func_97EF;
  var_0.var_1581[31] = ::lib_0A0A::func_FFE1;
  var_0.var_1581[32] = ::lib_0A0A::func_12DDF;
  var_0.var_1581[33] = ::scripts\aitypes\combat::func_B4EB;
  var_0.var_1581[34] = ::scripts\aitypes\combat::func_FE88;
  var_0.var_1581[35] = ::scripts\aitypes\combat::func_FE6E;
  var_0.var_1581[36] = ::scripts\aitypes\combat::func_FE83;
  var_0.var_1581[37] = ::func_63EC;
  var_0.var_1581[38] = ::lib_0A0A::func_4742;
  var_0.var_1581[39] = ::lib_0A0A::func_98C1;
  var_0.var_1581[40] = ::lib_0A0A::func_116FD;
  var_0.var_1581[41] = ::lib_0A09::func_E475;
  var_0.var_1581[42] = ::func_63ED;
  var_0.var_1581[43] = ::lib_0A0A::func_BDF3;
  var_0.var_1581[44] = ::lib_0A0A::func_4712;
  var_0.var_1581[45] = ::lib_0A0A::func_97E4;
  var_0.var_1581[46] = ::lib_0A0A::func_116F1;
  var_0.var_1581[47] = ::lib_0A09::func_E470;
  var_0.var_1581[48] = ::func_63EE;
  var_0.var_1581[49] = ::lib_0A0A::func_2546;
  var_0.var_1581[50] = ::func_63EF;
  var_0.var_1581[51] = ::lib_0A0A::func_9D97;
  var_0.var_1581[52] = ::lib_0A0A::func_4721;
  var_0.var_1581[53] = ::lib_0A0A::func_9814;
  var_0.var_1581[54] = ::lib_0A09::cointoss;
  var_0.var_1581[55] = ::lib_0A0A::func_B4ED;
  var_0.var_1581[56] = ::lib_0A0A::func_B019;
  var_0.var_1581[57] = ::func_63F0;
  var_0.var_1581[58] = ::lib_0A0A::func_9DDA;
  var_0.var_1581[59] = ::func_63F1;
  var_0.var_1581[60] = ::func_63F2;
  var_0.var_1581[61] = ::func_63F3;
  var_0.var_1581[62] = ::lib_0A0A::func_474F;
  var_0.var_1581[63] = ::lib_0A0A::func_98DB;
  var_0.var_1581[64] = ::lib_0A0A::func_11700;
  var_0.var_1581[65] = ::lib_0A0A::func_FFCC;
  var_0.var_1581[66] = ::lib_0A0A::func_4711;
  var_0.var_1581[67] = ::lib_0A0A::func_116F0;
  var_0.var_1581[68] = ::lib_0A0A::func_100AD;
  var_0.var_1581[69] = ::func_63F4;
  var_0.var_1581[70] = ::lib_0A0A::func_4726;
  var_0.var_1581[71] = ::lib_0A0A::func_9894;
  var_0.var_1581[72] = ::lib_0A0A::func_116F9;
  var_0.var_1581[73] = ::lib_0A0A::func_9D71;
  var_0.var_1581[74] = ::lib_0A0A::func_4749;
  var_0.var_1581[75] = ::lib_0A0A::func_471E;
  var_0.var_1581[76] = ::lib_0A0A::func_9803;
  var_0.var_1581[77] = ::lib_0A0A::func_116F4;
  var_0.var_1581[78] = ::func_63F5;
  var_0.var_1581[79] = ::lib_0A0A::func_9D40;
  var_0.var_1581[80] = ::lib_0A18::func_8BF7;
  var_0.var_1581[81] = ::lib_0A0A::func_10038;
  var_0.var_1581[82] = ::lib_0A0A::func_38CB;
  var_0.var_1581[83] = ::lib_0A0A::func_38E8;
  var_0.var_1581[84] = ::lib_0A0A::func_473E;
  var_0.var_1581[85] = ::lib_0A0A::func_116FC;
  var_0.var_1581[86] = ::lib_0A0A::func_453E;
  var_0.var_1581[87] = ::scripts\aitypes\combat::func_12F28;
  var_0.var_1581[88] = ::scripts\aitypes\melee::shouldmelee;
  var_0.var_1581[89] = ::scripts\aitypes\melee::melee_init;
  var_0.var_1581[90] = ::scripts\aitypes\melee::func_B5F0;
  var_0.var_1581[91] = ::scripts\aitypes\melee::func_B5E8;
  var_0.var_1581[92] = ::scripts\aitypes\melee::func_B5EE;
  var_0.var_1581[93] = ::scripts\aitypes\melee::func_5903;
  var_0.var_1581[94] = ::scripts\aitypes\melee::func_9896;
  var_0.var_1581[95] = ::scripts\aitypes\melee::func_41C6;
  var_0.var_1581[96] = ::scripts\aitypes\combat::func_8C24;
  var_0.var_1581[97] = ::lib_0A18::func_3929;
  var_0.var_1581[98] = ::lib_0A18::func_1182E;
  var_0.var_1581[99] = ::lib_0A18::func_1182C;
  var_0.var_1581[100] = ::lib_0A18::func_1182D;
  var_0.var_1581[101] = ::scripts\aitypes\combat::func_8BF6;
  var_0.var_1581[102] = ::lib_0A18::func_3928;
  var_0.var_1581[103] = ::lib_0A18::func_11812;
  var_0.var_1581[104] = ::lib_0A18::func_1180F;
  var_0.var_1581[105] = ::lib_0A18::func_11811;
  var_0.var_1581[106] = ::scripts\aitypes\combat::func_43EB;
  var_0.var_1581[107] = ::scripts\aitypes\combat::func_DF56;
  var_0.var_1581[108] = ::scripts\aitypes\combat::func_DF53;
  var_0.var_1581[109] = ::scripts\aitypes\combat::func_DF55;
  var_0.var_1581[110] = ::scripts\aitypes\combat::func_8BC6;
  var_0.var_1581[111] = ::scripts\aitypes\combat::func_2542;
  var_0.var_1581[112] = ::scripts\aitypes\combat::func_2544;
  var_0.var_1581[113] = ::scripts\aitypes\combat::func_2545;
  var_0.var_1581[114] = ::scripts\aitypes\combat::func_12E91;
  var_0.var_1581[115] = ::lib_0A12::func_C565;
  var_0.var_1581[116] = ::lib_0A12::func_F7B2;
  var_0.var_1581[117] = ::func_63F6;
  var_0.var_1581[118] = ::func_63F7;
  var_0.var_1581[119] = ::func_63F8;
  var_0.var_1581[120] = ::func_63F9;
  var_0.var_1581[121] = ::lib_0A12::func_D4A0;
  var_0.var_1581[122] = ::lib_0A09::func_E477;
  var_0.var_1581[123] = ::lib_09FC::func_57DF;
  level.var_119E["enemy_combatant"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("enemy_combatant");
}