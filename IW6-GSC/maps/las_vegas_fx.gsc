/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas_fx.gsc
*****************************************************/

main() {
  level._effect["vfx_train_track_sparks"] = loadfx("vfx/moments/las_vegas/vfx_train_track_sparks");
  level._effect["vfx_elec_spark_drip_vegas"] = loadfx("vfx/moments/las_vegas/vfx_elec_spark_drip_vegas");
  level._effect["vfx_sunflare_desert"] = loadfx("vfx/ambient/atmospheric/vfx_sunflare_desert");
  level._effect["vfx_spark_drip_runner"] = loadfx("vfx/moments/mp_chasm/vfx_spark_drip_runner");
  level._effect["vfx_desert_sand_flat_runner"] = loadfx("vfx/ambient/weather/sand/vfx_desert_sand_flat_runner");
  level._effect["vfx_desert_sand_flat"] = loadfx("vfx/ambient/weather/sand/vfx_desert_sand_flat");
  level._effect["vfx_desert_sand_flow2"] = loadfx("vfx/ambient/weather/sand/vfx_desert_sand_flow2");
  level._effect["vfx_desert_sand_flow1"] = loadfx("vfx/ambient/weather/sand/vfx_desert_sand_flow1");
  level._effect["vfx_sand_kick_up"] = loadfx("vfx/gameplay/footsteps/vfx_sand_kick_up");
  precachefx();

  if(!getdvarint("r_reflectionProbeGenerate")) {
    maps\createfx\las_vegas_sound::main();
    maps\createfx\las_vegas_fx::main();
  }
}

