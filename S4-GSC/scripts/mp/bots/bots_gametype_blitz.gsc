/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_blitz.gsc
***************************************************/

main() {
  _id_D795();
  _id_D767();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_2709;
}

_id_D767() {}

_id_2709() {
  self notify("bot_blitz_think");
  self endon("bot_blitz_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}