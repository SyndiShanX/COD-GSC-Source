/*******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_difficulty.gsc
*******************************************************************/

func_00D5() {
  level.zmb_sg_difficulty_settings = [];
  level.zmb_sg_player_rank_modifiers = [];
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Defense Objective Health", "defense_common", 1250, 750, 1, 0.85, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Defense Objective Time", "type_defense_common_timer", [90, 120], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Defense Objective Outline Helper", "type_defense_common_outline_dist", [700, 700]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Defense Objective Zombie Attacker Increase", "type_defense_common_zombie_attacker_count_wave", 1, 1, 1, 2);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Defense Objective Max Zombie Attackers", "type_defense_common_zombie_attacker_count_max", [5]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Defense Objective Zombie Attackers Add", "type_defense_common_zombie_attacker_count", [1, 2, 15, 3, 40, 5]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Defense Objective Includes Bombers", "type_defense_common_zombie_attacker_allow_bombers", [1, 0, 70, 1]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Defense Objective Low Level Health Buff", "type_defense_common_generator_health_buff", [1, 500, 4, 400, 5, 0]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Red Skull Defense Objective Health", "type_defense_common_generator_health_red_skull", [1, 1, 200, 0.2]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Repair Objective Time", "type_keypoint_interact_repair_common_timer", [180, 120], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Repair Objective Repair Guards Appearance by Objective wave", "type_keypoint_interact_repair_common_guard_min_objective_count", [3, 2]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Repair Objective Repair Time", "type_keypoint_interact_repair_common_time", [2.75, 5, 5, 5]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Repair Objective Repair Guards", "type_keypoint_interact_repair_common_guard_info", [1, [1, "zombie_heavy"], 80, [2, "zombie_heavy"]]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Repair Objective Repair Guards Appearance by Valve", "type_keypoint_interact_repair_common_guard_timing_info", [1, 3, 20, 2, 80, 1]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Extermination Time", "type_extermination_common_timer", [150, 180], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Extermination Spawn Delay", "extermination_common_delay", 0.8, 0.5, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Extermination Spawn Count", "extermination_common_count", 20, 35, 1, 2, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Extermination Sizzler Max base", "extermination_common_sizzler_maximum", 3, 3, 1, 4, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Extermination Spawn Count Multiplier", "extermination_common_player_level_extension", [1, 1, 20, 1, 40, 1.25, 60, 1.5, 80, 1.6]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Extermination Bomber Walk Time", "extermination_common_bomber_force_run_start", [1, 10, 20, 8, 40, 6, 60, 4, 80, 0]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Extermination Sizzler Max add", "extermination_common_sizzler_add", [1, 0, 20, 1, 80, 2]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Red Skull Extermination Objective Health", "extermination_common_extermination_health_multiplier", [1, 1, 200, 1.85]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Red Skull Extermination Hit React Disabled", "extermination_common_extermination_hitreacts_enabled", [1, 0, 200, 1]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassin Squad Count", "meuchler_common_count", 2, 2, 1, 2, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassin Health", "meuchler_common_health", 5000, 8000, 1, 3, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassin Leader Health", "meuchler_common_leader_health", 9000, 13000, 1, 3, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassin Objective time", "type_meuchler_common_timer", [150, 180], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassin Leader Type", "meuchler_common_leader_type", [1, maps\mp\zombies\shotgun\_zombies_shotgun_v1_objective_mods::get_assassin_types(0), 30, maps\mp\zombies\shotgun\_zombies_shotgun_v1_objective_mods::get_assassin_types(1), 85, maps\mp\zombies\shotgun\_zombies_shotgun_v1_objective_mods::get_assassin_types(2)]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassin Leader Health Buff", "meuchler_common_leader_health_buff", [1, 1, 30, 1.2, 85, 1.35, 200, 2.3]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassin Red Skull All Special", "meuchler_common_all_leaders", [1, 0, 200, 1]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassinate Zombie Time", "type_assassinate_common_timer", [180, 150], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassinate Zombie Health", "type_assassinate_common_health", 19000, 81400, 1, 5.9);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassinate First Objective MAX", "type_assassinate_common_repitions_first_max", [2]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Assassinate Zombie Energy Hold", "type_assassinate_common_energy_hold", [1, 0, 0, 0]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassinate Other Zombie Count", "type_assassinate_common_other_zombies_count", [1, 4, 40, 6, 60, 10, 80, 14]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassinate Repitions", "type_assassinate_common_repitions", [1, 1, 6, 2, 40, 3, 80, 4]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassinate Force Run Start Time", "type_assassinate_common_run_start", [1, 20, 40, 17, 65, 15, 90, 14]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassinate Next Target delay", "type_assassinate_common_next_spawn_time", [1, 3, 40, 4, 65, 5]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassinate VIB Wave 9 Double Trouble Chance", "type_assassinate_common_double_trouble_chance", [1, 0, 40, 20, 90, 45]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassinate Reps-Red Skull", "type_assassinate_common_red_skull_repitions", [1, 0, 200, 2]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Assassinate VIB Count-Red Skull", "type_assassinate_common_red_skull_count", [1, 0, 200, 2]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Escort Time", "type_escort_timer", [180, 180], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Escort Health", "type_escort_health", 700, 500, 1, 0.75, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Escort Health-Red Skull", "type_escort_health_redskull", [1, 1, 200, 0.2]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Escape Delay", "type_escape_common_delay", [40, 40]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Escape Time", "type_escape_common_capture_time", 25, 25, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Escape Radius", "type_escape_common_capture_radius", 200, 200, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Boss Base Health", "type_boss_health", 210000, 798000);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Boss Base time", "type_boss_timer", [300, 300]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Boss Red Skull Health Multiplier", "type_boss_health_red_skull", [0, 1, 200, 1.35]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Boss Red Skull Assassin Health", "type_boss_health_assassin_red_skull", -5536, 228000);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Zepplin Weakpoint Health", "zepplin_weakpoint_health", 1250, 2750, 1, 1.25, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Zepplin Attack Time", "blimp_attack_timer", [180, 180], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Zepplin Max Sizzlers", "blimp_attack_sizzlers_create", [1, 0, 90, 1, 200, 4]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Zepplin Sizzlers Min Objectives Required", "blimp_attack_sizzlers_create_wave", [1, 999, 90, 2, 200, 0]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Zepplin Override Weakpoint Reveal time", "blimp_attack_weapoint_reveal_time", [0, 0, 200, 3.5]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Zepplin Pauses waves", "zmf_zepplin_pauses_zombie_waves", [0, 1, 200, 0]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Zepplin Rockets Focused", "blimp_attack_rockets_focuses", [0, 0, 200, 1]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Zepplin Has Delayed Rockets", "blimp_attack_rockets_quickdraw", [1, 0, 6, 1]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Fireman Sheild Disabled Time", "zmb_fireman_boss_shield_downtime", 19, 14, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Fireman Is Red Skull", "zmb_fireman_boss_is_uber", [0, 0, 200, 1]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_player_level_setting("Bob max sizzler creation", "zmb_beast_max_sizzler_count", [0, 0, 40, 1, 80, 2, 200, 4]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Bomb Defuse Objective Defuse Time", "keypoint_interact_bomb_defuse_time", 3, 6, 1, 1);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Bomb Defuse Objective Time", "keypoint_interact_bomb_timer", 300, 180, 1, 0.85);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Visions Time", "visions_timer", [150, 180], 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Visions Count", "dnk_ext_visions_count", 30, 45, 1, 2, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Blood Plates Time", "blood_plates_timer", 240, 210, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Blood Plates Kills Requirement", "blood_plates_kills_per_plate", 10, 15, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Dig Sizzler Health", "dig_ext_siz_count", 15, 20, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Dig Sizzler Delay", "dig_ext_siz_delay", 4, 2, 1, 1, undefined, undefined);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Guardian Boss Time", "boss_guardian_timer", [300, 300]);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Alter Defense Time", "altar_defense_timer", 120, 120);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Alter Defense Health", "altar_defense_altar_health", 2500, 2000, 1, 0.85);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Alter Defense Minion Health", "altar_defense_health_per_minion_kill", 65, 75);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Alter Defense Minion Count", "altar_defense_max_minion_count", 4, 5);
  level.zombies_shotgun_weapons_level["weapon_pistol"] = 1;
  level.zombies_shotgun_weapons_level["weapon_smg"] = 1;
  level.zombies_shotgun_weapons_level["weapon_shotgun"] = 2;
  level.zombies_shotgun_weapons_level["weapon_assault"] = 2;
  level.zombies_shotgun_weapons_level["weapon_sniper"] = 3;
  level.zombies_shotgun_weapons_level["weapon_heavy"] = 3;
  level.zombies_shotgun_weapons_cost["weapon_pistol"] = 500;
  level.zombies_shotgun_weapons_cost["weapon_smg"] = 2000;
  level.zombies_shotgun_weapons_cost["weapon_shotgun"] = 2750;
  level.zombies_shotgun_weapons_cost["weapon_assault"] = 3000;
  level.zombies_shotgun_weapons_cost["weapon_sniper"] = 3000;
  level.zombies_shotgun_weapons_cost["weapon_heavy"] = 4250;
  level.var_7F1B = 20;
  level._zmb_roles_positive_power_multiplier = 0.7;
  level.zmb_shotgun_jack_in_box_odds = 0;
  level.zmb_shotgun_jack_in_box_odds_add_per_spin = 5;
  level.zmb_global_zombie_health_multiplier_wave_start = 4;
  level.zmb_global_zombie_health_multiplier = 1.1;
  level.zmb_zm_roles_exponential_cost = 1.7;
  level thread maps\mp\_utility::func_6F74(::adjust_zombie_health_on_connected);
  level.dynamic_special_enemy_add = [];
  level.dynamic_special_enemy_add["zombie_heavy"] = [];
  level.dynamic_special_enemy_add["zombie_heavy"][0] = [0, 0];
  level.dynamic_special_enemy_add["zombie_heavy"][1] = [0, 1];
  level.dynamic_special_enemy_add["zombie_heavy"][2] = [1, 2];
  level.dynamic_special_enemy_add["zombie_heavy"][3] = [2, 2];
  level.dynamic_special_enemy_add["zombie_heavy"][4] = [2, 2];
  level.dynamic_special_enemy_add["zombie_exploder"] = [];
  level.dynamic_special_enemy_add["zombie_exploder"][0] = [0, 0];
  level.dynamic_special_enemy_add["zombie_exploder"][1] = [2, 3];
  level.dynamic_special_enemy_add["zombie_exploder"][2] = [3, 4];
  level.dynamic_special_enemy_add["zombie_exploder"][3] = [4, 4];
  level.dynamic_special_enemy_add["zombie_exploder"][4] = [4, 4];
}

