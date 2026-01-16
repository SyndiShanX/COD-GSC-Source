/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\coop_wall_buys.gsc
*************************************************/

init() {
  level.var_138A1 = [];
  level.magic_weapons = [];
  level.all_magic_weapons = [];
  level.var_47AD = [];
  level.pap = [];
  level.var_138CB = [];
  func_C906();
  var_0 = spawnStruct();
  var_0.var_DB01 = "tickets";
  var_0.model = "zmb_lethal_cryo_grenade_wm";
  var_0.var_39C = "zfreeze_semtex_mp";
  level.var_138A1["zfreeze_semtex_mp"] = var_0;
  scripts\engine\utility::flag_init("wall_buy_setup_done");
}

func_48CD(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_0 = int(var_0);
  var_5.weapon = var_1;
  if(var_4 != "") {
    var_5.var_EC13 = var_4;
  }

  var_5.model = getweaponmodel(var_1);
  var_5.var_DB01 = var_3;
  level.var_138A1[var_2] = var_5;
}

func_C906() {
  var_0 = 0;
  if(isDefined(level.coop_weapontable)) {
    var_1 = level.coop_weapontable;
  } else {
    var_1 = "cp\cp_weapontable.csv";
  }

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);
    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 1);
    var_4 = tablelookupbyrow(var_1, var_0, 2);
    var_5 = tablelookupbyrow(var_1, var_0, 4);
    var_6 = tablelookupbyrow(var_1, var_0, 5);
    var_7 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_8 = strtok(var_4, " ");
    foreach(var_10 in var_8) {
      switch (var_10) {
        case "craft":
          level.var_47AD[var_7] = var_3;
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
          func_48CD(var_2, var_3, var_7, var_10, var_6);
          break;
      }
    }

    var_0++;
  }
}

func_FA1D(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 6;
  var_0.weapon_build_models = [];
  var_0.rofweaponslist = [];
  var_0.var_13C38 = [];
  if(scripts\cp\utility::map_check(2)) {
    var_6 = "cp\cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(3)) {
    var_6 = "cp\cp_town_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(4)) {
    var_6 = "cp\cp_final_wall_buy_models.csv";
  } else {
    var_6 = "cp\cp_wall_buy_models.csv";
  }

  var_7 = 0;
  for(;;) {
    var_8 = tablelookupbyrow(var_6, var_7, var_2);
    if(var_8 == "") {
      break;
    }

    var_9 = "none";
    var_10 = "none";
    var_11 = "none";
    var_12 = -1;
    if(isDefined(var_8)) {
      var_13 = tablelookup(var_6, var_1, var_7, var_3);
      var_14 = tablelookup(var_6, var_1, var_7, var_4);
      var_15 = [];
      if(isDefined(var_13) && var_13 != "") {
        var_10 = scripts\cp\cp_relics::func_7D6C(var_0, var_13);
        if(var_10.size > 0) {
          var_0.var_13C38[var_13] = var_10;
        }

        for(var_11 = 0; var_11 < var_5; var_11++) {
          var_12 = var_0 getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_13, "attachment", var_11);
          if(isDefined(var_12) && var_12 != "none") {
            var_15[var_15.size] = var_12;
          }
        }

        var_9 = scripts\cp\utility::getweaponcamo(var_13);
        var_10 = scripts\cp\utility::getweaponcosmeticattachment(var_13);
        var_11 = scripts\cp\utility::getweaponreticle(var_13);
        var_12 = scripts\cp\utility::getweaponpaintjobid(var_13);
      }

      var_0.weapon_build_models[var_8] = ::scripts\cp\utility::mpbuildweaponname(scripts\cp\utility::getweaponrootname(var_14), var_15, var_9, var_11, scripts\cp\utility::get_weapon_variant_id(var_0, var_14), self getentitynumber(), self.clientid, var_12, var_10);
      if(var_8 == "g18") {
        var_0 loadweaponsforplayer([var_0.weapon_build_models[var_8]], 1);
      }

      var_13 = getweaponattachments(var_0.weapon_build_models[var_8]);
      foreach(var_12 in var_13) {
        if(issubstr(var_12, "rof")) {
          var_0.rofweaponslist[var_0.rofweaponslist.size] = getweaponbasename(var_0.weapon_build_models[var_8]);
        }
      }
    }

    var_7++;
  }

  var_0.weaponkitinitialized = 1;
  var_0 notify("player_weapon_build_kit_initialized");
}

