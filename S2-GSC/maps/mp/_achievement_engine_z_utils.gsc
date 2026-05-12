/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_achievement_engine_z_utils.gsc
***************************************************/

_achievment_engine_z_report_event(param_00, param_01, param_02, param_03) {
  if(!maps\mp\_events_z::is_contracts_game_online()) {
    return;
  }

  var_04 = self;
  if(param_01.size > 0) {
    if(!maps\mp\_events_z::get_testing_contracts_offline()) {
      var_04 ae_reportcomplexgameevent(param_00, param_01);
    }
  }
}

ae_zm_sendkillevent(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = self;
  param_05 = get_player_kill_special(param_05, var_06, param_00, param_02, param_03);
  var_07 = get_zombie_type_val(param_01);
  var_08 = [];
  var_08 = add_weapon_type(var_08, param_02, param_03);
  var_08 = add_key_and_value(var_08, 2, var_07);
  var_08 = add_death_means_info(var_08, param_00, param_03, param_02);
  var_08 = add_hit_location(var_08, param_04);
  var_08 = add_upgrade_info(var_08, param_02);
  var_08 = add_current_map(var_08);
  var_08 = add_player_kill_special(var_08, param_05);
  var_08 = add_key_and_value(var_08, 8, int(level.var_A980));
  if(is_community_kill(var_07, param_00)) {
    var_09 = level.var_744A;
  } else {
    var_09 = [var_07];
  }

  foreach(var_0B in var_09) {
    var_0B _achievment_engine_z_report_event(34, var_08, "Single Zombie Kill", param_05);
  }
}

ae_zm_sendmultikillevent(param_00) {
  var_01 = self;
  var_02 = [];
  var_03 = get_singular_mkill_data(param_00, "means_of_death");
  var_04 = get_singular_mkill_data(param_00, "weapon");
  if(lib_0547::func_5565(var_04, "island_grenade_hc_zm")) {
    var_03 = "MOD_EXPLOSIVE";
  }

  if(!isDefined(var_03)) {
    return;
  }

  if(issubstr(var_03, "MOD_GRENADE") || issubstr(var_03, "MOD_GRENADE_SPLASH") || issubstr(var_03, "MOD_EXPLOSIVE") || issubstr(var_03, "MOD_PROJECTILE")) {
    var_02 = add_key_and_value(var_02, 3, 3);
  }

  if(isDefined(var_04)) {
    if(var_04 == "drag_explosive_zombie_zm" || var_04 == "drag_explosive_zm") {
      var_02 = add_key_and_value(var_02, 2, 1);
    }
  }

  if(param_00.size >= 10) {
    var_02 = add_key_and_value(var_02, 5, 1);
  }

  var_01 _achievment_engine_z_report_event(35, var_02, "Multi Zombie Kill");
}

ae_zm_purchasejoltsevent(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_06 = undefined;
  var_07 = get_item_value(param_01);
  if(isDefined(param_02)) {
    var_08 = get_item_collection_condition_value(param_02);
    if(isDefined(param_03)) {
      var_05 = add_key_and_value(var_05, 2, var_07);
      var_05 = add_key_and_value(var_05, 3, int(param_03));
      var_05 = add_key_and_value(var_05, 4, var_08);
    }
  } else {
    var_05 = add_key_and_value(var_05, 1, var_07);
  }

  param_00 _achievment_engine_z_report_event(36, var_05, param_04);
}

ae_sendwavesurvivalevent_zm(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = 0;
  var_06 = undefined;
  if(param_01 != "survival_wave_single") {
    var_07 = get_challenge_bitval(param_01);
    if(param_01 == "survival_area") {
      var_06 = survival_get_zone_bitval(param_03);
    }

    var_04 = add_key_and_value(var_04, 1, int(param_02));
    var_04 = add_key_and_value(var_04, 2, var_07);
    var_04 = add_key_and_value(var_04, 3, var_06);
    var_04 = add_current_map(var_04);
  } else {
    var_04 = add_current_map(var_04);
    var_04 = add_key_and_value(var_04, 2, 8);
  }

  param_00 _achievment_engine_z_report_event(37, var_04, param_01);
}

