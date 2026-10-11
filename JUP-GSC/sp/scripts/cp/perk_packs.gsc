/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\perk_packs.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\armor;
#using scripts\cp\cp_hud_message;
#using scripts\cp\perks;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;
#namespace perk_packs;

function function_9de497922ea1a6bf() {
  level.var_b3cbb613d49ff5a3 = [];
  level.var_e23f2a9c37c8597c = [];
  function_b3c5ba25a66d7ce9("perk_pack_speedy", &function_fa0bb7d172f87c23, &function_494742bebd999d7a);
  function_b3c5ba25a66d7ce9("perk_pack_buff", &function_b206a39197180c92, &function_9f0bac6bdea9712f);
  function_b3c5ba25a66d7ce9("perk_pack_mule", &function_581e926068ad6972, &function_e772d952ad274643);
  function_b3c5ba25a66d7ce9("perk_pack_medic", &function_a7ac939f2c1d839, &function_ed6749412e69fe02);
  function_b3c5ba25a66d7ce9("perk_pack_ammo_buff", &function_f4e87426380be51, &function_54f94ddcc1f58996);
  function_b3c5ba25a66d7ce9("perk_pack_armor_buff", &function_448cea0f7c6fbf36, &function_77eb1d81d0f5e81f);
}

function function_645eb4e3639de90d() {
  if(!isDefined(self.perk_packs)) {
    self.perk_packs = [];
    self.var_c50870864fd5fa67 = 4;
    function_10be613f34ff473a();
  }
}

function function_b3c5ba25a66d7ce9(var_42695dc3bf559617, setfunc, unsetfunc) {
  assert(isDefined(var_42695dc3bf559617));
  assert(isDefined(setfunc));
  assert(isDefined(unsetfunc));

  if(isDefined(setfunc)) {
    assert(isfunction(setfunc));
    level.var_b3cbb613d49ff5a3[var_42695dc3bf559617] = setfunc;
  }

  if(isDefined(unsetfunc)) {
    assert(isfunction(unsetfunc));
    level.var_e23f2a9c37c8597c[var_42695dc3bf559617] = unsetfunc;
  }
}

function function_10be613f34ff473a() {
  for(i = 1; i < 5; i++) {
    self.perk_packs[i] = spawnStruct();
    self.perk_packs[i].pack_level = 0;
    self.perk_packs[i].pack_name = "none";
  }
}

function function_eb542c381f315290() {
  for(i = 1; i < self.var_c50870864fd5fa67 + 1; i++) {
    if(self.perk_packs[i].pack_name == "none") {
      return i;
    }
  }

  return 0;
}

function function_e752c81048e56e3c(slot, pack_level) {
  if(isDefined(pack_level)) {
    self.perk_packs[slot].pack_level = pack_level;
  }
}

function function_dfceffb521d7d4cb(perkname) {
  switch (perkname) {
    case #"hash_4666fbb263cf581b":
      return "perk_pack_mule";
    case #"hash_5d3f25d7f9aa109":
      return "perk_pack_medic";
    case #"hash_46e6f0dbb1fb728c":
      return "perk_pack_buff";
    case #"hash_de9b5c91d811f203":
      return "perk_pack_mule";
    default:
      return "perk_pack_speed";
  }
}

function function_7184b43950d947ea(perk_pack, slot, pack_level) {
  var_5dc06b0667135c87 = "ui_spawn_perk_";
  omnvarindex = slot - 1;
  omnvar = var_5dc06b0667135c87 + omnvarindex;

  if(perk_pack != "none") {
    if(isDefined(omnvar)) {
      omnvar_value = int(tablelookup("cp/perk_pack_table.csv", 1, perk_pack, 0));

      if(isDefined(omnvar_value)) {
        self setclientomnvar(omnvar, omnvar_value);
      }
    }

    return;
  }

  self setclientomnvar(omnvar, -1);
}

