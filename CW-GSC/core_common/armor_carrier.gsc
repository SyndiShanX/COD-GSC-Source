/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\armor_carrier.gsc
***********************************************/

#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapons;
#namespace armor_carrier;

function private autoexec __init__system__() {
  system::register(#"armor_carrier", &preinit, undefined, &finalize, undefined);
}

function private preinit() {
  level.var_8ef8b9e8 = getweapon(#"armor_plate");
  clientfield::register_clientuimodel("hudItems.armorPlateCount", 1, 4, "int", 0);
  clientfield::register_clientuimodel("hudItems.armorPlateMaxCarry", 1, 4, "int");
  callback::on_spawned(&on_player_spawned);
  callback::on_connect(&on_player_connect);
  callback::add_callback(#"on_loadout", &on_player_loadout);
  serverfield::register("armor_plate_behavior", 1, 1, "int", &function_deb3cb98);
}

function private finalize() {
  item_world::function_861f348d(#"generic_pickup", &function_e74225a7);
}

function function_deb3cb98(oldval, newval) {
  if(!isPlayer(self)) {
    return;
  }

  self.armor_plate_behavior = newval;
}

function private on_player_connect() {
  if(!isDefined(self.armor_plate_behavior)) {
    self.armor_plate_behavior = isDefined(self serverfield::get("armor_plate_behavior")) ? self serverfield::get("armor_plate_behavior") : 0;
  }
}

function private on_player_spawned() {
  self.armorplatecount = 0;
  self.var_c52363ab = 5;
  self clientfield::set_player_uimodel("hudItems.armorPlateCount", self.armorplatecount);
  self clientfield::set_player_uimodel("hudItems.armorPlateMaxCarry", self.var_c52363ab);
}

function private on_player_loadout() {
  self giveweapon(level.var_8ef8b9e8);
  self lockweapon(level.var_8ef8b9e8, 1, 1);

  if(is_true(getgametypesetting(#"hash_5700fdc9d17186f7"))) {
    self armor::set_armor(225, 225, 3, 0.4, 1, 0.5, 0, 1, 1, 1);
    return;
  }

  if((isDefined(getgametypesetting(#"hash_64f2892e3a0fd0b")) ? getgametypesetting(#"hash_64f2892e3a0fd0b") : 0) > 0) {
    self armor::set_armor(getgametypesetting(#"hash_64f2892e3a0fd0b") * 75, 225, 3, 0.4, 1, 0.5, 0, 1, 1, 1);
  }
}

function private function_e74225a7(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot) {
  if(itemcount.itementry.itemtype == # "armor_shard") {
    var_82da4e0 = int(min(slot, self.var_c52363ab - var_aec6fa7f.armorplatecount));
    var_aec6fa7f.armorplatecount += var_82da4e0;
    var_aec6fa7f clientfield::set_player_uimodel("hudItems.armorPlateCount", var_aec6fa7f.armorplatecount);
    return (slot - var_82da4e0);
  }

  return slot;
}

function private function_86b9a404() {
  if(self isonladder() || self function_b4813488() || self inlaststand() || self isparachuting() || self isinfreefall() || self isskydiving()) {
    return false;
  }

  return self.armorplatecount > 0 && armor::get_armor() < 225;
}

function function_e12c220a(var_16888a24) {
  assert(isPlayer(self));

  if(!isPlayer(self)) {
    return;
  }

  self.var_c52363ab = var_16888a24;
  self clientfield::set_player_uimodel("hudItems.armorPlateMaxCarry", self.var_c52363ab);
}

function private function_d66636df() {
  if(function_86b9a404()) {
    self.armorplatecount -= 1;
    self clientfield::set_player_uimodel("hudItems.armorPlateCount", self.armorplatecount);
    currentarmor = armor::get_armor();
    var_3d557ef9 = currentarmor + 75;
    var_3d557ef9 = int(min(var_3d557ef9, 225));
    self armor::set_armor(var_3d557ef9, 225, 3, 0.4, 1, 0.5, 0, 1, 1, 1);
    return true;
  }

  return false;
}

function private function_a7879258(lastweapon) {
  self endon(#"disconnect");

  if(lastweapon === level.var_8ef8b9e8 || lastweapon === level.weaponnone) {
    lastweapon = undefined;
  }

  var_b2cde03b = function_ce353466(lastweapon);

  if(self getcurrentweapon() === level.var_8ef8b9e8 && !self isswitchingweapons()) {
    self weapons::function_d571ac59(lastweapon, 0, 0, var_b2cde03b);
    return;
  }

  waitresult = self waittilltimeout(2, #"weapon_change_complete", #"death", #"enter_vehicle", #"exit_vehicle");

  if(waitresult._notify !== # "weapon_change_complete") {
    self weapons::function_d571ac59(lastweapon, 0, 0, var_b2cde03b);
    return;
  }

  if(self getcurrentweapon() === level.var_8ef8b9e8) {
    if(!isDefined(self.armor_plate_behavior)) {
      self.armor_plate_behavior = isDefined(self serverfield::get("armor_plate_behavior")) ? self serverfield::get("armor_plate_behavior") : 0;
    }

    self.var_6a0f2dd7 = 0;
    self.var_32b4a72a = 0;

    if(self.armor_plate_behavior != 1) {
      self thread function_c81e4a7c();
    }

    for(;;) {
      if(!function_86b9a404() || self.var_32b4a72a === 1 && self.var_6a0f2dd7) {
        self weapons::function_d571ac59(lastweapon, 0, 0, var_b2cde03b);
        return;
      }

      waitresult = self waittilltimeout(1.1, #"death", #"enter_vehicle", #"exit_vehicle");

      if(waitresult._notify !== # "timeout") {
        self weapons::function_d571ac59(lastweapon, 0, 0, var_b2cde03b);
        return;
      }

      if(self getcurrentweapon() !== level.var_8ef8b9e8 || self isdroppingweapon()) {
        break;
      }

      if(function_d66636df()) {
        self.var_6a0f2dd7 = 1;
      }
    }
  } else {
    return;
  }

  currentweapon = self getcurrentweapon();

  if(currentweapon === level.var_8ef8b9e8 || currentweapon === level.weaponnone) {
    self weapons::function_d571ac59(lastweapon, 0, 0, var_b2cde03b);
  }
}

function private function_ce353466(last_weapon) {
  if(!isDefined(last_weapon) || last_weapon === level.weaponnone || last_weapon === level.var_8ef8b9e8) {
    return false;
  }

  if(!self hasweapon(last_weapon)) {
    return false;
  }

  if(last_weapon === level.laststandpistol) {
    return false;
  }

  if(killstreaks::is_killstreak_weapon(last_weapon) && last_weapon.iscarriedkillstreak !== 1) {
    return false;
  }

  if(last_weapon.isgameplayweapon || last_weapon.var_29d24e37 || last_weapon.var_9a789947 || last_weapon.isnotdroppable) {
    return false;
  }

  return true;
}

function private function_c81e4a7c() {
  self endon(#"disconnect");
  self.var_32b4a72a = 0;

  while(isalive(self) && (self weaponswitchbuttonPressed() || self function_315b0f70()) && self getcurrentweapon() === level.var_8ef8b9e8 && !self isdroppingweapon()) {
    waitframe(1);
  }

  self.var_32b4a72a = 1;
}

function event_handler[weapon_change] function_62befac0(eventstruct) {
  if(eventstruct.weapon === level.var_8ef8b9e8) {
    self thread function_a7879258(eventstruct.last_weapon);
  }
}