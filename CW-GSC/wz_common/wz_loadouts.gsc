/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\wz_loadouts.gsc
***********************************************/

#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace wz_loadouts;

function private autoexec __init__system__() {
  system::register(#"wz_loadouts", &preinit, undefined, undefined, #"item_inventory");
}

function private preinit() {
  gametype = util::get_game_type();

  if(gametype !== # "warzone_hot_pursuit" && gametype !== # "warzone_heavy_metal" && gametype !== # "warzone_bigteam_dbno_quad") {
    return;
  }

  if(isDefined(getgametypesetting(#"hash_7d8c969e384dd1c9")) ? getgametypesetting(#"hash_7d8c969e384dd1c9") : 0) {
    level.var_5c14d2e6 = &function_3fed57dd;
  }

  if(isDefined(getgametypesetting(#"hash_4149d5d65eb07138")) ? getgametypesetting(#"hash_4149d5d65eb07138") : 0) {
    level.var_317fb13c = &function_3fed57dd;

    if(gametype === # "warzone_bigteam_dbno_quad") {
      level.var_317fb13c = &function_a9b8fa06;
    }
  }
}

function function_a9b8fa06() {
  assert(isPlayer(self));

  if(!isPlayer(self) || !isalive(self)) {
    return;
  }

  item_world::function_1b11e73c();

  while(isDefined(self) && !isDefined(self.inventory)) {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  self function_7376c60d();
}

function function_3fed57dd() {
  assert(isPlayer(self));

  if(!isPlayer(self) || !isalive(self)) {
    return;
  }

  item_world::function_1b11e73c();

  while(isDefined(self) && !isDefined(self.inventory)) {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(level.deathcircleindex)) {
    self function_58190f52();
    return;
  }

  switch (level.deathcircleindex) {
    case 0:
      self function_58190f52();
      break;
    case 1:
      self function_6667abef();
      break;
    case 2:
      self function_7376c60d();
      break;
    case 3:
      self function_1f091d2f();
      break;
    case 4:
      self function_2d31b980();
      break;
    default:
      self function_58190f52();
      break;
  }
}

function give_item(item_name, item_count) {
  if(!isPlayer(self)) {
    assert(0);
    return;
  }

  if(!isstring(item_name) && !ishash(item_name)) {
    assert(0);
    return;
  }

  item = item_world_util::function_49ce7663(item_name);

  if(isDefined(item_count) && isint(item_count)) {
    if(item.itementry.itemtype == # "ammo") {
      item.amount = item.itementry.amount * item_count;
    } else {
      item.count = item_count;
    }
  }

  var_fa3df96 = self item_inventory::function_e66dcff5(item);
  self item_world::function_de2018e3(item, self, var_fa3df96);
}

function give_weapon(weaponname, attachmentnames) {
  if(!isPlayer(self)) {
    assert(0);
    return;
  }

  if(!isstring(weaponname) && !ishash(weaponname)) {
    assert(0);
    return;
  }

  if(isDefined(attachmentnames) && !isarray(attachmentnames)) {
    assert(0);
    return;
  }

  weapon = item_world_util::function_49ce7663(weaponname);
  var_fa3df96 = self item_inventory::function_e66dcff5(weapon);

  if(isDefined(attachmentnames)) {
    weapon.attachments = [];

    foreach(attachmentname in attachmentnames) {
      if(!isstring(attachmentname) && !ishash(attachmentname)) {
        assert(0);
        return;
      }

      attachment = item_world_util::function_49ce7663(attachmentname);
      item_inventory_util::function_9e9c82a6(weapon, attachment);
    }

    weapon.amount = self getweaponammoclipsize(item_inventory_util::function_2b83d3ff(weapon));
  }

  self item_world::function_de2018e3(weapon, self, var_fa3df96);
}

function private function_58190f52() {
  gametype = util::get_game_type();

  if(gametype == # "warzone_hot_pursuit" || gametype == # "warzone_bigteam_dbno_quad") {
    give_weapon(#"pistol_standard_t8_item");
    give_item(#"ammo_type_45_item");
    return;
  }

  if(gametype == # "warzone_heavy_metal") {
    give_weapon(#"lmg_spray_t8_item");
    give_item(#"ammo_type_556_item");
    return;
  }

  if(gametype == # "hash_135cf8c5c6396f04") {
    function_f56a5599();
  }
}

function private function_6667abef() {
  gametype = util::get_game_type();

  if(gametype == # "warzone_hot_pursuit" || gametype == # "warzone_bigteam_dbno_quad") {
    give_weapon(#"pistol_standard_t8_item", array(#"fastmag_wz_item", #"tritium_wz_item"));
    give_item(#"ammo_type_45_item");
    give_item(#"health_item_small", 5);
    return;
  }

  if(gametype == # "warzone_heavy_metal") {
    give_weapon(#"lmg_spray_t8_item", array(#"fastmag_wz_item", #"acog_wz_item"));
    give_item(#"ammo_type_556_item");
    give_item(#"health_item_large");
    return;
  }

  if(gametype == # "hash_135cf8c5c6396f04") {
    function_f56a5599();
  }
}

function private function_7376c60d() {
  gametype = util::get_game_type();

  if(gametype == # "warzone_hot_pursuit" || gametype == # "warzone_bigteam_dbno_quad") {
    give_weapon(#"smg_standard_t8_item");
    give_item(#"ammo_type_9mm_item");
    give_item(#"health_item_small", 5);
    return;
  }

  if(gametype == # "warzone_heavy_metal") {
    give_weapon(#"lmg_standard_t8_item");
    give_item(#"ammo_type_762_item");
    give_item(#"health_item_large", 2);
    return;
  }

  if(gametype == # "hash_135cf8c5c6396f04") {
    function_f56a5599();
  }
}

function private function_1f091d2f() {
  gametype = util::get_game_type();

  if(gametype == # "warzone_hot_pursuit" || gametype == # "warzone_bigteam_dbno_quad") {
    give_weapon(#"smg_standard_t8_item", array(#"laser_sight_wz_item"));
    give_item(#"ammo_type_9mm_item");
    give_item(#"health_item_small", 5);
    give_item(#"armor_item_small");
    give_item(#"armor_shard_item", 5);
    return;
  }

  if(gametype == # "warzone_heavy_metal") {
    give_weapon(#"lmg_standard_t8_item", array(#"fastmag_wz_item", #"acog_wz_item"));
    give_item(#"ammo_type_762_item");
    give_item(#"health_item_large", 3);
    give_item(#"armor_item_large");
    return;
  }

  if(gametype == # "hash_135cf8c5c6396f04") {
    function_f56a5599();
  }
}

function private function_2d31b980() {
  gametype = util::get_game_type();

  if(gametype == # "warzone_hot_pursuit" || gametype == # "warzone_bigteam_dbno_quad") {
    give_weapon(#"smg_standard_t8_item", array(#"holo_wz_item", #"laser_sight_wz_item", #"extbarrel_wz_item"));
    give_item(#"ammo_type_9mm_item");
    give_item(#"health_item_small", 5);
    give_item(#"armor_item_medium");
    give_item(#"armor_shard_item", 5);
    return;
  }

  if(gametype == # "warzone_heavy_metal") {
    give_weapon(#"lmg_standard_t8_item", array(#"extmag_wz_item", #"reddot_wz_item", #"extbarrel_wz_item"));
    give_item(#"ammo_type_762_item");
    give_item(#"health_item_large", 3);
    give_item(#"armor_item_large");
    give_item(#"armor_shard_item", 5);
    return;
  }

  if(gametype == # "hash_135cf8c5c6396f04") {
    function_f56a5599();
  }
}

function private function_f56a5599() {
  give_weapon(#"lmg_stealth_t8_item");
  give_weapon(#"ar_peacekeeper_t8_item");
  give_item(#"ammo_type_556_item", 2);
  give_item(#"health_item_squad", 5);
  give_item(#"armor_item_medium");
  give_item(#"dart_wz_item", 5);
  give_item(#"ultimate_turret_wz_item", 5);
}