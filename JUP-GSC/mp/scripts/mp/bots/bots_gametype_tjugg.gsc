/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_tjugg.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace bots_gametype_tjugg;

function main() {
  setup_callbacks();
  setup_bot_tjugg();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_tjugg_think;
}

function setup_bot_tjugg() {}

function bot_tjugg_think() {
  self notify("bot_tjugg_think");
  self endon("bot_tjugg_think");
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