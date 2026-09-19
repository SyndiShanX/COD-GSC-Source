/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_events_z.gsc
*****************************************/

init() {
  initialize_contract_tracking();
}

initialize_contract_tracking() {
  register_unique_kill_func(undefined, maps\mp\_achievement_engine_z_utils::get_player_current_ability, undefined, "Player Mod");
  register_unique_kill_func("player_electrical_kills", maps\mp\_achievement_engine_z_utils::is_damage_electrical, 5, "Is Electrical");
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
  register_unique_kill_func("player_zombie_kills_wet_zombies", _id_0547::is_wet_zombie, 20, "zombie was drowned");
  register_unique_kill_func(undefined, _id_0547::is_jack_box, 30, "jack in box kill");
  create_new_contract_type("wave_survival", "survival_starting_weapons", ::contract_validate_weapon_used, [::get_next_player_weapon, ::get_weapon_on_round_change], get_player_starter_weapons(), "Survive Usings Starter Weapons");
  create_new_contract_type("wave_survival", "survival_no_damage", ::contract_fail_on_player_damage, [::wait_for_player_dmg], undefined, "Survive Without Taking damage");
  create_new_contract_type("wave_survival", "survival_shotgun", ::contract_validate_weapon_used, [::get_next_player_weapon, ::get_weapon_on_round_change], "weapon_shotgun", "Survive With Only ShotGun");
  create_new_contract_type("wave_survival", "survival_no_move", ::contract_fail_on_player_move, [_id_0547::_id_A6F6], undefined, "Survive Without Moving");
  create_new_contract_type("wave_survival", "survival_one_area_only", ::contract_fail_on_zone_change, [_id_0547::_id_A6F6], undefined, "Survive Single Area");
  create_new_contract_type("wave_survival", "survival_first_area", ::contract_fail_on_new_zone, [_id_0547::_id_A6F6], undefined, "First Area");
  create_new_contract_type("wave_survival", "survival_crouched", ::contract_fail_on_not_crouched, [_id_0547::_id_A6F6], undefined, "Crouched");
  level thread maps\mp\_utility::_id_6F74(::assigncontractsfirstboxweapon);
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
  common_scripts\utility::flag_init("zmb_contracts_boss_battle_active");
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
  level thread maps\mp\_utility::_id_6F74(::contracts_consecutive_waves_tracking);
  level thread maps\mp\_utility::_id_6F74(::contracts_distance_traveled_tracking);
  level thread maps\mp\_utility::_id_6F74(::contracts_time_traveled_tracking);
  level thread maps\mp\_utility::_id_6F74(::contracts_start_track_boss_battle_laststand);
  _id_0547::register_postenemykilledfunc(::contracts_zombies_death_tracking);
  level.zmb_events_on_map_won = ::mp_zombie_map_won;
  _id_054D::_id_7BC6(::report_player_zombie_damage);
}

_id_0F4C() {
  if(!isDefined(level._id_AC1D))
    return 0;

  var_0 = [];

  foreach(var_2 in level._id_AC1D) {
    if(common_scripts\utility::_id_562E(var_2.is_quest_door)) {
      continue;
    }
    if(isDefined(var_2.getnegotiationnextnode) && issubstr(var_2.getnegotiationnextnode, "airship_")) {
      continue;
    }
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
  }

  foreach(var_2 in var_0) {
    if(!common_scripts\utility::_id_562E(var_2._id_6BE1))
      return 0;
  }

  return 1;
}

report_player_zombie_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_5)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(!isDefined(var_1.recent_weapon_damage))
    var_1.recent_weapon_damage = [];

  if(!isDefined(var_1.recent_weapon_locs))
    var_1.recent_weapon_locs = [];

  var_1.recent_weapon_damage = common_scripts\utility::_id_0F6F(var_1.recent_weapon_damage, var_5);
  var_1.recent_weapon_locs = common_scripts\utility::_id_0F6F(var_1.recent_weapon_locs, [var_5, var_8]);
  var_1 thread report_weapons_used();
}

report_weapons_used() {
  var_0 = self;
  var_0 notify("new_report_weapons_used");
  var_0 endon("new_report_weapons_used");
  waitframe();
  var_0.recent_weapon_damage = common_scripts\utility::_id_0F97(var_0.recent_weapon_damage);
  var_0 notify("weapons_used", var_0.recent_weapon_damage, var_0.recent_weapon_locs);
  var_0.recent_weapon_damage = [];
  var_0.recent_weapon_locs = [];
}

