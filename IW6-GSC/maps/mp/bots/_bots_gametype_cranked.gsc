/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_cranked.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;

main() {
  level.bot_personality_types_desired["active"] = 1;
  level.bot_personality_types_desired["stationary"] = 0;
}