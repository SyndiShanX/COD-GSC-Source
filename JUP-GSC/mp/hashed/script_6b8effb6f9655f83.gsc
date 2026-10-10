/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6b8effb6f9655f83.gsc
*************************************************/

#using script_443d99fe707f1d9f;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\weapon;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace loot_drop;

function function_251cd47c5242ae4f() {
  level callback::add("on_ai_killed", &on_ai_killed);
  level.var_14fad57c290ee19a = &function_97ed4e4e49d3e1b;
  level.var_170ca38d1fed8147 = &function_1415d77bc67b91fc;

  level.var_e7e662c51dc0814a = getDvar(@ "hash_a6a124879b28d19d");
}

function on_zombie_ai_killed(params) {
  if(istrue(self.var_7e4b076a06c6df27) || istrue(self.var_a9cfabe3e558f7fa)) {
    return;
  }

  var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie";
  dropitemcount = 2;

  if(isDefined(level.var_dc23eb4e69e18ed6)) {
    var_cde3aa266f27c24d = level.var_dc23eb4e69e18ed6;
  }

  if(self.subclass == "zombie_base_armored_heavy") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_armored";
  } else if(self.zombieaisetting == "settings_zombie_abom" || self.zombieaisetting == "settings_zombie_abom_mega" || self.zombieaisetting == "settings_zombie_abom_mega_hvt") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_abomination";
    dropitemcount = 6;
  } else if(self.subclass == "zombie_hellhound") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_hellhound";
  } else if(self.subclass == "zombie_mangler") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_mangler";
  } else if(self.subclass == "zombie_mimic") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_mimic";
  } else if(self.subclass == "zombie_disciple") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_disciple";
  } else if(self.subclass == "zombie_disciple_hvt_stormcaller") {
    dropitemcount = 6;
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_disciple_hvt_stormcaller";
  } else if(self.subclass == "zombie_base_armored_light") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_armored_light";
  } else if(self.subclass == "zombie_deathworm") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_deathworm";
    dropitemcount = 10;
  } else if(self.subclass == "zombie_deathworm_quest_s1") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_deathworm";
    dropitemcount = 10;
  } else if(self.subclass == "zombie_deathworm_riftrun") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_deathworm";
    dropitemcount = 10;
  } else if(self.subclass == "zombie_deathworm_boss") {
    var_cde3aa266f27c24d = "ob_jup_items_enemy_droplist_zombie_deathworm";
    dropitemcount = 10;
  }

  if(isDefined(level.var_e7e662c51dc0814a) && level.var_e7e662c51dc0814a != "") {
    var_cde3aa266f27c24d = level.var_e7e662c51dc0814a;
  }

  spawn_pos = self.origin;
  var_d03b21428bf6d166 = spawnStruct();
  function_f632348cbb773537(level.var_230e213404e33c44, var_d03b21428bf6d166);
  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07(var_cde3aa266f27c24d, dropitemcount, spawn_pos);
}

function on_ai_killed(params) {
  if(!getdvarint(@ "hash_ab61a3c338b17bdf", 1)) {
    return;
  }

  if(!isDefined(level.var_230e213404e33c44)) {
    level.var_230e213404e33c44 = throttle_initialize("loot_drop_killed", 1, level.framedurationseconds);
  }

  if(self.unittype == "soldier") {
    function_1ebeccaabab5d730(params);
    return;
  }

  if(self.type == "zombie") {
    on_zombie_ai_killed(params);
  }
}

function function_1ebeccaabab5d730(params) {
  if(istrue(self.var_7e4b076a06c6df27) || istrue(self.var_a9cfabe3e558f7fa)) {
    return;
  }

  if(isDefined(self.vehicle) && istrue(self.vehicle.isheli)) {
    return;
  }

  if(self.unittype == "soldier") {
    dropquantity = 2;
    var_2d62b5de8c483c2f = "ob_jup_items_enemy_droplist_solider";

    if(isDefined(level.var_e7e662c51dc0814a) && level.var_e7e662c51dc0814a != "") {
      var_2d62b5de8c483c2f = level.var_e7e662c51dc0814a;
    } else if(isDefined(self.ob) && isDefined(self.ob.var_2189bfeed28cbb65)) {
      var_2d62b5de8c483c2f = function_ecfc5eec680d2b6();
      dropquantity = function_25c1bfac5c9b6573();
    } else if(isDefined(self.ob) && istrue(self.ob.var_392cd09a100e53d5)) {
      var_2d62b5de8c483c2f = function_f22dd81df2150b04();
      dropquantity = function_3ca2b9357c34701();
    } else {
      var_2d62b5de8c483c2f = function_97263a41a3e0f9d7();
    }

    weapon = function_97ed4e4e49d3e1b();
    spawn_pos = self.origin;
    floorspawnpos = self getdroptofloorposition(spawn_pos);

    if(isDefined(floorspawnpos)) {
      spawn_pos = floorspawnpos;
    }

    alreadydroppedweapon = 0;

    if(istrue(self.alreadydroppedweapon)) {
      alreadydroppedweapon = 1;
    }

    var_d03b21428bf6d166 = spawnStruct();
    function_f632348cbb773537(level.var_230e213404e33c44, var_d03b21428bf6d166);

    if(!alreadydroppedweapon) {
      function_1415d77bc67b91fc(weapon, spawn_pos);
    }

    common_item::function_cd45408bd44fab07(var_2d62b5de8c483c2f, dropquantity, spawn_pos);
  }
}