assigncontractsfirstboxweapon(var_0) {
  var_1 = self;
  var_1 endon("disconnect");

  if(!isDefined(var_0))
    var_2 = "magicBoxUse1";
  else
    var_2 = "magicBoxUse" + var_0;

  var_1 waittill(var_2, var_3);

  if(!isDefined(var_1.contractsboxattempts))
    var_1.contractsboxattempts = 1;

  var_1.contractsboxattempts++;

  foreach(var_5 in var_1.active_contract_tracker["wave_survival"]) {
    switch (var_5.condition) {
      case "survival_first_box_only":
        if(!_id_0547::_id_585C(_id_0547::_id_AAF9(var_3))) {
          var_5._id_6E55 = [];
          var_5._id_6E55[0] = _id_0547::_id_AAF9(var_3);
          var_5._id_6E55[1] = _id_0586::_id_078B(var_3);
        } else
          var_1 thread assigncontractsfirstboxweapon(var_1.contractsboxattempts);

        break;
    }
  }
}

contracts_report_player_completed_purchase(var_0, var_1, var_2) {
  var_0 player_purchase_report_collection(var_0, var_1);
  var_0 maps\mp\_achievement_engine_z_utils::ae_zm_purchasejoltsevent(var_0, var_1);
}

contracts_report_player_collected_powerup(var_0, var_1) {
  maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_zombie_powerup_collected");
}

contracts_report_player_upgraded_weapon(var_0) {
  maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_zombie_upgrade_weapon");
}

contracts_report_players_opened_map() {
  while(!_id_0F4C())
    waitframe();

  foreach(var_1 in level.players)
  maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_1, "player_zombie_all_doors_opened");
}

player_purchase_report_collection(var_0, var_1) {
  var_2 = 0;
  var_3 = [];

  foreach(var_5 in var_0.active_contract_tracker["zombie_purchases"]) {
    switch (var_1) {
      case "perk_machine":
        switch (var_5.condition) {
          case "player_perk_count":
            if(var_5._id_005C != var_0._id_6F66.size) {
              var_5._id_005C = var_0._id_6F66.size;
              var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
            }

            break;
          case "player_perk_count_unique":
            var_0.session_unique_perks_zm = get_unique_perks_total(var_0._id_6F66, var_0.session_unique_perks_zm);

            if(var_5._id_005C != var_0.session_unique_perks_zm.size) {
              var_5._id_005C = var_0.session_unique_perks_zm.size;
              var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
            }

            break;
          default:
            break;
        }

        break;
      case "armor_booth":
        switch (var_5.condition) {
          case "player_armor_count":
            var_5._id_005C++;
            var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
            break;
          case "player_armor_count_round":
            var_5._id_005C++;
            var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
            break;
        }

        break;
    }
  }

  foreach(var_8 in var_3)
  var_0 maps\mp\_achievement_engine_z_utils::ae_zm_purchasejoltsevent(var_0, var_1, var_8.condition, var_8._id_005C, var_8.condition);

  return var_3.size > 0;
}

is_wave_0(var_0, var_1, var_2, var_3) {
  return level._id_A980 == 0;
}

is_after_wave_10(var_0, var_1, var_2, var_3) {
  return level._id_A980 >= 10;
}

assassin_charge_kill(var_0, var_1, var_2, var_3) {
  return var_1._id_0A4B == "zombie_assassin" && common_scripts\utility::_id_562E(var_0.israzerguncharging) && razer_gun_melee_kill(var_0, var_1, var_2, var_3, 1);
}

is_zombie_exploder_bomb(var_0, var_1, var_2, var_3) {
  return _id_0547::_id_5565(var_2, "drag_explosive_zombie_zm");
}

is_ripsaw_non_heavy_death(var_0, var_1, var_2, var_3) {
  return !common_scripts\utility::_id_562E(var_1._id_0103) && razer_gun_melee_kill(var_0, var_1, var_2, var_3, 1);
}

is_ripsaw_heavy_death(var_0, var_1, var_2, var_3) {
  return common_scripts\utility::_id_562E(var_1._id_0103) && razer_gun_melee_kill(var_0, var_1, var_2, var_3, 1);
}

is_any_heavy_melee_death(var_0, var_1, var_2, var_3) {
  return common_scripts\utility::_id_562E(var_1._id_0103);
}

zombie_was_sacrificed(var_0, var_1, var_2, var_3) {
  return common_scripts\utility::_id_562E(var_1._id_8F2B);
}

is_player_airborne(var_0, var_1, var_2, var_3) {
  return !var_0 isonground();
}

