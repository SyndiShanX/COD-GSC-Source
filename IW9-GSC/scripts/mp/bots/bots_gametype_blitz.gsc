/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_blitz.gsc
***************************************************/

main() {
  setup_callbacks();
  setup_bot_blitz();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_blitz_think;
}

setup_bot_blitz() {}

bot_blitz_think() {
  self notify("bot_blitz_think");
  self endon("bot_blitz_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}