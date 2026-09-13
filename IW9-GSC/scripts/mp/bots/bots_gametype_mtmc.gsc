/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_mtmc.gsc
**************************************************/

main() {
  setup_callbacks();
  setup_bot_mtmc();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_mtmc_think;
}

setup_bot_mtmc() {}

bot_mtmc_think() {
  self notify("bot_mtmc_think");
  self endon("bot_mtmc_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}