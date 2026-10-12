/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player_frame_update_aggregator.gsc
*****************************************************************/



#using scripts\cp\utility;
#namespace player_frame_update_aggregator;

function init() {
  level.playerframeupdatecallbacks = [];
  level thread runupdates();
}

function runupdates() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");

  while(true) {
    for(i = 0; i < level.players.size; i++) {
      for(j = 0; j < level.playerframeupdatecallbacks.size; j++) {
        level.players[i][[level.playerframeupdatecallbacks[j]]]();
      }
    }

    waitframe();
  }
}

function registerplayerframeupdatecallback(callback) {
  level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = callback;
}