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
  var0 = spawnStruct();
  var0.purchase_type = "tickets";
  var0.model = "zmb_lethal_cryo_grenade_wm";
  var0.weaponname = "zfreeze_semtex_mp";
  level.wall_buys["zfreeze_semtex_mp"] = var0;
  scripts\engine\utility::flag_init("wall_buy_setup_done");
}

function create_default_struct(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var0 = int(var0);
  var5.weapon = var1;

  if(var4 != "") {
    var5.scopemodel = var4;
  }

  var5.model = getweaponmodel(var1);
  var5.purchase_type = var3;
  level.wall_buys[var2] = var5;
}

function parse_weapons_table() {
  var0 = 0;

  if(isDefined(level.coop_weapontable)) {
    var1 = level.coop_weapontable;
    goto LOC_00000020;
  }

  for(var1 = "cp/cp_weapontable.csv";; var1++) {
    var2 = tablelookupbyrow(var1, var1, 0);

    if(var2 == "") {
      break;
    }

    var3 = tablelookupbyrow(var1, var1, 1);
    var4 = tablelookupbyrow(var1, var1, 2);
    var5 = tablelookupbyrow(var1, var1, 4);
    var6 = tablelookupbyrow(var1, var1, 5);
    var7 = scripts\cp\utility::getrawbaseweaponname(var3);
    var8 = strtok(var4, " ");

    foreach(var10 in var8) {
      switch (var10) {
        case "craft":
          level.craftable_weapons[var7] = var3;
          break;
        case "magic":
          level.magic_weapons[var7] = getweaponbasename(var3);
          level.all_magic_weapons[var7] = var3;
          break;
        case "upgrade":
          level.pap[var7] = var3;
          break;
        case "wall":
        case "tickets":
          create_default_struct(var2, var3, var7, var10, var6);
          break;
      }
    }
  }
}

function setup_player_weapon_models(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var1 = 0;
  var2 = 1;
  var3 = 2;
  var4 = 3;
  var5 = 6;
  var0.weapon_build_models = [];
  var0.rofweaponslist = [];
  var0.weapon_passives = [];

  if(true) {
    var0.weaponkitinitialized = 1;
    var0 notify("player_weapon_build_kit_initialized");
    return;
  }

  if(scripts\cp\utility::map_check(2)) {
    var6 = "cp/cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(3)) {
    var6 = "cp/cp_town_wall_buy_models.csv";
  } else {
    var6 = "cp/cp_wall_buy_models.csv";
  }

  for(var7 = 0;; var7++) {
    var8 = tablelookupbyrow(var6, var7, var4);

    if(var8 == "") {
      break;
    }

    var9 = "none";
    var10 = "none";
    var11 = "none";
    var12 = -1;

    if(isDefined(var8)) {
      var13 = tablelookup(var6, var3, var7, var5);
      var14 = tablelookup(var6, var3, var7, var6);
      var15 = [];

      if(isDefined(var13) && var13 != "") {
        for(var16 = 0; var16 < var6; var16++) {
          var17 = var2 getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var13, "attachment", var16);

          if(isDefined(var17) && var17 != "none") {
            var15 = var17;
          }
        }

        var9 = scripts\cp\utility::getweaponcamo(var13);
        var10 = scripts\cp\utility::getweaponcosmeticattachment(var13);
        var11 = scripts\cp\utility::getweaponreticle(var13);
        var12 = scripts\cp\utility::getweaponpaintjobid(var13);
      }

      var2.weapon_build_models[var8] = scripts\cp\utility::mpbuildweaponname(scripts\cp\utility::getweaponrootname(var14), var15, var9, var11, scripts\cp\utility::get_weapon_variant_id(var2, var14), self getentitynumber(), self.clientid, var12, var10);

      if(var8 == "g18") {
        var2 loadweaponsforplayer([var2.weapon_build_models[var8]], 1);
      }

      var18 = getweaponattachments(var2.weapon_build_models[var8]);

      foreach(var17 in var18) {
        if(issubstr(var17, "rof")) {
          var2.rofweaponslist[var2.rofweaponslist.size] = getweaponbasename(var2.weapon_build_models[var8]);
        }
      }
    }
  }

  var2.weaponkitinitialized = 1;
  var2 notify("player_weapon_build_kit_initialized");
}

