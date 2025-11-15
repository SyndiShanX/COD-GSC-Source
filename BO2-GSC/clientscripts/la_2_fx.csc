/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_2_fx.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\la_2_fx;
#include clientscripts\_fx;

precache_util_fx() {
}

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_la2_exp_building_hero"] = loadfx("maps/la2/fx_la2_exp_building_hero");
  level._effect["fx_la2_exp_crumble_building_hero"] = loadfx("maps/la2/fx_la2_exp_crumble_building_hero");
  level._effect["fx_exp_la2_garage"] = loadfx("explosions/fx_exp_la2_garage");
  level._effect["fx_dest_la2_garage_collapse"] = loadfx("destructibles/fx_dest_la2_garage_collapse");
  level._effect["fx_la2_garage_dust_collapse"] = loadfx("maps/la2/fx_la2_garage_dust_collapse");
  level._effect["fx_la2_garage_dust_linger"] = loadfx("maps/la2/fx_la2_garage_dust_linger");
  level._effect["fx_la2_building_collapse_os"] = loadfx("maps/la2/fx_la2_building_collapse_os");
  level._effect["fx_la2_crane_spark_burst"] = loadfx("maps/la2/fx_la2_crane_spark_burst");
  level._effect["fx_la2_dest_billboard_bottom"] = loadfx("destructibles/fx_la2_dest_billboard_bottom");
  level._effect["fx_la2_dest_billboard_top_impact"] = loadfx("destructibles/fx_la2_dest_billboard_top_impact");
  level._effect["fx_la2_f38_swarm"] = loadfx("maps/la2/fx_la2_f38_swarm");
  level._effect["fx_la2_debris_falling"] = loadfx("maps/la2/fx_la2_debris_falling");
  level._effect["fx_la2_drone_swarm_exp"] = loadfx("maps/la2/fx_la2_drone_swarm_exp");
  level._effect["fx_la2_f38_swarm_formation"] = loadfx("maps/la2/fx_la2_f38_swarm_formation");
  level._effect["fx_la2_explo_field"] = loadfx("maps/la2/fx_la2_explo_field");
  level._effect["fx_la2_f38_swarm_distant"] = loadfx("maps/la2/fx_la2_f38_swarm_distant");
  level._effect["fx_la2_spot_harper"] = loadfx("light/fx_la2_spot_harper");
  level._effect["fx_la2_smoke_intro_aftermath"] = loadfx("maps/la2/fx_la2_smoke_intro_aftermath");
  level._effect["fx_la2_smoke_intro_aftermath_sm"] = loadfx("maps/la2/fx_la2_smoke_intro_aftermath_sm");
  level._effect["fx_building_collapse_aftermath_sm"] = loadfx("maps/la/fx_building_collapse_aftermath_sm");
  level._effect["fx_la2_ash_windy_heavy_sm"] = loadfx("maps/la2/fx_la2_ash_windy_heavy_sm");
  level._effect["fx_la2_ash_windy_heavy_md"] = loadfx("maps/la2/fx_la2_ash_windy_heavy_md");
  level._effect["fx_la2_debris_papers_fall_burning"] = loadfx("env/debris/fx_la2_debris_papers_fall_burning");
  level._effect["fx_la2_debris_papers_windy_slow"] = loadfx("env/debris/fx_la2_debris_papers_windy_slow");
  level._effect["fx_la2_debris_papers_fall_burning_xlg"] = loadfx("env/debris/fx_la2_debris_papers_fall_burning_xlg");
  level._effect["fx_fire_fuel_sm"] = loadfx("fire/fx_fire_fuel_sm");
  level._effect["fx_fire_fuel_sm_smolder"] = loadfx("fire/fx_fire_fuel_sm_smolder");
  level._effect["fx_la2_fire_fuel_sm"] = loadfx("maps/la2/fx_la2_fire_fuel_sm");
  level._effect["fx_la2_fire_intro_blocker"] = loadfx("maps/la2/fx_la2_fire_intro_blocker");
  level._effect["fx_la2_road_flare_distant"] = loadfx("light/fx_la2_road_flare_distant");
  level._effect["fx_la2_billboard_glow_med"] = loadfx("maps/la2/fx_la2_billboard_glow_med");
  level._effect["fx_la2_light_beacon_red"] = loadfx("light/fx_la2_light_beacon_red");
  level._effect["fx_la2_light_beacon_white"] = loadfx("light/fx_la2_light_beacon_white");
  level._effect["fx_la2_light_beacon_blue"] = loadfx("light/fx_la2_light_beacon_blue");
  level._effect["fx_la2_light_beacon_red_blink"] = loadfx("light/fx_la2_light_beacon_red_blink");
  level._effect["fx_la2_light_beacon_blue_blink"] = loadfx("light/fx_la2_light_beacon_blue_blink");
  level._effect["fx_la2_light_beam_streetlamp_intro"] = loadfx("maps/la2/fx_la2_light_beam_streetlamp_intro");
  level._effect["fx_contrail_spawner"] = loadfx("maps/la/fx_la_contrail_sky_spawner");
  level._effect["fx_la2_tracers_antiair"] = loadfx("weapon/antiair/fx_la2_tracers_antiair");
  level._effect["fx_la2_tracers_antiair_playspace"] = loadfx("weapon/antiair/fx_la2_tracers_antiair_playspace");
  level._effect["fx_la2_tracers_dronekill"] = loadfx("weapon/antiair/fx_la2_tracers_dronekill");
  level._effect["fx_elec_burst_shower_lg_runner"] = loadfx("env/electrical/fx_elec_burst_shower_lg_runner");
  level._effect["fx_la2_elec_burst_xlg_runner"] = loadfx("env/electrical/fx_la2_elec_burst_xlg_runner");
  level._effect["fx_la2_elec_spark_runner_sm"] = loadfx("electrical/fx_la2_elec_spark_runner_sm");
  level._effect["fx_la2_fire_window_lg"] = loadfx("env/fire/fx_la2_fire_window_lg");
  level._effect["fx_la2_fire_window_xlg"] = loadfx("env/fire/fx_la2_fire_window_xlg");
  level._effect["fx_la2_fire_lg"] = loadfx("env/fire/fx_la2_fire_lg");
  level._effect["fx_la2_fire_xlg"] = loadfx("env/fire/fx_la2_fire_xlg");
  level._effect["fx_la2_fire_line_xlg"] = loadfx("env/fire/fx_la2_fire_line_xlg");
  level._effect["fx_la2_ember_column"] = loadfx("env/fire/fx_la2_ember_column");
  level._effect["fx_la2_smolder_mortar_crater"] = loadfx("env/fire/fx_la2_smolder_mortar_crater");
  level._effect["fx_la2_fire_palm"] = loadfx("env/fire/fx_la2_fire_palm");
  level._effect["fx_la2_fire_palm_detail"] = loadfx("env/fire/fx_la2_fire_palm_detail");
  level._effect["fx_la2_fire_veh"] = loadfx("env/fire/fx_la2_fire_veh");
  level._effect["fx_la2_fire_veh_sm"] = loadfx("env/fire/fx_la2_fire_veh_sm");
  level._effect["fx_la_smk_cloud_med"] = loadfx("env/smoke/fx_la_smk_cloud_med");
  level._effect["fx_la_smk_cloud_xlg"] = loadfx("env/smoke/fx_la_smk_cloud_xlg");
  level._effect["fx_la_smk_cloud_battle_lg"] = loadfx("env/smoke/fx_la_smk_cloud_battle_lg");
  level._effect["fx_smoke_building_med"] = loadfx("env/smoke/fx_la2_smk_plume_building_med");
  level._effect["fx_smoke_building_xlg"] = loadfx("env/smoke/fx_la2_smk_plume_building_xlg");
  level._effect["fx_la_smk_plume_buidling_hero"] = loadfx("env/smoke/fx_la_smk_plume_buidling_hero");
  level._effect["fx_la_smk_low_distant_med"] = loadfx("env/smoke/fx_la_smk_low_distant_med");
  level._effect["fx_la_smk_low_distant_xlg"] = loadfx("env/smoke/fx_la_smk_low_distant_xlg");
  level._effect["fx_la_smk_plume_distant_med"] = loadfx("env/smoke/fx_la_smk_plume_distant_med");
  level._effect["fx_la_smk_plume_distant_lg"] = loadfx("env/smoke/fx_la_smk_plume_distant_lg");
  level._effect["fx_la_smk_plume_distant_xlg"] = loadfx("env/smoke/fx_la_smk_plume_distant_xlg");
  level._effect["fx_la2_smk_bld_wall_right_sm"] = loadfx("smoke/fx_la2_smk_bld_wall_right_sm");
  level._effect["fx_la2_smk_bld_wall_left_xlg"] = loadfx("smoke/fx_la2_smk_bld_wall_left_xlg");
  level._effect["fx_la2_smk_bld_wall_right_xlg"] = loadfx("smoke/fx_la2_smk_bld_wall_right_xlg");
  level._effect["fx_la2_smk_bld_wall_north_lg"] = loadfx("smoke/fx_la2_smk_bld_wall_north_lg");
  level._effect["fx_la2_vista_smoke_plume_01_right"] = loadfx("smoke/fx_la2_vista_smoke_plume_01_right");
  level._effect["fx_la2_vista_smoke_plume_01_left"] = loadfx("smoke/fx_la2_vista_smoke_plume_01_left");
  level._effect["fx_lf_la_sun2"] = loadfx("lens_flares/fx_lf_la_sun2");
  level._effect["fx_lf_la_sun2_flight"] = loadfx("lens_flares/fx_lf_la_sun2_flight");
}

main() {
  clientscripts\createfx\la_2_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_util_fx();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}