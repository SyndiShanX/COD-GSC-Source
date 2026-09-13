/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_22a691c4f1eedbb.gsc
***********************************************/

main() {
  setup_callbacks();
  _id_66A879F936127721();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::_id_BC880163DB33E8BC;
}

_id_66A879F936127721() {}

_id_BC880163DB33E8BC() {
  self notify("bot_aon_think");
  self endon("bot_aon_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}