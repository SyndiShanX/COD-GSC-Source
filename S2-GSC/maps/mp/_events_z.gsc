/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_events_z.gsc
*********************************************/

func_00D5() {
  initialize_contract_tracking();
}

initialize_contract_tracking() {
  register_unique_kill_func(undefined, ::maps\mp\_achievement_engine_z_utils::get_player_current_ability, undefined, "Player Mod");
  register_unique_kill_func("player_electrical_kills", ::maps\mp\_achievement_engine_z_utils::is_damage_electrical, 5, "Is Electrical");
  register_unique_kill_func(undefined, ::is_zombies_s_mine, 11, "Is S-Mine");
  register_unique_kill_func("player_zombie_kills_no_ammo", ::has_no_primary_ammo, 6, "Has No Ammo");
  register_unique_kill_func("player_zombie_kills_only_melee", ::zombie_died_from_melee_only, 9, "Zombie Died From Only Melee");
  register_unique_kill_func("player_zombie_kills_wustlings_charging", ::is_charging_wustling, 10, "Charging Wustling");
  register_unique_kill_func("player_zombie_kills_bombers_no_explosion", ::is_unexploded_bomber, 7, "Unexploded Bomber");
  register_unique_kill_func(undefined, ::is_throwing_knife, 12, "Throwing Knife");
  register_unique_kill_func(undefined, ::assassin_charge_kill, 22, "Razergun charge");
  register_unique_kill_func(undefined, ::is_zombie_exploder_bomb, 8, "Bomber Bomb");
  register_unique_kill_func(undefined, ::is_ripsaw_non_heavy_death, 23, "Non Heavy melee");
  register_unique_kill_func(undefined, ::is_ripsaw_heavy_death, 27, "Heavy melee");
  register_unique_kill_func(undefined, ::is_player_airborne, 24, "Airbourne");
  register_unique_kill_func(undefined, ::get_number_unique_kills, undefined, "Unique Kills");
  register_unique_kill_func("player_zombie_heavy_melee_kills", ::is_any_heavy_melee_death, 28, "zombie Kills with heavy melee");
  register_unique_kill_func("player_zombie_kills_sacrifice", ::zombie_was_sacrificed, 29, "zombie was sacrificed");
  register_unique_kill_func("player_zombie_kills_wet_zombies", ::lib_0547::is_wet_zombie, 20, "zombie was drowned");
  register_unique_kill_func(undefined, ::lib_0547::is_jack_box, 30, "jack in box kill");
  create_new_contract_type("wave_survival", "survival_starting_weapons", ::contract_validate_weapon_used, [::get_next_player_weapon, ::get_weapon_on_round_change], get_player_starter_weapons(), "Survive Usings Starter Weapons");
  create_new_contract_type("wave_survival", "survival_no_damage", ::contract_fail_on_player_damage, [::wait_for_player_dmg], undefined, "Survive Without Taking damage");
  create_new_contract_type("wave_survival", "survival_shotgun", ::contract_validate_weapon_used, [::get_next_player_weapon, ::get_weapon_on_round_change], "weapon_shotgun", "Survive With Only ShotGun");
  create_new_contract_type("wave_survival", "survival_no_move", ::contract_fail_on_player_move, [::lib_0547::func_A6F6], undefined, "Survive Without Moving");
  create_new_contract_type("wave_survival", "survival_one_area_only", ::contract_fail_on_zone_change, [::lib_0547::func_A6F6], undefined, "Survive Single Area");
  create_new_contract_type("wave_survival", "survival_first_area", ::contract_fail_on_new_zone, [::lib_0547::func_A6F6], undefined, "First Area");
  create_new_contract_type("wave_survival", "survival_crouched", ::contract_fail_on_not_crouched, [::lib_0547::func_A6F6], undefined, "Crouched");
  level thread maps\mp\_utility::func_6F74(::assigncontractsfirstboxweapon);
  create_new_contract_type("wave_survival", "survival_first_box_only", ::contract_validate_weapon_used, [::get_next_player_weapon, ::get_weapon_on_round_change], "no_box_weapon", "Survive Using First Weapon From Box");
  add_area_contract(["zone1_4_bridge_tower"]);
  add_area_contract(["zone3_2_med"]);
  add_area_contract(["high_canon"]);
  add_area_contract(["sub_pens_1_zone"]);
  add_generic_contract("zombie_purchases", "player_perk_count", "Current Perk Count");
  add_generic_contract("zombie_purchases", "player_perk_count_unique", "Unique Perks This Game");
  add_generic_contract("zombie_purchases", "player_armor_count", "Purchased Armor");
  add_generic_contract("player_actions", "player_teammate_revives_single_session", "Revivals This Game");
  add_generic_contract("player_actions", "player_teammate_revives_unique", "Unique Player Revivals This Game");
  add_generic_contract("player_actions", "player_teammate_revives_camoflauge", "revive Players While In Camo");
  add_generic_contract("player_actions", "player_harvest_spines", "Spines Harvested");
  add_generic_contract("wave_survival", "survival_basic", "Survive.");
  add_generic_contract("player_actions", "player_distance_traveled_zombie_threat", "Run! (from zombies)");
  add_generic_contract("player_actions", "player_time_traveled_frontline", "Distrace Zombies With FrontLine");
  add_generic_contract("player_actions", "player_zombie_shellshock_stun", "Zombies Shellshocked");
  add_generic_contract("player_actions", "player_zombie_aquire_jolts", "Jolts Gained");
  add_generic_contract("player_actions", "player_zombie_kills_after_wave_10", "Zombie Kills After Wave 10");
  add_generic_contract("player_actions", "player_zombie_kills_on_wave_0", "Island- Zombie Kills On Wave 0");
  add_generic_contract("player_actions", "player_zombie_kills_in_air", "Zombie Kills In Air");
  add_generic_contract("player_actions", "player_zombie_heavy_melee_kills", "zombie Kills with heavy melee");
  add_generic_contract("player_actions", "player_zombie_aquire_weapon_from_box", "Last Weapon From Box");
  add_generic_contract("player_actions", "player_zombie_kills_unique_types", "Player Aquired Unique kills");
  add_generic_contract("player_actions", "player_rode_minecart", "Times Player Rode Cart");
  add_generic_contract("player_actions", "player_stuka_kills", "Player Stuka Kills");
  add_generic_contract("player_actions", "player_electrical_kills", "Player Electrical Kills");
  add_generic_contract("player_actions", "player_zombie_kills_no_ammo", "Player Kills No Ammo");
  add_generic_contract("player_actions", "player_zombie_kills_only_melee", "Player Kills Only Melee");
  add_generic_contract("player_actions", "player_zombie_kills_wustlings_charging", "Player Kills Charging Wustlings");
  add_generic_contract("player_actions", "player_zombie_kills_fireman_tank", "Player Kills Fireman Tank");
  add_generic_contract("player_actions", "player_zombie_kills_bombers_no_explosion", "Player Kills Bomber-No Explosion");
  add_generic_contract("zombie_purchases", "player_armor_count_round", "Aquire Armor In Round");
  add_generic_contract("player_actions", "player_zombie_kills_traps", "Trap kills");
  add_generic_contract("player_actions", "player_zombie_kills_traps_specific", "Specific Trap kills");
  add_generic_contract("player_actions", "player_zombie_kills_sacrifice", "Sacrifice");
  level.orders_and_contracts_event_report = [];
  orders_and_contracts_challenge_init("any_objective_completed", ::mp_zombie_objective_completed);
  orders_and_contracts_challenge_init("any_boss_completed", ::mp_zombie_boss_completed);
  orders_and_contracts_challenge_init("any_boss_completed_small", ::mp_zombie_boss_completed_small);
  orders_and_contracts_challenge_init("mp_zombie_nest_01_tower_battle", ::mp_zombie_nest_01_tower_battle_report_efficiency);
  orders_and_contracts_challenge_init("mp_zombie_nest_01_final_boss", ::mp_zombie_nest_01_final_boss_report_completion);
  orders_and_contracts_challenge_init("mp_zombie_island_final_boss", ::mp_zombie_island_final_boss_report_completion);
  orders_and_contracts_challenge_init("mp_zombie_berlin_final_boss", ::mp_zombie_berlin_final_boss_report_completion);
  orders_and_contracts_challenge_init("mp_zombie_island_corpsegate_open", ::mp_zombie_island_corpse_gate_report_completion);
  orders_and_contracts_challenge_init("geistcraft_device_powered", ::mp_zombie_geistcraft_device_powered);
  initialize_per_player_tracking();
  common_scripts\utility::func_3C87("zmb_contracts_boss_battle_active");
  level.zmb_events_powerup_collected = ::contracts_report_player_collected_powerup;
  level.zmb_events_upgraded_a_weapon = ::contracts_report_player_upgraded_weapon;
  level thread contracts_report_players_opened_map();
  level.zmb_events_purchase_callback = ::contracts_report_player_completed_purchase;
  level.zmb_events_player_on_teammate_revived = ::contracts_report_player_preformed_revive;
  level.zmb_events_player_zombie_spine_harvest = ::contracts_report_player_harvested_spine;
  level.zmb_events_player_zombie_shellshock_stun = ::contracts_report_player_stunned_zombie;
  level.zmb_events_player_zombie_aquired_jolts = ::contracts_report_player_earned_money;
  level.zmb_events_player_zombie_weapon_from_box = ::contracts_report_player_aquired_weapon_from_box;
  level.zmb_events_player_rode_minecart = ::contracts_report_player_riding_minecart;
  level.zmb_events_player_destroyed_stuka = ::contracts_report_player_destoyed_stuka;
  level.zmb_events_player_destoyed_brenner_gas_tank = ::contracts_report_player_destoyed_brenner_gas_tank;
  level thread maps\mp\_utility::func_6F74(::contracts_consecutive_waves_tracking);
  level thread maps\mp\_utility::func_6F74(::contracts_distance_traveled_tracking);
  level thread maps\mp\_utility::func_6F74(::contracts_time_traveled_tracking);
  level thread maps\mp\_utility::func_6F74(::contracts_start_track_boss_battle_laststand);
  lib_0547::register_postenemykilledfunc(::contracts_zombies_death_tracking);
  level.zmb_events_on_map_won = ::mp_zombie_map_won;
  lib_054D::func_7BC6(::report_player_zombie_damage);
}