get_number_unique_kills(var_0, var_1, var_2, var_3) {
  var_0 get_num_unique_zombie_kills(var_1._id_0A4B);
  var_4 = undefined;

  switch (var_0.zombie_types_killed_list.size) {
    case 5:
      var_4 = 25;
      break;
    case 7:
      var_4 = 26;
      break;
  }

  return var_4;
}

is_sacrifice(var_0, var_1, var_2, var_3) {
  return common_scripts\utility::_id_562E(var_1._id_8F2B);
}

razer_gun_melee_kill(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 != "MOD_MELEE")
    return 0;

  if(common_scripts\utility::_id_562E(var_4))
    return common_scripts\utility::_id_0F79(["razergun_zm", "razergun_melee_zm", "razergun_pap_zm"], var_2);
  else
    return common_scripts\utility::_id_0F79(["razergun_zm", "razergun_pap_zm"], var_2);
}

zmb_contracts_map_is_foggy() {
  return isDefined(level.zmb_contracts_get_map_fog_state) && [[level.zmb_contracts_get_map_fog_state]]();
}

is_unexploded_bomber(var_0, var_1, var_2, var_3) {
  return var_1._id_0A4B == "zombie_exploder" && isDefined(var_1._id_349C);
}

weapon_is_trap(var_0, var_1, var_2, var_3) {
  return _id_0547::_id_5565(var_2, "trap_zm_mp");
}

is_charging_wustling(var_0, var_1, var_2, var_3) {
  return var_1._id_0A4B == "zombie_heavy" && common_scripts\utility::_id_562E(var_1._id_5542);
}

is_zombies_s_mine(var_0, var_1, var_2, var_3) {
  return _id_0547::_id_5565(var_2, "bouncingbetty_zm");
}

is_throwing_knife(var_0, var_1, var_2, var_3) {
  return _id_0547::_id_5565(var_2, "throwingknife_zm");
}

zombie_died_from_melee_only(var_0, var_1, var_2, var_3) {
  return !common_scripts\utility::_id_562E(var_1.has_taken_bullet_damage) && var_3 == "MOD_MELEE";
}

has_no_primary_ammo(var_0, var_1, var_2, var_3) {
  var_4 = var_0 getweaponlistprimaries();

  foreach(var_2 in var_4) {
    if(var_0 getammocount(var_2) > 0)
      return 0;
  }

  return 1;
}

get_trap_value_for_name(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "trap_sub":
      var_1 = 13;
      break;
    case "trap_spike":
      var_1 = 14;
      break;
    case "trap_firewell":
      var_1 = 15;
      break;
    case "trap_rnd":
      var_1 = 16;
      break;
    case "trap_med":
      var_1 = 17;
      break;
    case "trap_catacombs":
      var_1 = 18;
      break;
    case "trap_roof":
      var_1 = 19;
      break;
  }

  return var_1;
}

register_unique_kill_func(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.register_unique_kill_funcs))
    level.register_unique_kill_funcs = [];

  var_4 = spawnStruct();
  var_4._id_502A = var_0;
  var_4._id_3F02 = var_1;
  var_4.value = var_2;
  var_4.debugname = var_3;
  level.register_unique_kill_funcs = common_scripts\utility::_id_0F6F(level.register_unique_kill_funcs, var_4);
}

contracts_zombies_death_tracking(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;
  var_10 = [];

  if(common_scripts\utility::_id_562E(var_9._id_5A3D))
    var_1 = common_scripts\utility::_id_4461(var_9.origin, level.players);

  if(var_4 == "turretweapon_zeppelin_gun_zm")
    var_1 = common_scripts\utility::_id_4461(var_9.origin, level.players);

  if(var_4 == "drag_explosive_zombie_zm")
    var_1 = var_0._id_0117;

  if(var_4 == "trap_zm_mp") {
    if(isDefined(var_0._id_0117))
      var_1 = var_0._id_0117;
    else
      var_1 = var_0._id_9C92._id_0117;
  }

  if(isDefined(var_0._id_9CBB))
    var_10 = common_scripts\utility::_id_0F6F(var_10, get_trap_value_for_name(var_0._id_9CBB));

  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  var_1 maps\mp\_achievement_engine_z_utils::ae_zm_sendkillevent(var_9, var_9._id_0A4B, maps\mp\_utility::_id_4431(var_4), var_3, var_6, var_10);

  if(var_1 zombies_multikill(var_9, var_4, var_3)) {
    var_1 maps\mp\_achievement_engine_z_utils::ae_zm_sendmultikillevent(var_1.playerzombiemultikilldata);
    var_1.playerzombiemultikilldata = undefined;
  }
}

