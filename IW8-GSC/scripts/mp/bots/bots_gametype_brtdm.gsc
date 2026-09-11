/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_brtdm.gsc
***************************************************/

function main() {
  setup_callbacks();
  ref_131dd();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &currenttime_bonus;
}

function ref_131dd() {}

function currenttime_bonus() {
  self notify("bot_brtdm_think");
  self endon("bot_brtdm_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}