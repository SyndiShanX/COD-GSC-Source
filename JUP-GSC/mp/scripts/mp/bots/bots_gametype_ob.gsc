/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_ob.gsc
***************************************************/

#using script_27fdece778e999d8;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace bots_gametype_ob;

function main() {
  if(scripts\cp_mp\utility\game_utility::function_6493ec89ae923684()) {
    namespace_da125b44c190d236::initialize();
    return;
  }

  setup_callbacks();
  setup_bot_war();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_war_think;
}

function setup_bot_war() {}

function bot_war_think() {
  self notify("bot_war_think");
  self endon("bot_war_think");
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