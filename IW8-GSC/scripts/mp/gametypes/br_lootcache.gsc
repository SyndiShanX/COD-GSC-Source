/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lootcache.gsc
*************************************************/

function brlootcache_init() {
  scripts\engine\scriptable::ref_12f5b("body", &lootcacheused);
  var_0 = getDvar("scr_br_debug_loot_name", "");
  var_1 = getDvar("scr_br_debug_loot_probability", 0);
  var_2 = strtok(var_0, " ");
  var_3 = strtok(var_1, " ");

  if(var_3.size == 0) {
    var_3[var_3.size] = "1.0";
  }

  level.dummy_backpack = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = spawnStruct();
    var_5.name = var_2[var_4];
    var_6 = int(min(var_4, var_3.size - 1));
    var_5.ref_1289a = float(var_3[var_6]);
    level.dummy_backpack[level.dummy_backpack.size] = var_5;
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    setmatchdata("halloweenTrickOrTreatRules", 1);
    _getactualcost::init();
  }

  level.dummy_hint = [];
  thread ref_119ff();
}

function get_bonus_targets(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(isDefined(level.playerhandleredeploy) && isDefined(level.playerhandleredeploy[var_0])) {
      return false;
    }
  }

  if(var_0 == "brloot_respawn_token" && scripts\mp\gametypes\br_pickups::ref_12cb6()) {
    return false;
  }

  if((var_0 == "brloot_redeploy_token" || var_0 == "brloot_gulag_token") && istrue(level.br_pickups.hidetokens)) {
    return false;
  }

  return true;
}

function ref_11a41(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(istrue(var_4)) {
    var_9 = 35;

    if(isDefined(var_6)) {
      var_10 = [115, 75, 95, 85, 105, 65];
      var_11 = (var_1.ml_p3_to_safehouse_transition + var_6 * 3) % var_10.size;
      var_12 = var_10[var_11];
      var_9 += 20 * var_6;
    } else if(var_2.ml_p3_to_safehouse_transition % 2 > 0) {
      var_12 = 75;
    } else {
      var_12 = 115;
    }

    var_12 += randomfloatrange(-10, 10);
    var_13 = var_12 + var_3.ml_p3_to_safehouse_transition / 2 * 25 + randomfloatrange(-5, 5);
    var_12 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_3, var_4, var_5, var_14, var_12, var_13);
  } else if(isDefined(self.intro_ride)) {
    var_14 = [[self.intro_ride]](var_3, var_4, var_5, var_6, var_7, var_8, var_14, var_9);
  } else {
    var_14 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_5, var_6, var_7, var_12);
  }

  if(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_4)) {
    var_15 = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo(var_4);
  } else {
    var_15 = level.br_pickups.counts[var_5];
  }

  var_16 = undefined;

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("pickupModifyCount")) {
    var_15 = scripts\mp\gametypes\br_gametypes::ref_12e07("pickupModifyCount", var_5, var_14, var_15, var_6);
  }

  if(isDefined(self.intro_moveplayercliphack)) {
    var_15 = [[self.intro_moveplayercliphack]](var_5, var_15);
  }

  jumpiffalse(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_5)) LOC_0000019f;
  var_17 = createheadicon(var_5);
  var_18 = 0;

  if(scripts\mp\utility\weapon::turnexfiltoside(var_5)) {
    var_16 = var_15;
  }

  if(var_5.hasalternate) {
    var_19 = var_5 getaltweapon();

    if(!scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train(var_5, var_19)) {
      var_18 = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo(var_19);
    }
  }

  var_20 = scripts\mp\gametypes\br_pickups::spawnpickup(var_17, var_15, var_15, 1, var_5, undefined, var_16, var_18);
  goto LOC_00000211;
}

