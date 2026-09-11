/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_defcon.gsc
****************************************************/

function main() {
  setup_callbacks();
  setup_bot_defcon();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_defcon_think;
}

function setup_bot_defcon() {}

function bot_defcon_think() {
  self notify("bot_defcon_think");
  self endon("bot_defcon_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}