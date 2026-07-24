/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\zombie_dlc2.gsc
****************************************/

zombie_dlc2fn0(var_0) {
  return _id_0A09::_id_5AEA(var_0, 200);
}

_id_2AD0() {
  if(isDefined(level._id_119E["zombie_dlc2"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0C2B::_id_98E5;
  var_0._id_1581[1] = scripts\aitypes\zombie_dlc2\behaviors::checkscripteddlc2;
  var_0._id_1581[2] = _id_0C2B::_id_10004;
  var_0._id_1581[3] = _id_0C2B::_id_6627;
  var_0._id_1581[4] = _id_0C2B::_id_6628;
  var_0._id_1581[5] = _id_0C2B::_id_6629;
  var_0._id_1581[6] = ::zombie_dlc2fn0;
  var_0._id_1581[7] = _id_0A09::_id_FAF6;
  var_0._id_1581[8] = _id_0C2B::_id_102D4;
  var_0._id_1581[9] = _id_0C2B::_id_3E4F;
  var_0._id_1581[10] = _id_0C2B::_id_3E29;
  var_0._id_1581[11] = scripts\aitypes\zombie_dlc2\behaviors::chaseenemydlc2;
  var_0._id_1581[12] = scripts\aitypes\zombie_dlc2\behaviors::seekenemydlc2;
  var_0._id_1581[13] = _id_0C2B::notargetfound;
  level._id_119E["zombie_dlc2"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("zombie_dlc2");
}