ae_sendzombiesspecial_zm(param_00 ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** * /,param_01,param_02,param_03) {
  var_04 = []; var_05 = undefined; var_06 = undefined; var_07 = [];
  switch (param_01) {
    case "player_zombie_kills_fireman_tank":
      var_04 = add_key_and_value(var_04, 1, 1);
      break;

    case "player_zombie_collect_fish":
      var_04 = add_key_and_value(var_04, 1, 21);
      break;

    case "player_zombie_powerup_collected":
      var_04 = add_key_and_value(var_04, 1, 4);
      break;

    case "player_zombie_boss_no_laststand":
      var_04 = add_key_and_value(var_04, 1, 5);
      break;

    case "player_zombie_kills_sacrifice":
      var_04 = add_key_and_value(var_04, 1, 17);
      break;

    case "player_teammate_revives":
      var_08 = get_unique_players_revived_val(param_02.player_revives_unique);
      var_04 = add_key_and_value(var_04, 1, 2);
      var_09 = get_player_current_ability(param_00);
      if(isDefined(var_09) && var_09 == 2) {
        var_04 = add_key_and_value(var_04, 2, 1);
      }

      if(isDefined(var_08)) {
        var_07 = common_scripts\utility::func_0F6F(var_07, var_08);
        var_05 = get_bitwise_value(var_07);
        var_04 = add_key_and_value(var_04, 128, var_05);
      }
      break;

    case "player_zombie_aquire_weapon_from_box":
      switch (param_02) {
        case "jack_in_box_decoy_zm":
          var_04 = add_key_and_value(var_04, 1, 14);
          break;
      }
      break;

    case "player_zombie_aquire_jolts":
      if(!isDefined(param_00.nextjoltsgoal)) {
        param_00.nextjoltsgoal = 5000;
      }

      if(param_00.nextjoltsgoal < 10000000) {
        if(param_02 >= param_00.nextjoltsgoal) {
          var_04 = add_key_and_value(var_04, 1, 15);
          var_04 = add_key_and_value(var_04, 2, param_00.nextjoltsgoal);
          param_00.nextjoltsgoal = param_00.nextjoltsgoal + 5000;
        }
      }
      break;

    case "player_zombie_shellshock_stun":
      var_04 = add_key_and_value(var_04, 1, 16);
      break;

    case "any_objective_completed":
      var_04 = add_key_and_value(var_04, 1, 20);
      break;

    case "geistcraft_device_powered":
      var_04 = add_key_and_value(var_04, 1, 18);
      break;

    case "mp_zombie_nest_01_tower_battle":
      var_04 = add_key_and_value(var_04, 1, 8);
      break;

    case "mp_zombie_nest_01_final_boss":
      if(common_scripts\utility::func_562E(param_02)) {
        var_04 = add_key_and_value(var_04, 1, 13);
      } else {
        var_04 = add_key_and_value(var_04, 1, 9);
      }
      break;

    case "mp_zombie_island_final_boss":
      var_04 = add_key_and_value(var_04, 1, 10);
      break;

    case "mp_zombie_berlin_final_boss":
      var_04 = add_key_and_value(var_04, 1, 19);
      break;

    case "player_stuka_kills":
      var_04 = add_key_and_value(var_04, 1, 11);
      break;

    case "player_rode_minecart":
      var_04 = add_key_and_value(var_04, 1, 12);
      break;

    case "any_boss_completed":
      if(should_report_boss_defeats_for_currency()) {
        var_04 = add_key_and_value(var_04, 1, 23);
      }
      break;

    case "any_boss_completed_small":
      if(should_report_boss_defeats_for_currency()) {
        var_04 = add_key_and_value(var_04, 1, 24);
      }
      break;

    case "player_zombie_upgrade_weapon":
      var_04 = add_key_and_value(var_04, 1, 7);
      break;

    case "player_zombie_all_doors_opened":
      var_04 = add_key_and_value(var_04, 1, 22);
      break;
  }

  param_00 _achievment_engine_z_report_event(38, var_04, "Collection " + param_01, var_06);
}

