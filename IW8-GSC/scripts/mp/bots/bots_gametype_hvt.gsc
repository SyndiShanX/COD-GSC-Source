/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_hvt.gsc
*************************************************/

function main() {
  setup_callbacks();
  setup_bot_hvt();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_hvt_think;
}

function setup_bot_hvt() {}

function bot_hvt_think() {
  self notify("bot_hvt_think");
  self endon("bot_hvt_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}