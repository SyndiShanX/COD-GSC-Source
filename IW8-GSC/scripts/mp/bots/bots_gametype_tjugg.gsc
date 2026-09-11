/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_tjugg.gsc
***************************************************/

function main() {
  setup_callbacks();
  setup_bot_tjugg();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_tjugg_think;
}

function setup_bot_tjugg() {}

function bot_tjugg_think() {
  self notify("bot_tjugg_think");
  self endon("bot_tjugg_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}