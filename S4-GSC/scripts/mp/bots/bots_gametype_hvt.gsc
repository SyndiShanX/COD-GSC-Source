/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_hvt.gsc
*************************************************/

main() {
  _id_D795();
  _id_D775();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_27F5;
}

_id_D775() {}

_id_27F5() {
  self notify("bot_hvt_think");
  self endon("bot_hvt_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}