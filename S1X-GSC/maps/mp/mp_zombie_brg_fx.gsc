/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_brg_fx.gsc
****************************************/

main() {
  level._effect["mwave_water_splash"] = loadfx("vfx/weaponimpact/mwave_water_splash");
  level._effect["brg_sniper_flare_on"] = loadfx("vfx/lights/brg_sniper_flare_on");
  level._effect["brg_ambulance_trap"] = loadfx("vfx/lights/brg_ambulance_trap");
  level._effect["brg_orbital_laser_target"] = loadfx("vfx/beam/brg_orbital_laser_target");
  level._effect["mist_puddles"] = loadfx("vfx/map/mp_zombie_brg/brg_mist_puddles");
  level._effect["steam_med_slow"] = loadfx("vfx/steam/dlc/steam_med_slow");
  level._effect["fan_steam"] = loadfx("vfx/steam/dlc/fan_steam");
  level._effect["insects_light_moths_complex"] = loadfx("vfx/animal/dlc/insects_light_moths_complex");
  level._effect["trash_tornado_s_runner"] = loadfx("vfx/map/mp_zombie_brg/brg_trash_tornado_s_runner");
  level._effect["steam_pipe_leak_interior_sm"] = loadfx("vfx/steam/dlc/steam_pipe_leak_interior_sm");
  level._effect["spark_burst_runner"] = loadfx("vfx/sparks/dlc/spark_burst_runner_brg");
  level._effect["insects_flies_landing"] = loadfx("vfx/animal/dlc/insects_flies_landing");
  level._effect["ambient_falling_leaves_runner"] = loadfx("vfx/wind/dlc/ambient_falling_leaves_runner");
  level._effect["brg_wind_blowing_debris"] = loadfx("vfx/wind/dlc/brg_wind_blowing_debris");
  level._effect["dust_mote_interior"] = loadfx("vfx/map/mp_zombie_brg/brg_dust_mote_ambient_interior");
  level._effect["fire_carwash"] = loadfx("vfx/map/mp_zombie_brg/fire_carwash");
  level._effect["fire_campfire_small"] = loadfx("vfx/map/mp_zombie_brg/brg_fire_xsmall");
  level._effect["fire_lp_m_blacksmk"] = loadfx("vfx/map/mp_zombie_brg/brg_fire_med");
  level._effect["smoke_pillar_black_large_slow"] = loadfx("vfx/map/mp_zombie_brg/brg_smoke_pillar_large_slow");
  level._effect["smoke_pillar_black_large_slow_lit"] = loadfx("vfx/map/mp_zombie_brg/brg_smoke_pillar_large_slow_lit");
  level._effect["battlefield_smoke_m"] = loadfx("vfx/smoke/dlc/battlefield_smoke_m");
  level._effect["candle_flame"] = loadfx("vfx/map/mp_zombie_brg/brg_candle_flame");
  level._effect["fire_oil_tanker_drips"] = loadfx("vfx/fire/dlc/fire_oil_tanker_drips");
  level._effect["fx_sunflare_burgertown"] = loadfx("vfx/lensflare/fx_sunflare_burgertown");
  level._effect["clouds_sun_overlay"] = loadfx("vfx/map/mp_zombie_brg/brg_ambient_cloud_top");
  level._effect["lensflare_spot_1_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_1");
  level._effect["lensflare_spot_1a_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_1a");
  level._effect["lensflare_spot_2_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_2");
  level._effect["lensflare_spot_2a_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_2a");
  level._effect["lensflare_spot_3_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_3");
  level._effect["lensflare_spot_4_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_4");
  level._effect["lensflare_spot_5_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_5");
  level._effect["lensflare_spot_6_lg"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_6");
  level._effect["lensflare_spot_tower"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_spot_tower");
  level._effect["lensflare_area_1"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_area_1");
  level._effect["lensflare_area_2"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_area_2");
  level._effect["lensflare_flood_1"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_flood_1");
  level._effect["lensflare_stadium"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_stadium");
  level._effect["lensflare_stadium2"] = loadfx("vfx/map/mp_zombie_brg/brg_light_glow_stadium2");
  level._effect["godray_window_sm"] = loadfx("vfx/map/mp_zombie_brg/brg_godray_ambient_sm");
  level._effect["godray_window_sm2"] = loadfx("vfx/map/mp_zombie_brg/brg_godray_ambient_sm2");
  level._effect["godray_window_med"] = loadfx("vfx/map/mp_zombie_brg/brg_godray_ambient_med");
  level._effect["godray_window_large"] = loadfx("vfx/map/mp_zombie_brg/brg_godray_ambient_lg");
  level._effect["godray_window_large_long"] = loadfx("vfx/map/mp_zombie_brg/brg_godray_ambient_lg_long");
  level._effect["sign_grid_scanning"] = loadfx("vfx/map/mp_zombie_brg/brg_sign_grid_scanning");
  level._effect["falling_water_trickle_wide"] = loadfx("vfx/map/mp_zombie_brg/brg_falling_water_trickle_wide");
  level._effect["falling_water_trickle_wide_long"] = loadfx("vfx/map/mp_zombie_brg/brg_falling_water_trickle_wide_long");
  level._effect["water_pipe_gush_up"] = loadfx("vfx/map/mp_zombie_brg/brg_water_pipe_gush_up");
  level._effect["water_pipe_gush_sm"] = loadfx("vfx/map/mp_zombie_brg/brg_water_pipe_gush_sm");
  level._effect["fog_ambient_tunnel"] = loadfx("vfx/map/mp_zombie_brg/brg_fog_ambient_tunnel");
  level._effect["fog_ambient_low_tunnel"] = loadfx("vfx/map/mp_zombie_brg/brg_fog_ambient_tunnel_low");
  level._effect["rats_flock_runaway"] = loadfx("vfx/map/mp_zombie_brg/brg_rat_flock_runaway_runner");
  level._effect["roaches_flock_scatter_straight"] = loadfx("vfx/map/mp_zombie_brg/brg_roach_scatter_straight_runner");
  level._effect["roaches_flock_scatter_radial"] = loadfx("vfx/map/mp_zombie_brg/brg_roach_scatter_radial_runner");
  level._effect["steam_vent_small"] = loadfx("vfx/map/mp_zombie_brg/brg_steam_vent_small");
  level._effect["water_curtain"] = loadfx("vfx/map/mp_zombie_brg/brg_water_curtain");
  level._effect["water_curtain_slide"] = loadfx("vfx/map/mp_zombie_brg/brg_water_curtain_slide");
  level._effect["water_curtain_splash"] = loadfx("vfx/map/mp_zombie_brg/brg_water_curtain_splash");
  level._effect["spawn_water"] = loadfx("vfx/water/zombie_spawn_water");
  level._effect["spawn_dirt"] = loadfx("vfx/dust/zombie_spawn_dust");
  level._effect["spawn_mud"] = loadfx("vfx/water/zombie_spawn_mud");
  level._effect["spawn_concrete"] = loadfx("vfx/rock/zombie_spawn_concrete");
  level._effect["spawn_manhole"] = loadfx("vfx/water/zombie_spawn_water");
  level._effect["spawn_garbage"] = loadfx("vfx/unique/zombie_spawn_garbage");
  level._effect["spawn_water_drip"] = loadfx("vfx/water/dlc/water_dripping_body");
  level._effect["goliath_spawn_water"] = loadfx("vfx/water/goliath_spawn_water");
  level._effect["goliath_spawn_dirt"] = loadfx("vfx/dust/goliath_spawn_dust");
  level._effect["goliath_spawn_concrete"] = loadfx("vfx/rock/goliath_spawn_concrete");
  level._effect["goliath_spawn_mud"] = loadfx("vfx/water/goliath_spawn_mud");
  level._effect["goliath_spawn_metal"] = loadfx("vfx/explosion/frag_grenade_default");
  level._effect["goliath_spawn_trail"] = loadfx("vfx/trail/smoketrail_rpg_paladin");
  level._effect["trap_carwash_fire_active"] = loadfx("vfx/map/mp_zombie_brg/fire_carwash");
  level._effect["trap_carwash_smoke_cooldown"] = loadfx("vfx/smoke/dlc/battlefield_smoke_l_ground");
  level._effect["trap_ambulance_lights_active"] = loadfx("vfx/lights/brg_ambulance_trap");
  level._effect["trap_electric_floor_shock_active"] = loadfx("vfx/map/mp_zombie_brg/electrified_floor");
  level._effect["trap_gator_enter_splash"] = loadfx("vfx/water/brg_gator_spawn_splash");
  level._effect["trap_gator_emerge_splash"] = loadfx("vfx/water/zombie_brg_gator_splash");
  level._effect["trap_gator_blood_splat"] = loadfx("vfx/blood/dlc_zombie_blood_splat_med");
  level._effect["trap_gator_attack_splash"] = loadfx("vfx/water/brg_gator_attack_splash");
  level._effect["trap_sewer_steam_active"] = loadfx("vfx/map/mp_zombie_brg/brg_sewage_trap");
  level._effect["trap_airstrike_laser_target"] = loadfx("vfx/beam/brg_orbital_laser_target");
  level._effect["trap_sniper_tracer"] = loadfx("vfx/muzzleflash/sniper_drone_tracer");
  level._effect["trap_sniper_tracer"] = loadfx("vfx/lights/brg_sniper_flare_on");
  level._effect["sq_burger_glow"] = loadfx("vfx/gameplay/mp/zombie/zombie_host_hand");
  level._effect["dlc_burger_bomb_trail"] = loadfx("vfx/trail/dlc_burger_bomb_trail");
  level._effect["dlc_gator_death"] = loadfx("vfx/blood/dlc_gator_death");
  level._effect["dlc_elec_panel_charging"] = loadfx("vfx/props/dlc_elec_panel_charging");
  level._effect["dlc_elec_panel_charge_full"] = loadfx("vfx/props/dlc_elec_panel_charge_full");
  level._effect["brg_skillet_charbroil"] = loadfx("vfx/fire/dlc/brg_skillet_charbroil");
  level._effect["dlc_zombie_blood_splat_sm"] = loadfx("vfx/blood/dlc_zombie_blood_splat_sm");
  level._effect["brg_skillet_gleam"] = loadfx("vfx/map/mp_zombie_brg/brg_skillet_gleam");
  level._effect["brg_altar_dust"] = loadfx("vfx/dust/dlc/brg_altar_dust");
  level._effect["spark_burst_runner_brg"] = loadfx("vfx/sparks/dlc/spark_burst_runner_brg");
  level._effect["brg_infected_burger"] = loadfx("vfx/map/mp_zombie_brg/brg_infected_burger");
  level._effect["brg_rocket_thruster"] = loadfx("vfx/fire/dlc/brg_rocket_thruster");
  level._effect["dlc_prop_scanner_door_lock_fail"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_fail");
  level._effect["dlc_prop_scanner_door_lock_on"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_on");
  level._effect["dlc_prop_scanner_door_lock_pass"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_pass");
  level._effect["sq_light"] = loadfx("vfx/lights/aircraft_light_wingtip_green");
  level._effect["cannon_firing"] = loadfx("vfx/map/mp_clowntown/ct_cannon_blast");
  level._effect["burger_bomb_fuse"] = loadfx("vfx/map/mp_zombie_brg/burger_bomb_fuse");
  level._effect["ball_trail"] = loadfx("vfx/map/mp_zombie_brg/burger_bomb_trail");
  level._effect["ball_idle"] = loadfx("vfx/map/mp_zombie_brg/burger_bomb_idle");
  level._effect["ball_flash"] = loadfx("vfx/map/mp_zombie_brg/burger_bomb_pulse");
  level._effect["ball_physics_impact"] = loadfx("vfx/map/mp_zombie_brg/burger_bomb_pulse");
  level._effect["mut_emz_attack_no_flash"] = loadfx("vfx/gameplay/mp/zombie/zombie_attack_emz_no_flash");
  thread lowpriorityenvfx();
}

lowpriorityenvfx() {
  for(;;) {
    level waittill("connected", var_0);
    thread lowpriorityenvfxforplayer(var_0);
  }
}

lowpriorityenvfxforplayer(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  maps\mp\zombies\_util::waittillplayersnextsnapshot(var_0);

  if(level.wavecounter >= 20) {
    return;
  }
  level thread common_scripts\_exploder::activate_clientside_exploder(7, var_0);

  for(;;) {
    level waittill("zombie_round_countdown_started");

    if(level.wavecounter >= 20) {
      break;
    }
  }

  level thread common_scripts\_exploder::deactivate_clientside_exploder(7, var_0, 1);
  level notify("stop_audio_exloder_7");
}