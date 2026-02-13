/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_to_hstg.gsc
*****************************************************/

main() {
  _id_D795();
  _id_D782();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_2907;
}

_id_D782() {}

_id_2907() {
  self notify("bot_to_hstg_think");
  self endon("bot_to_hstg_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}