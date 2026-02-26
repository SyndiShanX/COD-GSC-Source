/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_72401f526ba71638.gsc
***********************************************/

#using script_2467fe25132955b8;
#using script_27610ca25737f68d;
#using script_340a2e805e35f7a2;
#using script_421ca110b4204518;
#using script_44c2a1259e14bef1;
#using script_58860a35d0555f74;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_1b527536;

function private autoexec __init__system__() {
  system::register(#"hash_13a43d760497b54d", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_9bff3a72 = getgametypesetting(#"hash_7dedd27bf994a9a9");

  if(!is_true(level.var_9bff3a72)) {
    return;
  }

  level.var_d98fc25e = [];
  function_134fcf4b(#"frost_blast", #"frost_blast_1", #"frost_blast_2", #"frost_blast_3", #"frost_blast_4", #"frost_blast_5");
  function_134fcf4b(#"heal_aoe", #"heal_aoe_1", #"heal_aoe_2", #"heal_aoe_3", #"heal_aoe_4", #"heal_aoe_5");
  function_134fcf4b(#"energy_mine", #"energy_mine_1", #"energy_mine_2", #"energy_mine_3", #"energy_mine_4", #"energy_mine_5");
  function_134fcf4b(#"aether_shroud", #"aether_shroud_1", #"aether_shroud_2", #"aether_shroud_3", #"aether_shroud_4", #"aether_shroud_5");
  function_134fcf4b(#"ring_of_fire", #"ring_of_fire_1", #"ring_of_fire_2", #"ring_of_fire_3", #"ring_of_fire_4", #"ring_of_fire_5");
  function_134fcf4b(#"hash_55569355da0f0f68", #"hash_43e326396554e18c", #"hash_43e329396554e6a5", #"hash_43e328396554e4f2", #"hash_43e323396554dc73", #"hash_43e322396554dac0");
  function_134fcf4b(#"toxic_growth", #"toxic_growth_1", #"toxic_growth_2", #"toxic_growth_3", #"toxic_growth_4", #"toxic_growth_5");
  function_134fcf4b(#"lightning_links", #"lightning_links_1", #"lightning_links_2", #"lightning_links_3", #"lightning_links_4", #"lightning_links_5");
  level.var_dbd3b871 = [];
  level.var_bfc892f2 = [];
  level.var_fee98522 = [];
  level.var_5b46d961 = [];
  level.var_197c8eb1 = 0;
  level.var_1b527536 = array(#"frost_blast", #"frost_blast_1", #"frost_blast_2", #"frost_blast_3", #"frost_blast_4", #"frost_blast_5", #"heal_aoe", #"heal_aoe_1", #"heal_aoe_2", #"heal_aoe_3", #"heal_aoe_4", #"heal_aoe_5", #"energy_mine", #"energy_mine_1", #"energy_mine_2", #"energy_mine_3", #"energy_mine_4", #"energy_mine_5", #"aether_shroud", #"aether_shroud_1", #"aether_shroud_2", #"aether_shroud_3", #"aether_shroud_4", #"aether_shroud_5", #"ring_of_fire", #"ring_of_fire_1", #"ring_of_fire_2", #"ring_of_fire_3", #"ring_of_fire_4", #"ring_of_fire_5", #"hash_55569355da0f0f68", #"hash_43e326396554e18c", #"hash_43e329396554e6a5", #"hash_43e328396554e4f2", #"hash_43e323396554dc73", #"hash_43e322396554dac0", #"toxic_growth", #"toxic_growth_1", #"toxic_growth_2", #"toxic_growth_3", #"toxic_growth_4", #"toxic_growth_5", #"lightning_links", #"lightning_links_1", #"lightning_links_2", #"lightning_links_3", #"lightning_links_4", #"lightning_links_5");
  clientfield::register_clientuimodel("hud_items.ammoCooldowns.fieldUpgrade", 1, 5, "float");
  clientfield::register("toplayer", "field_upgrade_selected", 1, 6, "int");
  clientfield::register("allplayers", "field_upgrade_fired", 1, 4, "counter");
  clientfield::function_91cd7763("material", "zm_field_upgrade_loadout.overrideImage", 16000, 0);
  callback::on_spawned(&function_1505f5d4);
  callback::on_ai_killed(&function_f832427c);
  callback::on_bleedout(&function_9482f724);

  level.var_f793af68 = &function_f793af68;
}

function function_7a0afa38(image = # "ui_icon_zm_field_upgrade_canister") {
  self clientfield::set_player_uimodel("zm_field_upgrade_loadout.overrideImage", image);
}

function function_b168fc67() {
  self clientfield::set_player_uimodel("zm_field_upgrade_loadout.overrideImage", #"white");
}

function function_134fcf4b(var_5eebbc40, ...) {
  var_50846129 = [];

  if(!isDefined(var_50846129)) {
    var_50846129 = [];
  } else if(!isarray(var_50846129)) {
    var_50846129 = array(var_50846129);
  }

  var_50846129[var_50846129.size] = var_5eebbc40;

  for(i = 0; i < vararg.size; i++) {
    if(!isDefined(var_50846129)) {
      var_50846129 = [];
    } else if(!isarray(var_50846129)) {
      var_50846129 = array(var_50846129);
    }

    var_50846129[var_50846129.size] = vararg[i];
  }

  level.var_d98fc25e[var_5eebbc40] = var_50846129;
}

function function_dbd391bf(weaponname, func) {
  level.var_dbd3b871[weaponname] = func;
}

function function_36e0540e(weaponname, maxammo, killcount, itemname) {
  level.var_bfc892f2[weaponname] = maxammo;
  level.var_fee98522[weaponname] = killcount;
  level.var_5b46d961[weaponname] = itemname;
}

function function_460882e2(var_4e20aeca = 0) {
  var_874a73c4 = isDefined(self.inventory.items[12].count) ? self.inventory.items[12].count : 0;

  if(self.var_c9448182 > 1 && var_4e20aeca && var_874a73c4 != self.var_c9448182) {
    return;
  }

  self.var_8da24ed0 = 0;
  self clientfield::set_player_uimodel("hud_items.ammoCooldowns.fieldUpgrade", 0);
}

function function_94d18799(var_40e28ba) {
  switch (var_40e28ba) {
    case # "frost_blast_tier":
      return # "frost_blast";
    case # "heal_aoe_tier":
      return # "heal_aoe";
    case # "energy_mine_tier":
      return # "energy_mine";
    case # "aether_shroud_tier":
      return # "aether_shroud";
    case # "ring_of_fire_tier":
      return # "ring_of_fire";
    case # "hash_1bb7d8d0caf94859":
      return # "hash_55569355da0f0f68";
    case # "toxic_growth_tier":
      return # "toxic_growth";
    case # "lightning_links_tier":
      return # "lightning_links";
  }
}

function function_e41a11bf(var_40e28ba, tier) {
  base_name = function_94d18799(var_40e28ba);

  var_8c590502 = isDefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;

  if(var_8c590502 > 0) {
    tier = var_8c590502;
  }

  var_50846129 = level.var_d98fc25e[base_name];

  if(!isDefined(var_50846129)) {
    return # "weapon_null";
  }

  field_upgrade = var_50846129[tier];

  if(!isDefined(field_upgrade)) {
    return # "weapon_null";
  }

  return field_upgrade;
}

function function_12b698fa(statname) {
  var_8c590502 = isDefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;

  if(var_8c590502 > 0) {
    return var_8c590502;
  }

  return self stats::function_6d50f14b(#"cacloadouts", #"upgrade_tiers", statname);
}

function private function_3ef3cec3(class_index) {
  if(isDefined(class_index)) {
    var_d07d57b2 = self function_b958b70d(class_index, "specialgrenade");
  } else {
    var_d07d57b2 = self function_b958b70d(self.class_num, "specialgrenade");
  }

  item_index = getitemindexfromref(var_d07d57b2);
  var_438da649 = function_b143666d(item_index, 1);
  var_40e28ba = var_438da649.var_cd070e56;

  if(!isDefined(var_40e28ba) || var_40e28ba == # "") {
    var_d07d57b2 = level.var_1b527536[0];
  } else if(isDefined(var_40e28ba) && var_40e28ba != # "") {
    tier = self function_12b698fa(var_40e28ba);
    var_d07d57b2 = function_e41a11bf(var_40e28ba, tier);

    if(var_d07d57b2 == # "" || var_d07d57b2 == # "weapon_null") {
      var_d07d57b2 = level.var_1b527536[0];
    }
  }

  self.var_c9448182 = level.var_bfc892f2[var_d07d57b2];
  self.var_fc8023b4 = level.var_fee98522[var_d07d57b2];
  self.var_87f72f8 = level.var_5b46d961[var_d07d57b2];

  for(i = 0; i < level.var_1b527536.size; i++) {
    if(level.var_1b527536[i] == var_d07d57b2) {
      self clientfield::set_to_player("field_upgrade_selected", i + 1);
      break;
    }
  }
}

function private function_7fb7c83c(weaponname) {
  if(!isDefined(weaponname)) {
    return 0;
  }

  if(isweapon(weaponname)) {
    weaponname = weaponname.name;
  }

  if(weaponname === # "hash_7e4053e6965bafa7") {
    return 1;
  }

  inarray = isinarray(level.var_1b527536, weaponname);
  return inarray;
}

function function_1067f94c(class_index) {
  item = self.inventory.items[12];
  var_d07d57b2 = self function_b958b70d(class_index, "specialgrenade");

  if(isDefined(var_d07d57b2)) {
    if(self.var_87f72f8 !== level.var_5b46d961[var_d07d57b2]) {
      var_1e63aebb = self clientfield::get_player_uimodel("zm_field_upgrade_loadout.overrideImage");

      if(var_1e63aebb != # "white" && var_1e63aebb != # "") {
        if(isDefined(class_index)) {
          var_d07d57b2 = self function_b958b70d(class_index, "specialgrenade");
        } else {
          var_d07d57b2 = self function_b958b70d(self.class_num, "specialgrenade");
        }

        item_index = getitemindexfromref(var_d07d57b2);
        var_438da649 = function_b143666d(item_index, 1);
        var_40e28ba = var_438da649.var_cd070e56;

        if(!isDefined(var_40e28ba) || var_40e28ba == # "") {
          var_d07d57b2 = level.var_1b527536[0];
        } else if(isDefined(var_40e28ba) && var_40e28ba != # "") {
          tier = self function_12b698fa(var_40e28ba);
          var_d07d57b2 = function_e41a11bf(var_40e28ba, tier);

          if(var_d07d57b2 == # "" || var_d07d57b2 == # "weapon_null") {
            var_d07d57b2 = level.var_1b527536[0];
          }
        }

        for(i = 0; i < level.var_1b527536.size; i++) {
          if(level.var_1b527536[i] == var_d07d57b2) {
            self clientfield::set_to_player("field_upgrade_selected", i + 1);
            break;
          }
        }

        self.var_2ff27865 = 0;
        self.var_681af36b = 0;
        self.var_d7c2e1cf = level.var_bfc892f2[var_d07d57b2];
        self.var_703fa168 = level.var_fee98522[var_d07d57b2];
        self.var_58fb681e = level.var_5b46d961[var_d07d57b2];
        return;
      }

      if(item.networkid != 32767) {
        item_inventory::remove_inventory_item(item.networkid);
      }

      self function_3ef3cec3(class_index);
      self function_460882e2();
    }
  }
}

function function_9482f724() {
  item = self.inventory.items[12];

  if(item.networkid != 32767) {
    self.var_6e3cb3d1 = item.itementry.name;
    self.var_a4be9abe = item.count;
  }
}

function private function_1505f5d4() {
  self flag::function_c58ecb49("zm_field_upgrade_in_use");
  self.var_8da24ed0 = 0;
  self function_3ef3cec3();
}

function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(!is_true(level.var_9bff3a72)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(self laststand::player_is_in_laststand()) {
    self forceoffhandend();
    progress = self.var_8da24ed0 / self.var_fc8023b4;
    self clientfield::set_player_uimodel("hud_items.ammoCooldowns.fieldUpgrade", progress);
    return;
  }

  if(function_7fb7c83c(eventstruct.weapon.name) && isDefined(level.var_dbd3b871[eventstruct.weapon.name])) {
    self playrumbleonentity(#"hash_116369f6e589c9fd");
    self function_5f81a103(eventstruct.weapon);
    self function_9a67c8c7(eventstruct.weapon.name);
    self thread[[level.var_dbd3b871[eventstruct.weapon.name]]](eventstruct);
  }
}

function function_5f81a103(weapon, b_killed = 0) {
  if(isPlayer(self)) {
    var_49058ab = {
      #var_4b738e64: function_f8d53445(), #var_8335e8a8: zm_utility::function_e3025ca5(), #var_d8fb195f: zm_utility::get_round_number(), #field_upgrade: weapon.name, #var_c9995ddd: b_killed
    };
    self function_678f57c8(#"hash_7f3eae86c535c88", var_49058ab);
  }
}

function private function_9a67c8c7(str_name) {
  switch (str_name) {
    case # "frost_blast_4":
    case # "frost_blast":
    case # "frost_blast_1":
    case # "frost_blast_3":
    case # "frost_blast_2":
    case # "frost_blast_5":
      var_45d28da0 = 1;
      break;
    case # "heal_aoe_1":
    case # "heal_aoe_2":
    case # "heal_aoe_3":
    case # "heal_aoe_4":
    case # "heal_aoe_5":
    case # "heal_aoe":
      var_45d28da0 = 2;
      break;
    case # "energy_mine_1":
    case # "energy_mine_3":
    case # "energy_mine_2":
    case # "energy_mine_4":
    case # "energy_mine_5":
    case # "energy_mine":
      var_45d28da0 = 3;
      break;
    case # "ring_of_fire_4":
    case # "ring_of_fire":
    case # "ring_of_fire_5":
    case # "ring_of_fire_3":
    case # "ring_of_fire_2":
    case # "ring_of_fire_1":
      var_45d28da0 = 4;
      break;
    case # "aether_shroud_3":
    case # "aether_shroud":
    case # "aether_shroud_1":
    case # "aether_shroud_4":
    case # "aether_shroud_5":
    case # "aether_shroud_2":
      var_45d28da0 = 5;
      break;
    case # "hash_43e323396554dc73":
    case # "hash_43e326396554e18c":
    case # "hash_43e328396554e4f2":
    case # "hash_43e329396554e6a5":
    case # "hash_55569355da0f0f68":
    case # "hash_43e322396554dac0":
      var_45d28da0 = 6;
      break;
    case # "toxic_growth_5":
    case # "toxic_growth_4":
    case # "toxic_growth_3":
    case # "toxic_growth_2":
    case # "toxic_growth_1":
    case # "toxic_growth":
      var_45d28da0 = 7;
      break;
    case # "lightning_links_2":
    case # "lightning_links_3":
    case # "lightning_links_4":
    case # "lightning_links_5":
    case # "lightning_links_1":
    case # "lightning_links":
      var_45d28da0 = 8;
      break;
  }

  if(isDefined(var_45d28da0)) {
    self clientfield::increment("field_upgrade_fired", var_45d28da0);
  }
}

function private function_f832427c(s_params) {
  if(isDefined(self.var_c2dcab66)) {
    foreach(playerstruct in self.var_c2dcab66) {
      e_player = playerstruct.player;
      weapon = playerstruct.weapon;

      if(isPlayer(e_player) && function_7fb7c83c(weapon.name)) {
        e_player function_5f81a103(weapon, 1);
      }

      if(e_player flag::get("zm_field_upgrade_in_use")) {
        return;
      }

      if(!isPlayer(e_player) || isDefined(weapon.name) && function_7fb7c83c(weapon.name)) {
        return;
      }

      if(isDefined(e_player.var_d93ab65) && e_player.var_d93ab65.size > 0) {
        return;
      }

      if(is_true(self.var_d0de7f41) || is_true(self.var_7fb7de87)) {
        return;
      }

      if(is_true(e_player zombie_utility::get_zombie_var_player(#"zombie_insta_kill")) || is_true(zombie_utility::get_zombie_var_team(#"zombie_insta_kill", e_player.team))) {
        return;
      }

      if(is_true(e_player.var_e84418c4)) {
        return;
      }

      if(e_player isremotecontrolling()) {
        return;
      }

      e_player.var_8da24ed0 += 1;

      if((is_true(e_player.var_28107825) || e_player flag::get(#"hash_35735a804a34da04")) && isDefined(e_player.var_67aa3392)) {
        e_player.var_67aa3392.var_5b5d9768 = e_player.var_8da24ed0;
      }

      var_7df0eb27 = e_player.var_fc8023b4;

      if(e_player namespace_e86ffa8::function_efb6dedf(2)) {
        var_7df0eb27 -= int(var_7df0eb27 * 0.2);
      }

      e_player function_fe8d21ed(var_7df0eb27);

      if(isPlayer(e_player)) {
        progress = e_player.var_8da24ed0 / var_7df0eb27;
        e_player clientfield::set_player_uimodel("hud_items.ammoCooldowns.fieldUpgrade", progress);
      }
    }

    return;
  }

  if(isPlayer(self.attacker) && self.damageweapon.name === # "hash_6a4dd5ed56f6e3f6") {
    e_player = self.attacker;
    e_player.var_8da24ed0 += 1;

    if((is_true(e_player.var_28107825) || e_player flag::get(#"hash_35735a804a34da04")) && isDefined(e_player.var_67aa3392)) {
      e_player.var_67aa3392.var_5b5d9768 = e_player.var_8da24ed0;
    }

    var_7df0eb27 = e_player.var_fc8023b4;

    if(e_player namespace_e86ffa8::function_efb6dedf(2)) {
      var_7df0eb27 -= int(var_7df0eb27 * 0.2);
    }

    e_player function_fe8d21ed(var_7df0eb27);

    if(isPlayer(e_player)) {
      progress = e_player.var_8da24ed0 / var_7df0eb27;
      e_player clientfield::set_player_uimodel("hud_items.ammoCooldowns.fieldUpgrade", progress);
    }
  }
}

function private function_fe8d21ed(var_7df0eb27 = 0) {
  if(isalive(self) && isDefined(self.var_8da24ed0) && isDefined(self.inventory) && isDefined(self.var_fc8023b4)) {
    var_874a73c4 = isDefined(self.inventory.items[12].count) ? self.inventory.items[12].count : 0;

    if(self.var_8da24ed0 >= var_7df0eb27 && var_874a73c4 < self.var_c9448182) {
      self function_6457e4cd(self.var_87f72f8);
      level.var_197c8eb1 = 1;

      if(isPlayer(self)) {
        var_874a73c4 = isDefined(self.inventory.items[12].count) ? self.inventory.items[12].count : 0;

        if(var_874a73c4 < self.var_c9448182) {
          function_460882e2();
        }
      }
    }
  }
}

function function_4f8cb6fd(item_name) {
  switch (item_name) {
    case # "field_upgrade_aether_shroud_1_item_sr":
    case # "field_upgrade_aether_shroud_2_item_sr":
    case # "field_upgrade_aether_shroud_item_sr":
    case # "field_upgrade_aether_shroud_3_item_sr":
    case # "field_upgrade_aether_shroud_4_item_sr":
    case # "field_upgrade_aether_shroud_5_item_sr":
      if(!is_true(getgametypesetting(#"hash_26dc68686741b223"))) {
        return true;
      }

      break;
    case # "field_upgrade_frost_blast_2_item_sr":
    case # "field_upgrade_frost_blast_5_item_sr":
    case # "field_upgrade_frost_blast_4_item_sr":
    case # "field_upgrade_frost_blast_3_item_sr":
    case # "field_upgrade_frost_blast_1_item_sr":
    case # "field_upgrade_frost_blast_item_sr":
      if(!is_true(getgametypesetting(#"hash_af8083f7ea1c28b"))) {
        return true;
      }

      break;
    case # "field_upgrade_heal_aoe_1_item_sr":
    case # "field_upgrade_heal_aoe_5_item_sr":
    case # "field_upgrade_heal_aoe_4_item_sr":
    case # "field_upgrade_heal_aoe_item_sr":
    case # "field_upgrade_heal_aoe_3_item_sr":
    case # "field_upgrade_heal_aoe_2_item_sr":
      if(!is_true(getgametypesetting(#"hash_77e5bcb82c95cf00"))) {
        return true;
      }

      break;
    case # "field_upgrade_energy_mine_item_sr":
    case # "field_upgrade_energy_mine_5_item_sr":
    case # "field_upgrade_energy_mine_2_item_sr":
    case # "field_upgrade_energy_mine_3_item_sr":
    case # "field_upgrade_energy_mine_1_item_sr":
    case # "field_upgrade_energy_mine_4_item_sr":
      if(!is_true(getgametypesetting(#"hash_4230e2ce569b5e48"))) {
        return true;
      }

      break;
    case # "field_upgrade_ring_of_fire_4_item_sr":
    case # "field_upgrade_ring_of_fire_2_item_sr":
    case # "field_upgrade_ring_of_fire_5_item_sr":
    case # "field_upgrade_ring_of_fire_1_item_sr":
    case # "field_upgrade_ring_of_fire_item_sr":
    case # "field_upgrade_ring_of_fire_3_item_sr":
      if(!is_true(getgametypesetting(#"hash_2015355bc530a7e8"))) {
        return true;
      }

      break;
    case # "field_upgrade_frenzied_guard_item_sr":
    case # "field_upgrade_frenzied_guard_2_item_sr":
    case # "field_upgrade_frenzied_guard_4_item_sr":
    case # "field_upgrade_frenzied_guard_3_item_sr":
    case # "field_upgrade_frenzied_guard_1_item_sr":
    case # "field_upgrade_frenzied_guard_5_item_sr":
      if(!is_true(getgametypesetting(#"hash_6e7905f68c5d7bdd"))) {
        return true;
      }

      break;
    case # "field_upgrade_toxic_growth_5_item_sr":
    case # "field_upgrade_toxic_growth_item_sr":
    case # "field_upgrade_toxic_growth_2_item_sr":
    case # "field_upgrade_toxic_growth_4_item_sr":
    case # "field_upgrade_toxic_growth_1_item_sr":
    case # "field_upgrade_toxic_growth_3_item_sr":
      if(!is_true(getgametypesetting(#"hash_5cedd3fe49a8b4e1"))) {
        return true;
      }

      break;
    case # "field_upgrade_lightning_links_3_item_sr":
    case # "field_upgrade_lightning_links_4_item_sr":
    case # "field_upgrade_lightning_links_5_item_sr":
    case # "field_upgrade_lightning_links_1_item_sr":
    case # "field_upgrade_lightning_links_2_item_sr":
    case # "field_upgrade_lightning_links_item_sr":
      if(!is_true(getgametypesetting(#"hash_1fc262f0136c2814"))) {
        return true;
      }

      break;
  }

  return false;
}

function function_6457e4cd(item_name, count = 1) {
  if(!isDefined(item_name) || item_name == # "") {
    return;
  }

  if(function_4f8cb6fd(item_name)) {
    return;
  }

  self playlocalsound(#"hash_55f9d99ffab775e1");
  item = function_4ba8fde(item_name);

  if(isDefined(item)) {
    item.count = count;
    var_fa3df96 = self item_inventory::function_e66dcff5(item);

    if(isDefined(var_fa3df96)) {
      if(!item_world_util::function_db35e94f(item.networkid)) {
        item.networkid = item_world_util::function_970b8d86(var_fa3df96);
      }

      self item_world::function_de2018e3(item, self, var_fa3df96, 0);

      if(item_name === "field_upgrade_energy_mine_4_item_sr" || item_name === "field_upgrade_energy_mine_5_item_sr") {
        self.var_d9f807a7 = 1;
        return;
      }

      self.var_d9f807a7 = undefined;
    }
  }
}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isPlayer(psoffsettime) && isarray(psoffsettime.var_d93ab65) && psoffsettime.var_d93ab65.size && !function_7fb7c83c(surfacetype.name)) {
    var_8214ea7f = 0;

    foreach(var_3889eb68 in psoffsettime.var_d93ab65) {
      if(isDefined(var_3889eb68.var_c91dca7e) && var_3889eb68.var_c91dca7e > var_8214ea7f) {
        var_8214ea7f = var_3889eb68.var_c91dca7e;
      }
    }

    boneindex += boneindex * var_8214ea7f;

    if(isDefined(self.var_95ee6823)) {
      boneindex *= self.var_95ee6823;
    }
  }

  return int(boneindex);
}

function function_7281de4d(itemname, var_c940cca, weaponname, iconname, maxammo, var_29440b41, charged = 0) {
  var_874a73c4 = isDefined(self.inventory.items[12].count) ? self.inventory.items[12].count : 0;

  if(var_874a73c4 > 0) {
    item = self.inventory.items[12];
    dropitem = self item_inventory::drop_inventory_item(item.networkid);
    dropitem hide();
    dropitem.var_864ea466 = 1;
    self item_inventory::consume_item(dropitem);
  }

  if(!isDefined(level.var_1b527536)) {
    level.var_1b527536 = [];
  } else if(!isarray(level.var_1b527536)) {
    level.var_1b527536 = array(level.var_1b527536);
  }

  if(!isinarray(level.var_1b527536, weaponname)) {
    level.var_1b527536[level.var_1b527536.size] = weaponname;
  }

  level.var_dbd3b871[weaponname] = var_c940cca;
  self.var_2ff27865 = self.var_8da24ed0;
  self.var_681af36b = var_874a73c4;
  self.var_58fb681e = self.var_87f72f8;
  self.var_d7c2e1cf = self.var_c9448182;
  self.var_703fa168 = self.var_fc8023b4;
  self.var_c9448182 = maxammo;
  self.var_fc8023b4 = var_29440b41;
  self.var_87f72f8 = itemname;
  self function_460882e2();

  if(charged) {
    self.var_8da24ed0 = self.var_fc8023b4;
    self function_6457e4cd(self.var_87f72f8);
  } else {
    self.var_8da24ed0 = 0;
  }

  progress = self.var_8da24ed0 / self.var_fc8023b4;
  self clientfield::set_player_uimodel("hud_items.ammoCooldowns.fieldUpgrade", progress);
  self function_7a0afa38(iconname);
}

function function_69303ed3() {
  self endon(#"death");
  var_874a73c4 = isDefined(self.inventory.items[12].count) ? self.inventory.items[12].count : 0;

  if(var_874a73c4 > 0) {
    item = self.inventory.items[12];
    dropitem = self item_inventory::drop_inventory_item(item.networkid);

    if(isentity(dropitem)) {
      dropitem hide();
      dropitem.var_864ea466 = 1;
      self item_inventory::consume_item(dropitem);
    }
  }

  self.var_c9448182 = self.var_d7c2e1cf;
  self.var_fc8023b4 = self.var_703fa168;
  self.var_87f72f8 = self.var_58fb681e;
  self.var_8da24ed0 = self.var_2ff27865;

  if((isDefined(self.var_681af36b) ? self.var_681af36b : 0) > 0) {
    self function_6457e4cd(self.var_87f72f8, self.var_681af36b);
  }

  progress = self.var_8da24ed0 / self.var_fc8023b4;
  self clientfield::set_player_uimodel("hud_items.ammoCooldowns.fieldUpgrade", progress);
  self function_b168fc67();
}

function function_53ca9662(item_name) {
  foreach(i, value in level.var_5b46d961) {
    if(value == item_name) {
      if(isinarray(level.var_d98fc25e[#"aether_shroud"], i)) {
        return # "aether_shroud";
      }

      if(isinarray(level.var_d98fc25e[#"frost_blast"], i)) {
        return # "frost_blast";
      }

      if(isinarray(level.var_d98fc25e[#"energy_mine"], i)) {
        return # "energy_mine";
      }

      if(isinarray(level.var_d98fc25e[#"heal_aoe"], i)) {
        return # "heal_aoe";
      }

      if(isinarray(level.var_d98fc25e[#"ring_of_fire"], i)) {
        return # "ring_of_fire";
      }

      if(isinarray(level.var_d98fc25e[#"hash_55569355da0f0f68"], i)) {
        return # "hash_55569355da0f0f68";
      }

      if(isinarray(level.var_d98fc25e[#"toxic_growth"], i)) {
        return # "toxic_growth";
      }

      if(isinarray(level.var_d98fc25e[#"lightning_links"], i)) {
        return # "lightning_links";
      }
    }
  }
}

function function_841bae20(var_dc307ae2) {
  if(!isDefined(level.var_d98fc25e)) {
    return undefined;
  }

  foreach(upgrade, array in level.var_d98fc25e) {
    if(isinarray(array, var_dc307ae2)) {
      return upgrade;
    }
  }

  return undefined;
}

function function_f793af68() {
  level endon(#"game_ended");
  setDvar(#"hash_6ace867d48136ede", "<dev string:x38>");
  setDvar(#"hash_31bd3f1a2ffb2b7", "<dev string:x38>");
  setDvar(#"hash_78ea4420d95a6213", "<dev string:x38>");
  setDvar(#"hash_3ce5890428b398f1", "<dev string:x38>");
  util::add_debug_command("<dev string:x3c>");
  util::add_debug_command("<dev string:x9a>" + function_9e72a96(#"field_upgrade_frost_blast_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xf4>" + function_9e72a96(#"field_upgrade_frost_blast_1_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x149>" + function_9e72a96(#"field_upgrade_frost_blast_2_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x19c>" + function_9e72a96(#"field_upgrade_frost_blast_3_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x1ef>" + function_9e72a96(#"field_upgrade_frost_blast_4_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x242>" + function_9e72a96(#"field_upgrade_frost_blast_5_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x295>" + function_9e72a96(#"field_upgrade_heal_aoe_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x2eb>" + function_9e72a96(#"field_upgrade_heal_aoe_1_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x341>" + function_9e72a96(#"field_upgrade_heal_aoe_2_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x395>" + function_9e72a96(#"field_upgrade_heal_aoe_3_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x3e9>" + function_9e72a96(#"field_upgrade_heal_aoe_4_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x43d>" + function_9e72a96(#"field_upgrade_heal_aoe_5_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x491>" + function_9e72a96("<dev string:x4e6>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x50b>" + function_9e72a96("<dev string:x560>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x587>" + function_9e72a96("<dev string:x5da>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x601>" + function_9e72a96("<dev string:x654>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x67b>" + function_9e72a96("<dev string:x6ce>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x6f5>" + function_9e72a96("<dev string:x748>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x76f>" + function_9e72a96("<dev string:x7c6>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x7ed>" + function_9e72a96("<dev string:x844>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x86d>" + function_9e72a96("<dev string:x8c2>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x8eb>" + function_9e72a96("<dev string:x940>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x969>" + function_9e72a96("<dev string:x9be>") + "<dev string:xef>");
  util::add_debug_command("<dev string:x9e7>" + function_9e72a96("<dev string:xa3c>") + "<dev string:xef>");
  util::add_debug_command("<dev string:xa65>" + function_9e72a96("<dev string:xabb>") + "<dev string:xef>");
  util::add_debug_command("<dev string:xae1>" + function_9e72a96("<dev string:xb37>") + "<dev string:xef>");
  util::add_debug_command("<dev string:xb5f>" + function_9e72a96("<dev string:xbb3>") + "<dev string:xef>");
  util::add_debug_command("<dev string:xbdb>" + function_9e72a96("<dev string:xc2f>") + "<dev string:xef>");
  util::add_debug_command("<dev string:xc57>" + function_9e72a96("<dev string:xcab>") + "<dev string:xef>");
  util::add_debug_command("<dev string:xcd3>" + function_9e72a96("<dev string:xd27>") + "<dev string:xef>");
  util::add_debug_command("<dev string:xd4f>" + function_9e72a96(#"field_upgrade_frenzied_guard_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xda7>" + function_9e72a96(#"field_upgrade_frenzied_guard_1_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xdff>" + function_9e72a96(#"field_upgrade_frenzied_guard_2_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xe55>" + function_9e72a96(#"field_upgrade_frenzied_guard_3_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xeab>" + function_9e72a96(#"field_upgrade_frenzied_guard_4_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xf01>" + function_9e72a96(#"field_upgrade_frenzied_guard_5_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xf57>" + function_9e72a96(#"field_upgrade_toxic_growth_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:xfad>" + function_9e72a96(#"field_upgrade_toxic_growth_1_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x1003>" + function_9e72a96(#"field_upgrade_toxic_growth_2_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x1057>" + function_9e72a96(#"field_upgrade_toxic_growth_3_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x10ab>" + function_9e72a96(#"field_upgrade_toxic_growth_4_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x10ff>" + function_9e72a96(#"field_upgrade_toxic_growth_5_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x1153>" + function_9e72a96(#"field_upgrade_lightning_links_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x11ac>" + function_9e72a96(#"field_upgrade_lightning_links_1_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x1205>" + function_9e72a96(#"field_upgrade_lightning_links_2_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x125c>" + function_9e72a96(#"field_upgrade_lightning_links_3_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x12b3>" + function_9e72a96(#"field_upgrade_lightning_links_4_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x130a>" + function_9e72a96(#"field_upgrade_lightning_links_5_item_sr") + "<dev string:xef>");
  util::add_debug_command("<dev string:x1361>");
  util::add_debug_command("<dev string:x13b2>");
  util::add_debug_command("<dev string:x1406>");
  function_cd140ee9(#"hash_6ace867d48136ede", &function_35216077);
  function_cd140ee9(#"hash_31bd3f1a2ffb2b7", &function_35216077);
  function_cd140ee9(#"hash_78ea4420d95a6213", &function_35216077);
  function_cd140ee9(#"hash_3ce5890428b398f1", &function_35216077);
}

function function_35216077(params) {
  if(params.value === "<dev string:x38>") {
    return;
  }

  switch (params.name) {
    case # "hash_3ce5890428b398f1":
      if(int(params.value)) {
        iprintlnbold("<dev string:x1467>");
      } else {
        iprintlnbold("<dev string:x1482>");
      }

      break;
    case # "hash_6ace867d48136ede":
      foreach(player in getplayers()) {
        player function_6457e4cd(hash(params.value));
      }

      break;
    case # "hash_31bd3f1a2ffb2b7":
      foreach(player in getplayers()) {
        if(isalive(player) && isDefined(player.var_8da24ed0) && isDefined(player.inventory) && isDefined(player.var_fc8023b4)) {
          player.var_8da24ed0 = player.var_fc8023b4;
          player function_fe8d21ed();
        }
      }

      break;
    case # "hash_78ea4420d95a6213":
      foreach(player in getplayers()) {
        if(params.value == 1) {
          player function_7a0afa38();
          continue;
        }

        player function_b168fc67();
      }

      break;
  }

  setDvar(#"hash_6ace867d48136ede", "<dev string:x38>");
  setDvar(#"hash_31bd3f1a2ffb2b7", "<dev string:x38>");
  setDvar(#"hash_78ea4420d95a6213", "<dev string:x38>");
}