func_23DA() {
  if(scripts\cp\utility::map_check(2)) {
    var_0 = "cp\cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(3)) {
    var_0 = "cp\cp_town_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(4)) {
    var_0 = "cp\cp_final_wall_buy_models.csv";
  } else {
    var_0 = "cp\cp_wall_buy_models.csv";
  }

  if(!scripts\engine\utility::flag_exist("wall_buy_setup_done")) {
    scripts\engine\utility::flag_init("wall_buy_setup_done");
  }

  var_1 = [];
  var_2 = 0;
  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, 1);
    if(var_3 == "") {
      break;
    }

    var_1[var_1.size] = var_3;
    var_2++;
  }

  var_4 = [];
  var_5 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_7 in var_5) {
    if(isDefined(var_7.name) && var_7.name == "wall_buy") {
      var_4[var_4.size] = var_7;
      if(isDefined(var_7.target)) {
        if(scripts\engine\utility::istrue(var_7.already_used)) {
          continue;
        }

        var_8 = scripts\engine\utility::getstructarray(var_7.target, "target");
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
    wait(0.05);
  }

  var_13 = sortbydistance(var_4, level.players[0].origin);
  foreach(var_15 in var_13) {
    var_15.script_noteworthy = strtok(var_15.script_noteworthy, "+")[0];
    var_10 = var_15.script_noteworthy;
    var_11 = scripts\cp\utility::getrawbaseweaponname(var_15.script_noteworthy);
    var_12 = undefined;
    if(!isDefined(level.var_138A1[var_11])) {
      var_15.disabled = 1;
      continue;
    }

    if(!scripts\engine\utility::istrue(var_15.already_used)) {
      if(isDefined(var_15.target)) {
        var_13 = scripts\engine\utility::getstruct(var_15.target, "targetname");
        var_14 = var_13.origin;
        var_15 = var_13.angles;
      } else {
        var_14 = var_11.origin;
        var_15 = var_10.angles;
      }

      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        if(var_1[var_2] == var_11) {
          var_12 = var_2;
          break;
        }
      }

      if(isDefined(var_12)) {
        var_15.trigger = spawn("script_weapon", var_14, 0, 0, var_12);
      } else {
        var_16 = (0, 0, 0);
        var_17 = (0, 0, 0);
        if(issubstr(var_15.script_noteworthy, "forgefreeze")) {
          var_16 = (3.25, -18, 9.75);
          var_17 = (0, 0, -90);
        }

        if(isDefined(var_15)) {
          var_15 = var_15 + var_17;
        }

        var_15.trigger = spawn("script_model", var_14 + var_16);
        if(isDefined(var_10)) {
          var_15.trigger setModel(level.var_138A1[var_11].model);
        } else {
          var_15.trigger setModel("tag_origin");
        }
      }

      if(isDefined(var_15)) {
        var_15.trigger.angles = var_15;
      }

      var_15.trigger thread func_16F5(var_15, var_15.trigger, var_10, var_11);
      level.var_138CB[level.var_138CB.size] = var_15.trigger;
    } else if(isDefined(var_15.parent_struct.trigger)) {
      var_15.trigger = var_15.parent_struct.trigger;
    } else {
      var_15 thread applyparentstructvalues(var_15);
    }

    var_15.weapon = var_10;
  }

  scripts\engine\utility::flag_set("wall_buy_setup_done");
}

applyparentstructvalues(var_0) {
  level endon("game_ended");
  while(!isDefined(var_0.parent_struct.trigger)) {
    scripts\engine\utility::waitframe();
  }

  var_0.trigger = var_0.parent_struct.trigger;
}

