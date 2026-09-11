/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\bandage.gsc
***********************************************/

function getbandagehealfractionbr() {
  return 0.2;
}

function getbandagehealtimebr() {
  return 5;
}

function getfirstaidhealtimebr() {
  return 5;
}

function getbandagetime(var_0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    var_1 = 1;

    if(isDefined(self.br_armorlevel) && self.br_armorlevel == 3) {
      var_1 = 0.75;
    }

    if(var_0 == "equip_bandages") {
      return (5 * var_1);
    }

    return (5 * var_1);
  }

  return 5;
}

function usebandage(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self.health == self.maxhealth) {
    self iprintlnbold("Your health is full!");
    return;
  }

  var_2 = "bandage_mp";

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_2 = "bandage_br_fake";
  }

  self disableweaponswitch();
  self allowfire(0);
  self giveandfireoffhand(var_2);
  wait 0.25;
  self.bandageactive = 1;
  self.healthregendisabled = 0;
  bandageheal(var_0);
  wait 0.25;

  if(self hasweapon(var_2)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
  }

  self allowfire(1);
  self enableweaponswitch();
  var_1--;
  scripts\mp\equipment::setequipmentslotammo("health", var_1);
  self.bandageactive = 0;
  self.healthregendisabled = 1;
}

function bandageheal(var_0) {
  self endon("heal_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread scripts\mp\gametypes\br_public::watchhealend();
  thread scripts\mp\healthoverlay::healhregenthink(var_0);
  wait getbandagetime(var_0);
}

function usequickslothealitem(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(self.usingascender)) {
    return;
  }

  if(istrue(self.inlaststand)) {
    scripts\mp\hud_message::showerrormessage("MP/LASTSTAND_HAVE_TO_BE_REVIVED");
    return;
  }

  if(var_0 == "equip_armorplate") {
    scripts\mp\equipment\armor_plate::demo_update_hint_logic(var_0, var_1);
  }

  if(scripts\mp\equipment::getequipmentslotammo("health") == 0) {
    var_2 = -1;
    var_3 = 0;

    foreach(var_5 in self.br_inventory_slots) {
      if(isDefined(var_5.scriptablename)) {
        if(var_5.scriptablename == level.br_pickups.br_equipnametoscriptable[var_0]) {
          scripts\mp\equipment::setequipmentslotammo("health", var_5.count);
          scripts\mp\gametypes\br_public::removeitemfrominventory(var_6);
          var_3 = 1;
          break;
        }

        if(var_5.itemtype == "health") {
          var_2 = var_6;
        }
      }
    }

    if(!var_3 && var_2 >= 0) {
      scripts\mp\equipment::giveequipment(level.br_pickups.br_equipname[self.br_inventory_slots[var_2].scriptablename], "health");
      scripts\mp\equipment::setequipmentslotammo("health", self.br_inventory_slots[var_2].count);
      self.br_inventory_slots[var_2] = undefined;
      return;
    }

    scripts\mp\equipment::takeequipment("health");
    return;
  }
}