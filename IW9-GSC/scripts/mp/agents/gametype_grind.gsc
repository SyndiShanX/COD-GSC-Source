/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_grind.gsc
************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["player"]["think"] = _id_5B39EA45C1E6FB1A::agent_player_conf_think;
}