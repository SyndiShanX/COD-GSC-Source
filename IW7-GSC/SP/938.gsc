/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 938.gsc
**************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["c6_worker"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0BFC::_id_340B;
  var_0._id_1581[1] = _id_0BFE::_id_97F9;
  var_0._id_1581[2] = _id_0A09::_id_9309;
  var_0._id_1581[3] = _id_0A09::_id_9307;
  var_0._id_1581[4] = _id_0BFE::_id_9E7B;
  var_0._id_1581[5] = _id_0BFE::_id_9EA3;
  var_0._id_1581[6] = _id_0BFE::_id_8BE3;
  var_0._id_1581[7] = _id_0BFE::_id_10072;
  var_0._id_1581[8] = _id_0BFE::_id_F1FB;
  var_0._id_1581[9] = _id_0BFE::_id_F1FC;
  var_0._id_1581[10] = _id_0BFE::_id_5AA4;
  var_0._id_1581[11] = _id_0BFE::_id_5AA5;
  var_0._id_1581[12] = _id_0BFE::_id_9F3F;
  var_0._id_1581[13] = _id_0BFC::_id_A665;
  var_0._id_1581[14] = _id_0BFE::_id_9F42;
  var_0._id_1581[15] = _id_0BFE::_id_F20B;
  var_0._id_1581[16] = _id_0BFE::_id_F20C;
  var_0._id_1581[17] = _id_0BFE::_id_F209;
  var_0._id_1581[18] = _id_0BFE::_id_F207;
  var_0._id_1581[19] = _id_0BFE::_id_F206;
  var_0._id_1581[20] = _id_0BFE::_id_F203;
  var_0._id_1581[21] = _id_0BFE::_id_F205;
  var_0._id_1581[22] = _id_0BFE::_id_F204;
  var_0._id_1581[23] = _id_0BFE::_id_F208;
  var_0._id_1581[24] = _id_0BFC::_id_9F06;
  var_0._id_1581[25] = scripts\aitypes\combat::_id_8BEC;
  var_0._id_1581[26] = _id_0BFC::_id_9D5B;
  var_0._id_1581[27] = _id_0BFC::_id_F795;
  var_0._id_1581[28] = scripts\aitypes\melee::shouldmelee;
  var_0._id_1581[29] = scripts\aitypes\melee::_id_B5C3;
  var_0._id_1581[30] = scripts\aitypes\melee::melee_init;
  var_0._id_1581[31] = _id_0BFC::_id_340D;
  var_0._id_1581[32] = _id_0BFC::_id_340E;
  var_0._id_1581[33] = scripts\aitypes\melee::_id_B5F0;
  var_0._id_1581[34] = scripts\aitypes\melee::_id_B5E8;
  var_0._id_1581[35] = scripts\aitypes\melee::_id_B5EE;
  var_0._id_1581[36] = scripts\aitypes\melee::_id_5903;
  var_0._id_1581[37] = scripts\aitypes\melee::_id_9896;
  var_0._id_1581[38] = scripts\aitypes\melee::_id_41C6;
  var_0._id_1581[39] = _id_0A09::_id_E475;
  level._id_119E["c6_worker"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("c6_worker");
}