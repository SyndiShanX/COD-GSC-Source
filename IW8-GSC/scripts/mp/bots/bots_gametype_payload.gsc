/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_payload.gsc
*****************************************************/

function main() {
  setup_callbacks();
  setup_bot_payload();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_payload_think;
}

function setup_bot_payload() {}

function bot_payload_think() {
  self notify("bot_payloadr_think");
  self endon("bot_payload_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}