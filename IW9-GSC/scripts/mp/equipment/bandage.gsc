/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\bandage.gsc
***********************************************/

getbandagehealfractionbr() {
  return 0.2;
}

getbandagehealtimebr() {
  return 5;
}

getfirstaidhealtimebr() {
  return 5;
}

getbandagetime(itemname) {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_7607F8111CFE5FF7 = 1;

    if(isDefined(self.br_armorlevel) && self.br_armorlevel == 3)
      _id_7607F8111CFE5FF7 = 0.75;

    if(itemname == "equip_bandages")
      return 5 * _id_7607F8111CFE5FF7;

    return 5 * _id_7607F8111CFE5FF7;
  }

  return 5;
}

usebandage(itemname, _id_1156B7A3B9B6AA08) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self.health == self.maxhealth) {
    self iprintlnbold("Your health is full!");
    return;
  }

  weaponobj = "bandage_mp";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    weaponobj = "bandage_br_fake";

  self disableweaponswitch();
  self allowfire(0);
  self giveandfireoffhand(weaponobj);
  wait 0.25;
  self.bandageactive = 1;
  self.healthregendisabled = 0;
  bandageheal(itemname);
  wait 0.25;

  if(self hasweapon(weaponobj))
    scripts\cp_mp\utility\inventory_utility::getridofweapon(weaponobj);

  self allowfire(1);
  self enableweaponswitch();
  _id_1156B7A3B9B6AA08--;
  scripts\mp\equipment::setequipmentslotammo("health", _id_1156B7A3B9B6AA08);
  self.bandageactive = 0;
  self.healthregendisabled = 1;
}

bandageheal(itemname) {
  self endon("heal_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread _id_2CEDCC356F1B9FC8::watchhealend();
  self notify("force_regeneration");
  wait(getbandagetime(itemname));
}