function assign_weapons_to_structs() {
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(scripts\cp\utility::map_check(2)) {
    var0 = "cp/cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(3)) {
    var0 = "cp/cp_town_wall_buy_models.csv";
  } else {
    var0 = "cp/cp_wall_buy_models.csv";
  }

  if(!scripts\engine\utility::flag_exist("wall_buy_setup_done")) {
    scripts\engine\utility::flag_init("wall_buy_setup_done");
  }

  var1 = [];

  for(var2 = 0;; var2++) {
    var3 = tablelookupbyrow(var0, var2, 1);

    if(var3 == "") {
      break;
    }

    var1 = var3;
  }

  var4 = [];
  var5 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(var7 in var5) {
    if(isDefined(var7.name) && var7.name == "wall_buy") {
      var4 = var7;

      if(isDefined(var7.target)) {
        if(istrue(var7.already_used)) {
          continue;
        }

        var8 = scripts\engine\utility::getStructArray(var7.target, "target");

        foreach(var10 in var8) {
          if(var10 == var7) {
            continue;
          }

          var10.already_used = 1;
          var10.parent_struct = var7;
        }
      }
    }
  }

  while(level.players.size < 1) {
    wait 0.05;
  }

  var13 = sortbydistance(var4, level.players[0].origin);

  foreach(var15 in var13) {
    var15.script_noteworthy = strtok(var15.script_noteworthy, "+")[0];
    var16 = var15.script_noteworthy;
    var17 = scripts\cp\utility::getrawbaseweaponname(var15.script_noteworthy);
    var18 = undefined;

    if(!isDefined(level.wall_buys[var17])) {
      var15.disabled = 1;
      continue;
    }

    if(!istrue(var15.already_used)) {
      if(isDefined(var15.target)) {
        var19 = scripts\engine\utility::getStruct(var15.target, "targetname");
        var20 = var19.origin;
        var21 = var19.angles;
      } else {
        var20 = var17.origin;
        var21 = var17.angles;
      }

      for(var4 = 0; var4 < var3.size; var4++) {
        if(var3[var4] == var24) {
          var20 = var4;
          break;
        }
      }

      if(isDefined(var20)) {
        var17.trigger = spawn("script_weapon", var20, 0, 0, var20);
      } else {
        var22 = (0, 0, 0);
        var23 = (0, 0, 0);

        if(issubstr(var17.script_noteworthy, "forgefreeze")) {
          var22 = (3.25, -18, 9.75);
          var23 = (0, 0, -90);
        }

        if(isDefined(var21)) {
          var21 += var23;
        }

        var17.trigger = spawn("script_model", var20 + var22);

        if(isDefined(var18)) {
          var17.trigger setModel(level.wall_buys[var24].model);
        } else {
          var17.trigger setModel("tag_origin");
        }
      }

      if(isDefined(var21)) {
        var17.trigger.angles = var21;
      }

      thread add_item_to_outline_watcher(var17.trigger, var17, var17.trigger, var18);
      level.wall_weapon_list[level.wall_weapon_list.size] = var17.trigger;
    } else if(isDefined(var17.parent_struct.trigger)) {
      var17.trigger = var17.parent_struct.trigger;
    } else {
      thread applyparentstructvalues(var17);
    }

    var17.weapon = var18;
  }

  var16 = undefined;
  scripts\engine\utility::flag_set("wall_buy_setup_done");
}

function applyparentstructvalues(var0) {
  level endon("game_ended");

  while(!isDefined(var0.parent_struct.trigger)) {
    waitframe();
  }

  var0.trigger = var0.parent_struct.trigger;
}

