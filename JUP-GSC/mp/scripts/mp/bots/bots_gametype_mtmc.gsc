/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_mtmc.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace bots_gametype_mtmc;

function main() {
  setup_callbacks();
  setup_bot_mtmc();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_mtmc_think;
}

function setup_bot_mtmc() {}

function bot_mtmc_think() {
  self notify("bot_mtmc_think");
  self endon("bot_mtmc_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}