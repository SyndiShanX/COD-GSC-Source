/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\consumables\inv_armor.gsc
*************************************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("armor", ::usearmor, ::canusearmor, ::getarmorcharges);
}

canusearmor(var_0) {
  var_1 = self;

  if(!_id_0561::_id_1F7B())
    return 0;

  if(var_1 _id_056A::_id_4B53())
    return 0;

  return 1;
}

usearmor(var_0) {
  foreach(var_2 in level.players) {
    var_2 _id_056A::_id_4775();
    var_2 thread maps\mp\gametypes\_hud_message::_id_9102("zm_shattered_maxarmor_splash");
  }
}

getarmorcharges(var_0) {
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