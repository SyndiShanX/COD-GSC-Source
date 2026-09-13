/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\whizby.gsc
***********************************************/

init() {
  _id_44A4AD8C0D35F203::init();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

onplayerspawned() {
  self._whizbyfxent = [];
  thread whizbythink();
}

whizbythink() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_44A4AD8C0D35F203::initplayer();

  for(;;) {
    self waittill("bulletwhizby", attacker, distance, position, forward);
    dowhizby(attacker, distance, position, forward);
  }
}

dowhizby(attacker, distance, position, forward) {
  if(!scripts\cp\utility::isusingremote())
    thread _id_44A4AD8C0D35F203::_id_A6E6611EFB4164D5(attacker, distance, position, forward);

  weapon = attacker getcurrentweapon();

  if(weaponclass(weapon) == "sniper") {}

  thread scripts\cp\cp_player_battlechatter::addrecentattacker(attacker);
}