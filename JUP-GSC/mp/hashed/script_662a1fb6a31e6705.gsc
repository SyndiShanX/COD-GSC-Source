/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_662a1fb6a31e6705.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace namespace_afee943043deb52b;

function main() {
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