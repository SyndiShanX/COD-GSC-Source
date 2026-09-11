/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player_frame_update_aggregator.gsc
*****************************************************************/

function init() {
  level.playerframeupdatecallbacks = [];
  thread runupdates();
}

function runupdates() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(var1 in level.players) {
      foreach(var3 in level.playerframeupdatecallbacks) {
        var1[[var3]]();
      }
    }

    waitframe();
  }
}

function registerplayerframeupdatecallback(var0) {
  level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = var0;
}