/****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\crab_brute\crab_brute_tunedata.gsc
****************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["crab_brute"] = spawnStruct();
  setupmytunedata(level.agenttunedata["crab_brute"]);
}

setupmytunedata(var_0) {
  var_0.min_dist_to_enemy_to_do_arrival_sq = 250000;
  var_0.max_dist_to_taunt_sq = 490000;
  var_0.initial_burrow_wait_time_ms = 2000;
  var_0.burrow_mindist_sq = 262144;
  var_0.burrow_maxdist_sq = 9000000;
  var_0.max_burrow_goal_radius = 128;
  var_0.min_burrow_goal_radius = 64;
  var_0.min_burrow_interval_ms = 5000;
  var_0.max_burrow_interval_ms = 12000;
  var_0.burrow_look_ahead_time = 0.25;
  var_0.burrow_path_check_interval_dist = 64;
  var_0.burrow_outro_damage_wait_time = 0.5;
  var_0.burrow_outro_damage_radius = 200;
  var_0.burrow_outro_min_damage_amt = 35;
  var_0.burrow_outro_max_damage_amt = 50;
  var_0.post_burrow_charge_chance = 30;
  var_0.post_burrow_taunt_chance = 20;
  var_0.post_burrow_flash_chance = 0;
  var_0.post_burrow_summon_chance = 20;
  var_0.post_burrow_nothing_chance = 30;
  var_0.charge_attack_damage_amt = 80;
  var_0.charge_attack_damage_radius_sq = 2500;
  var_0.charge_attack_stop_facing_enemy_dist_sq = 22500;
  var_0.max_charge_time_ms = 3000;
  var_0.charge_abort_dot = 0;
  var_0.charge_attack_damage_dot = 0;
  var_0.charge_attack_mindist_sq = 14400;
  var_0.charge_attack_maxdist_sq = 122500;
  var_0.charge_attack_abort_dist_sq = 202500;
  var_0.max_charge_attack_interval_ms = 6000;
  var_0.min_charge_attack_interval_ms = 3000;
  var_0.max_tired_time_ms = 2000;
  var_0.min_tired_time_ms = 1000;
  var_0.need_to_block_damage_threshold = 500;
  var_0.max_time_after_last_damage_to_block = 333;
  var_0.block_chance = 75;
  var_0.min_block_time = 3000;
  var_0.max_block_time = 6000;
  var_0.quit_block_if_no_damage_time = 1000;
  var_0.min_block_interval = 10000;
  var_0.max_block_interval = 15000;
  var_0.reduce_damage_dot = 0.25;
  var_0.reduce_damage_pct = 0.15;
  var_0.shield_reduce_damage_pct = 0;
  var_0.shield_damage_dot = 0.25;
  var_0.shields_up_duration_ms = 1000;
  var_0.flash_chance = 80;
  var_0.flash_radius_sq = 1000000;
  var_0.flash_dot = 0.5;
  var_0.flash_duration = 2.5;
  var_0.flash_rumble_duration = 1;
  var_0.flash_min_dist_to_enemy_to_attempt_sq = 16384;
  var_0.min_initial_flash_wait_time_ms = 3000;
  var_0.max_initial_flash_wait_time_ms = 10000;
  var_0.flash_min_interval_ms = 8000;
  var_0.flash_max_interval_ms = 12000;
  var_0.flash_min_time_after_summon_ms = 8000;
  var_0.min_moving_pain_dist = 128;
  var_0.summon_chance = 60;
  var_0.summon_max_radius = 1000;
  var_0.summon_min_radius = 500;
  var_0.summon_spawn_min_dist_between_agents_sq = 2500;
  var_0.summon_min_spawn_num_per_player = 1;
  var_0.summon_max_spawn_num_per_player = 2;
  var_0.summon_min_dist_to_enemy_to_attempt_sq = 65536;
  var_0.summon_min_interval_ms = 15000;
  var_0.summon_max_interval_ms = 20000;
  var_0.max_allowed_minis_to_allow_new_summon = 0;
  var_0.min_initial_summon_wait_time_ms = 5000;
  var_0.max_initial_summon_wait_time_ms = 15000;
  var_0.summon_min_time_after_flash_ms = 5000;
  var_0.melee_max_z_diff = 60;
}

gettunedata() {
  return level.agenttunedata["crab_brute"];
}