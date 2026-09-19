/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_achievement_engine_z_utils.gsc
***********************************************************/

_achievment_engine_z_report_event(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_events_z::is_contracts_game_online()) {
    return;
  }
  var_4 = self;

  if(var_1.size > 0) {
    if(!maps\mp\_events_z::get_testing_contracts_offline())
      var_4 _meth_8697(var_0, var_1);
  }
}

ae_zm_sendkillevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_5 = get_player_kill_special(var_5, var_6, var_0, var_2, var_3);
  var_7 = get_zombie_type_val(var_1);
  var_8 = [];
  var_8 = add_weapon_type(var_8, var_2, var_3);
  var_8 = add_key_and_value(var_8, 2, var_7);
  var_8 = add_death_means_info(var_8, var_0, var_3, var_2);
  var_8 = add_hit_location(var_8, var_4);
  var_8 = add_upgrade_info(var_8, var_2);
  var_8 = add_current_map(var_8);
  var_8 = add_player_kill_special(var_8, var_5);
  var_8 = add_key_and_value(var_8, 8, int(level._id_A980));

  if(is_community_kill(var_7, var_0))
    var_9 = level.players;
  else
    var_9 = [var_6];

  foreach(var_11 in var_9)
  var_11 _achievment_engine_z_report_event(34, var_8, "Single Zombie Kill", var_5);
}

ae_zm_sendmultikillevent(var_0) {
  var_1 = self;
  var_2 = [];
  var_3 = get_singular_mkill_data(var_0, "means_of_death");
  var_4 = get_singular_mkill_data(var_0, "weapon");

  if(_id_0547::_id_5565(var_4, "island_grenade_hc_zm"))
    var_3 = "MOD_EXPLOSIVE";

  if(!isDefined(var_3)) {
    return;
  }
  if(issubstr(var_3, "MOD_GRENADE") || issubstr(var_3, "MOD_GRENADE_SPLASH") || issubstr(var_3, "MOD_EXPLOSIVE") || issubstr(var_3, "MOD_PROJECTILE"))
    var_2 = add_key_and_value(var_2, 3, 3);

  if(isDefined(var_4)) {
    if(var_4 == "drag_explosive_zombie_zm" || var_4 == "drag_explosive_zm")
      var_2 = add_key_and_value(var_2, 2, 1);
  }

  if(var_0.size >= 10)
    var_2 = add_key_and_value(var_2, 5, 1);

  var_1 _achievment_engine_z_report_event(35, var_2, "Multi Zombie Kill");
}

ae_zm_purchasejoltsevent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = undefined;
  var_7 = get_item_value(var_1);

  if(isDefined(var_2)) {
    var_8 = get_item_collection_condition_value(var_2);

    if(isDefined(var_3)) {
      var_5 = add_key_and_value(var_5, 2, var_7);
      var_5 = add_key_and_value(var_5, 3, int(var_3));
      var_5 = add_key_and_value(var_5, 4, var_8);
    }
  } else
    var_5 = add_key_and_value(var_5, 1, var_7);

  var_0 _achievment_engine_z_report_event(36, var_5, var_4);
}

ae_sendwavesurvivalevent_zm(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 0;
  var_6 = undefined;

  if(var_1 != "survival_wave_single") {
    var_7 = get_challenge_bitval(var_1);

    if(var_1 == "survival_area")
      var_6 = survival_get_zone_bitval(var_3);

    var_4 = add_key_and_value(var_4, 1, int(var_2));
    var_4 = add_key_and_value(var_4, 2, var_7);
    var_4 = add_key_and_value(var_4, 3, var_6);
    var_4 = add_current_map(var_4);
  } else {
    var_4 = add_current_map(var_4);
    var_4 = add_key_and_value(var_4, 2, 8);
  }

  var_0 _achievment_engine_z_report_event(37, var_4, var_1);
}

