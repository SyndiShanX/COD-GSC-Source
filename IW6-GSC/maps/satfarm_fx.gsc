/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_fx.gsc
*****************************************************/

main(var_0) {
  level._effect["vfx_big_tank_explosion"] = loadfx("vfx/gameplay/explosions/vehicle/vfx_big_tank_explosion");
  level._effect["vfx_smk_drk_geotrail"] = loadfx("vfx/gameplay/vehicle_destruction/air/vfx_smk_drk_geotrail");
  level._effect["vfx_smk_stream_attach"] = loadfx("vfx/ambient/smoke/vfx_smk_stream_attach");
  level._effect["vfx_sand_blowing_flat_runner_sf"] = loadfx("vfx/ambient/weather/sand/vfx_sand_blowing_flat_runner_sf");
  level._effect["vfx_sunflare_satfarm"] = loadfx("vfx/ambient/atmospheric/vfx_sunflare_satfarm");
  level._effect["vfx_fire_xtralarge_nxglight"] = loadfx("vfx/ambient/fire/vfx_fire_xtralarge_nxglight");
  level._effect["vfx_smolder_large"] = loadfx("vfx/ambient/smoke/vfx_smolder_large");
  level._effect["vfx_fire_grounded_med_nxglight"] = loadfx("vfx/ambient/fire/vfx_fire_grounded_med_nxglight");
  level._effect["antiair_runner_flak_day_mp"] = loadfx("fx/misc/antiair_runner_flak_day_mp");
  level._effect["vfx_smk_black_inside"] = loadfx("vfx/moments/satfarm/vfx_smk_black_inside");
  level._effect["vfx_smk_plume_wreckage"] = loadfx("vfx/ambient/smoke/vfx_smk_plume_wreckage");
  level._effect["smk_plume_black_lrg"] = loadfx("vfx/ambient/smoke/smk_plume_black_lrg");
  level._effect["sand_vista_blow_sat"] = loadfx("vfx/ambient/sand/sand_vista_blow_sat");
  level._effect["sand_blowing_flat_runner"] = loadfx("fx/sand/sand_blowing_flat_runner");
  level._effect["explosion_war_background_runner"] = loadfx("vfx/moments/satfarm/explosion_war_background_runner");
  level._effect["antiair_single_tracer01_cloudy_loop"] = loadfx("vfx/moments/satfarm/antiair_single_tracer01_cloudy_loop");
  level._effect["vfx_perif_smk_war_vista"] = loadfx("vfx/ambient/skybox/vfx_perif_smk_war_vista");
  level._effect["vfx_sand_ambient_blowing"] = loadfx("vfx/ambient/weather/sand/vfx_sand_ambient_blowing");
  level._effect["vfx_aerl_expl_bhind_end"] = loadfx("vfx/gameplay/vehicle_destruction/air/vfx_aerl_expl_bhind_");
  level._effect["tread_sand_satfarm"] = loadfx("fx/treadfx/tread_sand_satfarm");
  level._effect["vfx_sparks_met_dbr"] = loadfx("vfx/ambient/sparks/vfx_sparks_met_dbr");
  level._effect["vfx_lrg_air_exp"] = loadfx("vfx/gameplay/explosions/vehicle/vfx_lrg_air_exp");
  level._effect["vfx_exp_sraam_no_missiles"] = loadfx("vfx/gameplay/explosions/vehicle/vfx_exp_sraam_no_missiles");
  level._effect["vfx_jet_contrail"] = loadfx("vfx/gameplay/smoke_trails/vfx_jet_contrail");
  level._effect["vfx_crash_fire"] = loadfx("vfx/moments/satfarm/vfx_crash_fire");
  level._effect["vfx_med_vehicle_exp"] = loadfx("vfx/gameplay/explosions/vehicle/vfx_med_vehicle_exp");
  level._effect["vfx_sparks_burst"] = loadfx("vfx/ambient/sparks/vfx_sparks_burst");
  level._effect["vfx_smolder_lrg_ng"] = loadfx("vfx/ambient/smoke/vfx_smolder_lrg_ng");
  level._effect["vfx_scrnfx_ht_hze_6sv"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_ht_hze_6sv");
  level._effect["vfx_antiair_tracer_flak_runner"] = loadfx("vfx/moments/homecoming/vfx_antiair_tracer_flak_runner");
  level._effect["vfx_flor_tube_glow"] = loadfx("vfx/ambient/lights/vfx_flor_tube_glow");
  level._effect["tank_blast_brick"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_bark"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_carpet"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_cloth"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_concrete"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_dirt"] = loadfx("fx/explosions/tank_impact_sand");
  level._effect["tank_blast_flesh"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_foliage"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_glass"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_grass"] = loadfx("fx/explosions/tank_impact_sand");
  level._effect["tank_blast_gravel"] = loadfx("fx/explosions/tank_impact_sand");
  level._effect["tank_blast_ice"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_metal"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_metal_grate"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_mud"] = loadfx("fx/explosions/tank_impact_sand");
  level._effect["tank_blast_paper"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_plaster"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_rock"] = loadfx("fx/explosions/tank_impact_sand");
  level._effect["tank_blast_sand"] = loadfx("fx/explosions/tank_impact_sand");
  level._effect["tank_blast_snow"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_water"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_wood"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_asphalt"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_ceramic"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_plastic"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_rubber"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_cushion"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_fruit"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_paintedmetal"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_riotshield"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_slush"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_default"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_none"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_impact");
  level._effect["tank_blast_brick_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_bark_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_carpet_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_cloth_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_concrete_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_dirt_low"] = loadfx("fx/explosions/tank_impact_sand_low");
  level._effect["tank_blast_flesh_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_foliage_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_glass_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_grass_low"] = loadfx("fx/explosions/tank_impact_sand_low");
  level._effect["tank_blast_gravel_low"] = loadfx("fx/explosions/tank_impact_sand_low");
  level._effect["tank_blast_ice_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_metal_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_metal_grate_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_mud_low"] = loadfx("fx/explosions/tank_impact_sand_low");
  level._effect["tank_blast_paper_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_plaster_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_rock_low"] = loadfx("fx/explosions/tank_impact_sand_low");
  level._effect["tank_blast_sand_low"] = loadfx("fx/explosions/tank_impact_sand_low");
  level._effect["tank_blast_snow_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_water_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_wood_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_asphalt_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_ceramic_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_plastic_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_rubber_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_cushion_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_fruit_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_paintedmetal_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_riotshield_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_slush_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_default_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_none_low"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_shell_low");
  level._effect["tank_blast_decal_brick"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_bark"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_carpet"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_cloth"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_concrete"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_dirt"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_flesh"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_foliage"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_glass"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_grass"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_gravel"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_ice"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_metal"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_metal_grate"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_mud"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_paper"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_plaster"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_rock"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_sand"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_snow"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_water"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_wood"] = loadfx("fx/explosions/wood_explosion_1_decal");
  level._effect["tank_blast_decal_asphalt"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_ceramic"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_plastic"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_rubber"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_cushion"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_fruit"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_paintedmetal"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_riotshield"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_slush"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");
  level._effect["tank_blast_decal_default"] = loadfx("fx/explosions/tank_concrete_explosion_decal");
  level._effect["tank_blast_decal_none"] = loadfx("fx/explosions/tank_impact_dirt_hamburg_decal");

  if(!isDefined(var_0)) {
    if(!getdvarint("r_reflectionProbeGenerate")) {
      maps\createfx\satfarm_fx::main();
      maps\createfx\satfarm_sound::main();
    }

    precache_create_fx();
    precache_scripted_fx();
  }

  var_1 = getEntArray("spinning_object", "targetname");

  foreach(var_3 in var_1)
  var_3 thread rotateobject();
}

precache_create_fx() {
  level._effect["falling_debris_small"] = loadfx("fx/misc/falling_debris_small");
}

rotateobject() {
  self endon("death");
  var_0 = 5;

  for(;;) {
    self rotateyaw(-360, var_0);
    wait 5;
  }
}

precache_scripted_fx() {
  level._effect["vehicle_explosion_t90_cheap"] = loadfx("fx/explosions/vehicle_explosion_t90_cheap");
  level._effect["tank_heavy_smoke"] = loadfx("fx/smoke/smoke_trail_black_heli");
  level._effect["grenade_muzzleflash"] = loadfx("fx/muzzleflashes/m203_flshview");
  level._effect["tank_muzzleflash"] = loadfx("fx/muzzleflashes/abrams_flash_wv_no_tracer");
  level._effect["aerial_explosion_mig29"] = loadfx("fx/explosions/aerial_explosion_mig29");
  level._effect["jet_crash_dcemp"] = loadfx("fx/explosions/jet_crash_dcemp");
  level._effect["generic_explosion_large"] = loadfx("fx/explosions/generic_explosion_large");
  level._effect["vehicle_tank_crush"] = loadfx("fx/explosions/vehicle_tank_crush");
  level._effect["vehicle_explosion_medium"] = loadfx("fx/explosions/vehicle_explosion_medium");
  level._effect["sat_dish_sand_impact"] = loadfx("fx/maps/satfarm/sat_dish_sand_impact");
  level._effect["signal_smoke_green"] = loadfx("fx/smoke/signal_smoke_green_grey");
  level._effect["fire_smoke_trail_L"] = loadfx("fx/fire/fire_smoke_trail_L");
  level._effect["vfx_smk_black_player"] = loadfx("vfx/moments/satfarm/vfx_smk_black_player");
  level._effect["vfx_fire_car_med"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_car_cheap");
  level._effect["friendly_tank_chevron"] = loadfx("fx/maps/satfarm/tag_friendly_chevron");
  level._effect["sabot_explode"] = loadfx("vfx/gameplay/explosions/vfx_explosion_missile_strike");
  level._effect["vfx_cloud_embers"] = loadfx("vfx/ambient/atmospheric/vfx_cloud_embers");
  level._effect["vfx_smk_lrg_chimney"] = loadfx("vfx/ambient/smoke/vfx_smk_lrg_chimney");
  level._effect["vfx_exp_phos_runner"] = loadfx("vfx/moments/satfarm/vfx_exp_phos_runner");
  level._effect["vfx_light_blinking_red"] = loadfx("vfx/ambient/lights/vfx_light_blinking_red");
  level._effect["mortar"] = loadfx("vfx/gameplay/impacts/vfx_mortar_impact");
  level._effect["mg_turret_explode"] = loadfx("fx/explosions/grenadeexp_default");
  level._effect["spark"] = loadfx("fx/misc/spark_fountain");
  level._effect["smokescreen"] = loadfx("fx/smoke/factory_ambush_smoke_grenade");
  level._effect["smoke_start"] = loadfx("fx/muzzleflashes/tiger_flash");
  level._effect["smoke_screen"] = loadfx("fx/smoke/hamburg_cover_smoke_runner");
  level._effect["smoke_screen_flash"] = loadfx("fx/smoke/smoke_screen_flash");
  level._effect["rpg_trail"] = loadfx("fx/smoke/smoke_geotrail_rpg_saf");
  level._effect["hamburg_tank_red_light"] = loadfx("fx/misc/hamburg_tank_red_light");
  level._effect["fire_extinguisher_explosion"] = loadfx("vfx/props/vfx_extinguisher_exp_satfarm");
  level._effect["vfx_door_breach"] = loadfx("vfx/moments/satfarm/vfx_door_breach");
  level._effect["paper_blowing_stack_flat_cluster"] = loadfx("fx/misc/paper_blowing_stack_flat_cluster");
  level._effect["vfx_holo_flash"] = loadfx("vfx/moments/satfarm/vfx_holo_flash");
  level._effect["vfx_holo_table"] = loadfx("vfx/moments/satfarm/vfx_holo_table");
  level._effect["electrical_sparks_plasma_runner"] = loadfx("vfx/ambient/sparks/electrical_sparks_plasma_runner");
  level._effect["vfx_electrical_dripping_plasma"] = loadfx("vfx/ambient/sparks/vfx_electrical_dripping_plasma");
  level._effect["electrical_sparks_blue_runner"] = loadfx("vfx/ambient/sparks/electrical_sparks_blue_runner");
  level._effect["electrical_sparks_runner"] = loadfx("vfx/ambient/sparks/electrical_sparks_runner");
  level._effect["god_rays"] = loadfx("vfx/moments/satfarm/god_rays");
  level._effect["vfx_electrical_spark_drip"] = loadfx("vfx/ambient/sparks/vfx_electrical_spark_drip");
  level._effect["hanging_dust_indoor_hallway"] = loadfx("vfx/ambient/dust/hanging_dust_indoor_hallway");
  level._effect["vfx_lens_flare_satfarm"] = loadfx("vfx/ambient/lights/vfx_lens_flare_satfarm");
  level._effect["cnd_godray_thin"] = loadfx("vfx/moments/cornered/cnd_godray_thin");
  level._effect["launchtube_steam"] = loadfx("vfx/moments/satfarm/satfarm_launchsmoke");
  level._effect["smoke_geotrail_missile_large"] = loadfx("vfx/moments/satfarm/smoke_geotrail_missile_satfarm");
  level._effect["vfx_light_blink_red"] = loadfx("vfx/gameplay/lights/vfx_light_blink_red");
  level._effect["launch_motes_fast"] = loadfx("vfx/moments/satfarm/launch_motes_fast");
  level._effect["light_damage_runner"] = loadfx("fx/misc/light_damage_runner");
  level._effect["light_blowout_swinging_runner"] = loadfx("fx/misc/light_blowout_swinging_runner");
  level._effect["electrical_sparks"] = loadfx("fx/explosions/electrical_transformer_spark_runner_lon");
  level._effect["ceiling_dust"] = loadfx("vfx/ambient/dust/vfx_fall_dust_once");
  level._effect["fire_sprinkler"] = loadfx("fx/water/fire_sprinkler_saf");
  level._effect["light_fluorescent_blowout_runner"] = loadfx("fx/misc/light_fluorescent_blowout_runner");
  level._effect["f15_missile"] = loadfx("fx/smoke/smoke_geotrail_sidewinder");
  level._effect["large_metal_painted_hull_exit"] = loadfx("fx/impacts/large_metal_painted_hull_exit");
  level._effect["vfx_c17_vol_spot"] = loadfx("vfx/moments/satfarm/vfx_c17_vol_spot");
  level._effect["c17_blowing_motes"] = loadfx("vfx/moments/satfarm/c17_blowing_motes");
  level._effect["c17_light_lens"] = loadfx("vfx/moments/satfarm/c17_light_lens");
  level._effect["c17_window_rays"] = loadfx("vfx/moments/satfarm/c17_window_rays");
  level._effect["vfx_fire_car_intro"] = loadfx("vfx/moments/satfarm/vfx_fire_car_intro");
  level._effect["c17_light_spot_lens"] = loadfx("vfx/moments/satfarm/c17_light_spot_lens");
  level._effect["c17_blowing_motes_fast"] = loadfx("vfx/moments/satfarm/c17_blowing_motes_fast");
  level._effect["vfx_steam_jet_med_loop"] = loadfx("vfx/ambient/steam/vfx_steam_jet_med_loop");
  level._effect["vfx_smk_black_outside"] = loadfx("vfx/moments/satfarm/vfx_smk_black_outside");
  level._effect["vfx_smoke_jetfire_geotrail"] = loadfx("vfx/gameplay/vehicle_destruction/vfx_smoke_jetfire_geotrail");
  level._effect["vfx_exp_solar_panel"] = loadfx("vfx/moments/satfarm/vfx_exp_solar_panel");
  level._effect["vfx_tank_landing_dust"] = loadfx("vfx/moments/satfarm/vfx_tank_landing_dust");
  level._effect["c17_light_door_vol"] = loadfx("vfx/moments/satfarm/c17_light_door_vol");
  level._effect["vfx_smk_jetfumes_geotrail"] = loadfx("vfx/gameplay/vehicles/vfx_smk_jetfumes_geotrail");
  level._effect["vfx_c17_dust_vortex"] = loadfx("vfx/moments/satfarm/vfx_c17_dust_vortex");
  level._effect["vfx_exp_sml_structure"] = loadfx("vfx/gameplay/explosions/vfx_exp_sml_structure");
  level._effect["vfx_bodyfall_dust"] = loadfx("vfx/gameplay/impacts/vfx_bodyfall_dust");
  level._effect["vfx_red_blinking_light_sm"] = loadfx("vfx/ambient/lights/vfx_red_blinking_light_sm");
  level._effect["vfx_light_int_tank"] = loadfx("vfx/moments/satfarm/vfx_light_int_tank");
  level._effect["vfx_satdish_exp"] = loadfx("vfx/moments/satfarm/vfx_satdish_exp");
  level._effect["t90_death_fire_smoke"] = loadfx("fx/fire/t90_death_fire_smoke");
  level._effect["vfx_exp_wall_fracture"] = loadfx("vfx/moments/satfarm/vfx_exp_wall_fracture");
  level._effect["vfx_explosion_crash_satf"] = loadfx("vfx/moments/satfarm/vfx_explosion_crash_satf");
  level._effect["vfx_exp_wall_destroy"] = loadfx("vfx/moments/satfarm/vfx_exp_wall_destroy");
  level._effect["vfx_fence_impact_dust"] = loadfx("vfx/moments/satfarm/vfx_fence_impact_dust");
  level._effect["vfx_satdish_impact_dust"] = loadfx("vfx/moments/satfarm/vfx_satdish_impact_dust");
  level._effect["vfx_missile_smoke_geotrail"] = loadfx("vfx/moments/satfarm/vfx_missile_smoke_geotrail");
  level._effect["m880_missile_trail_01"] = loadfx("vfx/moments/flood/flood_m880_missile_trail_01");
  level._effect["m880_afterburn_ignite"] = loadfx("vfx/moments/flood/flood_m880_afterburn_ignite");
  level._effect["m880_missile_begin"] = loadfx("vfx/moments/flood/flood_m880_missile_begin");
  level._effect["vfx_big_880_explosion"] = loadfx("vfx/gameplay/explosions/vehicle/vfx_big_880_explosion");
  level._effect["aerial_explosion_hind_chernobyl"] = loadfx("fx/explosions/aerial_explosion_hind_chernobyl");
}

create_view_particle_source() {
  level.view_particle_source = common_scripts\utility::spawn_tag_origin();
  level.view_particle_source.origin = level.player.origin;
  level.view_particle_source linktoplayerview(level.player, "tag_eye", (0, 0, 0), (0, 0, 0), 1);
}