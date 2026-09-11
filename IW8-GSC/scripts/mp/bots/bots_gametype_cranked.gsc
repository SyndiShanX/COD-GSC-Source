/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cranked.gsc
*****************************************************/

function main() {
  setup_callbacks();
  setup_bot_cranked();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_cranked_think;
}

function setup_bot_cranked() {
  level.bot_personality_types_desired["active"] = 1;
  level.bot_personality_types_desired["stationary"] = 0;
}

function bot_cranked_think() {
  self notify("bot_cranked_think");
  self endon("bot_cranked_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}