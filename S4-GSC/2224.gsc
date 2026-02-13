/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2224.gsc
*************************************************/

main() {
  _id_08B1::main();
}

_id_D3C7(var_0, var_1, var_2) {
  if(var_0) {
    if(isDefined(var_1) && isDefined(var_2)) {
      level thread _id_08B5::_id_E7B8(var_1, var_2);
    }

    level thread _id_08B4::_id_F151(1);

    foreach(var_4 in level.players) {
      var_4 thread _id_08B3::main();
    }
  } else {
    level thread _id_08B5::_id_E7BA();
    level thread _id_08B4::_id_F151(0);
  }

  if(isDefined(level._id_0408._id_5DBE)) {
    level thread[[level._id_0408._id_5DBE]](var_0, var_1, var_2);
  }
}