contracts_tracking_init(var_0) {
  var_1 = self;

  foreach(var_3 in var_0) {
    foreach(var_5 in level.zmb_unique_zombie_contracts[var_3])
    var_1 initialize_player_zombies_contract(var_5);
  }
}

contracts_consecutive_waves_tracking() {
  var_0 = self;
  var_0 endon("disconnect");

  foreach(var_2 in level.zmb_unique_zombie_contracts_reset_funcs["wave_survival"])
  var_0 childthread watch_progress_clear(var_2.reset_func_array, "wave_survival", var_2.condition);

  for(;;) {
    level waittill("round complete");

    foreach(var_5 in var_0.active_contract_tracker["wave_survival"])
    var_5._id_005C++;

    foreach(var_5 in var_0.active_contract_tracker["zombie_purchases"]) {
      switch (var_5.condition) {
        case "player_armor_count_round":
          var_5._id_005C = 0;
          break;
      }
    }

    level notify("wave_survival");
    _id_0547::_id_A6F6();
    maps\mp\_achievement_engine_z_utils::ae_sendwavesurvivalevent_zm(var_0, "survival_wave_single");

    foreach(var_5 in var_0.active_contract_tracker["wave_survival"])
    maps\mp\_achievement_engine_z_utils::ae_sendwavesurvivalevent_zm(var_0, var_5.condition, var_5._id_005C, var_5._id_6E55);
  }
}

contracts_distance_traveled_tracking() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = 5;
  var_2 = var_1;
  var_3 = 5;
  var_4 = spawnStruct();
  var_4.updatetravelfleeingzombie = 0;

  for(;;) {
    wait(var_3);
    var_5 = int(var_0._id_3036 * 0.00158);

    if(var_5 >= var_2) {
      var_2 = var_2 + var_1;

      foreach(var_7 in var_0.active_contract_tracker["player_actions"]) {
        if(var_7.condition == "player_distance_traveled_zombie_threat") {
          if(var_0 is_being_chased_by_zombie()) {
            var_4.updatetravelfleeingzombie = 1;
            var_7._id_005C = var_7._id_005C + var_1;
          }
        }
      }

      var_0 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_distance_traveled_zombie_threat", var_4);
      var_4.updatetravelfleeingzombie = 0;
    }
  }
}

contracts_time_traveled_tracking() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = spawnStruct();
  var_1.updatetravelfrontline = 0;
  var_2 = 1;
  var_3 = 60;

  for(;;) {
    wait 1;

    foreach(var_5 in var_0.active_contract_tracker["player_actions"]) {
      if(var_5.condition == "player_time_traveled_frontline") {
        if(var_0 get_current_active_ability() == "role_ability_taunt_zm" && var_0 is_being_chased_by_zombie()) {
          var_5._id_005C = var_5._id_005C + var_2;

          if(var_5._id_005C >= var_3) {
            var_3 = var_3 + 60;
            var_1.updatetravelfrontline = 1;
            var_0 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_distance_traveled_zombie_threat", var_1);
            var_1.updatetravelfrontline = 0;
          }
        }
      }
    }
  }
}

contracts_report_player_preformed_revive(var_0, var_1) {
  var_2 = var_1;
  var_3 = spawnStruct();
  var_3.player_revives_this_session = undefined;
  var_3.player_revives_unique = undefined;
  var_3.player_revives_camo = undefined;

  foreach(var_5 in var_2.active_contract_tracker["player_actions"]) {
    switch (var_5.condition) {
      case "player_teammate_revives_single_session":
        var_5._id_005C++;
        var_3.player_revives_this_session = var_5._id_005C;
        break;
      case "player_teammate_revives_unique":
        if(!common_scripts\utility::_id_0F79(var_2.session_unique_player_revives_zm, var_0))
          var_2.session_unique_player_revives_zm = common_scripts\utility::_id_0F6F(var_2.session_unique_player_revives_zm, var_0);

        if(var_5._id_005C != var_2.session_unique_player_revives_zm.size) {
          var_5._id_005C = var_2.session_unique_player_revives_zm.size;
          var_3.player_revives_unique = var_5._id_005C;
        }

        break;
      case "player_teammate_revives_camoflauge":
        if(var_2 get_current_active_ability() == "role_ability_camo_zm") {
          var_3.player_revives_camo = 1;
          var_5._id_005C++;
        }

        break;
      default:
        break;
    }
  }

  var_2 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_2, "player_teammate_revives", var_3);
}

