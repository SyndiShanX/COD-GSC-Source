/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel1_fx.gsc
**************************************/

#include maps\_utility;

main() {
  maps\createart\pel1_art::main();
  precacheFX();
  spawnFX();

  thread fog_settings();
  thread vision_settings();
  thread wind_settings();
  thread water_settings();
  thread view_settings();
}

view_settings() {
  setsaveddvar("r_motionblur_enable", 1);
  setsaveddvar("r_motionblur_positionFactor", 0.35);
  setsaveddvar("r_motionblur_directionFactor", .2);

  maps\createart\pel1_art::main();
}

vision_settings() {
  wait 1;
  set_all_players_visionset("pel1_intro", 1);

  wait 5;
  level waittill("lst doors opened");
  set_all_players_visionset("pel1", 3);
}

set_outro_vision() {
  set_all_players_visionset("pel1_intro", 1);
}

fog_settings() {
  start_dist = 814;
  halfway_dist = 1763;
  halfway_height = 541;
  base_height = -451;
  red = 0.50;
  green = 0.613;
  blue = 0.657;
  trans_time = 0;

  if(IsSplitScreen()) {
    halfway_height = 10000;
    cull_dist = 2000;
    set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    level waittill("do aftermath");
    setVolFog(100, 5500, 0, 3000, 0.4, 0.45, 0.47, 10.0);
  }
}
wind_settings() {
  SetSavedDvar("wind_global_vector", "-178 140 0");
  SetSavedDvar("wind_global_low_altitude", -500);
  SetSavedDvar("wind_global_hi_altitude", 1600);
  SetSavedDvar("wind_global_low_strength_percent", 0.2);
}

