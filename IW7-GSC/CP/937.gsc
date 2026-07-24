/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 937.gsc
**************************************/

_id_3387(var_0) {
  return scripts\aitypes\combat::_id_9E8B(var_0, 0);
}

_id_3388(var_0) {
  return _id_0A09::_id_13157(var_0, [distance(self.origin, self.enemy.origin), 512, 1024]);
}

_id_2AD0() {
  if(isDefined(level._id_119E["c6_mp"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0A14::_id_98C5;
  var_0._id_1581[1] = _id_0A0F::_id_9898;
  var_0._id_1581[2] = _id_0A07::_id_97ED;
  var_0._id_1581[3] = scripts\aitypes\combat::_id_12E90;
  var_0._id_1581[4] = _id_0BFA::_id_3E49;
  var_0._id_1581[5] = _id_0BFA::_id_3DE6;
  var_0._id_1581[6] = scripts\aitypes\combat::_id_9E40;
  var_0._id_1581[7] = _id_0BFA::updatetarget;
  var_0._id_1581[8] = _id_0A19::_id_12F5C;
  var_0._id_1581[9] = scripts\aitypes\combat::_id_12F28;
  var_0._id_1581[10] = _id_0BFA::_id_930A;
  var_0._id_1581[11] = _id_0BFA::_id_930D;
  var_0._id_1581[12] = _id_0BFA::_id_5813;
  var_0._id_1581[13] = _id_0BFA::_id_97FA;
  var_0._id_1581[14] = _id_0BFA::_id_116F3;
  var_0._id_1581[15] = scripts\aitypes\combat::_id_FE88;
  var_0._id_1581[16] = scripts\aitypes\combat::_id_FE6E;
  var_0._id_1581[17] = scripts\aitypes\combat::_id_FE83;
  var_0._id_1581[18] = _id_0A09::_id_E475;
  var_0._id_1581[19] = scripts\aitypes\melee::shouldmelee;
  var_0._id_1581[20] = scripts\aitypes\melee::melee_init;
  var_0._id_1581[21] = scripts\aitypes\melee::_id_B5F0;
  var_0._id_1581[22] = scripts\aitypes\melee::_id_B5E8;
  var_0._id_1581[23] = scripts\aitypes\melee::_id_B5EE;
  var_0._id_1581[24] = scripts\aitypes\melee::_id_5903;
  var_0._id_1581[25] = scripts\aitypes\melee::_id_9896;
  var_0._id_1581[26] = scripts\aitypes\melee::_id_41C6;
  var_0._id_1581[27] = scripts\aitypes\combat::_id_8BF6;
  var_0._id_1581[28] = _id_0A18::_id_8BF7;
  var_0._id_1581[29] = scripts\aitypes\combat::_id_B4EB;
  var_0._id_1581[30] = _id_0A18::_id_3928;
  var_0._id_1581[31] = _id_0A18::_id_11812;
  var_0._id_1581[32] = _id_0A18::_id_1180F;
  var_0._id_1581[33] = _id_0A18::_id_11811;
  var_0._id_1581[34] = scripts\aitypes\combat::_id_8BC6;
  var_0._id_1581[35] = ::_id_3387;
  var_0._id_1581[36] = ::_id_3388;
  var_0._id_1581[37] = scripts\aitypes\combat::_id_DF56;
  var_0._id_1581[38] = scripts\aitypes\combat::_id_DF53;
  var_0._id_1581[39] = scripts\aitypes\combat::_id_DF55;
  var_0._id_1581[40] = scripts\aitypes\combat::_id_8C0B;
  var_0._id_1581[41] = _id_0BFA::_id_3401;
  level._id_119E["c6_mp"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("c6_mp");
}