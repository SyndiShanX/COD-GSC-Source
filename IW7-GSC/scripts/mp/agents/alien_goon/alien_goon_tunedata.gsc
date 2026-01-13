/****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\alien_goon\alien_goon_tunedata.gsc
****************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["alien_goon"] = spawnStruct();
  setupmytunedata(level.agenttunedata["alien_goon"]);
}

setupmytunedata(var_0) {
  var_0.min_time_between_melee_attacks_ms = 1000;
  var_0.melee_max_flex_xy_scale = 2.5;
  var_0.melee_xy_scale_boost = 0.5;
  var_0.non_predicted_move_melee_dist_sq = 6724;
  var_0.check_reachable_dist_sq = 4096;
  var_0.moving_melee_attack_damage_radius_sq = 1600;
  var_0.melee_attack_damage_radius_sq = 9216;
  var_0.melee_dot = 0.867;
  var_0.stand_melee_dist_sq = 4096;
  var_0.stand_melee_attack_dot = 0.707;
  var_0.move_melee_dist_sq = 16384;
  var_0.post_attack_taunt_chance = 50;
  var_0.post_attack_max_enemy_dist_sq = 256;
  var_0.stumble_interval_ms = 10000;
  var_0.stumble_damage_pct = 0.25;
  var_0.stumble_chance = 50;
  var_0.min_dist_to_enemy_to_allow_turn_sq = -25536;
  var_0.max_dist_to_enemy_to_allow_turn_sq = 1048576;
  var_0.min_stop_facing_enemy_time_before_hit = 0.1;
  var_0.max_stop_facing_enemy_time_before_hit = 0.15;
  var_0.melee_max_z_diff = 60;
  var_0.avg_time_to_impact = 0.7;
  var_0.reduce_damage_dot = 0.25;
  var_0.reduce_damage_pct = 0.15;
  var_0.min_enemy_dist_to_dodge_sq = 65536;
  var_0.dodge_chance = 75;
  var_0.min_dodge_test_interval_ms = 250;
  var_0.min_dodge_interval_ms = 6000;
  var_0.min_dodge_scale = 0.3;
  var_0.max_dodge_scale = 0.5;
  var_0.wander_goal_radius = 64;
  var_0.wander_min_wait_time_ms = 1000;
  var_0.wander_max_wait_time_ms = 2500;
  var_0.jump_attack_damage_radius_sq = 8100;
  var_0.jump_attack_min_enemy_dot = 0.985;
  var_0.jump_attack_damage_dot = 0.867;
  var_0.jump_attack_melee_damage_multiplier = 1.1;
  var_0.jump_attack_initial_delay_ms = 5000;
  var_0.jump_attack_min_interval = 10000;
  var_0.max_leap_melee_drop_distance = 64;
  var_0.min_leap_distance_sq = 90000;
  var_0.max_leap_distance_sq = 562500;
  var_0.leap_offset_xy = 48;
  var_0.avg_leap_speed = 500;
  var_0.teleport_chance = 0;
  var_0.min_dist_to_teleport_sq = 1409865409;
  var_0.force_melee_attack_damage_radius_sq = 256;
}