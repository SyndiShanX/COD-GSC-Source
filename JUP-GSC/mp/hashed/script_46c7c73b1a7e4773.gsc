/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_46c7c73b1a7e4773.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_41387eecc35b88bf;
#using script_443d99fe707f1d9f;
#using script_5d8202968463a21d;
#using script_686729055b66c6e4;
#using script_749ff6f56673a813;
#using script_7956d56c4922bd1;
#using script_7cfaa6fd841fb4dd;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\dragonsbreath;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\pmc_missions;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;
#using scripts\ob\points;
#namespace zombie_challenges;

function function_ea5d8dfcc9a28411() {
  if(!challengesenabled()) {
    return;
  }

  level.wallbuy_weapons = [];
  level.magicbox_weapons = [];
  level.var_fd85a760f9e601f6 = throttle::throttle_initialize("zombieChallengesOnZombieAiKilled", 1, level.framedurationseconds);
  level.var_1ba18dd27f458f88 = throttle::throttle_initialize("playerChallengesOnAgentAiKilled", 1, level.framedurationseconds);
  callback::add("on_pmc_mission_completed", &function_135da259745a566d);
  callback::add("on_pmc_mission_step_complete", &function_20a93cb9e4f580fe);
  callback::add("on_pmc_mission_tier_complete", &function_9fe3364da6f70780);
  callback::add("player_spawned", &on_player_spawned);
  callback::add("magicbox_purchase", &function_6a7cf6856f3e681);
  callback::add("wallbuy_purchase", &function_de9f828fd5fb2dc3);
  callback::add("on_ai_killed", &function_e5ea18b76842725f);
  callback::add("player_item_pickup", &on_item_pickup);
  callback::add("loot_crystal_destroyed", &loot_crystal_destroyed);
  callback::add("on_zombie_ai_spawned", &on_zombie_ai_spawned);
  callback::add("on_vehicle_spawned", &on_vehicle_spawned);
  callback::add("on_pap_machine_purchase", &on_pap_machine_purchase);
  callback::add("on_tesla_storm_stunned", &on_tesla_storm_stunned);
  callback::add("ammomod_proc", &function_7e993967c3cfc6c9);
  callback::add("on_tacmap_ping_scriptable_or_ent", &on_tacmap_ping_scriptable_or_ent);
  callback::add("register_activities", &function_af4c6a6a1f2e94f7);
  callback::add("exfil_success", &function_70fef3c29291be77);
  callback::add("on_turret_trap_circuit_added", &function_625e98d18b3d55a2);
  callback::add("item_exfiled", &function_93a828d2f14b2a77);
  callback::add("weapon_exfiled", &function_1a63a8486a277ac8);
  callback::add("ob_weaponstash_drill_notPaused", &function_654c053523c6f5f6);
  callback::add("safe_opened", &function_c170c9d5fe107d4c);
  callback::add("merc_stronghold_cleared", &function_438364b427391b60);
  callback::add("zm_perk_obtained", &function_def7cd4658600e1a);
  callback::add("player_region_difficulty_change", &function_61691a3175d3e844);
  callback::add("on_spawn_redeploy_drone", &function_4f322f99eb988e83);
  callback::add("ava_activated_uavTower", &function_948301ad97e24c18);
  callback::add("ava_located", &function_a7cf9a60c8407c0);
  callback::add("ava_defended", &function_28c89f81cdaa9d97);
  callback::add("escaped_with_ava", &function_2a7867137131b412);
  callback::add("destroyed_sam_shepherd", &function_5f52ca88d2ee165);
  callback::add("secured_airdrop_shepherd", &function_c3cb09ac0cc5bb8c);
  callback::add("escorted_vehicle_shepherd", &function_5f4bea465b992020);
  callback::add("defended_escort_shepherd", &function_9cf351a917bdb260);
  callback::add("fight_to_stronghold_zakhaev", &function_b08965cd9e357396);
  callback::add("place_explosive_zakhaev", &function_7ddbc5d5709f0565);
  callback::add("clear_stronghold_zakhaev", &function_4dc500ccd9ff3cbc);
  callback::add("defend_scrambler_zakhaev", &function_6cfc34c8585e3810);
  callback::add("defeat_worm_zakhaev", &function_bd6f213cdc70081);
  callback::add("player_entered_radiation", &function_4ffcd177964e72b2);
  callback::add("player_exited_radiation", &function_1fb60c4452a392c8);
  callback::add("ammo_mod_equipped", &function_b05b488b03740449);
  callback::add("infilled_with_super", &function_979b0b77c84e497f);
  callback::add("player_near_extractor", &function_1e972a37f996a61c);
  callback::add("player_near_radio_tower", &function_ea321f874c7d825);
  callback::add("player_tac_map_toggled", &function_7078fecde61ab0db);
  callback::add("player_vehicle_enter", &function_5f169bceaf46be72);
  callback::add("magicbox_used", &function_eb1506a06c31da2b);
  callback::add("remote_turret_deployed", &function_7758c4422a68f415);
  callback::add("aethernest_approach", &function_8e07c089e889784f);
  callback::add("big_bounty_started", &function_da6e19f48f3340b8);
  callback::add("on_vehicle_tire_repaired", &function_4b8d35d7af7fd960);
  callback::add("on_vehicle_refueled", &on_vehicle_refueled);
  callback::add("zm_packed_weapon", &function_984089fc6559a650);
  callback::add("lootcache_looted", &function_8b134141131f364a);
  callback::add("on_used_super", &function_a5e16566a91e9488);
  callback::add("on_turned", &function_65ec7747ff7a397a);
  callback::add("spore_control_started", &function_628a2357515e077a);
  callback::add("cargo_delivery_started", &function_fbab6a79ccb766d2);
  callback::add("approached_merc_camp", &function_a9d19f968e2f15e9);
  callback::add("merc_camp_success", &function_ed0bb8717f31f954);
  callback::add("merc_camp_fail", &function_d88408f2a5adf639);
  callback::add("merc_camp_looted", &function_5470291610d91652);
  callback::add("player_laststand", &on_player_laststand);
  callback::add("on_spawn_redeploy_drone", &on_spawn_redeploy_drone);
  callback::add("on_spawn_harvester_orb", &function_83ba63f5ccc1143e);
  callback::add("weapon_stash_started", &function_a14a93ab2f0b86d1);
  callback::add("killstreak_equipped", &function_3cde22ad6d42a269);
  callback::add("zombie_score_event", &function_c99db6b18ad62976);
  callback::add("on_exfil_exiting_ao", &on_exfil_exiting_ao);
  callback::add("player_damaged", &on_player_damaged);
  callback::add("on_soldier_ai_damaged", &function_3cd8cd54ce47110a);
  callback::add("on_zombie_ai_damaged", &function_3cd8cd54ce47110a);
  callback::add("on_outlast_arrive", &on_outlast_arrive);
  callback::add("on_approach_zm_stronghold", &on_approach_zm_stronghold);
  callback::add("approached_gunship", &function_7f2dd34d9517d2c6);
  callback::add("kiosk_item_sold", &function_c9293fc51ab4bfeb);
  callback::add("abomination_swallow_grenade", &function_876eed02bb717d72);
  callback::add("energy_mine_convoy_stopped", &function_1d29b3ce33c72a69);
  callback::add("harvester_orb_damaged", &function_22de5391f273b6bf);
  callback::add("player_revived", &on_player_revived);
  callback::add("zm_perk_elemental_pop_proc", &function_900df0cbd73e399b);
  callback::add("aethernest_cyst_destroyed", &function_735905adf14f7ebc);
  callback::add("on_approach_convoy", &on_approach_convoy);
  callback::add("on_convoy_begin", &on_convoy_begin);
  callback::add("on_engage_convoy", &on_engage_convoy);
  callback::add("on_destroy_convoy", &on_destroy_convoy);
  callback::add("veh_on_convoy_ended", &veh_on_convoy_ended);
  callback::add("on_approach_merc_stronghold", &on_approach_merc_stronghold);
  callback::add("merc_stronghold_nokey", &function_816b42385497212a);
  callback::add("on_unlock_merc_stronghold", &on_unlock_merc_stronghold);
  callback::add("on_merc_stronghold_cleared_vo", &on_merc_stronghold_cleared_vo);
  callback::add("on_merc_stronghold_reinforcement", &on_merc_stronghold_reinforcement);
  callback::add("on_outlast_start", &on_outlast_start);
  callback::add("on_approach_outlast_pnd", &on_approach_outlast_pnd);
  callback::add("on_outlast_progress_degrade", &on_outlast_progress_degrade);
  callback::add("on_outlast_success", &on_outlast_success);
  callback::add("on_abandon_outlast_contract", &on_abandon_outlast_contract);
  callback::add("on_sabotage_start", &on_sabotage_start);
  callback::add("on_abandon_sabotage_contract", &on_abandon_sabotage_contract);
  callback::add("on_sabotage_failure_nocannister", &on_sabotage_failure_nocannister);
  callback::add("on_sabotage_success_nocannister", &on_sabotage_success_nocannister);
  callback::add("on_sabotage_success_withcannister", &on_sabotage_success_withcannister);
  callback::add("on_merc_defend_started", &on_merc_defend_started);
  callback::add("on_merc_defend_approach_refractor", &on_merc_defend_approach_refractor);
  callback::add("on_merc_defend_damage_25", &on_merc_defend_damage_25);
  callback::add("on_merc_defend_success", &on_merc_defend_success);
  callback::add("merc_warlord_success", &function_d4f961679a3612e2);
  callback::add("merc_warlord_death", &function_2ca2263723de3b23);
  callback::add("player_used_item", &function_94545a9bb0878e0e);
  callback::add("phd_flopper_killed", &function_defeb316e4a936c);
  callback::add("weapon_stash_completed", &function_81747fd819153293);
  callback::add("on_super_ready", &on_super_ready);
  callback::add("exfil_acknowledged", &function_7c8dbb063c0e860c);
  callback::add("field_upgrade_used", &function_6685ae90a5b68220);
  callback::add("on_merc_camp_recon_destroyed", &on_merc_camp_recon_destroyed);
  callback::add("vehicle_explode", &function_c2fa6446b3ec956f);
  callback::add("on_enemy_cryofreeze", &function_73246c2cbf5948fb);
  callback::add("on_powerup_nuke_pickup", &on_powerup_nuke_pickup);
  level function_53f4bb14857d9b44("id_assignPlayerKillModifiersTrimmed", &assignplayerkillmodifierstrimmed);
  level function_53f4bb14857d9b44("id_healing_aura_heal", &function_cf64989979528904);
  level.var_3dacdac07404670c = [];
  level thread function_68feab32966b29b8();
  level.var_4a486ba98909b396 = 1;
  level.var_53677277fc550387 = &function_380c0caf9e64a771;
  level.var_f932763b261a721f = &function_9c039c6daa449c38;
  level.var_87a8b21898e26133 = &function_182aeec2e4e170de;
  level.var_667b02b5d11ccfcb = &function_35b3a590197d97a6;
  function_340f1f6cb09800d6();
  level.var_cf8d941509d44c64 = throttle_initialize("zombie_challenges_heli", 1, default_to(level.framedurationseconds, 0.1));
  level.var_16aba0b1e426588e = throttle_initialize("zombie_challenges_convoy", 1, default_to(level.framedurationseconds, 0.1));
  level.var_844aeaa09ef5dd5a = throttle_initialize("zombie_challenges_destconvoy", 1, default_to(level.framedurationseconds, 0.1));
  level.var_1d8645b41c9cb6a0 = throttle_initialize("zombie_challenges_drone", 1, default_to(level.framedurationseconds, 0.1));
  level.var_972268e38976b7a9 = throttle_initialize("zombie_challenges_orb", 1, default_to(level.framedurationseconds, 0.1));

  level thread function_a0dc56fbe58ef8c3();
}

function function_340f1f6cb09800d6() {
  function_6c8b18941d0a604d();
  function_adb26e28d3408dac();
  function_63663f994d4e7634();
  function_d89978ce1f60dfc();
  function_cde7564c165a0bf1();
  function_2647e6d2c835793e();
  function_569430d5aed94ffd();
  function_82d4524b2566958a();
}

function function_af4c6a6a1f2e94f7(params) {
  if(isDefined(level.activities)) {
    function_8b5b2a3392fc7e2a("ActivitySuccess", &function_4b0eddcc1928fa56);
    function_8b5b2a3392fc7e2a("ActivityFailure", &function_748c2bebf6e2765b);
    function_8b5b2a3392fc7e2a("ActivityBegin", &function_16afc8d96fd3de0c);
    function_8b5b2a3392fc7e2a("PlayerJoin", &function_3b2ed72578533fe0);
  }
}

function function_be1f0a84acb0ed97(victimstruct, sparams, var_d4a58a5ad5a66ed, var_494c20dbf01ad08c, var_a0aa10131c98134a) {
  zombiemodifiers = var_d4a58a5ad5a66ed;
  var_151fa81d56a14612 = var_494c20dbf01ad08c;
  var_d28c6116660bb280 = var_a0aa10131c98134a;
  killing_event = spawnStruct();
  throttle::function_f632348cbb773537(level.var_fd85a760f9e601f6, killing_event);
  var_cb9bc0821d0eee8d = function_6c8b18941d0a604d();
  var_7f56c75cde4fea6c = function_adb26e28d3408dac();
  var_3e963b841cdedb62 = function_63663f994d4e7634();

  if(isPlayer(sparams.eattacker)) {
    if(!isDefined(sparams.eattacker.var_ae035a44da08bfab)) {
      sparams.eattacker.var_ae035a44da08bfab = 0;
    }

    if(isDefined(sparams.eattacker.var_ae035a44da08bfab)) {
      sparams.eattacker.var_ae035a44da08bfab++;
    }

    if(function_18a53d77df35c4c9(sparams.eattacker, 16819) && !mod(sparams.eattacker.var_ae035a44da08bfab, 5)) {
      if(sparams.eattacker ent_flag("frenzied_guard_active")) {
        item = spawnnewitemfromscriptablesharedfunc("obloot_ava_intel_frenzied_guard", victimstruct.origin, victimstruct.angles, 0, 1);

        if(isDefined(item)) {
          sparams.eattacker thread function_c537a191b851482f(item, "obloot_ava_intel_frenzied_guard");
        }
      }
    }
  }

  if(isPlayer(sparams.eattacker) && isDefined(sparams.sweapon)) {
    var_d28c6116660bb280 = level function_32126a54e0e1055c(var_d28c6116660bb280, victimstruct.subclass, victimstruct.var_53525e5d094a332b, victimstruct.kiastring);

    if(sparams.eattacker ent_flag("frenzied_guard_active")) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["frenzied_guard_kill"]);

      if(isDefined(victimstruct.aicategory) && (victimstruct.aicategory == "special" || victimstruct.aicategory == "elite")) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["special_elite_frenzied_guard_kill"]);
      }

      sparams.eattacker thread function_da06d69b0b66e612(14882, "quest_s0a1t5_bringemon_start", undefined, 1);
    }

    if(istrue(sparams.eattacker.var_f2f5db77ae69537f)) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["aether_shroud_kill_zombie"]);
    }

    if(victimstruct.tesla_storm_stunned) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["tesla_storm_kill_zombie"]);
    }

    if(victimstruct.cryofreeze_active) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["cryofreeze_kill"]);
    }

    if(victimstruct.frost_blast_active) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["frost_blast_kill"]);
    }

    if(victimstruct.energy_mine_kill) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["energy_mine_kill_zombie"]);
    }

    if(arraycontains(level.wallbuy_weapons, sparams.sweapon)) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["wallbuy_kill"]);
    }

    if(arraycontains(level.magicbox_weapons, sparams.sweapon)) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["magicbox_kill"]);
    }

    if(issharedfuncdefined("zombie", "get_pap_level")) {
      n_pap_level = sparams.eattacker function_af5127390d3221e9(sparams.sweapon);
    }

    if(isDefined(n_pap_level) && n_pap_level >= 1) {
      if(isDefined(level.var_8241e0d86017df29)) {
        str_region = [[level.var_8241e0d86017df29]](victimstruct.origin);

        switch (str_region) {
          case #"hash_5343b465e56ec9a4":
          case #"hash_651f76c0ad6741ec":
          case #"hash_7bb2cd766703d463":
          case #"hash_af83e47edfa8900a":
            zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["pap_kill_zombie_level_1_yellow_or_higher"]);
            break;
        }
      }
    }

    if(isDefined(n_pap_level) && n_pap_level >= 2) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["pap_kill_zombie_level_2"]);

      if(is_equal(victimstruct.aicategory, "special")) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["pap_kill_zombie_special_level_2"]);
      }
    }

    if(isDefined(n_pap_level) && n_pap_level >= 3) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["pap_kill_zombie_level_3"]);

      if(is_equal(victimstruct.aicategory, "elite")) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["pap_kill_zombie_elite_level_3"]);
      }
    }

    if(isDefined(n_pap_level) && n_pap_level != 0) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["pap_kill"]);
    }

    if(isDefined(sparams.eattacker) && isDefined(sparams.eattacker.activities) && isDefined(sparams.eattacker.activities.focusedactivityid)) {
      zombiemodifiers = level function_9966e6739036c441(zombiemodifiers, sparams, "zombie", victimstruct.subclass, victimstruct.var_53525e5d094a332b);
      var_151fa81d56a14612 = level function_128985eaf12e0ed8(var_151fa81d56a14612, sparams, "zombie", victimstruct.subclass, victimstruct.var_53525e5d094a332b);
    }

    if(isDefined(sparams.eattacker) && isDefined(sparams.eattacker.var_f0571de00436dc5)) {
      var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["redeploy_drone_zombie_kill"]);
    }

    if(isDefined(sparams.eattacker) && sparams.eattacker ent_flag_exist("in_radiation")) {
      var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["aether_storm_orange_zombie_kill"]);

      if(isDefined(victimstruct.subclass) && victimstruct.subclass == "zombie_disciple_hvt_stormcaller") {
        sparams.eattacker function_f10f600ac4ee4c09("aether_storm_special_intel_collected", 2);
      }
    }

    if(isDefined(sparams.eattacker.vehicle) && is_equal(sparams.eattacker.currentweapon.classname, "turret")) {
      kill_bit = var_cb9bc0821d0eee8d["vehicle_turret_zombie_kill"];

      if(isDefined(kill_bit)) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
      }
    }

    switch (victimstruct.subclass) {
      case #"hash_2f5c52f1e6ef9284":
        if(victimstruct.napalm_burned) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["napalmburst_burning_kill"]);
        }

        break;
      case #"hash_f297af39454fdc7b":
        if(victimstruct.napalm_burned) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["napalmburst_burning_kill"]);
        }

        break;
      default:
        break;
    }

    if(isDefined(victimstruct.subclass) && victimstruct.subclass == "zombie_hellhound") {
      if(victimstruct.cryofreeze_active) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["schematic_cryofreeze_kill"]);
      }
    }

    if(isDefined(sparams.einflictor.streakinfo) && isDefined(sparams.einflictor.streakinfo.streakname)) {
      if(sparams.einflictor.streakinfo.streakname == "sentry_gun") {
        kill_bit = var_cb9bc0821d0eee8d["killstreak_turret_zombie_kill"];

        if(isDefined(kill_bit)) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
        }
      }
    }

    if(isDefined(sparams.einflictor)) {
      if(isDefined(sparams.einflictor.code_classname) && sparams.einflictor.code_classname == "script_vehicle") {
        kill_bit = var_cb9bc0821d0eee8d["vehicle_kill"];

        if(isDefined(kill_bit)) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
        }
      }
    }
  } else {
    var_42a08b1fb177cfa0 = undefined;

    if(isDefined(sparams.eattacker) && isPlayer(sparams.eattacker.var_941802a0997e0c42)) {
      var_42a08b1fb177cfa0 = sparams.eattacker.var_941802a0997e0c42;
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["brainrot_kill"]);
    }

    if(isDefined(var_42a08b1fb177cfa0)) {
      return [zombiemodifiers, var_151fa81d56a14612, var_d28c6116660bb280, var_42a08b1fb177cfa0];
    }
  }

  return [zombiemodifiers, var_151fa81d56a14612, var_d28c6116660bb280];
}

function function_e5ea18b76842725f(sparams) {
  player = sparams.eattacker;
  victimstruct = spawnStruct();
  victimstruct.subclass = self.subclass;
  victimstruct.aicategory = self.aicategory;
  victimstruct.origin = self.origin;
  victimstruct.angles = self.angles;
  victimstruct.tesla_storm_stunned = ent_flag("tesla_storm_stunned");
  victimstruct.cryofreeze_active = ent_flag("cryofreeze_active");
  victimstruct.frost_blast_active = ent_flag("frost_blast_active");
  victimstruct.energy_mine_kill = ent_flag("energy_mine_kill");
  victimstruct.napalm_burned = ent_flag("napalm_burned");
  victimstruct.var_53525e5d094a332b = spawnStruct();
  victimstruct.var_53525e5d094a332b.ent_flag = self.ent_flag;
  victimstruct.team = self.team;
  victimstruct.stunnedblinded = scripts\mp\weapons::isstunnedorblinded();
  victimstruct.unittype = self.unittype;
  victimstruct.var_ec0a5c743cc6a4da = self.var_ec0a5c743cc6a4da;
  victimstruct.killedtime = gettime();
  victimstruct.var_21a8839dd03e31cd = self.var_21a8839dd03e31cd;
  victimstruct.kiastring = self.kiastring;

  if(isDefined(player)) {
    var_bafbdb422ea9eaae = function_137b512700167b00(player, self);

    if(isDefined(self.kiastring) && self.kiastring == "warlord_kia") {
      var_bafbdb422ea9eaae.kiastring = self.kiastring;
    }

    var_bafbdb422ea9eaae.var_21a8839dd03e31cd = victimstruct.var_21a8839dd03e31cd;

    if(isPlayer(player) && isweapon(sparams.sweapon)) {
      if(!isDefined(player.var_603a8aa6efd893c9)) {
        player.var_603a8aa6efd893c9 = [];
      }

      weaponlootid = weapon::function_89a83ae9a4c4142a(sparams.sweapon);

      if(isDefined(weaponlootid)) {
        if(!isDefined(player.var_603a8aa6efd893c9[weaponlootid])) {
          player.var_603a8aa6efd893c9[weaponlootid] = 0;
        }

        player.var_603a8aa6efd893c9[weaponlootid]++;
      }
    }
  }

  var_cb9bc0821d0eee8d = function_6c8b18941d0a604d();
  var_7f56c75cde4fea6c = function_adb26e28d3408dac();
  var_3e963b841cdedb62 = function_63663f994d4e7634();
  zombiemodifiers = 0;
  var_151fa81d56a14612 = 0;
  var_d28c6116660bb280 = 0;
  var_b33db8aa71151cab = function_61dbb8ade69346c1(zombiemodifiers, var_151fa81d56a14612, sparams);
  zombiemodifiers = var_b33db8aa71151cab[0];
  var_151fa81d56a14612 = var_b33db8aa71151cab[1];

  if(isDefined(victimstruct.unittype)) {
    switch (victimstruct.unittype) {
      case #"hash_44aaeb0edd152195":
        if(isDefined(self) && isDefined(self.kiastring) && self.kiastring == "warlord_kia" && !isPlayer(player)) {
          player = namespace_64135de19550f047::function_3bd4148272ae66ee(sparams);
        }

        if(!isPlayer(player) || !isDefined(sparams.sweapon)) {
          return;
        }

        var_758af3a43f3f8c8b = function_9de7a3128f548745(zombiemodifiers, var_151fa81d56a14612, var_d28c6116660bb280, sparams);
        zombiemodifiers = var_758af3a43f3f8c8b[0];
        var_151fa81d56a14612 = var_758af3a43f3f8c8b[1];
        var_d28c6116660bb280 = var_758af3a43f3f8c8b[2];
        var_d28c6116660bb280 = function_4030ef122da1cf5c(var_d28c6116660bb280);
        break;
      case #"hash_f695947f7a9ce23f":
        var_331e81b3297cdd35 = level function_be1f0a84acb0ed97(victimstruct, sparams, zombiemodifiers, var_151fa81d56a14612, var_d28c6116660bb280);
        zombiemodifiers = var_331e81b3297cdd35[0];
        var_151fa81d56a14612 = var_331e81b3297cdd35[1];
        var_d28c6116660bb280 = var_331e81b3297cdd35[2];

        if(isDefined(var_331e81b3297cdd35[3]) && isPlayer(var_331e81b3297cdd35[3])) {
          player = var_331e81b3297cdd35[3];
        }

        if(victimstruct.kiastring == "deathworm_kia") {
          level function_7d81180cfc146b9a(victimstruct);

          if(isDefined(var_bafbdb422ea9eaae)) {
            var_bafbdb422ea9eaae.var_379d31f8d73d8b2f = 0;
          }
        }

        break;
      default:
        break;
    }
  }

  if(isPlayer(player)) {
    player assignplayerkillmodifierstrimmed(victimstruct, sparams.sweapon, sparams.smeansofdeath, sparams.einflictor);
    var_1d68c79557cc54ea = [];
    var_1d68c79557cc54ea[0] = zombiemodifiers;
    var_1d68c79557cc54ea[1] = var_151fa81d56a14612;
    var_1d68c79557cc54ea[2] = var_d28c6116660bb280;
    level onagentkilled(sparams.einflictor, player, sparams.idamage, sparams.smeansofdeath, sparams.sweapon, sparams.shitloc, player.modifiers, var_1d68c79557cc54ea, victimstruct.team, var_bafbdb422ea9eaae);
  }
}

