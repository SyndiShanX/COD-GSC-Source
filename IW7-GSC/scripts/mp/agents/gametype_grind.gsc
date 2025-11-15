/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_grind.gsc
************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["squadmate"]["gametype_update"] = ::scripts\mp\agents\gametype_conf::agent_squadmember_conf_think;
  level.agent_funcs["player"]["think"] = ::scripts\mp\agents\gametype_conf::agent_player_conf_think;
}