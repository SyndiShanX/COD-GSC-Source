/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\killhouse_fx.gsc
********************************/

main() {
  level._effect["neon_lightbeam_killhouse_hall"] = loadfx("vfx\lights\neon_lightbeam_killhouse_hall");
  level._effect["light_rays_moving_openeddoor_fng"] = loadfx("vfx\lights\light_rays_moving_openeddoor_fng");
  level._effect["light_rays_moving_long_near_fng"] = loadfx("vfx\lights\light_rays_moving_long_near_fng");
  level._effect["light_rays_moving_window_fng"] = loadfx("vfx\lights\light_rays_moving_window_fng");
  level._effect["light_rays_moving_long_fng"] = loadfx("vfx\lights\light_rays_moving_long_fng");
  level._effect["footstep_mud_small_killhouse"] = loadfx("vfx\treadfx\footstep_mud_small_killhouse");
  level._effect["footstep_mud_killhouse"] = loadfx("vfx\treadfx\footstep_mud_killhouse");
  level._effect["water_car_explo_splash_lrg"] = loadfx("vfx\water\water_car_explo_splash_lrg");
  level._effect["dust_lights_killhouse"] = loadfx("vfx\lights\dust_lights_killhouse");
  level._effect["neon_lightbeam_killhouse"] = loadfx("vfx\lights\neon_lightbeam_killhouse");
  level._effect["welding_runner"] = loadfx("vfx\unique\welding_runner");
  level._effect["00_particle_shadow_sm_e"] = loadfx("vfx\cloud\00_particle_shadow_sm_e_fng");
  level._effect["00_particle_shadow_med_e"] = loadfx("vfx\cloud\00_particle_shadow_med_e_fng");
  level._effect["00_particle_shadow_lrg_e"] = loadfx("vfx\cloud\00_particle_shadow_lrg_e_fng");
  level._effect["insect_trail_runner"] = loadfx("fx\misc\insect_trail_runner");
  level._effect["moth_runner"] = loadfx("fx\misc\moth_runner");
  level._effect["moth_runner_fng"] = loadfx("fx\misc\moth_runner_fng");
  level._effect["insects_carcass_runner"] = loadfx("fx\misc\insects_carcass_runner");
  level._effect["pine_ndls_fng"] = loadfx("fx\misc\pine_ndls_fng");
  level._effect["leaves_fall_gentlewind_fng"] = loadfx("fx\misc\leaves_fall_gentlewind_fng");
  level._effect["leaves_runner_fng"] = loadfx("fx\misc\leaves_runner_fng");
  level._effect["watter_drips_fng"] = loadfx("fx\misc\watter_drips_fng");
  level._effect["light_rays_moving_door_fng"] = loadfx("vfx\lights\light_rays_moving_door_fng");
  level._effect["fx_sunflare_killhouse_bloom"] = loadfx("vfx\lensflare\fx_sunflare_killhouse_bloom");
  level._effect["jet_contrail_fng"] = loadfx("fx\smoke\jet_contrail_fng");
  level._effect["dust_particles_sml_fng"] = loadfx("vfx\dust\dust_particles_sml_fng");
  level._effect["dust_puff_radial_dummy_down_fng"] = loadfx("vfx\dust\dust_puff_radial_dummy_down_fng");
  level._effect["dust_poof_radial_dummy_fng"] = loadfx("vfx\dust\dust_poof_radial_dummy_fng");
  level._effect["dust_particles_sml_fng_shooting_range"] = loadfx("vfx\dust\dust_particles_sml_fng_shooting_range");
  level._effect["fog_river_200"] = loadfx("fx\weather\fog_river_200_fng");
  level._effect["fog_asphalt_200_fng"] = loadfx("fx\weather\fog_asphalt_200_fng");
  level._effect["fx_sunflare_killhouse"] = loadfx("vfx\lensflare\fx_sunflare_killhouse");
  level._effect["watermelon"] = loadfx("fx\props\watermelon");
  level._effect["light_spotlight_cone_haze_dim_fng"] = loadfx("vfx\lights\light_spotlight_cone_haze_dim_fng");
  level._effect["light_spotlight_cone_haze_dim_fng_override"] = loadfx("vfx\lights\light_spotlight_cone_haze_dim_fng_override");
  level._effect["light_spotlight_cone_haze_dim_fng_override_2"] = loadfx("vfx\lights\light_spotlight_cone_haze_dim_fng_override_2");
  level._effect["light_spotlight_cone_haze_dim_fng_override_3"] = loadfx("vfx\lights\light_spotlight_cone_haze_dim_fng_override_3");
  level._effect["light_rays_moving_fng"] = loadfx("vfx\lights\light_rays_moving_fng");
  level._effect["light_spotlight_cone_haze_long_fng"] = loadfx("vfx\lights\light_spotlight_cone_haze_long_fng");
  level._effect["fx_flare_green_light_fng"] = loadfx("vfx\lensflare\fx_flare_green_light_fng");
  level._effect["light_rays_dim_moving_fng"] = loadfx("vfx\lights\light_rays_dim_moving_fng");
  level._effect["light_spotlight_cone_haze_long_yellow_fng"] = loadfx("vfx\lights\light_spotlight_cone_haze_long_yellow_fng");
  level._effect["lensflare_floodlight_on_killhouse"] = loadfx("vfx\lights\lensflare_floodlight_on_killhouse");
  level._effect["fog_hangar_fng"] = loadfx("vfx\fog\fog_hangar_fng");
  level._effect["fog_oriented_edge_fade_fng"] = loadfx("vfx\fog\fog_oriented_edge_fade_fng");
  level._effect["battlefield_smoke_m_slow_fng"] = loadfx("vfx\smoke\dlc\battlefield_smoke_m_slow_fng");
  level._effect["village_morning_fog_fng"] = loadfx("fx\smoke\village_morning_fog_fng");
  level._effect["tread_road_killhouse"] = loadfx("vfx\treadfx\tread_road_killhouse");
  level._effect["heli_dust_default_killhouse"] = loadfx("fx\treadfx\heli_dust_default_killhouse");
  level._effect["heli_dust_asphalt_killhouse"] = loadfx("fx\treadfx\heli_dust_asphalt_killhouse");
  animscripts\utility::setfootstepeffect("asphalt", loadfx("fx\impacts\footstep_water"));
  animscripts\utility::setfootstepeffect("brick", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("carpet", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("cloth", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("concrete", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("dirt", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("foliage", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("grass", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("metal", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("mud", loadfx("fx\impacts\footstep_mud_dark"));
  animscripts\utility::setfootstepeffect("rock", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("sand", loadfx("fx\impacts\footstep_dust"));
  animscripts\utility::setfootstepeffect("water", loadfx("fx\impacts\footstep_water"));
  animscripts\utility::setfootstepeffect("wood", loadfx("fx\impacts\footstep_dust"));
  level.c4_explosion_fx_override = loadfx("fx\explosions\grenadeExp_metal_killhouse");
  treadfx_override();
  maps\createfx\killhouse_fx::main();
  maps\createfx\killhouse_sound::main();
  thread override_footsteps_mud_fx();
}

treadfx_override() {
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "asphalt", "fx\treadfx\heli_dust_asphalt_fng");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "concrete", "fx\treadfx\heli_dust_asphalt_fng");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "metal", "fx\treadfx\tread_empty_default");
  maps\_treadfx::setvehiclefx("script_vehicle_littlebird_armed", "asphalt", "fx\treadfx\heli_dust_asphalt_fng");
  maps\_treadfx::setvehiclefx("script_vehicle_littlebird_armed", "concrete", "fx\treadfx\heli_dust_asphalt_fng");
  maps\_treadfx::setvehiclefx("script_vehicle_littlebird_armed", "metal", "fx\treadfx\tread_empty_default");
  maps\_treadfx::setallvehiclefx("script_vehicle_ch46e", "fx\treadfx\heli_dust_default_killhouse");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e", "asphalt", "fx\treadfx\heli_dust_asphalt_killhouse");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e", "metal", "fx\treadfx\tread_empty_default");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e", "wood", "fx\treadfx\tread_empty_default");
  maps\_treadfx::setvehiclefx("script_vehicle_m1a1_abrams", "asphalt", "vfx\treadfx\tread_road_killhouse");
  maps\_treadfx::setvehiclefx("script_vehicle_m1a1_abrams", "concrete", "vfx\treadfx\tread_road_killhouse");
  maps\_treadfx::setvehiclefx("script_vehicle_bm21_mobile_cover", "asphalt", "vfx\treadfx\tread_road_killhouse");
  maps\_treadfx::setvehiclefx("script_vehicle_bm21_mobile_cover", "concrete", "vfx\treadfx\tread_road_killhouse");
}

override_footsteps_mud_fx() {
  wait 0.1;
  animscripts\utility::setfootstepeffect("mud", loadfx("vfx\treadfx\footstep_mud_killhouse"));
  animscripts\utility::setfootstepeffectsmall("mud", loadfx("vfx\treadfx\footstep_mud_small_killhouse"));
}