boost_special_enemy_waves() {
  lib_056D::func_52B5();
  foreach(var_0F, var_01 in level.var_3774) {
    foreach(var_0E, var_03 in level.var_3774[var_0F]) {
      foreach(var_0D, var_05 in level.var_3774[var_0F][var_0E]) {
        var_06 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_current_team_level();
        var_07 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_percentage(var_06);
        var_08 = int(5 * var_07 / 100 - 1);
        if(var_08 < 0) {
          var_08 = 0;
        }

        var_09 = var_0E / level.var_3774[var_0F][var_0E].size;
        if(isDefined(level.dynamic_special_enemy_add[var_0D])) {
          var_0A = level.dynamic_special_enemy_add[var_0D][var_08][0];
          var_0B = level.dynamic_special_enemy_add[var_0D][var_08][1];
          var_0C = int(var_0F * lerp(var_0A, var_0B, var_09));
          level.var_3774[var_0F][var_0E][var_0D] = level.var_3774[var_0F][var_0E][var_0D] + var_0C;
        }
      }
    }
  }
}

adjust_zombie_health_on_connected() {
  while(!isDefined(level.var_744A) || level.var_744A.size == 0) {
    wait 0.05;
  }

  var_00 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_current_team_level();
  level.zmb_global_zombie_health_multiplier = lerp(1.1, 1.9, maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_percentage(var_00) / 100);
}