function function_74320e884b9a3fd8(pack_name) {
  for(i = 1; i < self.var_c50870864fd5fa67 + 1; i++) {
    if(self.perk_packs[i].pack_name == pack_name) {
      return self.perk_packs[i].pack_level;
    }
  }

  return 0;
}

function function_8f03acc557e2b610(pack_name) {
  for(i = 1; i < self.var_c50870864fd5fa67 + 1; i++) {
    if(self.perk_packs[i].pack_name == pack_name) {
      return true;
    }
  }

  return false;
}

function function_f82e41138806e225() {
  for(i = 1; i < self.var_c50870864fd5fa67 + 1; i++) {
    if(self.perk_packs[i].pack_name == "none") {
      return false;
    }
  }

  return true;
}

function function_de2c47c49e185540(pack_name) {
  for(i = 1; i < self.var_c50870864fd5fa67 + 1; i++) {
    if(self.perk_packs[i].pack_name == pack_name) {
      return i;
    }
  }

  return 0;
}

function function_9ab372b1dc1a8e3() {
  slot = 0;

  for(i = 1; i < self.var_c50870864fd5fa67 + 1; i++) {
    if(self.perk_packs[i].pack_name == "none") {
      slot = i;
    }
  }

  return slot;
}

function function_7f62b61fc20b6540(slot_num) {
  return self.perk_packs[slot_num].pack_name;
}

function function_47ae9e67fafc2fc4(slot_num, var_d1fc596f54becc5a) {
  var_efbe3cb0d8d22512 = function_7f62b61fc20b6540(slot_num);
  function_7175c0fbce3fed06(var_efbe3cb0d8d22512);
  function_9dfbc3169c4fb507(var_d1fc596f54becc5a, 3);
}

function function_6906dab2c6805a25(pack_name, pack_level) {
  slot = function_de2c47c49e185540(pack_name);

  if(slot > 0) {
    current_level = function_74320e884b9a3fd8(pack_name);

    if(current_level < 2) {
      function_e752c81048e56e3c(slot, pack_level);
    }
  }
}

function function_9dfbc3169c4fb507(pack_name, pack_level) {
  slot = function_eb542c381f315290();

  if(slot != 0) {
    self.perk_packs[slot].pack_name = pack_name;
    function_e752c81048e56e3c(slot, pack_level);
    function_7184b43950d947ea(pack_name, slot, pack_level);
    self[[level.var_b3cbb613d49ff5a3[pack_name]]](pack_level);
  }
}

function function_83829cdb2347c8f() {
  function_7175c0fbce3fed06("perk_pack_speedy");
  function_7175c0fbce3fed06("perk_pack_buff");
  function_7175c0fbce3fed06("perk_pack_medic");
  function_7175c0fbce3fed06("perk_pack_mule");
  function_a201dbdaec933ae6();
}

function function_7175c0fbce3fed06(pack_name) {
  for(slot = 1; slot < self.var_c50870864fd5fa67 + 1; slot++) {
    if(self.perk_packs[slot].pack_name == pack_name) {
      self.perk_packs[slot].pack_name = "none";
      self.perk_packs[slot].pack_level = 0;
      function_7184b43950d947ea("none", slot, 0);
      self[[level.var_e23f2a9c37c8597c[pack_name]]](0);
    }
  }
}

function function_ed49c972daeb7575() {
  self.var_c50870864fd5fa67 = 2;
}

function function_a201dbdaec933ae6() {
  self.var_c50870864fd5fa67 = 4;
}

function function_3cf76f4dab9dc93c() {
  if(self.var_c50870864fd5fa67 == 2) {
    return true;
  }

  return false;
}

function function_fa0bb7d172f87c23(pack_level) {
  giveperk("specialty_hustle");
  giveperk("specialty_fastcrouchmovement");
  giveperk("specialty_stalker");
  giveperk("specialty_fastreload");
  giveperk("specialty_tactical_recon");
  giveperk("specialty_warhead");
}

