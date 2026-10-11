/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\kits.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\globallogic;
#using scripts\cp\kits;
#using scripts\cp\loadout;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\perks;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\progression;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\battlerage;
#using scripts\cp_mp\equipment\stimpistol;
#using scripts\cp_mp\pickups;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace kits;

function init() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1" || level.createfx_enabled) {
    return;
  }

  level thread function_a0b42c4ad579d92d();
  function_8d0097515bff3b01();
  level.kits = [];
  level.var_8ea1af22ffe88d13 = getdvarint(@ "hash_5c3f154759eb545", 0);
  level.var_50c7b4b50d222c0 = -1;
  level.var_e85fcf89f70a718a = [];
  kit_register("kitAssault", &function_9a8f60f7edd5a777, &function_b809060fb006fe63, &function_b5cde7de44edc3ed);
  kit_register("kitMedic", &function_9a8f60f7edd5a777, &function_cc637a3dd608f5ee, &function_d3fa6b71dbfb70e4);
  kit_register("kitRecon", &function_9a8f60f7edd5a777, &function_fc436569eeecfeb, &function_88e35eb26ea39405);
  level.var_6e1af29ff5ac9eab = create_deck(["kitMedic", "kitAssault", "kitRecon"], 1, 1);
  level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&function_73d413e8f4d44f51);
  val::group_register("kitSelect", ["crouch", "prone", "usability", "weapon_switch", "supers", "gesture", "killstreaks", "cp_munitions", "offhand_primary_weapons", "fire", "offhand_secondary_weapons", "offhand_weapons", "allow_movement", "allow_jump", "melee"]);
}

function function_a0b42c4ad579d92d() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");

  if(!getdvarint(@ "hash_6d1717e53049e751", 0)) {
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("cp_kit_select_box", &function_6b01aba37e349764);
    return;
  }

  var_a0342fa7a0730a90 = getEntArray("kitSelectBox", "script_noteworthy");

  foreach(var_c13eaee83f7969e4 in var_a0342fa7a0730a90) {
    var_c13eaee83f7969e4 delete();
  }
}

function function_8d0097515bff3b01() {
  level.var_3ece19163aadf34e = [];

  for(i = 0; i < 10; i++) {
    var = tablelookupbyrow("cp/kitTierThresholds.csv", i, 1);
    level.var_3ece19163aadf34e[level.var_3ece19163aadf34e.size] = int(var);
  }
}

function kit_register(kit_name, var_5a9f3515a988dc27, var_c6acfae4e3bf5232, var_7d26fc6ce47a3fd1) {
  struct = spawnStruct();
  struct.var_5a9f3515a988dc27 = var_5a9f3515a988dc27;
  struct.var_c6acfae4e3bf5232 = var_c6acfae4e3bf5232;
  struct.rank_funcs = [];
  level.kits[kit_name] = struct;
  [[var_7d26fc6ce47a3fd1]]();
}

