/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_brtdm.gsc
***************************************************/

main() {
  setup_callbacks();
  setup_bot_brtdm();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_brtdm_think;
}

setup_bot_brtdm() {}

bot_brtdm_think() {
  self notify("bot_brtdm_think");
  self endon("bot_brtdm_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}