function ref_11a42(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = 0;
  var_7 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_7.ml_p3_to_safehouse_transition = self.itemsdropped;
  var_7.playersetattractiontype = var_4;
  var_8 = [];

  foreach(var_10 in var_0) {
    if(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_10)) {
      var_11 = scripts\mp\utility\weapon::getweaponrootname(var_10);

      if(get_bonus_targets(var_11)) {
        var_8 = var_10;
      }

      continue;
    }

    if(get_bonus_targets(var_10)) {
      var_8 = var_10;
    }
  }

  var_7.totaldropcount = var_8.size;

  foreach(var_10 in var_8) {
    if(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_10)) {
      var_5 = ref_11a41(var_10, var_7, self.origin, self.angles, var_1, 1, var_2, var_3, 1);
      self.itemsdropped++;
      var_14 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_10);

      if(isDefined(var_14)) {
        var_5 = ref_11a41(var_14, var_7, self.origin, self.angles, var_1, 1, var_2, var_3);
        self.itemsdropped++;
      }

      continue;
    }

    var_15 = level.br_pickups.delay_hide_player_clip[var_10];

    if(isDefined(var_15) && var_15 == 4 && var_6 == 0) {
      var_5 = ref_11a41(var_10, var_7, self.origin, self.angles, var_1, 1, var_2, var_3);
      self.itemsdropped++;
      var_6 = 1;
    } else {
      var_5 = ref_11a41(var_10, var_7, self.origin, self.angles, var_1, 0, var_2, var_3);
      self.itemsdropped++;
    }
  }

  return var_5;
}

function ref_11a02(var_0, var_1) {
  return ref_11a42(var_0, 1, var_1);
}

function heli_flyloop(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("closed");
  var_1 = getdvarint("scr_reusable_cache_recharge_time", 90);
  var_2 = 10;
  var_3 = 1;
  var_4 = var_1 / var_2;

  while(var_3 < var_2) {
    wait var_4;
    self setscriptablepartstate(var_0, "vfx" + var_3);
    var_3++;
  }

  waitframe();
  var_5 = getdvarint("scr_reusable_cache_loot_sets", 3);
  self.intel_collected = (self.intel_collected + 1) % var_5;
  self setscriptablepartstate(var_0, "closing");

  if(scripts\mp\gametypes\br_publicevent_restock::use_dropkit_marker()) {
    scripts\mp\gametypes\br_publicevent_restock::ref_12c00();
    return;
  }
}

function lootcacheused(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0.computer_force_player_to_exit)) {
    return;
  }

  if(istrue(var_3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var_0))) {
    return;
  }

  if(isDefined(var_0) && isDefined(var_0.get_circle_back_nodes_on_same_side) && ![[var_0.get_circle_back_nodes_on_same_side]](var_0, var_1, var_2, var_3, var_4)) {
    return;
  }

  if((var_2 == "closed" || var_2 == "closed_nocol") && !isDefined(var_0.entity)) {
    if(var_2 == "closed") {
      var_0 setscriptablepartstate(var_1, "opening");
    } else if(var_2 == "closed_nocol") {
      var_0 setscriptablepartstate(var_1, "opening_nocol");
    }

    if(isDefined(var_0) && isDefined(var_0.ref_1406c)) {
      thread[[var_0._id_1406C]](var_0, var_1, var_2, var_3, var_4);
    }

    var_0.itemsdropped = 0;
    thread allow_forward_factor(var_0, var_1, var_2, var_3, var_4);

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("addSpawnLootContents")) {
      var_0 thread scripts\mp\gametypes\br_gametypes::ref_12e05("addSpawnLootContents");
    }

    scripts\mp\gametypes\br_plunder::ref_11c91("br_loot_cache", -1);

    if(isDefined(var_0.type) && var_0.type == "br_loot_cache_rogue") {
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("br_rogueCacheOpen");
      var_3 dlog_recordplayerevent("dlog_event_rogue_cache", []);
    } else {
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("br_cacheOpen");
    }

    foreach(var_6 in level.teamdata[var_3.team]["activeSupplySweeps"]) {
      if(isDefined(var_6) && var_6.owner != var_3) {
        var_6.owner thread scripts\mp\utility\points::giveunifiedpoints("br_supply_sweep_assist", undefined, undefined, undefined, undefined, undefined, var_6);
      }
    }

    var_3 scripts\cp\vehicles\vehicle_compass_cp::ref_12002();

    if(!isDefined(var_3.ref_11a01)) {
      var_3.ref_11a01 = 1;
    } else {
      var_3.ref_11a01++;
    }

    var_3 scripts\mp\utility\stats::setextrascore1(var_3.ref_11a01);

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var_3 thread _getactualcost::ref_12120(var_0.type, var_0, var_3.calloutarea);
    }

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("lootCacheOpened")) {
      var_3 thread scripts\mp\gametypes\br_gametypes::ref_12e05("lootCacheOpened", var_0);
    }

    var_8 = scripts\mp\gametypes\br_vip_quest::getplayervipquest(var_3);

    if(isDefined(var_8)) {
      var_3 thread scripts\mp\events::killeventtextpopup("br_vip_loot", 0, 0);
      var_8 scripts\mp\gametypes\br_quest_util::questtimersubtract(getdvarint("scr_br_VIP_cacheTimeReduction", 5));
    }

    level notify("lootcache_opened_kill_callout" + var_0.origin);
    level.dummy_hint = scripts\engine\utility::array_remove(level.dummy_hint, var_0);
    return;
  }
}