function add_item_to_outline_watcher(var0, var1, var2, var3) {
  if(!scripts\engine\utility::flag("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  }

  if(!isDefined(level.outline_weapon_watch_list)) {
    return;
  }

  var1.cost = level.interactions[var2].cost;
  var1.struct = var0;

  if(isDefined(var3) && (issubstr(var3, "harpoon") || issubstr(var3, "slasher") || issubstr(var3, "katana"))) {
    return;
  }

  if(!isDefined(var0.script_parameters) || var0.script_parameters != "tickets") {
    level.outline_weapon_watch_list[level.outline_weapon_watch_list.size] = var1;
    return;
  }
}

function item_pickup(var0) {
  give_weapon_coop(var0, self);
}

function givevalidweapon(var0, var1) {
  level endon("game_ended");
  var0 endon("game_ended");
  var0 endon("disconnect");
  var0 notify("weapon_purchased");

  if(istrue(var0.isusingsupercard)) {
    wait 0.5;
  }

  var2 = undefined;

  if(scripts\cp\cp_weapons::should_take_players_current_weapon(var0)) {
    var3 = var0 scripts\cp\utility::getvalidtakeweapon();
    var4 = scripts\cp\utility::getrawbaseweaponname(var3);
    var0 takeweapon(var3);

    if(isDefined(var0.pap[var4])) {
      var0.pap[var4] = undefined;
      var0 notify("weapon_level_changed");
    }
  }

  var5 = undefined;

  if(issameweapon(var1)) {
    var5 = var1;
  } else {
    var5 = asmdevgetallstates(var1);
  }

  var6 = scripts\cp\utility::getrawbaseweaponname(var5);
  var0 scripts\cp\utility::take_fists_weapon(var0);

  if(isDefined(var0.weapon_build_models[var6])) {
    var5 = asmdevgetallstates(var0.weapon_build_models[var6]);
  }

  var7 = getweaponattachments(var5);
  var8 = var0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var5, undefined, var7, undefined, undefined);
  var5 = asmdevgetallstates(var8);
  var5 = var0 scripts\cp\utility::_giveweapon(var5, undefined, undefined, 0);
  var9 = spawnStruct();
  var9.lvl = 1;
  var0.pap[var6] = var9;
  var0 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
  var0 notify("weapon_level_changed");
  var0 givemaxammo(var5);
  var0 switchtoweapon(var5);
}

function give_weapon_coop(var0) {
  var1 = 0;
  var2 = undefined;
  var3 = 0;

  if(isDefined(var0.trigger) && isDefined(var0.trigger.cost)) {
    var3 = var0.trigger.cost;
  }

  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = self getweaponslistprimaries();
  var8 = var7.size;
  var9 = 3;
  var10 = asmdevgetallstates(var0.script_noteworthy);
  var11 = scripts\cp\utility::getrawbaseweaponname(var10);

  if(var10.basename == "iw7_forgefreeze_zm") {
    level.magic_weapons["forgefreeze"] = "iw7_forgefreeze_zm+forgefreezealtfire";
    var1 = 1;
  }

  if(scripts\cp\utility::weapon_is_dlc_melee(var10)) {
    var1 = 1;
  }

  if(!scripts\cp\cp_weapon::has_weapon_variation(var10)) {
    var12 = scripts\cp\utility::getvalidtakeweapon();
    self.curr_weap = var12;

    if(isDefined(var12)) {
      var2 = 1;
      var13 = scripts\cp\utility::getrawbaseweaponname(var12);

      if(scripts\cp\utility::has_special_weapon() && var8 < var9 + 1) {
        var2 = 0;
      }

      foreach(var15 in var7) {
        if(var15.isalternate) {
          var9++;
        }
      }

      if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
        var9++;
      }

      if(var7.size < var9) {
        var2 = 0;
      }

      if(var2) {
        if(isDefined(self.pap[var13])) {
          self.pap[var13] = undefined;
          self notify("weapon_level_changed");
        }

        thread scripts\cp\cp_interaction::play_weapon_purchase_vo(var0, self);
        self takeweapon(var12);
      }
    }

    if(isDefined(self.weapon_build_models[var11])) {
      var4 = self.weapon_build_models[var11];
    } else {
      var4 = var0.weapon;
    }

    if(scripts\cp\utility::is_consumable_active("wall_power") && !scripts\cp\utility::isnmlactive()) {
      var17 = scripts\engine\utility::array_combine(getweaponattachments(var4), ["pap1"]);

      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var11)) {
        var6 = undefined;
      } else if(isDefined(level.pap_1_camo)) {
        var6 = level.pap_1_camo;
      }

      switch (var11) {
        case "dischord":
          var6 = "camo20";
          break;
        case "facemelter":
          var6 = "camo22";
          break;
        case "headcutter":
          var6 = "camo21";
          break;
        case "shredder":
          var6 = "camo23";
          break;
      }

      var18 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var4, undefined, var17, undefined, var6);
      var19 = asmdevgetallstates(var18);
      var19 = scripts\cp\utility::_giveweapon(var19, undefined, undefined, 1);
      var20 = scripts\cp\utility::getrawbaseweaponname(var19);
      scripts\cp\cp_merits::processmerit("mt_upgrade_weapons");
      var21 = spawnStruct();
      var21.lvl = 2;
      self.pap[var20] = var21;
      scripts\cp\utility::notify_used_consumable("wall_power");
      scripts\cp\utility::take_fists_weapon(self);
    } else {
      if(!isDefined(var8)) {
        var8 = var18;
      }

      var17 = getweaponattachments(var8);
      var18 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var8, undefined, var17);
      var19 = asmdevgetallstates(var18);
      var19 = scripts\cp\utility::_giveweapon(var19, undefined, undefined, 1);
      self.itempicked = var18;
      level.transactionid = randomint(100);
      scripts\cp\utility::take_fists_weapon(self);
      var21 = spawnStruct();
      var21.lvl = 1;
      self.pap[var19] = var21;
    }

    if(var5) {
      var4.trigger delete();
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var4);
    }

    self notify("wor_item_pickup", var19);
    scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    self givemaxammo(var19);
    self notify("weapon_level_changed");
    self switchtoweapon(var19);
    wait 0.25;

    while(self isswitchingweapon()) {
      wait 0.05;
    }

    thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  } else {
    self.purchasing_ammo = 1;
    var19 = undefined;
    var22 = self getweaponslistall();
    var23 = scripts\cp\utility::getrawbaseweaponname(var18);
    var24 = undefined;

    foreach(var26 in var22) {
      var19 = scripts\cp\utility::getrawbaseweaponname(var26);

      if(var19 == var23) {
        var24 = var26;
        break;
      }
    }

    var28 = weaponmaxammo(var24);
    var29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var30 = int(var29 * var28);
    var31 = self getweaponammostock(var24);

    if(var31 < var30) {
      self setweaponammostock(var24, var30);
    }

    thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 1, 50);
  }

  self notify("weapon_purchased");
  wait 0.05;
  self.purchasing_ammo = undefined;
  scripts\cp\cp_interaction::refresh_interaction();
}

