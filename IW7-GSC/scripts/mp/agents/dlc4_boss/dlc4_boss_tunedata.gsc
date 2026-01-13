/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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

setupmytunedata(var_0) {
  var_0.fireball_weight = 3;
  var_0.clap_weight = 0;
  var_0.throw_weight = 0;
  var_0.tornado_weight = 0;
  var_0.summon_weight = 1;
  var_0.move_left_weight = 0.25;
  var_0.move_right_weight = 0.25;
  var_0.move_fireball_left_weight = 2;
  var_0.move_fireball_right_weight = 2;
  var_0.idle_weight = 0.5;
  var_0.air_pound_weight = 0.8;
  var_0.drop_move_weight = 0.75;
  var_0.fly_over_weight = 0.7;
  var_0.ground_vul_weight = 0;
  var_0.black_hole_weight = 0.7;
  var_0.eclipse_weight = 0.7;
  var_0.ground_pound_weight = 0;
  var_0.move_clap_left_weight = 0;
  var_0.move_clap_right_weight = 0;
  var_0.teleport_weight = 0;
  var_0.fireball_cooldown_time = 4000;
  var_0.clap_cooldown_time = -25536;
  var_0.throw_cooldown_time = 20000;
  var_0.tornado_cooldown_time = 20000;
  var_0.summon_cooldown_time = 20000;
  var_0.move_left_cooldown_time = 6000;
  var_0.move_right_cooldown_time = 6000;
  var_0.move_fireball_left_cooldown_time = 6000;
  var_0.move_fireball_right_cooldown_time = 6000;
  var_0.air_pound_cooldown_time = 20000;
  var_0.drop_move_cooldown_time = 15000;
  var_0.temp_idle_cooldown_time = 5000;
  var_0.fly_over_cooldown_time = 20000;
  var_0.black_hole_cooldown_time = 30000;
  var_0.eclipse_cooldown_time = 0;
  var_0.ground_vul_cooldown_time = 0;
  var_0.passive_cooldown = 7000;
  var_0.special_cooldown = 10000;
  var_0.min_burst_count = 3;
  var_0.max_burst_count = 5;
  var_0.sawblade_min_offset = -30;
  var_0.sawblade_max_offset = 30;
  var_0.sawblade_burst_interval = 0.3;
  var_0.sawblade_weapon = "iw7_demon_fireball_mp";
  var_0.chance_to_target_charger = 0.7;
  var_0.throw_weapon = "iw7_demon_throw_mp";
  var_0.throw_offset = (0, 0, 500);
  var_0.throw_distance = 2000;
  var_0.throw_fidelity = 5;
  var_0.throw_starting_pitch = 10;
  var_0.throw_side_yaw = 10;
  var_0.throw_meteor_radius = 130;
  var_0.clap_duration = 10000;
  var_0.staff_projectile_min_dist_sq = -25536;
  var_0.staff_projectile_max_dist_sq = 262144;
  var_0.staff_projectile_z_delta = 60;
  var_0.staff_projectile_speed = 1000;
  var_0.staff_projectile_range = 1000;
  var_0.staff_projectile_damage = 300;
  var_0.staff_projectile_interval = 0.1;
  var_0.ratking_staff_projectile_model = "tag_origin_staff_proj";
  var_0.summon_agent_type = "skeleton";
  var_0.summon_min_spawn_num = [];
  var_0.summon_max_spawn_num = [];
  var_0.summon_min_spawn_num["1"] = 6;
  var_0.summon_max_spawn_num["1"] = 10;
  var_0.summon_min_spawn_num["2"] = 8;
  var_0.summon_max_spawn_num["2"] = 13;
  var_0.summon_min_spawn_num["3"] = 8;
  var_0.summon_max_spawn_num["3"] = 13;
  var_0.summon_min_spawn_num["4"] = 10;
  var_0.summon_max_spawn_num["4"] = 15;
  var_0.summon_max_total = [];
  var_0.summon_max_total["1"] = 10;
  var_0.summon_max_total["2"] = 13;
  var_0.summon_max_total["3"] = 15;
  var_0.summon_max_total["4"] = 17;
  var_0.summon_min_radius = 100;
  var_0.summon_max_radius = 450;
  var_0.summon_min_dist_from_player = 200;
  var_0.summon_min_zombies_before_active = 12;
  var_0.skeleton_health = 8500;
  var_0.automatic_spawn_time = 3000;
  var_0.automatic_spawn_cap = 2;
  var_0.min_idle_time = 500;
  var_0.max_idle_time = 3000;
  var_0.min_move_nodes = 2;
  var_0.max_move_nodes = 5;
  var_0.look_ahead_speed = 20;
  var_0.look_ahead_radius = 200;
  var_0.strafe_move_nodes = 4;
  var_0.ground_vul_time = 8000;
  var_0.ground_pound_radius = 300;
  var_0.ground_pound_min_damage = 95;
  var_0.ground_pound_max_damage = 300;
  var_0.zombies_per_person = 0;
  var_0.zombies_summon_radius = 200;
  var_0.drop_down_time = 1000;
  var_0.fly_over_nodes_travelled = 7;
  var_0.persistent_fire_damage = 50;
  var_0.persistent_fire_rate = 0.1;
  var_0.fly_over_speed = 1.5;
  var_0.ss_groundpound_radius = 500;
  var_0.ss_groundpound_min_damage = 95;
  var_0.ss_groundpound_max_damage = 500;
  var_0.air_pound_rise_fx = level._effect["vfx_demon_spawn"];
  var_0.air_pound_pound_fx = level._effect["demon_pound_slam_lrg"];
  var_0.air_pound_pound_sfx = "rocket_explode_energy";
  var_0.air_pound_pound_rumble_scale = 0.45;
  var_0.air_pound_pound_rumble_duration = 3;
  var_0.air_pound_pound_rumble_radius = 750;
  var_0.air_pound_rise_rumble_scale = 0.35;
  var_0.air_pound_rise_rumble_duration = 3;
  var_0.air_pound_rise_rumble_radius = 750;
  var_0.black_hole_duration = 5000;
  var_0.armageddon_duration = 15000;
  var_0.safe_zone_radius = 300;
  var_0.meteor_min_period = 0.1;
  var_0.meteor_max_period = 0.5;
  var_0.meteor_period_stage_decay = 0.85;
  var_0.meteor_target_radius = 1000;
  var_0.eclipse_duration = 180000;
}