func_0F4C() {
  if(!isDefined(level.var_AC1D)) {
    return 0;
  }

  var_00 = [];
  foreach(var_02 in level.var_AC1D) {
    if(common_scripts\utility::func_562E(var_02.is_quest_door)) {
      continue;
    }

    if(isDefined(var_02.var_819A) && issubstr(var_02.var_819A, "airship_")) {
      continue;
    }

    var_00 = common_scripts\utility::func_0F6F(var_00, var_02);
  }

  foreach(var_02 in var_00) {
    if(!common_scripts\utility::func_562E(var_02.var_6BE1)) {
      return 0;
    }
  }

  return 1;
}

report_player_zombie_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_05)) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(!isDefined(param_01.recent_weapon_damage)) {
    param_01.recent_weapon_damage = [];
  }

  if(!isDefined(param_01.recent_weapon_locs)) {
    param_01.recent_weapon_locs = [];
  }

  param_01.recent_weapon_damage = common_scripts\utility::func_0F6F(param_01.recent_weapon_damage, param_05);
  param_01.recent_weapon_locs = common_scripts\utility::func_0F6F(param_01.recent_weapon_locs, [param_05, param_08]);
  param_01 thread report_weapons_used();
}

report_weapons_used() {
  var_00 = self;
  var_00 notify("new_report_weapons_used");
  var_00 endon("new_report_weapons_used");
  wait 0.05;
  var_00.recent_weapon_damage = common_scripts\utility::func_0F97(var_00.recent_weapon_damage);
  var_00 notify("weapons_used", var_00.recent_weapon_damage, var_00.recent_weapon_locs);
  var_00.recent_weapon_damage = [];
  var_00.recent_weapon_locs = [];
}

