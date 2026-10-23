/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_dogfight_ffa.gsc
****************************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_dogfight_think;
}

bot_dogfight_think() {}