function function_9de7a3128f548745(var_d4a58a5ad5a66ed, var_494c20dbf01ad08c, var_a0aa10131c98134a, sparams) {
  var_cb9bc0821d0eee8d = function_6c8b18941d0a604d();
  var_7f56c75cde4fea6c = function_adb26e28d3408dac();
  var_3e963b841cdedb62 = function_63663f994d4e7634();
  zombiemodifiers = var_d4a58a5ad5a66ed;
  var_151fa81d56a14612 = var_494c20dbf01ad08c;
  var_d28c6116660bb280 = var_a0aa10131c98134a;

  if(ent_flag("energy_mine_kill")) {
    zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["energy_mine_kill_soldier"]);
  }

  if(istrue(sparams.eattacker.var_f2f5db77ae69537f)) {
    zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["aether_shroud_kill_soldier"]);
  }

  if(issharedfuncdefined("zombie", "get_pap_level")) {
    n_pap_level = sparams.eattacker function_af5127390d3221e9(sparams.sweapon);
  }

  if(self.agent_type == "actor_jup_ob_enemy_specialist_captain") {
    zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["soldier_captain_kill"]);
  }

  if(self.agent_type == "actor_jup_ob_enemy_specialist_commander") {
    zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["soldier_commander_kill"]);
  }

  if(isDefined(sparams.eattacker) && isDefined(sparams.eattacker.activities) && isDefined(sparams.eattacker.activities.focusedactivityid)) {
    zombiemodifiers = function_9966e6739036c441(zombiemodifiers, sparams, "soldier", self.subclass, self);
    var_151fa81d56a14612 = function_128985eaf12e0ed8(var_151fa81d56a14612, sparams, "soldier", self.subclass, self);
  } else if(ent_flag_exist("activity_mercCamp_spawned")) {
    zombiemodifiers = function_9966e6739036c441(zombiemodifiers, sparams, "soldier", self.subclass, self);
  }

  if(isDefined(self.subclass)) {
    switch (self.subclass) {
      case #"hash_8c92249632740ac":
      case #"hash_12daa0cbf50f6442":
      case #"hash_d646bb7570717551":
      case #"hash_dde105a699b160b3":
        var_549a0a08bd58f080 = getdvarint(@ "hash_41f8d73d574eb96b", 480000);

        if(gettime() < var_549a0a08bd58f080) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["warlord_speedrun"]);
        }

        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["storm_castle_warlord_kill"]);
        break;
      default:
        break;
    }
  }

  if(!isPlayer(sparams.einflictor)) {
    if(isDefined(sparams.einflictor.streakinfo) && isDefined(sparams.einflictor.streakinfo.streakname)) {
      if(sparams.einflictor.streakinfo.streakname == "precision_airstrike") {
        kill_bit = var_7f56c75cde4fea6c["precision_airstrike_soldier_kill"];

        if(isDefined(kill_bit)) {
          var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, kill_bit);

          if(ent_flag_exist("activity_mercCamp_spawned") && isDefined(sparams.eattacker)) {
            sparams.eattacker function_f10f600ac4ee4c09("precision_airstrike_merc_camp", 2);
          }
        }
      }

      if(sparams.einflictor.streakinfo.streakname == "sentry_gun") {
        kill_bit = var_cb9bc0821d0eee8d["killstreak_turret_soldier_kill"];

        if(isDefined(kill_bit)) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
        }

        if(function_5acc35fc66331385(sparams.eattacker, 16139) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
          spawnnewitemfromscriptablesharedfunc("obloot_ava_intel_soldier", self.origin, self.angles, 0, 1);
        }
      }
    }
  }

  return [zombiemodifiers, var_151fa81d56a14612, var_d28c6116660bb280];
}

function function_61dbb8ade69346c1(var_d4a58a5ad5a66ed, var_494c20dbf01ad08c, sparams) {
  var_cb9bc0821d0eee8d = function_6c8b18941d0a604d();
  var_7f56c75cde4fea6c = function_adb26e28d3408dac();
  zombiemodifiers = var_d4a58a5ad5a66ed;
  var_151fa81d56a14612 = var_494c20dbf01ad08c;

  if(isPlayer(sparams.eattacker) && isDefined(sparams.sweapon)) {
    if(issharedfuncdefined("zombie", "get_pap_level")) {
      n_pap_level = sparams.eattacker function_af5127390d3221e9(sparams.sweapon);
    }

    if(isDefined(n_pap_level) && n_pap_level != 0) {
      var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["pap_kill_general"]);
    }

    if(array_contains(level.wallbuy_weapons, sparams.sweapon)) {
      var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["wallbuy_kill_general"]);
    }

    if(array_contains(level.magicbox_weapons, sparams.sweapon)) {
      var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["magicbox_kill_general"]);
    }

    if(isDefined(self.var_d37b75616f7c2ee) && isDefined(self.var_d37b75616f7c2ee.biscritical) && self.var_d37b75616f7c2ee.biscritical == 1) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["critical_kill"]);
    }

    if(weapon::iskillstreakweapon(sparams.sweapon)) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["killstreak_kill"]);
    }

    if(sparams.eattacker ent_flag("frenzied_guard_active") || istrue(sparams.eattacker.var_f2f5db77ae69537f) || ent_flag("energy_mine_kill") || ent_flag("frost_blast_active") || ent_flag("tesla_storm_stunned")) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["field_upgrade_kill"]);
    }

    if(isDefined(sparams.eattacker.var_e44a614acd5d4984) && abs(sparams.eattacker.var_e44a614acd5d4984 - gettime()) <= 5000) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["kill_after_field_upgrade_used"]);
    }

    if(ent_flag("frost_blast_active")) {
      function_648b4b8e2ec610d8();
    }

    if(weapon::isweaponequipment(sparams.sweapon)) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["equipment_kill"]);
    }

    if(isDefined(sparams.eattacker) && sparams.eattacker ent_flag_exist("in_radiation")) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["aether_storm_kill"]);
    }

    if(isDefined(sparams.smeansofdeath)) {
      weaponelementtype = points::function_591305dc9c07499b(sparams.sweapon, sparams.eattacker, sparams.smeansofdeath);

      if(!isDefined(self.elementsaffected)) {
        self.elementsaffected = [];
      }

      if(weaponelementtype == "fire" || sparams.smeansofdeath == "MOD_ELEMENTAL_FIRE") {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["fire_damage"]);
        self.elementsaffected["fire"] = 1;
      } else if(weaponelementtype == "cold" || sparams.smeansofdeath == "MOD_ELEMENTAL_COLD") {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["frost_damage"]);
        self.elementsaffected["cold"] = 1;
      } else if(weaponelementtype == "electrical" || sparams.smeansofdeath == "MOD_ELEMENTAL_ELEC" || sparams.sweapon.basename == "jup_shock_stick_ob") {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["electric_damage"]);
        self.elementsaffected["electrical"] = 1;
      } else if(weaponelementtype == "toxic" || sparams.smeansofdeath == "MOD_ELEMENTAL_TOXIC") {
        var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["toxic_damage"]);
        self.elementsaffected["toxic"] = 1;
      }

      if(isDefined(sparams.smeansofdeath) && sparams.smeansofdeath == "MOD_EXPLOSIVE" || sparams.smeansofdeath == "MOD_PROJECTILE" || sparams.smeansofdeath == "MOD_PROJECTILE_SPLASH" || sparams.smeansofdeath == "MOD_GRENADE_SPLASH") {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["explosive_damage"]);
      }
    }

    if(isarray(self.elementsaffected)) {
      if(self.elementsaffected.size >= 2) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["elemental_combo"]);
      }
    }

    if(sparams.eattacker ent_flag("speedcola_schematic_active") && isDefined(sparams.eattacker.var_6502bc23ef7b1744)) {
      if(gettime() <= sparams.eattacker.var_6502bc23ef7b1744 + 5000) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["schematic_speedcola_kill"]);
      } else {
        sparams.eattacker ent_flag_clear("speedcola_schematic_active");
      }
    }

    if(isDefined(sparams.eattacker.perks_active)) {
      if(isDefined(sparams.eattacker.perks_active.size) && sparams.eattacker.perks_active.size >= 4) {
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["kill_four_perks"]);
      }
    }

    if(isDefined(sparams.eattacker.perks_active)) {
      foreach(perk in sparams.eattacker.perks_active) {
        bit = undefined;

        switch (perk) {
          case #"hash_4485ea5afc8ef4ec":
            bit = var_cb9bc0821d0eee8d["juggernog_equipped"];
            break;
          case #"hash_47874f94af82bbae":
            bit = var_cb9bc0821d0eee8d["quickrevive_equipped"];
            break;
          case #"hash_8f7f900f28dfcf96":
            bit = var_cb9bc0821d0eee8d["deadshot_daiquiri_equipped"];
            break;
          case #"hash_5b88c6956390309e":
            bit = var_cb9bc0821d0eee8d["speedcola_equipped"];
            break;
          case #"hash_d5e621d55a8082dd":
            bit = var_cb9bc0821d0eee8d["elemental_pop_equipped"];
            break;
          case #"hash_f8756efed2ffb6f4":
            bit = var_cb9bc0821d0eee8d["death_perception_equipped"];
            break;
          case #"hash_8ce81fd37af3e66b":
            bit = var_cb9bc0821d0eee8d["staminup_equipped"];
            break;
          case #"hash_474f00cba8142b0b":
            bit = var_cb9bc0821d0eee8d["phd_flopper_equipped"];
            break;
          default:
            break;
        }

        if(isDefined(bit)) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, bit);
        }
      }
    }

    if(isDefined(level.var_8241e0d86017df29)) {
      str_region = [[level.var_8241e0d86017df29]](sparams.eattacker.origin);

      switch (str_region) {
        case #"hash_7bb2cd766703d463":
          if(isweapon(sparams.sweapon) && isDefined(sparams.sweapon)) {
            if(sparams.eattacker getplayerweaponraritysharedfunc(sparams.sweapon) >= 4) {
              var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["low_threat_legendary_wep_kill"]);
            }
          }

          break;
        case #"hash_af83e47edfa8900a":
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["yellow_region_kill"]);
          break;
        case #"hash_5343b465e56ec9a4":
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["red_region_kill"]);
          break;
        default:
          break;
      }
    }

    rarity = sparams.eattacker getplayerweaponraritysharedfunc(sparams.sweapon);

    switch (rarity) {
      case 1:
        var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["uncommon"]);
        break;
      case 2:
        var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["rare"]);
        break;
      case 3:
        var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["epic"]);
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["epic_or_higher_rarity"]);
        break;
      case 4:
        var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["legendary"]);
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["full_attachements_kill"]);
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["epic_or_higher_rarity"]);
        break;
      case 5:
        zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["epic_or_higher_rarity"]);
        break;
      default:
        break;
    }

    if(isDefined(sparams.eattacker.var_b57b122cb903fddf) && sparams.eattacker.var_b57b122cb903fddf != 0 && sparams.eattacker.var_b57b122cb903fddf % 10 == 0) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["jackrabbit"]);
    }

    if(function_ce3c3c0439296754()) {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, var_cb9bc0821d0eee8d["tactical_affected_kill"]);
    }

    if(isDefined(sparams.eattacker.rapidkill_data) && isDefined(sparams.eattacker.rapidkill_data["elemental_kill_electrical"]) && sparams.eattacker.rapidkill_data["elemental_kill_electrical"].rapidkill_count != 0) {
      if(sparams.eattacker.rapidkill_data["elemental_kill_electrical"].rapidkill_count % 10 == 0) {
        var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["conductive"]);
      }
    }

    if(isDefined(sparams.einflictor.turrettype) && issubstr(sparams.einflictor.turrettype, "defend_turret")) {
      var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, var_7f56c75cde4fea6c["deadbolt_turret_kill"]);
    }
  }

  return [zombiemodifiers, var_151fa81d56a14612];
}

function function_9966e6739036c441(var_398aced5a2239dca, sparams, enemytype, subclass, var_53525e5d094a332b) {
  zombiemodifiers = var_398aced5a2239dca;
  var_16713e93b3812fc6 = function_6c8b18941d0a604d();

  if(isDefined(sparams.eattacker) && isPlayer(sparams.eattacker) && var_53525e5d094a332b ent_flag_exist("activity_mercCamp_spawned")) {
    kill_bit = var_16713e93b3812fc6["merc_camp_kill"];

    if(isDefined(kill_bit) && enemytype == "soldier") {
      zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
    }
  }

  if(isDefined(sparams.eattacker) && isDefined(sparams.eattacker.activities) && isDefined(sparams.eattacker.activities.focusedactivityid)) {
    activity = getactivityinstance(sparams.eattacker.activities.focusedactivityid);

    if(!isDefined(activity.type)) {
      activity.type = "";
    }

    switch (activity.type) {
      case #"hash_5191681fd986c4eb":
        kill_bit = var_16713e93b3812fc6["aether_sabotage_soldier_kill"];

        if(isDefined(kill_bit) && enemytype == "soldier" && var_53525e5d094a332b ent_flag_exist("activity_sabotage_spawned")) {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
        }

        break;
      case #"hash_87fc920520ec2075":
      case #"hash_bcceffcc02978e65":
        switch (enemytype) {
          case #"hash_44aaeb0edd152195":
            if(isDefined(activity.safe) && isDefined(activity.safe.var_208c5333afcd7102)) {
              kill_bit = var_16713e93b3812fc6["weapon_stash_guard_kill"];

              if(isDefined(kill_bit) && var_53525e5d094a332b ent_flag_exist("activity_safe_attracted")) {
                zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
              }
            }

            break;
          case #"hash_f695947f7a9ce23f":
            if(isDefined(activity.safe) && isDefined(activity.safe.var_208c5333afcd7102)) {
              kill_bit = var_16713e93b3812fc6["weapon_stash_guard_kill"];

              if(isDefined(kill_bit) && var_53525e5d094a332b ent_flag_exist("activity_safe_attracted")) {
                zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
              }
            }

            break;
        }

        break;
      case #"hash_40d422a1ae5ecf0f":
        kill_bit = var_16713e93b3812fc6["escort_zombie_kill"];

        if(isDefined(kill_bit) && enemytype == "zombie") {
          zombiemodifiers = function_6d40f12a09494350(zombiemodifiers, kill_bit);
        }

        break;
    }
  }

  return zombiemodifiers;
}

function function_128985eaf12e0ed8(var_22958a4f33c2a347, sparams, enemytype, subclass, var_53525e5d094a332b) {
  var_151fa81d56a14612 = var_22958a4f33c2a347;
  var_741c0fba7bde178b = function_adb26e28d3408dac();

  if(isDefined(sparams.eattacker) && isDefined(sparams.eattacker.activities) && isDefined(sparams.eattacker.activities.focusedactivityid)) {
    activity = getactivityinstance(sparams.eattacker.activities.focusedactivityid);

    if(!isDefined(activity.type)) {
      activity.type = "";
    }

    switch (activity.type) {
      case #"hash_bcceffcc02978e65":
        switch (enemytype) {
          case #"hash_f695947f7a9ce23f":
            kill_bit = var_741c0fba7bde178b["safe_drill_attract_kill"];

            if(isDefined(kill_bit) && var_53525e5d094a332b ent_flag_exist("activity_safe_attracted")) {
              var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, kill_bit);
            }

            break;
        }

        break;
      case #"hash_b034a4d29df58c9a":
        kill_bit = var_741c0fba7bde178b["merc_defend_soldier_kill"];

        if(isDefined(kill_bit) && enemytype == "soldier" && var_53525e5d094a332b ent_flag_exist("activity_merc_defend_spawned")) {
          var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, kill_bit);
        }

        break;
      case #"hash_17b1c4f2de901a59":
        kill_bit = var_741c0fba7bde178b["contaminated_space_zombie_kill"];

        if(isDefined(kill_bit) && enemytype == "zombie" && var_53525e5d094a332b ent_flag_exist("activity_outlast_spawned")) {
          var_151fa81d56a14612 = function_6d40f12a09494350(var_151fa81d56a14612, kill_bit);
        }

        break;
    }
  }

  return var_151fa81d56a14612;
}

function function_18a53d77df35c4c9(player, missionid) {
  if(!isDefined(player) || !isDefined(missionid)) {
    return false;
  }

  return function_c7d3c1cb4a3958cf(player, missionid) && !function_62b41959b3c5a9ca(player, missionid) || getdvarint(@ "hash_7c5a823345cc6183", 0);
}

function function_7e993967c3cfc6c9(params) {
  if(!isPlayer(self)) {
    return;
  }

  ammomod_name = params.ammomod_name;
  is_special = params.var_19560ec564499c6c;

  if(isDefined(params.zombie)) {
    zombie = params.zombie;
  }

  if(isDefined(ammomod_name)) {
    aeeventname = #"ob_interact";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    gamemode = challenges::getchallengegamemode(self);
    gametype = challenges::function_17c5d7feb226e256();

    if(ammomod_name == "deadwire") {
      if(isDefined(zombie) && isDefined(zombie.var_a65cf0af898fe81a)) {
        return;
      }

      zombie.var_a65cf0af898fe81a = 1;
      bitid = "deadwire_proc";

      if(istrue(is_special)) {
        bitid = "deadwire_stun_special";
      }
    } else if(ammomod_name == "napalmburst") {
      if(isDefined(zombie) && isDefined(zombie.napalmburst_proc)) {
        return;
      }

      zombie.napalmburst_proc = 1;
      bitid = "napalmburst_proc";

      if(istrue(is_special)) {
        bitid = "napalmburst_special_proc";
      }
    } else if(ammomod_name == "brainrot") {
      bitid = "brainrot_proc";
    }

    if(isDefined(aeeventid) && isDefined(bitid)) {
      interact_bits = function_d89978ce1f60dfc();
      interact_bit = 0;
      interact_bit = function_6d40f12a09494350(interact_bit, interact_bits[bitid]);
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2b9333cc10a910d9"), interact_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

      if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
        callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
      }
    }
  }
}

function on_tesla_storm_stunned(params) {
  if(isPlayer(params.eattacker) && is_equal(self.unittype, "soldier") && !istrue(self.var_1979f554dfbc890b)) {
    params.eattacker function_f10f600ac4ee4c09("tesla_storm_stun_soldier");
    self.var_1979f554dfbc890b = 1;
  }
}

function function_de9f828fd5fb2dc3(sparams) {
  thread function_5e1833b74c8dc68f();

  if(isDefined(sparams.objweapon) && isweapon(sparams.objweapon)) {
    level.wallbuy_weapons = array_add(level.wallbuy_weapons, sparams.objweapon);

    if(istrue(sparams.objweapon.hasalternate)) {
      altweapon = sparams.objweapon getaltweapon();
      level.wallbuy_weapons = array_add(level.wallbuy_weapons, altweapon);
    }
  }

  var_7d9803744a905b95 = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_e6b742f2dbcdaa7a", #"wallbuy"));
  buy_action = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"buy"));
  var_f237807396377232 = spawnStruct();

  if(isweapon(sparams.objweapon)) {
    var_f237807396377232.rarity = namespace_736197e4d378b91b::function_75e73212bbe447d9(sparams.objweapon);
  }

  var_f237807396377232.var_7d9803744a905b95 = var_7d9803744a905b95;
  challenges::function_1ba256da09a9878a(self, sparams.lootid, undefined, undefined, 1, sparams.cost, buy_action, var_f237807396377232);
  function_cadbe7496c7c80ee(sparams.objweapon);
}

function on_item_pickup(sparams) {
  if(isDefined(sparams.item)) {
    if(istrue(sparams.item.var_1c9b1e35f32a7097)) {
      function_f243f33d3935b4f8();
    } else if(istrue(sparams.item.var_5d482f7364fad176)) {
      function_f10f600ac4ee4c09("loot_harvester_orb_end", 2);
    }

    switch (sparams.itembundlename) {
      case #"hash_7c4ae75afa6d0b90":
        function_f10f600ac4ee4c09("pickup_gas_mask");
        break;
      case #"hash_26ac0d5fd9f65d60":
        function_f10f600ac4ee4c09("pickup_gas_mask");
        break;
      case #"hash_35336c7481df7ce2":
        function_f0156d5e3908b93b();
        thread function_da06d69b0b66e612(16822, "quest_s0a1t6_alab_loottablet", 1);
        break;
      case #"hash_edfb85cb31838c9":
        function_f10f600ac4ee4c09("shatterblast_obtain");
        break;
      case #"hash_74b351733941de9b":
        if(istrue(sparams.item.var_1018ba92f1186325)) {
          function_f10f600ac4ee4c09("pickup_keycard_from_convoy");
          thread function_da06d69b0b66e612(16095, "quest_s0a1t2_cnvy_keylooted", 1);
        } else {
          function_f10f600ac4ee4c09("used_stronghold_key", 2);
        }

        break;
      case #"hash_fcf503d2ae6bc4f0":
        function_f10f600ac4ee4c09("pickup_ava_intel_from_frenzied_guard_special_elite");
        break;
      case #"hash_d6c8c974b4fb2e01":
        function_f10f600ac4ee4c09("pickup_ava_intel_from_aether_nest");
        break;
      case #"hash_ed44a06281542bd4":
        function_f10f600ac4ee4c09("pickup_ava_intel_by_armored_zombie");
        break;
      case #"hash_e42806c4e3d8eaa3":
        function_f10f600ac4ee4c09("pickup_ava_intel_from_soldier");
        break;
      case #"hash_c1d8ea8609e37fc5":
        function_f10f600ac4ee4c09("stronghold_special_intel", 2);
        thread function_da06d69b0b66e612(16946, "quest_s0a1t4_mstr_dossiersucc", 1);
        break;
      case #"hash_2d418737827b9bda":
        function_f10f600ac4ee4c09("zombie_stronghold_intel_tablet_collected", 2);
        break;
      case #"hash_931bacafb159989a":
        function_f10f600ac4ee4c09("pickup_essence_bazaar", 2);
        thread function_da06d69b0b66e612(16655, "quest_s0a2t3_essaether_start");
        break;
      case #"hash_32fefbc1ade48d6a":
        function_f10f600ac4ee4c09("pickup_essence_retail", 2);
        thread function_da06d69b0b66e612(16655, "quest_s0a2t3_essaether_start");
        break;
      case #"hash_35508910428bf454":
        function_f10f600ac4ee4c09("pickup_essence_shops", 2);
        thread function_da06d69b0b66e612(16655, "quest_s0a2t3_essaether_start");
        break;
      case #"hash_de70b56562925f9e":
        function_98c3f4e720f6089c();
        self.var_8fb5cf84d3fec2ed = 1;
        break;
      case #"hash_6ae12cc9d2961da1":
        thread function_da06d69b0b66e612(17078, "quest_s0a3t3_merccamp_research", 1);
        function_f10f600ac4ee4c09("jup_strauss_research_tablet");
        break;
    }

    if(isDefined(sparams.itembundle) && isDefined(sparams.itembundle.ref)) {
      switch (sparams.itembundle.ref) {
        case #"hash_362af22ed7a7952":
        case #"hash_2cf17c998fa6c370":
        case #"hash_8f0b03ed1c07c01a":
        case #"hash_968017ca0fcdc9b0":
        case #"hash_9e489735d19803e5":
          function_bcfb5a0e96552599();
          break;
        default:
          break;
      }
    }
  }

  if(isDefined(sparams.item) && isDefined(sparams.itembundle)) {
    rarity = function_56e47c52dfb878e1(sparams.itembundle.raritydef);
    lootid = loot::getlootidfromref(sparams.itembundle.ref);
    var_f237807396377232 = spawnStruct();
    var_f237807396377232.rarity = rarity;
    challenges::function_8359cadd253f9604(self, undefined, sparams.item.count, 0, lootid, var_f237807396377232);
  }
}

function function_56e47c52dfb878e1(raritydef) {
  if(isDefined(raritydef)) {
    raritybundle = getscriptbundle(raritydef);
    rarityname = raritybundle.magicboxrarity;

    switch (rarityname) {
      case #"hash_db653a4972b3c13b":
        return 0;
      case #"hash_540f19f4cb02adc3":
        return 1;
      case #"hash_209fa8900070d83d":
        return 2;
      case #"hash_95068103fe897bc8":
        return 3;
      case #"hash_d6c98e710a88aa4a":
        return 4;
      case #"hash_22aea56c1711fd5":
        return 5;
      default:
        return 0;
    }
  }
}