contracts_report_player_harvested_spine(var_0, var_1) {
  var_2 = self;

  foreach(var_4 in var_2.active_contract_tracker["player_actions"]) {
    switch (var_4.condition) {
      case "player_harvest_spines":
        var_4 increment_contract_array(var_0);
        var_2 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_2, var_4.condition, var_0);
        break;
    }
  }
}

contracts_report_player_stunned_zombie(var_0) {
  var_1 = self;

  foreach(var_3 in var_1.active_contract_tracker["player_actions"]) {
    switch (var_3.condition) {
      case "player_zombie_shellshock_stun":
        var_3._id_005C = var_3._id_005C + var_0;

        for(var_4 = 0; var_4 < var_0; var_4++)
          var_1 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_1, "player_zombie_shellshock_stun", var_0);

        break;
    }
  }
}

contracts_report_player_earned_money(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1)) {
    return;
  }
  var_2 = self;

  foreach(var_4 in var_2.active_contract_tracker["player_actions"]) {
    switch (var_4.condition) {
      case "player_zombie_aquire_jolts":
        var_4._id_005C = var_4._id_005C + var_0;
        var_2 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_2, "player_zombie_aquire_jolts", var_4._id_005C, 1);
        break;
    }
  }
}

contracts_report_player_special_kills(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::_id_562E(var_0._id_0103);
  var_6 = self;

  foreach(var_8 in var_6.active_contract_tracker["player_actions"]) {
    switch (var_8.condition) {}
  }
}

contracts_report_player_picked_up_fish() {
  var_0 = self;
  maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_zombie_collect_fish");
}

contracts_report_player_aquired_weapon_from_box(var_0) {
  var_1 = self;

  foreach(var_3 in var_1.active_contract_tracker["player_actions"]) {
    switch (var_3.condition) {
      case "player_zombie_aquire_weapon_from_box":
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_1, "player_zombie_aquire_weapon_from_box", maps\mp\_utility::_id_4431(var_0));
        break;
    }
  }
}

contracts_report_player_riding_minecart() {
  var_0 = self;

  foreach(var_2 in var_0.active_contract_tracker["player_actions"]) {
    switch (var_2.condition) {
      case "player_rode_minecart":
        var_2._id_005C++;
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_rode_minecart");
        break;
    }
  }
}

contracts_report_player_destoyed_stuka() {
  var_0 = self;

  foreach(var_2 in var_0.active_contract_tracker["player_actions"]) {
    switch (var_2.condition) {
      case "player_stuka_kills":
        var_2._id_005C++;
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_stuka_kills");
        break;
    }
  }
}

contracts_report_player_destoyed_brenner_gas_tank() {
  var_0 = self;

  foreach(var_2 in var_0.active_contract_tracker["player_actions"]) {
    switch (var_2.condition) {
      case "player_zombie_kills_fireman_tank":
        var_2._id_005C++;
        maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_zombie_kills_fireman_tank");
        break;
    }
  }
}

mp_zombie_nest_01_tower_battle_report_efficiency(var_0) {
  var_1 = 85;
  var_2 = 1;

  if(maps\mp\_utility::_id_4571() == "mp_zombie_nest_01")
    var_2 = 2;

  if(var_0 < var_1)
    self._id_39D8 = 1;

  if(!isDefined(self._id_005C))
    self._id_005C = 0;

  self._id_005C++;

  if(self._id_005C == var_2 && !common_scripts\utility::_id_562E(self._id_39D8))
    level thread quest_contracts_completed(self.name);
}

mp_zombie_nest_01_final_boss_report_completion(var_0) {
  level thread quest_contracts_completed(self.name, var_0);
}

mp_zombie_island_final_boss_report_completion() {
  level thread quest_contracts_completed(self.name);
}

mp_zombie_island_corpse_gate_report_completion() {
  level thread quest_contracts_completed(self.name);
}

mp_zombie_geistcraft_device_powered() {
  level thread quest_contracts_completed(self.name);
}

mp_zombie_berlin_final_boss_report_completion() {
  level thread quest_contracts_completed(self.name);
}

mp_zombie_objective_completed() {
  level thread quest_contracts_completed(self.name);
}

mp_zombie_boss_completed() {
  level thread quest_contracts_completed(self.name);
}

mp_zombie_boss_completed_small() {
  level thread quest_contracts_completed(self.name);
}

quest_contracts_completed(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_3, var_0, var_1);
}

orders_and_contracts_challenge_init(var_0, var_1) {
  level.orders_and_contracts_event_report[var_0] = spawnStruct();
  level.orders_and_contracts_event_report[var_0].name = var_0;
  level.orders_and_contracts_event_report[var_0]._id_1E61 = var_1;
}

