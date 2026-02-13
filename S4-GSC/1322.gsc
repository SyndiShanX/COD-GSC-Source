/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1322.gsc
*************************************************/

_id_4CB4(var_0) {
  return _id_06AF::_id_8AF4(var_0, self._id_0192);
}

_id_2509() {
  if(isDefined(level._id_0B73["dog_agent"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_0E8A = [];
  var_0._id_0E8A[0] = _id_08E4::_id_FC57;
  var_0._id_0E8A[1] = _id_06B9::_id_7CFA;
  var_0._id_0E8A[2] = _id_08E4::_id_FC5D;
  var_0._id_0E8A[3] = _id_06B9::_id_E7DC;
  var_0._id_0E8A[4] = _id_08E4::_id_4CBE;
  var_0._id_0E8A[5] = _id_08E4::_id_4CBF;
  var_0._id_0E8A[6] = _id_08E4::_id_4CC0;
  var_0._id_0E8A[7] = _id_08E4::_id_4CB9;
  var_0._id_0E8A[8] = _id_08E4::_id_4CBB;
  var_0._id_0E8A[9] = _id_08E4::_id_4CBC;
  var_0._id_0E8A[10] = ::_id_4CB4;
  var_0._id_0E8A[11] = _id_06B3::_id_DB84;
  var_0._id_0E8A[12] = _id_06B3::_id_9D4C;
  var_0._id_0E8A[13] = ::scripts\aitypes\melee_mp::meleecharge_updatemp;
  var_0._id_0E8A[14] = _id_06B3::_id_9D6F;
  var_0._id_0E8A[15] = _id_06B3::_id_9D72;
  var_0._id_0E8A[16] = _id_06B3::_id_4D16;
  var_0._id_0E8A[17] = _id_06B3::_id_821D;
  var_0._id_0E8A[18] = _id_06B3::_id_395C;
  var_0._id_0E8A[19] = _id_08E4::_id_4CB6;
  var_0._id_0E8A[20] = _id_08E4::_id_4CB7;
  var_0._id_0E8A[21] = _id_08E4::_id_4CB8;
  var_0._id_0E8A[22] = _id_08E4::_id_4CBD;
  level._id_0B73["dog_agent"] = var_0;
}

_id_C241() {
  _id_2509();
  _func_030B("dog_agent");
}