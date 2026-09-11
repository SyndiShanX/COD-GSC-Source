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

function getbandagetime(var0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    var1 = 1;

    if(isDefined(self.br_armorlevel) && self.br_armorlevel == 3) {
      var1 = 0.75;
    }

    if(var0 == "equip_bandages") {
      return (5 * var1);
    }

    return (5 * var1);
  }

  return 5;
}

function usebandage(var0, var1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self.health == self.maxhealth) {
    self iprintlnbold("Your health is full!");
    return;
  }

  var2 = "bandage_mp";

  if(scripts\mp\utility\game::getgametype() == "br") {
    var2 = "bandage_br_fake";
  }

  self disableweaponswitch();
  self allowfire(0);
  self giveandfireoffhand(var2);
  wait 0.25;
  self.bandageactive = 1;
  self.healthregendisabled = 0;
  bandageheal(var0);
  wait 0.25;

  if(self hasweapon(var2)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var2);
  }

  self allowfire(1);
  self enableweaponswitch();
  var1--;
  scripts\mp\equipment::setequipmentslotammo("health", var1);
  self.bandageactive = 0;
  self.healthregendisabled = 1;
}

function bandageheal(var0) {
  self endon("heal_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread scripts\mp\gametypes\br_public::watchhealend();
  thread scripts\mp\healthoverlay::healhregenthink(var0);
  wait getbandagetime(var0);
}

function usequickslothealitem(var0, var1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(self.usingascender)) {
    return;
  }

  if(istrue(self.inlaststand)) {
    scripts\mp\hud_message::showerrormessage("MP/LASTSTAND_HAVE_TO_BE_REVIVED");
    return;
  }

  if(var0 == "equip_armorplate") {
    scripts\mp\equipment\armor_plate::demo_update_hint_logic(var0, var1);
  }

  if(scripts\mp\equipment::getequipmentslotammo("health") == 0) {
    var2 = -1;
    var3 = 0;

    foreach(var5 in self.br_inventory_slots) {
      if(isDefined(var5.scriptablename)) {
        if(var5.scriptablename == level.br_pickups.br_equipnametoscriptable[var0]) {
          scripts\mp\equipment::setequipmentslotammo("health", var5.count);
          scripts\mp\gametypes\br_public::removeitemfrominventory(var6);
          var3 = 1;
          break;
        }

        if(var5.itemtype == "health") {
          var2 = var6;
        }
      }
    }

    if(!var3 && var2 >= 0) {
      scripts\mp\equipment::giveequipment(level.br_pickups.br_equipname[self.br_inventory_slots[var2].scriptablename], "health");
      scripts\mp\equipment::setequipmentslotammo("health", self.br_inventory_slots[var2].count);
      self.br_inventory_slots[var2] = undefined;
      return;
    }

    scripts\mp\equipment::takeequipment("health");
    return;
  }
}