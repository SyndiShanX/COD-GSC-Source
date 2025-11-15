/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_sd.gsc
**************************************************/

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
  level.agent_funcs["player"]["think"] = ::agent_player_sd_think;
}

agent_player_sd_think() {
  self _enableUsability();

  self thread maps\mp\bots\_bots_gametype_sd::bot_sd_think();
}