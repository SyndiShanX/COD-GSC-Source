/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1395.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("mys_box_key", ::_id_A21F, ::_id_1F5C, ::_id_4598);
}

_id_1F5C(var_0) {
  if(!_id_0561::_id_1F7B())
    return 0;

  if(_id_4B7B())
    return 0;

  return 1;
}

_id_A21F(var_0) {
  self playlocalsound("zmb_pickup_general");
  var_1 = self._id_259F[var_0].type;
  self._id_65EC = spawnStruct();
  self._id_65EC.type = var_1;
  self._id_65EC._id_267C = 1 - _id_4599(var_1);

  if(common_scripts\utility::_id_562E(level.reworkedconsumabledenabled))
    self._id_65EC.flatdiscount = 1250;

  _id_0561::notifywallbuytriggers();
  _id_0548::playsoundasmaster();
}

_id_4598(var_0) {
  if(!isDefined(var_0))
    var_0 = "";

  switch (var_0) {
    case "epic":
      return 4;
    case "legendary":
      return 3;
    case "rare":
      return 2;
    case "common":
      return 1;
    default:
      return 0;
  }
}

_id_4599(var_0) {
  if(!isDefined(var_0))
    var_0 = "";

  switch (var_0) {
    case "common":
    case "rare":
    case "legendary":
    case "epic":
      return 0.5;
    default:
      return 0;
  }
}

_id_4B7B() {
  if(isDefined(self._id_65EC))
    return 1;

  return 0;
}

_id_A21E() {
  if(!_id_4B7B()) {
    return;
  }
  self._id_65EC = undefined;
  _id_0561::notifywallbuytriggers();
}