function function_73d413e8f4d44f51() {
  if(getdvarint(@ "hash_d86c1c5277b6aff3", 0)) {
    return;
  }

  ent_num = "<dev string:x1c>" + self getentitynumber();
  start_path = "<dev string:x1e>" + self.name + "<dev string:x1e>";
  cmd = "<dev string:x20>" + start_path + "<dev string:x37>" + ent_num + "<dev string:x74>";
  addentrytodevgui(cmd);
  var_7fd676df2171ccea = "<dev string:x20>" + start_path + "<dev string:x78>" + ent_num + "<dev string:x74>";
  addentrytodevgui(var_7fd676df2171ccea);
  cmd_assault = "<dev string:x20>" + start_path + "<dev string:xb0>" + ent_num + "<dev string:x74>";
  addentrytodevgui(cmd_assault);
  cmd_recon = "<dev string:x20>" + start_path + "<dev string:xec>" + ent_num + "<dev string:x74>";
  addentrytodevgui(cmd_recon);
  var_968fce5e79523a06 = "<dev string:x20>" + start_path + "<dev string:x124>" + ent_num + "<dev string:x74>";
  addentrytodevgui(var_968fce5e79523a06);

  if(getdvarint(@ "hash_cde8f32ae6195947", 0)) {
    current_kit = function_c6631f3a73e64004();
    rank = 10;
  } else {
    current_kit = function_cc1ccc9e93b22c24();
    rank = kit_getrank();
  }

  if(isDefined(current_kit) && current_kit != "") {
    if(getdvarint(@ "hash_a867e9199df5f340", 0)) {
      thread function_b0a067743207e204();
    }

    if(!isDefined(self.equipment)) {
      self.equipment = [];
    }

    scripts\cp\super::clear_player_class_and_super();
    thread scripts\cp\super::init_super_for_player("super_default_zm");
    scripts\cp\super::function_1f8539b231e93107(current_kit);
    thread scripts\cp\super::update_super_icon(current_kit);
    function_2dbbfd9d03919c32();
    function_5d43ea7662b15991(current_kit);
    player_setrank(rank);
    scripts\cp\globallogic::broadcast_kit(self);

    if(!istrue(self.super_displayed)) {
      self.super_displayed = 1;
    }

    self[[level.kits[current_kit].var_5a9f3515a988dc27]](rank);
  }
}

function function_b0a067743207e204() {
  if(getdvarint(@ "hash_6978b3f150582c40", 1)) {
    level endon("game_ended");
    self endon("disconnect");

    if(istrue(level.var_8ea1af22ffe88d13) && isDefined(self.pers) && isDefined(self.pers["kit"]) && self.pers["kit"] != "kitNone") {
      return;
    }

    self.var_7269deeba689cd65 = 1;

    if(!istrue(self.var_eaa61b501c84602e)) {
      self waittill("spawned_player");
      ent_flag_wait("player_spawned_with_loadout");
    }

    while(self isparachuting() || self isinfreefall() || !self isonground() && !self isswimming() || self isswimunderwater()) {
      waitframe();
    }

    self notifyonplayercommand("assault", "+usereload");
    self notifyonplayercommand("assault", "+activate");
    self notifyonplayercommand("medic", "-smoke");
    self notifyonplayercommand("recon", "+weapnext");
    thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/KITS_TUTORIAL_HINT", 6000);
    val::group_set("kitSelect", 0);
    scripts\cp\utility::freezecontrolswrapper(1);
    disable_backpack_inventory(1);
    var_9db8f59efabb5566 = 0;
    var_197515363c80fa40 = 1;

    while(var_9db8f59efabb5566 < var_197515363c80fa40) {
      result = waittill_any_return_3("assault", "medic", "recon");
      self playlocalsound("weap_ammo_pickup");
      function_abe664c11f9d4b73();

      switch (result) {
        case #"hash_d4f05e450448c3ec":
          function_c3cb4bdae301d5b4("kitAssault");
          break;
        case #"hash_5d3f25d7f9aa109":
          self.pers["override_self_revive_checkpoint"] = 1;
          function_c3cb4bdae301d5b4("kitMedic");
          break;
        case #"hash_9617cc9a55eccdd4":
          function_c3cb4bdae301d5b4("kitRecon");
          break;
      }

      var_9db8f59efabb5566++;
    }

    scripts\cp\utility::freezecontrolswrapper(0);
    val::group_reset("kitSelect");
    disable_backpack_inventory(0);
    self notifyonplayercommandremove("use", "+usereload");
    self notifyonplayercommandremove("use", "+activate");
    self notifyonplayercommandremove("stance", "+stance");
    self notifyonplayercommandremove("swap_weapon", "+weapnext");
    self notify("clear_tutorial_messages");
    self clearhudtutorialmessage();
    self.var_7269deeba689cd65 = undefined;
    rank = 10;
  }
}

