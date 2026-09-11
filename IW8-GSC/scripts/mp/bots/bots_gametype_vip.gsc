/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_vip.gsc
*************************************************/

function main() {
  setup_callbacks();
  setup_bot_vip();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_vip_think;
}

function setup_bot_vip() {}

function bot_vip_think() {
  self notify("bot_vip_think");
  self endon("bot_vip_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}