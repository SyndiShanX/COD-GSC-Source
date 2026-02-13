/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_pill.gsc
**************************************************/

main() {
  _id_D795();
  _id_D77B();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_288F;
}

_id_D77B() {}

_id_288F() {
  self notify("bot_pill_think");
  self endon("bot_pill_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}