function function_c3cb4bdae301d5b4(var_6f37cc057cc7abd7, var_a1f585e5e3a34cd5, var_48db175a7e02aa53, debug_activated) {
  var_63cdcd704dde8c06 = self getclientomnvar("ui_super_progress") * 1000;
  function_abe664c11f9d4b73(1);

  if(!isDefined(var_a1f585e5e3a34cd5)) {
    var_a1f585e5e3a34cd5 = 0;
  }

  function_5d43ea7662b15991(var_6f37cc057cc7abd7);
  rank = kit_getrank(var_6f37cc057cc7abd7, debug_activated);
  player_setrank(rank + var_a1f585e5e3a34cd5);
  scripts\cp\super::clear_player_class_and_super();
  scripts\cp\super::function_1f8539b231e93107(var_6f37cc057cc7abd7);
  self.super_progress = var_63cdcd704dde8c06;
  self setclientomnvar("ui_super_progress", self.super_progress);
  self setclientomnvar("cp_super_fired", 1);
  entity_num = self getentitynumber();
  scripts\cp\globallogic::broadcast_kit(self);
  self.disable_super = 0;
  thread scripts\cp\super::update_super_icon(var_6f37cc057cc7abd7);

  if(self.super_progress > 998) {
    scripts\cp\super::display_super_ready_splash();
  }

  self.var_48db175a7e02aa53 = var_48db175a7e02aa53;
  self[[level.kits[var_6f37cc057cc7abd7].var_5a9f3515a988dc27]](kit_getrank(undefined, debug_activated));
  scripts\cp_mp\armor::setarmoromnvars();
}

function function_abe664c11f9d4b73(var_55f9f0077c3f0cc7) {
  current_kit = function_cab56589fd214c7e();

  if(!isDefined(current_kit) || current_kit != "kitNone") {
    if(isDefined(current_kit)) {
      self[[level.kits[current_kit].var_c6acfae4e3bf5232]]();
    }

    if(!istrue(var_55f9f0077c3f0cc7)) {
      function_5d43ea7662b15991("kitNone");
    }
  }

  function_85f298a56d597983();
}

function function_cc1ccc9e93b22c24() {
  if(!isDefined(self.pers["kit"])) {
    current_kit = self getplayerdata("cp", "progression", "playerKit", "currentKit");

    if(isDefined(current_kit)) {
      return current_kit;
    }

    return "kitMedic";
  }

  return self.pers["kit"];
}

function function_c6631f3a73e64004() {
  if(!isDefined(self.pers["kit"])) {
    return level.var_6e1af29ff5ac9eab deck_draw();
  }

  return self.pers["kit"];
}

function function_5bdd1bea0ed10416(kit_name) {
  return level.kits[kit_name];
}

function function_752e4abf5dd0ffbf(kit_name, rank, rank_func, param1, param2) {
  kit_data = function_5bdd1bea0ed10416(kit_name);

  if(isDefined(kit_data) && isDefined(kit_data.rank_funcs)) {
    struct = spawnStruct();
    struct.rank_func = rank_func;
    struct.param1 = param1;
    struct.param2 = param2;

    if(!isDefined(kit_data.rank_funcs[rank])) {
      kit_data.rank_funcs[rank] = [];
    }

    size = kit_data.rank_funcs[rank].size;
    kit_data.rank_funcs[rank][size] = struct;
  }
}

function function_c4fd5298f57f111() {
  return isDefined(self.kit_data);
}

function function_6fca2e13ace44fbd() {
  if(function_c4fd5298f57f111()) {
    return self.kit_data;
  }

  return undefined;
}

function function_cab56589fd214c7e() {
  if(function_c4fd5298f57f111()) {
    return self.kit_data.kit;
  }

  return undefined;
}

function function_7b2a99b6a0ec3642() {
  if(function_c4fd5298f57f111()) {
    return self.kit_data.kit_perks;
  }

  return undefined;
}