is_contracts_game_online() {
  return level.onlinegame || get_testing_contracts_offline();
}

get_testing_contracts_offline() {
  var_0 = 0;
  return var_0;
}

initialize_player_zombies_contract(var_0) {
  var_1 = self;

  if(!isDefined(var_1.active_contract_tracker))
    var_1.active_contract_tracker = [];

  var_2 = spawnStruct();
  var_2._id_6E55 = var_0._id_6E55;
  var_2.condition = var_0.condition;
  var_2._id_005C = 0;
  var_2.complete = 0;
  var_2.name = var_0.name;
  var_2._id_3F02 = var_0._id_3F02;
  var_2.type = var_0.type;

  if(!isDefined(var_1.active_contract_tracker[var_2.type]))
    var_1.active_contract_tracker[var_2.type] = [var_2];
  else
    var_1.active_contract_tracker[var_2.type] = common_scripts\utility::_id_0F6F(var_1.active_contract_tracker[var_2.type], var_2);
}

watch_progress_clear(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_5 in var_0)
  var_3 childthread run_reset_func_array(var_5, var_1, var_2);
}

run_reset_func_array(var_0, var_1, var_2) {
  for(;;)
    try_stat_reset(var_1, var_2, var_0);
}

try_stat_reset(var_0, var_1, var_2) {
  var_3 = [[var_2]]();

  foreach(var_5 in self.active_contract_tracker[var_0]) {
    if(_id_0547::_id_5565(var_5.condition, var_1) && !validate_contract_rule(var_5, var_3))
      var_5._id_005C = 0;
  }
}

validate_contract_rule(var_0, var_1) {
  return ![[var_0._id_3F02]](var_0, var_1);
}

add_generic_contract(var_0, var_1, var_2) {
  create_new_contract_type(var_0, var_1, undefined, undefined, undefined, var_2);
}

add_area_contract(var_0) {
  var_1 = "Survive in ";

  foreach(var_3 in var_0)
  var_1 = var_1 + (var_3 + " ");

  create_new_contract_type("wave_survival", "survival_area", ::contract_fail_on_player_leave_area, [_id_0547::_id_A6F6], var_0, var_1);
}

contracts_init_player_member_variables() {
  var_0 = self;
  var_0.session_unique_perks_zm = [];
  var_0.session_unique_player_revives_zm = [];
  var_0.playerzombiemultikilldata = [];
  var_0.zombie_types_killed_list = [];
}

create_new_contract_type(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "Zombie/^3Orders^7 and ^3Contracts^7/";
  var_7 = var_6 + "1 Track/";
  var_8 = spawnStruct();
  var_8.type = var_0;
  var_8.name = var_5;
  var_8.condition = var_1;
  var_8._id_6E55 = var_4;
  var_8._id_3F02 = var_2;

  if(!isDefined(level.zmb_unique_zombie_contracts))
    level.zmb_unique_zombie_contracts = [];

  if(!isDefined(level.zmb_unique_zombie_contracts_reset_funcs))
    level.zmb_unique_zombie_contracts_reset_funcs = [];

  if(!isDefined(level.zmb_unique_zombie_contracts_reset_funcs[var_0]))
    level.zmb_unique_zombie_contracts_reset_funcs[var_0] = [];

  level.zmb_unique_zombie_contracts_reset_funcs[var_0][var_1] = spawnStruct();
  level.zmb_unique_zombie_contracts_reset_funcs[var_0][var_1].reset_func_array = var_3;
  level.zmb_unique_zombie_contracts_reset_funcs[var_0][var_1].condition = var_1;

  if(!isDefined(level.zmb_unique_zombie_contracts[var_0]))
    level.zmb_unique_zombie_contracts[var_0] = [var_8];
  else
    level.zmb_unique_zombie_contracts[var_0] = common_scripts\utility::_id_0F6F(level.zmb_unique_zombie_contracts[var_0], var_8);
}

get_player_starter_weapons() {
  while(!isDefined(level.zombiemeleeweapon))
    waitframe();

  return _id_0547::get_zombies_mode_starter_weapons(1);
}

get_player_first_box_weapon() {
  if(isDefined(self.zmbcontractsfirstboxweapon))
    return self.zmbcontractsfirstboxweapon;
  else
    return "no_box_weapon";
}

get_current_active_ability() {
  if(common_scripts\utility::_id_562E(self._id_983B))
    return "role_ability_taunt_zm";

  if(common_scripts\utility::_id_562E(self._id_569F))
    return "role_ability_camo_zm";

  if(common_scripts\utility::_id_562E(self._id_5F5C))
    return "role_ability_mad_minute_zm";

  if(common_scripts\utility::_id_3798("stunning_burst_active") && common_scripts\utility::_id_3794("stunning_burst_active"))
    return "role_ability_stunning_burst_zm";

  return "none";
}