assigncontractsfirstboxweapon(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  if(!isDefined(param_00)) {
    var_02 = "magicBoxUse1";
  } else {
    var_02 = "magicBoxUse" + var_01;
  }

  var_01 waittill(var_02, var_03);
  if(!isDefined(var_01.contractsboxattempts)) {
    var_01.contractsboxattempts = 1;
  }

  var_01.contractsboxattempts++;
  foreach(var_05 in var_01.active_contract_tracker["wave_survival"]) {
    switch (var_05.condition) {
      case "survival_first_box_only":
        if(!lib_0547::func_585C(lib_0547::func_AAF9(var_03))) {
          var_05.var_6E55 = [];
          var_05.var_6E55[0] = lib_0547::func_AAF9(var_03);
          var_05.var_6E55[1] = lib_0586::func_078B(var_03);
        } else {
          var_01 thread assigncontractsfirstboxweapon(var_01.contractsboxattempts);
        }
        break;
    }
  }
}

contracts_report_player_completed_purchase(param_00, param_01, param_02) {
  param_00 player_purchase_report_collection(param_00, param_01);
  param_00 maps\mp\_achievement_engine_z_utils::ae_zm_purchasejoltsevent(param_00, param_01);
}

contracts_report_player_collected_powerup(param_00, param_01) {
  maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(param_00, "player_zombie_powerup_collected");
}

contracts_report_player_upgraded_weapon(param_00) {
  maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(param_00, "player_zombie_upgrade_weapon");
}

contracts_report_players_opened_map() {
  while(!func_0F4C()) {
    wait 0.05;
  }

  foreach(var_01 in level.var_744A) {
    maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_01, "player_zombie_all_doors_opened");
  }
}

player_purchase_report_collection(param_00, param_01) {
  var_02 = 0;
  var_03 = [];
  foreach(var_05 in param_00.active_contract_tracker["zombie_purchases"]) {
    switch (param_01) {
      case "perk_machine":
        switch (var_05.condition) {
          case "player_perk_count":
            if(var_05.var_005C != param_00.var_6F66.size) {
              var_05.var_005C = param_00.var_6F66.size;
              var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
            }
            break;

          case "player_perk_count_unique":
            param_00.session_unique_perks_zm = get_unique_perks_total(param_00.var_6F66, param_00.session_unique_perks_zm);
            if(var_05.var_005C != param_00.session_unique_perks_zm.size) {
              var_05.var_005C = param_00.session_unique_perks_zm.size;
              var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
            }
            break;

          default:
            break;
        }
        break;

      case "armor_booth":
        switch (var_05.condition) {
          case "player_armor_count":
            var_05.var_005C++;
            var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
            break;

          case "player_armor_count_round":
            var_05.var_005C++;
            var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
            break;
        }
        break;
    }
  }

  foreach(var_08 in var_03) {
    param_00 maps\mp\_achievement_engine_z_utils::ae_zm_purchasejoltsevent(param_00, param_01, var_08.condition, var_08.var_005C, var_08.condition);
  }

  return var_03.size > 0;
}

is_wave_0(param_00, param_01, param_02, param_03) {
  return level.var_A980 == 0;
}

is_after_wave_10(param_00, param_01, param_02, param_03) {
  return level.var_A980 >= 10;
}

assassin_charge_kill(param_00, param_01, param_02, param_03) {
  return param_01.var_0A4B == "zombie_assassin" && common_scripts\utility::func_562E(param_00.israzerguncharging) && razer_gun_melee_kill(param_00, param_01, param_02, param_03, 1);
}

is_zombie_exploder_bomb(param_00, param_01, param_02, param_03) {
  return lib_0547::func_5565(param_02, "drag_explosive_zombie_zm");
}

is_ripsaw_non_heavy_death(param_00, param_01, param_02, param_03) {
  return !common_scripts\utility::func_562E(param_01.var_0103) && razer_gun_melee_kill(param_00, param_01, param_02, param_03, 1);
}

is_ripsaw_heavy_death(param_00, param_01, param_02, param_03) {
  return common_scripts\utility::func_562E(param_01.var_0103) && razer_gun_melee_kill(param_00, param_01, param_02, param_03, 1);
}

is_any_heavy_melee_death(param_00, param_01, param_02, param_03) {
  return common_scripts\utility::func_562E(param_01.var_0103);
}

zombie_was_sacrificed(param_00, param_01, param_02, param_03) {
  return common_scripts\utility::func_562E(param_01.var_8F2B);
}

is_player_airborne(param_00, param_01, param_02, param_03) {
  return !param_00 isonground();
}

get_number_unique_kills(param_00, param_01, param_02, param_03) {
  param_00 get_num_unique_zombie_kills(param_01.var_0A4B);
  var_04 = undefined;
  switch (param_00.zombie_types_killed_list.size) {
    case 5:
      var_04 = 25;
      break;

    case 7:
      var_04 = 26;
      break;
  }

  return var_04;
}