function function_97ed4e4e49d3e1b() {
  if(isDefined(self.lastweapon) && (arraycontains(strtok(self.lastweapon.basename, "_"), "la") || arraycontains(strtok(self.lastweapon.basename, "_"), "sn"))) {
    return self.lastweapon;
  }

  if(isDefined(self.primaryweapon) && self.primaryweapon.basename != "none") {
    return self.primaryweapon;
  }

  return weapon::buildweapon("iw9_pi_golf17_mp");
}

function function_1415d77bc67b91fc(weapon, origin) {
  dropinfo = common_item::function_49b86047c8a8b228(common_item::function_59a2e61d79065dca(), origin);
  weaponinfostruct = spawnStruct();
  weaponinfostruct.ammoclipright = weaponclipsize(weapon);
  weaponinfostruct.ammoclipleft = weaponclipsize(weapon);
  weaponinfostruct.var_9bfd50804dd2553c = namespace_736197e4d378b91b::function_aedc908c4a79d05e(weapon) ? 0 : weaponclipsize(weapon getaltweapon());
  weaponinfostruct.ammostock = weaponmaxammo(weapon);
  item = namespace_736197e4d378b91b::function_6cf4b48de9a4bc39(weapon, weaponinfostruct, dropinfo.origin, dropinfo.angles, dropinfo.payload);

  if(!isDefined(item)) {
    return;
  }

  item.var_4f74f0aef2b2a8bf = spawnStruct();
  item.var_4f74f0aef2b2a8bf.itembundlename = namespace_736197e4d378b91b::function_46423e80a0fa8f2(weapon.basename, 0, weapon.variantid);
  item.var_4f74f0aef2b2a8bf.attachments = weapon.attachments;
  item.var_4f74f0aef2b2a8bf.rarity = 0;
  item.var_4f74f0aef2b2a8bf.baseweapon = weapon.basename;
  item.var_4f74f0aef2b2a8bf.variantid = weapon.variantid;
}

function function_97263a41a3e0f9d7() {
  if(isDefined(self.subclass)) {
    switch (self.subclass) {
      case #"hash_806a6487959205af":
        return "ob_jup_items_enemy_droplist_captain";
      default:
        return "ob_jup_items_enemy_droplist_solider";
    }
  }

  return "ob_jup_items_enemy_droplist_solider";
}

function function_ecfc5eec680d2b6() {
  if(!isDefined(level.ob)) {
    return "ob_jup_items_enemy_droplist_solider";
  }

  var_3ecf047d758de560 = level.ob.var_3ecf047d758de560[self.ob.var_2189bfeed28cbb65];

  if(isDefined(var_3ecf047d758de560)) {
    switch (self.subclass) {
      case #"hash_d646bb7570717551":
        return "ob_jup_items_warlord_allforone";
      case #"hash_12daa0cbf50f6442":
        return "ob_jup_items_warlord_chemist";
      case #"hash_8c92249632740ac":
        return "ob_jup_items_warlord_maestro";
      case #"hash_dde105a699b160b3":
        return "ob_jup_items_warlord_rainmaker";
      default:
        if(var_3ecf047d758de560.warlordtype == "Chemist") {
          return "ob_jup_items_chemist_bodyguard";
        }

        break;
    }
  }

  return "ob_jup_items_enemy_droplist_solider";
}

function function_25c1bfac5c9b6573() {
  if(!isDefined(level.ob)) {
    return 2;
  }

  var_3ecf047d758de560 = level.ob.var_3ecf047d758de560[self.ob.var_2189bfeed28cbb65];

  switch (self.subclass) {
    case #"hash_d646bb7570717551":
      return 1;
    case #"hash_12daa0cbf50f6442":
      return 1;
    case #"hash_8c92249632740ac":
      return 1;
    case #"hash_dde105a699b160b3":
      return 1;
    default:
      if(var_3ecf047d758de560.warlordtype == "Chemist") {
        return 4;
      }

      break;
  }

  return 2;
}

function function_f22dd81df2150b04() {
  if(!isDefined(level.ob)) {
    return "ob_jup_items_enemy_droplist_solider";
  }

  if(self.ob.warlordtype == "WARLORD_CHEMIST") {
    return "ob_jup_items_chemist_fortressguard";
  }

  return "ob_jup_items_enemy_droplist_solider";
}

function function_3ca2b9357c34701() {
  if(!isDefined(level.ob)) {
    return 2;
  }

  if(self.ob.warlordtype == "WARLORD_CHEMIST") {
    return 3;
  }

  return 2;
}