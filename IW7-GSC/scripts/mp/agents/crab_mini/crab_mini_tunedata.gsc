/**************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\crab_mini\crab_mini_tunedata.gsc
**************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["crab_mini"] = spawnStruct();
  setupmytunedata(level.agenttunedata["crab_mini"]);
}

setupmytunedata(param_00) {
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
  param_00.chance_to_get_stuck_if_hit = 0;
  param_00.chance_to_get_stuck_if_miss = 100;
  param_00.stuck_min_time_ms = 1000;
  param_00.stuck_max_time_ms = 2000;
  param_00.min_dist_to_enemy_to_allow_turn_sq = -25536;
  param_00.max_dist_to_enemy_to_allow_turn_sq = 1048576;
  param_00.min_stop_facing_enemy_time_before_hit = 0.3;
  param_00.max_stop_facing_enemy_time_before_hit = 0.4;
  param_00.melee_max_z_diff = 60;
  param_00.avg_time_to_impact = 0.5;
  param_00.reduce_damage_dot = 0.25;
  param_00.reduce_damage_pct = 0.15;
}

gettunedata() {
  return level.agenttunedata["crab_mini"];
}