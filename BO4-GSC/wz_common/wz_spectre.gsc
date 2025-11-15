/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_spectre.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\mp_common\item_inventory;
#include scripts\mp_common\item_inventory_util;

#namespace wz_spectre;

autoexec __init__system__() {
  system::register(#"wz_spectre", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising"))) {
    return;
  }

  clientfield::register("allplayers", "hasspectrebody", 16000, 1, "int");
  clientfield::register("toplayer", "spectrebladebonus", 16000, 1, "int");
  clientfield::register("clientuimodel", "hudItems.isSpectre", 16000, 1, "int");
  clientfield::register("world", "showSpectreSwordBeams", 16000, 1, "int");
  callback::add_callback(#"inventory_reset", &function_4467066e);
  callback::add_callback(#"on_drop_item", &function_4467066e);
  callback::on_item_pickup(&function_4467066e);
  callback::add_callback(#"on_player_downed", &function_ef53914c);
  callback::on_player_killed_with_params(&function_de83cc91);
  callback::add_callback(#"hash_405e46788e83af41", &start_beams);
}

start_beams() {
  level clientfield::set("showSpectreSwordBeams", 1);
}

private function_4467066e(params) {
  var_ec8e239d = 0;

  if(isstruct(self.inventory) && isarray(self.inventory.items)) {
    foreach(item in self.inventory.items) {
      itementry = item.itementry;

      if(isDefined(item.itementry) && item.itementry.name == #"sig_blade_wz_item") {
        var_ec8e239d = 1;
        break;
      }
    }
  }

  function_f82142f8(var_ec8e239d);
}

private function_f82142f8(isspectre) {
  self notify(#"hash_2e4cc87f4b3a6396");
  self endon(#"death", #"hash_2e4cc87f4b3a6396");
  level endon(#"game_playing");
  self function_1edd6e9e(isspectre);

  if(!isalive(self)) {
    return;
  }

  self clientfield::set("hasspectrebody", isspectre);
  role = self player_role::get();

  if(isspectre) {
    if(role != 57) {
      wait 0.5;
      self.var_fcb62e3f = role;
      self player_role::set(57);
      self setcharacteroutfit(0);
      self setcharacterwarpaintoutfit(0);
      self function_ab96a9b5("head", 0);
      self function_ab96a9b5("headgear", 0);
      self function_ab96a9b5("arms", 0);
      self function_ab96a9b5("torso", 0);
      self function_ab96a9b5("legs", 0);
      self function_ab96a9b5("palette", 0);
      self function_ab96a9b5("warpaint", 0);
      self function_ab96a9b5("decal", 0);
    }
  } else if(role == 57) {
    wait 0.5;
    self function_9299d039();
  }

  self clientfield::set_player_uimodel("hudItems.isSpectre", isspectre);
}

private function_9299d039() {
  if(isDefined(self.var_fcb62e3f)) {
    self player_role::set(self.var_fcb62e3f);
  }
}

private function_1edd6e9e(isspectre) {
  modelvalue = 0;

  if(isspectre && isalive(self)) {
    modelvalue = 1;
  }
}

private function_ef53914c() {
  params = self.laststandparams;

  if(!isDefined(params)) {
    return;
  }

  attacker = params.attacker;
  weapon = params.sweapon;

  if(!isplayer(attacker) || attacker.team == self.team || weapon.name != #"sig_blade") {
    return;
  }

  attacker thread function_124f7ba3();

  if(attacker.health < attacker.maxhealth) {
    attacker.health = attacker.maxhealth;
  }

  if(isDefined(attacker.inventory) && isDefined(attacker.inventory.items)) {
    foreach(slot in array(16 + 1, 16 + 1 + 6 + 1)) {
      attacker give_max_ammo(slot);
    }
  }
}

private give_max_ammo(weaponslot) {
  item = self.inventory.items[weaponslot];

  if(!isDefined(item)) {
    return;
  }

  weapon = item_inventory_util::function_2b83d3ff(item);

  if(!isDefined(weapon)) {
    return;
  }

  self setweaponammoclip(weapon, weapon.clipsize);

  foreach(ammo in array(#"ammo_type_9mm_item", #"ammo_type_45_item", #"ammo_type_556_item", #"ammo_type_762_item", #"ammo_type_338_item", #"ammo_type_50cal_item", #"ammo_type_12ga_item", #"ammo_type_rocket_item")) {
    ammoitem = getscriptbundle(ammo);

    if(!isDefined(ammoitem.weapon) || ammoitem.weapon.ammoindex !== weapon.ammoindex) {
      continue;
    }

    maxstockammo = item_inventory_util::function_2879cbe0(self.inventory.var_7658cbec, ammoitem.weapon);
    currentammostock = self getweaponammostock(ammoitem.weapon);
    var_9b9ba643 = maxstockammo - currentammostock;
    self function_fc9f8b05(weapon, var_9b9ba643);
    break;
  }
}

private function_124f7ba3() {
  self endon(#"disconnect");
  self clientfield::set_to_player("spectrebladebonus", 1);
  util::wait_network_frame();
  self clientfield::set_to_player("spectrebladebonus", 0);
}

private function_de83cc91(params) {
  attacker = params.eattacker;
  weapon = params.weapon;

  if(isDefined(params.laststandparams)) {
    attacker = params.laststandparams.attacker;
    weapon = params.laststandparams.sweapon;
  }

  if(!isplayer(attacker) || attacker.team == self.team || weapon.name != #"sig_blade") {
    return;
  }
}