/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_wall_buys.gsc
***********************************************/

function init() {
  level.wall_buys = [];
  level.magic_weapons = [];
  level.all_magic_weapons = [];
  level.craftable_weapons = [];
  level.pap = [];
  level.wall_weapon_list = [];
  parse_weapons_table();
  var_0 = spawnStruct();
  var_0.purchase_type = "tickets";
  var_0.model = "zmb_lethal_cryo_grenade_wm";
  var_0.weaponname = "zfreeze_semtex_mp";
  level.wall_buys["zfreeze_semtex_mp"] = var_0;
  scripts\engine\utility::flag_init("wall_buy_setup_done");
}

function create_default_struct(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_0 = int(var_0);
  var_5.weapon = var_1;

  if(var_4 != "") {
    var_5.scopemodel = var_4;
  }

  var_5.model = getweaponmodel(var_1);
  var_5.purchase_type = var_3;
  level.wall_buys[var_2] = var_5;
}

function parse_weapons_table() {
  var_0 = 0;

  if(isDefined(level.coop_weapontable)) {
    var_1 = level.coop_weapontable;
    goto LOC_00000020;
  }

  for(var_1 = "cp/cp_weapontable.csv";; var_1++) {
    var_2 = tablelookupbyrow(var_1, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_1, 1);
    var_4 = tablelookupbyrow(var_1, var_1, 2);
    var_5 = tablelookupbyrow(var_1, var_1, 4);
    var_6 = tablelookupbyrow(var_1, var_1, 5);
    var_7 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_8 = strtok(var_4, " ");

    foreach(var_10 in var_8) {
      switch (var_10) {
        case "craft":
          level.craftable_weapons[var_7] = var_3;
          break;
        case "magic":
          level.magic_weapons[var_7] = getweaponbasename(var_3);
          level.all_magic_weapons[var_7] = var_3;
          break;
        case "upgrade":
          level.pap[var_7] = var_3;
          break;
        case "wall":
        case "tickets":
          create_default_struct(var_2, var_3, var_7, var_10, var_6);
          break;
      }
    }
  }
}

function setup_player_weapon_models(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 6;
  var_0.weapon_build_models = [];
  var_0.rofweaponslist = [];
  var_0.weapon_passives = [];

  if(true) {
    var_0.weaponkitinitialized = 1;
    var_0 notify("player_weapon_build_kit_initialized");
    return;
  }

  if(scripts\cp\utility::map_check(2)) {
    var_6 = "cp/cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(3)) {
    var_6 = "cp/cp_town_wall_buy_models.csv";
  } else {
    var_6 = "cp/cp_wall_buy_models.csv";
  }

  for(var_7 = 0;; var_7++) {
    var_8 = tablelookupbyrow(var_6, var_7, var_4);

    if(var_8 == "") {
      break;
    }

    var_9 = "none";
    var_10 = "none";
    var_11 = "none";
    var_12 = -1;

    if(isDefined(var_8)) {
      var_13 = tablelookup(var_6, var_3, var_7, var_5);
      var_14 = tablelookup(var_6, var_3, var_7, var_6);
      var_15 = [];

      if(isDefined(var_13) && var_13 != "") {
        for(var_16 = 0; var_16 < var_6; var_16++) {
          var_17 = var_2 getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_13, "attachment", var_16);

          if(isDefined(var_17) && var_17 != "none") {
            var_15 = var_17;
          }
        }

        var_9 = scripts\cp\utility::getweaponcamo(var_13);
        var_10 = scripts\cp\utility::getweaponcosmeticattachment(var_13);
        var_11 = scripts\cp\utility::getweaponreticle(var_13);
        var_12 = scripts\cp\utility::getweaponpaintjobid(var_13);
      }

      var_2.weapon_build_models[var_8] = scripts\cp\utility::mpbuildweaponname(scripts\cp\utility::getweaponrootname(var_14), var_15, var_9, var_11, scripts\cp\utility::get_weapon_variant_id(var_2, var_14), self getentitynumber(), self.clientid, var_12, var_10);

      if(var_8 == "g18") {
        var_2 loadweaponsforplayer([var_2.weapon_build_models[var_8]], 1);
      }

      var_18 = getweaponattachments(var_2.weapon_build_models[var_8]);

      foreach(var_17 in var_18) {
        if(issubstr(var_17, "rof")) {
          var_2.rofweaponslist[var_2.rofweaponslist.size] = getweaponbasename(var_2.weapon_build_models[var_8]);
        }
      }
    }
  }

  var_2.weaponkitinitialized = 1;
  var_2 notify("player_weapon_build_kit_initialized");
}