function allow_earthquake(var_0) {
  var_1 = 0;
  var_1 |= var_0 == "br_loot_always_spawn_cache_common";
  var_1 |= var_0 == "br_loot_always_spawn_cache_legendary";
  var_1 |= var_0 == "br_loot_always_spawn_cache_holiday";
  return var_1;
}

function allow_forward_factor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = "default";
  var_7 = 0;

  if(var_0.type == "br_reusable_loot_cache") {
    if(!isDefined(var_0.intel_collected)) {
      var_0.intel_collected = 0;
    }

    var_7 = var_0.intel_collected;
  }

  if(isDefined(var_0.ref_12f7f)) {
    if(isDefined(var_0.ref_12f80)) {
      var_8 = verifybunkercode(var_0.ref_12f7f, var_0.ref_12f80);
    } else {
      var_8 = verifybunkercode(var_1.ref_12f7f);
    }

    var_8 = scripts\engine\utility::array_randomize(var_8);
    var_7 = "scriptCache";
  } else if(allow_earthquake(var_2.type) && isDefined(level.playerwaittospawn)) {
    var_8 = [[level.playerwaittospawn]](var_2, var_5);
    var_8 = "prePlaced";
  } else {
    var_8 = pickscriptablelootitem(var_3, var_8);
  }

  var_9 = 0;

  if(isDefined(var_8)) {
    var_9 = var_8.size;
  }

  logstring("_lootCacheUsedSpawnPickups " + var_3.type + " " + var_8 + " setIndex = " + var_8 + " items.count = " + var_9);

  if(isDefined(var_8)) {
    var_8 = ref_11a1a(var_8, var_6);
  }

  if(isDefined(var_8) && var_6 scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
    var_8 = ref_11a1d(var_8, var_6);
  }

  var_8 = ref_11a1e(var_8, var_6);

  if(isDefined(var_8)) {
    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
      if(scripts\mp\flags::gameflag("placement_updates_allowed")) {
        var_10 = game["teamPlacements"][var_6.team];

        if(!isDefined(level.lootchopper_initspawninfo)) {
          scripts\mp\gametypes\br_gametype_dmz::freefallfromplanestatemachine();
        }

        var_11 = 100 - 100 * var_10 / level.lootchopper_initspawninfo;

        if(isDefined(level.debug_kill_tromeo) && var_11 < level.debug_kill_tromeo) {
          var_8 = ref_11a1b(var_3, var_8);
        } else if(isDefined(level.ref_13bdf) && var_11 > level.ref_13bdf) {
          var_8 = ref_11a1c(var_3, var_8);
        }
      }
    }

    if(isDefined(level.ref_11b50)) {
      var_8 = ref_11a19(var_8);
    }

    if(var_3.type != "br_reusable_loot_cache") {
      var_8 = undefined;
    }

    if(var_3.type == "br_loot_cache_zom") {
      if(isDefined(var_3.ref_12f80)) {
        var_8 = var_3.ref_12f80 % 3;
      }

      wait 0.7;
    }

    if(isDefined(var_3.type) && var_3.type == "br_loot_cache_rogue") {
      var_12 = ["custom1", "custom2", "custom3", "custom4", "custom5", "custom6", "custom7", "custom8", "custom9", "custom10"];
      var_13 = var_6 getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");

      if(!isDefined(var_13)) {
        var_13 = randomint(var_12.size);
      }

      var_13 = var_12[var_13];
      var_14 = var_6 thread scripts\mp\gametypes\br_public::playerloadoutsaveselected(var_13);
      var_15 = lootcontentsaddloadoutweapons(var_6, var_14);

      foreach(var_17 in var_15) {
        var_8 = var_17;
      }
    }

    var_8 = ref_11a02(var_3, var_8, var_8);
  } else {
    var_19 = (0, 0, 0);
    var_20 = "mp/loot_set_cache_contents_base.csv";

    if(getdvarint("scr_br_alt_mode_cash", 0)) {
      var_20 = "mp/loot_set_cache_contents_base_cash.csv";
    } else if(getdvarint("scr_br_alt_mode_gg", 0)) {
      var_20 = "mp/loot_set_cache_contents_base_gg.csv";
    } else if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
      var_19 = (0, 45, 0);

      if(var_3.type == "br_loot_cache_lege") {
        var_20 = "mp/loot_set_cache_contents_lege_dmz_ground_tablets.csv";
      } else if(var_3.type == "br_loot_cache") {
        var_20 = "mp/loot_set_cache_contents_rare_dmz_ground_tablets.csv";
      }
    }

    var_21 = chooseandspawnitems(var_3, 2, 1, "weapon", var_20, var_19);
    var_8 = var_21[0];
    var_21 = chooseandspawnitems(var_3, 0, 1, "ammo", var_20, var_19);
    var_8 = var_21[0];
    var_21 = chooseandspawnitems(var_3, 0, 1, undefined, var_20, var_19);
    var_8 = var_21[0];
    var_21 = chooseandspawnitems(var_3, 0, 1, undefined, var_20, var_19);
    var_8 = var_21[0];
    var_21 = chooseandspawnitems(var_3, 2, 1, "plunder", var_20, var_19);
    var_8 = var_21[0];
    var_3 setscriptablepartstate(var_4, "open");
  }

  if(getdvarint("scr_spawn_hvv_tokens", 0)) {
    var_22 = getdvarfloat("scr_br_hvv_token_chance_on_loot", 0.5);

    if(randomfloat(1) < var_22) {
      var_23 = anglestoleft(var_3.angles);
      scripts\mp\gametypes\br_gametype_olaride::spawnherovillaintoken(var_3.origin + 50 * var_23, var_3.angles, undefined, var_3.origin);
    }
  }

  var_24 = "cache";

  switch (var_3.type) {
    case "br_lep_quest_cache":
    case "br_scavenger_quest_cache_adler":
    case "br_scavenger_quest_cache":
      var_24 = "cache_scavenger";
      break;
    case "br_loot_cache_pow":
    case "br_loot_cache_reddoor":
    case "br_loot_cache_easterevent":
    case "br_loot_cache_lege":
      var_24 = "cache_legendary";
      break;
    case "br_geiger_quest_cache":
      var_24 = "cache_geigerstash";
      break;
    case "br_reusable_loot_cache":
      thread heli_flyloop(var_3);
      break;
    case "br_loot_cache_rogue":
      var_24 = "cache_rogue";
      break;
  }

  if(scripts\mp\gametypes\br_publicevent_restock::use_dropkit_marker()) {
    var_3 scripts\mp\gametypes\br_publicevent_restock::ref_12cc0();
  }

  foreach(var_26 in var_8) {
    if(isDefined(var_26)) {
      var_26.ref_11a40 = var_24;
    }
  }
}