func_16F5(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::flag("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  }

  var_1.cost = level.interactions[var_2].cost;
  var_1.struct = var_0;
  if(isDefined(var_3) && issubstr(var_3, "harpoon") || issubstr(var_3, "slasher") || issubstr(var_3, "katana")) {
    return;
  }

  if(var_0.script_parameters != "tickets") {
    level.outline_weapon_watch_list[level.outline_weapon_watch_list.size] = var_1;
  }
}

func_A02D(var_0) {
  var_0 settenthstimer(self);
}

givevalidweapon(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("weapon_purchased");
  if(scripts\engine\utility::istrue(var_0.isusingsupercard)) {
    wait(0.5);
  }

  var_2 = undefined;
  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(var_0)) {
    var_3 = var_0 scripts\cp\utility::getvalidtakeweapon();
    var_4 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_0 takeweapon(var_3);
    if(isDefined(var_0.pap[var_4])) {
      var_0.pap[var_4] = undefined;
      var_0 notify("weapon_level_changed");
    }
  }

  var_5 = scripts\cp\utility::getrawbaseweaponname(var_1);
  var_0 scripts\cp\utility::take_fists_weapon(var_0);
  if(isDefined(var_0.weapon_build_models[var_5])) {
    var_1 = var_0.weapon_build_models[var_5];
  }

  var_6 = getweaponattachments(var_1);
  var_1 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_1, undefined, var_6, undefined, undefined);
  var_1 = var_0 scripts\cp\utility::_giveweapon(var_1, undefined, undefined, 0);
  var_7 = spawnStruct();
  var_7.lvl = 1;
  var_0.pap[var_5] = var_7;
  var_0 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
  var_0 notify("weapon_level_changed");
  var_0 givemaxammo(var_1);
  var_0 switchtoweapon(var_1);
}

settenthstimer(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = var_0.trigger.cost;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = self getweaponslistprimaries();
  var_8 = self getweaponslistprimaries().size;
  var_9 = 3;
  var_10 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
  if(var_0.script_noteworthy == "iw7_forgefreeze_zm") {
    level.magic_weapons["forgefreeze"] = "iw7_forgefreeze_zm+forgefreezealtfire";
    var_1 = 1;
  }

  if(var_0.script_noteworthy == "iw7_venomx_zm") {
    level.magic_weapons["venomx"] = "iw7_venomx_zm";
    if(isDefined(level.venomx_count) && level.venomx_count >= level.players.size) {
      var_1 = 1;
    }
  }

  if(scripts\cp\utility::weapon_is_dlc_melee(var_0.script_noteworthy)) {
    var_1 = 1;
  }

  if(!scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
    var_11 = scripts\cp\utility::getvalidtakeweapon();
    self.curr_weap = var_11;
    if(isDefined(var_11)) {
      var_2 = 1;
      var_12 = scripts\cp\utility::getrawbaseweaponname(var_11);
      if(scripts\cp\utility::has_special_weapon() && var_8 < var_9 + 1) {
        var_2 = 0;
      }

      foreach(var_14 in var_7) {
        if(scripts\cp\utility::isstrstart(var_14, "alt_")) {
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
        if(isDefined(self.pap[var_12])) {
          self.pap[var_12] = undefined;
          self notify("weapon_level_changed");
        }

        thread scripts\cp\cp_interaction::play_weapon_purchase_vo(var_0, self);
        self takeweapon(var_11);
      }
    }

    if(isDefined(self.weapon_build_models[var_10])) {
      var_4 = self.weapon_build_models[var_10];
    } else {
      var_4 = var_0.weapon;
    }

    if(scripts\cp\utility::is_consumable_active("wall_power")) {
      var_10 = scripts\engine\utility::array_combine(getweaponattachments(var_4), ["pap1"]);
      if(issubstr(var_4, "venomx")) {
        var_10 = undefined;
        var_6 = undefined;
        if(scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges)) {
          var_4 = "iw7_venomx_zm_pap1";
          var_6 = level.pap_1_camo;
        }
      } else {
        if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_10)) {
          var_6 = undefined;
        } else if(isDefined(level.pap_1_camo)) {
          var_6 = level.pap_1_camo;
        }

        switch (var_10) {
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
      }

      var_11 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_4, undefined, var_10, undefined, var_6);
      var_11 = scripts\cp\utility::_giveweapon(var_11, undefined, undefined, 1);
      var_12 = scripts\cp\utility::getrawbaseweaponname(var_11);
      scripts\cp\cp_merits::processmerit("mt_upgrade_weapons");
      var_13 = spawnStruct();
      var_13.lvl = 2;
      self.pap[var_12] = var_13;
      if(!scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges) && issubstr(var_4, "venomx")) {
        scripts\cp\utility::take_fists_weapon(self);
        self notify("wor_item_pickup", var_11);
        scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
        self givemaxammo(var_11);
        self notify("weapon_level_changed");
        self switchtoweapon(var_11);
        wait(0.25);
        while(self isswitchingweapon()) {
          wait(0.05);
        }

        self notify("weapon_purchased");
        wait(0.05);
        self.purchasing_ammo = undefined;
        scripts\cp\cp_interaction::refresh_interaction();
        return;
      }

      scripts\cp\utility::notify_used_consumable("wall_power");
      scripts\cp\utility::take_fists_weapon(self);
    } else {
      var_10 = getweaponattachments(var_7);
      var_11 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_6, undefined, var_13);
      var_13 = scripts\cp\utility::_giveweapon(var_13, undefined, undefined, 1);
      self.itempicked = var_13;
      level.transactionid = randomint(100);
      scripts\cp\zombies\zombie_analytics::log_purchasingaweapon(1, self, self.itempicked, self.curr_weap, level.wave_num, var_1.name, self.wavesheldwithweapon, self.killsperweaponlog, self.downsperweaponlog);
      scripts\cp\utility::take_fists_weapon(self);
      var_13 = spawnStruct();
      var_13.lvl = 1;
      self.pap[var_10] = var_13;
    }

    if(var_1) {
      var_0.trigger delete();
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    }

    self notify("wor_item_pickup", var_11);
    scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    self givemaxammo(var_11);
    self notify("weapon_level_changed");
    self switchtoweapon(var_11);
    wait(0.25);
    while(self isswitchingweapon()) {
      wait(0.05);
    }
  } else {
    self.purchasing_ammo = 1;
    var_10 = undefined;
    var_14 = self getweaponslistall();
    var_15 = self getcurrentweapon();
    var_16 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
    var_17 = undefined;
    foreach(var_19 in var_14) {
      var_10 = scripts\cp\utility::getrawbaseweaponname(var_19);
      if(var_10 == var_16) {
        var_17 = var_19;
        break;
      }
    }

    var_1B = weaponmaxammo(var_17);
    var_1C = scripts\cp\perks\prestige::prestige_getminammo();
    var_1D = int(var_1C * var_1B);
    var_1E = self getweaponammostock(var_17);
    if(var_1E < var_1D) {
      self setweaponammostock(var_17, var_1D);
    }

    if(self hasweapon("alt_" + var_17)) {
      var_1B = weaponmaxammo("alt_" + var_17);
      var_1C = scripts\cp\perks\prestige::prestige_getminammo();
      var_1D = int(var_1C * var_1B);
      var_1E = self getweaponammostock("alt_" + var_17);
      if(var_1E < var_1D) {
        self setweaponammostock("alt_" + var_17, var_1D);
      }
    }

    thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 1, 50);
  }

  self notify("weapon_purchased");
  wait(0.05);
  self.purchasing_ammo = undefined;
  scripts\cp\cp_interaction::refresh_interaction();
}

