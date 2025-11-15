/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\ratking\ratking_tunedata.gsc
**********************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.soloratkingtuning = ::setupsoloratkingtunedata;
  level.ratkingtuning = ::setupratkingtunedata;
  level.agenttunedata["ratking"] = spawnStruct();
  setupsoloratkingtunedata(level.agenttunedata["ratking"]);
}

setupratkingtunedata(param_00) {
  param_00.slasher_spin_damage_range_sq = 5625;
  param_00.slasher_spin_damage_amt = 60;
  param_00.min_grenade_throw_interval = 10000;
  param_00.max_grenade_throw_interval = 30000;
  param_00.min_grenade_throw_dist_sq = -25536;
  param_00.max_grenade_throw_dist_sq = 1562500;
  param_00.min_dist_to_enemy_for_taunt_sq = 262144;
  param_00.min_taunt_interval = 15000;
  param_00.max_taunt_interval = 20000;
  param_00.taunt_chance = 75;
  param_00.min_summon_interval = 10000;
  param_00.max_summon_interval = 20000;
  param_00.summon_chance = 100;
  param_00.need_to_block_damage_threshold = 20;
  param_00.max_time_after_last_damage_to_block = 1000;
  param_00.block_chance = 100;
  param_00.min_block_time = 5000;
  param_00.max_block_time = 10000;
  param_00.quit_block_if_no_damage_time = 2000;
  param_00.min_block_interval = 10000;
  param_00.max_block_interval = 20000;
  param_00.staff_stomp_inner_radius_sq = 5625;
  param_00.staff_stomp_outer_radius_sq = 22500;
  param_00.staff_stomp_damage_radius = 175;
  param_00.staff_stomp_interval = 10000;
  param_00.staff_stomp_inner_interval = 3000;
  param_00.staff_stomp_max_damage = 200;
  param_00.staff_stomp_min_damage = 30;
  param_00.min_moving_pain_dist = 128;
  param_00.staff_projectile_min_dist_sq = -25536;
  param_00.staff_projectile_max_dist_sq = 262144;
  param_00.staff_projectile_interval_min = 10000;
  param_00.staff_projectile_interval_max = 20000;
  param_00.staff_projectile_z_delta = 60;
  param_00.staff_projectile_speed = 1000;
  param_00.staff_projectile_range = 1000;
  param_00.staff_projectile_damage = 85;
  param_00.staff_projectile_interval = 0.1;
  param_00.staff_shield_attack_min_dist_sq = 90000;
  param_00.staff_shield_attack_max_dist_sq = 6250000;
  param_00.staff_shield_attack_interval_min = 10000;
  param_00.staff_shield_attack_interval_max = 20000;
  param_00.min_clear_los_time_before_shield_attack = 500;
  param_00.min_path_dist_for_teleport = 500;
  param_00.no_los_wait_time_before_teleport = 500;
  param_00.min_time_between_teleports = 5000;
  param_00.min_time_between_traversal_teleports = 1500;
  param_00.min_teleport_dist_to_player = 300;
  param_00.max_teleport_dist_to_player = 700;
  param_00.min_travel_dist_for_teleport = 400;
  param_00.telefrag_dist_sq = 576;
  param_00.attempt_teleport_if_no_engagement_within_time = 2500;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  param_00.cfastteleportduetodamagechance = 100;
  param_00.cfastteleportdamagepct = 0.001;
  param_00.cdamageaccumulationcleartimems = 750;
  param_00.cfastteleportmindisttoenemytoteleport = 100;
  param_00.cfastteleportcloseindistpctmin = 0.7;
  param_00.cfastteleportcloseindistpctmax = 0.8;
  param_00.cfastteleportminangledelta = 85;
  param_00.cfastteleportmaxangledelta = 86;
  param_00.csprinterteleportminangledelta = 5;
  param_00.csprinterteleportmaxangledelta = 15;
  param_00.csprinterteleportmindist = 400;
  param_00.csprinterteleportmaxdist = 500;
  param_00.summon_agent_type = "karatemaster";
  param_00.summon_min_spawn_num = 4;
  param_00.summon_max_spawn_num = 6;
  param_00.summon_min_radius = 100;
  param_00.summon_max_radius = 600;
  param_00.summon_spawn_min_dist_between_agents_sq = 2500;
  param_00.max_num_agents_to_allow_summon = 1;
  param_00.min_time_between_summon_rounds = 5000;
  if(isDefined(level.rk_tuning_override)) {
    [[level.rk_tuning_override]](param_00);
  }
}

