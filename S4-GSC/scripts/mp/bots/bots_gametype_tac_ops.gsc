/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_tac_ops.gsc
*****************************************************/

main() {
  _id_D795();
  _id_D780();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_28F1;
}

_id_D780() {}

_id_28F1() {
  self notify("bot_tac_ops_think");
  self endon("bot_tac_ops_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}