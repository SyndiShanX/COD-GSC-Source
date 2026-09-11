/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_pill.gsc
***********************************************/

function main() {
  setup_callbacks();
}

function setup_callbacks() {
  level.agent_funcs["player"]["think"] = &scripts\mp\agents\gametype_conf::agent_player_conf_think;
}