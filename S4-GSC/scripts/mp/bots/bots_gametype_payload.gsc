/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_payload.gsc
*****************************************************/

main() {
  _id_D795();
  _id_D77A();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_287B;
}

_id_D77A() {}

_id_287B() {
  self notify("bot_payloadr_think");
  self endon("bot_payload_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}