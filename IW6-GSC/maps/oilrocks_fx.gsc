/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_fx.gsc
*****************************************************/

main() {
  level._effect["vfx_sunflare_carrier"] = loadfx("vfx/ambient/atmospheric/vfx_sunflare_carrier");
  level._effect["vfx_lens_flare_oilrocks_wfall_2_cg"] = loadfx("vfx/ambient/lights/vfx_lens_flare_oilrocks_wfall_2_cg");
  level._effect["vfx_lens_flare_oilrocks_cg"] = loadfx("vfx/ambient/lights/vfx_lens_flare_oilrocks_cg");
  level._effect["vfx_gnat_swarm_or"] = loadfx("vfx/moments/oil_rocks/vfx_gnat_swarm_or");
  level._effect["vfx_heli_leaf_kickup"] = loadfx("vfx/moments/oil_rocks/vfx_heli_leaf_kickup");
  level._effect["vfx_wf_surface_turb_yell_right"] = loadfx("vfx/ambient/water/vfx_wf_surface_turb_yell_right");
  level._effect["vfx_wf_surface_turb_yellow"] = loadfx("vfx/ambient/water/vfx_wf_surface_turb_yellow");
  level._effect["vfx_window_smash"] = loadfx("vfx/moments/oil_rocks/vfx_window_smash");
  level._effect["vfx_waterfall_mist_bright"] = loadfx("vfx/ambient/water/vfx_waterfall_mist_bright");
  level._effect["vfx_building_hole_dust"] = loadfx("vfx/moments/oil_rocks/vfx_building_hole_dust");
  level._effect["vfx_exp_gunboat_fire"] = loadfx("vfx/gameplay/vehicles/gunboat/vfx_exp_gunboat_fire");
  level._effect["vfx_wake_gunboat"] = loadfx("vfx/gameplay/vehicles/gunboat/vfx_wake_gunboat");
  level._effect["vfx_safe_rm_win_smash"] = loadfx("vfx/moments/oil_rocks/vfx_safe_rm_win_smash");
  common_scripts\utility::add_fx("vfx_stream_splashes", "vfx/ambient/water/vfx_stream_splashes");
  common_scripts\utility::add_fx("vfx_falling_dust_runner", "vfx/moments/deer_hunt/vfx_falling_dust_runner");
  common_scripts\utility::add_fx("vfx_falling_dust", "vfx/ambient/dust/vfx_falling_dust");
  common_scripts\utility::add_fx("vfx_fire_refinery_burnoff_small", "vfx/ambient/fire/fuel/vfx_fire_refinery_burnoff_small");
  common_scripts\utility::add_fx("vfx_pipe_drip_thick", "vfx/ambient/water/vfx_pipe_drip_thick");
  common_scripts\utility::add_fx("vfx_hanging_particulates", "vfx/moments/deer_hunt/vfx_hanging_particulates");
  common_scripts\utility::add_fx("vfx_ground_mist_thick_or", "vfx/moments/oil_rocks/vfx_ground_mist_thick_or");
  common_scripts\utility::add_fx("vfx_ground_mist_or", "vfx/moments/oil_rocks/vfx_ground_mist_or");
  common_scripts\utility::add_fx("vfx_waterfall_large_oilrocks", "vfx/moments/oil_rocks/vfx_waterfall_large_oilrocks");
  common_scripts\utility::add_fx("vfx_lens_flare_oilrocks_waterfall_2", "vfx/ambient/lights/vfx_lens_flare_oilrocks_waterfall_2");
  common_scripts\utility::add_fx("vfx_lens_flare_oilrocks_glass_reflected", "vfx/ambient/lights/vfx_lens_flare_oilrocks_glass_reflected");
  common_scripts\utility::add_fx("vfx_waterfall_fallingwater_smooth", "vfx/moments/jungle_ghost/vfx_waterfall_fallingwater_smooth");
  common_scripts\utility::add_fx("vfx_lens_flare_oilrocks", "vfx/ambient/lights/vfx_lens_flare_oilrocks");
  common_scripts\utility::add_fx("vfx_lens_flare_dh", "vfx/ambient/lights/vfx_lens_flare_dh");
  common_scripts\utility::add_fx("cliffside_falling_rocks", "fx/_requests/oilrocks/cliffside_falling_rocks");
  common_scripts\utility::add_fx("vfx_waterfall_mist_bottom_thick", "vfx/ambient/water/vfx_waterfall_mist_bottom_thick");
  common_scripts\utility::add_fx("vfx_waterfall_rainbow_large", "vfx/moments/jungle_ghost/vfx_waterfall_rainbow_large");
  common_scripts\utility::add_fx("vfx_waterfall_rainbow", "vfx/moments/jungle_ghost/vfx_waterfall_rainbow");
  common_scripts\utility::add_fx("FX_apache_ai_hydra_rocket_flash_wv", "fx/_requests/oilrocks/apache_ai_hydra_rocket_flash_wv");
  common_scripts\utility::add_fx("FX_vfx_apache_missile_water_impact", "fx/_requests/oilrocks/vfx_apache_missile_water_impact");
  common_scripts\utility::add_fx("FX_water_splash_large", "fx/water/water_splash_large");
  common_scripts\utility::add_fx("FX_boat_water_explosion", "fx/impacts/105mm_water_impact");
  common_scripts\utility::add_fx("FX_boat_fire_explosion", "fx/explosions/propane_large_exp");
  common_scripts\utility::add_fx("FX_oilrocks_infantry_vehicle_smoke", "fx/_requests/oilrocks/oilrocks_infantry_vehicle_smoke");
  common_scripts\utility::add_fx("FX_oilrocks_infantry_battlefield_smoke", "fx/_requests/oilrocks/oilrocks_infantry_battlefield_smoke");
  common_scripts\utility::add_fx("FX_oilrocks_turret_flash_gaz", "fx/muzzleflashes/minigun_flash");
  common_scripts\utility::add_fx("FX_oilrocks_turret_flash_gunboat", "fx/muzzleflashes/minigun_flash");
  common_scripts\utility::add_fx("FX_oilrocks_turret_flash_zpu", "fx/muzzleflashes/bmp_flash_wv");
  common_scripts\utility::add_fx("FX_oilrocks_garage_car_jump_wall_destroy", "fx/_requests/oilrocks/oilrocks_garage_car_jump_wall_destroy");
  common_scripts\utility::add_fx("residual_dust_hang", "fx/dust/residual_dust_hang");
  common_scripts\utility::add_fx("safe_room_ceiling_dust_fall", "fx/dust/safe_room_ceiling_dust_fall");
  common_scripts\utility::add_fx("safe_room_trail", "fx/dust/safe_room_trail");
  common_scripts\utility::add_fx("metal_scrape_child_a", "fx/fire/metal_scrape_child_a");
  common_scripts\utility::add_fx("safe_scrape_sparks", "fx/impacts/safe_scrape_sparks");
  common_scripts\utility::add_fx("spark_fall_runner_mp_infrequent", "fx/explosions/spark_fall_runner_mp_infrequent");
  common_scripts\utility::add_fx("Safe_room_pull_wall_dust", "fx/dust/Safe_room_pull_wall_dust");
  common_scripts\utility::add_fx("safe_room_paper_fly", "fx/dust/safe_room_paper_fly");
  common_scripts\utility::add_fx("vfx_thick_cloud", "vfx/ambient/weather/clouds/vfx_thick_cloud");
  common_scripts\utility::add_fx("vfx_wispy_cloud", "vfx/ambient/weather/clouds/vfx_wispy_cloud");
  common_scripts\utility::add_fx("vfx_water_fire_field", "vfx/moments/oil_rocks/vfx_water_fire_field");
  common_scripts\utility::add_fx("vfx_water_fire_field_bare", "vfx/moments/oil_rocks/vfx_water_fire_field_bare");
  common_scripts\utility::add_fx("vfx_water_fire_steam", "vfx/moments/oil_rocks/vfx_water_fire_steam");
  common_scripts\utility::add_fx("vfx_fire_burning_fuel_tank", "vfx/ambient/fire/fuel/vfx_fire_burning_fuel_tank");
  common_scripts\utility::add_fx("vfx_fire_refinery_burnoff", "vfx/ambient/fire/fuel/vfx_fire_refinery_burnoff");
  common_scripts\utility::add_fx("vfx_waterfall_section", "vfx/ambient/water/vfx_waterfall_section");
  common_scripts\utility::add_fx("vfx_waterfall_mist", "vfx/ambient/water/vfx_waterfall_mist");
  common_scripts\utility::add_fx("vfx_river_rock_splash", "vfx/ambient/water/vfx_river_rock_splash");
  common_scripts\utility::add_fx("vfx_canyon_godray", "vfx/ambient/lights/vfx_canyon_godray");
  common_scripts\utility::add_fx("vfx_water_embers", "vfx/ambient/fire/vfx_water_embers");
  common_scripts\utility::add_fx("vfx_smk_building_dmg_lg", "vfx/ambient/smoke/vfx_smk_building_dmg_lg");
  common_scripts\utility::add_fx("vfx_river_rock_wake", "vfx/ambient/water/vfx_river_rock_wake");
  common_scripts\utility::add_fx("vfx_canyon_rainbow", "vfx/ambient/lights/vfx_canyon_rainbow");
  common_scripts\utility::add_fx("vfx_canyon_birds", "vfx/ambient/animals/vfx_canyon_birds");
  common_scripts\utility::add_fx("vfx_waterfall_splash", "vfx/ambient/water/vfx_waterfall_splash");
  common_scripts\utility::add_fx("vfx_waterf_sec_top_fade", "vfx/ambient/water/vfx_waterf_sec_top_fade");
  common_scripts\utility::add_fx("vfx_waterfall_mist_bottom", "vfx/ambient/water/vfx_waterfall_mist_bottom");
  common_scripts\utility::add_fx("vfx_gnat_swarm", "vfx/ambient/animals/vfx_gnat_swarm");
  common_scripts\utility::add_fx("vfx_pipe_drip", "vfx/ambient/water/vfx_pipe_drip");
  common_scripts\utility::add_fx("vfx_jungle_pollen", "vfx/ambient/atmospheric/vfx_jungle_pollen");
  common_scripts\utility::add_fx("vfx_dock_mist", "vfx/ambient/atmospheric/vfx_dock_mist");
  common_scripts\utility::add_fx("vfx_trash_debris_kickup_runner", "vfx/ambient/dust/vfx_trash_debris_kickup_runner");
  common_scripts\utility::add_fx("vfx_steam_vent", "vfx/ambient/steam/vfx_steam_vent");
  common_scripts\utility::add_fx("vfx_warm_light_nodlight", "vfx/ambient/lights/vfx_warm_light_nodlight");
  common_scripts\utility::add_fx("vfx_brown_moth_bulb", "vfx/ambient/animals/vfx_brown_moth_bulb");
  common_scripts\utility::add_fx("vfx_wf_ledge_mist", "vfx/ambient/water/vfx_wf_ledge_mist");
  common_scripts\utility::add_fx("vfx_wf_surface_turb", "vfx/ambient/water/vfx_wf_surface_turb");
  common_scripts\utility::add_fx("cliffside_rockslide", "fx/_requests/oilrocks/cliffside_rockslide");
  common_scripts\utility::add_fx("hellfire_cliffside_impact", "fx/_requests/oilrocks/hellfire_cliffside_impact");

  if(!getdvarint("r_reflectionProbeGenerate")) {
    maps\createfx\oilrocks_fx::main();
  }

  maps\createfx\oilrocks_sound::main();
}