/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1390.gsc
**************************************/

_id_52A4() {
  _id_0561::_id_52A5("attack_dogs", "Attack Dogs", ::_id_A1FA, ::_id_1F2D, ::_id_4423);
  level thread _id_0516::init();
}

_id_1F2D() {
  return 1;
}

_id_A1FA() {
  self playlocalsound("zmb_pickup_general");
  thread _id_0516::_id_9E26();
}

_id_4423(var_0) {
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