/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_war.gsc
*************************************************/

main() {
  _id_D795();
  _id_D784();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_291F;
}

_id_D784() {}

_id_291F() {
  self notify("bot_war_think");
  self endon("bot_war_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    wait 0.05;
  }
}