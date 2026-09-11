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
    foreach(var_1 in level.players) {
      foreach(var_3 in level.playerframeupdatecallbacks) {
        var_1[[var_3]]();
      }
    }

    waitframe();
  }
}

function registerplayerframeupdatecallback(var_0) {
  level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = var_0;
}