is_sacrifice(param_00, param_01, param_02, param_03) {
  return common_scripts\utility::func_562E(param_01.var_8F2B);
}

razer_gun_melee_kill(param_00, param_01, param_02, param_03, param_04) {
  if(param_03 != "MOD_MELEE") {
    return 0;
  }

  if(common_scripts\utility::func_562E(param_04)) {
    return common_scripts\utility::func_0F79(["razergun_zm", "razergun_melee_zm", "razergun_pap_zm"], param_02);
  }

  return common_scripts\utility::func_0F79(["razergun_zm", "razergun_pap_zm"], param_02);
}

zmb_contracts_map_is_foggy() {
  return isDefined(level.zmb_contracts_get_map_fog_state) && [[level.zmb_contracts_get_map_fog_state]]();
}

is_unexploded_bomber(param_00, param_01, param_02, param_03) {
  return param_01.var_0A4B == "zombie_exploder" && isDefined(param_01.var_349C);
}

weapon_is_trap(param_00, param_01, param_02, param_03) {
  return lib_0547::func_5565(param_02, "trap_zm_mp");
}

is_charging_wustling(param_00, param_01, param_02, param_03) {
  return param_01.var_0A4B == "zombie_heavy" && common_scripts\utility::func_562E(param_01.var_5542);
}

is_zombies_s_mine(param_00, param_01, param_02, param_03) {
  return lib_0547::func_5565(param_02, "bouncingbetty_zm");
}

is_throwing_knife(param_00, param_01, param_02, param_03) {
  return lib_0547::func_5565(param_02, "throwingknife_zm");
}

zombie_died_from_melee_only(param_00, param_01, param_02, param_03) {
  return !common_scripts\utility::func_562E(param_01.has_taken_bullet_damage) && param_03 == "MOD_MELEE";
}

has_no_primary_ammo(param_00, param_01, param_02, param_03) {
  var_04 = param_00 getweaponslistprimaries();
  foreach(param_02 in var_04) {
    if(param_00 method_817F(param_02) > 0) {
      return 0;
    }
  }

  return 1;
}

get_trap_value_for_name(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "trap_sub":
      var_01 = 13;
      break;

    case "trap_spike":
      var_01 = 14;
      break;

    case "trap_firewell":
      var_01 = 15;
      break;

    case "trap_rnd":
      var_01 = 16;
      break;

    case "trap_med":
      var_01 = 17;
      break;

    case "trap_catacombs":
      var_01 = 18;
      break;

    case "trap_roof":
      var_01 = 19;
      break;
  }

  return var_01;
}

register_unique_kill_func(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.register_unique_kill_funcs)) {
    level.register_unique_kill_funcs = [];
  }

  var_04 = spawnStruct();
  var_04.var_502A = param_00;
  var_04.var_3F02 = param_01;
  var_04.var_A281 = param_02;
  var_04.debugname = param_03;
  level.register_unique_kill_funcs = common_scripts\utility::func_0F6F(level.register_unique_kill_funcs, var_04);
}

contracts_zombies_death_tracking(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = self;
  var_0A = [];
  if(common_scripts\utility::func_562E(var_09.var_5A3D)) {
    param_01 = common_scripts\utility::func_4461(var_09.var_0116, level.var_744A);
  }

  if(param_04 == "turretweapon_zeppelin_gun_zm") {
    param_01 = common_scripts\utility::func_4461(var_09.var_0116, level.var_744A);
  }

  if(param_04 == "drag_explosive_zombie_zm") {
    param_01 = param_00.var_0117;
  }

  if(param_04 == "trap_zm_mp") {
    if(isDefined(param_00.var_0117)) {
      param_01 = param_00.var_0117;
    } else {
      param_01 = param_00.var_9C92.var_0117;
    }
  }

  if(isDefined(param_00.var_9CBB)) {
    var_0A = common_scripts\utility::func_0F6F(var_0A, get_trap_value_for_name(param_00.var_9CBB));
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  param_01 maps\mp\_achievement_engine_z_utils::ae_zm_sendkillevent(var_09, var_09.var_0A4B, maps\mp\_utility::func_4431(param_04), param_03, param_06, var_0A);
  if(param_01 zombies_multikill(var_09, param_04, param_03)) {
    param_01 maps\mp\_achievement_engine_z_utils::ae_zm_sendmultikillevent(param_01.playerzombiemultikilldata);
    param_01.playerzombiemultikilldata = undefined;
  }
}

contracts_tracking_init(param_00) {
  var_01 = self;
  foreach(var_03 in param_00) {
    foreach(var_05 in level.zmb_unique_zombie_contracts[var_03]) {
      var_01 initialize_player_zombies_contract(var_05);
    }
  }
}

contracts_consecutive_waves_tracking() {
  var_00 = self;
  var_00 endon("disconnect");
  foreach(var_02 in level.zmb_unique_zombie_contracts_reset_funcs["wave_survival"]) {
    var_00 childthread watch_progress_clear(var_02.reset_func_array, "wave_survival", var_02.condition);
  }

  for(;;) {
    level waittill("round complete");
    foreach(var_05 in var_00.active_contract_tracker["wave_survival"]) {
      var_05.var_005C++;
    }

    foreach(var_05 in var_00.active_contract_tracker["zombie_purchases"]) {
      switch (var_05.condition) {
        case "player_armor_count_round":
          var_05.var_005C = 0;
          break;
      }
    }

    level notify("wave_survival");
    lib_0547::func_A6F6();
    maps\mp\_achievement_engine_z_utils::ae_sendwavesurvivalevent_zm(var_00, "survival_wave_single");
    foreach(var_05 in var_00.active_contract_tracker["wave_survival"]) {
      maps\mp\_achievement_engine_z_utils::ae_sendwavesurvivalevent_zm(var_00, var_05.condition, var_05.var_005C, var_05.var_6E55);
    }
  }
}

contracts_distance_traveled_tracking() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = 5;
  var_02 = var_01;
  var_03 = 5;
  var_04 = spawnStruct();
  var_04.updatetravelfleeingzombie = 0;
  for(;;) {
    wait(var_03);
    var_05 = int(var_00.var_3036 * 0.00158);
    if(var_05 >= var_02) {
      var_02 = var_02 + var_01;
      foreach(var_07 in var_00.active_contract_tracker["player_actions"]) {
        if(var_07.condition == "player_distance_traveled_zombie_threat") {
          if(var_00 is_being_chased_by_zombie()) {
            var_04.updatetravelfleeingzombie = 1;
            var_07.var_005C = var_07.var_005C + var_01;
          }
        }
      }

      var_00 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_00, "player_distance_traveled_zombie_threat", var_04);
      var_04.updatetravelfleeingzombie = 0;
    }
  }
}

