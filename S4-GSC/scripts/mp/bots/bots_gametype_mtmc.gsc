/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_mtmc.gsc
**************************************************/

main() {
  _id_D795();
  _id_D779();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_285F;
}

_id_D779() {}

_id_285F() {
  self notify("bot_mtmc_think");
  self endon("bot_mtmc_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}