function function_494742bebd999d7a(pack_level) {
  takeperk("specialty_hustle");
  takeperk("specialty_fastcrouchmovement");
  takeperk("specialty_stalker");
  takeperk("specialty_fastreload");
  takeperk("specialty_tactical_recon");
  takeperk("specialty_warhead");
}

function function_a7ac939f2c1d839(pack_level) {
  giveperk("specialty_fast_health_regen");
  giveperk("specialty_quick_revive");
}

function function_ed6749412e69fe02(pack_level) {
  takeperk("specialty_fast_health_regen");
  takeperk("specialty_quick_revive");
}

function function_f4e87426380be51(pack_level) {
  splash = "cp_super_ammo_used";
  scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
  self setclientomnvar("ui_ammo_class_power_on", gettime());
  giveperk("specialty_bulletdamage");
}

function function_54f94ddcc1f58996(pack_level) {
  takeperk("specialty_bulletdamage");
  self setclientomnvar("ui_ammo_class_power_off", gettime());
}

function function_448cea0f7c6fbf36(pack_level) {
  splash = "cp_super_armor_used";
  full_armor = self.var_4cb4a6ebd0885ffd;
  scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(full_armor);
  self.old_armor_scalar = scripts\cp\perks::get_perk("enemy_damage_to_player_armor_scalar");
  scripts\cp\perks::set_perk("enemy_damage_to_player_armor_scalar", self.old_armor_scalar * 1.5);
  self.armorhardened = 1;
  scripts\cp\armor::function_e0d47de3df5f23ea();
}

function function_77eb1d81d0f5e81f(pack_level) {
  scripts\cp\perks::set_perk("enemy_damage_to_player_armor_scalar", self.old_armor_scalar);
  self.armorhardened = 0;
  scripts\cp\armor::function_e0d47de3df5f23ea();
}

function function_b206a39197180c92(pack_level) {
  giveperk("specialty_extra_armor");
  scripts\cp\armor::function_8ce284d6441202b8(pack_level);
  function_79287cc290242a2(self, pack_level);
  giveperk("specialty_eod");
}

function function_9f0bac6bdea9712f(pack_level) {
  takeperk("specialty_extra_armor");
  scripts\cp\armor::function_8ce284d6441202b8(0);
  function_79287cc290242a2(self, 0);
  takeperk("specialty_eod");
}

function function_79287cc290242a2(player, pack_level) {
  entity_num = player getentitynumber();
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "hivesdestroyed", pack_level);
}

function function_581e926068ad6972(pack_level) {
  giveperk("specialty_extra_weapon");
  giveperk("specialty_armor_satchel");
  self setclientomnvar("ui_br_has_plate_pouch", 1);
  giveperk("specialty_extra_shrapnel");
}

function function_e772d952ad274643(pack_level) {
  takeperk("specialty_extra_weapon");
  takeperk("specialty_armor_satchel");
  self setclientomnvar("ui_br_has_plate_pouch", 0);
  takeperk("specialty_extra_shrapnel");
  function_3e9ce650ebb5cee();
}

function function_3e9ce650ebb5cee() {
  primaries = self getweaponslistprimaries();
  weapon_count = 0;
  self.mule_weaponlist = [];

  foreach(weapon in primaries) {
    if(weapon.inventorytype == "primary") {
      self.mule_weaponlist[weapon_count] = weapon;
      weapon_count += 1;
    }
  }

  if(weapon_count >= 3) {
    var_cca6009e1acb40ed = random(self.mule_weaponlist);

    if(isDefined(var_cca6009e1acb40ed)) {
      self takeweapon(var_cca6009e1acb40ed);
    }
  }
}

function function_e5ea666722be9cd0(num) {
  if(!isDefined(num)) {
    num = 4;
  }

  if(_hasperk("specialty_extra_shrapnel")) {
    num += 2;
  }

  return num;
}