setupfighttunedata(var_0) {
  var_0.max_soul_health = 4;
  var_0.section_complete_notify = "SECTION_COMPLETE_NOTIFY";
  var_0.weak_spot_model = "zmb_superslasher_weak_spot";
  var_0.weak_spot_health = 12500;
  var_0.min_health_percent = 0.15;
  var_0.var_3CCC = 30000;
  var_0.charge_rate = 1 / var_0.var_3CCC;
  var_0.decharge_time = 10000;
  var_0.decharge_rate = 1 / var_0.decharge_time;
  var_0.buffer_time_solo = 6000;
  var_0.buffer_time_coop = 4000;
  var_0.active_time = 180000;
  var_0.stolen_ghost_model = "zombie_ghost_cube_blue";
  var_0.zombie_ghost_model = "dlc4_boss_soul";
  var_0.fake_ghost_model = "fake_dlc4_boss_soul";
  var_0.num_souls_released = 6;
  var_0.soul_max_distance_from_arena = 5000;
  var_0.soul_explosion_radius = 70;
  var_0.boss_mid_height = 150;
  var_0.boss_mid_offset = 0;
  var_0.soul_mid_height = 12;
  var_0.soul_health_depleted_notify = "SOUL_HEALTH_DEPLETED";
  var_0.soul_respawn_time = 2000;
  var_0.soul_lifetime = 2000;
  var_0.entangler_weapon_name = "iw7_entangler_zm";
  var_0.entangler_stop_notify = "stop_using_entangler";
  var_0.entangler_hit_same_target_notify = "entangler_hit_same_target";
  var_0.entangler_track_update_frequency = 0.2;
  var_0.entangler_recharge_rate = 0.5;
  var_0.entangler_track_time = 0.5;
}