contracts_time_traveled_tracking() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = spawnStruct();
  var_01.updatetravelfrontline = 0;
  var_02 = 1;
  var_03 = 60;
  for(;;) {
    wait(1);
    foreach(var_05 in var_00.active_contract_tracker["player_actions"]) {
      if(var_05.condition == "player_time_traveled_frontline") {
        if(var_00 get_current_active_ability() == "role_ability_taunt_zm" && var_00 is_being_chased_by_zombie()) {
          var_05.var_005C = var_05.var_005C + var_02;
          if(var_05.var_005C >= var_03) {
            var_03 = var_03 + 60;
            var_01.updatetravelfrontline = 1;
            var_00 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_00, "player_distance_traveled_zombie_threat", var_01);
            var_01.updatetravelfrontline = 0;
          }
        }
      }
    }
  }
}

contracts_report_player_preformed_revive(param_00, param_01) {
  var_02 = param_01;
  var_03 = spawnStruct();
  var_03.player_revives_this_session = undefined;
  var_03.player_revives_unique = undefined;
  var_03.player_revives_camo = undefined;
  foreach(var_05 in var_02.active_contract_tracker["player_actions"]) {
    switch (var_05.condition) {
      case "player_teammate_revives_single_session":
        var_05.var_005C++;
        var_03.player_revives_this_session = var_05.var_005C;
        break;

      case "player_teammate_revives_unique":
        if(!common_scripts\utility::func_0F79(var_02.session_unique_player_revives_zm, param_00)) {
          var_02.session_unique_player_revives_zm = common_scripts\utility::func_0F6F(var_02.session_unique_player_revives_zm, param_00);
        }

        if(var_05.var_005C != var_02.session_unique_player_revives_zm.size) {
          var_05.var_005C = var_02.session_unique_player_revives_zm.size;
          var_03.player_revives_unique = var_05.var_005C;
        }
        break;

      case "player_teammate_revives_camoflauge":
        if(var_02 get_current_active_ability() == "role_ability_camo_zm") {
          var_03.player_revives_camo = 1;
          var_05.var_005C++;
        }
        break;

      default:
        break;
    }
  }

  var_02 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_02, "player_teammate_revives", var_03);
}

contracts_report_player_harvested_spine(param_00, param_01) {
  var_02 = self;
  foreach(var_04 in var_02.active_contract_tracker["player_actions"]) {
    switch (var_04.condition) {
      case "player_harvest_spines":
        var_04 increment_contract_array(param_00);
        var_02 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_02, var_04.condition, param_00);
        break;
    }
  }
}

contracts_report_player_stunned_zombie(param_00) {
  var_01 = self;
  foreach(var_03 in var_01.active_contract_tracker["player_actions"]) {
    switch (var_03.condition) {
      case "player_zombie_shellshock_stun":
        var_03.var_005C = var_03.var_005C + param_00;
        for(var_04 = 0; var_04 < param_00; var_04++) {
          var_01 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_01, "player_zombie_shellshock_stun", param_00);
        }
        break;
    }
  }
}

contracts_report_player_earned_money(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01)) {
    return;
  }

  var_02 = self;
  foreach(var_04 in var_02.active_contract_tracker["player_actions"]) {
    switch (var_04.condition) {
      case "player_zombie_aquire_jolts":
        var_04.var_005C = var_04.var_005C + param_00;
        var_02 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_02, "player_zombie_aquire_jolts", var_04.var_005C, 1);
        break;
    }
  }
}

contracts_report_player_special_kills(param_00, param_01, param_02, param_03, param_04) {
  var_05 = common_scripts\utility::func_562E(param_00.var_0103);
  var_06 = self;
  foreach(var_08 in var_06.active_contract_tracker["player_actions"]) {
    switch (var_08.condition) {}
  }
}

contracts_report_player_picked_up_fish() {
  var_00 = self;
  maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_00, "player_zombie_collect_fish");
}

contracts_report_player_aquired_weapon_from_box(param_00) {
  var_01 = self;
  foreach(var_03 in var_01.active_contract_tracker["player_actions"]) {
    switch (var_03.condition) {
      case "player_zombie_aquire_weapon_from_box":
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_01, "player_zombie_aquire_weapon_from_box", maps\mp\_utility::func_4431(param_00));
        break;
    }
  }
}

contracts_report_player_riding_minecart() {
  var_00 = self;
  foreach(var_02 in var_00.active_contract_tracker["player_actions"]) {
    switch (var_02.condition) {
      case "player_rode_minecart":
        var_02.var_005C++;
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_00, "player_rode_minecart");
        break;
    }
  }
}

