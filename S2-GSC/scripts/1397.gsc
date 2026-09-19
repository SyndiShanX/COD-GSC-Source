/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1397.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("ref_coupon", ::_id_A230, ::_id_1F86, ::_id_4661);
}

_id_1F86(var_0) {
  if(!_id_0561::_id_1F7B())
    return 0;

  if(_id_4B8A())
    return 0;

  return 1;
}

_id_A230(var_0) {
  self._id_4B8A = 1;
}

_id_4661(var_0) {
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

_id_4B8A() {
  return isDefined(self._id_4B8A) && self._id_4B8A;
}

_id_A22F(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!_id_4B8A()) {
    return;
  }
  wait 0.25;
  var_1 = int(0.25 * var_0);
  self._id_4B8A = 0;
  maps\mp\gametypes\zombies::_id_4798(var_1, 1);
}