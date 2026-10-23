/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_scorestreak_training.gsc
************************************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::_id_1ABC;
}

_id_1ABC() {
  self notify("bot_scorestreak_training_think");
  self endon("bot_scorestreak_training_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self[[self.personality_update_function]]();
    waitframe();
  }
}