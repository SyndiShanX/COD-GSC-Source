/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\gamestate.gsc
***********************************************/

#namespace gamestate;

set_state(state) {
  game.state = state;
  function_cab6408d(state);
}

is_state(state) {
  return game.state == state;
}

is_game_over() {
  return game.state == "postgame" || game.state == "shutdown";
}

is_shutting_down() {
  return game.state == "shutdown";
}