ae_sendzombiesspecial_zm(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = undefined;
  var_6 = undefined;
  var_7 = [];

  switch (var_1) {
    case "player_zombie_kills_fireman_tank":
      var_4 = add_key_and_value(var_4, 1, 1);
      break;
    case "player_zombie_collect_fish":
      var_4 = add_key_and_value(var_4, 1, 21);
      break;
    case "player_zombie_powerup_collected":
      var_4 = add_key_and_value(var_4, 1, 4);
      break;
    case "player_zombie_boss_no_laststand":
      var_4 = add_key_and_value(var_4, 1, 5);
      break;
    case "player_zombie_kills_sacrifice":
      var_4 = add_key_and_value(var_4, 1, 17);
      break;
    case "player_teammate_revives":
      var_8 = get_unique_players_revived_val(var_2.player_revives_unique);
      var_4 = add_key_and_value(var_4, 1, 2);
      var_9 = get_player_current_ability(var_0);

      if(isDefined(var_9) && var_9 == 2)
        var_4 = add_key_and_value(var_4, 2, 1);

      if(isDefined(var_8)) {
        var_7 = common_scripts\utility::_id_0F6F(var_7, var_8);
        var_5 = get_bitwise_value(var_7);
        var_4 = add_key_and_value(var_4, 128, var_5);
      }

      break;
    case "player_zombie_aquire_weapon_from_box":
      switch (var_2) {
        case "jack_in_box_decoy_zm":
          var_4 = add_key_and_value(var_4, 1, 14);
          break;
      }

      break;
    case "player_zombie_aquire_jolts":
      if(!isDefined(var_0.nextjoltsgoal))
        var_0.nextjoltsgoal = 5000;

      if(var_0.nextjoltsgoal < 10000000) {
        if(var_2 >= var_0.nextjoltsgoal) {
          var_4 = add_key_and_value(var_4, 1, 15);
          var_4 = add_key_and_value(var_4, 2, var_0.nextjoltsgoal);
          var_0.nextjoltsgoal = var_0.nextjoltsgoal + 5000;
        }
      }

      break;
    case "player_zombie_shellshock_stun":
      var_4 = add_key_and_value(var_4, 1, 16);
      break;
    case "any_objective_completed":
      var_4 = add_key_and_value(var_4, 1, 20);
      break;
    case "geistcraft_device_powered":
      var_4 = add_key_and_value(var_4, 1, 18);
      break;
    case "mp_zombie_nest_01_tower_battle":
      var_4 = add_key_and_value(var_4, 1, 8);
      break;
    case "mp_zombie_nest_01_final_boss":
      if(common_scripts\utility::_id_562E(var_2))
        var_4 = add_key_and_value(var_4, 1, 13);
      else
        var_4 = add_key_and_value(var_4, 1, 9);

      break;
    case "mp_zombie_island_final_boss":
      var_4 = add_key_and_value(var_4, 1, 10);
      break;
    case "mp_zombie_berlin_final_boss":
      var_4 = add_key_and_value(var_4, 1, 19);
      break;
    case "player_stuka_kills":
      var_4 = add_key_and_value(var_4, 1, 11);
      break;
    case "player_rode_minecart":
      var_4 = add_key_and_value(var_4, 1, 12);
      break;
    case "any_boss_completed":
      if(should_report_boss_defeats_for_currency())
        var_4 = add_key_and_value(var_4, 1, 23);

      break;
    case "any_boss_completed_small":
      if(should_report_boss_defeats_for_currency())
        var_4 = add_key_and_value(var_4, 1, 24);

      break;
    case "player_zombie_upgrade_weapon":
      var_4 = add_key_and_value(var_4, 1, 7);
      break;
    case "player_zombie_all_doors_opened":
      var_4 = add_key_and_value(var_4, 1, 22);
      break;
  }

  var_0 _achievment_engine_z_report_event(38, var_4, "Collection " + var_1, var_6);
}

should_report_boss_defeats_for_currency() {
  return 0;
}

get_unique_players_revived_val(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return undefined;

  switch (var_0) {
    case 3:
      var_1 = 1;
      break;
  }

  return var_1;
}

ae_sendmapwon_zm(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4 = add_current_map(var_4);

  if(_id_0547::zombie_shattered_get_map_number() > 0)
    var_4 = add_key_and_value(var_4, 1, var_0 getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isMapInSequence"));

  var_0 _achievment_engine_z_report_event(41, var_4, "Won Map Event");
}

survival_get_zone_bitval(var_0) {
  if(isDefined(var_0))
    return get_zone_bitval(var_0[0]);
}

add_current_map(var_0, var_1) {
  var_2 = _func_117(getDvar("1673"));
  var_3 = 0;

  switch (var_2) {
    case "mp_zombie_training":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 8;
      var_3 = 8;
      break;
    case "mp_zombie_house":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 1;
      var_3 = 1;
      break;
    case "mp_zombie_nest_01":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 2;
      var_3 = 2;
      break;
    case "mp_zombie_island":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 3;
      var_3 = 3;
      break;
    case "mp_zombie_berlin":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 4;
      var_3 = 4;
      break;
    case "mp_zombie_windmill":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 5;
      var_3 = 5;
      break;
    case "mp_zombie_dnk":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 6;
      var_3 = 6;
      break;
    case "mp_zombie_dig_02":
      var_0[var_0.size] = 5;
      var_0[var_0.size] = 7;
      var_3 = 7;
      break;
    default:
      break;
  }

  if(common_scripts\utility::_id_562E(var_1))
    return var_3;
  else
    return var_0;
}

get_zombie_type_val(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "zombie_generic":
      var_1 = 1;
      break;
    case "zombie_crawler":
      var_1 = 7;
      break;
    case "zombie_berserker":
      var_1 = 2;
      break;
    case "zombie_heavy":
      var_1 = 3;
      break;
    case "zombie_exploder":
      var_1 = 4;
      break;
    case "zombie_fireman":
      var_1 = 5;
      break;
    case "zombie_assassin":
      var_1 = 6;
      break;
    case "zombie_bob":
      var_1 = 8;
      break;
    case "zombie_guardian":
      var_1 = 9;
      break;
    case "zombie_king":
      var_1 = 11;
      break;
    case "zombie_treasurer":
      var_1 = 10;
      break;
    default:
      break;
  }

  return var_1;
}

