/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\telemetry.gsc
****************************************/

#namespace telemetry;

function init() {
  if(isDefined(game)) {
    if(!isDefined(game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"])) {
      game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"] = spawnStruct();
    }

    if(!isDefined(game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].total_player_connections)) {
      game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].total_player_connections = 0;
    }

    if(!isDefined(game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].life_count)) {
      game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].life_count = 0;
    }

    if(!isDefined(game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].game_event_count)) {
      game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].game_event_count = 0;
    }

    if(!isDefined(game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].total_bot_count)) {
      game["\xb5D\xd3\x90\xb4\xfd\x11\xc1\x89"].total_bot_count = 0;
    }

    return;
  }

  println("<dev string:x24>");
}