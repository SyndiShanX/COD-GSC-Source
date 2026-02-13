/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_mendota.gsc
*****************************************************/

main() {
  _id_D795();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::bot_mendota_think;
}

bot_mendota_think() {
  self notify("bot_mendota_think");
  self endon("bot_mendota_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self[[self._id_B025]]();
    waitframe();
  }
}