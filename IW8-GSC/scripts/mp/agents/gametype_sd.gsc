/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_sd.gsc
***********************************************/

function main() {
  setup_callbacks();
}

function setup_callbacks() {
  level.agent_funcs["player"]["think"] = &agent_player_sd_think;
}

function agent_player_sd_think() {
  scripts\common\utility::allow_usability(1);
  thread scripts\mp\bots\bots_gametype_sd::bot_sd_think();
}