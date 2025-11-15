/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_sd.gsc
*********************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["player"]["think"] = ::agent_player_sd_think;
}

agent_player_sd_think() {
  scripts\engine\utility::allow_usability(1);
  thread scripts\mp\bots\gametype_sd::bot_sd_think();
}