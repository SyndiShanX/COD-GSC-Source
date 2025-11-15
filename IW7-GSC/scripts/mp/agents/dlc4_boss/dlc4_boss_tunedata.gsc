/**************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\dlc4_boss\dlc4_boss_tunedata.gsc
**************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["dlc4_boss"] = spawnStruct();
  setupmytunedata(level.agenttunedata["dlc4_boss"]);
  setupfighttunedata(level.agenttunedata["dlc4_boss"]);
  setupfightweighttunedata(level.agenttunedata["dlc4_boss"]);
  setupspecialwavetunedata(level.agenttunedata["dlc4_boss"]);
  setupfrenziedtunedata(level.agenttunedata["dlc4_boss"]);
}

setupmytunedata(param_00) {
  param_00.fireball_weight = 3;
  param_00.clap_weight = 0;
  param_00.throw_weight = 0;
  param_00.tornado_weight = 0;
  param_00.summon_weight = 1;
  param_00.move_left_weight = 0.25;
  param_00.move_right_weight = 0.25;
  param_00.move_fireball_left_weight = 2;
  param_00.move_fireball_right_weight = 2;
  param_00.idle_weight = 0.5;
  param_00.air_pound_weight = 0.8;
  param_00.drop_move_weight = 0.75;
  param_00.fly_over_weight = 0.7;
  param_00.ground_vul_weight = 0;
  param_00.black_hole_weight = 0.7;
  param_00.eclipse_weight = 0.7;
  param_00.ground_pound_weight = 0;
  param_00.move_clap_left_weight = 0;
  param_00.move_clap_right_weight = 0;
  param_00.teleport_weight = 0;
  param_00.fireball_cooldown_time = 4000;
  param_00.clap_cooldown_time = -25536;
  param_00.throw_cooldown_time = 20000;
  param_00.tornado_cooldown_time = 20000;
  param_00.summon_cooldown_time = 20000;
  param_00.move_left_cooldown_time = 6000;
  param_00.move_right_cooldown_time = 6000;
  param_00.move_fireball_left_cooldown_time = 6000;
  param_00.move_fireball_right_cooldown_time = 6000;
  param_00.air_pound_cooldown_time = 20000;
  param_00.drop_move_cooldown_time = 15000;
  param_00.temp_idle_cooldown_time = 5000;
  param_00.fly_over_cooldown_time = 20000;
  param_00.black_hole_cooldown_time = 30000;
  param_00.eclipse_cooldown_time = 0;
  param_00.ground_vul_cooldown_time = 0;
  param_00.passive_cooldown = 7000;
  param_00.special_cooldown = 10000;
  param_00.min_burst_count = 3;
  param_00.max_burst_count = 5;
  param_00.sawblade_min_offset = -30;
  param_00.sawblade_max_offset = 30;
  param_00.sawblade_burst_interval = 0.3;
  param_00.sawblade_weapon = "iw7_demon_fireball_mp";
  param_00.chance_to_target_charger = 0.7;
  param_00.throw_weapon = "iw7_demon_throw_mp";
  param_00.throw_offset = (0, 0, 500);
  param_00.throw_distance = 2000;
  param_00.throw_fidelity = 5;
  param_00.throw_starting_pitch = 10;
  param_00.throw_side_yaw = 10;
  param_00.throw_meteor_radius = 130;
  param_00.clap_duration = 10000;
  param_00.staff_projectile_min_dist_sq = -25536;
  param_00.staff_projectile_max_dist_sq = 262144;
  param_00.staff_projectile_z_delta = 60;
  param_00.staff_projectile_speed = 1000;
  param_00.staff_projectile_range = 1000;
  param_00.staff_projectile_damage = 300;
  param_00.staff_projectile_interval = 0.1;
  param_00.ratking_staff_projectile_model = "tag_origin_staff_proj";
  param_00.summon_agent_type = "skeleton";
  param_00.summon_min_spawn_num = [];
  param_00.summon_max_spawn_num = [];
  param_00.summon_min_spawn_num["1"] = 6;
  param_00.summon_max_spawn_num["1"] = 10;
  param_00.summon_min_spawn_num["2"] = 8;
  param_00.summon_max_spawn_num["2"] = 13;
  param_00.summon_min_spawn_num["3"] = 8;
  param_00.summon_max_spawn_num["3"] = 13;
  param_00.summon_min_spawn_num["4"] = 10;
  param_00.summon_max_spawn_num["4"] = 15;
  param_00.summon_max_total = [];
  param_00.summon_max_total["1"] = 10;
  param_00.summon_max_total["2"] = 13;
  param_00.summon_max_total["3"] = 15;
  param_00.summon_max_total["4"] = 17;
  param_00.summon_min_radius = 100;
  param_00.summon_max_radius = 450;
  param_00.summon_min_dist_from_player = 200;
  param_00.summon_min_zombies_before_active = 12;
  param_00.skeleton_health = 8500;
  param_00.automatic_spawn_time = 3000;
  param_00.automatic_spawn_cap = 2;
  param_00.min_idle_time = 500;
  param_00.max_idle_time = 3000;
  param_00.min_move_nodes = 2;
  param_00.max_move_nodes = 5;
  param_00.look_ahead_speed = 20;
  param_00.look_ahead_radius = 200;
  param_00.strafe_move_nodes = 4;
  param_00.ground_vul_time = 8000;
  param_00.ground_pound_radius = 300;
  param_00.ground_pound_min_damage = 95;
  param_00.ground_pound_max_damage = 300;
  param_00.zombies_per_person = 0;
  param_00.zombies_summon_radius = 200;
  param_00.drop_down_time = 1000;
  param_00.fly_over_nodes_travelled = 7;
  param_00.persistent_fire_damage = 50;
  param_00.persistent_fire_rate = 0.1;
  param_00.fly_over_speed = 1.5;
  param_00.ss_groundpound_radius = 500;
  param_00.ss_groundpound_min_damage = 95;
  param_00.ss_groundpound_max_damage = 500;
  param_00.air_pound_rise_fx = level._effect["vfx_demon_spawn"];
  param_00.air_pound_pound_fx = level._effect["demon_pound_slam_lrg"];
  param_00.air_pound_pound_sfx = "rocket_explode_energy";
  param_00.air_pound_pound_rumble_scale = 0.45;
  param_00.air_pound_pound_rumble_duration = 3;
  param_00.air_pound_pound_rumble_radius = 750;
  param_00.air_pound_rise_rumble_scale = 0.35;
  param_00.air_pound_rise_rumble_duration = 3;
  param_00.air_pound_rise_rumble_radius = 750;
  param_00.black_hole_duration = 5000;
  param_00.armageddon_duration = 15000;
  param_00.safe_zone_radius = 300;
  param_00.meteor_min_period = 0.1;
  param_00.meteor_max_period = 0.5;
  param_00.meteor_period_stage_decay = 0.85;
  param_00.meteor_target_radius = 1000;
  param_00.eclipse_duration = 180000;
}

setupfighttunedata(param_00) {
  param_00.max_soul_health = 4;
  param_00.section_complete_notify = "SECTION_COMPLETE_NOTIFY";
  param_00.weak_spot_model = "zmb_superslasher_weak_spot";
  param_00.weak_spot_health = 12500;
  param_00.min_health_percent = 0.15;
  param_00.var_3CCC = 30000;
  param_00.charge_rate = 1 / param_00.var_3CCC;
  param_00.decharge_time = 10000;
  param_00.decharge_rate = 1 / param_00.decharge_time;
  param_00.buffer_time_solo = 6000;
  param_00.buffer_time_coop = 4000;
  param_00.active_time = 180000;
  param_00.stolen_ghost_model = "zombie_ghost_cube_blue";
  param_00.zombie_ghost_model = "dlc4_boss_soul";
  param_00.fake_ghost_model = "fake_dlc4_boss_soul";
  param_00.num_souls_released = 6;
  param_00.soul_max_distance_from_arena = 5000;
  param_00.soul_explosion_radius = 70;
  param_00.boss_mid_height = 150;
  param_00.boss_mid_offset = 0;
  param_00.soul_mid_height = 12;
  param_00.soul_health_depleted_notify = "SOUL_HEALTH_DEPLETED";
  param_00.soul_respawn_time = 2000;
  param_00.soul_lifetime = 2000;
  param_00.entangler_weapon_name = "iw7_entangler_zm";
  param_00.entangler_stop_notify = "stop_using_entangler";
  param_00.entangler_hit_same_target_notify = "entangler_hit_same_target";
  param_00.entangler_track_update_frequency = 0.2;
  param_00.entangler_recharge_rate = 0.5;
  param_00.entangler_track_time = 0.5;
}

setupfightweighttunedata(param_00) {
  param_00.move_base_weight = 3;
  param_00.move_stage_multiplier = -0.15;
  param_00.idle_base_weight = 1;
  param_00.idle_stage_multiplier = 0;
  param_00.drop_move_base_weight = 0.5;
  param_00.drop_move_stage_multiplier = 0;
  param_00.fireball_base_weight = 1.8;
  param_00.fireball_stage_multiplier = 0.15;
  param_00.move_fireball_base_weight = 1.8;
  param_00.move_fireball_stage_multiplier = 0.15;
  param_00.black_hole_base_weight = 0.5;
  param_00.black_hole_stage_multiplier = 0.2;
  param_00.black_hole_charge_multiplier = 0.5;
  param_00.fly_over_base_weight = 0.6;
  param_00.fly_over_stage_multiplier = 0.2;
  param_00.summon_base_weight = 50;
  param_00.summon_stage_multiplier = 0;
  param_00.special_base_weight = 2.2;
  param_00.special_stage_multiplier = 0.1;
}

setupspecialwavetunedata(param_00) {
  param_00.base_spawn_interval = 2;
  param_00.spawn_interval_decay = 0.9;
  param_00.specialwavesdata = [];
  param_00.specialwavesdata["BASIC_1"] = 15;
  param_00.specialwavesdata["PHANTOM_1"] = 4;
  param_00.specialwavesdata["SPECIAL_1"] = ["zombie_clown", "zombie_clown", "zombie_clown", "zombie_clown", "zombie_clown", "zombie_clown"];
  param_00.specialwavesdata["BASIC_2"] = 18;
  param_00.specialwavesdata["PHANTOM_2"] = 6;
  param_00.specialwavesdata["SPECIAL_2"] = ["slasher"];
  param_00.specialwavesdata["BASIC_3"] = 21;
  param_00.specialwavesdata["PHANTOM_3"] = 7;
  param_00.specialwavesdata["SPECIAL_3"] = ["karatemaster", "karatemaster", "karatemaster", "karatemaster"];
  param_00.specialwavesdata["BASIC_4"] = 24;
  param_00.specialwavesdata["PHANTOM_4"] = 8;
  param_00.specialwavesdata["SPECIAL_4"] = ["alien_rhino", "alien_rhino"];
}

setupfrenziedtunedata(param_00) {
  param_00.frenzied_health = 250000;
  param_00.last_stand_health = 20000;
  param_00.frenzied_damage_cap = 1500;
  param_00.frenzied_damage_cap_wave_increase = 1500;
  param_00.frenzied_damage_cap_time = 0.5;
  param_00.last_stand_time = 15000;
  param_00.last_stand_victory_min_time = 8000;
  param_00.frenzied_blink_chance = 0.05;
  param_00.frenzied_move_weight = 0;
  param_00.frenzied_idle_weight = 0;
  param_00.frenzied_drop_move_weight = 0;
  param_00.frenzied_fireball_weight = 1.5;
  param_00.frenzied_move_fireball_weight = 2.5;
  param_00.frenzied_black_hole_weight = 0.5;
  param_00.frenzied_fly_over_weight = 0.7;
  param_00.frenzied_summon_weight = 0;
  param_00.frenzied_special_weight = 1.1;
  param_00.frenzied_summon_min_interval = 0.5;
  param_00.frenzied_summon_max_interval = 1;
  param_00.frenzied_summon_wave_period = -20536;
  param_00.frenzied_summon_number = 8;
  param_00.frenzied_summon_increase_per_wave = 2;
  param_00.frenzied_summon_start_wave = 4;
  param_00.frenzied_summon_agents = ["skeleton", "alien_goon", "alien_phantom", "zombie_clown", "karatemaster", "slasher", "alien_rhino"];
  param_00.frenzied_summon_data = [];
  param_00.frenzied_summon_data["skeleton"] = [10, 2];
  param_00.frenzied_summon_data["alien_goon"] = [10, 2];
  param_00.frenzied_summon_data["zombie_clown"] = [6, 4];
  param_00.frenzied_summon_data["alien_phantom"] = [6, 7];
  param_00.frenzied_summon_data["karatemaster"] = [5, 10];
  param_00.frenzied_summon_data["alien_rhino"] = [5, 35];
  param_00.frenzied_summon_data["slasher"] = [5, 60];
  param_00.frenzied_meteor_min_period = 0.5;
  param_00.frenzied_meteor_max_period = 1;
  param_00.frenzied_meteor_target_radius = 1200;
  param_00.frenzied_meteor_target_min_radius = 800;
}