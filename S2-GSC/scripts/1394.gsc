/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1394.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("max_ammo", ::_id_A21A, ::_id_1F82, ::_id_4575);
}

_id_1F82(var_0) {
  if(!_id_0561::_id_1F7B()) {
    return 0;
  }

  return 1;
}

_id_A21A(var_0) {
  maps\mp\gametypes\zombies::_id_0DB9(self, 1);
}

_id_4575(var_0) {
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