should_report_boss_defeats_for_currency() {
  return 0;
}

get_unique_players_revived_val(param_00) {
  var_01 = undefined;
  if(!isDefined(param_00)) {
    return undefined;
  }

  switch (param_00) {
    case 3:
      var_01 = 1;
      break;
  }

  return var_01;
}

ae_sendmapwon_zm(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04 = add_current_map(var_04);
  if(lib_0547::zombie_shattered_get_map_number() > 0) {
    var_04 = add_key_and_value(var_04, 1, param_00 getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isMapInSequence"));
  }

  param_00 _achievment_engine_z_report_event(41, var_04, "Won Map Event");
}

survival_get_zone_bitval(param_00) {
  if(isDefined(param_00)) {
    return get_zone_bitval(param_00[0]);
  }
}

add_current_map(param_00, param_01) {
  var_02 = tolower(getDvar("1673"));
  var_03 = 0;
  switch (var_02) {
    case "mp_zombie_training":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 8;
      var_03 = 8;
      break;

    case "mp_zombie_house":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 1;
      var_03 = 1;
      break;

    case "mp_zombie_nest_01":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 2;
      var_03 = 2;
      break;

    case "mp_zombie_island":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 3;
      var_03 = 3;
      break;

    case "mp_zombie_berlin":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 4;
      var_03 = 4;
      break;

    case "mp_zombie_windmill":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 5;
      var_03 = 5;
      break;

    case "mp_zombie_dnk":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 6;
      var_03 = 6;
      break;

    case "mp_zombie_dig_02":
      param_00[param_00.size] = 5;
      param_00[param_00.size] = 7;
      var_03 = 7;
      break;

    default:
      break;
  }

  if(common_scripts\utility::func_562E(param_01)) {
    return var_03;
  }

  return param_00;
}

get_zombie_type_val(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "zombie_generic":
      var_01 = 1;
      break;

    case "zombie_crawler":
      var_01 = 7;
      break;

    case "zombie_berserker":
      var_01 = 2;
      break;

    case "zombie_heavy":
      var_01 = 3;
      break;

    case "zombie_exploder":
      var_01 = 4;
      break;

    case "zombie_fireman":
      var_01 = 5;
      break;

    case "zombie_assassin":
      var_01 = 6;
      break;

    case "zombie_bob":
      var_01 = 8;
      break;

    case "zombie_guardian":
      var_01 = 9;
      break;

    case "zombie_king":
      var_01 = 11;
      break;

    case "zombie_treasurer":
      var_01 = 10;
      break;

    default:
      break;
  }

  return var_01;
}

add_weapon_type(param_00, param_01, param_02) {
  var_03 = lib_0547::zm_get_weapon_class(param_01);
  if(param_01 == "raven_gun_zm" || param_01 == "raven_gun_pap_zm") {
    var_03 = "weapon_pistol";
  }

  switch (var_03) {
    case "weapon_assault":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 1;
      break;

    case "weapon_smg":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 2;
      break;

    case "weapon_heavy":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 3;
      break;

    case "weapon_shotgun":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 4;
      break;

    case "weapon_sniper":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 5;
      break;

    case "weapon_pistol":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 6;
      break;

    case "weapon_projectile":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 7;
      break;

    case "weapon_grenade":
      param_00[param_00.size] = 1;
      param_00[param_00.size] = 8;
      break;

    case "weapon_other":
      param_00 = add_melee_info_if_valid(param_00, param_02);
      break;

    case "other":
      param_00 = add_melee_info_if_valid(param_00, param_02);
      if(maps\mp\_events_z::weapon_is_trap(undefined, undefined, param_01)) {
        param_00[param_00.size] = 1;
        param_00[param_00.size] = 11;
      }
      break;
  }

  return param_00;
}

