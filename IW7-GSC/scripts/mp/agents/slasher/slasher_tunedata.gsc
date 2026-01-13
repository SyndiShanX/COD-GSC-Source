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

setupslashertunedata(var_0) {
  var_0.slasher_spin_damage_range_sq = 5625;
  var_0.slasher_spin_damage_amt = 60;
  var_0.ram_attack_collision_dist_sq = 1024;
  var_0.ram_attack_melee_dist_sq = 2025;
  var_0.ram_attack_dot = 0.5;
  var_0.ram_attack_push = 120;
  var_0.ram_attack_damage = 90;
  var_0.ram_attack_go_straight_radius_sq = 5625;
  var_0.min_ram_attack_interval = 1000;
  var_0.max_ram_attack_interval = 4000;
  var_0.ram_attack_mindist_sq = 14400;
  var_0.ram_attack_maxdist_sq = 122500;
  var_0.ram_attack_abort_dist_sq = 202500;
  var_0.ram_attack_chase_radius = 70;
  var_0.ram_attack_chase_radius_if_playing_chicken = 120;
  var_0.ram_attack_timeout = 3000;
  var_0.min_sawblade_fire_interval = 0.5;
  var_0.max_sawblade_fire_interval = 1.5;
  var_0.sawblade_burst_interval = 0.15;
  var_0.sawblade_burst_chance = 100;
  var_0.min_burst_count = 2;
  var_0.max_burst_count = 5;
  var_0.sawblade_min_offset = -24;
  var_0.sawblade_max_offset = 24;
  var_0.sawblade_min_randomness = 0.9;
  var_0.sawblade_max_randomness = 1.1;
  var_0.no_los_wait_time_before_teleport = 3000;
  var_0.min_time_between_teleports = 2000;
  var_0.min_jump_scare_dist_to_player = 0;
  var_0.max_jump_scare_dist_to_player = 1000;
  var_0.attempt_teleport_if_no_engagement_within_time = 8000;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 1000000;
  var_0.min_path_dist_for_teleport = 512;
  var_0.min_grenade_throw_interval = 10000;
  var_0.max_grenade_throw_interval = 30000;
  var_0.min_grenade_throw_dist_sq = -25536;
  var_0.max_grenade_throw_dist_sq = 1562500;
  var_0.min_sawblade_attack_dist_sq = 160000;
  var_0.max_sawblade_attack_dist_sq = 2250000;
  var_0.min_sawblade_attack_time = 2000;
  var_0.max_sawblade_attack_time = 4000;
  var_0.min_sawblade_attack_interval = 3000;
  var_0.max_sawblade_attack_interval = 6000;
  var_0.min_clear_los_time_before_firing_saw = 1000;
  var_0.min_dist_to_enemy_for_taunt_sq = 262144;
  var_0.min_taunt_interval = 15000;
  var_0.max_taunt_interval = 20000;
  var_0.taunt_chance = 75;
  var_0.min_summon_interval = 8000;
  var_0.max_summon_interval = 15000;
  var_0.summon_chance = 25;
  var_0.need_to_block_damage_threshold = 500;
  var_0.max_time_after_last_damage_to_block = 333;
  var_0.block_chance = 75;
  var_0.min_block_time = 3000;
  var_0.max_block_time = 6000;
  var_0.quit_block_if_no_damage_time = 1000;
  var_0.min_block_interval = 10000;
  var_0.max_block_interval = 15000;
  var_0.ground_pound_radius_sq = 30625;
  var_0.ground_pound_damage_radius_sq = -25536;
  var_0.min_moving_pain_dist = 128;
}

gettunedata() {
  return level.agenttunedata["slasher"];
}