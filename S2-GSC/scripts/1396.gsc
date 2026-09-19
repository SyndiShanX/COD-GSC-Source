/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1396.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("nuke", ::_id_A221, ::_id_1F83, ::_id_45BA);
}

_id_1F83(var_0) {
  if(!_id_0561::_id_1F7B())
    return 0;

  return 1;
}

_id_A221(var_0) {
  maps\mp\gametypes\zombies::_id_685F(self, 1);
}

_id_45BA(var_0) {
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