function ref_11a1b(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(issubstr(var_4, "brloot_plunder")) {
      if(var_0.type == "br_loot_cache_lege") {
        if(var_4 != "brloot_plunder_cash_legendary_1" && scripts\engine\utility::cointoss()) {
          var_4 = "brloot_plunder_cash_legendary_1";
        }
      } else if(var_4 != "brloot_plunder_cash_epic_2" && scripts\engine\utility::cointoss()) {
        var_4 = "brloot_plunder_cash_epic_2";
      }
    }

    var_2 = var_4;
  }

  return var_2;
}

function ref_11a1c(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(issubstr(var_4, "brloot_plunder")) {
      if(var_0.type == "br_loot_cache_lege") {
        if((var_4 == "brloot_plunder_cash_epic_2" || var_4 == "brloot_plunder_cash_legendary_1") && scripts\engine\utility::cointoss()) {
          var_4 = "brloot_plunder_cash_epic_1";
        }
      } else if((var_4 == "brloot_plunder_cash_epic_2" || var_4 == "brloot_plunder_cash_epic_1") && scripts\engine\utility::cointoss()) {
        var_4 = "brloot_plunder_cash_rare_2";
      }
    }

    var_2 = var_4;
  }

  return var_2;
}

function ref_11a19(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 != "brloot_access_card_red") {
      var_1 = var_3;
      continue;
    }

    if(level.ref_11b50 > level.armoryswitches) {
      var_1 = var_3;
      level.armoryswitches++;
    }
  }

  return var_1;
}

