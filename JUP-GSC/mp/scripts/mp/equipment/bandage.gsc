/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\bandage.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\adrenaline;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace bandage;

function getbandagehealfractionbr() {
  return 0.2;
}

function getbandagehealtimebr() {
  return 5;
}

function getfirstaidhealtimebr() {
  return 5;
}

function getbandagetime(itemname) {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    healscale = 1;

    if(isDefined(self.br_armorlevel) && self.br_armorlevel == 3) {
      healscale = 0.75;
    }

    if(itemname == "equip_bandages") {
      return (5 * healscale);
    }

    return (5 * healscale);
  }

  return 5;
}

function usebandage(itemname, var_1156b7a3b9b6aa08) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self.health == self.maxhealth) {
    self iprintlnbold("Your health is full!");
    return;
  }

  weaponobj = "bandage_mp";

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    weaponobj = "bandage_br_fake";
  }

  self disableweaponswitch();
  self allowfire(0);
  self giveandfireoffhand(weaponobj);
  wait 0.25;
  self.bandageactive = 1;
  self.healthregendisabled = 0;
  bandageheal(itemname);
  wait 0.25;

  if(self hasweapon(weaponobj)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(weaponobj);
  }

  self allowfire(1);
  self enableweaponswitch();
  var_1156b7a3b9b6aa08--;
  scripts\mp\equipment::setequipmentslotammo("health", var_1156b7a3b9b6aa08);
  self.bandageactive = 0;
  self.healthregendisabled = 1;
}

function bandageheal(itemname) {
  self endon("heal_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread scripts\mp\gametypes\br_public::watchhealend();
  self notify("force_regeneration");
  wait getbandagetime(itemname);
}