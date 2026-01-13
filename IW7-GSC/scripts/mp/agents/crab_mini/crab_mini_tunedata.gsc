/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\crab_mini\crab_mini_tunedata.gsc
**************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["crab_mini"] = spawnStruct();
  setupmytunedata(level.agenttunedata["crab_mini"]);
}

setupmytunedata(var_0) {
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
  var_0.chance_to_get_stuck_if_hit = 0;
  var_0.chance_to_get_stuck_if_miss = 100;
  var_0.stuck_min_time_ms = 1000;
  var_0.stuck_max_time_ms = 2000;
  var_0.min_dist_to_enemy_to_allow_turn_sq = -25536;
  var_0.max_dist_to_enemy_to_allow_turn_sq = 1048576;
  var_0.min_stop_facing_enemy_time_before_hit = 0.3;
  var_0.max_stop_facing_enemy_time_before_hit = 0.4;
  var_0.melee_max_z_diff = 60;
  var_0.avg_time_to_impact = 0.5;
  var_0.reduce_damage_dot = 0.25;
  var_0.reduce_damage_pct = 0.15;
}

gettunedata() {
  return level.agenttunedata["crab_mini"];
}