water_settings() {
  setDvar("r_watersim_waveSeedDelay", 100.0);
  setDvar("r_watersim_curlAmount", 0.18);
  setDvar("r_watersim_curlMax", 0.2);
  setDvar("r_watersim_curlReduce", 0.95);
  setDvar("r_watersim_minShoreHeight", 0.04);
  setDvar("r_watersim_foamAppear", 20.0);
  setDvar("r_watersim_foamDisappear", 0.45);
  setDvar("r_watersim_windAmount", 0.026);
  setDvar("r_watersim_windDir", 75);
  setDvar("r_watersim_windMax", 1.96);
  setDvar("r_watersim_particleGravity", 0.03);
  setDvar("r_watersim_particleLimit", 2.5);
  setDvar("r_watersim_particleLength", 0.03);
  setDvar("r_watersim_particleWidth", 2.0);
}
precacheFX() {
  level._effectType["dirt_mortar"] = "mortar";
  level._effect["dirt_mortar"] = loadfx("explosions/fx_mortarExp_dirt");

  level._effectType["water_mortar"] = "mortar_water";
  level._effect["water_mortar"] = loadfx("explosions/mortarExp_water");

  level._effectType["beach_mortar_water"] = "mortar_water";
  level._effect["beach_mortar_water"] = loadfx("explosions/mortarExp_water");

  level._effect["bunker_door_charge"] = loadfx("explosions/large_vehicle_explosion");

  level._effect["lci_rocket_impact"] = loadfx("weapon/rocket/fx_LCI_rocket_explosion_beach");
  level._effect["jeep_explode"] = loadfx("vehicle/vexplosion/fx_Vexplode_willyjeep");
  level._effect["lvt_explode"] = loadfx("vehicle/vexplosion/fx_Vexplode_lvt_beach");

  level._effect["special_lvt_explode"] = loadfx("maps/pel1/fx_exp_lvt_pel1");

  level._effect["rocket_launch"] = loadfx("weapon/rocket/fx_LCI_rocket_ignite_launch");
  level._effect["rocket_trail"] = loadfx("weapon/rocket/fx_lci_rocket_geotrail");

  level._effect["rocket_aftermath"] = loadfx("maps/pel1/fx_LCI_rocket_debris_aftermath");

  level._effect["thompson_muzzle"] = loadfx("weapon/muzzleflashes/standardflashworld");

  level._effect["bunker_explode_large"] = loadfx("maps/pel1/fx_beach_bunker_explosion_lg");
  level._effect["bunker_explode_medium"] = loadfx("maps/pel1/fx_beach_bunker_explosion_md");
  level._effect["napalm_fire_smolder"] = loadfx("maps/pel1/fx_bunker_napalm_fire_smolder");

  level._effect["distant_muzzleflash"] = loadfx("weapon/tracer/fx_muz_distnt_lg_wrld");
  level._effect["one_squib"] = loadfx("impacts/fx_bullet_dirt_lg");
  level._effect["model3_muzzle"] = loadfx("weapon/artillery/fx_artillery_jap_200mm_no_smoke");

  level._effect["lvt_wake"] = loadfx("vehicle/water/fx_wake_lvt_churn");

  level._effect["character_fire_pain_sm"] = LoadFx("env/fire/fx_fire_player_sm_1sec");
  level._effect["character_fire_death_sm"] = LoadFx("env/fire/fx_fire_player_md");
  level._effect["character_fire_death_torso"] = LoadFx("env/fire/fx_fire_player_torso");

  level._effect["bunker_fire_out"] = LoadFx("env/fire/fx_fire_flamethrower_outward_burst");
  level._effect["bunker_fire_smolder"] = LoadFx("maps/pel1/fx_bunker_flamed_smolder");

  level._effect["pistol_flash"] = loadfx("weapon/muzzleflashes/pistolflash");

  level._effect["target_smoke"] = loadfx("env/smoke/fx_smoke_ground_marker_green_w");

  level._effect["aaa_tracer"] = loadfx("Weapon/Tracer/fx_tracer_jap_tripple25_projectile");

  level._effect["plane_crashing"] = loadfx("trail/fx_trail_plane_smoke_fire_damage");

  level._effect["palms01"] = loadfx("maps/pel1/fx_foliage_snapped_palms01");
  level._effect["palms04"] = loadfx("maps/pel1/fx_foliage_snapped_palms04");
  level._effect["palms04a"] = loadfx("maps/pel1/fx_foliage_snapped_palms04a");
  level._effect["palms04b"] = loadfx("maps/pel1/fx_foliage_snapped_palms04b");
  level._effect["palms04c"] = loadfx("maps/pel1/fx_foliage_snapped_palms04c");

  level._effect["door_splash"] = loadfx("vehicle/water/fx_lst_door_splash");
  level._effect["exit_splash"] = loadfx("vehicle/water/fx_lvt_lci_exit_splash");

  level._effect["head_shot"] = loadfx("impacts/flesh_hit_body_fatal_exit");

  level._effect["palm_break"] = loadfx("env/dirt/fx_dust_fol_palm_dust_burst");

  level.scr_sound["mortar_flash"] = "wpn_mortar_fire";
  level._effect["mortar_flash"] = loadfx("weapon/mortar/fx_mortar_launch_w_trail");

  level._effect["side_smoke"] = loadfx("maps/pel1/fx_smokebank_beach_xxlg");

  level._effect["air_flak"] = loadfx("weapon/flak/fx_flak_field_8k_dist");

  level._effect["bomb_explo"] = loadfx("weapon/napalm/fx_napalmexp_tall_blk");
  level.plane_bomb_fx["corsair"] = level._effect["bomb_explo"];

  level._effect["uw_blood"] = loadfx("impacts/fx_flesh_hit_knife_uw");

  level._effect["splash_bubbles"] = loadfx("maps/sniper/fx_underwater_foam_bubbles_torso");

  level._effect["limb_bubbles"] = loadfx("bio/player/fx_underwater_bubbles_torso");
  level._effect["torso_bubbles"] = loadfx("bio/player/fx_underwater_bubbles_torso");

  level._effect["broken_radio_spark"] = loadfx("env/electrical/fx_elec_short_oneshot");

  level._effect["sullivan_death_fx"] = loadfx("maps/pel1/fx_deathfx_sullivan");

  level._effect["flesh_hit"] = loadFX("impacts/flesh_hit");

  level._effect["a_smoke_plume_xlg_slow_blk"] = loadfx("env/smoke/fx_smoke_plume_xlg_slow_blk");
  level._effect["a_smoke_plume_xlg_slow_blk_tall"] = loadfx("env/smoke/fx_smoke_plume_xlg_slow_blk_tall_w");
  level._effect["a_smk_column_lg_blk"] = loadfx("env/smoke/fx_smk_column_lg_blk");
  level._effect["smoke_rolling_thick"] = loadfx("maps/pel1/fx_smoke_rolling_thick");
  level._effect["smoke_rolling_thick2"] = loadfx("maps/pel1/fx_smoke_rolling_thick2");
  level._effect["lingering_cliff_smoke_w"] = loadfx("env/smoke/fx_smoke_artillery_barrage_w");

  level._effect["smoke_impact_smolder"] = loadfx("maps/pel1/fx_smoke_crater_w");

  level._effect["player_water_blood_cloud"] = loadfx("env/water/fx_water_blood_cloud_player");
  level._effect["med_water_blood_cloud"] = loadfx("env/water/fx_water_blood_cloud_256x256");
  level._effect["large_water_blood_cloud"] = loadfx("env/water/fx_water_blood_cloud_512x512");
  level._effect["xlarge_water_blood_cloud"] = loadfx("env/water/fx_water_blood_cloud_1024x1024");

  level._effect["detail_fire"] = loadfx("env/fire/fx_fire_rubble_detail");
  level._effect["small_fire"] = loadfx("env/fire/fx_fire_smoke_tree_brush_small_w");
  level._effect["med_fire"] = loadfx("env/fire/fx_fire_smoke_tree_brush_med_w");
  level._effect["trunk_fire"] = loadfx("env/fire/fx_fire_smoke_tree_trunk_med_w");

  level._effect["bunker_dust"] = loadfx("maps/pel1/fx_bunker_dust_ceiling_impact");
  level._effect["bunker_dust_ambient"] = loadfx("maps/pel1/fx_bunker_dust_ceiling_impact_ambient");

  level._effect["godray_small"] = loadfx("env/light/fx_ray_sun_small");
  level._effect["godray_small_short"] = loadfx("maps/pel1/fx_godray_small_short");
  level._effect["godray_small_short2"] = loadfx("maps/pel1/fx_godray_small_short2");

  level._effect["tide_splash_small"] = loadfx("env/water/fx_water_splash_tide_small");
  level._effect["tide_splash_med"] = loadfx("env/water/fx_water_splash_tide_med");
  level._effect["tide_splash_large"] = loadfx("env/water/fx_water_splash_tide_lrg");

  level._effect["ash_and_embers"] = loadfx("env/fire/fx_tree_fire_ash_embers");
  level._effect["large_fire_distant"] = loadfx("env/fire/fx_fire_large_distant");
  level._effect["xlarge_fire_distant"] = loadfx("env/fire/fx_fire_xlarge_distant");

  level._effect["heat_haze_medium"] = loadfx("maps/pel1/fx_heathaze_md");
  level._effect["ash_cloud_1"] = loadfx("maps/pel1/fx_ash_cloud");
  level._effect["dust_kick_up_emitter"] = loadfx("maps/pel1/fx_dust_kick_up_emitter");
  level._effect["dust_ambiance_tunnel"] = loadfx("maps/pel1/fx_dust_ambiance_tunnel");
}

spawnFX() {
  maps\createfx\pel1_fx::main();
}