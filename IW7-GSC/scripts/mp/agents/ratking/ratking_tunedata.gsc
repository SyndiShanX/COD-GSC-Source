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

setupratkingtunedata(var_0) {
  var_0.slasher_spin_damage_range_sq = 5625;
  var_0.slasher_spin_damage_amt = 60;
  var_0.min_grenade_throw_interval = 10000;
  var_0.max_grenade_throw_interval = 30000;
  var_0.min_grenade_throw_dist_sq = -25536;
  var_0.max_grenade_throw_dist_sq = 1562500;
  var_0.min_dist_to_enemy_for_taunt_sq = 262144;
  var_0.min_taunt_interval = 15000;
  var_0.max_taunt_interval = 20000;
  var_0.taunt_chance = 75;
  var_0.min_summon_interval = 10000;
  var_0.max_summon_interval = 20000;
  var_0.summon_chance = 100;
  var_0.need_to_block_damage_threshold = 20;
  var_0.max_time_after_last_damage_to_block = 1000;
  var_0.block_chance = 100;
  var_0.min_block_time = 5000;
  var_0.max_block_time = 10000;
  var_0.quit_block_if_no_damage_time = 2000;
  var_0.min_block_interval = 10000;
  var_0.max_block_interval = 20000;
  var_0.staff_stomp_inner_radius_sq = 5625;
  var_0.staff_stomp_outer_radius_sq = 22500;
  var_0.staff_stomp_damage_radius = 175;
  var_0.staff_stomp_interval = 10000;
  var_0.staff_stomp_inner_interval = 3000;
  var_0.staff_stomp_max_damage = 200;
  var_0.staff_stomp_min_damage = 30;
  var_0.min_moving_pain_dist = 128;
  var_0.staff_projectile_min_dist_sq = -25536;
  var_0.staff_projectile_max_dist_sq = 262144;
  var_0.staff_projectile_interval_min = 10000;
  var_0.staff_projectile_interval_max = 20000;
  var_0.staff_projectile_z_delta = 60;
  var_0.staff_projectile_speed = 1000;
  var_0.staff_projectile_range = 1000;
  var_0.staff_projectile_damage = 85;
  var_0.staff_projectile_interval = 0.1;
  var_0.staff_shield_attack_min_dist_sq = 90000;
  var_0.staff_shield_attack_max_dist_sq = 6250000;
  var_0.staff_shield_attack_interval_min = 10000;
  var_0.staff_shield_attack_interval_max = 20000;
  var_0.min_clear_los_time_before_shield_attack = 500;
  var_0.min_path_dist_for_teleport = 500;
  var_0.no_los_wait_time_before_teleport = 500;
  var_0.min_time_between_teleports = 5000;
  var_0.min_time_between_traversal_teleports = 1500;
  var_0.min_teleport_dist_to_player = 300;
  var_0.max_teleport_dist_to_player = 700;
  var_0.min_travel_dist_for_teleport = 400;
  var_0.telefrag_dist_sq = 576;
  var_0.attempt_teleport_if_no_engagement_within_time = 2500;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  var_0.cfastteleportduetodamagechance = 100;
  var_0.cfastteleportdamagepct = 0.001;
  var_0.cdamageaccumulationcleartimems = 750;
  var_0.cfastteleportmindisttoenemytoteleport = 100;
  var_0.cfastteleportcloseindistpctmin = 0.7;
  var_0.cfastteleportcloseindistpctmax = 0.8;
  var_0.cfastteleportminangledelta = 85;
  var_0.cfastteleportmaxangledelta = 86;
  var_0.csprinterteleportminangledelta = 5;
  var_0.csprinterteleportmaxangledelta = 15;
  var_0.csprinterteleportmindist = 400;
  var_0.csprinterteleportmaxdist = 500;
  var_0.summon_agent_type = "karatemaster";
  var_0.summon_min_spawn_num = 4;
  var_0.summon_max_spawn_num = 6;
  var_0.summon_min_radius = 100;
  var_0.summon_max_radius = 600;
  var_0.summon_spawn_min_dist_between_agents_sq = 2500;
  var_0.max_num_agents_to_allow_summon = 1;
  var_0.min_time_between_summon_rounds = 5000;
  if(isDefined(level.rk_tuning_override)) {
    [[level.rk_tuning_override]](var_0);
  }
}