precachefx() {
  level._effect["sand_wind_lg"] = loadfx("fx/dust/dust_wind_canyon");
  level._effect["bar_box_exp"] = loadfx("fx/_requests/las_vegas/restaurant_cardboard_box_exp");
  level._effect["footstep_dust_sandstorm"] = loadfx("fx/impacts/footstep_dust_sandstorm");
  level._effect["footstep_sand_decal"] = loadfx("fx/impacts/footstep_sand_decal");
  level._effect["ceiling_dust"] = loadfx("fx/dust/ceiling_dust_default");
  level._effect["sand_storm_distant"] = loadfx("fx/weather/sand_storm_distant");
  level._effect["sand_storm_light"] = loadfx("fx/weather/sand_storm_light");
  level._effect["sand_blow_flat"] = loadfx("vfx/ambient/weather/sand/vfx_sand_blowing_flat");
  level._effect["sand_blow_flat_runner"] = loadfx("vfx/ambient/weather/sand/vfx_sand_blowing_flat_runner");
  level._effect["sand_dust_falling_runner"] = loadfx("vfx/ambient/weather/sand/vfx_sand_dust_falling_runner");
  level._effect["sand_dust_room_hang"] = loadfx("vfx/ambient/weather/sand/vfx_sand_dust_room_hang");
  level._effect["vfx_las_vegas_street_flow"] = loadfx("vfx/ambient/weather/sand/vfx_las_vegas_street_flow");
  level._effect["vfx_las_vegas_street_flow_fill"] = loadfx("vfx/ambient/weather/sand/vfx_las_vegas_street_flow_fill");
  level._effect["vfx_las_vegas_sand_vortex_runner"] = loadfx("vfx/ambient/weather/sand/vfx_las_vegas_sand_vortex_runner");
  level._effect["vfx_leaf_palm_high_wind"] = loadfx("vfx/ambient/trees/vfx_leaf_palm_high_wind");
  level._effect["vfx_sand_trash_spiral_runner"] = loadfx("vfx/ambient/weather/sand/vfx_sand_trash_spiral_runner");
  level._effect["vfx_sand_streamers_runner"] = loadfx("vfx/ambient/weather/sand/vfx_sand_streamers_runner");
  level._effect["vfx_electrical_spark_drip"] = loadfx("vfx/ambient/sparks/vfx_electrical_spark_drip");
  level._effect["vfx_electrical_spark"] = loadfx("vfx/moments/las_vegas/vfx_elec_spark_drip_vegas");
  level._effect["vfx_debris_fall_train"] = loadfx("vfx/moments/las_vegas/vfx_debris_fall_train");
  level._effect["dust_motes_interior"] = loadfx("vfx/ambient/dust/particulates/dust_motes_interior");
  level._effect["vfx_smk_building_dmg_wind"] = loadfx("vfx/ambient/smoke/vfx_smk_building_dmg_wind");
  level._effect["vfx_adult_flyers"] = loadfx("vfx/ambient/misc/vfx_adult_flyers");
  level._effect["vfx_smk_building_dmg_sm"] = loadfx("vfx/ambient/smoke/vfx_smk_building_dmg_sm");
  level._effect["vfx_wind_motes"] = loadfx("vfx/ambient/dust/particulates/vfx_wind_motes");
  level._effect["vfx_smk_blg_dmg_sm_nofire"] = loadfx("vfx/ambient/smoke/vfx_smk_blg_dmg_sm_nofire");
  level._effect["vfx_pipe_drip"] = loadfx("vfx/ambient/water/vfx_pipe_drip");
  level._effect["vfx_fire_car_large_vegas"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_car_large_vegas");
  level._effect["vfx_fire_car_med_vegas"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_car_med_vegas");
  level._effect["vfx_fire_car_small_vegas"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_car_small_vegas");
  level._effect["vfx_ground_mist_vegas_chandelier_room"] = loadfx("vfx/moments/las_vegas/vfx_ground_mist_vegas_chandelier_room");
  level._effect["vfx_vegas_insects_small_radius"] = loadfx("vfx/moments/las_vegas/vfx_vegas_insects_small_radius");
  level._effect["vfx_particulates_exit_sign_lit"] = loadfx("vfx/moments/las_vegas/vfx_particulates_exit_sign_lit");
  level._effect["vfx_particulates_tv_lit"] = loadfx("vfx/moments/las_vegas/vfx_particulates_tv_lit");
  level._effect["vfx_dust_hang_ceiling"] = loadfx("vfx/moments/las_vegas/vfx_dust_hang_ceiling");
  level._effect["vfx_pipe_drip_chasm"] = loadfx("vfx/moments/mp_chasm/vfx_pipe_drip_chasm");
  level._effect["vfx_vegas_insects"] = loadfx("vfx/moments/las_vegas/vfx_vegas_insects");
  level._effect["vfx_ground_mist_vegas"] = loadfx("vfx/moments/las_vegas/vfx_ground_mist_vegas");
  level._effect["vfx_particulates_hang"] = loadfx("vfx/moments/las_vegas/vfx_particulates_hang");
  level._effect["com_platestack_large_tip1"] = loadfx("vfx/props/com_platestack_large_tip1");
  level._effect["hotel_hallway_sparks"] = loadfx("fx/explosions/sparks_clk");
  level._effect["hotel_hallway_luggage"] = loadfx("fx/_requests/las_vegas/hotel_hallway_luggage");
  level._effect["raidroom_window_glassbreak_fx"] = loadfx("fx/props/highrise_glass_120x110");
  level._effect["raidroom_paper_vortex"] = loadfx("vfx/moments/las_vegas/vfx_luxor_room_paper_vortex");
  level._effect["raidroom_paper_vortex_quick"] = loadfx("vfx/moments/las_vegas/vfx_luxor_rm_vortex_quick");
  level._effect["raidroom_window_flow"] = loadfx("vfx/moments/las_vegas/vfx_luxor_raidroom_window_flow");
  level._effect["raidroom_jump_slide_glass"] = loadfx("vfx/moments/las_vegas/vfx_glass_shard_slide");
  level._effect["raidroom_jump_drop_glass"] = loadfx("vfx/moments/las_vegas/vfx_glass_shard_drop");
  level._effect["slide_boot_dust"] = loadfx("vfx/moments/las_vegas/vfx_luxor_slide_boot_dust");
  level._effect["vfx_dust_hand_clap"] = loadfx("vfx/moments/las_vegas/vfx_dust_hand_clap");
  level._effect["flashlight"] = loadfx("fx/_requests/las_vegas/flashlight_vegas");
  level._effect["flashlight_spotlight"] = loadfx("fx/_requests/las_vegas/flashlight_spotlight");
  level._effect["flashlight_cheap"] = loadfx("fx/_requests/las_vegas/flashlight_cheap_vegas");
  level._effect["flashlight_gamblingroom"] = loadfx("fx/_requests/las_vegas/gamblingroom_spotlight");
  level._effect["flashlight_atrium"] = loadfx("fx/lights/cornered_balcony_spotlight");
  level._effect["foliage_dub_potted_spikey_plant"] = loadfx("fx/props/foliage_dub_potted_spikey_plant");
  level._effect["vfx_sand_stream"] = loadfx("vfx/moments/las_vegas/vfx_sand_stream");
  level._effect["vfx_luxor_glass_smash"] = loadfx("vfx/moments/las_vegas/vfx_luxor_glass_smash");
  level._effect["vfx_luxor_room_fill"] = loadfx("vfx/moments/las_vegas/vfx_luxor_room_fill");
  level._effect["vfx_luxor_room_fill_center"] = loadfx("vfx/moments/las_vegas/vfx_luxor_glass_smash_center");
  level._effect["vfx_luxor_room_fill_outter"] = loadfx("vfx/moments/las_vegas/vfx_luxor_glass_smash_outter");
  level._effect["vfx_thick_falling_stream"] = loadfx("vfx/ambient/weather/sand/vfx_sand_thick_falling_stream");
  level._effect["vfx_sand_ground_spawn_loop"] = loadfx("vfx/moments/las_vegas/vfx_sand_ground_spawn_loop");
  level._effect["vfx_sand_body_impact"] = loadfx("vfx/ambient/weather/sand/vfx_sand_body_impact");
  level._effect["vfx_sand_blowing_edge_detail_sm"] = loadfx("vfx/ambient/weather/sand/vfx_sand_blowing_edge_detail_sm");
  level._effect["vfx_sand_hand"] = loadfx("vfx/moments/las_vegas/vfx_sand_hand");
  level._effect["vfx_sand_forearm"] = loadfx("vfx/moments/las_vegas/vfx_sand_forearm");
  level._effect["vfx_hand_clap"] = loadfx("vfx/moments/las_vegas/vfx_dust_hand_clap");
  level._effect["vfx_train_fall_impact_a"] = loadfx("vfx/moments/las_vegas/vfx_train_fall_impact_a");
  level._effect["vfx_train_fall_track_impact"] = loadfx("vfx/moments/las_vegas/vfx_train_fall_track_impact");
  level._effect["vfx_gnat_swarm"] = loadfx("vfx/ambient/animals/vfx_gnat_swarm");
  level._effect["vfx_blurred_insects"] = loadfx("vfx/ambient/animals/vfx_blurred_insects");
  level._effect["vfx_blurred_insects_bidirectional"] = loadfx("vfx/ambient/animals/vfx_blurred_insects_bidirectional");
  level._effect["vfx_insect_volume"] = loadfx("vfx/ambient/animals/vfx_insect_volume");
  level._effect["hanging_dust_indoor"] = loadfx("vfx/ambient/dust/hanging_dust_indoor");
  level._effect["hanging_dust_indoor_hallway"] = loadfx("vfx/ambient/dust/hanging_dust_indoor_hallway");
  level._effect["smoke_geotrail_rpg"] = loadfx("fx/smoke/smoke_geotrail_rpg");
  level._effect["aas_72x_damage_trail"] = loadfx("vfx/_requests/las_vegas/aas_72x_damage_trail");
  level._effect["aas_72x_damage_explosion"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");
  level._effect["headshot_k"] = loadfx("fx/impacts/flesh_hit_head_fatal_exit_exaggerated");
  level._effect["tunnel_ground_smoke"] = loadfx("vfx/_requests/las_vegas/tunnel_dust_kickup");
  level._effect["gas_grenade_trail"] = loadfx("vfx/_requests/las_vegas/gas_grenade_trail");
  level._effect["gas_grenade"] = loadfx("vfx/_requests/las_vegas/gas_grenade");
  level._effect["close_muzzleflash"] = loadfx("vfx/gameplay/muzzle_flashes/smg/vfx_muz_smg_w_muz_a");
  level._effect["shell_eject"] = loadfx("fx/shellejects/pistol");
  level._effect["sniper_glint"] = loadfx("fx/misc/scope_glint");
  level._effect["sniper_glint_large"] = loadfx("fx/_requests/las_vegas/scope_glint_large");
  level._effect["bullettrail"] = loadfx("fx/_requests/las_vegas/50cal_bullettrail");
  level._effect["blood_impact"] = loadfx("vfx/moments/las_vegas/vfx_blood_impact");
  level._effect["blood_spurt"] = loadfx("vfx/gameplay/impacts/flesh/vfx_flesh_hit_body_fatal_exit");
  level._effect["big_blood_spurt"] = loadfx("vfx/gameplay/impacts/flesh/vfx_flesh_hit_head_fatal_exit");
  level._effect["blood_pool"] = loadfx("vfx/_requests/las_vegas/bloodpool");
  level._effect["headshot_blood"] = loadfx("fx/misc/blood_head_kick");
}

footstepeffects() {
  animscripts\utility::setfootstepeffect("dirt", level._effect["footstep_sand_decal"]);
  animscripts\utility::setfootstepeffect("sand", level._effect["footstep_sand_decal"]);
}

wildlife() {
  thread mask_gamb_room_birds();
  thread exterior_tumbleweed();
}

mask_gamb_room_birds() {
  var_0 = getEntArray("gamb_room_birds_volume", "script_noteworthy");
  maps\_utility::mask_interactives_in_volumes(var_0);
  var_1 = getent("trigger_birds_gamblingroom", "targetname");
  var_1 waittill("trigger");

  foreach(var_3 in var_0) {
    var_3 maps\_utility::activate_interactives_in_volume();
  }
}

exterior_tumbleweed() {
  common_scripts\utility::flag_wait("FLAG_player_slide_complete");
  maps\_utility::delaythread(17, maps\_vehicle::spawn_vehicles_from_targetname_and_drive, "entrance_tumbleweed_getup");
  common_scripts\utility::flag_wait("getup_done");
  maps\_utility::delaythread(1.5, maps\_vehicle::spawn_vehicles_from_targetname_and_drive, "entrance_tumbleweed_convoy");
  maps\_utility::delaythread(15, maps\_vehicle::spawn_vehicles_from_targetname_and_drive, "entrance_tumbleweed_convoy2");
}