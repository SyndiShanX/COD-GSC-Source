/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_sd.gsc
***********************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["player"]["think"] = ::agent_player_sd_think;
}

agent_player_sd_think() {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("agent_use");
  thread _id_6DDDB002636F198A::bot_sd_think();
}