setupsoloratkingtunedata(var_0) {
  var_0.slasher_spin_damage_range_sq = 5625;
  var_0.slasher_spin_damage_amt = 60;
  var_0.min_grenade_throw_interval = 10000;
  var_0.max_grenade_throw_interval = 30000;
  var_0.min_grenade_throw_dist_sq = -25536;
  var_0.max_grenade_throw_dist_sq = 1562500;
  var_0.min_dist_to_enemy_for_taunt_sq = 262144;
  var_0.min_taunt_interval = 15000;
  var_0.max_taunt_interval = 20000;
  var_0.taunt_chance = 75;
  var_0.min_summon_interval = 8000;
  var_0.max_summon_interval = 15000;
  var_0.summon_chance = 100;
  var_0.need_to_block_damage_threshold = 20;
  var_0.max_time_after_last_damage_to_block = 1000;
  var_0.block_chance = 100;
  var_0.min_block_time = 2000;
  var_0.max_block_time = 5000;
  var_0.quit_block_if_no_damage_time = 2000;
  var_0.min_block_interval = 10000;
  var_0.max_block_interval = 20000;
  var_0.staff_stomp_inner_radius_sq = 2500;
  var_0.staff_stomp_outer_radius_sq = 22500;
  var_0.staff_stomp_damage_radius = 175;
  var_0.staff_stomp_interval = 10000;
  var_0.staff_stomp_inner_interval = 3000;
  var_0.staff_stomp_max_damage = 200;
  var_0.staff_stomp_min_damage = 30;
  var_0.min_moving_pain_dist = 128;
  var_0.staff_projectile_min_dist_sq = -25536;
  var_0.staff_projectile_max_dist_sq = 262144;
  var_0.staff_projectile_interval_min = 10000;
  var_0.staff_projectile_interval_max = 20000;
  var_0.staff_projectile_z_delta = 60;
  var_0.staff_projectile_speed = 1000;
  var_0.staff_projectile_range = 1000;
  var_0.staff_projectile_damage = 85;
  var_0.staff_projectile_interval = 0.1;
  var_0.staff_shield_attack_min_dist_sq = 90000;
  var_0.staff_shield_attack_max_dist_sq = 2250000;
  var_0.staff_shield_attack_interval_min = 3000;
  var_0.staff_shield_attack_interval_max = 5000;
  var_0.min_clear_los_time_before_shield_attack = 1000;
  var_0.min_path_dist_for_teleport = 400;
  var_0.no_los_wait_time_before_teleport = 500;
  var_0.min_time_between_teleports = 5000;
  var_0.min_time_between_traversal_teleports = 1500;
  var_0.min_teleport_dist_to_player = 300;
  var_0.max_teleport_dist_to_player = 700;
  var_0.min_travel_dist_for_teleport = 400;
  var_0.telefrag_dist_sq = 576;
  var_0.attempt_teleport_if_no_engagement_within_time = 4000;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  var_0.cfastteleportduetodamagechance = 100;
  var_0.cfastteleportdamagepct = 0.001;
  var_0.cdamageaccumulationcleartimems = 750;
  var_0.cfastteleportmindisttoenemytoteleport = 100;
  var_0.cfastteleportcloseindistpctmin = 0.7;
  var_0.cfastteleportcloseindistpctmax = 0.8;
  var_0.cfastteleportminangledelta = 85;
  var_0.cfastteleportmaxangledelta = 86;
  var_0.csprinterteleportminangledelta = 5;
  var_0.csprinterteleportmaxangledelta = 15;
  var_0.csprinterteleportmindist = 400;
  var_0.csprinterteleportmaxdist = 500;
  var_0.summon_agent_type = "karatemaster";
  var_0.summon_min_spawn_num = 4;
  var_0.summon_max_spawn_num = 6;
  var_0.summon_min_radius = 100;
  var_0.summon_max_radius = 600;
  var_0.summon_spawn_min_dist_between_agents_sq = 2500;
  var_0.max_num_agents_to_allow_summon = 0;
  var_0.min_time_between_summon_rounds = 3000;
  if(isDefined(level.rk_solo_tuning_override)) {
    [[level.rk_solo_tuning_override]](var_0);
  }
}

gettunedata() {
  return level.agenttunedata["ratking"];
}