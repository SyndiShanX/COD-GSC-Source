/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_war.gsc
*******************************************************/

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
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self[[self.personality_update_function]]();
    waitframe();
  }
}