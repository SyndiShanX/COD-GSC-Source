/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1400.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("vending_machine", ::_id_A244, ::_id_1F8B, ::_id_4716);
}

_id_1F8B(var_0) {
  if(!_id_0561::_id_1F7B())
    return 0;

  if(_id_4BA4())
    return 0;

  return 1;
}

_id_A244(var_0) {
  self._id_4B7D = 1;
  self notify("perk_discount_applied");
}

_id_4716(var_0) {
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

_id_4717(var_0) {
  if(_id_056B::_id_9D19(var_0._id_6F63))
    return 0;

  if(_id_4BA4())
    return 0.5;

  return 1;
}

_id_4BA4() {
  return isDefined(self._id_4B7D) && self._id_4B7D;
}

_id_A245() {
  var_0 = self;

  if(var_0 _id_4BA4())
    var_0._id_4B7D = undefined;

  var_0 notify("used_vending_machine_discount");
}