contracts_report_player_destoyed_stuka() {
  var_00 = self;
  foreach(var_02 in var_00.active_contract_tracker["player_actions"]) {
    switch (var_02.condition) {
      case "player_stuka_kills":
        var_02.var_005C++;
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_00, "player_stuka_kills");
        break;
    }
  }
}

contracts_report_player_destoyed_brenner_gas_tank() {
  var_00 = self;
  foreach(var_02 in var_00.active_contract_tracker["player_actions"]) {
    switch (var_02.condition) {
      case "player_zombie_kills_fireman_tank":
        var_02.var_005C++;
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_00, "player_zombie_kills_fireman_tank");
        break;
    }
  }
}

mp_zombie_nest_01_tower_battle_report_efficiency(param_00) {
  var_01 = 85;
  var_02 = 1;
  if(maps\mp\_utility::func_4571() == "mp_zombie_nest_01") {
    var_02 = 2;
  }

  if(param_00 < var_01) {
    self.var_39D8 = 1;
  }

  if(!isDefined(self.var_005C)) {
    self.var_005C = 0;
  }

  self.var_005C++;
  if(self.var_005C == var_02 && !common_scripts\utility::func_562E(self.var_39D8)) {
    level thread quest_contracts_completed(self.var_0109);
  }
}

mp_zombie_nest_01_final_boss_report_completion(param_00) {
  level thread quest_contracts_completed(self.var_0109, param_00);
}

mp_zombie_island_final_boss_report_completion() {
  level thread quest_contracts_completed(self.var_0109);
}

mp_zombie_island_corpse_gate_report_completion() {
  level thread quest_contracts_completed(self.var_0109);
}

mp_zombie_geistcraft_device_powered() {
  level thread quest_contracts_completed(self.var_0109);
}

mp_zombie_berlin_final_boss_report_completion() {
  level thread quest_contracts_completed(self.var_0109);
}

mp_zombie_objective_completed() {
  level thread quest_contracts_completed(self.var_0109);
}

mp_zombie_boss_completed() {
  level thread quest_contracts_completed(self.var_0109);
}

mp_zombie_boss_completed_small() {
  level thread quest_contracts_completed(self.var_0109);
}

quest_contracts_completed(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    var_03 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_03, param_00, param_01);
  }
}

orders_and_contracts_challenge_init(param_00, param_01) {
  level.orders_and_contracts_event_report[param_00] = spawnStruct();
  level.orders_and_contracts_event_report[param_00].var_0109 = param_00;
  level.orders_and_contracts_event_report[param_00].var_1E61 = param_01;
}

is_contracts_game_online() {
  return level.var_6B4D || get_testing_contracts_offline();
}

get_testing_contracts_offline() {
  var_00 = 0;
  return var_00;
}

initialize_player_zombies_contract(param_00) {
  var_01 = self;
  if(!isDefined(var_01.active_contract_tracker)) {
    var_01.active_contract_tracker = [];
  }

  var_02 = spawnStruct();
  var_02.var_6E55 = param_00.var_6E55;
  var_02.condition = param_00.condition;
  var_02.var_005C = 0;
  var_02.complete = 0;
  var_02.var_0109 = param_00.var_0109;
  var_02.var_3F02 = param_00.var_3F02;
  var_02.var_01B9 = param_00.var_01B9;
  if(!isDefined(var_01.active_contract_tracker[var_02.var_01B9])) {
    var_01.active_contract_tracker[var_02.var_01B9] = [var_02];
    return;
  }

  var_01.active_contract_tracker[var_02.var_01B9] = common_scripts\utility::func_0F6F(var_01.active_contract_tracker[var_02.var_01B9], var_02);
}

watch_progress_clear(param_00, param_01, param_02) {
  var_03 = self;
  if(!isDefined(param_00)) {
    return;
  }

  foreach(var_05 in param_00) {
    var_03 childthread run_reset_func_array(var_05, param_01, param_02);
  }
}

run_reset_func_array(param_00, param_01, param_02) {
  try_stat_reset(param_01, param_02, param_00);
}

try_stat_reset(param_00, param_01, param_02) {
  var_03 = [[param_02]]();
  foreach(var_05 in self.active_contract_tracker[param_00]) {
    if(lib_0547::func_5565(var_05.condition, param_01) && !validate_contract_rule(var_05, var_03)) {
      var_05.var_005C = 0;
    }
  }
}

validate_contract_rule(param_00, param_01) {
  return ![[param_00.var_3F02]](param_00, param_01);
}

add_generic_contract(param_00, param_01, param_02) {
  create_new_contract_type(param_00, param_01, undefined, undefined, undefined, param_02);
}

add_area_contract(param_00) {
  var_01 = "Survive in ";
  foreach(var_03 in param_00) {
    var_01 = var_01 + var_03 + " ";
  }

  create_new_contract_type("wave_survival", "survival_area", ::contract_fail_on_player_leave_area, [::lib_0547::func_A6F6], param_00, var_01);
}

contracts_init_player_member_variables() {
  var_00 = self;
  var_00.session_unique_perks_zm = [];
  var_00.session_unique_player_revives_zm = [];
  var_00.playerzombiemultikilldata = [];
  var_00.zombie_types_killed_list = [];
}

