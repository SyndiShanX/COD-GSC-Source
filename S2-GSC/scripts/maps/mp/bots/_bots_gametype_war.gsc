/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_war.gsc
*******************************************************/

main() {
  _id_87A7();
  _id_879B();
}

_id_87A7() {
  level._id_19D5["gametype_think"] = ::_id_1B25;
}

_id_879B() {}

_id_1B25() {
  self notify("bot_war_think");
  self endon("bot_war_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self[[self._id_6F7F]]();
    waitframe();
  }
}