func_E229(var_0) {
  if(isDefined(self.var_10936)) {
    self.var_10936 = undefined;
  }

  if(isDefined(self.var_10939)) {
    self.var_10939 = undefined;
  }

  if(isDefined(self.var_10938)) {
    self.var_10938 = undefined;
  }

  if(isDefined(self.special_ammocount_comb)) {
    self.special_ammocount_comb = undefined;
  }

  if(isDefined(self.special_ammocount)) {
    self.special_ammocount = undefined;
  }
}

setgrenadethrowscale() {
  if(scripts\cp\perks\prestige::prestige_getnodeployables() == 1) {
    var_0 = self getweaponslistprimaries();
    foreach(var_2 in var_0) {
      var_3 = scripts\cp\utility::coop_getweaponclass(var_2);
      if(var_3 == "weapon_pistol") {
        var_4 = weaponmaxammo(var_2);
        var_5 = int(var_4 * 0.25);
        var_6 = self getrunningforwardpainanim(var_2);
        if(var_5 > var_6) {
          self setweaponammostock(var_2, var_5);
        }
      }
    }
  }
}

func_7D6F(var_0) {
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    var_4 = scripts\cp\cp_persistence::get_base_weapon_name(var_3);
    if(issubstr(var_0, var_4)) {
      return var_3;
    }
  }

  return undefined;
}

func_7C04() {
  var_0 = self getweaponslistprimaries();
  var_1 = 3;
  foreach(var_3 in var_0) {
    if(scripts\cp\utility::isstrstart(var_3, "alt_")) {
      var_1++;
    }
  }

  if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_1++;
  }

  if(var_0.size >= var_1) {
    var_5 = self getcurrentweapon();
    var_6 = 0;
    if(var_5 == "none") {
      var_6 = 1;
    } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_5)) {
      var_6 = 1;
    } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_5))) {
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
      var_5 = func_7D66(var_5);
    }

    return var_5;
  }

  return undefined;
}