contract_fail_on_player_leave_area(var_0, var_1) {
  var_2 = self;
  return !var_2 _id_0547::player_validate_is_in_zones(var_0._id_6E55);
}

contract_validate_weapon_used(var_0, var_1, var_2) {
  var_3 = self;

  if(!_isarray(var_1))
    var_1 = [var_1];

  if(_isarray(var_0)) {
    var_4 = "normal_weapon_check";
    var_5 = var_0;
  } else {
    var_4 = var_0.condition;

    if(_isarray(var_0._id_6E55))
      var_5 = var_0._id_6E55;
    else
      var_5 = [var_0._id_6E55];
  }

  if(common_scripts\utility::_id_0F79(var_5, "no_box_weapon"))
    return 1;

  foreach(var_7 in var_1) {
    var_7 = var_3 set_last_checked_weapon(var_7);
    var_8 = 0;

    foreach(var_10 in var_5) {
      if(var_4 == "survival_shotgun") {
        var_11 = maps\mp\_utility::getweaponclass(_id_0547::zombies_to_mp(var_7), 1);

        if(_id_0547::_id_5565(var_11, var_0._id_6E55) || weapon_is_a_match(var_7, "p38_pap_zm"))
          var_8 = 1;

        continue;
      }

      if(var_3 weapon_is_a_match(var_7, var_10))
        var_8 = 1;
    }

    if(proceed_to_contract_progress_reset(var_8, var_7, 1))
      return 1;
  }

  return 0;
}

weapon_is_a_match(var_0, var_1) {
  var_2 = self;

  if(var_0 == var_1)
    return 1;

  if(issubstr(var_0, "shovel") && issubstr(var_1, "shovel"))
    return 1;

  return 0;
}

set_last_checked_weapon(var_0) {
  var_1 = self;
  var_2 = "";

  if(!isDefined(var_1.lastweaponcheck))
    var_1 save_this_weapon(var_0);

  var_3 = var_1.lastweaponcheckraw;
  var_4 = var_1.lastweaponcheck;

  if(_id_0547::_id_5565(var_0, var_3))
    return var_4;
  else
    var_1 save_this_weapon(var_0);

  return var_1.lastweaponcheck;
}

save_this_weapon(var_0) {
  var_1 = self;
  var_1.lastweaponcheckraw = var_0;
  var_1.lastweaponcheck = _id_0547::_id_AAF9(var_0);
}

proceed_to_contract_progress_reset(var_0, var_1, var_2) {
  if(common_scripts\utility::_id_562E(var_2)) {
    if(issubstr(var_1, "drag_explosive"))
      return 0;

    if(var_1 == "none")
      return 0;

    if(_id_0547::iszombieindirectweapon(var_1))
      return 0;

    if(_id_0547::_id_5866(var_1) || _id_0547::_id_5863(var_1) && !_id_0547::_id_5565(var_1, "alt+wunderbuss_zm"))
      return 0;
  }

  return !var_0;
}

contract_fail_on_player_move(var_0, var_1) {
  if(!isDefined(self.previouszmbcontractorigin))
    self.previouszmbcontractorigin = self.origin;

  var_2 = self.previouszmbcontractorigin;
  var_3 = self.origin;
  var_4 = var_2 != var_3;
  self.previouszmbcontractorigin = self.origin;
  return var_4;
}

contract_fail_on_not_crouched(var_0, var_1) {
  var_2 = self getstance();
  return !_id_0547::_id_5565(var_2, "crouch");
}

contract_fail_on_zone_change(var_0, var_1, var_2) {
  if(!isDefined(self.previouszmbzone))
    self.previouszmbzone = _id_055A::_id_462D();

  if(!isDefined(self.previouszmbzone))
    return 0;

  var_3 = self.previouszmbzone;
  var_4 = _id_055A::_id_462D();

  if(!isDefined(var_4))
    return 0;

  var_5 = !_id_0547::_id_5565(var_3, var_4);

  if(!common_scripts\utility::_id_562E(var_2))
    self.previouszmbzone = var_4;

  return var_5;
}

contract_fail_on_new_zone(var_0, var_1) {
  return contract_fail_on_zone_change(var_0, var_1, 1);
}

succeed_on_inventory_aquired(var_0, var_1) {
  return 4;
}

