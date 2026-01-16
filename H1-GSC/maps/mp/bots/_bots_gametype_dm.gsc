/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_dm.gsc
**********************************************/

main() {
  setup_callbacks();
  setup_bot_dm();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_dm_think;
}

setup_bot_dm() {}

bot_dm_think() {
  self notify("bot_dm_think");
  self endon("bot_dm_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  for (;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}