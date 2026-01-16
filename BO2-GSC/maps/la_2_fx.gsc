/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\la_2_fx;

precache_util_fx() {
}

precache_scripted_fx() {
  level._effect["f35_light"] = loadfx("maps/la/fx_light_f35_ignore_z");
  level._effect["drone_muzzle_flash"] = loadfx("weapon/muzzleflashes/fx_rifle1_flash_base_creek");
  level._effect["cougar_damage_smoke"] = loadfx("vehicle/vfire/fx_vsmoke_cougar_loop");
  level._effect["dogfight_building_explosion"] = loadfx("maps/la/fx_la_exp_gas_station_lg");
  level._effect["dogfight_building_smoke"] = loadfx("maps/la/fx_building_collapse_aftermath");
  level._effect["plane_crash_smoke_concrete"] = loadfx("impacts/fx_la_bldg_concrete_rocket_loop");
  level._effect["plane_crash_smoke_glass"] = loadfx("impacts/fx_la_bldg_glass_rocket_loop");
  level._effect["plane_crash_smoke_distant"] = loadfx("impacts/fx_la_bldg_concrete_rocket_1shot");
  level._effect["vehicle_launch_trail"] = loadfx("trail/fx_trail_vehicle_push_generic");
  level._effect["crane_slam"] = loadfx("maps/la/fx_la_debris_crane_slam");
  level._effect["eject_building_hit"] = loadfx("maps/la/fx_la_player_eject_impact_bldg");
  level._effect["eject_hit_ground"] = loadfx("maps/la2/fx_la2_body_impact_concrete");
  level._effect["midair_collision_explosion"] = loadfx("maps/la2/fx_la2_exp_midair_collision");
  level._effect["chaff"] = loadfx("vehicle/vexplosion/fx_la2_drone_chaff");
  level._effect["drone_damaged_state"] = loadfx("trail/fx_trail_la2_drone_dmg");
  level._effect["embers_on_player_in_f35_vtol"] = loadfx("maps/la2/fx_la2_f35_floating_embers");
  level._effect["embers_on_player_in_f35_plane"] = loadfx("maps/la2/fx_la2_f35_floating_embers_conventional");
  level._effect["boost_fx"] = loadfx("maps/la2/fx_la2_f35_player_boost");
  level._effect["ejection_seat_rocket"] = loadfx("maps/la2/fx_la2_f35_seat_eject_rocket");
  level._effect["plane_deathfx_small"] = loadfx("explosions/fx_exp_aerial_sm_dist");
  level._effect["plane_deathfx_large"] = loadfx("explosions/fx_exp_aerial_dist");
  level._effect["plane_deathfx_huge"] = loadfx("explosions/fx_exp_aerial_lg_dist");
  level._effect["bigrig_death"] = loadfx("vehicle/vfire/fx_vfire_la2_18wheeler");
  level._effect["drone_building_impact_paper_concrete"] = loadfx("impacts/fx_la_drone_crash_concrete");
  level._effect["drone_building_impact_paper_glass"] = loadfx("impacts/fx_la_drone_crash_glass");
  level._effect["siren_light"] = loadfx("light/fx_vlight_t6_police_car_siren");
  level._effect["building_wrap_impact_sparks"] = loadfx("impacts/fx_la_drone_crash_bldg_wrap");
  level._effect["drone_impact_fx"] = loadfx("impacts/fx_deathfx_drone_gib");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["pavelow_tail_rotor_fire"] = loadfx("fire/fx_vfire_pavelow_tail");
  level._effect["intro_cougar_godrays"] = loadfx("maps/la/fx_la_cougar_intro_godrays");
  level._effect["f35_console_blinking"] = loadfx("maps/la2/fx_la2_f35_console_blinking");
  level._effect["f35_console_ambient"] = loadfx("maps/la2/fx_la2_f35_console_ambient");
  level._effect["cougar_dome_light"] = loadfx("light/fx_vlight_la_cougar_int_spot");
  level._effect["explosion_side_large"] = loadfx("maps/la2/fx_la2_exp_side_lrg");
  level._effect["explosion_side_med"] = loadfx("maps/la2/fx_la2_exp_side_med");
  level._effect["fireball_trail_lg"] = loadfx("trail/fx_la2_trail_plane_smoke_fireball");
  level._effect["fa38_exp_interior"] = loadfx("maps/la2/fx_f38_exp_interior");
  level._effect["convoy_dust"] = loadfx("maps/la2/fx_la2_convoy_dust");
  level._effect["anderson_halo"] = loadfx("maps/la2/fx_la2_f38_pilot_glow");
  level._effect["heli_crash_trail"] = loadfx("trail/fx_trail_la2_drone_dmg");
  level._effect["plane_damagefx"] = loadfx("maps/la2/fx_f38_console_damage_os");
  level._effect["convoy_tread_cougar"] = loadfx("vehicle/treadfx/fx_la2_treadfx_cougar_loop");
  level._effect["convoy_tread_ambulance"] = loadfx("vehicle/treadfx/fx_la2_treadfx_red_cross_loop");
  level._effect["convoy_skid_stop"] = loadfx("vehicle/treadfx/fx_la2_treadfx_red_cross_skid");
  level._effect["parking_garage_pillar"] = loadfx("destructibles/fx_dest_la2_garage_pillar");
  level._effect["parking_garage_wall"] = loadfx("destructibles/fx_dest_la2_garage_wall");
  level._effect["signal_tower_fx"] = loadfx("destructibles/fx_la2_dest_signal_tower");
  level._effect["f38_console_dmg_1"] = loadfx("maps/la2/fx_f38_console_dmg_1");
  level._effect["f38_console_dmg_2"] = loadfx("maps/la2/fx_f38_console_dmg_2");
  level._effect["f38_console_dmg_3"] = loadfx("maps/la2/fx_f38_console_dmg_3");
  level._effect["f38_console_dmg_4"] = loadfx("maps/la2/fx_f38_console_dmg_4");
  level._effect["f38_eject_trail"] = loadfx("maps/la2/fx_la2_fa38_crash_trail");
  level._effect["f38_afterburner"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f38_afterburner");
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["crane_collapse"] = % fxanim_la_crane_collapse_anim;
  addnotetrack_customfunction("fxanim_props", "crane_fx_start", ::crane_rooftop_fx, "crane_collapse");
  addnotetrack_customfunction("fxanim_props", "plane_hide_01", ::crane_destroy_panel_1, "crane_collapse");
  addnotetrack_customfunction("fxanim_props", "plane_hide_02", ::crane_destroy_panel_2, "crane_collapse");
  addnotetrack_customfunction("fxanim_props", "plane_hide_03", ::crane_destroy_panel_3, "crane_collapse");
  addnotetrack_customfunction("fxanim_props", "plane_hide_04", ::crane_destroy_panel_4, "crane_collapse");
  addnotetrack_customfunction("fxanim_props", "plane_hide_05", ::crane_destroy_panel_5, "crane_collapse");
  addnotetrack_customfunction("fxanim_props", "plane_hide_06", ::crane_destroy_panel_6, "crane_collapse");
  level.scr_anim["fxanim_props"]["crane_collapse_env"] = % fxanim_la_crane_collapse_env_anim;
  level.scr_anim["fxanim_props"]["garage_pillar_top1"] = % fxanim_la_garage_pillar_top1_anim;
  level.scr_anim["fxanim_props"]["garage_pillar_top2"] = % fxanim_la_garage_pillar_top2_anim;
  level.scr_anim["fxanim_props"]["garage_pillar_mid1"] = % fxanim_la_garage_pillar_mid1_anim;
  level.scr_anim["fxanim_props"]["garage_pillar_mid2"] = % fxanim_la_garage_pillar_mid2_anim;
  level.scr_anim["fxanim_props"]["garage_pillar_btm1"] = % fxanim_la_garage_pillar_btm1_anim;
  level.scr_anim["fxanim_props"]["garage_pillar_btm2"] = % fxanim_la_garage_pillar_btm2_anim;
  level.scr_anim["fxanim_props"]["garage_roof"] = % fxanim_la_garage_roof_anim;
  level.scr_anim["fxanim_props"]["garage_corner"] = % fxanim_la_garage_corner_anim;
  level.scr_anim["fxanim_props"]["palm_lrg_destroy01"] = % fxanim_gp_tree_palm_lrg_dest01_anim;
  level.scr_anim["fxanim_props"]["palm_lrg_destroy02"] = % fxanim_gp_tree_palm_lrg_dest02_anim;
  level.scr_anim["fxanim_props"]["signal_tower"] = % fxanim_la_signal_tower_anim;
  level.scr_anim["fxanim_props"]["billboard_pillar_top01"] = % fxanim_la_billboard_pillar_top01_anim;
  addnotetrack_customfunction("fxanim_props", "billboard01_destroy", ::billboard_death_1, "billboard_pillar_top01");
  level.scr_anim["fxanim_props"]["billboard_pillar_top02"] = % fxanim_la_billboard_pillar_top02_anim;
  addnotetrack_customfunction("fxanim_props", "billboard02_destroy", ::billboard_death_2, "billboard_pillar_top02");
  level.scr_anim["fxanim_props"]["bldg_convoy_block"] = % fxanim_la_bldg_convoy_block_anim;
  level.scr_anim["fxanim_props"]["f35_panels_break"] = % fxanim_la_cockpit_panels_break_anim;
  level.scr_anim["fxanim_props"]["f35_panels_break_loop"][0] = % fxanim_la_cockpit_panels_loop_anim;
}

crane_rooftop_fx(e_crane) {
  playfxontag(level._effect["crane_slam"], e_crane, "crane_fx_jnt");
  exploder(200);
}

crane_destroy_panel_1(e_crane) {
  bm_panel = get_ent("crane_smash_1", "targetname", 1);
  bm_panel delete();
}

crane_destroy_panel_2(e_crane) {
  bm_panel = get_ent("crane_smash_2", "targetname", 1);
  bm_panel delete();
}

crane_destroy_panel_3(e_crane) {
  bm_panel = get_ent("crane_smash_3", "targetname", 1);
  bm_panel delete();
}

crane_destroy_panel_4(e_crane) {
  bm_panel = get_ent("crane_smash_4", "targetname", 1);
  bm_panel delete();
}

crane_destroy_panel_5(e_crane) {
  bm_panel = get_ent("crane_smash_5", "targetname", 1);
  bm_panel delete();
}

crane_destroy_panel_6(e_crane) {
  bm_panel = get_ent("crane_smash_6", "targetname", 1);
  bm_panel delete();
}

billboard_death_1(e_billboard) {
  e_billboard playsound("evt_billboard1_collapse");
  level notify("billboard_death_1");
}

billboard_death_2(e_billboard) {
  level notify("billboard_death_2");
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
  level._effect["fx_la2_spot_harper"] = loadfx("light/fx_la2_spot_harper");
  level._effect["fx_la2_f38_swarm_distant"] = loadfx("maps/la2/fx_la2_f38_swarm_distant");
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

wind_initial_setting() {
  setsaveddvar("wind_global_vector", "-164 206 35");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 2775);
  setsaveddvar("wind_global_low_strength_percent", 0.55);
}

main() {
  initmodelanims();
  precache_util_fx();
  precache_scripted_fx();
  precache_createfx_fx();
  footsteps();
  maps\createfx\la_2_fx::main();
  wind_initial_setting();
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_dust");
}