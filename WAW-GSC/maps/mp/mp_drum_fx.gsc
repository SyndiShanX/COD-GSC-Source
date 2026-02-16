/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_drum_fx.gsc
**************************************/

#include maps\mp\_utility;

main() {
  maps\mp\createart\mp_drum_art::main();
  precacheFX();
  spawnFX();

  thread water_settings();
}
water_settings() {
  setDvar("r_watersim_waveSeedDelay", 10);
  setDvar("r_watersim_curlAmount", 0.18);
  setDvar("r_watersim_curlMax", 0.32);
  setDvar("r_watersim_curlReduce", 0.261);
  setDvar("r_watersim_minShoreHeight", 0.358);
  setDvar("r_watersim_foamAppear", 3.01);
  setDvar("r_watersim_foamDisappear", 0.40);
  setDvar("r_watersim_windAmount", 0.179);
  setDvar("r_watersim_windDir", 275);
  setDvar("r_watersim_windMax", 2.69);
  setDvar("r_watersim_particleGravity", 0.03);
  setDvar("r_watersim_particleLimit", 2.5);
  setDvar("r_watersim_particleLength", 0.03);
  setDvar("r_watersim_particleWidth", 2.0);
}

precacheFX() {
  level._effect["mp_fire_rubble_md_smk"] = loadfx("maps/mp_maps/fx_mp_fire_rubble_md_smk");
  level._effect["mp_fire_column_xsm"] = loadfx("maps/mp_maps/fx_mp_fire_column_xsm");
  level._effect["mp_fire_column_sm"] = loadfx("maps/mp_maps/fx_mp_fire_column_sm");
  level._effect["mp_fire_dlight"] = loadfx("maps/mp_maps/fx_mp_fire_dlight");
  level._effect["mp_fire_dlight_sm"] = loadfx("maps/mp_maps/fx_mp_fire_dlight_sm");
  level._effect["mp_roof_ash_embers"] = loadfx("maps/mp_maps/fx_mp_roof_ash_embers");

  level._effect["mp_smoke_plume_lg"] = loadfx("maps/mp_maps/fx_mp_smoke_plume_lg");
  level._effect["mp_smoke_plume_med"] = loadfx("maps/mp_maps/fx_mp_smoke_plume_med_slow_def");
  level._effect["mp_smoke_sm_slow"] = loadfx("maps/mp_maps/fx_mp_smoke_sm_slow");
  level._effect["mp_smoke_crater"] = loadfx("maps/mp_maps/fx_mp_smoke_crater");

  level._effect["mp_ray_light_sm"] = loadfx("env/light/fx_light_godray_overcast_sm");
  level._effect["light_godray_overcast_xsm"] = loadfx("env/light/fx_light_godray_overcast_xsm");
  level._effect["mp_ray_slit"] = loadfx("maps/mp_maps/fx_mp_ray_slit");

  level._effect["mp_water_drips_hvy_long"] = loadfx("maps/mp_maps/fx_mp_water_drips_hvy_long");
  level._effect["mp_water_drips_rust"] = loadfx("maps/mp_maps/fx_mp_water_drips_rust");
  level._effect["mp_water_wake_wide"] = loadfx("maps/mp_maps/fx_mp_water_wake_wide");
  level._effect["mp_water_shimmers"] = loadfx("maps/mp_maps/fx_mp_water_shimmers");
  level._effect["mp_water_wake_pillar"] = loadfx("maps/mp_maps/fx_mp_water_wake_pillar");
  level._effect["mp_wavebreak_runner"] = loadfx("maps/mp_maps/fx_mp_wavebreak_runner");

  level._effect["mp_dust_motes"] = loadfx("maps/mp_maps/fx_mp_ray_motes_lg");
  level._effect["mp_dust_motes_md"] = loadfx("maps/mp_maps/fx_mp_ray_motes_md");

  level._effect["mp_light_glow_indoor_short_red"] = loadfx("maps/mp_maps/fx_mp_light_glow_indoor_short_red");
  level._effect["mp_flashlight_yellow"] = loadfx("maps/mp_maps/fx_mp_flashlight_yellow");

  level._effect["mp_elec_spark_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_runner");
  level._effect["mp_pipe_steam_lg"] = loadfx("maps/mp_maps/fx_mp_pipe_steam_lg");
  level._effect["mp_insect_swarm"] = loadfx("maps/mp_maps/fx_mp_insect_swarm");
  level._effect["mp_fog_low_brown_thick"] = loadfx("maps/mp_maps/fx_mp_fog_low_brown_thick");
  level._effect["mp_sea_mist_rolling"] = loadfx("maps/mp_maps/fx_mp_sea_mist_rolling");
  level._effect["mp_birds_circling"] = loadfx("maps/mp_maps/fx_mp_birds_circling");
  level._effect["mp_sea_mine"] = loadfx("maps/mp_maps/fx_mp_sea_mine");
  level._effect["mp_seaweed"] = loadfx("maps/mp_maps/fx_mp_seaweed");
}

spawnFX() {
  maps\mp\createfx\mp_drum_fx::main();
}