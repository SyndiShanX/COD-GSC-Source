/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mak_fx.gsc
**************************************/

#include maps\_utility;

main() {
  precacheFX();
  spawnFX();
  maps\createart\mak_art::main();
  footsteps();

  event1();
  event2();
  event4();
  event6();

  wind_settings();
  level thread water_settings();
  view_settings();
}

footsteps() {
  animscripts\utility::setFootstepEffect("asphalt", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("brick", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("carpet", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("cloth", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("concrete", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("dirt", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("foliage", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("gravel", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("grass", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("ice", LoadFx("bio/player/fx_footstep_snow"));
  animscripts\utility::setFootstepEffect("metal", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("mud", LoadFx("bio/player/fx_footstep_mud"));
  animscripts\utility::setFootstepEffect("paper", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("plaster", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("rock", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("sand", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("snow", LoadFx("bio/player/fx_footstep_snow"));
  animscripts\utility::setFootstepEffect("water", LoadFx("bio/player/fx_footstep_water"));
  animscripts\utility::setFootstepEffect("wood", LoadFx("bio/player/fx_footstep_dust"));
}

view_settings() {
  SetSavedDvar("r_motionblur_enable", 1);
  SetSavedDvar("r_motionblur_positionFactor", 0.17);
  SetSavedDvar("r_motionblur_directionFactor", 0.17);
}
wind_settings() {
  SetSavedDvar("wind_global_vector", "162 59 7.5");
  SetSavedDvar("wind_global_low_altitude", 19);
  SetSavedDvar("wind_global_hi_altitude", 561);
  SetSavedDvar("wind_global_low_strength_percent", 0.07);
}

water_settings() {
  setDvar("r_watersim_curlAmount", 1);
  setDvar("r_watersim_curlMax", 1);
  setDvar("r_watersim_curlReduce", 0.95);
  setDvar("r_watersim_minShoreHeight", -3.2);
  setDvar("r_watersim_waveSeedDelay", 250.0);
  setDvar("r_watersim_foamAppear", 20);
  setDvar("r_watersim_foamDisappear", 0.775);
  setDvar("r_watersim_windAmount", 0.4);
  setDvar("r_watersim_windMax", 0.21);
  setDvar("r_watersim_windDir", 340.0);
  waittillframeend;
  WaterSimEnable(true);
}

event1() {
  level._effect["cigarette"] = LoadFx("maps/mak/fx_cigarette_smoke");
  level._effect["cigarette_exhale"] = LoadFx("maps/mak/fx_cigarette_smoke_exhale_puff");
  level._effect["cigarette_glow"] = LoadFx("maps/mak/fx_cigarette_glow");
  level._effect["cigarette_glow_puff"] = LoadFx("maps/mak/fx_cigarette_glow_puff");
  level._effect["cigarette_glow_puff2"] = LoadFx("maps/mak/fx_cigarette_glow_puff2");
  level._effect["cigarette_embers"] = LoadFx("maps/mak/fx_cigarette_embers_puff");
  level._effect["blood_spray"] = LoadFx("maps/mak/fx_blood_spray");
  level._effect["blood_spurt"] = LoadFx("maps/mak/fx_blood_spurt");
  level._effect["blood_pool"] = LoadFx("maps/mak/fx_blood_spill_floor");
  level._effect["flash_light"] = LoadFx("misc/fx_flashlight_beam");
  level._effect["spit"] = LoadFx("maps/mak/fx_spit_mist");
  level._effect["beatstick_hit"] = LoadFx("maps/mak/fx_blood_spray_small");

  level._effect["hut1_explosion"] = LoadFx("maps/mak/fx_explosion_charge_large");
  level._effect["hut2_explosion"] = LoadFx("maps/mak/fx_explosion_charge_med");
  level._effect["hut3_explosion"] = LoadFx("maps/mak/fx_explosion_charge_xlarge");
  level._effect["hut4_explosion"] = LoadFx("maps/mak/fx_explosion_charge_xlarge_main");
  level._effect["hut4_smoke_trail"] = LoadFX("maps/mak/fx_sys_element_smoke_tail_med_emitter");

  level._effect["corner_hut_explosion"] = LoadFX("maps/mak/fx_explosion_charge_med_corner");
  level.scr_sound["corner_hut_explosion"] = "exp_hut_corner";

  level._effect["shed_barrel_explosion"] = LoadFX("maps/mak/fx_explosion_barrel_small");
  level._effect["barrel_explosion"] = LoadFX("destructibles/fx_barrelExp");
  level._effect["barrel_trail"] = LoadFx("destructibles/fx_dest_fire_trail_med");

  add_earthquake("truck_barrels", 0.4, 2, 300);

  level._effect["hut1_collapse"] = LoadFx("maps/mak/fx_fire_ewok_collapse_group");
  level._effect["hut1_splash"] = LoadFx("maps/mak/fx_fire_ewok_splash_plume");
  level._effect["hut1_smoke"] = LoadFx("maps/mak/fx_fire_ewok_smoke");
  level._effect["hut1_fire_large"] = LoadFx("maps/mak/fx_fire_ewok_large");
  level._effect["hut1_fire_medium"] = LoadFx("maps/mak/fx_fire_ewok_medium");
  level._effect["hut1_fire_pole"] = LoadFx("maps/mak/fx_fire_ewok_medium_pole");

  level._effect["under_hut"] = LoadFX("maps/mak/fx_fire_hut_collapse_small");

  level._effect["guy2shed"] = LoadFX("maps/mak/fx_collapse_dust_plume_4");

  level._effect["showdown_splash"] = LoadFx("maps/mak/fx_water_splash_falling_guy");

  level._effect["beatdown_arm_smoke"] = LoadFx("maps/mak/fx_smoke_small");

  level._effect["head_shot"] = LoadFx("impacts/flesh_hit_head_fatal_exit");
  level._effect["head_shot_splat"] = LoadFx("impacts/flesh_hit_splat");
}

event2() {
  level._effect["birds_fly"] = LoadFx("maps/pel2/fx_birds_tree_panic");
  level._effect["spot_light"] = LoadFx("env/light/fx_light_pby_exterior_dspot");
  level._effect["spot_light_death"] = LoadFx("maps/mak/fx_light_searchlight_burst_md");
}

event4() {
  level._effect["truck_fuel_spill"] = LoadFx("maps/mak/fx_fire_fuel_spill");
  level._effect["truck_fuel_spill_fire"] = LoadFx("maps/mak/fx_fire_fuel_ground_emitter");
  level._effect["truck_tower_collision"] = LoadFx("maps/mak/fx_truck_tower_collision");
}

event6() {
  level._effect["tower_impact"] = LoadFx("maps/mak/fx_collapse_dust_plume_3");
  level._effect["end_barrel_explosion"] = LoadFx("destructibles/fx_barrelExp");
  level._effect["end_hut_explosion1"] = LoadFx("maps/mak/fx_explosion_charge_xlarge_2");
  level._effect["end_hut_explosion2"] = LoadFx("maps/mak/fx_explosion_charge_xlarge_2_ending");
  level._effect["large_water_squib"] = LoadFx("impacts/large_waterhit");
  level._effect["small_water_squib"] = LoadFx("impacts/small_waterhit");
  level._effect["head_shot_big"] = LoadFx("impacts/flesh_head_impact03");
  level._effect["rocket_explode"] = LoadFx("weapon/mortar/fx_mortar_exp_dirt_medium");
}
precacheFX() {
  level._effect["flesh_hit"] = LoadFX("impacts/flesh_hit_body_fatal_exit");

  level._effect["character_fire_pain_sm"] = LoadFx("env/fire/fx_fire_player_sm_1sec");
  level._effect["character_fire_death_sm"] = LoadFx("env/fire/fx_fire_player_md");
  level._effect["character_fire_death_torso"] = LoadFx("env/fire/fx_fire_player_torso");

  level._effect["radio_explode"] = LoadFx("env/electrical/fx_elec_short_oneshot");

  level._effect["insects_lantern1"] = LoadFX("bio/insects/fx_insects_lantern_1");
  level._effect["insects_lantern2"] = LoadFX("bio/insects/fx_insects_lantern_2");
  level._effect["campfire_smolder"] = LoadFX("env/fire/fx_fire_campfire_smolder");
  level._effect["campfire_medium"] = LoadFX("maps/mak/fx_fire_camp_med");
  level._effect["chimney_smoke"] = LoadFX("maps/mak/fx_smoke_chimney_med");
  level._effect["chimney_smoke_large"] = LoadFX("env/smoke/fx_smoke_wood_chimney_lrg");
  level._effect["searchlight_1"] = LoadFX("misc/fx_spotlight_large");
  level._effect["bats_circling"] = LoadFX("bio/animals/fx_bats_circling");
  level._effect["bats_swarm"] = LoadFX("bio/animals/fx_bats_circling_swarm");
  level._effect["floor_rays_large"] = LoadFX("maps/mak/fx_ray_linear_large");
  level._effect["floor_rays_medium"] = LoadFX("maps/mak/fx_ray_linear_med");
  level._effect["plume_collapse_dust"] = LoadFX("explosions/fx_dust_cloud_plume_1");
  level._effect["mist_rolling"] = LoadFX("maps/mak/fx_fog_rolling_thin");
  level._effect["mist_rolling2"] = LoadFX("maps/mak/fx_fog_rolling_thin2");
  level._effect["fire_barrel_medium"] = LoadFX("env/fire/fx_fire_barrel_med");
  level._effect["fire_barrel_small"] = LoadFX("env/fire/fx_fire_barrel_small");
  level._effect["glow_outdoor"] = LoadFX("env/light/fx_glow_lampost_white_dim_static");
  level._effect["glow_indoor"] = LoadFX("env/light/fx_light_indoor_white_static");
  level._effect["insects_swarm"] = LoadFX("maps/mak/fx_insects_swarm");
  level._effect["glow_spotlight"] = LoadFX("env/light/fx_glow_spotlight_white_dim_static");
  level._effect["sys_e_smoke_trail"] = LoadFX("maps/mak/fx_sys_element_smoke_tail_small");
  level._effect["fire_debris_small"] = LoadFX("maps/mak/fx_fire_debris_small");
  level._effect["fire_debris_med"] = LoadFX("maps/mak/fx_fire_debris_med");
  level._effect["fire_debris_large"] = LoadFX("maps/mak/fx_fire_debris_large");
  level._effect["fire_debris_large_direct"] = LoadFX("maps/mak/fx_fire_debris_large_directional");
  level._effect["glow_indoor_spot"] = LoadFX("maps/mak/fx_light_glow_lantern_spot");
  level._effect["fire_debris_large_single"] = LoadFX("maps/mak/fx_fire_debris_large_single");
  level._effect["fire_debris_ash_cloud"] = LoadFX("maps/mak/fx_fire_debris_ash_cloud");
  level._effect["fire_embers_patch"] = LoadFX("maps/mak/fx_fire_debris_embers_patch");
  level._effect["fire_embers_patch2"] = LoadFX("maps/mak/fx_fire_debris_embers_patch2");
  level._effect["fire_debris_med_line"] = LoadFX("maps/mak/fx_fire_debris_med_line");
  level._effect["fire_debris_med_line2"] = LoadFX("maps/mak/fx_fire_debris_med_line2");
  level._effect["fire_debris_med_line3"] = LoadFX("maps/mak/fx_fire_debris_med_line3");
  level._effect["fire_water_medium"] = LoadFX("maps/mak/fx_fire_water_med");
  level._effect["fire_water_small"] = LoadFX("maps/mak/fx_fire_water_small");
  level._effect["fire_smoke_column1"] = LoadFX("maps/mak/fx_smoke_column");
  level._effect["fire_smoke_column2"] = LoadFX("maps/mak/fx_smoke_column2");
  level._effect["fire_hut_d_light"] = LoadFX("maps/mak/fx_fire_hut_d_light");
  level._effect["god_ray_moon1"] = LoadFX("maps/mak/fx_ray_linear_large_moon");
  level._effect["god_ray_moon2"] = LoadFX("maps/mak/fx_ray_linear_large_moon2");
  level._effect["god_ray_moon3"] = LoadFX("maps/mak/fx_ray_linear_large_moon3");
  level._effect["god_ray_moon4"] = LoadFX("maps/mak/fx_ray_linear_large_moon4");
  level._effect["god_ray_fire"] = LoadFX("maps/mak/fx_ray_linear_fire_small");
  level._effect["god_ray_fire2"] = LoadFX("maps/mak/fx_ray_linear_fire_medium");
  level._effect["smoke_ambiance_indoor"] = LoadFX("maps/mak/fx_smoke_ambiance_indoor");
  level._effect["water_flow"] = LoadFX("maps/mak/fx_water_wake_flow");
  level._effect["water_splash_rocks"] = LoadFX("maps/mak/fx_water_splash_rocks");
  level._effect["water_wake_mist"] = LoadFX("maps/mak/fx_water_wake_mist");
  level._effect["water_wake_ripples"] = LoadFX("maps/mak/fx_water_ripples_small");
  level._effect["glow_candle"] = LoadFX("env/light/fx_dlight_candle_glow");

  level._effect["lantern_on_global"] = LoadFX("env/light/fx_lights_lantern_on");
}

spawnFX() {
  maps\createfx\mak_fx::main();
}

cig_smoke(officer) {
  wait(1);
  playFXOnTag(level._effect["cigarette"], officer, "tag_efx");
  playFXOnTag(level._effect["cigarette_glow"], officer, "tag_efx");
}