function reset_special_ammo(var0) {
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
    var0 = self getweaponslistprimaries();

    foreach(var2 in var0) {
      var3 = var2.classname;

      if(var3 == "weapon_pistol") {
        var4 = weaponmaxammo(var2);
        var5 = int(var4 * 0.25);
        var6 = self getammocount(var2);

        if(var5 > var6) {
          self setweaponammostock(var2, var5);
        }
      }
    }

    return;
  }
}

function get_weapon_ref(var0) {
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    var4 = scripts\cp\cp_persistence::get_base_weapon_name(var3);

    if(issubstr(var0, var4)) {
      return var3;
    }
  }

  return undefined;
}

function get_replaceable_weapon() {
  var0 = self getweaponslistprimaries();
  var1 = 3;

  foreach(var3 in var0) {
    if(var3.isalternate) {
      var1++;
    }
  }

  if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var1++;
  }

  if(var0.size >= var1) {
    var5 = self getcurrentweapon();
    var6 = 0;

    if(nullweapon(var5)) {
      var6 = 1;
    } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var5)) {
      var6 = 1;
    } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var5 getbaseweapon())) {
      var6 = 1;
    } else if(scripts\cp\utility::is_melee_weapon(var5, 1)) {
      var6 = 1;
    }

    if(var6) {
      self.copy_fullweaponlist = self getweaponslistall();
      var5 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
    }

    self.copy_fullweaponlist = undefined;

    if(weaponinventorytype(var5) == "altmode") {
      var5 = var5 getaltweapon();
    }

    return var5;
  }

  return undefined;
}

function get_weapon_name_from_alt(var0) {
  if(weaponinventorytype(var0) != "altmode") {
    return var0;
  }

  return getsubstr(var0, 4);
}

function can_give_weapon(var0) {
  var1 = self getweaponslistprimaries();
  var2 = self getcurrentweapon();
  var3 = var2.classname;
  var4 = scripts\cp\utility::getbaseweaponname(var2);

  foreach(var0 in var1) {
    if(var0.isalternate) {
      var1 = scripts\engine\utility::array_remove(var1, var0);
    }
  }

  var7 = 0;

  if(!scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var8 = 3;
  } else {
    var8 = 4;
  }

  if(isDefined(self.numadditionalprimaries)) {
    var8 += self.numadditionalprimaries;
  }

  while(self isswitchingweapon()) {
    wait 0.05;
  }

  if(nullweapon(var3)) {
    return false;
  }

  if(isDefined(level.custom_cangive_weapon_func)) {
    if(![[level.custom_cangive_weapon_func]](var2, var3, var4, var8)) {
      return false;
    }
  }

  if(isDefined(scripts\cp\utility::has_special_weapon()) && scripts\cp\utility::has_special_weapon()) {
    return false;
  }

  if(var2.size >= var8 + 1 && self.hasriotshield) {
    return false;
  }

  if(var2.size >= var8 + 2 && self.hasriotshield) {
    return false;
  }

  if(var2.size >= var8 + 1 && !self.hasriotshieldequipped) {
    return false;
  }

  if(var2.size >= var8 + 2 && self.hasriotshieldequipped) {
    return false;
  }

  if(self.hasriotshieldequipped && var2.size >= var8 + 1) {
    return false;
  }

  if(self.hasriotshieldequipped && var2.size >= var8 + 1) {
    return false;
  }

  if(!scripts\cp\utility::is_holding_deployable()) {
    return true;
  } else {
    return false;
  }

  return false;
}

function interaction_purchase_weapon(var0, var1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return;
  }

  item_pickup(var0, var1);
  var1.last_interaction_point = undefined;
}

function get_wall_buy_hint_func(var0, var1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return &"CP_ZMB_INTERACTIONS/WALL_BUY_DISABLED";
  }

  if(!can_give_weapon(var1, var0)) {
    return &"COOP_INTERACTIONS/CANNOT_BUY";
  }

  var2 = [[level.weapon_hint_func]](var0, var1);

  if(isDefined(var2)) {
    return var2;
  }

  var3 = getweaponbasename(var0.script_noteworthy);
  return level.interaction_hintstrings[var3];
}

function set_weapon_purchase_disabled(var0) {
  level.weapon_purchase_disabled = var0;
}