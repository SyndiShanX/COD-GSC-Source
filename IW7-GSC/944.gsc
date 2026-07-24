/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 944.gsc
**************************************/

_id_F170(var_0) {
  return scripts\aitypes\melee::melee_init(var_0, self.bt._id_F15D);
}

_id_2AD0() {
  if(isDefined(level._id_119E["seeker"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = _id_0C25::_id_98CA;
  var_0._id_1581[1] = _id_0A09::_id_9307;
  var_0._id_1581[2] = _id_0C25::_id_1572;
  var_0._id_1581[3] = _id_0C25::_id_13850;
  var_0._id_1581[4] = _id_0C25::_id_F177;
  var_0._id_1581[5] = ::_id_F170;
  var_0._id_1581[6] = ::scripts\aitypes\melee::_id_5903;
  var_0._id_1581[7] = ::scripts\aitypes\melee::_id_9896;
  var_0._id_1581[8] = ::scripts\aitypes\melee::_id_41C6;
  var_0._id_1581[9] = _id_0C25::_id_2BD3;
  level._id_119E["seeker"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("seeker");
}