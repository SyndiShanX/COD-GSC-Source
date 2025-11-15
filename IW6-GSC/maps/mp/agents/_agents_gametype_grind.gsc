/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_grind.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["squadmate"]["gametype_update"] = maps\mp\agents\_agents_gametype_conf::agent_squadmember_conf_think;
  level.agent_funcs["player"]["think"] = maps\mp\agents\_agents_gametype_conf::agent_player_conf_think;
}