function assign_weapons_to_structs() {
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(scripts\cp\utility::map_check(2)) {
    var_0 = "cp/cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(3)) {
    var_0 = "cp/cp_town_wall_buy_models.csv";
  } else {
    var_0 = "cp/cp_wall_buy_models.csv";
  }

  if(!scripts\engine\utility::flag_exist("wall_buy_setup_done")) {
    scripts\engine\utility::flag_init("wall_buy_setup_done");
  }

  var_1 = [];

  for(var_2 = 0;; var_2++) {
    var_3 = tablelookupbyrow(var_0, var_2, 1);

    if(var_3 == "") {
      break;
    }

    var_1 = var_3;
  }

  var_4 = [];
  var_5 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(var_7 in var_5) {
    if(isDefined(var_7.name) && var_7.name == "wall_buy") {
      var_4 = var_7;

      if(isDefined(var_7.target)) {
        if(istrue(var_7.already_used)) {
          continue;
        }

        var_8 = scripts\engine\utility::getStructArray(var_7.target, "target");

        foreach(var_10 in var_8) {
          if(var_10 == var_7) {
            continue;
          }

          var_10.already_used = 1;
          var_10.parent_struct = var_7;
        }
      }
    }
  }

  while(level.players.size < 1) {
    wait 0.05;
  }

  var_13 = sortbydistance(var_4, level.players[0].origin);

  foreach(var_15 in var_13) {
    var_15.script_noteworthy = strtok(var_15.script_noteworthy, "+")[0];
    var_16 = var_15.script_noteworthy;
    var_17 = scripts\cp\utility::getrawbaseweaponname(var_15.script_noteworthy);
    var_18 = undefined;

    if(!isDefined(level.wall_buys[var_17])) {
      var_15.disabled = 1;
      continue;
    }

    if(!istrue(var_15.already_used)) {
      if(isDefined(var_15.target)) {
        var_19 = scripts\engine\utility::getStruct(var_15.target, "targetname");
        var_20 = var_19.origin;
        var_21 = var_19.angles;
      } else {
        var_20 = var_17.origin;
        var_21 = var_17.angles;
      }

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        if(var_3[var_4] == var_24) {
          var_20 = var_4;
          break;
        }
      }

      if(isDefined(var_20)) {
        var_17.trigger = spawn("script_weapon", var_20, 0, 0, var_20);
      } else {
        var_22 = (0, 0, 0);
        var_23 = (0, 0, 0);

        if(issubstr(var_17.script_noteworthy, "forgefreeze")) {
          var_22 = (3.25, -18, 9.75);
          var_23 = (0, 0, -90);
        }

        if(isDefined(var_21)) {
          var_21 += var_23;
        }

        var_17.trigger = spawn("script_model", var_20 + var_22);

        if(isDefined(var_18)) {
          var_17.trigger setModel(level.wall_buys[var_24].model);
        } else {
          var_17.trigger setModel("tag_origin");
        }
      }

      if(isDefined(var_21)) {
        var_17.trigger.angles = var_21;
      }

      thread add_item_to_outline_watcher(var_17.trigger, var_17, var_17.trigger, var_18);
      level.wall_weapon_list[level.wall_weapon_list.size] = var_17.trigger;
    } else if(isDefined(var_17.parent_struct.trigger)) {
      var_17.trigger = var_17.parent_struct.trigger;
    } else {
      thread applyparentstructvalues(var_17);
    }

    var_17.weapon = var_18;
  }

  var_16 = undefined;
  scripts\engine\utility::flag_set("wall_buy_setup_done");
}

