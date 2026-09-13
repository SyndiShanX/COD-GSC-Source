/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player_frame_update_aggregator.gsc
*****************************************************************/

init() {
  level.playerframeupdatecallbacks = [];
  level thread runupdates();
}

runupdates() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.playerframeupdatecallbacks.size; _id_AC0E5C4AC96AAA41++)
        level.players[_id_AC0E594AC96AA3A8][[level.playerframeupdatecallbacks[_id_AC0E5C4AC96AAA41]]]();
    }

    waitframe();
  }
}

registerplayerframeupdatecallback(callback) {
  level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = callback;
}