function function_2dbbfd9d03919c32() {
  struct = spawnStruct();
  struct.kit = "";
  struct.rank = 0;
  struct.kit_perks = [];
  self.kit_data = struct;
}

function function_5d43ea7662b15991(kit) {
  self.kit_data.kit = kit;
  self.pers["kit"] = kit;

  if(kit == "kitNone") {
    return;
  }

  self setplayerdata("cp", "progression", "playerKit", "currentKit", kit);
}

function player_setrank(rank) {
  self.kit_data.rank = rank;

  var_7bd982b079077285 = function_e39ac4b1f5dca89b();
  self setplayerdata("cp", "progression", "playerKit", "kitTiers", var_7bd982b079077285, rank);
}

function function_9d47d4e65a0d8124(var_884f54b50e2552f9) {
  if(!isDefined(var_884f54b50e2552f9)) {
    var_4b49758599569d84 = scripts\cp\progression::function_9f35ebf8db17e8d9(function_cc1ccc9e93b22c24());
  } else {
    var_4b49758599569d84 = scripts\cp\progression::function_9f35ebf8db17e8d9(var_884f54b50e2552f9);
  }

  for(i = 0; i < level.var_3ece19163aadf34e.size; i++) {
    if(var_4b49758599569d84 >= level.var_3ece19163aadf34e[i]) {
      continue;
    }

    return i;
  }

  return 10;
}

function function_e39ac4b1f5dca89b() {
  kit = function_cc1ccc9e93b22c24();

  switch (kit) {
    case #"hash_36cdfbfaeba9a21a":
      return "assaultTier";
    case #"hash_f7803221ec64d903":
      return "medicTier";
    case #"hash_2b0e6b98c99852f2":
      return "reconTier";
  }

  return undefined;
}

function kit_getrank(var_884f54b50e2552f9, debug_activated) {
  if(isDefined(self.kit_data) && istrue(debug_activated)) {
    return self.kit_data.rank;
  }

  return scripts\cp\kits::function_9d47d4e65a0d8124(var_884f54b50e2552f9);
}

function kit_giveperk(perk_name) {
  self.kit_data.kit_perks = function_6d6af8144a5131f1(self.kit_data.kit_perks, perk_name);

  if(issharedfuncdefined("perk", "givePerk")) {
    self[[getsharedfunc("perk", "givePerk")]](perk_name);
  }
}

function function_629fc96f1bbf9884(result, instance) {
  if(result == 0) {
    return;
  }

  var_17a208de8e7cd188 = "";

  switch (result) {
    case 1:
      var_17a208de8e7cd188 = "kitAssault";
      break;
    case 2:
      self.pers["override_self_revive_checkpoint"] = 1;
      var_17a208de8e7cd188 = "kitMedic";
      break;
    case 3:
      var_17a208de8e7cd188 = "kitRecon";
      break;
  }

  function_c3cb4bdae301d5b4(var_17a208de8e7cd188, undefined, 1);

  if(isDefined(result) && result > 0 && result <= 3) {
    function_544e73b4ae5d3735(instance);
  }
}

function function_544e73b4ae5d3735(instance) {
  instance.disabled_use_for[self getentitynumber()] = 1;
}

function function_6b01aba37e349764(instance, part, state, player, bautouse, usestring) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(instance.disabled_use_for) && istrue(instance.disabled_use_for[player getentitynumber()])) {
    player thread scripts\cp\utility::hint_prompt("cant_use_kit_select_again", 1, 2);
    return;
  }

  player openmenu("CPKitSelect");
  player freezecontrols(1);
  player thread function_32983028a7e81ab3("luinotifyserver");
  player waittill("exit_kit_select", result);
  player function_629fc96f1bbf9884(result, instance);
  player freezecontrols(0);
}