function applyparentstructvalues(var_0) {
  level endon("game_ended");

  while(!isDefined(var_0.parent_struct.trigger)) {
    waitframe();
  }

  var_0.trigger = var_0.parent_struct.trigger;
}

function add_item_to_outline_watcher(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::flag("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  }

  if(!isDefined(level.outline_weapon_watch_list)) {
    return;
  }

  var_1.cost = level.interactions[var_2].cost;
  var_1.struct = var_0;

  if(isDefined(var_3) && (issubstr(var_3, "harpoon") || issubstr(var_3, "slasher") || issubstr(var_3, "katana"))) {
    return;
  }

  if(!isDefined(var_0.script_parameters) || var_0.script_parameters != "tickets") {
    level.outline_weapon_watch_list[level.outline_weapon_watch_list.size] = var_1;
    return;
  }
}

function item_pickup(var_0) {
  give_weapon_coop(var_0, self);
}

function givevalidweapon(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("weapon_purchased");

  if(istrue(var_0.isusingsupercard)) {
    wait 0.5;
  }

  var_2 = undefined;

  if(scripts\cp\cp_weapons::should_take_players_current_weapon(var_0)) {
    var_3 = var_0 scripts\cp\utility::getvalidtakeweapon();
    var_4 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_0 takeweapon(var_3);

    if(isDefined(var_0.pap[var_4])) {
      var_0.pap[var_4] = undefined;
      var_0 notify("weapon_level_changed");
    }
  }

  var_5 = undefined;

  if(issameweapon(var_1)) {
    var_5 = var_1;
  } else {
    var_5 = asmdevgetallstates(var_1);
  }

  var_6 = scripts\cp\utility::getrawbaseweaponname(var_5);
  var_0 scripts\cp\utility::take_fists_weapon(var_0);

  if(isDefined(var_0.weapon_build_models[var_6])) {
    var_5 = asmdevgetallstates(var_0.weapon_build_models[var_6]);
  }

  var_7 = getweaponattachments(var_5);
  var_8 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_5, undefined, var_7, undefined, undefined);
  var_5 = asmdevgetallstates(var_8);
  var_5 = var_0 scripts\cp\utility::_giveweapon(var_5, undefined, undefined, 0);
  var_9 = spawnStruct();
  var_9.lvl = 1;
  var_0.pap[var_6] = var_9;
  var_0 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
  var_0 notify("weapon_level_changed");
  var_0 givemaxammo(var_5);
  var_0 switchtoweapon(var_5);
}

