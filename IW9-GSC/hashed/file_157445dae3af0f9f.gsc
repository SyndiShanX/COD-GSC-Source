/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_157445dae3af0f9f.gsc
***********************************************/

init() {
  level._id_B20FF0025288EF0B = [];
  level thread runupdates();
}

runupdates() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level._id_B20FF0025288EF0B.size; _id_AC0E5C4AC96AAA41++)
        level.players[_id_AC0E594AC96AA3A8][[level._id_B20FF0025288EF0B[_id_AC0E5C4AC96AAA41]]]();
    }

    wait 1;
  }
}

_id_3AE366EC2732AF83(callback) {
  level._id_B20FF0025288EF0B[level._id_B20FF0025288EF0B.size] = callback;
}