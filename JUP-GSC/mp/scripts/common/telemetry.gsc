/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\telemetry.gsc
***********************************************/

#namespace telemetry;

function init() {
  if(isDefined(game)) {
    if(!isDefined(game["telemetry"])) {
      game["telemetry"] = spawnStruct();
    }

    if(!isDefined(game["telemetry"].total_player_connections)) {
      game["telemetry"].total_player_connections = 0;
    }

    if(!isDefined(game["telemetry"].life_count)) {
      game["telemetry"].life_count = 0;
    }

    if(!isDefined(game["telemetry"].game_event_count)) {
      game["telemetry"].game_event_count = 0;
    }

    return;
  }

  println("<dev string:x1c>");
}