function function_32983028a7e81ab3(actionnotify) {
  self endon("exit_kit_select");

  while(true) {
    self waittill(actionnotify, param1, param2);

    if(actionnotify == "luinotifyserver") {
      if(param1 != "kit_select") {
        if(param1 == "kit_menu_closed") {
          self notify("exit_kit_select", param2);
          break;
        }

        continue;
      }
    }

    self notify("exit_kit_select", param2);
    break;
  }
}

function function_3b92ce1d90f10a43(player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased, var_db943473454f6ea6) {
  player endon("disconnect");

  if(!istrue(self.var_eaa61b501c84602e)) {
    self waittill("spawned_player");
    ent_flag_wait("player_spawned_with_loadout");
  }

  scripts\cp_mp\pickups::br_forcegivecustompickupitem(player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased, var_db943473454f6ea6);
}

function kit_givekillstreak(killstreak_name, var_ba94bd87c4bc896a, replace_existing, var_76e8f75ad48a3817, var_fdbe3e771645f346, backpackequip, pickupent) {
  self endon("disconnect");

  if(!istrue(var_ba94bd87c4bc896a) && !istrue(self.var_eaa61b501c84602e)) {
    self waittill("spawned_player");
    ent_flag_wait("player_spawned_with_loadout");
  }

  if(!isDefined(self.var_48db175a7e02aa53)) {
    self.var_48db175a7e02aa53 = 0;
  }

  if(istrue(var_76e8f75ad48a3817) && !istrue(self.var_48db175a7e02aa53)) {
    checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

    if(isDefined(checkpoint) && checkpoint != "") {
      return;
    }
  }

  var_67ac588b82b6e3c9 = 0;

  if(istrue(replace_existing)) {
    if(istrue(var_67ac588b82b6e3c9)) {
      if(isDefined(self.munition_slots)) {
        munitions = self.munition_slots;

        foreach(munition in munitions) {
          if(isDefined(munition.ref) && munition.ref == killstreak_name) {
            return;
          }
        }
      }
    } else {
      munitions = self.munition_slots;

      foreach(munition in munitions) {
        if(isDefined(munition.ref) && munition.ref == killstreak_name) {
          return;
        }
      }
    }
  }

  if(isDefined(backpackequip) && backpackequip) {
    ref = function_9ee17a338bde061b(killstreak_name);
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
    scripts\cp_mp\pickups::function_6f39f9916649ac48(lootid, 1);
  }

  var_6e1ec6f2c0ee6b2c = undefined;
  total_slots = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(total_slots < 4) {
    var_6e1ec6f2c0ee6b2c = total_slots;
  } else {
    var_6e1ec6f2c0ee6b2c = self.dpad_selection_index - 1;
  }

  if(scripts\cp\loot_system::is_empty_or_none(0)) {
    var_6e1ec6f2c0ee6b2c = 0;
  } else if(function_240f7f4e57340e8f()) {
    if(level.noinventory) {
      ref = self.munition_slots[0].ref;
      scripts\cp\pickups::function_21779eb63ee9edb0(scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(ref), undefined, undefined, 1, undefined, undefined, 3, undefined, pickupent);
    } else {
      ref = scripts\cp\munitions::function_9ee17a338bde061b(self.munition_slots[0].ref);
      scripts\cp\pickups::additemtobackpackbyref(ref, "killstreak", 1);
    }

    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
    level.var_50c7b4b50d222c0++;
    level.var_e85fcf89f70a718a[level.var_50c7b4b50d222c0] = lootid;
    remove_munition(0, self.munition_slots[0].ref);
    var_6e1ec6f2c0ee6b2c = 0;
  } else {
    scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
    return 0;
  }

  scripts\cp\loot_system::try_give_munition_to_slot(killstreak_name, var_6e1ec6f2c0ee6b2c);

  if(!istrue(var_fdbe3e771645f346)) {
    thread scripts\cp\loadout::function_7da7bd24b280d295();
  }
}