func_7D66(var_0) {
  if(weaponinventorytype(var_0) != "altmode") {
    return var_0;
  }

  return getsubstr(var_0, 4);
}

can_give_weapon(var_0) {
  var_1 = self getweaponslistprimaries();
  var_2 = self getcurrentweapon();
  var_3 = scripts\cp\utility::coop_getweaponclass(var_2);
  var_4 = scripts\cp\utility::getbaseweaponname(var_2);
  foreach(var_0 in var_1) {
    if(scripts\cp\utility::isstrstart(var_0, "alt_")) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_0);
    }
  }

  var_7 = 0;
  if(!scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_8 = 3;
  } else {
    var_8 = 4;
  }

  if(isDefined(self.var_C20E)) {
    var_8 = var_8 + self.var_C20E;
  }

  while(self isswitchingweapon()) {
    wait(0.05);
  }

  if(var_2 == "none") {
    return 0;
  }

  if(isDefined(level.var_4C40)) {
    if(![
        [level.var_4C40]
      ](var_1, var_2, var_3, var_8)) {
      return 0;
    }
  }

  if(isDefined(scripts\cp\utility::has_special_weapon()) && scripts\cp\utility::has_special_weapon()) {
    return 0;
  }

  if(var_1.size >= var_8 + 1 && self.hasriotshield) {
    return 0;
  }

  if(var_1.size >= var_8 + 2 && self.hasriotshield) {
    return 0;
  }

  if(var_1.size >= var_8 + 1 && !self.hasriotshieldequipped) {
    return 0;
  }

  if(var_1.size >= var_8 + 2 && self.hasriotshieldequipped) {
    return 0;
  }

  if(self.hasriotshieldequipped && var_1.size >= var_8 + 1) {
    return 0;
  }

  if(self.hasriotshieldequipped && var_1.size >= var_8 + 1) {
    return 0;
  }

  if(!scripts\cp\utility::is_holding_deployable()) {
    return 1;
  } else {
    return 0;
  }

  return 0;
}

interaction_purchase_weapon(var_0, var_1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return;
  }

  if(issubstr(var_0.script_noteworthy, "venomx")) {
    var_2 = var_1 getweaponslistall();
    foreach(var_4 in var_2) {
      if(issubstr(var_4, "venomx")) {
        return;
      }
    }

    if(scripts\engine\utility::flag_exist("completepuzzles_step4") && scripts\engine\utility::flag("completepuzzles_step4")) {
      var_2 = var_1 getweaponslistall();
      foreach(var_4 in var_2) {
        if(issubstr(var_4, "venomx")) {
          return;
        }
      }

      var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_weapon", "final_comment_vo");
      if(!isDefined(level.venomx_count)) {
        level.venomx_count = 1;
      }

      var_0 func_A02D(var_1);
      var_1.last_interaction_point = undefined;
      var_1 scripts\cp\zombies\achievement::update_achievement("EGG_SLAYER", 1);
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
      return;
    }

    return;
  }

  var_2 func_A02D(var_3);
  var_3.last_interaction_point = undefined;
}

get_wall_buy_hint_func(var_0, var_1) {
  if(issubstr(var_0.script_noteworthy, "venomx")) {
    if(!scripts\engine\utility::flag("completepuzzles_step4")) {
      return "";
    }

    var_2 = var_1 getweaponslistall();
    foreach(var_4 in var_2) {
      if(issubstr(var_4, "venomx")) {
        return &"COOP_INTERACTIONS_CANNOT_BUY";
      }
    }
  }

  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return &"CP_ZMB_INTERACTIONS_WALL_BUY_DISABLED";
  }

  if(!var_1 can_give_weapon(var_0)) {
    return &"COOP_INTERACTIONS_CANNOT_BUY";
  }

  var_6 = [[level.weapon_hint_func]](var_0, var_1);
  if(isDefined(var_6)) {
    return var_6;
  }

  var_7 = getweaponbasename(var_0.script_noteworthy);
  return level.interaction_hintstrings[var_7];
}

set_weapon_purchase_disabled(var_0) {
  level.weapon_purchase_disabled = var_0;
}