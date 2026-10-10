/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\player_frame_update_aggregator.gsc
********************************************************************/

#using scripts\mp\flags;
#namespace player_frame_update_aggregator;

function init() {
  level.playerframeupdatecallbacks = [];
  level thread runupdates();
}

function runupdates() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    foreach(player in level.players) {
      foreach(callback in level.playerframeupdatecallbacks) {
        player[[callback]]();
      }
    }

    waitframe();
  }
}

function registerplayerframeupdatecallback(callback) {
  level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = callback;
}