contract_fail_on_player_damage(var_0, var_1) {
  return 1;
}

get_next_player_weapon() {
  var_0 = self;
  var_0 waittill("weapons_used", var_1);
  return var_1;
}

wait_for_player_volume_touch_update(var_0) {
  wait 1;
  return 1;
}

get_weapon_on_round_change() {
  level waittill("wave_survival");
  return self getcurrentweapon();
}

contract_reset_on_wave_break() {
  level waittill("round complete");
  var_0 = self;

  foreach(var_2 in var_0.active_contract_tracker["zombie_purchases"]) {
    switch (var_2.condition) {
      case "player_armor_count_round":
        var_2._id_005C = 0;
        break;
    }
  }
}

wait_for_player_dmg() {
  var_0 = undefined;

  while(!isDefined(var_0) || !agent_is_zombie(undefined, var_0))
    self waittill("damage", var_1, var_0);

  return 1;
}

agent_is_zombie(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1._id_0A4B);
}

wait_for_player_purchase_perk() {
  self waittill("forever");
  return 1;
}

get_unique_perks_total(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!common_scripts\utility::_id_0F79(var_1, var_3.name))
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3.name);
  }

  return var_1;
}

initialize_per_player_tracking() {
  level thread maps\mp\_utility::_id_6F74(::contracts_init_player_member_variables);
  level thread maps\mp\_utility::_id_6F74(::contracts_tracking_init, ["wave_survival", "zombie_purchases", "player_actions"]);
}

zombies_multikill(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3.playerzombiemultikills))
    var_3.playerzombiemultikills = [];

  var_4 = [];
  var_4["zombie_type"] = var_0._id_0A4B;
  var_4["weapon"] = maps\mp\_utility::_id_4431(var_1);
  var_4["means_of_death"] = var_2;
  var_4["origin"] = var_0.origin;
  var_3.playerzombiemultikills = common_scripts\utility::_id_0F6F(var_3.playerzombiemultikills, var_4);

  if(!common_scripts\utility::_id_562E(var_3.starttrackingmultikill)) {
    var_3.starttrackingmultikill = 1;
    return var_3 contracts_report_player_multikills();
  } else
    return 0;
}

contracts_report_player_multikills() {
  self endon("disconnect");

  for(var_0 = 0; var_0 < 3; var_0++)
    waitframe();

  var_1 = self.playerzombiemultikills.size >= 5;

  if(var_1)
    self.playerzombiemultikilldata = self.playerzombiemultikills;
  else
    self.playerzombiemultikilldata = undefined;

  self.starttrackingmultikill = 0;
  self.playerzombiemultikills = undefined;
  return var_1;
}

is_being_chased_by_zombie() {
  var_0 = _id_0547::_id_408F();

  if(var_0.size == 0)
    return 0;

  var_1 = 0;

  foreach(var_3 in var_0) {
    if(_id_0547::_id_5565(var_3._id_28D2, self))
      return 1;
  }

  return 0;
}

get_num_unique_zombie_kills(var_0) {
  var_1 = self;

  if(!common_scripts\utility::_id_0F79(var_1.zombie_types_killed_list, var_0))
    var_1.zombie_types_killed_list = common_scripts\utility::_id_0F6F(var_1.zombie_types_killed_list, var_0);
}

increment_contract_array(var_0) {
  var_1 = self;

  if(!isDefined(var_1.count_arr))
    var_1.count_arr = [];

  if(!isDefined(var_1.count_arr[var_0])) {
    var_1.count_arr[var_0] = spawnStruct();
    var_1.count_arr[var_0].name = var_0;
    var_1.count_arr[var_0]._id_005C = 0;
  }

  var_1.count_arr[var_0]._id_005C++;
}

mp_zombie_map_won(var_0) {
  maps\mp\_achievement_engine_z_utils::ae_sendmapwon_zm(var_0);
}

start_boss_battle_tracking() {
  common_scripts\utility::flag_set("zmb_contracts_boss_battle_active");
}

end_boss_battle_tracking() {
  common_scripts\utility::_id_3C7B("zmb_contracts_boss_battle_active");
}

contracts_start_track_boss_battle_laststand() {
  var_0 = self;
  var_0 endon("disconnect");
  common_scripts\utility::_id_3C9F("zmb_contracts_boss_battle_active");
  var_0 endon("enter_last_stand");

  while(common_scripts\utility::_id_3C77("zmb_contracts_boss_battle_active"))
    waitframe();

  var_0 maps\mp\_achievement_engine_z_utils::ae_sendzombiesspecial_zm(var_0, "player_zombie_boss_no_laststand");
}