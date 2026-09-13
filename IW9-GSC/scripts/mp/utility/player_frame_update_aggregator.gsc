/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\player_frame_update_aggregator.gsc
*****************************************************************/

init() {
  level.playerframeupdatecallbacks = [];
  level thread runupdates();
}

runupdates() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(player in level.players) {
      foreach(callback in level.playerframeupdatecallbacks)
      player[[callback]]();
    }

    waitframe();
  }
}

registerplayerframeupdatecallback(callback) {
  level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = callback;
}