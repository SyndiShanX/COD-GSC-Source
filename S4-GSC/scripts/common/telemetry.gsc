/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\telemetry.gsc
*************************************************/

init() {
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
  } else {}
}