function function_4b1cba62d1e11ff7(rank_override) {
  if(!isDefined(rank_override)) {
    current_rank = kit_getrank();
  } else {
    current_rank = rank_override;
    player_setrank(rank_override);
  }

  var_d95570ee57aa059a = function_5bdd1bea0ed10416(function_cab56589fd214c7e());

  for(i = 1; i <= current_rank; i++) {
    if(isDefined(var_d95570ee57aa059a.rank_funcs[i])) {
      for(j = 0; j < var_d95570ee57aa059a.rank_funcs[i].size; j++) {
        if(isDefined(var_d95570ee57aa059a.rank_funcs[i][j].param1) && isDefined(var_d95570ee57aa059a.rank_funcs[i][j].param2)) {
          param1 = var_d95570ee57aa059a.rank_funcs[i][j].param1;
          param2 = var_d95570ee57aa059a.rank_funcs[i][j].param2;
          self[[var_d95570ee57aa059a.rank_funcs[i][j].rank_func]](param1, param2);
          continue;
        }

        if(isDefined(var_d95570ee57aa059a.rank_funcs[i][j].param1)) {
          param1 = var_d95570ee57aa059a.rank_funcs[i][j].param1;
          self[[var_d95570ee57aa059a.rank_funcs[i][j].rank_func]](param1);
          continue;
        }

        if(isDefined(var_d95570ee57aa059a.rank_funcs[i][j].param2)) {
          param2 = var_d95570ee57aa059a.rank_funcs[i][j].param2;
          self[[var_d95570ee57aa059a.rank_funcs[i][j].rank_func]](param2);
          continue;
        }

        self[[var_d95570ee57aa059a.rank_funcs[i][j].rank_func]]();
      }
    }
  }
}

function function_b5cde7de44edc3ed() {
  function_752e4abf5dd0ffbf("kitAssault", 1, &function_4edbe9015e9d9db9);
  function_752e4abf5dd0ffbf("kitAssault", 1, &function_de0a1791020ffab7);
  function_752e4abf5dd0ffbf("kitAssault", 3, &function_2d374978bbe91095);
  function_752e4abf5dd0ffbf("kitAssault", 5, &kit_giveperk, "specialty_fastreload");
  function_752e4abf5dd0ffbf("kitAssault", 7, &function_d9a2d7048746d025);
  function_752e4abf5dd0ffbf("kitAssault", 10, &function_c896ad3e605a6807);
}

function function_88e35eb26ea39405() {
  function_752e4abf5dd0ffbf("kitRecon", 1, &function_cb75c83d0c8a3a1a);
  function_752e4abf5dd0ffbf("kitRecon", 1, &kit_giveperk, "specialty_pitcher");
  function_752e4abf5dd0ffbf("kitRecon", 1, &kit_giveperk, "specialty_missileprediction");
  function_752e4abf5dd0ffbf("kitRecon", 3, &function_6bad71dd9c815118);
  function_752e4abf5dd0ffbf("kitRecon", 3, &function_5c191edc29023e9a);
  function_752e4abf5dd0ffbf("kitRecon", 5, &kit_giveperk, "specialty_restock");
  function_752e4abf5dd0ffbf("kitRecon", 7, &kit_giveperk, "specialty_extra_tactical");
  function_752e4abf5dd0ffbf("kitRecon", 7, &kit_giveperk, "specialty_extra_deadly");
  function_752e4abf5dd0ffbf("kitRecon", 10, &function_a6f8f16be96637ec);
}

function function_d3fa6b71dbfb70e4() {
  function_752e4abf5dd0ffbf("kitMedic", 1, &function_9b85f157df1ddf00);
  function_752e4abf5dd0ffbf("kitMedic", 1, &kit_giveperk, "specialty_quick_revive");
  function_752e4abf5dd0ffbf("kitMedic", 3, &function_aad0f192d3283e7d);
  function_752e4abf5dd0ffbf("kitMedic", 5, &function_cb70876971fe7047);
  function_752e4abf5dd0ffbf("kitMedic", 7, &kit_giveperk, "specialty_supersprint_enhanced");
  function_752e4abf5dd0ffbf("kitMedic", 10, &function_9f254ea2de3f9f5f);
}

