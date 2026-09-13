/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_dm.gsc
************************************************/

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
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}