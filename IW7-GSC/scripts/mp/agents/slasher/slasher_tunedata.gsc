/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\slasher\slasher_tunedata.gsc
**********************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["slasher"] = spawnStruct();
  setupslashertunedata(level.agenttunedata["slasher"]);
}

setupslashertunedata(param_00) {
  param_00.slasher_spin_damage_range_sq = 5625;
  param_00.slasher_spin_damage_amt = 60;
  param_00.ram_attack_collision_dist_sq = 1024;
  param_00.ram_attack_melee_dist_sq = 2025;
  param_00.ram_attack_dot = 0.5;
  param_00.ram_attack_push = 120;
  param_00.ram_attack_damage = 90;
  param_00.ram_attack_go_straight_radius_sq = 5625;
  param_00.min_ram_attack_interval = 1000;
  param_00.max_ram_attack_interval = 4000;
  param_00.ram_attack_mindist_sq = 14400;
  param_00.ram_attack_maxdist_sq = 122500;
  param_00.ram_attack_abort_dist_sq = 202500;
  param_00.ram_attack_chase_radius = 70;
  param_00.ram_attack_chase_radius_if_playing_chicken = 120;
  param_00.ram_attack_timeout = 3000;
  param_00.min_sawblade_fire_interval = 0.5;
  param_00.max_sawblade_fire_interval = 1.5;
  param_00.sawblade_burst_interval = 0.15;
  param_00.sawblade_burst_chance = 100;
  param_00.min_burst_count = 2;
  param_00.max_burst_count = 5;
  param_00.sawblade_min_offset = -24;
  param_00.sawblade_max_offset = 24;
  param_00.sawblade_min_randomness = 0.9;
  param_00.sawblade_max_randomness = 1.1;
  param_00.no_los_wait_time_before_teleport = 3000;
  param_00.min_time_between_teleports = 2000;
  param_00.min_jump_scare_dist_to_player = 0;
  param_00.max_jump_scare_dist_to_player = 1000;
  param_00.attempt_teleport_if_no_engagement_within_time = 8000;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 1000000;
  param_00.min_path_dist_for_teleport = 512;
  param_00.min_grenade_throw_interval = 10000;
  param_00.max_grenade_throw_interval = 30000;
  param_00.min_grenade_throw_dist_sq = -25536;
  param_00.max_grenade_throw_dist_sq = 1562500;
  param_00.min_sawblade_attack_dist_sq = 160000;
  param_00.max_sawblade_attack_dist_sq = 2250000;
  param_00.min_sawblade_attack_time = 2000;
  param_00.max_sawblade_attack_time = 4000;
  param_00.min_sawblade_attack_interval = 3000;
  param_00.max_sawblade_attack_interval = 6000;
  param_00.min_clear_los_time_before_firing_saw = 1000;
  param_00.min_dist_to_enemy_for_taunt_sq = 262144;
  param_00.min_taunt_interval = 15000;
  param_00.max_taunt_interval = 20000;
  param_00.taunt_chance = 75;
  param_00.min_summon_interval = 8000;
  param_00.max_summon_interval = 15000;
  param_00.summon_chance = 25;
  param_00.need_to_block_damage_threshold = 500;
  param_00.max_time_after_last_damage_to_block = 333;
  param_00.block_chance = 75;
  param_00.min_block_time = 3000;
  param_00.max_block_time = 6000;
  param_00.quit_block_if_no_damage_time = 1000;
  param_00.min_block_interval = 10000;
  param_00.max_block_interval = 15000;
  param_00.ground_pound_radius_sq = 30625;
  param_00.ground_pound_damage_radius_sq = -25536;
  param_00.min_moving_pain_dist = 128;
}

gettunedata() {
  return level.agenttunedata["slasher"];
}