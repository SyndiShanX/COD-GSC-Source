/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3873.gsc
**************************************/

main() {
  _id_0F23::main();
}

_id_F5B6(var_0, var_1, var_2) {
  if(var_0) {
    if(isDefined(var_1) && isDefined(var_2)) {
      level thread _id_0F27::_id_10ED8(var_1, var_2);
    }

    level thread _id_0F26::_id_117D3(1);

    foreach(var_4 in level.players) {
      var_4 thread _id_0F24::main();
      var_4 thread _id_0F25::_id_11408();
      var_4 thread _id_0F24::_id_1DD3();
    }
  } else {
    level thread _id_0F27::_id_10EDA();
    level thread _id_0F26::_id_117D3(0);

    foreach(var_4 in level.players) {
      var_4 thread _id_0F25::_id_11407();
      var_4 thread _id_0F24::_id_1DD2();
    }
  }
}