function give_weapon_coop(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 0;

  if(isDefined(var_0.trigger) && isDefined(var_0.trigger.cost)) {
    var_3 = var_0.trigger.cost;
  }

  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = self getweaponslistprimaries();
  var_8 = var_7.size;
  var_9 = 3;
  var_10 = asmdevgetallstates(var_0.script_noteworthy);
  var_11 = scripts\cp\utility::getrawbaseweaponname(var_10);

  if(var_10.basename == "iw7_forgefreeze_zm") {
    level.magic_weapons["forgefreeze"] = "iw7_forgefreeze_zm+forgefreezealtfire";
    var_1 = 1;
  }

  if(scripts\cp\utility::weapon_is_dlc_melee(var_10)) {
    var_1 = 1;
  }

  if(!scripts\cp\cp_weapon::has_weapon_variation(var_10)) {
    var_12 = scripts\cp\utility::getvalidtakeweapon();
    self.curr_weap = var_12;

    if(isDefined(var_12)) {
      var_2 = 1;
      var_13 = scripts\cp\utility::getrawbaseweaponname(var_12);

      if(scripts\cp\utility::has_special_weapon() && var_8 < var_9 + 1) {
        var_2 = 0;
      }

      foreach(var_15 in var_7) {
        if(var_15.isalternate) {
          var_9++;
        }
      }

      if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
        var_9++;
      }

      if(var_7.size < var_9) {
        var_2 = 0;
      }

      if(var_2) {
        if(isDefined(self.pap[var_13])) {
          self.pap[var_13] = undefined;
          self notify("weapon_level_changed");
        }

        thread scripts\cp\cp_interaction::play_weapon_purchase_vo(var_0, self);
        self takeweapon(var_12);
      }
    }

    if(isDefined(self.weapon_build_models[var_11])) {
      var_4 = self.weapon_build_models[var_11];
    } else {
      var_4 = var_0.weapon;
    }

    if(scripts\cp\utility::is_consumable_active("wall_power") && !scripts\cp\utility::isnmlactive()) {
      var_17 = scripts\engine\utility::array_combine(getweaponattachments(var_4), ["pap1"]);

      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_11)) {
        var_6 = undefined;
      } else if(isDefined(level.pap_1_camo)) {
        var_6 = level.pap_1_camo;
      }

      switch (var_11) {
        case "dischord":
          var_6 = "camo20";
          break;
        case "facemelter":
          var_6 = "camo22";
          break;
        case "headcutter":
          var_6 = "camo21";
          break;
        case "shredder":
          var_6 = "camo23";
          break;
      }

      var_18 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_4, undefined, var_17, undefined, var_6);
      var_19 = asmdevgetallstates(var_18);
      var_19 = scripts\cp\utility::_giveweapon(var_19, undefined, undefined, 1);
      var_20 = scripts\cp\utility::getrawbaseweaponname(var_19);
      scripts\cp\cp_merits::processmerit("mt_upgrade_weapons");
      var_21 = spawnStruct();
      var_21.lvl = 2;
      self.pap[var_20] = var_21;
      scripts\cp\utility::notify_used_consumable("wall_power");
      scripts\cp\utility::take_fists_weapon(self);
    } else {
      if(!isDefined(var_8)) {
        var_8 = var_18;
      }

      var_17 = getweaponattachments(var_8);
      var_18 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_8, undefined, var_17);
      var_19 = asmdevgetallstates(var_18);
      var_19 = scripts\cp\utility::_giveweapon(var_19, undefined, undefined, 1);
      self.itempicked = var_18;
      level.transactionid = randomint(100);
      scripts\cp\utility::take_fists_weapon(self);
      var_21 = spawnStruct();
      var_21.lvl = 1;
      self.pap[var_19] = var_21;
    }

    if(var_5) {
      var_4.trigger delete();
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
    }

    self notify("wor_item_pickup", var_19);
    scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    self givemaxammo(var_19);
    self notify("weapon_level_changed");
    self switchtoweapon(var_19);
    wait 0.25;

    while(self isswitchingweapon()) {
      wait 0.05;
    }

    thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  } else {
    self.purchasing_ammo = 1;
    var_19 = undefined;
    var_22 = self getweaponslistall();
    var_23 = scripts\cp\utility::getrawbaseweaponname(var_18);
    var_24 = undefined;

    foreach(var_26 in var_22) {
      var_19 = scripts\cp\utility::getrawbaseweaponname(var_26);

      if(var_19 == var_23) {
        var_24 = var_26;
        break;
      }
    }

    var_28 = weaponmaxammo(var_24);
    var_29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var_30 = int(var_29 * var_28);
    var_31 = self getweaponammostock(var_24);

    if(var_31 < var_30) {
      self setweaponammostock(var_24, var_30);
    }

    thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 1, 50);
  }

  self notify("weapon_purchased");
  wait 0.05;
  self.purchasing_ammo = undefined;
  scripts\cp\cp_interaction::refresh_interaction();
}

function reset_special_ammo(var_0) {
  if(isDefined(self.special_ammocount_ap)) {
    self.special_ammocount_ap = undefined;
  }

  if(isDefined(self.special_ammocount_in)) {
    self.special_ammocount_in = undefined;
  }

  if(isDefined(self.special_ammocount_explo)) {
    self.special_ammocount_explo = undefined;
  }

  if(isDefined(self.special_ammocount_comb)) {
    self.special_ammocount_comb = undefined;
  }

  if(isDefined(self.special_ammocount)) {
    self.special_ammocount = undefined;
    return;
  }
}

