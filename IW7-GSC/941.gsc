/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 941.gsc
**************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["civilian"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0C0E::_id_97E6;
  var_0._id_1581[1] = _id_0C0E::_id_12E8F;
  level._id_119E["civilian"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("civilian");
}