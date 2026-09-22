/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1401.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("weap_guarantee", ::_id_A247, ::_id_1F8C, ::_id_4721);
}

_id_1F8C(var_0) {
  if(!_id_0561::_id_1F7B()) {
    return 0;
  }

  return 1;
}

_id_A247(var_0) {
  self playlocalsound("zmb_pickup_general");
  var_1 = self._id_259F[var_0].name;
  var_2 = _id_398B(var_1);
  self._id_A99B = var_2;

  foreach(var_4 in self getweaponlistprimaries()) {
    if(_id_0547::_id_5565(_id_0547::_id_AAF9(var_4), var_2)) {
      _id_0548::_id_3AC1(self, var_4);
      self givemaxammo(var_4);
    }
  }

  _id_0561::notifywallbuytriggers();
}

_id_4721(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

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

_id_398B(var_0) {
  var_1 = _func_337(var_0, "consumable_zm_guarantee_");
  return var_1;
}

_id_4BA5() {
  if(isDefined(self._id_A99B)) {
    return 1;
  }

  return 0;
}

_id_A246() {
  var_0 = self._id_A99B;
  self._id_A99B = undefined;
  _id_0561::notifywallbuytriggers();
  return var_0;
}