function function_94545a9bb0878e0e(params) {
  if(isDefined(params.itembundle.var_72340ceb276c0f64) && istrue(params.itembundle.var_72340ceb276c0f64)) {
    if(!isDefined(self.var_1e70ca7c886956a0)) {
      self.var_1e70ca7c886956a0 = 0;
    }

    if(gettime() > self.var_1e70ca7c886956a0 + 30000) {
      self.var_1e70ca7c886956a0 = 0;
      self.var_22d1f71559f6524a = 0;
    }

    if(self.var_1e70ca7c886956a0 == 0) {
      self.var_1e70ca7c886956a0 = gettime();
    }

    if(!isDefined(self.var_22d1f71559f6524a)) {
      self.var_22d1f71559f6524a = 0;
    }

    self.var_22d1f71559f6524a++;

    if(self.var_22d1f71559f6524a >= 5) {
      function_f10f600ac4ee4c09("use_acquisitions_thirty", 1, 0);
    }
  }

  if(isDefined(params.itembundle) && isDefined(params.item)) {
    rarity = function_56e47c52dfb878e1(params.itembundle.raritydef);
    lootid = loot::getlootidfromref(params.itembundle.ref);
    var_f237807396377232 = spawnStruct();
    var_f237807396377232.rarity = rarity;
    challenges::function_cfeb523fd3aa9ecf(self, lootid, undefined, 0, params.item.count, var_f237807396377232);
  }
}