setupsoloratkingtunedata(param_00) {
  param_00.slasher_spin_damage_range_sq = 5625;
  param_00.slasher_spin_damage_amt = 60;
  param_00.min_grenade_throw_interval = 10000;
  param_00.max_grenade_throw_interval = 30000;
  param_00.min_grenade_throw_dist_sq = -25536;
  param_00.max_grenade_throw_dist_sq = 1562500;
  param_00.min_dist_to_enemy_for_taunt_sq = 262144;
  param_00.min_taunt_interval = 15000;
  param_00.max_taunt_interval = 20000;
  param_00.taunt_chance = 75;
  param_00.min_summon_interval = 8000;
  param_00.max_summon_interval = 15000;
  param_00.summon_chance = 100;
  param_00.need_to_block_damage_threshold = 20;
  param_00.max_time_after_last_damage_to_block = 1000;
  param_00.block_chance = 100;
  param_00.min_block_time = 2000;
  param_00.max_block_time = 5000;
  param_00.quit_block_if_no_damage_time = 2000;
  param_00.min_block_interval = 10000;
  param_00.max_block_interval = 20000;
  param_00.staff_stomp_inner_radius_sq = 2500;
  param_00.staff_stomp_outer_radius_sq = 22500;
  param_00.staff_stomp_damage_radius = 175;
  param_00.staff_stomp_interval = 10000;
  param_00.staff_stomp_inner_interval = 3000;
  param_00.staff_stomp_max_damage = 200;
  param_00.staff_stomp_min_damage = 30;
  param_00.min_moving_pain_dist = 128;
  param_00.staff_projectile_min_dist_sq = -25536;
  param_00.staff_projectile_max_dist_sq = 262144;
  param_00.staff_projectile_interval_min = 10000;
  param_00.staff_projectile_interval_max = 20000;
  param_00.staff_projectile_z_delta = 60;
  param_00.staff_projectile_speed = 1000;
  param_00.staff_projectile_range = 1000;
  param_00.staff_projectile_damage = 85;
  param_00.staff_projectile_interval = 0.1;
  param_00.staff_shield_attack_min_dist_sq = 90000;
  param_00.staff_shield_attack_max_dist_sq = 2250000;
  param_00.staff_shield_attack_interval_min = 3000;
  param_00.staff_shield_attack_interval_max = 5000;
  param_00.min_clear_los_time_before_shield_attack = 1000;
  param_00.min_path_dist_for_teleport = 400;
  param_00.no_los_wait_time_before_teleport = 500;
  param_00.min_time_between_teleports = 5000;
  param_00.min_time_between_traversal_teleports = 1500;
  param_00.min_teleport_dist_to_player = 300;
  param_00.max_teleport_dist_to_player = 700;
  param_00.min_travel_dist_for_teleport = 400;
  param_00.telefrag_dist_sq = 576;
  param_00.attempt_teleport_if_no_engagement_within_time = 4000;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  param_00.cfastteleportduetodamagechance = 100;
  param_00.cfastteleportdamagepct = 0.001;
  param_00.cdamageaccumulationcleartimems = 750;
  param_00.cfastteleportmindisttoenemytoteleport = 100;
  param_00.cfastteleportcloseindistpctmin = 0.7;
  param_00.cfastteleportcloseindistpctmax = 0.8;
  param_00.cfastteleportminangledelta = 85;
  param_00.cfastteleportmaxangledelta = 86;
  param_00.csprinterteleportminangledelta = 5;
  param_00.csprinterteleportmaxangledelta = 15;
  param_00.csprinterteleportmindist = 400;
  param_00.csprinterteleportmaxdist = 500;
  param_00.summon_agent_type = "karatemaster";
  param_00.summon_min_spawn_num = 4;
  param_00.summon_max_spawn_num = 6;
  param_00.summon_min_radius = 100;
  param_00.summon_max_radius = 600;
  param_00.summon_spawn_min_dist_between_agents_sq = 2500;
  param_00.max_num_agents_to_allow_summon = 0;
  param_00.min_time_between_summon_rounds = 3000;
  if(isDefined(level.rk_solo_tuning_override)) {
    [[level.rk_solo_tuning_override]](param_00);
  }
}

gettunedata() {
  return level.agenttunedata["ratking"];
}