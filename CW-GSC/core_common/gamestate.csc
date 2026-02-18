/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\gamestate.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace gamestate;

function private autoexec __init__system__() {
  system::register(#"gamestate", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(game.state)) {
    game.state = # "pregame";
  }
}

function event_handler[event_f7d4a05b] function_69452d92(eventstruct) {
  if(!isDefined(game.state)) {
    game.state = # "pregame";
  }

  if(eventstruct.gamestate !== game.state) {
    game.state = eventstruct.gamestate;
    println("<dev string:x38>" + game.state);
    callback::callback(#"hash_1184c2c2ed4c24b3", eventstruct);

    switch (eventstruct.gamestate) {
      case # "playing":
        callback::callback(#"on_game_playing", eventstruct);
        break;
      case # "postgame":
        callback::callback(#"hash_3ca80e35288a78d0", eventstruct);
        break;
      case # "shutdown":
        callback::callback(#"on_game_shutdown", eventstruct);
        break;
    }
  }
}