function function_9a8f60f7edd5a777(rank) {
  function_4b1cba62d1e11ff7(rank);
}

function function_fc436569eeecfeb() {
  function_79cd95da38030c14();
  kit_equipment = ["brloot_offhand_binoculars", "brloot_offhand_heartbeatsensor", "brloot_offhand_snapshot"];
  function_dcd93712b7924616(kit_equipment);
  function_85f298a56d597983();
  function_76634baec9299866("cluster_spike");
  function_76634baec9299866("sentry");
}

function function_cc637a3dd608f5ee() {
  kit_equipment = ["brloot_health_adrenaline"];
  kit_equipment = ["brloot_offhand_claymore", "brloot_offhand_atmine"];
  function_dcd93712b7924616(kit_equipment);
  function_d5672d0b0bf9c5ed();
  function_76634baec9299866("assault_drone");
  function_85f298a56d597983();
  scripts\cp_mp\equipment\stimpistol::function_f5037ba4a5399b63(undefined, 1);
  function_79cd95da38030c14();
}

function function_b809060fb006fe63() {
  kit_equipment = ["brloot_health_adrenaline"];
  function_dcd93712b7924616(kit_equipment);
  function_85f298a56d597983();
  function_79cd95da38030c14();
  self.hasplatepouch = 0;
  self setclientomnvar("ui_br_has_plate_pouch", 0);
  platecount = scripts\cp_mp\armor::function_600f6cf462e983f();

  if(platecount >= 4) {
    scripts\cp_mp\armor::function_774133dc8df0ccd5(3);
  }

  function_76634baec9299866("assault_suit");
}

function function_d5672d0b0bf9c5ed() {
  if(istrue(self.hasselfrevivetoken)) {
    scripts\cp\pickups::removeselfrevivetoken();
  }
}

function function_79cd95da38030c14() {
  self setclientomnvar("ui_field_upgrade_icon", 0);
  self.super_progress = 0;
  self setclientomnvar("ui_super_progress", self.super_progress);
  self setclientomnvar("cp_super_fired", 0);
  entity_num = self getentitynumber();
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "playerRole", "none");
  scripts\cp\super::function_674934b4db05639a(undefined);
  self.disable_super = 1;
}

function function_76634baec9299866(killstreak_name) {
  var_e6b96cf88b444fa2 = scripts\cp\munitions::function_346cde477a4fef90(killstreak_name);

  if(isDefined(var_e6b96cf88b444fa2)) {
    thread scripts\cp\munitions::remove_munition(var_e6b96cf88b444fa2, killstreak_name);
    scripts\cp\utility::function_98f7ca3781dac77c(self, killstreak_name);
  }
}

function function_85f298a56d597983() {
  perks = function_7b2a99b6a0ec3642();

  if(isDefined(perks) && perks.size > 0) {
    for(i = 0; i < perks.size; i++) {
      scripts\cp\perks::remove_perk(perks[i]);
    }
  }

  self.kit_data.kit_perks = [];
}

function function_dcd93712b7924616(kit_equipment) {
  foreach(equipment_name in kit_equipment) {
    var_1ff41a59e586a8f6 = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(equipment_name);
    equipment_amount = scripts\cp_mp\pickups::gettotalitemcountinbag(var_1ff41a59e586a8f6);
    scripts\cp_mp\pickups::function_6f39f9916649ac48(var_1ff41a59e586a8f6, equipment_amount);
  }
}

function function_cb70876971fe7047() {
  thread kit_givekillstreak("assault_drone", undefined, 1, 1);
}

