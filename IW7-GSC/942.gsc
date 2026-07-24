/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 942.gsc
**************************************/

_id_63EC(var_0) {
  return _id_0A0A::shouldrefundsuper(var_0, 0.3);
}

_id_63ED(var_0) {
  return _id_0A0A::_id_4746(var_0, "hide");
}

_id_63EE(var_0) {
  return _id_0A0A::_id_B4ED(var_0, 1);
}

_id_63EF(var_0) {
  return _id_0A0A::shouldrefundsuper(var_0, 0);
}

_id_63F0(var_0) {
  return _id_0A09::_id_E478(var_0, isDefined(self.a._id_2411) && self.a._id_2411 && scripts\anim\utility_common::canseeenemy());
}

_id_63F1(var_0) {
  return _id_0A09::_id_E478(var_0, scripts\anim\utility_common::cansuppressenemyfromexposed());
}

_id_63F2(var_0) {
  return _id_0A09::_id_9FEE(var_0, anim._id_11813);
}

_id_63F3(var_0) {
  return _id_0A09::_id_9309(var_0, level.player);
}

_id_63F4(var_0) {
  return _id_0A0A::shouldrefundsuper(var_0, 0.1);
}

_id_63F5(var_0) {
  return _id_0A09::_id_E478(var_0, isDefined(self._id_190C) || scripts\anim\utility_common::enemyishiding());
}

_id_63F6(var_0) {
  return _id_0A12::_id_9ED9(var_0, "continue");
}

_id_63F7(var_0) {
  return _id_0A12::_id_8471(var_0, self.goalradius);
}

_id_63F8(var_0) {
  return _id_0A12::_id_9ED9(var_0, "stop");
}

_id_63F9(var_0) {
  return _id_0A12::_id_8471(var_0, 0);
}