add_melee_info_if_valid(param_00, param_01) {
  if(lib_0547::func_5565(param_01, "MOD_MELEE")) {
    param_00[param_00.size] = 1;
    param_00[param_00.size] = 10;
  }

  return param_00;
}

add_upgrade_info(param_00, param_01) {
  if(issubstr(param_01, "_pap") || issubstr(param_01, "frag_grenade_funderbuss_zm")) {
    param_00[param_00.size] = 7;
    param_00[param_00.size] = 1;
  }

  return param_00;
}

add_death_means_info(param_00, param_01, param_02, param_03) {
  if(isDefined(param_02) && maps\mp\_utility::func_5697(param_02, param_03)) {
    param_00[param_00.size] = 3;
    param_00[param_00.size] = 1;
  } else if(isDefined(param_02) && maps\mp\_utility::func_56E5(param_02)) {
    param_00[param_00.size] = 3;
    param_00[param_00.size] = 3;
  } else if(isDefined(param_01.var_5033) && param_01.var_5033 &level.var_503B) {
    param_00[param_00.size] = 3;
    param_00[param_00.size] = 4;
  } else if(isDefined(param_02) && param_02 == "MOD_MELEE") {
    param_00[param_00.size] = 3;
    param_00[param_00.size] = 2;
  }

  return param_00;
}

add_hit_location(param_00, param_01) {
  if(param_01 == "head" || param_01 == "helmet") {
    param_00[param_00.size] = 6;
    param_00[param_00.size] = 1;
  }

  return param_00;
}

get_player_current_ability(param_00, param_01, param_02, param_03) {
  var_04 = param_00 maps\mp\_events_z::get_current_active_ability();
  var_05 = undefined;
  switch (var_04) {
    case "role_ability_mad_minute_zm":
      var_05 = 1;
      break;

    case "role_ability_camo_zm":
      var_05 = 2;
      break;

    case "role_ability_taunt_zm":
      var_05 = 3;
      break;

    case "role_ability_stunning_burst_zm":
      var_05 = 4;
      break;
  }

  return var_05;
}

get_player_kill_special(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_06 = [];
  if(isDefined(param_00) && param_00.size > 0) {
    var_05 = param_00;
  }

  foreach(var_08 in level.register_unique_kill_funcs) {
    var_09 = [[var_08.var_3F02]](param_01, param_02, param_03, param_04);
    if(isDefined(var_08.var_A281) && var_09) {
      var_05 = common_scripts\utility::func_0F6F(var_05, var_08.var_A281);
      continue;
    }

    if(!isDefined(var_08.var_A281) && isDefined(var_09)) {
      var_05 = common_scripts\utility::func_0F6F(var_05, var_09);
    }
  }

  return var_05;
}

add_player_kill_special(param_00, param_01) {
  var_02 = get_bitwise_value(param_01);
  param_00 = add_key_and_value(param_00, 128, var_02);
  return param_00;
}

get_bitwise_value(param_00) {
  if(param_00.size == 0) {
    return undefined;
  }

  var_01 = 0;
  foreach(var_03 in param_00) {
    if(isDefined(var_03)) {
      var_01 = var_01 | 1 << var_03;
    }
  }

  return var_01;
}

