/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_front.gsc
***************************************************/

main() {
  _id_D795();
  _id_D771();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_279C;
}

_id_D771() {}

_id_279C() {
  self notify("bot_front_think");
  self endon("bot_front_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}