add_weapon_type(var_0, var_1, var_2) {
  var_3 = _id_0547::zm_get_weapon_class(var_1);

  if(var_1 == "raven_gun_zm" || var_1 == "raven_gun_pap_zm")
    var_3 = "weapon_pistol";

  switch (var_3) {
    case "weapon_assault":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 1;
      break;
    case "weapon_smg":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 2;
      break;
    case "weapon_heavy":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 3;
      break;
    case "weapon_shotgun":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 4;
      break;
    case "weapon_sniper":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 5;
      break;
    case "weapon_pistol":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 6;
      break;
    case "weapon_projectile":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 7;
      break;
    case "weapon_grenade":
      var_0[var_0.size] = 1;
      var_0[var_0.size] = 8;
    case "weapon_other":
      var_0 = add_melee_info_if_valid(var_0, var_2);
      break;
    case "other":
      var_0 = add_melee_info_if_valid(var_0, var_2);

      if(maps\mp\_events_z::weapon_is_trap(undefined, undefined, var_1)) {
        var_0[var_0.size] = 1;
        var_0[var_0.size] = 11;
      }

      break;
  }

  return var_0;
}

add_melee_info_if_valid(var_0, var_1) {
  if(_id_0547::_id_5565(var_1, "MOD_MELEE")) {
    var_0[var_0.size] = 1;
    var_0[var_0.size] = 10;
  }

  return var_0;
}

add_upgrade_info(var_0, var_1) {
  if(issubstr(var_1, "_pap") || issubstr(var_1, "frag_grenade_funderbuss_zm")) {
    var_0[var_0.size] = 7;
    var_0[var_0.size] = 1;
  }

  return var_0;
}

add_death_means_info(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && maps\mp\_utility::_id_5697(var_2, var_3)) {
    var_0[var_0.size] = 3;
    var_0[var_0.size] = 1;
  } else if(isDefined(var_2) && maps\mp\_utility::isexplosivedamage(var_2)) {
    var_0[var_0.size] = 3;
    var_0[var_0.size] = 3;
  } else if(isDefined(var_1._id_5033) && var_1._id_5033 &level.idflags_penetration) {
    var_0[var_0.size] = 3;
    var_0[var_0.size] = 4;
  } else if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    var_0[var_0.size] = 3;
    var_0[var_0.size] = 2;
  }

  return var_0;
}

add_hit_location(var_0, var_1) {
  if(var_1 == "head" || var_1 == "helmet") {
    var_0[var_0.size] = 6;
    var_0[var_0.size] = 1;
  }

  return var_0;
}

get_player_current_ability(var_0, var_1, var_2, var_3) {
  var_4 = var_0 maps\mp\_events_z::get_current_active_ability();
  var_5 = undefined;

  switch (var_4) {
    case "role_ability_mad_minute_zm":
      var_5 = 1;
      break;
    case "role_ability_camo_zm":
      var_5 = 2;
      break;
    case "role_ability_taunt_zm":
      var_5 = 3;
      break;
    case "role_ability_stunning_burst_zm":
      var_5 = 4;
      break;
  }

  return var_5;
}

get_player_kill_special(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];

  if(isDefined(var_0) && var_0.size > 0)
    var_5 = var_0;

  foreach(var_8 in level.register_unique_kill_funcs) {
    var_9 = [[var_8._id_3F02]](var_1, var_2, var_3, var_4);

    if(isDefined(var_8.value) && var_9) {
      var_5 = common_scripts\utility::_id_0F6F(var_5, var_8.value);
      continue;
    }

    if(!isDefined(var_8.value) && isDefined(var_9))
      var_5 = common_scripts\utility::_id_0F6F(var_5, var_9);
  }

  return var_5;
}

