/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_defcon.gsc
****************************************************/

main() {
  _id_D795();
  _id_D76E();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_2761;
}

_id_D76E() {}

_id_2761() {
  self notify("bot_defcon_think");
  self endon("bot_defcon_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}