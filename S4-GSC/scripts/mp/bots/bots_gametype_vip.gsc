/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_vip.gsc
*************************************************/

main() {
  _id_D795();
  _id_D783();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_2918;
}

_id_D783() {}

_id_2918() {
  self notify("bot_vip_think");
  self endon("bot_vip_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}