function chooseandspawnitems(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_7 = 0;

  if(!isDefined(var_2)) {
    var_2 = "";
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_8 = "mp/loot_set_cache_contents_base.csv";

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  var_9 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  for(var_10 = 0; var_10 < var_1; var_10++) {
    if(!isDefined(var_5)) {
      var_5 = 0;
    }

    var_11 = registerscriptedspawnpoints(var_2, var_0, var_5, var_8);

    if(var_11 == "") {
      continue;
    }

    if(get_bonus_targets(var_11)) {
      var_12 = self.angles;

      if(isDefined(var_4)) {
        var_12 += var_4;
      }

      var_13 = level.br_pickups.delay_hide_player_clip[var_11];

      if(isDefined(var_13) && var_13 == 4 && var_7 == 0) {
        var_6 = ref_11a41(var_11, var_9, self.origin, var_12, undefined, 1);
        self.itemsdropped++;
        var_7 = 1;
      } else {
        var_6 = ref_11a41(var_11, var_9, self.origin, var_12, undefined, 0);
        self.itemsdropped++;
      }
    }
  }

  return var_6;
}

function ref_11a1d(var_0, var_1) {
  if(!isDefined(var_1.display_hint_forced)) {
    var_1.display_hint_forced = 10;
  }

  var_2 = 0;

  foreach(var_4 in var_0) {
    if(issubstr(var_4, "killstreak")) {
      var_2 = 1;
      break;
    }
  }

  if(!var_2) {
    if(randomint(100) < var_1.display_hint_forced) {
      if(!isDefined(level.vip_info)) {
        level.vip_info = 0;
      } else {
        level.vip_info = randomint(25);
      }

      var_6 = verifybunkercode("killchain_boost", level.vip_info);

      foreach(var_8 in var_6) {
        var_0 = var_8;
      }

      var_1.display_hint_forced = 10;
    } else {
      var_1.display_hint_forced += 15;
    }
  }

  return var_0;
}

function ref_11a1a(var_0, var_1) {
  foreach(var_3 in level.dummy_backpack) {
    if(var_3.ref_1289a > randomfloat(1)) {
      var_0 = var_3.name;
    }
  }

  return var_0;
}

function ref_11a1e(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_2 = getdvarfloat("scr_br_plunder_adjust_prob", 0.8);

  if(randomfloat(1) < var_2 && !vehicle_collision_takedamage(var_0)) {
    if(!ref_1373a(var_1)) {
      var_0 = "brloot_plunder_cash_uncommon_1";
    }
  }

  return var_0;
}

function vehicle_collision_takedamage(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "brloot_plunder")) {
      return true;
    }
  }

  return false;
}

function ref_1373a() {
  var_0 = self;

  if(!isalive(var_0)) {
    return false;
  }

  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_5 in var_3) {
    if(var_5 scripts\mp\gametypes\br_public::unlockscriptabledoors()) {
      var_2 = 1;
      continue;
    }

    if(isDefined(var_5.plundercount)) {
      var_1 += var_5.plundercount;
    }
  }

  var_7 = level.br_armory_kiosk.ref_13ac3;
  var_8 = var_0 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
  var_9 = level.br_armory_kiosk.ref_13ac4;

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  var_10 = scripts\mp\gametypes\br_armory_kiosk::ai_push_to_position(undefined, level.br_armory_kiosk.ref_13ac2, 0, var_7, var_8, var_9);

  if(var_2 && isDefined(var_10) && var_1 < var_10) {
    return false;
  }

  return true;
}

function ref_119ff() {
  level endon("game_ended");
  level waittill("prematch_fade_done");
  var_0 = getlootscriptablearrayinradius("br_loot_cache_lege");

  if(isDefined(var_0)) {
    level.dummy_hint = var_0;
    return;
  }
}

function lootcontentsaddloadoutweapons(var_0) {
  level endon("game_ended");
  var_1 = [];
  var_1[var_1.size] = var_0.loadoutprimaryobject;
  var_1[var_1.size] = var_0.loadoutsecondaryobject;
  return var_1;
}