/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\telemetry.gsc
***********************************************/

#using script_7a8059ca02b7b09e;
#using scripts\core_common\system_shared;
#namespace telemetry;

function private autoexec __init__system__() {
  system::register(#"hash_53528dbbf6cd15c4", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(isDefined(game)) {
    if(!isDefined(game.telemetry)) {
      game.telemetry = {};
    }

    if(!isDefined(game.telemetry.player_count)) {
      game.telemetry.player_count = 0;
    }

    if(!isDefined(game.telemetry.life_count)) {
      game.telemetry.life_count = 0;
    }

    return;
  }

  println("<dev string:x38>");
}