setupfightweighttunedata(var_0) {
  var_0.move_base_weight = 3;
  var_0.move_stage_multiplier = -0.15;
  var_0.idle_base_weight = 1;
  var_0.idle_stage_multiplier = 0;
  var_0.drop_move_base_weight = 0.5;
  var_0.drop_move_stage_multiplier = 0;
  var_0.fireball_base_weight = 1.8;
  var_0.fireball_stage_multiplier = 0.15;
  var_0.move_fireball_base_weight = 1.8;
  var_0.move_fireball_stage_multiplier = 0.15;
  var_0.black_hole_base_weight = 0.5;
  var_0.black_hole_stage_multiplier = 0.2;
  var_0.black_hole_charge_multiplier = 0.5;
  var_0.fly_over_base_weight = 0.6;
  var_0.fly_over_stage_multiplier = 0.2;
  var_0.summon_base_weight = 50;
  var_0.summon_stage_multiplier = 0;
  var_0.special_base_weight = 2.2;
  var_0.special_stage_multiplier = 0.1;
}

setupspecialwavetunedata(var_0) {
  var_0.base_spawn_interval = 2;
  var_0.spawn_interval_decay = 0.9;
  var_0.specialwavesdata = [];
  var_0.specialwavesdata["BASIC_1"] = 15;
  var_0.specialwavesdata["PHANTOM_1"] = 4;
  var_0.specialwavesdata["SPECIAL_1"] = ["zombie_clown", "zombie_clown", "zombie_clown", "zombie_clown", "zombie_clown", "zombie_clown"];
  var_0.specialwavesdata["BASIC_2"] = 18;
  var_0.specialwavesdata["PHANTOM_2"] = 6;
  var_0.specialwavesdata["SPECIAL_2"] = ["slasher"];
  var_0.specialwavesdata["BASIC_3"] = 21;
  var_0.specialwavesdata["PHANTOM_3"] = 7;
  var_0.specialwavesdata["SPECIAL_3"] = ["karatemaster", "karatemaster", "karatemaster", "karatemaster"];
  var_0.specialwavesdata["BASIC_4"] = 24;
  var_0.specialwavesdata["PHANTOM_4"] = 8;
  var_0.specialwavesdata["SPECIAL_4"] = ["alien_rhino", "alien_rhino"];
}

setupfrenziedtunedata(var_0) {
  var_0.frenzied_health = 250000;
  var_0.last_stand_health = 20000;
  var_0.frenzied_damage_cap = 1500;
  var_0.frenzied_damage_cap_wave_increase = 1500;
  var_0.frenzied_damage_cap_time = 0.5;
  var_0.last_stand_time = 15000;
  var_0.last_stand_victory_min_time = 8000;
  var_0.frenzied_blink_chance = 0.05;
  var_0.frenzied_move_weight = 0;
  var_0.frenzied_idle_weight = 0;
  var_0.frenzied_drop_move_weight = 0;
  var_0.frenzied_fireball_weight = 1.5;
  var_0.frenzied_move_fireball_weight = 2.5;
  var_0.frenzied_black_hole_weight = 0.5;
  var_0.frenzied_fly_over_weight = 0.7;
  var_0.frenzied_summon_weight = 0;
  var_0.frenzied_special_weight = 1.1;
  var_0.frenzied_summon_min_interval = 0.5;
  var_0.frenzied_summon_max_interval = 1;
  var_0.frenzied_summon_wave_period = -20536;
  var_0.frenzied_summon_number = 8;
  var_0.frenzied_summon_increase_per_wave = 2;
  var_0.frenzied_summon_start_wave = 4;
  var_0.frenzied_summon_agents = ["skeleton", "alien_goon", "alien_phantom", "zombie_clown", "karatemaster", "slasher", "alien_rhino"];
  var_0.frenzied_summon_data = [];
  var_0.frenzied_summon_data["skeleton"] = [10, 2];
  var_0.frenzied_summon_data["alien_goon"] = [10, 2];
  var_0.frenzied_summon_data["zombie_clown"] = [6, 4];
  var_0.frenzied_summon_data["alien_phantom"] = [6, 7];
  var_0.frenzied_summon_data["karatemaster"] = [5, 10];
  var_0.frenzied_summon_data["alien_rhino"] = [5, 35];
  var_0.frenzied_summon_data["slasher"] = [5, 60];
  var_0.frenzied_meteor_min_period = 0.5;
  var_0.frenzied_meteor_max_period = 1;
  var_0.frenzied_meteor_target_radius = 1200;
  var_0.frenzied_meteor_target_min_radius = 800;
}