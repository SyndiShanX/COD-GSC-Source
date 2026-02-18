/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\gamestate.gsc
***********************************************/

#using scripts\core_common\gamestate_util;
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

function set_state(state) {
  game.state = state;
  function_cab6408d(state);
  level notify(state);
  println("<dev string:x38>" + state);
}