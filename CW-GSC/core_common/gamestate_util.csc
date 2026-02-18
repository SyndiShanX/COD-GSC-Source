/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\gamestate_util.csc
***********************************************/

#namespace gamestate;

function is_state(state) {
  return game.state == state;
}

function is_game_over() {
  return game.state == # "postgame" || game.state == # "shutdown";
}

function is_shutting_down() {
  return game.state == # "shutdown";
}