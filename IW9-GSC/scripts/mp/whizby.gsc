/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\whizby.gsc
***********************************************/

init() {
  setdvarifuninitialized("scr_suppression", 0);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  _id_44A4AD8C0D35F203::init();
}

onplayerspawned() {
  thread whizbythink();
}

whizbythink() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  effecttime = gettime();
  _id_44A4AD8C0D35F203::initplayer();

  for(;;) {
    self waittill("bulletwhizby", attacker, distance, position, forward);
    effecttime = dowhizby(attacker, distance, position, forward, effecttime);
    _id_6DAF5B3C904637E7(attacker);
  }
}

dowhizby(attacker, distance, position, forward, effecttime) {
  currenttime = gettime();

  if(!scripts\mp\utility\player::isusingremote())
    thread _id_44A4AD8C0D35F203::_id_A6E6611EFB4164D5(attacker, distance, position, forward);

  weapon = attacker getcurrentweapon();

  if(isDefined(weapon) && weaponclass(weapon) == "sniper")
    scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_CAFA7AD7442C35D5", undefined, 0.2);

  thread scripts\mp\battlechatter_mp::addrecentattacker(attacker);
  return effecttime;
}

_id_6DAF5B3C904637E7(attacker) {
  if(getdvarint("scr_suppression", 1) == 1) {
    weapon = attacker getcurrentweapon();

    if(weapon hasattachment("linearbrake") && !_id_2669878CF5A1B6BC::iskillstreakweapon(weapon) && !scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {
      attacker _id_5762AC2F22202BA2::hudicontype("suppression");
      scripts\mp\gamescore::trackdebuffassist(attacker, self, weapon.basename);
    }
  }
}