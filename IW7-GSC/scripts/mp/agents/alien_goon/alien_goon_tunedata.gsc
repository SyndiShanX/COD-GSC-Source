/****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\alien_goon\alien_goon_tunedata.gsc
****************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["alien_goon"] = spawnStruct();
  setupmytunedata(level.agenttunedata["alien_goon"]);
}

setupmytunedata(param_00) {
  param_00.min_time_between_melee_attacks_ms = 1000;
  param_00.melee_max_flex_xy_scale = 2.5;
  param_00.melee_xy_scale_boost = 0.5;
  param_00.non_predicted_move_melee_dist_sq = 6724;
  param_00.check_reachable_dist_sq = 4096;
  param_00.moving_melee_attack_damage_radius_sq = 1600;
  param_00.melee_attack_damage_radius_sq = 9216;
  param_00.melee_dot = 0.867;
  param_00.stand_melee_dist_sq = 4096;
  param_00.stand_melee_attack_dot = 0.707;
  param_00.move_melee_dist_sq = 16384;
  param_00.post_attack_taunt_chance = 50;
  param_00.post_attack_max_enemy_dist_sq = 256;
  param_00.stumble_interval_ms = 10000;
  param_00.stumble_damage_pct = 0.25;
  param_00.stumble_chance = 50;
  param_00.min_dist_to_enemy_to_allow_turn_sq = -25536;
  param_00.max_dist_to_enemy_to_allow_turn_sq = 1048576;
  param_00.min_stop_facing_enemy_time_before_hit = 0.1;
  param_00.max_stop_facing_enemy_time_before_hit = 0.15;
  param_00.melee_max_z_diff = 60;
  param_00.avg_time_to_impact = 0.7;
  param_00.reduce_damage_dot = 0.25;
  param_00.reduce_damage_pct = 0.15;
  param_00.min_enemy_dist_to_dodge_sq = 65536;
  param_00.dodge_chance = 75;
  param_00.min_dodge_test_interval_ms = 250;
  param_00.min_dodge_interval_ms = 6000;
  param_00.min_dodge_scale = 0.3;
  param_00.max_dodge_scale = 0.5;
  param_00.wander_goal_radius = 64;
  param_00.wander_min_wait_time_ms = 1000;
  param_00.wander_max_wait_time_ms = 2500;
  param_00.jump_attack_damage_radius_sq = 8100;
  param_00.jump_attack_min_enemy_dot = 0.985;
  param_00.jump_attack_damage_dot = 0.867;
  param_00.jump_attack_melee_damage_multiplier = 1.1;
  param_00.jump_attack_initial_delay_ms = 5000;
  param_00.jump_attack_min_interval = 10000;
  param_00.max_leap_melee_drop_distance = 64;
  param_00.min_leap_distance_sq = 90000;
  param_00.max_leap_distance_sq = 562500;
  param_00.leap_offset_xy = 48;
  param_00.avg_leap_speed = 500;
  param_00.teleport_chance = 0;
  param_00.min_dist_to_teleport_sq = 1409865409;
  param_00.force_melee_attack_damage_radius_sq = 256;
}