function give_pistol_ammo_if_nerf_active() {
  if(scripts\cp\perks\cp_prestige::prestige_getnodeployables() == 1) {
    var_0 = self getweaponslistprimaries();

    foreach(var_2 in var_0) {
      var_3 = var_2.classname;

      if(var_3 == "weapon_pistol") {
        var_4 = weaponmaxammo(var_2);
        var_5 = int(var_4 * 0.25);
        var_6 = self getammocount(var_2);

        if(var_5 > var_6) {
          self setweaponammostock(var_2, var_5);
        }
      }
    }

    return;
  }
}

function get_weapon_ref(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\cp_persistence::get_base_weapon_name(var_3);

    if(issubstr(var_0, var_4)) {
      return var_3;
    }
  }

  return undefined;
}

function get_replaceable_weapon() {
  var_0 = self getweaponslistprimaries();
  var_1 = 3;

  foreach(var_3 in var_0) {
    if(var_3.isalternate) {
      var_1++;
    }
  }

  if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_1++;
  }

  if(var_0.size >= var_1) {
    var_5 = self getcurrentweapon();
    var_6 = 0;

    if(nullweapon(var_5)) {
      var_6 = 1;
    } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_5)) {
      var_6 = 1;
    } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_5 getbaseweapon())) {
      var_6 = 1;
    } else if(scripts\cp\utility::is_melee_weapon(var_5, 1)) {
      var_6 = 1;
    }

    if(var_6) {
      self.copy_fullweaponlist = self getweaponslistall();
      var_5 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
    }

    self.copy_fullweaponlist = undefined;

    if(weaponinventorytype(var_5) == "altmode") {
      var_5 = var_5 getaltweapon();
    }

    return var_5;
  }

  return undefined;
}

function get_weapon_name_from_alt(var_0) {
  if(weaponinventorytype(var_0) != "altmode") {
    return var_0;
  }

  return getsubstr(var_0, 4);
}

function can_give_weapon(var_0) {
  var_1 = self getweaponslistprimaries();
  var_2 = self getcurrentweapon();
  var_3 = var_2.classname;
  var_4 = scripts\cp\utility::getbaseweaponname(var_2);

  foreach(var_0 in var_1) {
    if(var_0.isalternate) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_0);
    }
  }

  var_7 = 0;

  if(!scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_8 = 3;
  } else {
    var_8 = 4;
  }

  if(isDefined(self.numadditionalprimaries)) {
    var_8 += self.numadditionalprimaries;
  }

  while(self isswitchingweapon()) {
    wait 0.05;
  }

  if(nullweapon(var_3)) {
    return false;
  }

  if(isDefined(level.custom_cangive_weapon_func)) {
    if(![[level.custom_cangive_weapon_func]](var_2, var_3, var_4, var_8)) {
      return false;
    }
  }

  if(isDefined(scripts\cp\utility::has_special_weapon()) && scripts\cp\utility::has_special_weapon()) {
    return false;
  }

  if(var_2.size >= var_8 + 1 && self.hasriotshield) {
    return false;
  }

  if(var_2.size >= var_8 + 2 && self.hasriotshield) {
    return false;
  }

  if(var_2.size >= var_8 + 1 && !self.hasriotshieldequipped) {
    return false;
  }

  if(var_2.size >= var_8 + 2 && self.hasriotshieldequipped) {
    return false;
  }

  if(self.hasriotshieldequipped && var_2.size >= var_8 + 1) {
    return false;
  }

  if(self.hasriotshieldequipped && var_2.size >= var_8 + 1) {
    return false;
  }

  if(!scripts\cp\utility::is_holding_deployable()) {
    return true;
  } else {
    return false;
  }

  return false;
}

function interaction_purchase_weapon(var_0, var_1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return;
  }

  item_pickup(var_0, var_1);
  var_1.last_interaction_point = undefined;
}

function get_wall_buy_hint_func(var_0, var_1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return &"CP_ZMB_INTERACTIONS/WALL_BUY_DISABLED";
  }

  if(!can_give_weapon(var_1, var_0)) {
    return &"COOP_INTERACTIONS/CANNOT_BUY";
  }

  var_2 = [[level.weapon_hint_func]](var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  var_3 = getweaponbasename(var_0.script_noteworthy);
  return level.interaction_hintstrings[var_3];
}

function set_weapon_purchase_disabled(var_0) {
  level.weapon_purchase_disabled = var_0;
}