get_zone_bitval(param_00) {
  var_01 = [];
  var_02 = 0;
  switch (param_00) {
    case "zone1_1_start":
      var_02 = 1;
      break;

    case "zone1_2_gallows":
      var_02 = 2;
      break;

    case "zone1_3_riverside":
      var_02 = 3;
      break;

    case "zone1_4_bridge":
      var_02 = 4;
      break;

    case "zone1_5_rooftops":
      var_02 = 5;
      break;

    case "zone1_4_bridge_tower":
      var_02 = 6;
      break;

    case "zone2_2_catacombs":
      var_02 = 7;
      break;

    case "zone3_1_com":
      var_02 = 8;
      break;

    case "zone3_2_med":
      var_02 = 9;
      break;

    case "zone3_3_rnd":
      var_02 = 10;
      break;

    case "zone4_1_mine":
      var_02 = 11;
      break;

    case "zone4_2_hilt":
      var_02 = 12;
      break;

    case "start_zone":
      var_02 = 13;
      break;

    case "isolated_room_entry_zone":
      var_02 = 14;
      break;

    case "isolated_room_zone":
      var_02 = 15;
      break;

    case "cart_tunnel_zone":
      var_02 = 16;
      break;

    case "climb_right_zone":
      var_02 = 17;
      break;

    case "corner_bluffs_zone":
      var_02 = 18;
      break;

    case "vista_beach_zone":
      var_02 = 19;
      break;

    case "vista_middle_zone":
      var_02 = 20;
      break;

    case "mining_corner":
      var_02 = 21;
      break;

    case "vista_zone_3":
      var_02 = 22;
      break;

    case "sub_pens_1_zone":
      var_02 = 23;
      break;

    case "high_canon":
      var_02 = 24;
      break;
  }

  return var_02;
}

get_item_collection_condition_value(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "player_perk_count_unique":
      var_01 = 1;
      break;

    case "player_perk_count":
      var_01 = 2;
      break;

    case "player_armor_count_round":
      var_01 = 3;
      break;
  }

  return var_01;
}

get_challenge_bitval(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "survival_basic":
      var_01 = 1;
      break;

    case "survival_starting_weapons":
      var_01 = 2;
      break;

    case "survival_no_damage":
      var_01 = 3;
      break;

    case "survival_area":
      var_01 = 4;
      break;

    case "survival_shotgun":
      var_01 = 5;
      break;

    case "survival_no_move":
      var_01 = 6;
      break;

    case "survival_first_box_only":
      var_01 = 7;
      break;

    case "survival_one_area_only":
      var_01 = 9;
      break;

    case "survival_first_area":
      var_01 = 10;
      break;

    case "survival_crouched":
      var_01 = 11;
      break;
  }

  return var_01;
}

get_item_value(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "trap":
      var_01 = 1;
      break;

    case "magic_box":
      var_01 = 3;
      break;

    case "weapons":
      var_01 = 2;
      break;

    case "doors":
      var_01 = 4;
      break;

    case "armor_booth":
      var_01 = 5;
      break;

    case "perk_machine":
      var_01 = 6;
      break;

    default:
      break;
  }

  return var_01;
}

is_community_kill(param_00, param_01) {
  if(lib_0547::func_5565(param_00, 10)) {
    return 1;
  }

  if(lib_0547::func_5565(param_00, 5)) {
    return 1;
  }

  if(common_scripts\utility::func_562E(param_01.var_5A3D)) {
    return 1;
  }

  return 0;
}

func_0939(param_00, param_01) {
  param_00[param_00.size] = param_01;
  return param_00;
}

add_key_and_value(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    param_00[param_00.size] = param_01;
    param_00[param_00.size] = param_02;
  }

  return param_00;
}

is_damage_electrical(param_00, param_01, param_02, param_03) {
  if(common_scripts\utility::func_562E(param_01.iselectrified)) {
    return 1;
  }

  if(issubstr(param_02, "teslagun")) {
    return 1;
  }

  if(param_02 == "turretweapon_zeppelin_gun_zm") {
    return 1;
  }

  if(common_scripts\utility::func_562E(param_01.var_0103) && param_02 == "razergun_zm" || param_02 == "razergun_pap_zm") {
    return 1;
  }

  return 0;
}

get_singular_mkill_data(param_00, param_01) {
  var_02 = param_00[0][param_01];
  foreach(var_04 in param_00) {
    if(!issubstr(var_04[param_01], var_02)) {
      return undefined;
    }
  }

  return var_02;
}