function function_6bad71dd9c815118() {
  thread kit_givekillstreak("cluster_spike", undefined, 1, 1);
}

function function_5c191edc29023e9a() {
  thread kit_givekillstreak("sentry", undefined, 1, 1);
}

function function_2d374978bbe91095() {
  thread kit_givekillstreak("assault_suit", undefined, 1, 1);
}

function function_b0fa6dd6b3535ac3() {
  scripts\cp\super::function_674934b4db05639a(&scripts\cp_mp\equipment\battlerage::function_905b7bada6fd91cb);
}

function function_4edbe9015e9d9db9() {
  self.var_a7e974288e869605 = "iw8_armor_marker_cp";
  scripts\cp\super::function_674934b4db05639a(&function_b0b1d13fefe14cd2);
}

function function_b0b1d13fefe14cd2() {
  thread scripts\cp\munitions::give_deployable_crate(self.var_a7e974288e869605);
  thread scripts\cp\cp_player_battlechatter::function_204aeba40a2aa027("super_armor_drop");
}

function function_9b85f157df1ddf00() {
  scripts\cp\super::function_674934b4db05639a(&scripts\cp_mp\equipment\stimpistol::function_321c7891711e583f);
}

function function_cb75c83d0c8a3a1a() {
  scripts\cp\super::function_674934b4db05639a(&scripts\cp\super::function_832d0277ebcade25);
}

function function_a6f8f16be96637ec() {
  thread function_3b92ce1d90f10a43(self, "brloot_offhand_binoculars", 1, 1, 0, 0, 1);
  thread function_3b92ce1d90f10a43(self, "brloot_offhand_heartbeatsensor", 1, 1, 0, 0, 1);
}

function function_9f254ea2de3f9f5f() {
  equipment_amount = 2;
  thread function_3b92ce1d90f10a43(self, "brloot_offhand_claymore", 1, equipment_amount, 0, 0, 1);
  thread function_3b92ce1d90f10a43(self, "brloot_offhand_atmine", 1, equipment_amount, 0, 0, 1);
}

function function_d9a2d7048746d025() {
  self.hasplatepouch = 1;
  self setclientomnvar("ui_br_has_plate_pouch", 1);
}

function function_c896ad3e605a6807() {
  stim_amount = 2;
  thread function_3b92ce1d90f10a43(self, "brloot_health_adrenaline", 1, stim_amount, 0, 0, 1);
}

function function_aad0f192d3283e7d() {
  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

  if(!isDefined(checkpoint) || checkpoint == "" || istrue(self.pers["override_self_revive_checkpoint"])) {
    self.pers["has_revive_token"] = undefined;
    self.pers["override_self_revive_checkpoint"] = undefined;
  }

  if((istrue(self.pers["has_revive_token"]) || !isDefined(self.pers["has_revive_token"])) && !istrue(self.pers["dropped_initial_revive_token"])) {
    scripts\cp\pickups::takerevivepickup();
  }
}

function function_de0a1791020ffab7() {
  kit_giveperk("specialty_extra_armor");
}

function function_4fd9b1fc1595a0d6() {}

function function_9ead8327db60741d() {}

function function_a2d01b1b2cae74a0() {
  kit_giveperk("specialty_increased_armor_health");
}

function function_ed63fce898dc9a95() {}

function function_df71d6671cdffe96() {
  self endon("disconnect");
  self waittill("spawned_player");
  ent_flag_wait("player_spawned_with_loadout");
  var_918c7d3ed87ea3e8 = scripts\cp_mp\equipment::getequipmentslotammo("primary");
  var_dca226ee1d93a538 = scripts\cp_mp\equipment::getequipmentslotammo("secondary");
  scripts\cp_mp\equipment::setequipmentslotammo("primary", 5);
  scripts\cp_mp\equipment::setequipmentslotammo("secondary", 5);
}

function give_scout_drone() {}

function blank() {}