initialize_care_package_rewards() {
  level.zmb_shotgun_carepackage_rewards = [];
  var_00 = level.zombies_shotgun_weapons_in_play["weapon_pistol"];
  var_01 = common_scripts\utility::func_F73(level.zombies_shotgun_weapons_in_play["weapon_smg"], ["dp28_zm"]);
  var_01 = common_scripts\utility::func_F73(var_01, ["winchester1897_zm", "walther_zm"]);
  var_02 = common_scripts\utility::func_F73(level.zombies_shotgun_weapons_in_play["weapon_assault"], level.zombies_shotgun_weapons_in_play["weapon_heavy"]);
  var_02 = common_scripts\utility::func_F73(var_02, ["ptrs41_zm", "delisle_zm", "leveraction_zm", "arisaka_zm"]);
  level.zmb_shotgun_carepackage_rewards["money_0"] = 0;
  level.zmb_shotgun_carepackage_rewards["money_1"] = 1000;
  level.zmb_shotgun_carepackage_rewards["money_2"] = 2000;
  level.zmb_shotgun_carepackage_rewards["money_3"] = 3000;
  var_03 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_berlin_melee_weapons();
  var_04 = [];
  var_05 = ["fliegerfaust_zm", "razergun_zm", "teslagun_zm"];
  var_06 = ["teslagun_zm_moon", "teslagun_zm_blood", "teslagun_zm_death", "teslagun_zm_storm", "razergun_pap_zm"];
  var_07 = common_scripts\utility::func_F73(["dp28_pap_zm", "dp28_pap_zm", "dp28_pap_zm", "sdk_pap_zm", "charlton_pap_zm", "emp44_pap_zm"], ["m1911_pap_zm", "p38_pap_zm", "svt40_pap_zm", "m1garand_pap_zm"]);
  if(lib_0547::func_5836("wz35_zm")) {
    var_07 = ["dp28_pap_zm", "dp28_pap_zm", "emp44_pap_zm", "wz35_pap_zm", "lad_pap_zm", "kgm21_pap_zm", "emp44_pap_zm", "m1911_pap_zm"];
  }

  if(lib_0547::func_5836("mas36_zm")) {
    var_07 = common_scripts\utility::func_F73(var_07, ["mas36_pap_zm", "austen_pap_zm"]);
  }

  if(lib_0547::func_5836("bechowiec_zm")) {
    var_07 = common_scripts\utility::func_F73(var_07, ["bechowiec_pap_zm"]);
  }

  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_care_package_reward(0, var_00, []);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_care_package_reward(1, var_00, var_04, var_03);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_care_package_reward(2, var_01, var_05);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_care_package_reward(3, var_02, var_06, undefined, var_07);
}