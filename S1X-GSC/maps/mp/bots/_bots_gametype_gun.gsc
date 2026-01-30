/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_gun.gsc
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
  setup_bot_gun();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

setup_bot_gun() {}

bot_gun_think() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(true) {
    self[[self.personality_update_function]]();
    wait(0.05);
  }
}