create_new_contract_type(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = "Zombie/^3Orders^7 and ^3Contracts^7/";
  var_07 = var_06 + "1 Track/";
  var_08 = spawnStruct();
  var_08.var_01B9 = param_00;
  var_08.var_0109 = param_05;
  var_08.condition = param_01;
  var_08.var_6E55 = param_04;
  var_08.var_3F02 = param_02;
  if(!isDefined(level.zmb_unique_zombie_contracts)) {
    level.zmb_unique_zombie_contracts = [];
  }

  if(!isDefined(level.zmb_unique_zombie_contracts_reset_funcs)) {
    level.zmb_unique_zombie_contracts_reset_funcs = [];
  }

  if(!isDefined(level.zmb_unique_zombie_contracts_reset_funcs[param_00])) {
    level.zmb_unique_zombie_contracts_reset_funcs[param_00] = [];
  }

  level.zmb_unique_zombie_contracts_reset_funcs[param_00][param_01] = spawnStruct();
  level.zmb_unique_zombie_contracts_reset_funcs[param_00][param_01].reset_func_array = param_03;
  level.zmb_unique_zombie_contracts_reset_funcs[param_00][param_01].condition = param_01;
  if(!isDefined(level.zmb_unique_zombie_contracts[param_00])) {
    level.zmb_unique_zombie_contracts[param_00] = [var_08];
    return;
  }

  level.zmb_unique_zombie_contracts[param_00] = common_scripts\utility::func_0F6F(level.zmb_unique_zombie_contracts[param_00], var_08);
}

get_player_starter_weapons() {
  while(!isDefined(level.zombiemeleeweapon)) {
    wait 0.05;
  }

  return lib_0547::get_zombies_mode_starter_weapons(1);
}

get_player_first_box_weapon() {
  if(isDefined(self.zmbcontractsfirstboxweapon)) {
    return self.zmbcontractsfirstboxweapon;
  }

  return "no_box_weapon";
}

get_current_active_ability() {
  if(common_scripts\utility::func_562E(self.var_983B)) {
    return "role_ability_taunt_zm";
  }

  if(common_scripts\utility::func_562E(self.var_569F)) {
    return "role_ability_camo_zm";
  }

  if(common_scripts\utility::func_562E(self.var_5F5C)) {
    return "role_ability_mad_minute_zm";
  }

  if(common_scripts\utility::func_3798("stunning_burst_active") && common_scripts\utility::func_3794("stunning_burst_active")) {
    return "role_ability_stunning_burst_zm";
  }

  return "none";
}

contract_fail_on_player_leave_area(param_00, param_01) {
  var_02 = self;
  return !var_02 lib_0547::player_validate_is_in_zones(param_00.var_6E55);
}

contract_validate_weapon_used(param_00, param_01, param_02) {
  var_03 = self;
  if(!isarray(param_01)) {
    param_01 = [param_01];
  }

  if(isarray(param_00)) {
    var_04 = "normal_weapon_check";
    var_05 = param_00;
  } else {
    var_04 = param_02.condition;
    if(isarray(param_01.var_6E55)) {
      var_05 = param_01.var_6E55;
    } else {
      var_05 = [param_01.var_6E55];
    }
  }

  if(common_scripts\utility::func_0F79(var_05, "no_box_weapon")) {
    return 1;
  }

  foreach(var_07 in param_01) {
    var_07 = var_03 set_last_checked_weapon(var_07);
    var_08 = 0;
    foreach(var_0A in var_05) {
      if(var_04 == "survival_shotgun") {
        var_0B = maps\mp\_utility::func_472A(lib_0547::zombies_to_mp(var_07), 1);
        if(lib_0547::func_5565(var_0B, param_00.var_6E55) || weapon_is_a_match(var_07, "p38_pap_zm")) {
          var_08 = 1;
        }

        continue;
      }

      if(var_03 weapon_is_a_match(var_07, var_0A)) {
        var_08 = 1;
      }
    }

    if(proceed_to_contract_progress_reset(var_08, var_07, 1)) {
      return 1;
    }
  }

  return 0;
}

weapon_is_a_match(param_00, param_01) {
  var_02 = self;
  if(param_00 == param_01) {
    return 1;
  }

  if(issubstr(param_00, "shovel") && issubstr(param_01, "shovel")) {
    return 1;
  }

  return 0;
}

set_last_checked_weapon(param_00) {
  var_01 = self;
  var_02 = "";
  if(!isDefined(var_01.lastweaponcheck)) {
    var_01 save_this_weapon(param_00);
  }

  var_03 = var_01.lastweaponcheckraw;
  var_04 = var_01.lastweaponcheck;
  if(lib_0547::func_5565(param_00, var_03)) {
    return var_04;
  } else {
    var_01 save_this_weapon(param_00);
  }

  return var_01.lastweaponcheck;
}

save_this_weapon(param_00) {
  var_01 = self;
  var_01.lastweaponcheckraw = param_00;
  var_01.lastweaponcheck = lib_0547::func_AAF9(param_00);
}

proceed_to_contract_progress_reset(param_00, param_01, param_02) {
  if(common_scripts\utility::func_562E(param_02)) {
    if(issubstr(param_01, "drag_explosive")) {
      return 0;
    }

    if(param_01 == "none") {
      return 0;
    }

    if(lib_0547::iszombieindirectweapon(param_01)) {
      return 0;
    }

    if(lib_0547::func_5866(param_01) || lib_0547::func_5863(param_01) && !lib_0547::func_5565(param_01, "alt+wunderbuss_zm")) {
      return 0;
    }
  }

  return !param_00;
}

contract_fail_on_player_move(param_00, param_01) {
  if(!isDefined(self.previouszmbcontractorigin)) {
    self.previouszmbcontractorigin = self.var_0116;
  }

  var_02 = self.previouszmbcontractorigin;
  var_03 = self.var_0116;
  var_04 = var_02 != var_03;
  self.previouszmbcontractorigin = self.var_0116;
  return var_04;
}

contract_fail_on_not_crouched(param_00, param_01) {
  var_02 = self getstance();
  return !lib_0547::func_5565(var_02, "crouch");
}

