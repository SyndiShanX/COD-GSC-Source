/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1393.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("insta_kill", ::_id_A218, ::_id_1F80, ::_id_4525);
}

_id_1F80(var_0) {
  if(!_id_0561::_id_1F7B()) {
    return 0;
  }

  return 1;
}

_id_A218(var_0) {
  maps\mp\gametypes\zombies::_id_53DD(self, 1);
}

_id_4525(var_0) {
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