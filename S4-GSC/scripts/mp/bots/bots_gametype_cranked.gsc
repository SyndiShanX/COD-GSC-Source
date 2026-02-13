/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cranked.gsc
*****************************************************/

main() {
  _id_D795();
  _id_D76A();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_2748;
}

_id_D76A() {
  level._id_2885["active"] = 1;
  level._id_2885["stationary"] = 0;
}

_id_2748() {
  self notify("bot_cranked_think");
  self endon("bot_cranked_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}