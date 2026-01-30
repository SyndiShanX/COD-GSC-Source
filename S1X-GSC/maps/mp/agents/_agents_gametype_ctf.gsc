/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_ctf.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_gametype_common;

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["player"]["think"] = maps\mp\bots\_bots_gametype_ctf::bot_ctf_think;
}