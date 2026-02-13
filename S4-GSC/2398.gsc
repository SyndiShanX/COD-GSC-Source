/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2398.gsc
*************************************************/

init() {
  level._id_B6B0 = [];
  level thread _id_CA7B();
}

_id_CA7B() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    foreach(var_1 in level.players) {
      foreach(var_3 in level._id_B6B0) {
        var_1[[var_3]]();
      }
    }

    waitframe();
  }
}

_id_C29C(var_0) {
  level._id_B6B0[level._id_B6B0.size] = var_0;
}