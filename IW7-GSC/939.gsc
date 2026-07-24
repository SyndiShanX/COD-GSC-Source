/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 939.gsc
**************************************/

_id_34F9(var_0) {
  return _id_0A09::_id_5AEA(var_0, 5);
}

_id_34FA(var_0) {
  return scripts\aitypes\melee::shouldmelee(var_0, self.bt.enemies[0]);
}

_id_34FB(var_0) {
  return _id_0A09::_id_5AEA(var_0, 100);
}

_id_34FC(var_0) {
  return _id_0A09::_id_5AEA(var_0, 500);
}

_id_2AD0() {
  if(isDefined(level._id_119E["c8"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = ::_id_34F9;
  var_0._id_1581[1] = _id_0A09::_id_FAF6;
  var_0._id_1581[2] = _id_0C01::_id_346D;
  var_0._id_1581[3] = _id_0C01::_id_34EE;
  var_0._id_1581[4] = _id_0A09::_id_9307;
  var_0._id_1581[5] = ::scripts\aitypes\combat::_id_9E40;
  var_0._id_1581[6] = _id_0C01::_id_34EF;
  var_0._id_1581[7] = _id_0BFE::_id_8BE3;
  var_0._id_1581[8] = _id_0BFE::_id_9E21;
  var_0._id_1581[9] = _id_0C01::_id_3468;
  var_0._id_1581[10] = _id_0C01::_id_3469;
  var_0._id_1581[11] = _id_0C01::_id_346A;
  var_0._id_1581[12] = _id_0C01::_id_346B;
  var_0._id_1581[13] = _id_0C01::_id_346C;
  var_0._id_1581[14] = _id_0C01::_id_3427;
  var_0._id_1581[15] = _id_0C01::_id_34C3;
  var_0._id_1581[16] = ::_id_34FA;
  var_0._id_1581[17] = ::scripts\aitypes\melee::melee_init;
  var_0._id_1581[18] = ::scripts\aitypes\melee::_id_B5F0;
  var_0._id_1581[19] = _id_0C01::_id_347F;
  var_0._id_1581[20] = _id_0C01::_id_3480;
  var_0._id_1581[21] = ::scripts\aitypes\melee::_id_5903;
  var_0._id_1581[22] = ::scripts\aitypes\melee::_id_9896;
  var_0._id_1581[23] = ::scripts\aitypes\melee::_id_41C6;
  var_0._id_1581[24] = _id_0C01::_id_34DA;
  var_0._id_1581[25] = _id_0C01::_id_348C;
  var_0._id_1581[26] = _id_0C01::_id_348D;
  var_0._id_1581[27] = _id_0C01::_id_348E;
  var_0._id_1581[28] = _id_0C01::_id_34DE;
  var_0._id_1581[29] = _id_0C01::_id_34DF;
  var_0._id_1581[30] = _id_0C01::_id_34F0;
  var_0._id_1581[31] = _id_0C01::_id_34F2;
  var_0._id_1581[32] = _id_0C01::_id_34F1;
  var_0._id_1581[33] = _id_0C01::_id_34E6;
  var_0._id_1581[34] = _id_0C01::_id_34E8;
  var_0._id_1581[35] = _id_0C01::_id_34E7;
  var_0._id_1581[36] = _id_0C01::_id_34F3;
  var_0._id_1581[37] = _id_0C01::_id_34E9;
  var_0._id_1581[38] = _id_0C01::_id_34C5;
  var_0._id_1581[39] = _id_0C01::_id_34B2;
  var_0._id_1581[40] = _id_0C01::_id_34B3;
  var_0._id_1581[41] = _id_0C01::_id_34B4;
  var_0._id_1581[42] = _id_0C01::_id_34B5;
  var_0._id_1581[43] = _id_0C01::_id_34B7;
  var_0._id_1581[44] = _id_0C01::_id_34B8;
  var_0._id_1581[45] = _id_0C01::_id_34D8;
  var_0._id_1581[46] = _id_0C01::_id_345B;
  var_0._id_1581[47] = _id_0C01::_id_345C;
  var_0._id_1581[48] = _id_0C01::_id_345E;
  var_0._id_1581[49] = _id_0C01::_id_345D;
  var_0._id_1581[50] = _id_0C01::_id_345A;
  var_0._id_1581[51] = _id_0C01::_id_3460;
  var_0._id_1581[52] = ::scripts\aitypes\combat::_id_B4EB;
  var_0._id_1581[53] = _id_0C01::_id_34CD;
  var_0._id_1581[54] = _id_0C01::_id_34CE;
  var_0._id_1581[55] = _id_0C01::_id_34CF;
  var_0._id_1581[56] = _id_0C01::_id_34DC;
  var_0._id_1581[57] = _id_0C01::_id_34BB;
  var_0._id_1581[58] = ::_id_34FB;
  var_0._id_1581[59] = _id_0C01::_id_34EC;
  var_0._id_1581[60] = ::_id_34FC;
  var_0._id_1581[61] = _id_0A09::_id_E477;
  var_0._id_1581[62] = _id_09FC::_id_57DF;
  level._id_119E["c8"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("c8");
}