_id_2AD0() {
  if(isDefined(level._id_119E["enemy_combatant"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0A08::_id_103F5;
  var_0._id_1581[1] = _id_0A10::_id_9898;
  var_0._id_1581[2] = _id_0A08::_id_97EC;
  var_0._id_1581[3] = ::scripts\aitypes\combat::_id_12E90;
  var_0._id_1581[4] = _id_0A09::_id_9307;
  var_0._id_1581[5] = ::scripts\aitypes\combat::_id_93B6;
  var_0._id_1581[6] = ::scripts\aitypes\combat::_id_2753;
  var_0._id_1581[7] = ::scripts\aitypes\combat::_id_1384E;
  var_0._id_1581[8] = ::scripts\aitypes\combat::_id_275A;
  var_0._id_1581[9] = ::scripts\aitypes\combat::_id_24D4;
  var_0._id_1581[10] = _id_0A0A::_id_41A3;
  var_0._id_1581[11] = ::scripts\aitypes\combat::_id_E84D;
  var_0._id_1581[12] = ::scripts\aitypes\combat::_id_E84E;
  var_0._id_1581[13] = ::scripts\aitypes\combat::_id_E84F;
  var_0._id_1581[14] = _id_0A0C::_id_10020;
  var_0._id_1581[15] = _id_0A0C::_id_85D3;
  var_0._id_1581[16] = _id_0A0C::_id_85D4;
  var_0._id_1581[17] = _id_0A0C::_id_1001E;
  var_0._id_1581[18] = _id_0A0C::_id_85AF;
  var_0._id_1581[19] = _id_0A0C::_id_85B0;
  var_0._id_1581[20] = _id_0A0C::_id_85B1;
  var_0._id_1581[21] = _id_0A17::_id_9308;
  var_0._id_1581[22] = _id_0A17::_id_12F2D;
  var_0._id_1581[23] = ::scripts\aitypes\combat::_id_9E40;
  var_0._id_1581[24] = ::scripts\aitypes\combat::_id_12F64;
  var_0._id_1581[25] = ::scripts\aitypes\combat::_id_12F1D;
  var_0._id_1581[26] = ::scripts\aitypes\combat::_id_12E93;
  var_0._id_1581[27] = _id_0A19::_id_12F5C;
  var_0._id_1581[28] = _id_0A0A::_id_12E92;
  var_0._id_1581[29] = _id_0A0A::_id_9E43;
  var_0._id_1581[30] = _id_0A0A::_id_97EF;
  var_0._id_1581[31] = _id_0A0A::_id_FFE1;
  var_0._id_1581[32] = _id_0A0A::_id_12DDF;
  var_0._id_1581[33] = ::scripts\aitypes\combat::_id_B4EB;
  var_0._id_1581[34] = ::scripts\aitypes\combat::_id_FE88;
  var_0._id_1581[35] = ::scripts\aitypes\combat::_id_FE6E;
  var_0._id_1581[36] = ::scripts\aitypes\combat::_id_FE83;
  var_0._id_1581[37] = ::_id_63EC;
  var_0._id_1581[38] = _id_0A0A::_id_4742;
  var_0._id_1581[39] = _id_0A0A::_id_98C1;
  var_0._id_1581[40] = _id_0A0A::_id_116FD;
  var_0._id_1581[41] = _id_0A09::_id_E475;
  var_0._id_1581[42] = ::_id_63ED;
  var_0._id_1581[43] = _id_0A0A::_id_BDF3;
  var_0._id_1581[44] = _id_0A0A::_id_4712;
  var_0._id_1581[45] = _id_0A0A::_id_97E4;
  var_0._id_1581[46] = _id_0A0A::_id_116F1;
  var_0._id_1581[47] = _id_0A09::_id_E470;
  var_0._id_1581[48] = ::_id_63EE;
  var_0._id_1581[49] = _id_0A0A::_id_2546;
  var_0._id_1581[50] = ::_id_63EF;
  var_0._id_1581[51] = _id_0A0A::_id_9D97;
  var_0._id_1581[52] = _id_0A0A::_id_4721;
  var_0._id_1581[53] = _id_0A0A::_id_9814;
  var_0._id_1581[54] = _id_0A09::cointoss;
  var_0._id_1581[55] = _id_0A0A::_id_B4ED;
  var_0._id_1581[56] = _id_0A0A::_id_B019;
  var_0._id_1581[57] = ::_id_63F0;
  var_0._id_1581[58] = _id_0A0A::_id_9DDA;
  var_0._id_1581[59] = ::_id_63F1;
  var_0._id_1581[60] = ::_id_63F2;
  var_0._id_1581[61] = ::_id_63F3;
  var_0._id_1581[62] = _id_0A0A::_id_474F;
  var_0._id_1581[63] = _id_0A0A::_id_98DB;
  var_0._id_1581[64] = _id_0A0A::_id_11700;
  var_0._id_1581[65] = _id_0A0A::_id_FFCC;
  var_0._id_1581[66] = _id_0A0A::_id_4711;
  var_0._id_1581[67] = _id_0A0A::_id_116F0;
  var_0._id_1581[68] = _id_0A0A::_id_100AD;
  var_0._id_1581[69] = ::_id_63F4;
  var_0._id_1581[70] = _id_0A0A::_id_4726;
  var_0._id_1581[71] = _id_0A0A::_id_9894;
  var_0._id_1581[72] = _id_0A0A::_id_116F9;
  var_0._id_1581[73] = _id_0A0A::_id_9D71;
  var_0._id_1581[74] = _id_0A0A::_id_4749;
  var_0._id_1581[75] = _id_0A0A::_id_471E;
  var_0._id_1581[76] = _id_0A0A::_id_9803;
  var_0._id_1581[77] = _id_0A0A::_id_116F4;
  var_0._id_1581[78] = ::_id_63F5;
  var_0._id_1581[79] = _id_0A0A::_id_9D40;
  var_0._id_1581[80] = _id_0A18::_id_8BF7;
  var_0._id_1581[81] = _id_0A0A::_id_10038;
  var_0._id_1581[82] = _id_0A0A::_id_38CB;
  var_0._id_1581[83] = _id_0A0A::_id_38E8;
  var_0._id_1581[84] = _id_0A0A::_id_473E;
  var_0._id_1581[85] = _id_0A0A::_id_116FC;
  var_0._id_1581[86] = _id_0A0A::_id_453E;
  var_0._id_1581[87] = ::scripts\aitypes\combat::_id_12F28;
  var_0._id_1581[88] = ::scripts\aitypes\melee::shouldmelee;
  var_0._id_1581[89] = ::scripts\aitypes\melee::melee_init;
  var_0._id_1581[90] = ::scripts\aitypes\melee::_id_B5F0;
  var_0._id_1581[91] = ::scripts\aitypes\melee::_id_B5E8;
  var_0._id_1581[92] = ::scripts\aitypes\melee::_id_B5EE;
  var_0._id_1581[93] = ::scripts\aitypes\melee::_id_5903;
  var_0._id_1581[94] = ::scripts\aitypes\melee::_id_9896;
  var_0._id_1581[95] = ::scripts\aitypes\melee::_id_41C6;
  var_0._id_1581[96] = ::scripts\aitypes\combat::_id_8C24;
  var_0._id_1581[97] = _id_0A18::_id_3929;
  var_0._id_1581[98] = _id_0A18::_id_1182E;
  var_0._id_1581[99] = _id_0A18::_id_1182C;
  var_0._id_1581[100] = _id_0A18::_id_1182D;
  var_0._id_1581[101] = ::scripts\aitypes\combat::_id_8BF6;
  var_0._id_1581[102] = _id_0A18::_id_3928;
  var_0._id_1581[103] = _id_0A18::_id_11812;
  var_0._id_1581[104] = _id_0A18::_id_1180F;
  var_0._id_1581[105] = _id_0A18::_id_11811;
  var_0._id_1581[106] = ::scripts\aitypes\combat::_id_43EB;
  var_0._id_1581[107] = ::scripts\aitypes\combat::_id_DF56;
  var_0._id_1581[108] = ::scripts\aitypes\combat::_id_DF53;
  var_0._id_1581[109] = ::scripts\aitypes\combat::_id_DF55;
  var_0._id_1581[110] = ::scripts\aitypes\combat::_id_8BC6;
  var_0._id_1581[111] = ::scripts\aitypes\combat::_id_2542;
  var_0._id_1581[112] = ::scripts\aitypes\combat::_id_2544;
  var_0._id_1581[113] = ::scripts\aitypes\combat::_id_2545;
  var_0._id_1581[114] = ::scripts\aitypes\combat::_id_12E91;
  var_0._id_1581[115] = _id_0A12::_id_C565;
  var_0._id_1581[116] = _id_0A12::_id_F7B2;
  var_0._id_1581[117] = ::_id_63F6;
  var_0._id_1581[118] = ::_id_63F7;
  var_0._id_1581[119] = ::_id_63F8;
  var_0._id_1581[120] = ::_id_63F9;
  var_0._id_1581[121] = _id_0A12::_id_D4A0;
  var_0._id_1581[122] = _id_0A09::_id_E477;
  var_0._id_1581[123] = _id_09FC::_id_57DF;
  level._id_119E["enemy_combatant"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("enemy_combatant");
}