contract_fail_on_zone_change(param_00, param_01, param_02) {
  if(!isDefined(self.previouszmbzone)) {
    self.previouszmbzone = lib_055A::func_462D();
  }

  if(!isDefined(self.previouszmbzone)) {
    return 0;
  }

  var_03 = self.previouszmbzone;
  var_04 = lib_055A::func_462D();
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = !lib_0547::func_5565(var_03, var_04);
  if(!common_scripts\utility::func_562E(param_02)) {
    self.previouszmbzone = var_04;
  }

  return var_05;
}

contract_fail_on_new_zone(param_00, param_01) {
  return contract_fail_on_zone_change(param_00, param_01, 1);
}

succeed_on_inventory_aquired(param_00, param_01) {
  return 4;
}

contract_fail_on_player_damage(param_00, param_01) {
  return 1;
}

get_next_player_weapon() {
  var_00 = self;
  var_00 waittill("weapons_used", var_01);
  return var_01;
}

wait_for_player_volume_touch_update(param_00) {
  wait(1);
  return 1;
}

get_weapon_on_round_change() {
  level waittill("wave_survival");
  return self getcurrentweapon();
}

contract_reset_on_wave_break() {
  level waittill("round complete");
  var_00 = self;
  foreach(var_02 in var_00.active_contract_tracker["zombie_purchases"]) {
    switch (var_02.condition) {
      case "player_armor_count_round":
        var_02.var_005C = 0;
        break;
    }
  }
}

wait_for_player_dmg() {
  var_00 = undefined;
  while(!isDefined(var_00) || !agent_is_zombie(undefined, var_00)) {
    self waittill("damage", var_01, var_00);
  }

  return 1;
}

agent_is_zombie(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  return isDefined(param_01) && !isPlayer(param_01) && isDefined(param_01.var_0A4B);
}

wait_for_player_purchase_perk() {
  self waittill("forever");
  return 1;
}

get_unique_perks_total(param_00, param_01) {
  foreach(var_03 in param_00) {
    if(!common_scripts\utility::func_0F79(param_01, var_03.var_0109)) {
      param_01 = common_scripts\utility::func_0F6F(param_01, var_03.var_0109);
    }
  }

  return param_01;
}

initialize_per_player_tracking() {
  level thread maps\mp\_utility::func_6F74(::contracts_init_player_member_variables);
  level thread maps\mp\_utility::func_6F74(::contracts_tracking_init, ["wave_survival", "zombie_purchases", "player_actions"]);
}

zombies_multikill(param_00, param_01, param_02) {
  var_03 = self;
  if(!isDefined(var_03.playerzombiemultikills)) {
    var_03.playerzombiemultikills = [];
  }

  var_04 = [];
  var_04["zombie_type"] = param_00.var_0A4B;
  var_04["weapon"] = maps\mp\_utility::func_4431(param_01);
  var_04["means_of_death"] = param_02;
  var_04["origin"] = param_00.var_0116;
  var_03.playerzombiemultikills = common_scripts\utility::func_0F6F(var_03.playerzombiemultikills, var_04);
  if(!common_scripts\utility::func_562E(var_03.starttrackingmultikill)) {
    var_03.starttrackingmultikill = 1;
    return var_03 contracts_report_player_multikills();
  }

  return 0;
}

contracts_report_player_multikills() {
  self endon("disconnect");
  for(var_00 = 0; var_00 < 3; var_00++) {
    wait 0.05;
  }

  var_01 = self.playerzombiemultikills.size >= 5;
  if(var_01) {
    self.playerzombiemultikilldata = self.playerzombiemultikills;
  } else {
    self.playerzombiemultikilldata = undefined;
  }

  self.starttrackingmultikill = 0;
  self.playerzombiemultikills = undefined;
  return var_01;
}

is_being_chased_by_zombie() {
  var_00 = lib_0547::func_408F();
  if(var_00.size == 0) {
    return 0;
  }

  var_01 = 0;
  foreach(var_03 in var_00) {
    if(lib_0547::func_5565(var_03.var_28D2, self)) {
      return 1;
    }
  }

  return 0;
}

get_num_unique_zombie_kills(param_00) {
  var_01 = self;
  if(!common_scripts\utility::func_0F79(var_01.zombie_types_killed_list, param_00)) {
    var_01.zombie_types_killed_list = common_scripts\utility::func_0F6F(var_01.zombie_types_killed_list, param_00);
  }
}

increment_contract_array(param_00) {
  var_01 = self;
  if(!isDefined(var_01.count_arr)) {
    var_01.count_arr = [];
  }

  if(!isDefined(var_01.count_arr[param_00])) {
    var_01.count_arr[param_00] = spawnStruct();
    var_01.count_arr[param_00].var_0109 = param_00;
    var_01.count_arr[param_00].var_005C = 0;
  }

  var_01.count_arr[param_00].var_005C++;
}

mp_zombie_map_won(param_00) {
  maps\mp\_achievement_engine_z_utils::ae_sendmapwon_zm(param_00);
}

start_boss_battle_tracking() {
  common_scripts\utility::func_3C8F("zmb_contracts_boss_battle_active");
}

end_boss_battle_tracking() {
  common_scripts\utility::func_3C7B("zmb_contracts_boss_battle_active");
}

contracts_start_track_boss_battle_laststand() {
  var_00 = self;
  var_00 endon("disconnect");
  common_scripts\utility::func_3C9F("zmb_contracts_boss_battle_active");
  var_00 endon("enter_last_stand");
  while(common_scripts\utility::func_3C77("zmb_contracts_boss_battle_active")) {
    wait 0.05;
  }

  var_00 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_00, "player_zombie_boss_no_laststand");
}