/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_to_hstg.gsc
*****************************************************/

function main() {
  setup_callbacks();
  setup_bot_to_hstg();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_to_hstg_think;
}

function setup_bot_to_hstg() {}

function bot_to_hstg_think() {
  self notify("bot_to_hstg_think");
  self endon("bot_to_hstg_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}