add_player_kill_special(var_0, var_1) {
  var_2 = get_bitwise_value(var_1);
  var_0 = add_key_and_value(var_0, 128, var_2);
  return var_0;
}

get_bitwise_value(var_0) {
  if(var_0.size == 0)
    return undefined;

  var_1 = 0;

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_1 = var_1 | 1 << var_3;
  }

  return var_1;
}

get_zone_bitval(var_0) {
  var_1 = [];
  var_2 = 0;

  switch (var_0) {
    case "zone1_1_start":
      var_2 = 1;
      break;
    case "zone1_2_gallows":
      var_2 = 2;
      break;
    case "zone1_3_riverside":
      var_2 = 3;
      break;
    case "zone1_4_bridge":
      var_2 = 4;
      break;
    case "zone1_5_rooftops":
      var_2 = 5;
      break;
    case "zone1_4_bridge_tower":
      var_2 = 6;
      break;
    case "zone2_2_catacombs":
      var_2 = 7;
      break;
    case "zone3_1_com":
      var_2 = 8;
      break;
    case "zone3_2_med":
      var_2 = 9;
      break;
    case "zone3_3_rnd":
      var_2 = 10;
      break;
    case "zone4_1_mine":
      var_2 = 11;
      break;
    case "zone4_2_hilt":
      var_2 = 12;
      break;
    case "start_zone":
      var_2 = 13;
      break;
    case "isolated_room_entry_zone":
      var_2 = 14;
      break;
    case "isolated_room_zone":
      var_2 = 15;
      break;
    case "cart_tunnel_zone":
      var_2 = 16;
      break;
    case "climb_right_zone":
      var_2 = 17;
      break;
    case "corner_bluffs_zone":
      var_2 = 18;
      break;
    case "vista_beach_zone":
      var_2 = 19;
      break;
    case "vista_middle_zone":
      var_2 = 20;
      break;
    case "mining_corner":
      var_2 = 21;
      break;
    case "vista_zone_3":
      var_2 = 22;
      break;
    case "sub_pens_1_zone":
      var_2 = 23;
      break;
    case "high_canon":
      var_2 = 24;
      break;
  }

  return var_2;
}

get_item_collection_condition_value(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "player_perk_count_unique":
      var_1 = 1;
      break;
    case "player_perk_count":
      var_1 = 2;
      break;
    case "player_armor_count_round":
      var_1 = 3;
      break;
  }

  return var_1;
}

get_challenge_bitval(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "survival_basic":
      var_1 = 1;
      break;
    case "survival_starting_weapons":
      var_1 = 2;
      break;
    case "survival_no_damage":
      var_1 = 3;
      break;
    case "survival_area":
      var_1 = 4;
      break;
    case "survival_shotgun":
      var_1 = 5;
      break;
    case "survival_no_move":
      var_1 = 6;
      break;
    case "survival_first_box_only":
      var_1 = 7;
      break;
    case "survival_one_area_only":
      var_1 = 9;
      break;
    case "survival_first_area":
      var_1 = 10;
      break;
    case "survival_crouched":
      var_1 = 11;
      break;
  }

  return var_1;
}

get_item_value(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "trap":
      var_1 = 1;
      break;
    case "magic_box":
      var_1 = 3;
      break;
    case "weapons":
      var_1 = 2;
      break;
    case "doors":
      var_1 = 4;
      break;
    case "armor_booth":
      var_1 = 5;
      break;
    case "perk_machine":
      var_1 = 6;
      break;
    default:
      break;
  }

  return var_1;
}

is_community_kill(var_0, var_1) {
  if(_id_0547::_id_5565(var_0, 10))
    return 1;

  if(_id_0547::_id_5565(var_0, 5))
    return 1;

  if(common_scripts\utility::_id_562E(var_1._id_5A3D))
    return 1;

  return 0;
}

_id_0939(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

add_key_and_value(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_0[var_0.size] = var_1;
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

is_damage_electrical(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::_id_562E(var_1.iselectrified))
    return 1;

  if(issubstr(var_2, "teslagun"))
    return 1;

  if(var_2 == "turretweapon_zeppelin_gun_zm")
    return 1;

  if(common_scripts\utility::_id_562E(var_1._id_0103) && (var_2 == "razergun_zm" || var_2 == "razergun_pap_zm"))
    return 1;

  return 0;
}

get_singular_mkill_data(var_0, var_1) {
  var_2 = var_0[0][var_1];

  foreach(var_4 in var_0) {
    if(!issubstr(var_4[var_1], var_2))
      return undefined;
  }

  return var_2;
}