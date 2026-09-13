/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_war.gsc
*************************************************/

main() {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    _id_26508F2DE04C7A52::_id_53AE52A625B5C703();
    return;
  }

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