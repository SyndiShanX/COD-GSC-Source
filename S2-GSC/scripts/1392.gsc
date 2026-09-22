/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1392.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("full_meter", ::_id_A20D, ::_id_1F7E, ::_id_44F3);
}

_id_1F7E(var_0) {
  if(!_id_0561::_id_1F7B()) {
    return 0;
  }

  return 1;
}

_id_A20D(var_0) {
  maps\mp\gametypes\zombies::_id_0840(self, 1);
}

_id_44F3(var_0) {
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