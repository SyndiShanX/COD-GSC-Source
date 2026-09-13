/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_vip.gsc
*************************************************/

main() {
  setup_callbacks();
  setup_bot_vip();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_vip_think;
}

setup_bot_vip() {}

bot_vip_think() {
  self notify("bot_vip_think");
  self endon("bot_vip_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}