function private function_c9293fc51ab4bfeb(params) {
  var_76f28326961ae32d = [];

  if(isDefined(params.bundle)) {
    var_76f28326961ae32d[#"hash_5579154124d68ab2"] = params.value;
  }

  if(isDefined(params.ref)) {
    switch (params.ref) {
      case #"hash_7787d60b15bab3cd":
        function_f10f600ac4ee4c09("flesh_chunk_sold");
        break;
    }
  }

  function_8f4f9e5b10af310d(#"ob_interact", var_76f28326961ae32d);

  if(isDefined(params.bundle)) {
    rarity = function_56e47c52dfb878e1(params.bundle.raritydef);
    lootid = loot::getlootidfromref(params.bundle.ref);
    var_f237807396377232 = spawnStruct();
    var_f237807396377232.rarity = rarity;
    var_f237807396377232.var_7d9803744a905b95 = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_e6b742f2dbcdaa7a", #"buy_station"));
    challenges::function_ea50038423fc4cfc(undefined, undefined, lootid, params.var_6d5e047412a465f6, params.value, var_f237807396377232);
  }
}

function function_8f4f9e5b10af310d(var_aaff38ee691a18b0, var_88a8f75abf8b400f) {
  aeeventid = function_6e2deb013c9ca85e(var_aaff38ee691a18b0);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();

  if(isDefined(aeeventid)) {
    kvp_array = [ae_utility::function_d6f771aedba70ce7(var_aaff38ee691a18b0, #"version"), 1, ae_utility::function_d6f771aedba70ce7(var_aaff38ee691a18b0, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(var_aaff38ee691a18b0, #"gametype"), gametype];

    foreach(key, value in var_88a8f75abf8b400f) {
      if(ae_utility::function_5ca3bdbcf741615f(var_aaff38ee691a18b0, key)) {
        kvp_array[kvp_array.size] = ae_utility::function_d6f771aedba70ce7(var_aaff38ee691a18b0, key);
        kvp_array[kvp_array.size] = value;
      }
    }

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, kvp_array);
    }

    return;
  }

  assertmsg("<dev string:x1c>");
}

function function_d000329f6edb1510() {
  aeeventname = #"kill";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();

  if(isDefined(aeeventid)) {
    var_cb9bc0821d0eee8d = function_6c8b18941d0a604d();
    var_d8b20b99033c0c4c = 0;
    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_648b2ad7f16589f0"), var_d8b20b99033c0c4c, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function on_player_spawned(params) {
  var_674c247b5e3b128 = pmc_missions::function_62b41959b3c5a9ca(self, 16141);
  var_1cd9b9791cfeb624 = pmc_missions::function_62b41959b3c5a9ca(self, 16142);

  if(var_674c247b5e3b128 && !var_1cd9b9791cfeb624) {
    self.var_74d8dcd67ff30483 = "jup_ob_zombie_weapon_stash_kills";
    return;
  }

  if(!var_674c247b5e3b128 && var_1cd9b9791cfeb624) {
    self.var_74d8dcd67ff30483 = "jup_ob_loot_safes";
  }
}

function function_cadbe7496c7c80ee(objweapon) {
  aeeventname = #"ob_interact";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();

  if(isDefined(aeeventid)) {
    interact_bits = function_d89978ce1f60dfc();
    interact_bit = 0;
    interact_bit = function_6d40f12a09494350(interact_bit, interact_bits["wallbuy_purchase"]);
    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2b9333cc10a910d9"), interact_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function function_6a7cf6856f3e681(sparams) {
  if(isDefined(sparams.objweapon) && isweapon(sparams.objweapon)) {
    level.magicbox_weapons = array_add(level.magicbox_weapons, sparams.objweapon);

    if(istrue(sparams.objweapon.hasalternate)) {
      altweapon = sparams.objweapon getaltweapon();
      level.magicbox_weapons = array_add(level.magicbox_weapons, altweapon);
    }
  }

  function_68052c69f0f90df8();

  if(isweapon(sparams.objweapon) && isDefined(sparams.objweapon.basename)) {
    if(namespace_736197e4d378b91b::function_75e73212bbe447d9(sparams.objweapon) >= 4) {
      function_f10f600ac4ee4c09("magicbox_legendary_ww_pickup");
    }
  }

  var_18cefa3acf061993 = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_e6b742f2dbcdaa7a", #"magicbox"));
  buy_action = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"buy"));
  cost = 950;
  var_f237807396377232 = spawnStruct();

  if(isweapon(sparams.objweapon)) {
    var_f237807396377232.rarity = namespace_736197e4d378b91b::function_75e73212bbe447d9(sparams.objweapon);
  }

  var_f237807396377232.var_7d9803744a905b95 = var_18cefa3acf061993;
  challenges::function_1ba256da09a9878a(self, sparams.lootid, undefined, undefined, 1, cost, buy_action, var_f237807396377232);
}

function function_68052c69f0f90df8(objweapon) {
  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"ob_interact";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();

  if(isDefined(aeeventid)) {
    interact_bits = function_d89978ce1f60dfc();
    interact_bit = 0;
    interact_bit = function_6d40f12a09494350(interact_bit, interact_bits["magicbox_purchase"]);
    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2b9333cc10a910d9"), interact_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function on_pap_machine_purchase(params) {
  if(isDefined(params.n_pap_level)) {
    switch (params.n_pap_level) {
      case 1:
        thread function_568866da0244ea3();
        function_f10f600ac4ee4c09("pap_purchase_level_1");
        break;
      case 2:
        thread function_da06d69b0b66e612(14967, "quest_s0a2t3_firepower_start", undefined, 1);
        function_f10f600ac4ee4c09("pap_purchase_level_1");
        function_f10f600ac4ee4c09("pap_purchase_level_2");
        break;
      case 3:
        thread function_da06d69b0b66e612(14972, "quest_s0_a3t2_mostfirepwr_start", undefined, 1);
        function_f10f600ac4ee4c09("pap_purchase_level_1");
        function_f10f600ac4ee4c09("pap_purchase_level_2");
        function_f10f600ac4ee4c09("pap_purchase_level_3");
        break;
    }
  }
}

function function_f243f33d3935b4f8() {
  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"ob_interact";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();

  if(isDefined(aeeventid)) {
    interact_bits = function_d89978ce1f60dfc();
    interact_bit = 0;
    interact_bit = function_6d40f12a09494350(interact_bit, interact_bits["pickup_item_from_crystal"]);
    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2b9333cc10a910d9"), interact_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function loot_crystal_destroyed(sparams) {
  if(isPlayer(sparams.instigator)) {}
}

function function_9ef71ee9309e7fcb() {
  aeeventname = #"ob_interact";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  gametype = level.gametype;
  function_f10f600ac4ee4c09("aether_extractor_destroy", 2);
  thread function_da06d69b0b66e612(16132, "quest_s0a1t3_saboteur_success");
}

function aether_extractor_disabled(sparams) {
  if(!isPlayer(sparams.player)) {
    return;
  }

  aeeventname = #"ob_interact";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  gametype = level.gametype;

  if(isDefined(aeeventid)) {
    interact_bits = function_d89978ce1f60dfc();
    interact_bit = 0;
    interact_bit = challenges::function_6d40f12a09494350(interact_bit, interact_bits["aether_extractor_destroy"]);
    params = [function_d6f771aedba70ce7(aeeventname, #"hash_b431eec04f47bf51"), interact_bit];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      sparams.player callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function function_6c8b18941d0a604d() {
  if(isarray(level.var_cb9bc0821d0eee8d) && level.var_cb9bc0821d0eee8d.size > 0) {
    return level.var_cb9bc0821d0eee8d;
  }

  var_cb9bc0821d0eee8d = [];
  var_cb9bc0821d0eee8d["wallbuy_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"wallbuy_kill");
  var_cb9bc0821d0eee8d["magicbox_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"magicbox_kill");
  var_cb9bc0821d0eee8d["frenzied_guard_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"frenzied_guard_kill");
  var_cb9bc0821d0eee8d["special_elite_frenzied_guard_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"special_elite_frenzied_guard_kill");
  var_cb9bc0821d0eee8d["cryofreeze_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"cryofreeze_kill");
  var_cb9bc0821d0eee8d["frost_blast_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"frost_blast_kill");
  var_cb9bc0821d0eee8d["energy_mine_kill_zombie"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"energy_mine_kill_zombie");
  var_cb9bc0821d0eee8d["energy_mine_kill_soldier"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"energy_mine_kill_soldier");
  var_cb9bc0821d0eee8d["aether_shroud_kill_zombie"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"aether_shroud_kill_zombie");
  var_cb9bc0821d0eee8d["aether_shroud_kill_soldier"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"aether_shroud_kill_soldier");
  var_cb9bc0821d0eee8d["tesla_storm_kill_zombie"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"tesla_storm_kill_zombie");
  var_cb9bc0821d0eee8d["pap_kill_zombie_level_1_yellow_or_higher"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"pap_kill_zombie_level_1_yellow_or_higher");
  var_cb9bc0821d0eee8d["pap_kill_zombie_level_2"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"pap_kill_zombie_level_2");
  var_cb9bc0821d0eee8d["pap_kill_zombie_special_level_2"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"pap_kill_zombie_special_level_2");
  var_cb9bc0821d0eee8d["pap_kill_zombie_level_3"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"pap_kill_zombie_level_3");
  var_cb9bc0821d0eee8d["pap_kill_zombie_elite_level_3"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"pap_kill_zombie_elite_level_3");
  var_cb9bc0821d0eee8d["brainrot_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"brainrot_kill");
  var_cb9bc0821d0eee8d["napalmburst_burning_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"napalmburst_burning_kill");
  var_cb9bc0821d0eee8d["deadwire_execution_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"deadwire_execution_kill");
  var_cb9bc0821d0eee8d["soldier_captain_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"soldier_captain_kill");
  var_cb9bc0821d0eee8d["soldier_commander_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"soldier_commander_kill");
  var_cb9bc0821d0eee8d["killstreak_turret_soldier_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"killstreak_turret_soldier_kill");
  var_cb9bc0821d0eee8d["killstreak_turret_zombie_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"killstreak_turret_zombie_kill");
  var_cb9bc0821d0eee8d["vehicle_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"vehicle_kill");
  var_cb9bc0821d0eee8d["vehicle_turret_zombie_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"hash_4608211df0e156df");
  var_cb9bc0821d0eee8d["aether_sabotage_soldier_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"aether_sabotage_soldier_kill");
  var_cb9bc0821d0eee8d["merc_camp_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"merc_camp_kill");
  var_cb9bc0821d0eee8d["weapon_stash_guard_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"weapon_stash_guard_kill");
  var_cb9bc0821d0eee8d["weapon_stash_zombie_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"weapon_stash_zombie_kill");
  var_cb9bc0821d0eee8d["escort_zombie_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"escort_zombie_kill");
  var_cb9bc0821d0eee8d["storm_castle_warlord_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"storm_castle_warlord_kill");
  var_cb9bc0821d0eee8d["pap_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"pap_kill");
  var_cb9bc0821d0eee8d["field_upgrade_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"field_upgrade_kill");
  var_cb9bc0821d0eee8d["critical_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"critical_kill");
  var_cb9bc0821d0eee8d["killstreak_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"killstreak_kill");
  var_cb9bc0821d0eee8d["equipment_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"equipment_kill");
  var_cb9bc0821d0eee8d["aether_storm_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"aether_storm_kill");
  var_cb9bc0821d0eee8d["fire_damage"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"fire_damage");
  var_cb9bc0821d0eee8d["electric_damage"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"electric_damage");
  var_cb9bc0821d0eee8d["frost_damage"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"frost_damage");
  var_cb9bc0821d0eee8d["explosive_damage"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"explosive_damage");
  var_cb9bc0821d0eee8d["elemental_combo"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"elemental_combo");
  var_cb9bc0821d0eee8d["warlord_speedrun"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"warlord_speedrun");
  var_cb9bc0821d0eee8d["deathworm_solo_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"deathworm_solo_kill");
  var_cb9bc0821d0eee8d["abomination_grenade_swallow"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"abomination_grenade_swallow");
  var_cb9bc0821d0eee8d["schematic_speedcola_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"schematic_speedcola_kill");
  var_cb9bc0821d0eee8d["schematic_cryofreeze_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"schematic_cryofreeze_kill");
  var_cb9bc0821d0eee8d["phd_flopper"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"phd_flopper");
  var_cb9bc0821d0eee8d["yellow_region_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"yellow_region_kill");
  var_cb9bc0821d0eee8d["red_region_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"red_region_kill");
  var_cb9bc0821d0eee8d["kill_four_perks"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"kill_four_perks");
  var_cb9bc0821d0eee8d["juggernog_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"juggernog_equipped");
  var_cb9bc0821d0eee8d["quickrevive_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"quickrevive_equipped");
  var_cb9bc0821d0eee8d["deadshot_daiquiri_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"deadshot_daiquiri_equipped");
  var_cb9bc0821d0eee8d["speedcola_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"speedcola_equipped");
  var_cb9bc0821d0eee8d["elemental_pop_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"elemental_pop_equipped");
  var_cb9bc0821d0eee8d["death_perception_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"death_perception_equipped");
  var_cb9bc0821d0eee8d["staminup_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"staminup_equipped");
  var_cb9bc0821d0eee8d["phd_flopper_equipped"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"phd_flopper_equipped");
  var_cb9bc0821d0eee8d["kills_and_exfil"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"kills_and_exfil");
  var_cb9bc0821d0eee8d["jackrabbit"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"jackrabbit");
  var_cb9bc0821d0eee8d["full_attachements_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"full_attachements_kill");
  var_cb9bc0821d0eee8d["epic_or_higher_rarity"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"epic_or_higher_rarity");
  var_cb9bc0821d0eee8d["one_shot_three_kills"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"one_shot_three_kills");
  var_cb9bc0821d0eee8d["kill_after_field_upgrade_used"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"kill_after_field_upgrade_used");
  var_cb9bc0821d0eee8d["tactical_affected_kill"] = function_e2ff8f4b4e94f723(#"hash_648b2ad7f16589f0", #"tactical_affected_kill");
  level.var_cb9bc0821d0eee8d = var_cb9bc0821d0eee8d;
  return var_cb9bc0821d0eee8d;
}

function function_adb26e28d3408dac() {
  if(isarray(level.var_7f56c75cde4fea6c) && level.var_7f56c75cde4fea6c.size > 0) {
    return level.var_7f56c75cde4fea6c;
  }

  var_7f56c75cde4fea6c = [];
  var_7f56c75cde4fea6c["safe_drill_attract_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"safe_drill_attract_kill");
  var_7f56c75cde4fea6c["merc_defend_soldier_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"merc_defend_soldier_kill");
  var_7f56c75cde4fea6c["precision_airstrike_soldier_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"precision_airstrike_soldier_kill");
  var_7f56c75cde4fea6c["redeploy_drone_zombie_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"redeploy_drone_zombie_kill");
  var_7f56c75cde4fea6c["contaminated_space_zombie_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"contaminated_space_zombie_kill");
  var_7f56c75cde4fea6c["aether_storm_orange_zombie_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"aether_storm_orange_zombie_kill");
  var_7f56c75cde4fea6c["low_threat_legendary_wep_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"low_threat_legendary_wep_kill");
  var_7f56c75cde4fea6c["pap_kill_general"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"pap_kill_general");
  var_7f56c75cde4fea6c["wallbuy_kill_general"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"wallbuy_kill_general");
  var_7f56c75cde4fea6c["magicbox_kill_general"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"magicbox_kill_general");
  var_7f56c75cde4fea6c["uncommon"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"uncommon");
  var_7f56c75cde4fea6c["rare"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"rare");
  var_7f56c75cde4fea6c["epic"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"epic");
  var_7f56c75cde4fea6c["legendary"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"legendary");
  var_7f56c75cde4fea6c["toxic_damage"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"toxic_damage");
  var_7f56c75cde4fea6c["conductive"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"conductive");
  var_7f56c75cde4fea6c["deadbolt_turret_kill"] = function_e2ff8f4b4e94f723(#"hash_3e038eef2f8914a6", #"deadbolt_turret_kill");
  level.var_7f56c75cde4fea6c = var_7f56c75cde4fea6c;
  return var_7f56c75cde4fea6c;
}

function function_63663f994d4e7634() {
  if(isarray(level.var_1a027888c7b365e9) && level.var_1a027888c7b365e9.size > 0) {
    return level.var_1a027888c7b365e9;
  }

  var_1a027888c7b365e9 = [];
  var_1a027888c7b365e9["zombie_general"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"zombie_general");
  var_1a027888c7b365e9["zombie_base"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"zombie_normal");
  var_1a027888c7b365e9["zombie_base_armored_heavy"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"hash_2e33fb6219268242");
  var_1a027888c7b365e9["zombie_base_armored_light"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"hash_2e33fb6219268242");
  var_1a027888c7b365e9["zombie_abom"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"hash_18af518f7f491249");
  var_1a027888c7b365e9["zombie_mangler"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"hash_e5cc9ba2d564d960");
  var_1a027888c7b365e9["zombie_mimic"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"hash_d92e9d5d34383289");
  var_1a027888c7b365e9["zombie_disciple"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"hash_111eeb7c9c836183");
  var_1a027888c7b365e9["zombie_normal_hellhound"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"zombie_normal_hellhound");
  var_1a027888c7b365e9["zombie_deathworm"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"hash_d08cb8b650fe3185");
  var_1a027888c7b365e9["merc_general"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_general");
  var_1a027888c7b365e9["merc_warlord"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_warlord");
  var_1a027888c7b365e9["merc_specialist"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_specialist");
  var_1a027888c7b365e9["soldier_captain_kill"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"soldier_captain_kill");
  var_1a027888c7b365e9["soldier_commander_kill"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"soldier_commander_kill");
  var_1a027888c7b365e9["merc_specialist_sniper"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_specialist_sniper");
  var_1a027888c7b365e9["merc_specialist_shielded"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_specialist_shielded");
  var_1a027888c7b365e9["merc_specialist_support"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_specialist_support");
  var_1a027888c7b365e9["merc_specialist_rusher"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_specialist_rusher");
  var_1a027888c7b365e9["merc_specialist_rocketeer"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_specialist_rocketeer");
  var_1a027888c7b365e9["merc_specialist_heavytactician"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"merc_specialist_heavytactician");
  var_1a027888c7b365e9["big_bounty_target"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"big_bounty_target");
  var_1a027888c7b365e9["zombie_elite_general"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"zombie_elite_general");
  var_1a027888c7b365e9["zombie_special_general"] = function_e2ff8f4b4e94f723(#"hash_4a2a8345ce12358", #"zombie_special_general");
  level.var_1a027888c7b365e9 = var_1a027888c7b365e9;
  return var_1a027888c7b365e9;
}

function function_32126a54e0e1055c(var_398aced5a2239dca, subclass, var_53525e5d094a332b, kiastring) {
  var_3e963b841cdedb62 = function_63663f994d4e7634();
  var_d28c6116660bb280 = var_398aced5a2239dca;

  if(isDefined(var_3e963b841cdedb62["zombie_general"])) {
    var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_general"]);
  }

  if(isDefined(subclass)) {
    switch (subclass) {
      case #"hash_1380581f5144c465":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_base"]);
        break;
      case #"hash_99a38be9e88b5244":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_base_armored_heavy"]);
        break;
      case #"hash_f297af39454fdc7b":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_base_armored_light"]);
        break;
      case #"hash_3d51cb1a1a5f356b":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_abom"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_elite_general"]);
        break;
      case #"hash_1967f0e49ca5666a":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_abom"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_elite_general"]);
        break;
      case #"hash_7ba1ac4906d2dfde":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_abom"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_elite_general"]);
        break;
      case #"hash_a18ec1c48b974dc7":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_abom"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_elite_general"]);
        break;
      case #"hash_2f5c52f1e6ef9284":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_mangler"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_special_general"]);
        break;
      case #"hash_60cbd0daf82a39c9":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_mangler"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_special_general"]);
        break;
      case #"hash_59740dd906312a95":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_mimic"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_special_general"]);
        break;
      case #"hash_c1fa8721b046b258":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_mimic"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_special_general"]);
        break;
      case #"hash_3e4a9c816939eeef":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_disciple"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_special_general"]);
        break;
      case #"hash_c1b612499d7bd4a":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_disciple"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_special_general"]);
        break;
      case #"hash_9bc2060c1da7a187":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_disciple"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_special_general"]);
        break;
      case #"hash_99d5ac2f7a4d8083":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_normal_hellhound"]);
        break;
      default:
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["zombie_base"]);
        break;
    }
  }

  if(isDefined(var_53525e5d094a332b) && var_53525e5d094a332b ent_flag_exist("big_bounty_target")) {
    var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["big_bounty_target"]);
  }

  return var_d28c6116660bb280;
}

function function_4030ef122da1cf5c(var_398aced5a2239dca) {
  var_3e963b841cdedb62 = function_63663f994d4e7634();
  var_d28c6116660bb280 = var_398aced5a2239dca;

  if(isDefined(var_3e963b841cdedb62["merc_general"])) {
    var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_general"]);
  }

  if(isDefined(self.subclass)) {
    switch (self.subclass) {
      case #"hash_8c92249632740ac":
      case #"hash_12daa0cbf50f6442":
      case #"hash_d646bb7570717551":
      case #"hash_dde105a699b160b3":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_warlord"]);
        break;
      default:
        break;
    }
  }

  if(isDefined(self.agent_type)) {
    switch (self.agent_type) {
      case #"hash_494c78d0fe9c3cb4":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["soldier_captain_kill"]);
        break;
      case #"hash_11b7036e79b0edc2":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["soldier_commander_kill"]);
        break;
      case #"hash_4468b0fd141b9355":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist_sniper"]);
        break;
      case #"hash_2b1c70e7844f2db0":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist_shielded"]);
        break;
      case #"hash_b5d278bc9bea747":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist_support"]);
        break;
      case #"hash_931849f4ce03d0e1":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist_rusher"]);
        break;
      case #"hash_caea87203ab0bcf4":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist_rocketeer"]);
        break;
      case #"hash_f5d5b7476b6cc681":
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist"]);
        var_d28c6116660bb280 = function_6d40f12a09494350(var_d28c6116660bb280, var_3e963b841cdedb62["merc_specialist_heavytactician"]);
        break;
      default:
        break;
    }
  }

  return var_d28c6116660bb280;
}

function function_484194ec6ace15bb(var_d29889468d853030, var_f2b106a03cdbf1, var_5670f984dc9565b5, var_828f250005b03c8e) {
  if(!isDefined(var_f2b106a03cdbf1)) {
    var_f2b106a03cdbf1 = 1;
  }

  if(!isDefined(var_5670f984dc9565b5)) {
    var_5670f984dc9565b5 = 1;
  }

  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"kill";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();
  weaponlootid = 0;

  if(isweapon(var_828f250005b03c8e)) {
    weaponlootid = weapon::function_89a83ae9a4c4142a(var_828f250005b03c8e);
  }

  if(!isDefined(weaponlootid)) {
    weaponlootid = 0;
  }

  if(isDefined(aeeventid)) {
    kill_bits = [];
    var_800fb1078b834513 = "";
    kill_bit = 0;

    switch (var_f2b106a03cdbf1) {
      case 1:
        kill_bits = function_6c8b18941d0a604d();
        var_800fb1078b834513 = #"hash_648b2ad7f16589f0";
        break;
      case 2:
        kill_bits = function_adb26e28d3408dac();
        var_800fb1078b834513 = #"hash_3e038eef2f8914a6";
        break;
      case 3:
        kill_bits = function_63663f994d4e7634();
        var_800fb1078b834513 = #"hash_4a2a8345ce12358";
        break;
      default:
        kill_bits = function_6c8b18941d0a604d();
        var_800fb1078b834513 = #"hash_648b2ad7f16589f0";
        break;
    }

    if(array_contains_key(kill_bits, var_d29889468d853030)) {
      kill_bit = function_6d40f12a09494350(kill_bit, kill_bits[var_d29889468d853030]);
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, var_800fb1078b834513), kill_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid];

      if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
        callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
      }

      if(istrue(var_5670f984dc9565b5)) {
        challenges::function_fee0bee456eac877(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, var_800fb1078b834513), kill_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid]);
      }
    }
  }
}

function function_d89978ce1f60dfc() {
  if(isarray(level.var_adeac835ef495aab) && level.var_adeac835ef495aab.size > 0) {
    return level.var_adeac835ef495aab;
  }

  interact_bits = [];
  interact_bits["wallbuy_purchase"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"wallbuy_purchase");
  interact_bits["magicbox_purchase"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"magicbox_purchase");
  interact_bits["pap_purchase_level_1"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pap_purchase_level_1");
  interact_bits["pap_purchase_level_2"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pap_purchase_level_2");
  interact_bits["pap_purchase_level_3"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pap_purchase_level_3");
  interact_bits["pickup_ava_intel_from_aether_nest"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pickup_ava_intel_from_aether_nest");
  interact_bits["pickup_ava_intel_from_frenzied_guard_special_elite"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pickup_ava_intel_from_frenzied_guard_special_elite");
  interact_bits["pickup_ava_intel_from_soldier"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pickup_ava_intel_from_soldier");
  interact_bits["pickup_ava_intel_by_armored_zombie"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pickup_ava_intel_by_armored_zombie");
  interact_bits["pickup_item_from_crystal"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pickup_item_from_crystal");
  interact_bits["destroy_crystal_vehicle"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"destroy_crystal_vehicle");
  interact_bits["cryofreeze_hit_hellhound"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"cryofreeze_hit_hellhound");
  interact_bits["cryofreeze_hit_zombie"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"cryofreeze_hit_zombie");
  interact_bits["frost_blast_freeze_mimic"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"frost_blast_freeze_mimic");
  interact_bits["frost_blast_freeze_zombie"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"frost_blast_freeze_zombie");
  interact_bits["enegry_mine_destroy_vehicle"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"enegry_mine_destroy_vehicle");
  interact_bits["shatterblast_obtain"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"shatterblast_obtain");
  interact_bits["shatterblast_destroy_armor"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"shatterblast_destroy_armor");
  interact_bits["healing_aura_heal"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"healing_aura_heal");
  interact_bits["tesla_storm_stun_soldier"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"tesla_storm_stun_soldier");
  interact_bits["pickup_keycard_from_convoy"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pickup_keycard_from_convoy");
  interact_bits["deadwire_proc"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"deadwire_proc");
  interact_bits["napalmburst_proc"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"napalmburst_proc");
  interact_bits["brainrot_proc"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"brainrot_proc");
  interact_bits["deadwire_stun_special"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"deadwire_stun_special");
  interact_bits["napalmburst_special_proc"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"napalmburst_special_proc");
  interact_bits["direct_line_ping"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"direct_line_ping");
  interact_bits["direct_line_activity_complete"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"direct_line_activity_complete");
  interact_bits["vehicle_tire_repair"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"vehicle_tire_repair");
  interact_bits["turret_trap_ammoMod"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"hash_feb08ead2a3ba075");
  interact_bits["aether_sabotage_completed"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"aether_sabotage_completed");
  interact_bits["loaded_helicopter_destroyed"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"hash_288723b94e2627d0");
  interact_bits["loot_merc_camps"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"loot_merc_camps");
  interact_bits["pickup_gas_mask"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"pickup_gas_mask");
  interact_bits["maintain_escort_health"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"maintain_escort_health");
  interact_bits["heli_chase_destroy"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"heli_chase_destroy");
  interact_bits["drink_gas_station_perk"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"drink_gas_station_perk");
  interact_bits["energy_mine_stop_convoy"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"energy_mine_stop_convoy");
  interact_bits["crate_looted"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"crate_looted");
  interact_bits["jup_strauss_research_tablet"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"hash_f245aa8279cf6615");
  interact_bits["perk_drank"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"perk_drank");
  interact_bits["magicbox_legendary_ww_pickup"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"magicbox_legendary_ww_pickup");
  interact_bits["befriend_hellish_companion"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"befriend_hellish_companion");
  interact_bits["flesh_chunk_sold"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"flesh_chunk_sold");
  interact_bits["schematic_juggernog_bigbounty"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"schematic_juggernog_bigbounty");
  interact_bits["schematic_quickrevive_revive"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"schematic_quickrevive_revive");
  interact_bits["use_acquisitions_thirty"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"use_acquisitions_thirty");
  interact_bits["loot_cache_looted"] = function_e2ff8f4b4e94f723(#"hash_2b9333cc10a910d9", #"loot_cache_looted");
  level.var_adeac835ef495aab = interact_bits;
  return interact_bits;
}

function function_cde7564c165a0bf1() {
  if(isarray(level.var_c4b0e79d3e523e7b) && level.var_c4b0e79d3e523e7b.size > 0) {
    return level.var_c4b0e79d3e523e7b;
  }

  var_a9f49527ae46e371 = [];
  var_a9f49527ae46e371["cargo_vehicle_scuttle"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"cargo_vehicle_scuttle");
  var_a9f49527ae46e371["safe_drill_no_pause"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"safe_drill_no_pause");
  var_a9f49527ae46e371["used_stronghold_key"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"used_stronghold_key");
  var_a9f49527ae46e371["stronghold_special_intel"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"stronghold_special_intel");
  var_a9f49527ae46e371["stronghold_safe_opened"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"stronghold_safe_opened");
  var_a9f49527ae46e371["zombie_stronghold_intel_tablet_collected"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"zombie_stronghold_intel_tablet_collected");
  var_a9f49527ae46e371["loot_harvester_orb_end"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"loot_harvester_orb_end");
  var_a9f49527ae46e371["maintain_computer_health"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"maintain_computer_health");
  var_a9f49527ae46e371["precision_airstrike_merc_camp"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"precision_airstrike_merc_camp");
  var_a9f49527ae46e371["precision_airstrike_merc_convoy"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"precision_airstrike_merc_convoy");
  var_a9f49527ae46e371["redeploy_drone_region"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"redeploy_drone_region");
  var_a9f49527ae46e371["outlast_pnd_no_pause"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"outlast_pnd_no_pause");
  var_a9f49527ae46e371["outlast_space_entered"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"outlast_space_entered");
  var_a9f49527ae46e371["pickup_ava_tablet_from_outlast"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"pickup_ava_tablet_from_outlast");
  var_a9f49527ae46e371["aether_extractor_destroy"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"aether_extractor_destroy");
  var_a9f49527ae46e371["aether_extractor_pickup_container"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"aether_extractor_pickup_container");
  var_a9f49527ae46e371["activate_uav_tower_ava"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"activate_uav_tower_ava");
  var_a9f49527ae46e371["locate_ava"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"locate_ava");
  var_a9f49527ae46e371["defend_ava"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"defend_ava");
  var_a9f49527ae46e371["escape_with_ava"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"escape_with_ava");
  var_a9f49527ae46e371["destroy_sam_shepherd"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"destroy_sam_shepherd");
  var_a9f49527ae46e371["secure_airdrop_shepherd"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"secure_airdrop_shepherd");
  var_a9f49527ae46e371["escort_vehicle_shepherd"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"escort_vehicle_shepherd");
  var_a9f49527ae46e371["defend_escort_shepherd"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"defend_escort_shepherd");
  var_a9f49527ae46e371["clear_zombies_mercs_zakhaev"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"hash_889cc431b3eb5887");
  var_a9f49527ae46e371["place_explosive_zakhaev"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"place_explosive_zakhaev");
  var_a9f49527ae46e371["clear_stronghold_zakhaev"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"clear_stronghold_zakhaev");
  var_a9f49527ae46e371["defend_scrambler_zakhaev"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"defend_scrambler_zakhaev");
  var_a9f49527ae46e371["defeat_worm_zakhaev"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"defeat_worm_zakhaev");
  var_a9f49527ae46e371["spore_regen_denied"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"spore_regen_denied");
  var_a9f49527ae46e371["aether_storm_entered"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"aether_storm_entered");
  var_a9f49527ae46e371["aether_storm_special_intel_collected"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"aether_storm_special_intel_collected");
  var_a9f49527ae46e371["heli_destroyed"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"heli_destroyed");
  var_a9f49527ae46e371["gunship_commander_destroy"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"gunship_commander_destroy");
  var_a9f49527ae46e371["pickup_essence_bazaar"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"pickup_essence_bazaar");
  var_a9f49527ae46e371["pickup_essence_shops"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"pickup_essence_shops");
  var_a9f49527ae46e371["pickup_essence_retail"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"pickup_essence_retail");
  var_a9f49527ae46e371["s1_mi_invest_rift"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"s1_mi_invest_rift");
  var_a9f49527ae46e371["s1_mi_destroy_seals"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"s1_mi_destroy_seals");
  var_a9f49527ae46e371["s1_mi_escape_to_beach"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"s1_mi_escape_to_beach");
  var_a9f49527ae46e371["s1_mi_defeat_worm"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"s1_mi_defeat_worm");
  var_a9f49527ae46e371["s1_mi_leave_rift"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"s1_mi_leave_rift");
  var_a9f49527ae46e371["s1_rift_mission_complete"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"s1_rift_mission_complete");
  var_a9f49527ae46e371["s1_rift_gate_unlock"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"s1_rift_gate_unlock");
  var_a9f49527ae46e371["punched_deathworm"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"punched_deathworm");
  var_a9f49527ae46e371["schematic_elementalpop_proc"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"schematic_elementalpop_proc");
  var_a9f49527ae46e371["cyst_kill_death_perception"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"cyst_kill_death_perception");
  var_a9f49527ae46e371["merc_camp_recon_destroyed"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"merc_camp_recon_destroyed");
  var_a9f49527ae46e371["powerup_nuke_pickup"] = function_e2ff8f4b4e94f723(#"hash_b431eec04f47bf51", #"powerup_nuke_pickup");
  level.var_c4b0e79d3e523e7b = var_a9f49527ae46e371;
  return var_a9f49527ae46e371;
}

function function_cde7554c165a09be() {
  if(isarray(level.var_c4b0e69d3e523c48) && level.var_c4b0e69d3e523c48.size > 0) {
    return level.var_c4b0e69d3e523c48;
  }

  var_a9f49427ae46e13e = [];
  var_a9f49427ae46e13e["s2_rift_gate_unlock"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_rift_gate_unlock");
  var_a9f49427ae46e13e["s2_rift_mission_complete"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_rift_mission_complete");
  var_a9f49427ae46e13e["s2_mi_invest_rift"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_invest_rift");
  var_a9f49427ae46e13e["s2_mi_rescue_toc"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_rescue_toc");
  var_a9f49427ae46e13e["s2_mi_transport_acv"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_transport_acv");
  var_a9f49427ae46e13e["s2_mi_fix_disruption"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_fix_disruption");
  var_a9f49427ae46e13e["s2_mi_rescue_companion"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_rescue_companion");
  var_a9f49427ae46e13e["s2_mi_charge_acv"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_charge_acv");
  var_a9f49427ae46e13e["s2_mi_survive_encounter"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_survive_encounter");
  var_a9f49427ae46e13e["s2_mi_escape_rift"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s2_mi_escape_rift");
  var_a9f49427ae46e13e["s3_rift_gate_unlock"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_rift_gate_unlock");
  var_a9f49427ae46e13e["s3_rift_mission_complete"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_rift_mission_complete");
  var_a9f49427ae46e13e["s3_mi_invest_rift"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_invest_rift");
  var_a9f49427ae46e13e["s3_mi_follow_jansen"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_follow_jansen");
  var_a9f49427ae46e13e["s3_mi_shatter_crystals"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_shatter_crystals");
  var_a9f49427ae46e13e["s3_mi_locate_jansen"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_locate_jansen");
  var_a9f49427ae46e13e["s3_mi_investigate_relic"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_investigate_relic");
  var_a9f49427ae46e13e["s3_mi_jansen_float"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_jansen_float");
  var_a9f49427ae46e13e["s3_mi_cleanse_relics"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_cleanse_relics");
  var_a9f49427ae46e13e["s3_mi_defeat_champion"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_defeat_champion");
  var_a9f49427ae46e13e["s3_mi_investigate_orbs"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_defeat_champion");
  var_a9f49427ae46e13e["s3_mi_assist_jansen"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_assist_jansen");
  var_a9f49427ae46e13e["s3_mi_escape_rift"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s3_mi_escape_rift");
  var_a9f49427ae46e13e["s4_unstable_rift_complete"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s4_unstable_rift_complete");
  var_a9f49427ae46e13e["s5_rift_gate_unlock"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s5_rift_gate_unlock");
  var_a9f49427ae46e13e["s5_rift_mission_complete"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s5_rift_mission_complete");
  var_a9f49427ae46e13e["s5_mi_invest_rift"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s5_mi_invest_rift");
  var_a9f49427ae46e13e["s5_mi_escape_rift"] = function_e2ff8f4b4e94f723(#"hash_b431edc04f47bd9e", #"s5_mi_escape_rift");
  level.var_c4b0e69d3e523c48 = var_a9f49427ae46e13e;
  return var_a9f49427ae46e13e;
}

function function_f10f600ac4ee4c09(var_e8046e3623e8effe, var_f2b106a03cdbf1, var_5670f984dc9565b5) {
  if(!isDefined(var_f2b106a03cdbf1)) {
    var_f2b106a03cdbf1 = 1;
  }

  if(!isDefined(var_5670f984dc9565b5)) {
    var_5670f984dc9565b5 = 1;
  }

  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"ob_interact";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();

  if(isDefined(aeeventid)) {
    interact_bits = [];
    var_ff89a661dac34339 = "";
    interact_bit = 0;

    switch (var_f2b106a03cdbf1) {
      case 1:
        interact_bits = function_d89978ce1f60dfc();
        var_ff89a661dac34339 = #"hash_2b9333cc10a910d9";
        break;
      case 2:
        interact_bits = function_cde7564c165a0bf1();
        var_ff89a661dac34339 = #"hash_b431eec04f47bf51";
        break;
      case 3:
        interact_bits = function_cde7554c165a09be();
        var_ff89a661dac34339 = #"hash_b431edc04f47bd9e";
        break;
      default:
        interact_bits = function_d89978ce1f60dfc();
        var_ff89a661dac34339 = #"hash_2b9333cc10a910d9";
        break;
    }

    if(array_contains_key(interact_bits, var_e8046e3623e8effe)) {
      interact_bit = function_6d40f12a09494350(interact_bit, interact_bits[var_e8046e3623e8effe]);
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, var_ff89a661dac34339), interact_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

      if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
        callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
      }

      if(istrue(var_5670f984dc9565b5)) {
        challenges::function_fee0bee456eac877(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, var_ff89a661dac34339), interact_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype]);
      }
    }
  }
}

function function_2647e6d2c835793e() {
  if(isarray(level.var_aaf1e130f5165019) && level.var_aaf1e130f5165019.size > 0) {
    return level.var_aaf1e130f5165019;
  }

  var_e6a72373966a02cc = [];
  var_e6a72373966a02cc["jup_schematic_speedcola"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_d0f2aef4eafb7cb8");
  var_e6a72373966a02cc["jup_schematic_juggernog"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_f4cd7510d63d0f6a");
  var_e6a72373966a02cc["jup_schematic_staminup"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_f1c9e6cd47be4f27");
  var_e6a72373966a02cc["jup_schematic_ammo_cryofreeze"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_60664ebd2a0f163e");
  var_e6a72373966a02cc["jup_schematic_deadshot"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_1f37a7272aecfbe6");
  var_e6a72373966a02cc["jup_schematic_quickrevive"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_f47f1141ed38094");
  var_e6a72373966a02cc["jup_schematic_elementalpop"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_d95c0afa6378870");
  var_e6a72373966a02cc["jup_schematic_phdflopper"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_9aafbe7ae04e2500");
  var_e6a72373966a02cc["jup_schematic_deathperception"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_204a269c7e66f26c");
  var_e6a72373966a02cc["jup_schematic_tombstone"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_1ab75fcce3b54279");
  var_e6a72373966a02cc["jup_schematic_ammo_deadwire"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_e56c1fcc36b6a733");
  var_e6a72373966a02cc["jup_schematic_ammo_napalm"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_debd36a473f74204");
  var_e6a72373966a02cc["jup_schematic_ammo_brainrot"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_2727de000a800334");
  var_e6a72373966a02cc["jup_schematic_ammo_shatter"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_3646e7f9447b7cca");
  var_e6a72373966a02cc["jup_schematic_case_dg2"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_3d6e5a0e94a252e2");
  var_e6a72373966a02cc["jup_schematic_case_raygun"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_f8ea41787f2487f9");
  var_e6a72373966a02cc["jup_schematic_case_plasmagun"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_ecc602c881811bb1");
  var_e6a72373966a02cc["jup_schematic_aecrystal_1"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_37757eb54f3cc475");
  var_e6a72373966a02cc["jup_schematic_aecrystal_2"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_44647ffb162dc04c");
  var_e6a72373966a02cc["jup_schematic_aecrystal_3"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_5df2c1bc2f02616a");
  var_e6a72373966a02cc["jup_schematic_aetool_uncomm"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_9497a27d8fc155a6");
  var_e6a72373966a02cc["jup_schematic_aetool_rare"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_b823ef263ffd4fc0");
  var_e6a72373966a02cc["jup_schematic_aetool_epic"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_f02f95884a581d5f");
  var_e6a72373966a02cc["jup_schematic_aetool_lege"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_dc9f33d810173aa9");
  var_e6a72373966a02cc["jup_schematic_classified_bloodburner"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_da8e652e39d6b5fe");
  var_e6a72373966a02cc["jup_schematic_classified_golden_armor_plate"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_85a88c5b64999a7");
  var_e6a72373966a02cc["jup_schematic_classified_dog_bone"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_252abcfeac8c1933");
  var_e6a72373966a02cc["jup_schematic_classified_aetherblade"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_9c6b1915c323c0d5");
  var_e6a72373966a02cc["jup_schematic_classified_golden_ammo"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_e30781d9e7408550");
  var_e6a72373966a02cc["direct_line_exfil"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"direct_line_exfil");
  var_e6a72373966a02cc["jup_obloot_quest_a2t4_container"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"hash_85664cfd5cb98224");
  var_e6a72373966a02cc["exfil_success"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"exfil_success");
  var_e6a72373966a02cc["exfil_schematic"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"exfil_schematic");
  var_e6a72373966a02cc["five_contracts_completed"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"five_contracts_completed");
  var_e6a72373966a02cc["contracts_all_regions"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"contracts_all_regions");
  var_e6a72373966a02cc["never_downed"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"never_downed");
  var_e6a72373966a02cc["exfil_acquisition"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"exfil_acquisition");
  var_e6a72373966a02cc["exfil_pap_legendary_weapons"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"exfil_pap_legendary_weapons");
  var_e6a72373966a02cc["exfil_three_schematics"] = function_e2ff8f4b4e94f723(#"hash_8a4cf5bfff2c6109", #"exfil_three_schematics");
  level.var_aaf1e130f5165019 = var_e6a72373966a02cc;
  return var_e6a72373966a02cc;
}

function function_4f87d9f22ebe1197() {
  var_63c0537a30bfebdc = [];
  var_63c0537a30bfebdc[var_63c0537a30bfebdc.size] = "direct_line_exfil";
  var_63c0537a30bfebdc[var_63c0537a30bfebdc.size] = "exfil_success";
  return var_63c0537a30bfebdc;
}

function private function_7c8dbb063c0e860c(params) {
  if(isPlayer(self)) {
    wait 9;
    self.var_bee88b1ed3560170 = thread function_e783a5b7a0b0d983();
  }
}

function private function_70fef3c29291be77(params) {
  var_6d28db65431f615a = function_4f87d9f22ebe1197();
  var_76f28326961ae32d = [];

  if(isarray(var_6d28db65431f615a)) {
    foreach(challenge in var_6d28db65431f615a) {
      if(isDefined(challenge)) {
        if(challenge == "direct_line_exfil") {
          if(function_62b41959b3c5a9ca(self, 16937) && function_62b41959b3c5a9ca(self, 15725)) {
            function_d1142b1749e61e85(challenge);
          }

          continue;
        }

        function_d1142b1749e61e85(challenge);
      }
    }
  }

  if(isDefined(self.completedcontracts) && self.completedcontracts >= 5) {
    function_d1142b1749e61e85("five_contracts_completed");
  }

  if(!ent_flag_exist("downed_before_exfil")) {
    function_d1142b1749e61e85("never_downed");

    if(isDefined(self.var_5dd9b65d7da434e3) && self.var_5dd9b65d7da434e3.size >= 3) {
      function_d1142b1749e61e85("contracts_all_regions");
    }
  }

  if(istrue(self.var_820d7adde5a94ed7)) {
    function_d1142b1749e61e85("jup_obloot_quest_a2t4_container");
  }

  var_b01d4c5ede595f2e = currency::function_15975e20bbd2c824("essence");

  if(isDefined(var_b01d4c5ede595f2e)) {
    var_76f28326961ae32d[#"hash_c818f0081a5df0ba"] = var_b01d4c5ede595f2e;
  }

  essence_spent = 0;

  if(isDefined(self.pers["currency_spent"])) {
    essence_spent = self.pers["currency_spent"];
    var_76f28326961ae32d[#"essence_spent"] = essence_spent;
  }

  function_8f4f9e5b10af310d(#"zm_exfil", var_76f28326961ae32d);
}

function function_d1142b1749e61e85(var_c2004d6a416c93b9) {
  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"zm_exfil";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();
  var_cd903eafd4933a21 = [];

  if(isDefined(aeeventid)) {
    var_cd903eafd4933a21 = function_2647e6d2c835793e();
    var_aca4d8f379381e77 = 0;

    if(array_contains_key(var_cd903eafd4933a21, var_c2004d6a416c93b9)) {
      var_aca4d8f379381e77 = function_6d40f12a09494350(var_aca4d8f379381e77, var_cd903eafd4933a21[var_c2004d6a416c93b9]);
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_8a4cf5bfff2c6109"), var_aca4d8f379381e77, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

      if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
        callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
      }
    }
  }
}

function function_3053004c06f9c2ed(param) {
  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"zm_exfil";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();
  lootid = param.lootid;
  var_3586af2f3cced9c4 = param.ref;
  rarity = param.rarity;
  paplevel = param.paplevel;
  var_cd903eafd4933a21 = [];

  if(!isDefined(lootid)) {
    lootid = 0;
  }

  if(!isDefined(rarity)) {
    rarity = 0;
  }

  if(!isDefined(paplevel)) {
    paplevel = 0;
  }

  if(!isDefined(var_3586af2f3cced9c4)) {
    var_3586af2f3cced9c4 = 0;
  }

  gametype = challenges::function_68ffb11dc4c6b979(gametype, aeeventname);
  gamemode = challenges::function_68ffb11dc4c6b979(gamemode, aeeventname);
  lootid = challenges::function_68ffb11dc4c6b979(lootid, aeeventname);
  rarity = challenges::function_68ffb11dc4c6b979(rarity, aeeventname);
  paplevel = challenges::function_68ffb11dc4c6b979(paplevel, aeeventname);

  if(isDefined(aeeventid)) {
    var_cd903eafd4933a21 = function_2647e6d2c835793e();
    var_aca4d8f379381e77 = 0;
    var_aca4d8f379381e77 = function_6d40f12a09494350(var_aca4d8f379381e77, var_cd903eafd4933a21[var_3586af2f3cced9c4]);

    if(!array_contains_key(var_cd903eafd4933a21, var_3586af2f3cced9c4)) {
      var_aca4d8f379381e77 = 0;
    }

    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_8a4cf5bfff2c6109"), var_aca4d8f379381e77, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"zm_rarity"), rarity, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c1df2daa62247afe"), paplevel, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), lootid];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function private function_93a828d2f14b2a77(params) {
  if(!isDefined(params.lootid)) {
    return;
  }

  itembundlename = common_item::function_fc925a153c7fd55c(params.lootid);

  if(isDefined(itembundlename)) {
    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

    if(isDefined(itembundle)) {
      reportparams = spawnStruct();
      reportparams.lootid = params.lootid;
      reportparams.rarity = itembundle.rarity;
      reportparams.ref = itembundle.ref;
      function_3053004c06f9c2ed(reportparams);

      if(isDefined(itembundle.type) && itembundle.type == "schematic") {
        function_d1142b1749e61e85("exfil_schematic");

        if(!isDefined(self.var_bc212fd29900efbc)) {
          self.var_bc212fd29900efbc = 1;
        } else {
          self.var_bc212fd29900efbc++;

          if(self.var_bc212fd29900efbc >= 3) {
            function_d1142b1749e61e85("exfil_three_schematics");
          }
        }
      }

      if(istrue(itembundle.var_72340ceb276c0f64)) {
        function_d1142b1749e61e85("exfil_acquisition");
      }
    }
  }
}

function private function_1a63a8486a277ac8(params) {
  if(!isDefined(params.weapon)) {
    return;
  }

  weapon = params.weapon;
  rarity = namespace_736197e4d378b91b::function_75e73212bbe447d9(weapon);
  paplevel = pack_a_punch::get_pap_level(weapon);
  lootid = params.lootid;

  if(isDefined(rarity) && isDefined(paplevel) && isDefined(lootid)) {
    if(rarity >= 4 && paplevel == 3) {
      if(!isDefined(self.var_884d5b5d3e94747c)) {
        self.var_884d5b5d3e94747c = [];
      }

      self.var_884d5b5d3e94747c[lootid] = weapon;

      if(self.var_884d5b5d3e94747c.size == 2) {
        function_d1142b1749e61e85("exfil_pap_legendary_weapons");
      }
    }

    reportparams = spawnStruct();
    reportparams.lootid = lootid;
    reportparams.rarity = rarity;
    reportparams.paplevel = paplevel;
    function_3053004c06f9c2ed(reportparams);
  }

  if(isweapon(weapon)) {
    weaponlootid = weapon::function_89a83ae9a4c4142a(weapon);

    if(isDefined(weaponlootid) && isDefined(self.var_603a8aa6efd893c9) && isDefined(self.var_603a8aa6efd893c9[weaponlootid])) {
      weaponkills = self.var_603a8aa6efd893c9[weaponlootid];
      var_e26242d286b51615 = 100;

      if(weaponlootid == 11337) {
        var_e26242d286b51615 = 10;
      }

      if(isDefined(weaponkills) && weaponkills >= var_e26242d286b51615) {
        function_484194ec6ace15bb("kills_and_exfil", 1, 0, weapon);
      }
    }
  }
}

function function_569430d5aed94ffd() {
  if(isarray(level.var_f1828b269521df25) && level.var_f1828b269521df25.size > 0) {
    return level.var_f1828b269521df25;
  }

  var_f1828b269521df25 = [];
  var_f1828b269521df25["aethernest_completed"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"hash_523eb625a0f903bb");
  var_f1828b269521df25["merc_stronghold_completed"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_merc_stronhghold");
  var_f1828b269521df25["ob_harvester_orb"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_harvester_orb");
  var_f1828b269521df25["ob_zombie_stronghold_orange"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_zombie_stronghold_orange");
  var_f1828b269521df25["ob_armored_convoy"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_armored_convoy");
  var_f1828b269521df25["ob_gunship"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_gunship");
  var_f1828b269521df25["ob_merc_camp"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_merc_camp");
  var_f1828b269521df25["ob_merc_stronhghold"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_merc_stronhghold");
  var_f1828b269521df25["ob_harvester_orb_speedrun"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_harvester_orb_speedrun");
  var_f1828b269521df25["ob_zombie_stronghold"] = function_e2ff8f4b4e94f723(#"hash_152317d21c601575", #"ob_zombie_stronghold");
  level.var_f1828b269521df25 = var_f1828b269521df25;
  return var_f1828b269521df25;
}

function function_78816b77271b0f4e(var_41acd4d450f972a5) {
  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"end_activity";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();
  var_a172e130e75deb31 = function_569430d5aed94ffd();
  activity_bit = 0;

  if(array_contains_key(var_a172e130e75deb31, var_41acd4d450f972a5)) {
    activity_bit = function_6d40f12a09494350(activity_bit, var_a172e130e75deb31[var_41acd4d450f972a5]);
    params = [function_d6f771aedba70ce7(aeeventname, #"hash_152317d21c601575"), activity_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function function_82d4524b2566958a() {
  if(isarray(level.var_57493830ad320944) && level.var_57493830ad320944.size > 0) {
    return level.var_57493830ad320944;
  }

  var_57493830ad320944 = [];
  var_57493830ad320944["weapons_stash_looted"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"ob_weapons_stash");
  var_57493830ad320944["bounty_hunter_complete_green"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"hash_e410c12d3edc0f1");
  var_57493830ad320944["bounty_hunter_complete_yellow"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"hash_d9fd21fa744d244e");
  var_57493830ad320944["bounty_hunter_complete_orange"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"hash_d21fcdb5cdfb6580");
  var_57493830ad320944["spore_control_completed"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"hash_10f69eb4e0309664");
  var_57493830ad320944["ob_cargo_delivery"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"ob_cargo_delivery");
  var_57493830ad320944["escort_zombie_completed"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"ob_escort");
  var_57493830ad320944["ob_weapons_stash"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"ob_weapons_stash");
  var_57493830ad320944["ob_merc_defend"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"ob_merc_defend");
  var_57493830ad320944["contract_region_red"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"contract_region_red");
  var_57493830ad320944["zero_damage_taken"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"zero_damage_taken");
  var_57493830ad320944["contract_region_green"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"contract_region_green");
  var_57493830ad320944["contract_region_yellow"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"contract_region_yellow");
  var_57493830ad320944["six_player_squad"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"six_player_squad");
  var_57493830ad320944["contract_general_speedrun"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"contract_general_speedrun");
  var_57493830ad320944["rift_run_contract_completed"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"rift_run_contract_completed");
  var_57493830ad320944["rift_run_hard_contract_completed"] = function_e2ff8f4b4e94f723(#"hash_8b2d3cef621fca38", #"rift_run_hard_contract_completed");
  level.var_57493830ad320944 = var_57493830ad320944;
  return var_57493830ad320944;
}

function function_9db4c37d4f1415f(var_5b84ea62d085c322, season) {
  if(!isDefined(season)) {
    season = 0;
  }

  if(!isPlayer(self)) {
    return;
  }

  aeeventname = #"contract_end";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  gamemode = challenges::getchallengegamemode(self);
  gametype = challenges::function_17c5d7feb226e256();
  var_4ecb199c4c868fce = season;
  var_be5e44033dbc0348 = function_82d4524b2566958a();
  contract_bit = 0;

  if(array_contains_key(var_be5e44033dbc0348, var_5b84ea62d085c322)) {
    contract_bit = function_6d40f12a09494350(contract_bit, var_be5e44033dbc0348[var_5b84ea62d085c322]);
    self function_db073176839d77fb(aeeventid, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_8b2d3cef621fca38"), contract_bit, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"season"), var_4ecb199c4c868fce]);
  }
}

function private function_53f4bb14857d9b44(str_id, func) {
  if(!isDefined(level.var_9dd45392c2bffc71)) {
    level.var_9dd45392c2bffc71 = [];
  }

  level.var_9dd45392c2bffc71[str_id] = func;
}

function private on_zombie_ai_spawned(sparams) {
  if(isDefined(self.subclass) && (self.subclass == "zombie_hellhound" || self.subclass == "zombie_base" || self.subclass == "zombie_base_armored_heavy" || self.subclass == "zombie_base_armored_light") || self.subclass == "zombie_mimic") {
    thread function_147cc8860b90f396();
  }

  if(isDefined(self.subclass) && (self.subclass == "zombie_base_armored_heavy" || self.subclass == "zombie_base_armored_light")) {
    callback::add("metabone_destroyed", &function_5fa99f9f82669144);
  }
}

function private function_147cc8860b90f396() {
  level endon("game_ended");
  self endon("death");

  while(isagent(self)) {
    self waittill("start_status_effects_monitor");
    waitframe();

    if(ent_flag("frost_blast_active")) {
      function_648b4b8e2ec610d8();
    }
  }
}

function private function_73246c2cbf5948fb(params) {
  if(isDefined(self.var_fb0325e04fae6ce8) && !istrue(self.var_7bae08b99e089ca4)) {
    self.var_7bae08b99e089ca4 = 1;
    var_e8046e3623e8effe = "cryofreeze_hit_zombie";

    if(self.subclass == "zombie_hellhound") {
      var_e8046e3623e8effe = "cryofreeze_hit_hellhound";
    }

    self.var_fb0325e04fae6ce8 function_f10f600ac4ee4c09(var_e8046e3623e8effe);
  }
}

function private function_648b4b8e2ec610d8() {
  if(isDefined(self.var_fb0325e04fae6ce8) && !isDefined(self.var_a15161793868922)) {
    self.var_a15161793868922 = 1;
    var_e8046e3623e8effe = "frost_blast_freeze_zombie";

    if(self.subclass == "zombie_mimic") {
      var_e8046e3623e8effe = "frost_blast_freeze_mimic";
    }

    self.var_fb0325e04fae6ce8 function_f10f600ac4ee4c09(var_e8046e3623e8effe);
  }
}

function private function_5fa99f9f82669144(sparams) {
  if(isPlayer(sparams.eattacker) && ent_flag("shatterblast_damaged_armor") && !istrue(self.var_62b7c7f34c3ca8ff)) {
    if(!isDefined(sparams.eattacker.var_ed974fbcac8d27f5)) {
      sparams.eattacker.var_ed974fbcac8d27f5 = 0;
    }

    if(isDefined(sparams.eattacker.var_ed974fbcac8d27f5)) {
      sparams.eattacker.var_ed974fbcac8d27f5++;
    }

    sparams.eattacker function_f10f600ac4ee4c09("shatterblast_destroy_armor");
    self.var_62b7c7f34c3ca8ff = 1;

    if(function_18a53d77df35c4c9(sparams.eattacker, 14634) && !mod(sparams.eattacker.var_ed974fbcac8d27f5, 3)) {
      switch (self.subclass) {
        case #"hash_99a38be9e88b5244":
        case #"hash_f297af39454fdc7b":
          item = spawnnewitemfromscriptablesharedfunc("obloot_ava_intel_armored_zombie", self.origin, self.angles, 0, 1);

          if(isDefined(item)) {
            sparams.eattacker thread function_c537a191b851482f(item, "obloot_ava_intel_armored_zombie");
          }
        default:
          break;
      }
    }
  }
}

function function_c537a191b851482f(item, str_item) {
  itembundle = getscriptbundle("itemspawnentry:" + str_item);
  lootid = function_6d15e119c2779a93(itembundle);
  squad_members = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  foreach(member in squad_members) {
    member scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(14, item.origin, item.index, lootid);
  }
}

function private function_cf64989979528904() {
  function_f10f600ac4ee4c09("healing_aura_heal");
}

function private on_vehicle_spawned(sparams) {
  waitframe();
  vehicle = sparams.vehicle;

  if(!isDefined(vehicle.vehiclename)) {
    return;
  }

  switch (vehicle.vehiclename) {
    case #"hash_174ce9a6344b18a4":
    case #"hash_66c8846b85d8c948":
    case #"hash_6c8a74960d04b922":
    case #"hash_bc31095b59d83674":
    case #"hash_ca9945ca2bd4d081":
      if(!istrue(vehicle.var_4a4265af0a6f92e9)) {
        thread function_1ab983924d3621aa();
      }

      break;
  }

  scripts\mp\vehicles\damage::function_21a469b6e2805cf1(vehicle.vehiclename, &function_eef88565476a2f1a);
}

function private function_eef88565476a2f1a(data) {
  if(!isDefined(data) || !isDefined(data.attacker) || !isDefined(self)) {
    return;
  }

  if(ent_flag_exist("energy_mine_kill") && !istrue(self.var_f6517a11d37da125)) {
    data.attacker function_f10f600ac4ee4c09("enegry_mine_destroy_vehicle");
    self.var_f6517a11d37da125 = 1;
  }

  if(isDefined(data.inflictor) && isDefined(data.inflictor.streakinfo) && isDefined(data.inflictor.streakinfo.streakname)) {
    if(data.inflictor.streakinfo.streakname == "precision_airstrike" && ent_flag_exist("armored_convoy_spawned")) {
      data.attacker function_f10f600ac4ee4c09("precision_airstrike_merc_convoy", 2);
    }
  }

  if(isDefined(self.classname_mp) && isDefined(self.targetname) && isDefined(data.attacker)) {
    if(self.targetname == "veh_jup_blima_anim_infil") {
      data.attacker function_f10f600ac4ee4c09("loaded_helicopter_destroyed");
    }
  }

  if(istrue(self.isheli) && isDefined(data.attacker)) {
    data.attacker function_f10f600ac4ee4c09("heli_destroyed", 2);
  }

  if(isDefined(self.vehiclename) && isDefined(data.attacker) && self.vehiclename == "veh_jup_hind") {
    data.attacker function_f10f600ac4ee4c09("gunship_commander_destroy", 2);
  }

  if(isDefined(self.task) && isDefined(self.task.var_b189a678c1c3489a) && isDefined(self.task.var_b189a678c1c3489a.activity_instance) && isDefined(self.task.var_b189a678c1c3489a.activity_instance.type)) {
    if(self.task.var_b189a678c1c3489a.activity_instance.type == "REV_OB_VEHICLE_DRIVE" && self.spawndata.vehicletype == "veh_apache_mp_phys") {
      data.attacker function_f10f600ac4ee4c09("heli_chase_destroy");
      data.attacker function_f10f600ac4ee4c09("heli_destroyed", 2);
    }
  }

  if(ent_flag_exist("REV_OB_VEHICLE_DRIVE") && isDefined(data.attacker)) {
    player = data.attacker;

    if(ent_flag_exist("cargo_delivered")) {
      player function_f10f600ac4ee4c09("cargo_vehicle_scuttle", 2);
      ent_flag_clear("cargo_delivered", 1);
    }
  }
}

function private function_c2fa6446b3ec956f(params) {
  if(!isDefined(self)) {
    return;
  }

  if(ent_flag_exist("REV_OB_VEHICLE_DRIVE") && isarray(self.attackerdata)) {
    foreach(playerstruct in self.attackerdata) {
      if(ent_flag_exist("cargo_delivered") && isDefined(playerstruct) && isDefined(playerstruct.attacker)) {
        playerstruct.attacker function_f10f600ac4ee4c09("cargo_vehicle_scuttle", 2);
        ent_flag_clear("cargo_delivered", 1);
      }
    }
  }
}

function private on_vehicle_refueled(params) {
  if(isDefined(params.vehicle) && !isDefined(params.vehicle.var_317b653ebff8473a)) {
    params.player function_f10f600ac4ee4c09("drink_gas_station_perk");
    params.vehicle.var_317b653ebff8473a = 1;
  }

  params.player thread function_da06d69b0b66e612(16148, "quest_s0a1t3_restock_start");
}

function private function_4b8d35d7af7fd960(params) {
  function_f10f600ac4ee4c09("vehicle_tire_repair");
}

function private on_tacmap_ping_scriptable_or_ent(params) {
  if(isDefined(params) && isDefined(params.target)) {
    if(isDefined(params.target.activity_instance)) {
      function_f10f600ac4ee4c09("direct_line_ping");
    }
  }
}

function private function_4b0eddcc1928fa56(var_b381b0883bcd4847) {
  activity = self;
  playerlist = var_b381b0883bcd4847.playerlist;
  iscontract = 0;

  if(isDefined(activity.category)) {
    iscontract = activity.category == "Contract";
  }

  if(isDefined(playerlist) && isDefined(activity)) {
    foreach(player in playerlist) {
      if(istrue(iscontract)) {
        player function_f10f600ac4ee4c09("direct_line_activity_complete", 1, 0);

        if(isDefined(player.var_e4f61eff2606b60c) && istrue(player.var_e4f61eff2606b60c)) {
          player function_9db4c37d4f1415f("zero_damage_taken");
        }

        if(isDefined(playerlist.size) && playerlist.size >= 6) {
          player function_9db4c37d4f1415f("six_player_squad");
        }

        if(isDefined(activity.starttime) && abs(activity.starttime - gettime()) <= 180000) {
          player function_9db4c37d4f1415f("contract_general_speedrun");
        }

        if(isfunction(level.var_fac39a693f085779)) {
          difficulty_region = [[level.var_fac39a693f085779]](namespace_4fda5d7358015a06::function_8988a4c89289d7f4(activity));

          if(!isDefined(player.var_5dd9b65d7da434e3)) {
            player.var_5dd9b65d7da434e3 = [];
          }

          switch (difficulty_region) {
            case #"hash_7bb2cd766703d463":
              player function_9db4c37d4f1415f("contract_region_green");
              player.var_5dd9b65d7da434e3["green"] = 1;

              if(isDefined(player.var_4b8e8742f0763613)) {
                player.var_4b8e8742f0763613.var_ae06e623319b2568 += level.gametypebundle.var_aaff84cee7edcbaf;
              }

              break;
            case #"hash_af83e47edfa8900a":
              player function_9db4c37d4f1415f("contract_region_yellow");
              player.var_5dd9b65d7da434e3["yellow"] = 1;

              if(isDefined(player.var_4b8e8742f0763613)) {
                player.var_4b8e8742f0763613.var_ae06e623319b2568 += level.gametypebundle.var_d54a02ac762f8ea8;
              }

              break;
            case #"hash_5343b465e56ec9a4":
              player function_9db4c37d4f1415f("contract_region_red");
              player.var_5dd9b65d7da434e3["orange"] = 1;

              if(isDefined(player.var_4b8e8742f0763613)) {
                player.var_4b8e8742f0763613.var_ae06e623319b2568 += level.gametypebundle.var_be8f52532f236cf2;
              }

              break;
            case #"hash_651f76c0ad6741ec":
              player function_9db4c37d4f1415f("contract_region_darkaether");

              if(isDefined(player.var_4b8e8742f0763613)) {
                player.var_4b8e8742f0763613.var_ae06e623319b2568 += level.gametypebundle.var_be8f52532f236cf2;
              }

              break;
            default:
              break;
          }
        }

        if(!isDefined(player.completedcontracts)) {
          player.completedcontracts = 0;
        }

        player.completedcontracts++;
        player challenges::oncontractend(1, 1, 1);
      }

      switch (activity.type) {
        case #"hash_5253ef0f4683b778":
          params = spawnStruct();
          params.activity_instance = activity;
          player function_7fab27036d043e38(params);

          if(player scripts\cp_mp\zombie_perks::has_perk("specialty_juggernog")) {
            player function_f10f600ac4ee4c09("schematic_juggernog_bigbounty", 1, 0);
          }

          break;
        case #"hash_427820bb3395e2bf":
          player function_9db4c37d4f1415f("spore_control_completed");
          timespent = abs(activity.starttime - gettime());

          if(timespent < 150000) {
            player function_f10f600ac4ee4c09("spore_regen_denied", 2, 0);
            player thread function_da06d69b0b66e612(16640, "quest_s0a2t5_extr_success");
          }

          break;
        case #"hash_5191681fd986c4eb":
          player function_9ef71ee9309e7fcb();
          player function_f10f600ac4ee4c09("aether_sabotage_completed", 1, 0);
          break;
        case #"hash_18347fa7b15eb832":
          player function_78816b77271b0f4e("ob_merc_camp");
          break;
        case #"hash_bcceffcc02978e65":
          player function_9db4c37d4f1415f("ob_weapons_stash");
          break;
        case #"hash_f0f77ef6300b1970":
          player function_78816b77271b0f4e("aethernest_completed");
          break;
        case #"hash_40d422a1ae5ecf0f":
          player function_9db4c37d4f1415f("escort_zombie_completed");

          if(isDefined(activity.vh_escort)) {
            var_1d41f01d9ef686fa = player getclientomnvar("ui_br_objective_progress_bar");

            if(isDefined(var_1d41f01d9ef686fa)) {
              if(var_1d41f01d9ef686fa >= 50) {
                player function_f10f600ac4ee4c09("maintain_escort_health", 1, 0);
              }
            }
          }

          break;
        case #"hash_b034a4d29df58c9a":
          player function_9db4c37d4f1415f("ob_merc_defend");
          var_f6225ddf8978c5fb = player getclientomnvar("ui_br_objective_param");

          if(isDefined(var_f6225ddf8978c5fb)) {
            if(var_f6225ddf8978c5fb >= 60) {
              player function_f10f600ac4ee4c09("maintain_computer_health", 2, 0);
            }
          }

          break;
        case #"hash_113756c907deb5be":
          player function_9db4c37d4f1415f("ob_cargo_delivery");
          break;
        case #"hash_bc2e36acd99d4454":
          player function_78816b77271b0f4e("ob_harvester_orb");

          if(isDefined(activity.var_f3da409905b9608a) && activity.var_f3da409905b9608a < 45) {
            player function_78816b77271b0f4e("ob_harvester_orb_speedrun");
          }

          break;
        case #"hash_cf6a24d2fd4c1930":
          player function_78816b77271b0f4e("ob_zombie_stronghold");

          if(isfunction(level.var_fac39a693f085779)) {
            difficulty_region = [[level.var_fac39a693f085779]](namespace_4fda5d7358015a06::function_8988a4c89289d7f4(activity));

            if(difficulty_region == "difficulty_hard") {
              player function_78816b77271b0f4e("ob_zombie_stronghold_orange");
            }
          }

          break;
        case #"hash_17b1c4f2de901a59":
          if(isDefined(self.var_18aaec4c8e0a3ddf) && self.var_18aaec4c8e0a3ddf == 0) {
            player function_f10f600ac4ee4c09("outlast_pnd_no_pause", 2, 0);
          }

          player function_f10f600ac4ee4c09("outlast_space_entered", 2, 0);
          break;
        case #"hash_cf18a80d017267ca":
          player function_78816b77271b0f4e("ob_armored_convoy");
          break;
        case #"hash_2f4998a4a5760392":
          player function_78816b77271b0f4e("ob_gunship");
          break;
        case #"hash_84c8d0e39c86ae55":
          player function_f10f600ac4ee4c09("befriend_hellish_companion", 1, 0);
          break;
      }
    }
  }

  if(isDefined(activity) && isDefined(activity.unlockedby)) {
    foreach(player in activity.unlockedby) {
      switch (activity.type) {
        case #"hash_87fc920520ec2075":
          player function_78816b77271b0f4e("ob_merc_stronhghold");
          break;
      }
    }
  }
}

function private function_748c2bebf6e2765b(var_b381b0883bcd4847) {
  activity = self;
  playerlist = var_b381b0883bcd4847.playerlist;

  if(isDefined(playerlist) && isDefined(activity)) {
    foreach(player in playerlist) {
      switch (activity.type) {
        case #"hash_18347fa7b15eb832":
          player function_78816b77271b0f4e("ob_merc_camp");

          if(isDefined(player.var_e4f61eff2606b60c) && player.var_e4f61eff2606b60c == 1) {
            player function_9db4c37d4f1415f("zero_damage_taken");
          }

          break;
      }
    }
  }
}

function private function_16afc8d96fd3de0c(var_b381b0883bcd4847) {
  activity = self;
  playerlist = var_b381b0883bcd4847.playerlist;

  if(isDefined(activity)) {
    activity.starttime = gettime();

    foreach(player in playerlist) {
      player.var_e4f61eff2606b60c = 1;
    }

    if(isDefined(activity.unlockedby)) {
      foreach(player in activity.unlockedby) {
        switch (activity.type) {
          case #"hash_87fc920520ec2075":
            break;
        }
      }

      return;
    }

    switch (activity.type) {
      case #"hash_40d422a1ae5ecf0f":
        activity thread function_db6c1cb0e91c7041(playerlist);
        break;
      default:
        break;
    }
  }
}

function private function_3b2ed72578533fe0(var_b381b0883bcd4847) {
  activity = self;
  playerlist = var_b381b0883bcd4847.playerlist;
  joinreason = var_b381b0883bcd4847.playerjoinreason;

  if(isDefined(activity) && isDefined(activity.type) && isDefined(playerlist) && isDefined(joinreason)) {}
}

function private function_22de5391f273b6bf(params) {
  if(isDefined(self) && !isDefined(self.var_f3da409905b9608a)) {
    self.var_f3da409905b9608a = 0;
    thread function_ebbb949856b57930();
  }
}

function private function_ebbb949856b57930() {
  level endon("game_ended");
  self endon("harvesterorb_end");
  self endon("orb_cleaned_up");

  if(isDefined(self.var_f3da409905b9608a)) {
    while(self.var_f3da409905b9608a <= 45) {
      wait 1;
      self.var_f3da409905b9608a++;
    }
  }
}

function private function_7fab27036d043e38(params) {
  if(!isfunction(level.var_fac39a693f085779)) {
    return;
  }

  if(isDefined(params.activity_instance) && isDefined(params.activity_instance.ai_type)) {
    str_aitype = params.activity_instance.ai_type;

    switch (str_aitype) {
      case #"hash_57f1e1130e644c8e":
        function_9db4c37d4f1415f("bounty_hunter_complete_orange");
        break;
      case #"hash_d5d252eb91d1700b":
        function_9db4c37d4f1415f("bounty_hunter_complete_green");
        break;
      case #"hash_8b1acdb45ebb6052":
        function_9db4c37d4f1415f("bounty_hunter_complete_yellow");
        break;
      default:
        break;
    }
  }
}

function private function_625e98d18b3d55a2(params) {
  function_f10f600ac4ee4c09("turret_trap_ammoMod");
}

function private function_f6832a11ac7b3d16(var_b381b0883bcd4847) {
  activity = self;
  playerlist = activity.playerparticipants;

  if(isDefined(activity)) {
    foreach(player in playerlist) {
      player function_f10f600ac4ee4c09("outlast_space_entered", 2, 0);
    }
  }
}

function private function_948301ad97e24c18(params) {
  function_f10f600ac4ee4c09("activate_uav_tower_ava", 2);
}

function private function_a7cf9a60c8407c0(params) {
  function_f10f600ac4ee4c09("locate_ava", 2);
}

function private function_28c89f81cdaa9d97(params) {
  function_f10f600ac4ee4c09("defend_ava", 2);
}

function private function_2a7867137131b412(params) {
  function_f10f600ac4ee4c09("escape_with_ava", 2);
}

function private function_5f52ca88d2ee165(params) {
  function_f10f600ac4ee4c09("destroy_sam_shepherd", 2);
}

function private function_c3cb09ac0cc5bb8c(params) {
  function_f10f600ac4ee4c09("secure_airdrop_shepherd", 2);
}

function private function_5f4bea465b992020(params) {
  function_f10f600ac4ee4c09("escort_vehicle_shepherd", 2);
}

function private function_9cf351a917bdb260(params) {
  function_f10f600ac4ee4c09("defend_escort_shepherd", 2);
}

function private function_b08965cd9e357396(params) {
  function_f10f600ac4ee4c09("clear_zombies_mercs_zakhaev", 2);
}

function private function_7ddbc5d5709f0565(params) {
  function_f10f600ac4ee4c09("place_explosive_zakhaev", 2);
}

function private function_4dc500ccd9ff3cbc(params) {
  function_f10f600ac4ee4c09("clear_stronghold_zakhaev", 2);
}

function private function_6cfc34c8585e3810(params) {
  function_f10f600ac4ee4c09("defend_scrambler_zakhaev", 2);
}

function private function_bd6f213cdc70081(params) {
  function_f10f600ac4ee4c09("defeat_worm_zakhaev", 2);
}

function private function_654c053523c6f5f6(params) {
  function_f10f600ac4ee4c09("safe_drill_no_pause", 2);
}

function private function_f0156d5e3908b93b(params) {
  playerlist = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(isDefined(playerlist)) {
    foreach(player in playerlist) {
      player function_f10f600ac4ee4c09("pickup_ava_tablet_from_outlast", 2, 0);
      player.var_820d7adde5a94ed7 = 1;
    }
  }
}

function private function_98c3f4e720f6089c(params) {
  playerlist = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(isDefined(playerlist)) {
    foreach(player in playerlist) {
      if(player ent_flag("quest_s0a2t4_heist_extsuccess_conv")) {
        player thread function_da06d69b0b66e612(16445, "quest_s0a2t4_heist_cancollected_conv", 1);
      }

      player function_f10f600ac4ee4c09("aether_extractor_pickup_container", 2);
    }
  }
}

function private function_c170c9d5fe107d4c(var_b381b0883bcd4847) {
  activity = self;

  if(!isDefined(activity)) {
    return;
  }

  playerlist = activity.playerparticipants;

  if(isDefined(activity.unlockedby) && istrue(var_b381b0883bcd4847.safe.var_2091b0afd53afd0)) {
    playerlist = activity.unlockedby;
  }

  foreach(player in playerlist) {
    if(isDefined(var_b381b0883bcd4847) && isDefined(var_b381b0883bcd4847.safe)) {
      if(istrue(var_b381b0883bcd4847.safe.var_2091b0afd53afd0)) {
        player function_f10f600ac4ee4c09("stronghold_safe_opened", 2, 0);
      }

      if(istrue(var_b381b0883bcd4847.safe.var_10505f0fb3d81db4)) {
        player thread function_da06d69b0b66e612(16140, "quest_s0a1t5_raiders_start");
      }
    }
  }
}

function private function_438364b427391b60(var_b381b0883bcd4847) {
  activity = self;
  playerlist = activity.playerparticipants;

  if(isDefined(activity)) {
    foreach(player in playerlist) {
      player function_78816b77271b0f4e("ob_merc_stronhghold");
    }
  }
}

function private function_def7cd4658600e1a(params) {
  function_f10f600ac4ee4c09("perk_drank");

  if(!isDefined(params) || !isDefined(params.specialtyperk)) {
    return;
  }

  if(params.specialtyperk == "specialty_speedcola") {
    thread function_3115bc3519ac2ea1();
  }
}

function private function_6e7c3cd09cadb943(params) {
  if(isDefined(params) && isDefined(params.perk_machine) && isDefined(params.perk_machine.ingasstation)) {
    function_f10f600ac4ee4c09("drink_gas_station_perk");
    thread function_da06d69b0b66e612(16148, "quest_s0a1t3_restock_start");
  }
}

function private function_61691a3175d3e844(params) {
  if(isDefined(params.player) && istrue(params.player.var_f0571de00436dc5)) {
    params.player function_f10f600ac4ee4c09("redeploy_drone_region", 2);
  }
}

function private function_4f322f99eb988e83(params) {
  scriptable::scriptable_addusedcallbackbypart("redeploy_drone_interact", &function_7be71446bbc4e06f);
}

function function_7be71446bbc4e06f(instance, part, state, player, bautouse, usestring) {
  player.var_f0571de00436dc5 = 1;
  player thread function_df09572b35cbd84c();
}

function function_df09572b35cbd84c() {
  level endon("game_ended");
  self endon("death");
  wait 2;

  while(!self isonground()) {
    waitframe();
  }

  if(isDefined(self.var_f0571de00436dc5)) {
    self.var_f0571de00436dc5 = undefined;
  }
}

function function_4ffcd177964e72b2(params) {
  if(isDefined(params.player)) {
    params.player thread function_da06d69b0b66e612(17082, "quest_s0_a3t4_closetime_start");
    player = params.player;
    player ent_flag_init("in_radiation");
    player function_f10f600ac4ee4c09("aether_storm_entered", 2);
  }
}

function function_1fb60c4452a392c8(params) {
  if(isDefined(params.player)) {
    player = params.player;

    if(player ent_flag_exist("in_radiation")) {
      player ent_flag_clear("in_radiation", 1);
    }
  }
}

function function_b05b488b03740449(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  var_bfd8e1203313f055 = function_a7ea8cc17447e576(params);

  if(isDefined(var_bfd8e1203313f055.var_1863d82b6dd463a9)) {
    params.player thread function_da06d69b0b66e612(var_bfd8e1203313f055.mission_id, var_bfd8e1203313f055.var_1863d82b6dd463a9, undefined, 1);
  }
}

function function_a7ea8cc17447e576(params) {
  var_bfd8e1203313f055 = spawnStruct();

  switch (params.ammo_mod_name) {
    case #"hash_853faa00a9ff1020":
      var_bfd8e1203313f055.mission_id = 14960;
      var_bfd8e1203313f055.var_1863d82b6dd463a9 = undefined;
      break;
    case #"hash_fe0fd5228eda0f07":
      var_bfd8e1203313f055.mission_id = 14856;
      var_bfd8e1203313f055.var_1863d82b6dd463a9 = "quest_s0a1t3_freezbrn_start";
      break;
    case #"hash_afaaf053b2461f8a":
      var_bfd8e1203313f055.mission_id = 14994;
      var_bfd8e1203313f055.var_1863d82b6dd463a9 = undefined;
      break;
    case #"hash_4f5cd54aaf7f106":
      var_bfd8e1203313f055.mission_id = 14991;
      var_bfd8e1203313f055.var_1863d82b6dd463a9 = "quest_s0_a3t2_firestarter_start";
      break;
    case #"hash_41d942d30dd3f804":
      var_bfd8e1203313f055.mission_id = 14885;
      var_bfd8e1203313f055.var_1863d82b6dd463a9 = "quest_s0a1t5_blasted_start";
      break;
  }

  return var_bfd8e1203313f055;
}

function private on_super_ready(params) {
  if(isPlayer(params.player) && params.superref == "super_energy_mine") {
    params.player thread function_da06d69b0b66e612(14883, "quest_s0a1t3_bomb_start", undefined, 1);
  }
}

function function_a5e16566a91e9488(params) {
  if(isPlayer(params.player) && isDefined(params.superinfo)) {
    if(params.superinfo.staticdata.ref == "super_frost_blast") {
      params.player thread function_da06d69b0b66e612(16629, "quest_s0a2t5_frostbite_start", undefined, 1);
      return;
    }

    if(params.superinfo.staticdata.ref == "super_tesla_storm") {
      params.player thread function_da06d69b0b66e612(14975, "quest_s0_a3t2_ac_start", undefined, 1);
      return;
    }

    if(params.superinfo.staticdata.ref == "super_aether_shroud") {
      params.player thread function_da06d69b0b66e612(14976, "quest_s0_a3t2_ghosted_start", undefined, 1);
    }
  }
}

function function_3cde22ad6d42a269(params) {
  if(isPlayer(self)) {
    if(isDefined(params.streakname) && params.streakname == "precision_airstrike") {
      thread function_da06d69b0b66e612(17074, "quest_s0_a3t2_painttarget_start");
    }
  }
}

function function_c99db6b18ad62976(params) {
  if(isDefined(params.scoreevent) && params.scoreevent == "deadwire_aoe_kill" && isPlayer(self)) {
    thread function_da06d69b0b66e612(14994, "quest_s0_a2t2_shocked_start", undefined, 1);
  }
}

function on_exfil_exiting_ao(params) {
  if(isPlayer(self)) {
    if(!function_d1b7b365deeebee7()) {
      if(isDefined(params.s_exfil)) {
        thread namespace_9f6a961447bab709::function_36d898a4d1fd0a31(params.s_exfil);
      }
    }
  }
}

function on_outlast_start(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16822, "quest_s0a1t6_alab_outstart");
  }
}

function on_outlast_arrive(params) {
  if(isPlayer(self)) {
    played = thread function_da06d69b0b66e612(16822, "quest_s0a1t6_alab_outarrive");

    if(!istrue(played)) {
      thread function_da06d69b0b66e612(17090, "quest_s0_a3t4_hold_start");
    }
  }
}

function private on_outlast_progress_degrade(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16822, "quest_s0a1t6_alab_outprogressdegrade");
  }
}

function private on_approach_outlast_pnd(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16822, "quest_s0a1t6_alab_outapproachpnd");
  }
}

function private on_outlast_success(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16822, "quest_s0a1t6_alab_outsuccess", 1);
  }
}

function private on_abandon_outlast_contract(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16822, "quest_s0a1t6_alab_outcontractcancel");
  }
}

function on_approach_zm_stronghold(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(17086, "quest_s0_a3t4_springcln_start");
  }
}

function function_7f2dd34d9517d2c6(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(17077, "quest_s0_a3t2_crashburn_start");
  }
}

function private function_e783a5b7a0b0d983() {
  self endon("death");
  player = self;
  backpacksize = player scripts\cp_mp\loot\common_inventory::function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = player scripts\cp_mp\loot\common_inventory::function_d870b2c45335bd88(i);

    if(!isDefined(currentlootid) || currentlootid == 0) {
      continue;
    }

    switch (currentlootid) {
      case 29666:
        player thread function_b46c28df3a5f6156(17090, "quest_s0_a3t4_hold_success");
        return true;
    }
  }

  return false;
}

function private function_d1b7b365deeebee7() {
  self endon("death");
  player = self;
  backpacksize = player scripts\cp_mp\loot\common_inventory::function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = player scripts\cp_mp\loot\common_inventory::function_d870b2c45335bd88(i);

    if(!isDefined(currentlootid) || currentlootid == 0) {
      continue;
    }

    switch (currentlootid) {
      case 29660:
        player thread function_b46c28df3a5f6156(16132, "quest_s0a1t3_sabo_exfil");
        return true;
      case 29652:
        break;
      case 29662:
        break;
      case 29659:
        player thread function_b46c28df3a5f6156(16640, "quest_s0a2t5_extr_exfil_success");
        return true;
      case 29649:
        player thread function_b46c28df3a5f6156(17070, "quest_s0a3t1_s2fa_exfil");
        return true;
    }
  }

  if(function_62b41959b3c5a9ca(player, 16821)) {
    player thread function_b46c28df3a5f6156(16822, "quest_s0a1t6_alab_exfil");
    return true;
  }

  if(function_62b41959b3c5a9ca(player, 16937) && function_62b41959b3c5a9ca(player, 15725)) {
    player thread function_b46c28df3a5f6156(16939, "quest_s0a1t1_dlsuccess");
    return true;
  }

  return false;
}

function function_b46c28df3a5f6156(mission_id, var_4152d19cb7e28515, b_conv) {
  if(isDefined(level.var_7f1d1c7c6153a9bf)) {
    if([[level.var_7f1d1c7c6153a9bf]]()) {
      return 0;
    }
  }

  if(isPlayer(self)) {
    player = self;

    if(function_c7d3c1cb4a3958cf(player, mission_id) || getdvarint(@ "hash_7846a66ee6afec3e", 0)) {
      if(!player ent_flag(var_4152d19cb7e28515)) {
        player ent_flag_set(var_4152d19cb7e28515);

        if(istrue(b_conv)) {
          scripts\cp_mp\overlord::playconversation(var_4152d19cb7e28515, [player], undefined, 0);
        } else {
          scripts\cp_mp\overlord::playevent(var_4152d19cb7e28515, [player], undefined, undefined, 1);
        }

        return 1;
      }

      return 0;
    }
  }
}

function function_380c0caf9e64a771(squad) {
  if(function_f578373042c34e16(16939, "quest_s0a1t1_dlsuccess", squad)) {
    return true;
  }

  if(function_f578373042c34e16(16132, "quest_s0a1t3_sabo_exfil", squad)) {
    return true;
  }

  if(function_f578373042c34e16(16640, "quest_s0a2t5_extr_exfil_success", squad)) {
    return true;
  }

  if(function_f578373042c34e16(17070, "quest_s0a3t1_s2fa_exfil", squad)) {
    return true;
  }

  if(function_f578373042c34e16(16822, "quest_s0a1t6_alab_exfil", squad)) {
    return true;
  }

  return false;
}

function function_35b3a590197d97a6(player) {
  return istrue(player.var_bee88b1ed3560170);
}

function function_65ec7747ff7a397a(params) {
  if(isPlayer(params.attacker)) {
    params.attacker thread function_da06d69b0b66e612(14960, "quest_s0a2t5_mindctrl_start", undefined, 1);
  }
}

function function_979b0b77c84e497f(params) {
  if(isDefined(params.player)) {
    player = params.player;
    player endon("remove_super");
    player endon("death_or_disconnect");
    level endon("game_ended");
    player waittill("super_ready");
    super = player scripts\mp\supers::getcurrentsuper();

    if(isDefined(super) && isDefined(super.staticdata) && isDefined(super.staticdata.ref)) {
      switch (super.staticdata.ref) {
        case #"hash_25d6c8e468976601":
          params.superref = super.staticdata.ref;
          callback::callback("on_super_ready", params);
          break;
      }
    }
  }
}

function function_bcfb5a0e96552599() {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16130, "quest_s0a1t3_itsatrap_start");
  }
}

function function_1e972a37f996a61c(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16132, "quest_s0a1t3_saboteur_start");
  }
}

function function_ea321f874c7d825(params) {
  if(isPlayer(params.player)) {
    thread function_da06d69b0b66e612(15917, "quest_s0a1t3_6gst_start");
  }
}

function function_9fe3364da6f70780(params) {
  if(isPlayer(params.player) && isDefined(params.ref)) {
    squadmembers = params.player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    switch (params.ref) {
      case #"hash_b5dfe711233e9965":
        scripts\cp_mp\overlord::playconversation("quest_s0a1t1_complete", [params.player], undefined, 0);
        break;
      case #"hash_b5dfe511233e963f":
        scripts\cp_mp\overlord::playconversation("quest_s0a1t3_complete", squadmembers, undefined, 0);
        break;
      case #"hash_26dd8a57fed58730":
        scripts\cp_mp\overlord::playconversation("quest_s0a3t45_complete", squadmembers, undefined, 0);
        break;
      case #"hash_a3e2c43acf843284":
        scripts\cp_mp\overlord::playconversation("quest_s0a2t15_complete", squadmembers, undefined, 0);
        break;
      case #"hash_a3e2c73acf84373d":
        scripts\cp_mp\overlord::playconversation("quest_s0a2t25_complete", squadmembers, undefined, 0);
        break;
      case #"hash_a3e2c03acf842c38":
        scripts\cp_mp\overlord::playconversation("quest_s0a2t5_complete", squadmembers, undefined, 0);
        break;
      case #"hash_26dd9057fed590a2":
        scripts\cp_mp\overlord::playconversation("quest_s0a3t2_complete", squadmembers, undefined, 0);
        break;
      case #"hash_b5dfe311233e9319":
        scripts\cp_mp\overlord::playconversation("quest_s0a1t5_tiercomplete", squadmembers, undefined, 0);
        break;
      case #"hash_a3e2c63acf8435aa":
        scripts\cp_mp\overlord::playconversation("quest_s0a2t3_complete", squadmembers, undefined, 0);
        break;
    }
  }
}

function function_20a93cb9e4f580fe(params) {
  if(isPlayer(params.player) && isDefined(params.parentref) && isDefined(params.stepref)) {
    player = params.player;
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    if(params.parentref == "jup_ob_raiders_of_the_lost_arms_complete") {
      if(params.stepref == "jup_ob_loot_safes") {
        player.var_74d8dcd67ff30483 = "jup_ob_zombie_weapon_stash_kills";
        return;
      }

      if(params.stepref == "jup_ob_zombie_weapon_stash_kills") {
        player.var_74d8dcd67ff30483 = "jup_ob_loot_safes";
      }
    }
  }
}

function function_135da259745a566d(params) {
  if(isPlayer(params.player) && isDefined(params.ref)) {
    player = params.player;
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    scoreeventparams = spawnStruct();
    scoreeventparams.scoreevent = #"hash_6d940c2bed869116";
    player callback::callback("zombie_score_event", scoreeventparams);

    foreach(squadmember in squadmembers) {
      squadmember callback::callback("zombie_score_event", scoreeventparams);
    }

    var_faab44449b51b7af = getrandomnavpoint(player.origin, 128);
    powerups::function_c38c89a662ac4f51("free_perk", var_faab44449b51b7af);

    if(isDefined(level.var_7f1d1c7c6153a9bf)) {
      if([[level.var_7f1d1c7c6153a9bf]]()) {
        return;
      }
    }

    player notify("mission_completed");

    switch (params.ref) {
      case #"hash_bf1e6b896218cdb":
        scripts\cp_mp\overlord::playevent("quest_s0a1t3_freezbrn_success", [player], undefined, undefined, 1);
        break;
      case #"hash_8a462acade0f335":
        scripts\cp_mp\overlord::playevent("quest_s0a1t3_itsatrap_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_ce8a39861430c5a8":
        scripts\cp_mp\overlord::playevent("quest_s0a1t3_6gst_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_464392e7ead3c3e4":
        scripts\cp_mp\overlord::playevent("quest_s0a1t1_fpsuccess", [player], undefined, undefined, 1);
        break;
      case #"hash_30e76e472fb048c9":
        scripts\cp_mp\overlord::playevent("quest_s0a1t1_gmbl_success", [player], undefined, undefined, 1);
        break;
      case #"hash_f5926de8272ccb1c":
        scripts\cp_mp\overlord::playevent("quest_s0a1t1_rwsuccess", [player], undefined, undefined, 1);
        break;
      case #"hash_cf42a9d8fc805d2f":
        scripts\cp_mp\overlord::playevent("quest_s0a1t1_wpsuccess", [player], undefined, undefined, 1);
        break;
      case #"hash_e8628ada6c23b518":
        scripts\cp_mp\overlord::playevent("quest_s0a1t5_blasted_success", [player], undefined, undefined, 1);
        break;
      case #"hash_68a1047a927afa1e":
        scripts\cp_mp\overlord::playevent("quest_s0a1t5_chaperone_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_33ca1415455ce28c":
        scripts\cp_mp\overlord::playevent("quest_s0a1t5_bringemon_success", [player], undefined, undefined, 1);
        break;
      case #"hash_1d78519cac9a446b":
        scripts\cp_mp\overlord::playevent("quest_s0a1t5_handsoff_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_8fd365e3bdbfbd91":
        scripts\cp_mp\overlord::playevent("quest_s0a1t5_nestwrecker_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_ad60eaa0e207438d":
        scripts\cp_mp\overlord::playevent("quest_s0a2t3_essaether_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_a66e8b09b5bd2bb5":
        scripts\cp_mp\overlord::playevent("quest_s0a2t3_bountyhunt_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_b5dbe8aa3dccbcd4":
        scripts\cp_mp\overlord::playevent("quest_s0a2t3_firepower_success", [player], undefined, undefined, 1);
        break;
      case #"hash_c433b2f38213a21c":
        scripts\cp_mp\overlord::playevent("quest_s0a1t3_restock_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_1627ae9ae7126532":
        scripts\cp_mp\overlord::playevent("quest_s0a2t5_frostbite_success", [player], undefined, undefined, 1);
        break;
      case #"hash_c8f86603ffc5a2d4":
        scripts\cp_mp\overlord::playevent("quest_s0a2t5_mindctrl_success", [player], undefined, undefined, 1);
        break;
      case #"hash_94bedd94f7ef2baf":
        scripts\cp_mp\overlord::playevent("quest_s0a2t1_delivery_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_4d6354242f93af13":
        scripts\cp_mp\overlord::playevent("quest_s0a2t2_mercclean_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_615a25c0ff004cd2":
        scripts\cp_mp\overlord::playevent("quest_s0a2t2_guardangel_success", [player], undefined, undefined, 1);
        break;
      case #"hash_6b9b64f5b9a1f92e":
        scripts\cp_mp\overlord::playevent("quest_s0a2t2_ascension_success", [player], undefined, undefined, 1);
        break;
      case #"hash_a682549e428cf4b0":
        scripts\cp_mp\overlord::playevent("quest_s0a2t2_reaper_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_c8842fe1f0db90be":
        scripts\cp_mp\overlord::playevent("quest_s0_a2t2_shocked_success", [player], undefined, undefined, 1);
        break;
      case #"hash_dd1abfdefd6588b3":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t2_ac_success", [player], undefined, undefined, 1);
        break;
      case #"hash_4884cf3af5825a29":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t2_ghosted_success", [player], undefined, undefined, 1);
        break;
      case #"hash_b21a7398a3158cae":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t2_mostfirepwr_success", [player], undefined, undefined, 1);
        break;
      case #"hash_c26ddb64ed821cad":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t2_painttarget_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_d0152c167157b2b4":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t4_springcln_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_d20dd052e2ca08ce":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t4_closetime_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_b4085c6adbd2d722":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t2_firestarter_success", [player], undefined, undefined, 1);
        break;
      case #"hash_2d47f015d1d0be40":
        scripts\cp_mp\overlord::playevent("quest_s0_a3t2_crashburn_success", squadmembers, undefined, undefined, 1);
        break;
      case #"hash_cec11b508f832d53":
        scripts\cp_mp\overlord::playevent("quest_s0a1t1_treasure_success", [player], undefined, undefined, 1);
        break;
      case #"hash_4ae55b1005252a01":
        scripts\cp_mp\overlord::playevent("quest_s0a1t3_bomb_success", [player], undefined, undefined, 1);
        break;
      case #"hash_6749f49c81821f0c":
        if(isDefined(player) && isDefined(player.var_74d8dcd67ff30483)) {
          if(player.var_74d8dcd67ff30483 == "jup_ob_loot_safes") {
            scripts\cp_mp\overlord::playevent("quest_s0a1t5_raiders_safe", squadmembers, undefined, undefined, 1);
          } else if(player.var_74d8dcd67ff30483 == "jup_ob_zombie_weapon_stash_kills") {
            scripts\cp_mp\overlord::playevent("quest_s0a1t5_raiders_kill", squadmembers, undefined, undefined, 1);
          }
        }

        break;
      default:
        break;
    }
  }
}

function function_7078fecde61ab0db(params) {
  if(isPlayer(params.player)) {
    params.player thread function_6db576722ffc548d();
  }
}

function function_6db576722ffc548d() {
  if(isDefined(level.var_7f1d1c7c6153a9bf)) {
    if([[level.var_7f1d1c7c6153a9bf]]()) {
      return;
    }
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(isPlayer(self)) {
    player = self;

    if((function_c7d3c1cb4a3958cf(player, 16939) || getdvarint(@ "hash_7846a66ee6afec3e", 0)) && !player ent_flag("heard_s0a1t1_directline_start_vo") && !function_62b41959b3c5a9ca(player, 16937)) {
      player ent_flag_set("heard_s0a1t1_directline_start_vo");
      random_int = randomintrange(1, 3);
      scripts\cp_mp\overlord::playconversation("quest_s0a1t1_dlstart" + string(random_int), [player], undefined, 0);
    }
  }
}

function function_568866da0244ea3() {
  if(isDefined(level.var_7f1d1c7c6153a9bf)) {
    if([[level.var_7f1d1c7c6153a9bf]]()) {
      return;
    }
  }

  if(isPlayer(self)) {
    player = self;

    if(function_c7d3c1cb4a3958cf(player, 14966) && !player ent_flag("heard_s0a1t1_firepower_start_vo")) {
      player ent_flag_set("heard_s0a1t1_firepower_start_vo");
      random_int = randomintrange(1, 3);
      scripts\cp_mp\overlord::playconversation("quest_s0a1t1_fpstart" + string(random_int), [player], undefined, 0);
    }
  }
}

function function_5f169bceaf46be72(params) {
  thread function_dc85f56a56f1d2c1();
}

function function_dc85f56a56f1d2c1() {
  if(isDefined(level.var_7f1d1c7c6153a9bf)) {
    if([[level.var_7f1d1c7c6153a9bf]]()) {
      return;
    }
  }

  if(isPlayer(self)) {
    player = self;

    if(function_c7d3c1cb4a3958cf(player, 15770) && !player ent_flag("heard_s0a1t1_rw_start_vo")) {
      player ent_flag_set("heard_s0a1t1_rw_start_vo");
      random_int = randomintrange(1, 3);
      scripts\cp_mp\overlord::playconversation("quest_s0a1t1_rwstart" + string(random_int), [player], undefined, 0);
    }
  }
}

function function_5e1833b74c8dc68f() {
  if(isDefined(level.var_7f1d1c7c6153a9bf)) {
    if([[level.var_7f1d1c7c6153a9bf]]()) {
      return;
    }
  }

  if(isPlayer(self)) {
    player = self;

    if(function_c7d3c1cb4a3958cf(player, 14765) && !player ent_flag("heard_s0a1t1_wp_start_vo")) {
      player ent_flag_set("heard_s0a1t1_wp_start_vo");
      random_int = randomintrange(1, 3);
      scripts\cp_mp\overlord::playconversation("quest_s0a1t1_wpstart" + string(random_int), [player], undefined, 0);
    }
  }
}

function function_db6c1cb0e91c7041(a_players) {
  self waittill("escort_mission_vo");

  for(i = 0; i < a_players.size; i++) {
    if(isalive(a_players[i])) {
      player = a_players[i];
      break;
    }
  }

  if(isDefined(player)) {
    player thread function_da06d69b0b66e612(17060, "quest_s0a1t5_chaperone_start");
  }
}

function function_eb1506a06c31da2b(params) {
  if(isPlayer(params.player)) {
    params.player thread function_da06d69b0b66e612(14837, "quest_s0a1t1_gmbl_start", undefined, 1);
  }
}

function function_7758c4422a68f415(params) {
  if(isPlayer(params.player)) {
    params.player thread function_da06d69b0b66e612(16136, "quest_s0a1t5_handsoff_start");
  }
}

function function_8e07c089e889784f(params) {
  if(isPlayer(params.player)) {
    params.player thread function_da06d69b0b66e612(16144, "quest_s0a1t5_nestwrecker_start");
  }
}

function function_da6e19f48f3340b8(params) {
  if(isPlayer(params.player)) {
    params.player thread function_da06d69b0b66e612(16651, "quest_s0a2t3_bountyhunt_start");
  }
}

function function_628a2357515e077a(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16640, "quest_s0a2t5_extr_start");
  }
}

function function_fbab6a79ccb766d2(params) {
  if(isPlayer(params.player)) {
    params.player thread function_da06d69b0b66e612(16625, "quest_s0a2t1_delivery_start");
  }
}

function private function_8b134141131f364a(params) {
  if(isDefined(params.cacheinstance) && isDefined(params.cacheinstance.type) && !istrue(params.cacheinstance.openedbefore)) {
    function_f10f600ac4ee4c09("loot_cache_looted");

    switch (params.cacheinstance.type) {
      case #"hash_4cfd32bbd2544dc2":
      case #"hash_69b00973eec22e7e":
      case #"hash_8dc697e88cc411b2":
      case #"hash_a862ca2b6614f16e":
        function_f10f600ac4ee4c09("crate_looted");
        break;
      default:
        break;
    }

    if(istrue(params.cacheinstance.var_69971d3fabc4c29b)) {
      function_f10f600ac4ee4c09("loot_merc_camps", 1, 0);
    }

    thread function_da06d69b0b66e612(21175, "quest_s0a1t1_treasure_start", undefined, 1);
  }
}

function private function_984089fc6559a650(params) {
  if(!isDefined(params)) {
    return;
  }

  var_4606405a751def54 = params.w_new getaltweapon();

  if(isDefined(params.w_take)) {
    if(isDefined(params.w_new)) {
      params.objweapon = params.w_new;
      level thread function_2862ad8db68c4dde(params);
    }

    if(isDefined(var_4606405a751def54)) {
      params.objweapon = var_4606405a751def54;
      level thread function_2862ad8db68c4dde(params);
    }
  }

  callback::callback("on_pap_machine_purchase", params);
  var_18cefa3acf061993 = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_e6b742f2dbcdaa7a", #"pack_a_punch"));
  buy_action = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"buy"));
  lootid = 0;
  rarity = 0;

  if(isDefined(params.w_take)) {
    lootid = weapon::getweaponlootid(params.w_take);

    if(isweapon(params.w_take)) {
      rarity = namespace_736197e4d378b91b::function_75e73212bbe447d9(params.w_take);
    }
  }

  var_f237807396377232 = spawnStruct();
  var_f237807396377232.rarity = rarity;
  var_f237807396377232.var_7d9803744a905b95 = var_18cefa3acf061993;
  var_f237807396377232.pap_level = params.n_pap_level;
  challenges::function_1ba256da09a9878a(self, lootid, undefined, undefined, 1, params.cost, buy_action, var_f237807396377232);
}

function private on_player_damaged(params) {
  if(isPlayer(params.victim)) {
    player = params.victim;

    if(isDefined(player.var_e4f61eff2606b60c)) {
      player.var_e4f61eff2606b60c = 0;
    }
  }
}

function private function_3cd8cd54ce47110a(sparams) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.elementsaffected)) {
    self.elementsaffected = [];
  }

  if(!isDefined(self.elementaltimer)) {
    self.elementaltimer = 0;
  }

  if(isDefined(sparams.sweapon) && isDefined(sparams.smeansofdeath)) {
    weaponelementtype = points::function_591305dc9c07499b(sparams.sweapon, sparams.eattacker, sparams.smeansofdeath);

    if(weaponelementtype == "fire" || sparams.smeansofdeath == "MOD_ELEMENTAL_FIRE") {
      if(!isDefined(self.elementsaffected["fire"])) {
        self.elementsaffected["fire"] = 1;
        function_726462b7bf0052b7();
      }
    } else if(weaponelementtype == "cold" || sparams.smeansofdeath == "MOD_ELEMENTAL_COLD") {
      if(!isDefined(self.elementsaffected["cold"])) {
        self.elementsaffected["cold"] = 1;
        function_726462b7bf0052b7();
      }
    } else if(weaponelementtype == "electrical" || sparams.smeansofdeath == "MOD_ELEMENTAL_ELEC" || sparams.sweapon.basename == "jup_shock_stick_ob") {
      if(!isDefined(self.elementsaffected["electrical"])) {
        self.elementsaffected["electrical"] = 1;
        function_726462b7bf0052b7();
      }
    } else if(weaponelementtype == "toxic" || sparams.smeansofdeath == "MOD_ELEMENTAL_TOXIC") {
      if(!isDefined(self.elementsaffected["toxic"])) {
        self.elementsaffected["toxic"] = 1;
        function_726462b7bf0052b7();
      }
    }
  }

  if(isDefined(self.kiastring) && self.kiastring == "deathworm_kia") {
    if(isPlayer(sparams.eattacker)) {
      if(sparams.eattacker.currentweapon.basename == "iw9_me_fists_mp") {
        sparams.eattacker function_f10f600ac4ee4c09("punched_deathworm", 2);
      }
    }
  }

  if(isDefined(self.health) && isDefined(self.maxhealth) && self.health >= self.maxhealth) {
    self.var_ec0a5c743cc6a4da = gettime();
  }
}

function private function_726462b7bf0052b7() {
  if(!isagent(self)) {
    return;
  }

  self.elementaltimer = 0;

  if(!isDefined(level.var_3dacdac07404670c[self getentitynumber()])) {
    level.var_3dacdac07404670c[self getentitynumber()] = self;
  }
}

function private function_68feab32966b29b8() {
  level endon("game_ended");

  while(true) {
    wait 1;

    if(level.var_3dacdac07404670c.size > 0) {
      level.var_3dacdac07404670c = function_fdc9d5557c53078e(level.var_3dacdac07404670c, 1);
      i = 0;

      foreach(enemy in level.var_3dacdac07404670c) {
        if(isalive(enemy) && isDefined(enemy.elementaltimer) && isDefined(enemy.elementsaffected)) {
          if(enemy.elementaltimer > 5) {
            enemy.elementaltimer = 0;
            enemy.elementsaffected = [];
            index = enemy getentitynumber();
            level.var_3dacdac07404670c = array_remove_index(level.var_3dacdac07404670c, index, 1);
            continue;
          }

          enemy.elementaltimer++;
          i++;

          if(i % 5 == 0) {
            waitframe();
          }
        }
      }
    }
  }
}

function function_ce3c3c0439296754() {
  if(!isagent(self)) {
    return;
  }

  tactical_attractor = undefined;

  if(isDefined(self.target_attractor) && isDefined(self.target_attractor.source)) {
    if(isDefined(self.target_attractor.source.grenade) && isDefined(self.target_attractor.source.grenade.equipmentref) && self.target_attractor.source.grenade.equipmentref == "equip_monkey_bomb") {
      tactical_attractor = "equip_monkey_bomb";
    } else if(isDefined(self.target_attractor.source.equipmentref)) {
      tactical_attractor = "equip_decoy";
    }
  }

  return scripts\mp\weapons::isstunnedorblinded() || zombie_stun::is_stunned() || function_809f44597eff7229() || isDefined(tactical_attractor) || function_4a588aa51c7a9b4e() || function_e270857762b60945() || function_9ccbbc7f4170babf() || function_fe9986961a6c036e();
}

function function_809f44597eff7229() {
  return isDefined(self._blackboard) && istrue(self._blackboard.vortexispulled);
}

function function_4a588aa51c7a9b4e() {
  return isDefined(self.var_45483f8609f54440) && abs(self.var_45483f8609f54440 - gettime());
}

function function_e270857762b60945() {
  return isarray(self.shocksticks) && self.shocksticks.size > 0;
}

function function_9ccbbc7f4170babf() {
  return isDefined(self.lastsnapshotgrenadetime) && abs(self.lastsnapshotgrenadetime - gettime()) <= 5000;
}

function function_fe9986961a6c036e() {
  return isDefined(self.var_4a9b1a3e622f082) && abs(self.var_4a9b1a3e622f082 - gettime()) <= 2000;
}

function private function_2862ad8db68c4dde(params) {
  alt_take = params.w_take getaltweapon();

  if(array_contains(level.wallbuy_weapons, params.w_take) || array_contains(level.wallbuy_weapons, alt_take)) {
    level.wallbuy_weapons = array_add(level.wallbuy_weapons, params.objweapon);
    return;
  }

  if(array_contains(level.magicbox_weapons, params.w_take) || array_contains(level.magicbox_weapons, alt_take)) {
    level.magicbox_weapons = array_add(level.magicbox_weapons, params.objweapon);
    return;
  }
}

function private function_d88408f2a5adf639(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_merccamp_fail");
    }
  }
}

function private function_ed0bb8717f31f954(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_merccamp_success");
    }
  }
}

function private function_5470291610d91652(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_merccamp_loot", 1);
    }
  }
}

function private function_a9d19f968e2f15e9(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 16152)) {
      player thread function_da06d69b0b66e612(16152, "quest_s0a2t2_mercclean_start");
      return;
    }

    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_merccamp_approach", 1);
    }
  }
}

function private on_player_laststand(params) {
  if(isPlayer(self)) {
    trigger_struct = spawnStruct();
    trigger_struct.origin = self.origin;
    trigger_struct.radius = 600;
    trigger_struct.height = 10;
    function_729d94c0071a8916(trigger_struct);

    if(isDefined(self) && isPlayer(self)) {
      ent_flag_init("downed_before_exfil");
    }
  }
}

function function_729d94c0071a8916(structspawn) {
  self.trigger = spawn("trigger_radius", structspawn.origin, 0, structspawn.radius, structspawn.height);
  thread function_ab0d44e43142e74e(self.trigger);
  waittill_any_2("death_or_disconnect", "laststand_revived");
  waitframe();

  if(isDefined(self) && isDefined(self.trigger)) {
    self.trigger delete();
  }
}

function function_ab0d44e43142e74e(trigger) {
  self endon("death_or_disconnect");
  self endon("laststand_revived");

  while(true) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent)) {
      ent thread function_da06d69b0b66e612(15914, "quest_s0a2t2_guardangel_start", undefined, 1);
    }
  }
}

function on_spawn_redeploy_drone(params) {
  self endon("redeploy_drone_destroyed");
  level endon("game_ended");

  while(true) {
    throttle::function_f632348cbb773537(level.var_1d8645b41c9cb6a0, self);

    if(isDefined(self)) {
      players = getplayersinradius(self.origin, 400, 10000);

      if(players.size > 0) {
        foreach(player in players) {
          if(isDefined(player)) {
            player thread function_da06d69b0b66e612(16645, "quest_s0a2t2_ascension_start", undefined, 1);
          }
        }
      }
    }

    wait 0.1;
  }
}

function function_83ba63f5ccc1143e(params) {
  level endon("game_ended");
  self endon("harvesterorb_end");
  self endon("orb_cleaned_up");

  while(true) {
    throttle::function_f632348cbb773537(level.var_972268e38976b7a9, self);

    if(isDefined(self)) {
      players = getplayersinradius(self.origin, 200, 10000);

      if(players.size > 0) {
        foreach(player in players) {
          if(isDefined(player) && function_5acc35fc66331385(player, 16648) || getdvarint(@ "hash_7846a66ee6afec3e", 0)) {
            player thread function_da06d69b0b66e612(16648, "quest_s0a2t2_reaper_start");
          }
        }
      }
    }

    wait 0.1;
  }
}

function function_1ab983924d3621aa() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    throttle::function_f632348cbb773537(level.var_cf8d941509d44c64, self);

    if(isDefined(self)) {
      players = getplayersinradius(self.origin, 800, 10000);

      if(players.size > 0) {
        foreach(player in players) {
          if(isDefined(player) && function_5acc35fc66331385(player, 17077) || getdvarint(@ "hash_7846a66ee6afec3e", 0)) {
            player thread function_da06d69b0b66e612(17077, "quest_s0_a3t2_crashburn_start");
          }
        }
      }
    }

    wait 0.1;
  }
}

function function_a14a93ab2f0b86d1(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16635, "quest_s0a2t2_safecrack_start");
  }
}

function function_81747fd819153293(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16635, "quest_s0a2t2_safecrack_success");
  }
}

function private function_da06d69b0b66e612(mission_id, var_4152d19cb7e28515, b_conv, b_solo) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  if(isDefined(level.var_7f1d1c7c6153a9bf)) {
    if([[level.var_7f1d1c7c6153a9bf]]()) {
      return false;
    }
  }

  if(isPlayer(self)) {
    player = self;

    if(istrue(b_solo)) {
      if((function_c7d3c1cb4a3958cf(player, mission_id) || getdvarint(@ "hash_7846a66ee6afec3e", 0)) && !player ent_flag(var_4152d19cb7e28515)) {
        player ent_flag_set(var_4152d19cb7e28515);

        if(istrue(b_conv)) {
          scripts\cp_mp\overlord::playconversation(var_4152d19cb7e28515, [player], undefined, 0);
        } else {
          scripts\cp_mp\overlord::playevent(var_4152d19cb7e28515, [player], undefined, undefined, 1);
        }

        return true;
      } else {
        return false;
      }
    } else {
      squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

      if(function_f578373042c34e16(mission_id, var_4152d19cb7e28515, squadmembers)) {
        var_d4b7bf65cde0ce23 = 0;

        foreach(member in squadmembers) {
          if(member ent_flag(var_4152d19cb7e28515)) {
            var_d4b7bf65cde0ce23 = 1;
          }
        }

        if(!var_d4b7bf65cde0ce23) {
          foreach(member in squadmembers) {
            member ent_flag_set(var_4152d19cb7e28515);
          }

          if(istrue(b_conv)) {
            scripts\cp_mp\overlord::playconversation(var_4152d19cb7e28515, squadmembers, undefined, 0);
          } else {
            scripts\cp_mp\overlord::playevent(var_4152d19cb7e28515, squadmembers, undefined, undefined, 1);
          }

          return true;
        } else {
          return false;
        }
      }
    }
  }

  return false;
}

function function_f578373042c34e16(mission_id, var_84e2ca49013808d2, players) {
  should_play_vo = 0;

  foreach(player in players) {
    if((function_c7d3c1cb4a3958cf(player, mission_id) || getdvarint(@ "hash_7846a66ee6afec3e", 0) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) && !player ent_flag(var_84e2ca49013808d2)) {
      should_play_vo = 1;
      break;
    }
  }

  return should_play_vo;
}

function function_5acc35fc66331385(player, mission_id) {
  if(isPlayer(player)) {
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    foreach(member in squadmembers) {
      if(isPlayer(member) && (function_c7d3c1cb4a3958cf(member, mission_id) || getdvarint(@ "hash_7846a66ee6afec3e", 0))) {
        return true;
      }
    }
  }

  return false;
}

function function_182aeec2e4e170de(player) {
  if((function_5acc35fc66331385(self, 17077) || getdvarint(@ "hash_7846a66ee6afec3e", 0)) && !ent_flag("quest_s0_a3t2_crashburn_start")) {
    return true;
  }

  return false;
}

function private function_876eed02bb717d72(params) {
  thread function_1052ebe04c0369ac();
}

function private function_1052ebe04c0369ac() {
  waitframe();

  if(isagent(self)) {
    if(!isalive(self)) {
      if(isDefined(self.lastattacker)) {
        self.lastattacker function_484194ec6ace15bb("abomination_grenade_swallow");
      }
    }
  }
}

function private function_1d29b3ce33c72a69(params) {
  if(isDefined(params.player) && isDefined(params.vehicle)) {
    if(params.vehicle ent_flag_exist("armored_convoy_spawned")) {
      params.player function_f10f600ac4ee4c09("energy_mine_stop_convoy");
    }
  }
}

function private function_3115bc3519ac2ea1() {
  self endon("death_or_disconnect");
  self.var_dd9a638faa62f464 = 0;

  while(scripts\cp_mp\zombie_perks::has_perk("specialty_speedcola")) {
    self waittill("reload");

    if(!ent_flag("speedcola_schematic_active")) {
      ent_flag_init("speedcola_schematic_active");
      ent_flag_set("speedcola_schematic_active");
      self.var_6502bc23ef7b1744 = gettime();
    }
  }
}

function private on_player_revived(params) {
  if(!isDefined(params.reviver) || !isDefined(self)) {
    return;
  }

  if(squad_utility::function_9b1d18c04d310cfc(params.reviver, self)) {
    if(params.reviver scripts\cp_mp\zombie_perks::has_perk("specialty_quickrevive")) {
      params.reviver function_f10f600ac4ee4c09("schematic_quickrevive_revive");
    }
  }
}

function private function_900df0cbd73e399b(params) {
  if(scripts\cp_mp\zombie_perks::has_perk("specialty_elemental_pop")) {
    function_f10f600ac4ee4c09("schematic_elementalpop_proc", 2);
  }
}

function private function_defeb316e4a936c(params) {
  if(isDefined(params) && isDefined(params.player)) {
    params.player function_484194ec6ace15bb("phd_flopper");
  }
}

function private function_735905adf14f7ebc(params) {
  if(!isPlayer(self)) {
    return;
  }

  thread function_503c8745be6d4249(params);

  if(scripts\cp_mp\zombie_perks::has_perk("specialty_death_perception")) {
    function_f10f600ac4ee4c09("cyst_kill_death_perception", 2);
  }
}

function private on_merc_camp_recon_destroyed(params) {
  if(!isDefined(params.player) || !isPlayer(params.player)) {
    return;
  }

  params.player function_f10f600ac4ee4c09("merc_camp_recon_destroyed", 2);
}

function private function_503c8745be6d4249(params) {
  level endon("game_ended");
  self endon("disconnect");
  wait 0.5;

  if(!isPlayer(self)) {
    return;
  }

  location = vectorlerp(self.origin, params.cyst.origin, 0.5);

  if(function_18a53d77df35c4c9(params.player, 16147)) {
    spawnnewitemfromscriptablesharedfunc("obloot_ava_intel_aether_nest", location, self.angles, 0, 1);
  }
}

function private on_powerup_nuke_pickup(params) {
  if(!isDefined(params.player) || !isPlayer(params.player)) {
    return;
  }

  params.player function_f10f600ac4ee4c09("powerup_nuke_pickup", 2);
}

function private function_7d81180cfc146b9a(victimstruct) {
  if(!isDefined(victimstruct)) {
    return;
  }

  if(!isDefined(victimstruct.var_d9765f2679be19b9)) {
    victimstruct.var_d9765f2679be19b9 = [];
  }

  if(isDefined(victimstruct.var_21a8839dd03e31cd)) {
    if(victimstruct.var_21a8839dd03e31cd.size == 1) {
      victimstruct.var_21a8839dd03e31cd[0] function_484194ec6ace15bb("deathworm_solo_kill", 1, 0);
    }

    foreach(player in victimstruct.var_21a8839dd03e31cd) {
      if(array_contains(victimstruct.var_d9765f2679be19b9, player)) {
        continue;
      }

      player function_484194ec6ace15bb("zombie_deathworm", 3, 0);
      player function_484194ec6ace15bb("zombie_elite_general", 3, 0);
      victimstruct.var_d9765f2679be19b9[victimstruct.var_d9765f2679be19b9.size] = player;
    }
  }
}

function private function_6685ae90a5b68220(params) {
  if(!isPlayer(self)) {
    return;
  }

  self.var_e44a614acd5d4984 = gettime();
}

function private function_a0dc56fbe58ef8c3() {
  function_6e7290c8ee4f558b("<dev string:x6e>");
  function_a9a864379a098ad6("<dev string:x8f>", "<dev string:xbb>", &function_8da31be1c7c3ed93);
  function_a9a864379a098ad6("<dev string:xd0>", "<dev string:xfd>", &function_5342bd4e7a1c6d83);
  function_a9a864379a098ad6("<dev string:x113>", "<dev string:x142>", &function_12a19de3d2346cbe);
  function_a9a864379a098ad6("<dev string:x15a>", "<dev string:x18a>", &function_cd70135e68209b24);
  function_a9a864379a098ad6("<dev string:x1a3>", "<dev string:x1d1>", &function_44bea892ed0bc101);
  function_a9a864379a098ad6("<dev string:x1e7>", "<dev string:x213>", &function_5d400e584442179b);
  function_fe953f000498048f();
}

function private function_8da31be1c7c3ed93() {
  foreach(player in level.players) {
    for(i = 0; i < 50; i++) {
      player function_484194ec6ace15bb("<dev string:x227>");
    }

    player function_f10f600ac4ee4c09("<dev string:x247>", 1, 0);

    for(i = 0; i < 10; i++) {
      player function_f10f600ac4ee4c09("<dev string:x264>", 1, 0);
    }
  }
}

function private function_5342bd4e7a1c6d83() {
  foreach(player in level.players) {
    for(i = 0; i < 50; i++) {
      player function_484194ec6ace15bb("<dev string:x283>");
    }

    player function_9db4c37d4f1415f("<dev string:x299>");
    player function_f10f600ac4ee4c09("<dev string:x2b4>", 1, 0);
  }
}

function private function_12a19de3d2346cbe() {
  foreach(player in level.players) {
    for(i = 0; i < 50; i++) {
      player function_484194ec6ace15bb("<dev string:x2ce>", 2);
    }

    player function_f10f600ac4ee4c09("<dev string:x2e9>", 2, 0);
    player function_9db4c37d4f1415f("<dev string:x300>");
  }
}

function private function_cd70135e68209b24() {
  foreach(player in level.players) {
    player function_f10f600ac4ee4c09("<dev string:x314>", 2, 0);
    player function_9db4c37d4f1415f("<dev string:x32a>");
  }
}

function private function_44bea892ed0bc101() {
  foreach(player in level.players) {
    for(i = 0; i < 50; i++) {
      player function_484194ec6ace15bb("<dev string:x345>", 2);
    }

    player function_f10f600ac4ee4c09("<dev string:x361>", 2, 0);
    player function_9db4c37d4f1415f("<dev string:x37d>");
  }
}

function private function_5d400e584442179b() {
  foreach(player in level.players) {
    for(i = 0; i < 50; i++) {
      player function_484194ec6ace15bb("<dev string:x38f>", 2);
    }

    player function_f10f600ac4ee4c09("<dev string:x3b1>", 2, 0);
    player function_9db4c37d4f1415f("<dev string:x37d>");
  }
}

function private on_approach_convoy(params) {}

function private on_convoy_begin(params) {
  thread function_6efeef8ea59e4541();
  thread function_fd34dfd4299a5170();
}

function private function_fd34dfd4299a5170() {
  self endon("death");
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");

  while(true) {
    throttle::function_f632348cbb773537(level.var_16aba0b1e426588e, self);
    activitypos = namespace_68dc261109a9503f::function_8988a4c89289d7f4(self);

    if(isDefined(self)) {
      foreach(player in level.players) {
        if(isDefined(player) && isDefined(activitypos)) {
          if(distance2dsquared(player.origin, activitypos) <= squared(1200)) {
            player thread function_da06d69b0b66e612(16095, "quest_s0a1t2_cnvy_approach");
          }
        }

        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function private function_6efeef8ea59e4541() {
  self endon("death");
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  var_fe525c27d1d0619e = namespace_8480efeffcd6e233::function_5bbdc39a533d9d57(self, "Awareness_Zone");
  var_d018f00fe7ac52a2 = namespace_8480efeffcd6e233::function_2403f7fe5d40cecc(var_fe525c27d1d0619e[0]);

  while(true) {
    throttle::function_f632348cbb773537(level.var_16aba0b1e426588e, self);

    if(isDefined(self)) {
      foreach(player in level.players) {
        activitypos = namespace_68dc261109a9503f::function_8988a4c89289d7f4(self);

        if(isDefined(activitypos) && isDefined(player) && isDefined(player.origin)) {
          var_d5c95aa3dab18949 = distance2dsquared(player.origin, activitypos);

          if(var_d5c95aa3dab18949 <= squared(var_d018f00fe7ac52a2 * 1.75) && var_d5c95aa3dab18949 > squared(1200)) {
            if(isDefined(player) && !player ent_flag("quest_s0a1t2_cnvy_approach") && (function_5acc35fc66331385(player, 16095) || getdvarint(@ "hash_7846a66ee6afec3e", 0))) {
              player thread function_da06d69b0b66e612(16095, "quest_s0a1t2_cnvy_farapproach");
            }
          }
        }

        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function private on_engage_convoy(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16095, "quest_s0a1t2_cnvy_engage");
  }
}

function private on_destroy_convoy(params) {
  if(isPlayer(self) && !ent_flag("quest_s0a1t2_cnvy_keylooted")) {
    thread function_da06d69b0b66e612(16095, "quest_s0a1t2_cnvy_vehicledestroyed");
  }
}

function private veh_on_convoy_ended(params) {
  thread function_5528c46bef03fb6b(params);
}

function private function_5528c46bef03fb6b(params) {
  params.activity_instance endon("instance_destroyed");
  self endon("death");

  while(true) {
    throttle::function_f632348cbb773537(level.var_844aeaa09ef5dd5a, self);

    if(isDefined(self) && vehicle::isvehicle() && isDefined(self.origin)) {
      players = getplayersinradius(self.origin, 240);

      if(players.size > 0) {
        foreach(player in players) {
          wait 0.1;

          if(isDefined(player) && (function_5acc35fc66331385(player, 16095) || getdvarint(@ "hash_7846a66ee6afec3e", 0)) && player ent_flag("quest_s0a1t2_cnvy_vehicledestroyed") && !player ent_flag("quest_s0a1t2_cnvy_keylooted")) {
            player thread function_da06d69b0b66e612(16095, "quest_s0a1t2_cnvy_closedestconvoy");
          }
        }
      }

      continue;
    }

    return;
  }
}

function private on_approach_merc_stronghold(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 16946)) {
      player thread function_da06d69b0b66e612(16946, "quest_s0a1t4_mstr_approach");
      return;
    }

    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_mercstronghold_approach");

      if(isDefined(params.is_warlord)) {
        player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_mercstronghold_allforone_intro");
      }
    }
  }
}

function private function_816b42385497212a(params) {
  player = params.player;

  if(isPlayer(player)) {
    player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_mercstronghold_nokey");
  }
}

function private on_unlock_merc_stronghold(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 16946)) {
      player thread function_da06d69b0b66e612(16946, "quest_s0a1t4_mstr_unlockdoor");
      return;
    }

    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_mercstronghold_unlock");
    }
  }
}

function private on_merc_stronghold_cleared_vo(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 16946)) {
      player thread function_da06d69b0b66e612(16946, "quest_s0a1t4_mstr_lastenemydown");
      return;
    }

    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_mercstronghold_lastenemy");
    }
  }
}

function private on_merc_stronghold_reinforcement(params) {
  player = params.player;

  if(isPlayer(player)) {
    if(function_5acc35fc66331385(player, 16946)) {
      player thread function_da06d69b0b66e612(16946, "quest_s0a1t4_mstr_reenforce", 1);
      return;
    }

    if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_mercstronghold_reinforce_resp", 1);
    }
  }
}

function private function_d4f961679a3612e2(params) {
  player = params.player;
  warlord = params.warlord;

  if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
    if(warlord == "allforone") {
      player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_merccamp_allforone_success", 1);
    }
  }
}

function private on_sabotage_start(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16445, "quest_s0a2t4_heist_extstart_conv", 1);
  }
}

function private on_abandon_sabotage_contract(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16445, "quest_s0a2t4_heist_extcontractcancel");
  }
}

function private on_sabotage_failure_nocannister(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16445, "quest_s0a2t4_heist_extfailure_conv", 1);
  }
}

function private on_sabotage_success_nocannister(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16445, "quest_s0a2t4_heist_extsuccess_conv", 1);
  }
}

function private on_sabotage_success_withcannister(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(16445, "quest_s0a2t4_heist_extsuccess_cannister_conv", 1);
  }
}

function private on_merc_defend_started(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(17070, "quest_s0a3t1_s2fa_mdfcontractstart");
  }
}

function private on_merc_defend_approach_refractor(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(17070, "quest_s0a3t1_s2fa_mdfrefractor");
  }
}

function private on_merc_defend_damage_25(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(17070, "quest_s0a3t1_s2fa_mdfdamage25");
  }
}

function private on_merc_defend_success(params) {
  if(isPlayer(self)) {
    thread function_da06d69b0b66e612(17070, "quest_s0a3t1_s2fa_mdfsuccess_conv", 1);
  }
}

function private function_2ca2263723de3b23(params) {
  player = params.player;

  if(function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
    player thread function_da06d69b0b66e612(17078, "quest_s0a3t3_mercstronghold_allforone_success");
  }
}

function private function_9c039c6daa449c38(player) {
  squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(function_f578373042c34e16(14966, "heard_s0a1t1_firepower_start_vo", squadmembers)) {
    return true;
  } else if(function_f578373042c34e16(14967, "quest_s0a2t3_firepower_start", squadmembers)) {
    return true;
  } else if(function_f578373042c34e16(14972, "quest_s0_a3t2_mostfirepwr_start", squadmembers)) {
    return true;
  }

  return false;
}

function assignplayerkillmodifierstrimmed(victimstruct, objweapon, meansofdeath, inflictor) {
  self.modifiers = [];
  self.modifiers["mask"] = 0;
  self.modifiers["mask2"] = 0;
  self.modifiers["mask3"] = 0;
  self.modifiers["attachment_flags"] = 0;
  curtime = gettime();
  weapongroup = scripts\mp\utility\weapon::getweapongroup(objweapon);
  fullweaponstring = getcompleteweaponname(objweapon);
  killing_event = spawnStruct();
  throttle::function_f632348cbb773537(level.var_1ba18dd27f458f88, killing_event);

  if(!iskillstreakweapon(objweapon) && isPlayer(self)) {
    attackerisinflictor = scripts\mp\events::attackerisinflictor(self, inflictor, objweapon, meansofdeath);
    attackervelocity = self getvelocity();
    var_63d7d6bf10076ecb = vectorNormalize(attackervelocity);
    var_a2c3fea3986af52a = anglesToForward(self getplayerangles());
    var_776dafcc4fadbc14 = vectordot(var_a2c3fea3986af52a, var_63d7d6bf10076ecb);
    var_414d20858ffe7335 = length2dsquared(attackervelocity);

    if(isDefined(victimstruct.attackerposition)) {
      attackerposition = victimstruct.attackerposition;
    } else {
      attackerposition = self.origin;
    }

    if(isDefined(attackervelocity)) {
      if(attackervelocity[0] != 0 || attackervelocity[1] != 0 || attackervelocity[2] != 0) {
        self.modifiers["moving_kill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"moving_kill"));
      }
    }

    isbulletdamage = isbulletdamage(meansofdeath);
    ismeleedamage = ismeleedamage(meansofdeath);

    if((isbulletdamage || ismeleedamage) && isDefined(var_776dafcc4fadbc14) && isDefined(var_414d20858ffe7335)) {
      if(abs(var_776dafcc4fadbc14) < 0.8 && var_414d20858ffe7335 > 50) {
        self.modifiers["strafing_kill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"strafing_kill"));
      }
    }

    if(meansofdeath == "MOD_EXECUTION") {
      self.modifiers["execution"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"execution"));
    }

    if(!isDefined(objweapon) || !isDefined(objweapon.basename) || objweapon.basename == "none") {
      return;
    }

    if(function_fbb73b9050299404(victimstruct, objweapon, meansofdeath, curtime, weapongroup)) {
      self.modifiers["oneshotkill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hash_603a0dde50c94e47"));
    }

    if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN") {
      self.modifiers["melee"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"melee"));

      if(weapongroup != "weapon_melee" && weapongroup != "weapon_melee2" && weapongroup != "other") {
        self.modifiers["gunbutt"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"gunbutt"));
      }
    }

    if(meansofdeath != "MOD_GRENADE" && meansofdeath == "MOD_HEAD_SHOT") {
      self.modifiers["headshot"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"headshot"));
    }

    if(!istrue(self isnightvisionon())) {
      self.modifiers["withoutnvgs"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"withoutnvgs"));
    }

    if(attackerisinflictor) {
      var_3c709d201f0772ad = scripts\mp\events::getshotdistancetype(self, objweapon, meansofdeath, attackerposition, victimstruct.origin);
      killdist = math::round_float(distance(attackerposition, victimstruct.origin) / 39.37, 2);

      switch (var_3c709d201f0772ad) {
        case #"hash_e1ae7daca67ccc55":
          self.modifiers["pointblank"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"shortrange"));
          break;
        case #"hash_bbddd8225d923d3":
          self.modifiers["longshot"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"longrange"));
          self setclientomnvar("ui_longshot_dist", killdist);
          self setclientomnvar("ui_longshot_special", islongshotspecial(attackerposition, victimstruct.origin, objweapon));
          break;
        case #"hash_4364fa08acd17954":
          self.modifiers["longshot"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"longrange"));
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hash_72a2c2883e780324"));
          self.modifiers["very_longshot"] = 1;
          self setclientomnvar("ui_longshot_dist", killdist);
          self setclientomnvar("ui_longshot_special", islongshotspecial(attackerposition, victimstruct.origin, objweapon));
          break;
      }

      if(istrue(self.focus) || isDefined(self.focuslasttime) && isDefined(self.lastshotfiredtime) && self.lastshotfiredtime == self.focuslasttime && curtime - self.focuslasttime <= 6000) {
        self.modifiers["holdingbreath"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"holdbreath"));
      }

      if(scripts\mp\class::isweaponsilenced(objweapon)) {
        self.modifiers["silencedkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"silenced"));
      }

      if(istrue(victimstruct.stunnedblinded)) {
        self.modifiers["victimimpairedkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"hash_c7bef9ff3af2dead"));
        self.modifiers["detectedimpairedkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"hash_9a9737f7fd4326f"));
      }

      if(scripts\mp\weapons::grenadeheldatdeath()) {
        self.modifiers["clutchkill"] = 1;
      }

      if(scripts\mp\events::issurvivorkill(self)) {
        self.modifiers["low_health_kill"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"lowhealth"));
      }

      if(!self isonground()) {
        self.modifiers["airborne"] = 1;
      }

      if(self playermount() >= 0.5) {
        self.modifiers["mounted"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"mounted"));
      }

      if(self ishanging()) {
        self.modifiers["ledgehanging"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"ledgehanging"));
      }

      if(isbulletdamage) {
        self.modifiers["bullet_damage"] = 1;
        remainingammo = self getweaponammoclip(objweapon);

        if(remainingammo <= 0) {
          self.modifiers["last_bullet_kill"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"lastbullet"));
        }

        burstfirecount = objweapon.burstcount;
        var_31a90ef4f5a008a8 = objweapon.issemiauto || isDefined(burstfirecount) && burstfirecount == 1 || istrue(objweapon.var_a6463aeb77648bc0) && isplayerads();
        var_ff3b6faa21cbea11 = !istrue(var_31a90ef4f5a008a8) && objweapon.isauto;

        if(isDefined(var_ff3b6faa21cbea11) && istrue(var_ff3b6faa21cbea11)) {
          self.modifiers["full_auto_kill"] = 1;
          self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"full_auto_kill"));
        }

        if(isDefined(var_31a90ef4f5a008a8) && istrue(var_31a90ef4f5a008a8)) {
          self.modifiers["semi_auto_kill"] = 1;
          self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"semi_auto_kill"));
        }

        if(isDefined(burstfirecount) && burstfirecount > 1) {
          self.modifiers["burst_kill"] = 1;
          self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"burst_kill"));
        }

        if(scripts\mp\utility\player::isplayerads()) {
          var_4da4661d6f703308 = self function_c603bed3b1c8d11(self.currentprimaryweapon);

          if(var_4da4661d6f703308) {
            self.modifiers["tac_stance"] = 1;
            self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"hash_3d20b9f56f230af1"));
          } else {
            self.modifiers["ads"] = 1;
            self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"ads"));
          }
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hipfire"));
        }
      } else if(weapongroup == "weapon_wonder") {
        if(scripts\mp\utility\player::isplayerads()) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"ads"));
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hipfire"));
        }
      }

      if(scripts\mp\weapons::isstunnedorblinded()) {
        self.modifiers["impaired"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"enemystunned"));
      }

      if(scripts\mp\events::events_issliding()) {
        self.modifiers["slidekill"] = 1;
        self.modifiers["sliding"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"slide"));
      } else if(self isonladder()) {
        self.modifiers["onladder"] = 1;
        self.modifiers["mask3"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask3"], function_e2ff8f4b4e94f723(#"hash_7f94e61c1787fc14", #"onladder"));
      } else if(scripts\mp\events::function_78dbf8d8bcbed882(self, objweapon)) {
        self.modifiers["jumpkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"jumpkill"));
      }

      vehicle = scripts\cp_mp\utility\player_utility::getvehicle(1);

      if(!isDefined(vehicle)) {
        stance = self getstance();

        switch (stance) {
          case #"hash_c6775c88e38f7803":
            self.modifiers["standing_kill"] = 1;
            self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"standing"));
            break;
          case #"hash_d91940431ed7c605":
            self.modifiers["prone_kill"] = 1;
            self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"prone"));
            break;
          case #"hash_3fed0cbd303639eb":
            self.modifiers["crouch_kill"] = 1;
            self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"crouch"));
            break;
        }
      }
    } else if(weapongroup == "weapon_projectile") {
      if(isDefined(inflictor) && isDefined(inflictor.adsfire)) {
        if(inflictor.adsfire) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"ads"));
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hipfire"));
        }
      }
    }

    vehicle = scripts\cp_mp\utility\player_utility::getvehicle(1);

    if(isDefined(vehicle)) {
      self.modifiers["in_vehicle"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"invehicle"));
    }

    if(isDefined(inflictor) && istrue(inflictor.isequipment) && meansofdeath == "MOD_IMPACT" && !isthrowingknife(objweapon)) {
      self.modifiers["item_impact"] = 1;
    }

    if(scripts\mp\utility\damage::islauncherdirectimpactdamage(objweapon, meansofdeath)) {
      self.modifiers["launcher_impact"] = 1;
    }

    if(scripts\mp\utility\damage::islauncherdirectimpactdamage(objweapon, meansofdeath, 1)) {
      self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"launcher_impact"));
    }

    if(isDefined(self.lastadsstarttime) && curtime - self.lastadsstarttime <= 500 && (weapongroup == "weapon_sniper" || weapongroup == "weapon_dmr")) {
      self.modifiers["quickscope"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"quickscope"));
    }

    if(isDefined(self.lastweaponchangetime) && curtime - self.lastweaponchangetime <= 2500) {
      self.modifiers["weapon_change_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"weaponswap"));
    }

    if(isDefined(self.lastreloadtime) && curtime - self.lastreloadtime <= 5000) {
      self.modifiers["reload_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"recentreload"));
    }

    if(isDefined(self.var_887efc1f015b6a78) && curtime - self.var_887efc1f015b6a78 <= 5000) {
      self.modifiers["after_sprint_kill"] = 1;
      self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"after_sprint_kill"));
    }

    if(isDefined(self.secondaryweaponobj) && objweapon == self.secondaryweaponobj) {
      self.modifiers["secondary_weapon"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"usingsecondaryweapon"));
    }

    if(istrue(self.inlaststand)) {
      self.modifiers["last_stand"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"laststand"));
    }

    if(self isinvehicleleanout()) {
      self.modifiers["vehiclelean"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"vehiclelean"));
    }

    if(meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT" || weaponclass(objweapon) == "spread") {
      thread function_670f85d113f86acb();

      if(!isDefined(self.var_39a4aa8a028cb36e)) {
        self.var_39a4aa8a028cb36e = 1;
      } else {
        self.var_39a4aa8a028cb36e++;

        if(self.var_39a4aa8a028cb36e >= 2) {
          scripts\mp\events::function_c5f08330d9923476(self.var_39a4aa8a028cb36e);

          if(self.var_39a4aa8a028cb36e >= 3) {
            function_484194ec6ace15bb("one_shot_three_kills", 1, 0, objweapon);
          }
        }
      }
    }

    if(isDefined(meansofdeath)) {
      switch (meansofdeath) {
        case #"hash_d8646db4e6ee3658":
          self.modifiers["fire_damage"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"fire"));
          break;
        case #"hash_b1078ff213fddba6":
          self.modifiers["impact_damage"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"equipmentimpact"));
          break;
        case #"hash_abb1587cdc6def23":
          self.modifiers["crush_damage"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"crush"));
          break;
        default:
          break;
      }
    }

    if(isDefined(objweapon.basename) && issubstr(objweapon.basename, "molotov") || issubstr(objweapon.basename, "thermite") || scripts\cp_mp\dragonsbreath::isdragonsbreathweapon(objweapon) || scripts\cp_mp\crossbow::isthermitecrossbow(objweapon)) {
      self.modifiers["fire_damage"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"fire"));
    }

    if(isDefined(inflictor) && isDefined(inflictor.equipmentref)) {
      if(inflictor.equipmentref == "equip_c4" || inflictor.equipmentref == "equip_claymore") {
        stuckto = inflictor getlinkedparent();

        if(isDefined(stuckto) && isDefined(stuckto.helperdronetype) && stuckto.helperdronetype == "radar_drone_recon") {
          self.modifiers["recon_drone_explosive"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"recondroneexplosive"));

          if(level.challengesallowed && isDefined(stuckto.owner)) {
            self.recondroneteammate = stuckto.owner;
          }
        } else if(isDefined(stuckto) && stuckto scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          self.modifiers["vehicle_explosive"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"vehicleexplosive"));

          if(stuckto scripts\common\vehicle::ishelicopter()) {
            self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"helicopter_explosive"));
          }
        }
      }
    }

    if(scripts\mp\utility\weapon::isvehicleweapon(objweapon) && meansofdeath == "MOD_EXPLOSIVE") {
      self.modifiers["vehicle_explosive"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"vehicleexplosive"));

      if(function_858ed945747dfb28(objweapon)) {
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"helicopter_explosive"));
      }
    }

    if(scripts\cp_mp\armor::hasarmor()) {
      self.modifiers["wearingarmor"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"wearingarmor"));
    }

    if(scripts\cp_mp\armor::function_9bca5c1d23a3e0b3()) {
      self.modifiers["fullarmor"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"fullarmor"));
    }

    if(isDefined(objweapon.scope)) {
      var_7a4444efa68407fa = objweapon.scope;
      basetype = getattachmentbasetype(objweapon, var_7a4444efa68407fa);

      if(basetype == "ironsdefault") {
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["attachment_flags"], function_e2ff8f4b4e94f723(#"hash_1ce058287dc8c73b", #"irons"));
      } else if(basetype == "reflex" || basetype == "minireflex") {
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["attachment_flags"], function_e2ff8f4b4e94f723(#"hash_1ce058287dc8c73b", #"reflex"));
      } else if(basetype == "hybrid") {
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["attachment_flags"], function_e2ff8f4b4e94f723(#"hash_1ce058287dc8c73b", #"hybrid"));
      } else if(basetype == "acog") {
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["attachment_flags"], function_e2ff8f4b4e94f723(#"hash_1ce058287dc8c73b", #"acog"));
      } else if(basetype == "holo") {
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["attachment_flags"], function_e2ff8f4b4e94f723(#"hash_1ce058287dc8c73b", #"holo"));
      }

      if(function_ec9cd761df1a3271(objweapon, var_7a4444efa68407fa)) {
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["attachment_flags"], function_e2ff8f4b4e94f723(#"hash_1ce058287dc8c73b", #"thermal"));
      }
    }

    usingsuppressor = objweapon issilenced();

    if(istrue(usingsuppressor)) {
      self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["attachment_flags"], function_e2ff8f4b4e94f723(#"hash_1ce058287dc8c73b", #"suppressor"));
    }

    if(meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH") {
      if(isDefined(inflictor.iscooked) && inflictor.iscooked) {
        self.modifiers["with_cooked_grenade_kill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"hash_5b4eb501eaf86d4e"));
      }
    }

    scripts\mp\events::function_245eb5b8f095001b(objweapon, meansofdeath, inflictor);
    zoomlevel = self playergetzoomfov();

    if(isDefined(zoomlevel) && zoomlevel <= 22) {
      self.modifiers["extreme_magnification_kill"] = 1;
      self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"extreme_magnification_kill"));
    }

    if(istrue(objweapon.isalternate)) {
      self.modifiers["isaltmode"] = 1;
      self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"isaltmode"));
    }

    if(self isswimming()) {
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"swimming"));

      if(self isswimunderwater()) {
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"underwater"));
      }
    }
  }
}

function function_670f85d113f86acb() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("watchForMoreBulletKillsInAFrameAE");
  self endon("watchForMoreBulletKillsInAFrameAE");
  wait 0.1;
  self.var_39a4aa8a028cb36e = 0;
}

function function_fbb73b9050299404(victimstruct, objweapon, meansofdeath, curtime, weapongroup) {
  if(weapongroup == "other" || weapongroup == "weapon_projectile") {
    return false;
  }

  if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXPLOSIVE") {
    return false;
  }

  if(isDefined(victimstruct.var_ec0a5c743cc6a4da) && isDefined(victimstruct.killedtime)) {
    timediff = abs(victimstruct.var_ec0a5c743cc6a4da - victimstruct.killedtime);

    if(timediff <= 25) {
      return true;
    }
  }

  return false;
}