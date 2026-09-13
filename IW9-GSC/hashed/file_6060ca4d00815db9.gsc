/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6060ca4d00815db9.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_war();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_war_think;
}

setup_bot_war() {}

bot_war_think() {
  self notify("bot_war_think");
  self endon("bot_war_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}