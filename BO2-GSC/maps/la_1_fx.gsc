/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_1_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_scene;
#include maps\la_utility;
#include maps\la_sam;
#include maps\createfx\la_1_fx;

precache_util_fx() {
}

precache_scripted_fx() {
  level._effect["cellphone_glow"] = loadfx("light/fx_la_p6_cell_phone_glow");
  level._effect["sec_drool"] = loadfx("blood/fx_blood_drool_slow");
  level._effect["data_glove_glow"] = loadfx("light/fx_la_data_glove_glow");
  level._effect["squibs_concrete"] = loadfx("weapon/fake/fx_fake_ap_tracer_impact_concrete");
  level._effect["squibs_metal"] = loadfx("weapon/fake/fx_fake_ap_tracer_impact_metal");
  level._effect["f35_exhaust_fly"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f38_afterburner");
  level._effect["f35_exhaust_hover_front"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f35_vtol_front");
  level._effect["f35_exhaust_hover_rear"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f35_vtol_rear");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit_body_fatal_exit");
  level._effect["rocket_explode"] = loadfx("weapon/rocket/fx_rocket_xtreme_exp_default_la");
  level._effect["rocket_trail_2x"] = loadfx("trail/fx_geotrail_sidewinder_missile_la");
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["intro_cougar_godrays"] = loadfx("maps/la/fx_la_cougar_intro_godrays");
  level._effect["intro_warp_smoke"] = loadfx("maps/la/fx_la_cougar_intro_smk_warp");
  level._effect["magic_cop_car_left"] = loadfx("maps/la/fx_la_cougar_intro_passing_cop_left");
  level._effect["magic_cop_car_right"] = loadfx("maps/la/fx_la_cougar_intro_passing_cop_right");
  level._effect["windshield_blood"] = loadfx("maps/la/fx_la_cougar_intro_windshield_blood");
  level._effect["windshield_crack"] = loadfx("maps/la/fx_la_cougar_intro_windshield_crack");
  level._effect["ambush_explosion"] = loadfx("explosions/fx_exp_la_around_cougar");
  level._effect["vehicle_launch_trail"] = loadfx("trail/fx_trail_vehicle_push_generic");
  level._effect["cougar_crash"] = loadfx("maps/la/fx_la_cougar_glass_shatter");
  level._effect["vehicle_impact_sm"] = loadfx("destructibles/fx_vehicle_scrape");
  level._effect["vehicle_impact_lg"] = loadfx("destructibles/fx_vehicle_bump");
  level._effect["vehicle_impact_front"] = loadfx("destructibles/fx_dest_car_front_crunch");
  level._effect["vehicle_impact_rear"] = loadfx("destructibles/fx_dest_car_rear_crunch");
  level._effect["siren_light"] = loadfx("light/fx_vlight_t6_police_car_siren");
  level._effect["siren_light_intro"] = loadfx("light/fx_vlight_police_car_flashing_la_intro");
  level._effect["siren_light_bike"] = loadfx("light/fx_vlight_police_cycle_flashing");
  level._effect["siren_light_bike_intro"] = loadfx("light/fx_vlight_police_cycle_flashing_la_intro");
  level._effect["cougar_dashboard"] = loadfx("light/fx_vlight_cougar_dashboard");
  level._effect["intro_warpcover"] = loadfx("explosions/fx_vexp_la_tiara_warpcover");
  level._effect["intro_blackhawk_explode"] = loadfx("explosions/fx_vexp_blackhawk_la_intro");
  level._effect["intro_blackhawk_trail"] = loadfx("fire/fx_vfire_blackhawk_stealth_body");
  level._effect["blackhawk_hit_ground"] = loadfx("maps/la/fx_la_blackhawk_road_scrape");
  level._effect["blackhawk_groundfx"] = loadfx("maps/la/fx_la_treadfx_heli_blackhawk");
  level._effect["exp_la_drone_hit_by_missile"] = loadfx("explosions/fx_exp_la_drone_hit_by_missile");
  level._effect["sam_drone_explode"] = loadfx("explosions/fx_la_exp_drone_lg");
  level._effect["sam_drone_explode_shockwave"] = loadfx("explosions/fx_exp_la_shockwave_view");
  level._effect["cougar_dome_light"] = loadfx("light/fx_vlight_la_cougar_int_spot");
  level._effect["cougar_monitor"] = loadfx("light/fx_la_cougar_monitor_glow");
  level._effect["intro_dust"] = loadfx("maps/la/fx_la_cougar_intro_dust_motes");
  level._effect["falling_sparks_tiny"] = loadfx("electrical/fx_elec_falling_sparks_tiny_os");
  level._effect["fa38_drone_crash"] = loadfx("maps/la/fx_la_fa38_intro_drone_crash");
  level._effect["fa38_car_scrape_side"] = loadfx("electrical/fx_la_fa38_intro_car_scrape_side");
  level._effect["fa38_car_scrape_roof"] = loadfx("electrical/fx_la_fa38_intro_car_scrape_roof");
  level._effect["intro_krail_scrape"] = loadfx("destructibles/fx_la_intro_krail_car_scrape");
  level._effect["torso_fire"] = loadfx("fire/fx_fire_ai_torso");
  level._effect["cc_policeman_death"] = loadfx("impacts/fx_body_fatal_exit_y");
  level._effect["bigrig_brake_light"] = loadfx("light/fx_vlight_brakelight_18wheeler");
  level._effect["18wheeler_tire_smk_rt"] = loadfx("smoke/fx_vsmk_tire_brake_18wheeler_rt");
  level._effect["18wheeler_tire_smk_lf"] = loadfx("smoke/fx_vsmk_tire_brake_18wheeler_lf");
  level._effect["trail_vehicle_falling_dust"] = loadfx("trail/fx_trail_vehicle_falling_dust");
  level._effect["car_fall_scrape"] = loadfx("maps/la/fx_car_fall_scrape");
  level._effect["smk_fire_trail_vehicle_falling"] = loadfx("trail/fx_smk_fire_trail_vehicle_falling");
  level._effect["sniper_bus_window_shatter"] = loadfx("maps/la/fx_bus_windows_shatter");
  level._effect["platform_collapse_rpg_trail"] = loadfx("maps/la/fx_la_platform_collapse_rpg_trail");
  level._effect["drone_trail"] = loadfx("trail/fx_trail_la2_drone_avenger");
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["bridge_explode"] = % fxanim_la_bridge_explode_anim;
  level.scr_anim["fxanim_props"]["bridge_explode_truck"] = % fxanim_la_bridge_explode_truck_anim;
  level.scr_anim["fxanim_props"]["freeway_collapse"] = % fxanim_la_freeway_collapse_anim;
  level.scr_anim["fxanim_props"]["freeway_collapse_car_01"] = % fxanim_la_freeway_collapse_car_01_anim;
  level.scr_anim["fxanim_props"]["freeway_wall"] = % fxanim_la_freeway_wall_anim;
  level.scr_anim["fxanim_props"]["freeway_wall_car"] = % fxanim_la_freeway_wall_car_anim;
  level.scr_anim["fxanim_props"]["freeway_cars_01"] = % fxanim_la_freeway_cars_01_anim;
  level.scr_anim["fxanim_props"]["freeway_cars_02"] = % fxanim_la_freeway_cars_02_anim;
  level.scr_anim["fxanim_props"]["freeway_drone"] = % fxanim_la_freeway_drone_anim;
  level.scr_anim["fxanim_props"]["freeway_fa38"] = % fxanim_la_freeway_fa38_anim;
  level.scr_anim["fxanim_props"]["drone_krail"] = % fxanim_la_drone_krail_anim;
  level.scr_anim["fxanim_props"]["police_car_flip"] = % fxanim_la_police_car_flip_anim;
  level.scr_anim["fxanim_props"]["suv_flip"] = % fxanim_la_suv_flip_anim;
  level.scr_anim["fxanim_props"]["police_car_f35"] = % fxanim_la_police_car_f35_anim;
  level.scr_anim["fxanim_props"]["billboard_pillar_top03"] = % fxanim_la_billboard_pillar_top03_anim;
  level.scr_anim["fxanim_props"]["f35_blast_chunks"] = % fxanim_la_f35_blast_chunks_anim;
  level.scr_anim["fxanim_props"]["billboard_drone_shoot"] = % fxanim_la_billboard_drone_shoot_anim;
  level.scr_anim["fxanim_props"]["cougar_fall_debris"] = % fxanim_la_cougar_fall_debris_anim;
  level.scr_anim["fxanim_props"]["streetlight01"] = % fxanim_la_streetlight01_anim;
  level.scr_anim["fxanim_props"]["streetlight02"] = % fxanim_la_streetlight02_anim;
  level.scr_anim["fxanim_props"]["freeway_chunks_fall"] = % fxanim_la_freeway_chunks_fall_anim;
  level.scr_anim["fxanim_props"]["road_sign_snipe_01"] = % fxanim_la_road_sign_snipe_01_anim;
  level.scr_anim["fxanim_props"]["road_sign_snipe_02"] = % fxanim_la_road_sign_snipe_02_anim;
  level.scr_anim["fxanim_props"]["road_sign_snipe_03"] = % fxanim_la_road_sign_snipe_03_anim;
  level.scr_anim["fxanim_props"]["road_sign_snipe_04"] = % fxanim_la_road_sign_snipe_04_anim;
  level.scr_anim["fxanim_props"]["sniper_drone_crash_chunks"] = % fxanim_la_sniper_drone_crash_chunks_anim;
  level.scr_anim["fxanim_props"]["sniper_drone_crash_drone"] = % fxanim_la_sniper_drone_crash_drone_anim;
  level.scr_anim["fxanim_props"]["sniper_bus"] = % fxanim_la_sniper_bus_anim;
  level.scr_anim["fxanim_props"]["sniper_freeway"] = % fxanim_la_sniper_freeway_anim;
  level.scr_anim["fxanim_props"]["sniper_rappel_rope"] = % fxanim_la_sniper_rappel_rope_anim;
  addnotetrack_customfunction("fxanim_props", "chunk_impact", maps\la_sam::drone_explode_impact, "drone_explode");
}

precache_createfx_fx() {
  level._effect["fx_lf_la_1_sun"] = loadfx("lens_flares/fx_lf_la_sun2_flight");
  level._effect["fx_la1_tracers_dronekill"] = loadfx("weapon/antiair/fx_la1_tracers_dronekill");
  level._effect["fx_la1_rocket_dronekill"] = loadfx("weapon/antiair/fx_la1_rocket_dronekill");
  level._effect["fx_la_drones_above_city"] = loadfx("maps/la/fx_la_drones_above_city");
  level._effect["fx_la_drone_avenger_invasion"] = loadfx("maps/la/fx_la_drone_avenger_invasion");
  level._effect["fx_ridiculously_large_exp_dist"] = loadfx("explosions/fx_ridiculously_large_exp_dist");
  level._effect["fx_la1_smk_us_bank_top"] = loadfx("smoke/fx_la1_smk_us_bank_top");
  level._effect["fx_la_distortion_cougar_exit"] = loadfx("maps/la/fx_la_distortion_cougar_exit");
  level._effect["fx_la_post_cougar_crash_fire_spotlight"] = loadfx("light/fx_la_post_cougar_crash_fire_spotlight");
  level._effect["fx_elec_ember_shower_os_la_runner"] = loadfx("electrical/fx_elec_ember_shower_os_la_runner");
  level._effect["fx_la_cougar_slip_falling_debris"] = loadfx("maps/la/fx_la_cougar_slip_falling_debris");
  level._effect["fx_dust_la_kickup_cougar_slip"] = loadfx("dirt/fx_dust_la_kickup_cougar_slip");
  level._effect["fx_exp_cougar_fall"] = loadfx("explosions/fx_exp_la_cougar_fall");
  level._effect["fx_rocket_xtreme_exp_default_la"] = loadfx("explosions/fx_rocket_xtreme_exp_rock_cheap");
  level._effect["fx_vexp_gen_up_stage1_small"] = loadfx("explosions/fx_vexp_gen_up_stage1_small");
  level._effect["fx_vexp_gen_up_stage3_medium"] = loadfx("explosions/fx_vexp_gen_up_stage3_medium");
  level._effect["fx_vexp_gen_up_stage3_small"] = loadfx("explosions/fx_vexp_gen_up_stage3_small");
  level._effect["fx_la2_fire_palm_detail"] = loadfx("env/fire/fx_la2_fire_palm_detail");
  level._effect["fx_la1_dest_billboard_drone"] = loadfx("destructibles/fx_la1_dest_billboard_drone");
  level._effect["fx_la_dust_rappel"] = loadfx("maps/la/fx_la_dust_rappel");
  level._effect["fx_la1_fire_car"] = loadfx("fire/fx_la1_fire_car");
  level._effect["fx_la1_fire_car_windblown"] = loadfx("fire/fx_la1_fire_car_windblown");
  level._effect["fx_la_f35_vtol_distortion"] = loadfx("maps/la/fx_la_f35_vtol_distortion");
  level._effect["fx_exp_la_fa38_intro_shockwave_view"] = loadfx("explosions/fx_exp_la_fa38_intro_shockwave_view");
  level._effect["fx_la_f35_vtol_distortion_takeoff"] = loadfx("maps/la/fx_la_f35_vtol_distortion_takeoff");
  level._effect["fx_exp_la_around_cougar"] = loadfx("explosions/fx_exp_la_around_cougar");
  level._effect["fx_la_rocket_exp_concrete_overhang"] = loadfx("explosions/fx_la_rocket_exp_concrete_overhang");
  level._effect["fx_la_platform_collapse_car_impact"] = loadfx("maps/la/fx_la_platform_collapse_car_impact");
  level._effect["fx_exp_la_drone_avenger_wall"] = loadfx("explosions/fx_exp_la_drone_avenger_wall");
  level._effect["fx_vexp_cougar_la_1_g20_fail"] = loadfx("explosions/fx_vexp_cougar_la_1_g20_fail");
  level._effect["fx_la1_smk_cougar_g20_fail"] = loadfx("smoke/fx_la1_smk_cougar_g20_fail");
  level._effect["fx_elec_led_sign_dest_sm"] = loadfx("electrical/fx_elec_led_sign_dest_sm");
  level._effect["fx_overpass_collapse_falling_debris"] = loadfx("maps/la/fx_overpass_collapse_falling_debris");
  level._effect["fx_freeway_chunks_impact_init"] = loadfx("maps/la/fx_freeway_chunks_impact_init");
  level._effect["fx_la_exp_overpass_lower_lg"] = loadfx("maps/la/fx_la_exp_overpass_lower_lg");
  level._effect["fx_overpass_impact_debris"] = loadfx("maps/la/fx_overpass_impact_debris");
  level._effect["fx_dest_concrete_crack_dust_lg"] = loadfx("destructibles/fx_dest_concrete_crack_dust_lg");
  level._effect["fx_overpass_collapse_ground_impact"] = loadfx("maps/la/fx_overpass_collapse_ground_impact");
  level._effect["fx_overpass_collapse_dust_large"] = loadfx("maps/la/fx_overpass_collapse_dust_large");
  level._effect["fx_exp_la_drone_hit_by_missile_overpass"] = loadfx("explosions/fx_exp_la_drone_hit_by_missile_overpass");
  level._effect["fx_la_car_falling_dust_sparks"] = loadfx("maps/la/fx_la_car_falling_dust_sparks");
  level._effect["fx_la_car_falling_impact"] = loadfx("maps/la/fx_la_car_falling_impact");
  level._effect["fx_concrete_crumble_area_sm"] = loadfx("dirt/fx_concrete_crumble_area_sm");
  level._effect["fx_la_overpass_debris_area_md"] = loadfx("maps/la/fx_la_overpass_debris_area_md");
  level._effect["fx_la_overpass_debris_area_lg"] = loadfx("maps/la/fx_la_overpass_debris_area_lg");
  level._effect["fx_la_overpass_debris_area_md_line"] = loadfx("maps/la/fx_la_overpass_debris_area_md_line");
  level._effect["fx_la_overpass_debris_area_md_line_wide"] = loadfx("maps/la/fx_la_overpass_debris_area_md_line_wide");
  level._effect["fx_la_overpass_debris_area_xlg"] = loadfx("maps/la/fx_la_overpass_debris_area_xlg");
  level._effect["fx_la_overpass_debris_area_lg_os"] = loadfx("maps/la/fx_la_overpass_debris_area_lg_os");
  level._effect["fx_fire_line_xsm"] = loadfx("env/fire/fx_fire_line_xsm");
  level._effect["fx_fire_fuel_xsm"] = loadfx("fire/fx_fire_fuel_xsm");
  level._effect["fx_fire_fuel_sm"] = loadfx("fire/fx_fire_fuel_sm");
  level._effect["fx_fire_fuel_sm_smolder"] = loadfx("fire/fx_fire_fuel_sm_smolder");
  level._effect["fx_fire_line_sm"] = loadfx("env/fire/fx_fire_line_sm");
  level._effect["fx_fire_fuel_sm_line"] = loadfx("fire/fx_fire_fuel_sm_line");
  level._effect["fx_fire_fuel_sm_ground"] = loadfx("fire/fx_fire_fuel_sm_ground");
  level._effect["fx_fire_line_md"] = loadfx("env/fire/fx_fire_line_md");
  level._effect["fx_fire_sm_smolder"] = loadfx("env/fire/fx_fire_sm_smolder");
  level._effect["fx_fire_md_smolder"] = loadfx("env/fire/fx_fire_md_smolder");
  level._effect["fx_embers_falling_md"] = loadfx("env/fire/fx_embers_falling_md");
  level._effect["fx_la2_fire_line_xlg"] = loadfx("env/fire/fx_la2_fire_line_xlg");
  level._effect["fx_debris_papers_fall_burning_xlg"] = loadfx("debris/fx_paper_burning_ash_falling_xlg");
  level._effect["fx_ash_falling_xlg"] = loadfx("debris/fx_ash_falling_xlg");
  level._effect["fx_ash_embers_falling_detail_long"] = loadfx("debris/fx_ash_embers_falling_detail_long");
  level._effect["fx_smk_fire_xlg_black_dist"] = loadfx("smoke/fx_smk_fire_xlg_black_dist");
  level._effect["fx_smk_plume_md_blk_wispy_dist"] = loadfx("smoke/fx_smk_plume_md_blk_wispy_dist");
  level._effect["fx_smk_plume_lg_blk_wispy_dist"] = loadfx("smoke/fx_smk_plume_lg_blk_wispy_dist");
  level._effect["fx_smk_plume_md_gray_wispy_dist"] = loadfx("smoke/fx_smk_plume_md_gray_wispy_dist");
  level._effect["fx_smk_plume_md_gray_wispy_dist_slow"] = loadfx("smoke/fx_smk_plume_md_gray_wispy_dist_slow");
  level._effect["fx_smk_battle_lg_gray_slow"] = loadfx("smoke/fx_smk_battle_lg_gray_slow");
  level._effect["fx_smk_smolder_gray_fast"] = loadfx("smoke/fx_smk_smolder_gray_fast");
  level._effect["fx_smk_smolder_gray_slow"] = loadfx("smoke/fx_smk_smolder_gray_slow");
  level._effect["fx_smk_fire_md_black"] = loadfx("smoke/fx_smk_fire_md_black");
  level._effect["fx_smk_fire_lg_black"] = loadfx("smoke/fx_smk_fire_lg_black");
  level._effect["fx_la1_smk_battle_freeway"] = loadfx("smoke/fx_la1_smk_battle_freeway");
  level._effect["fx_la_smk_plume_buidling_med"] = loadfx("smoke/fx_smk_plume_building_md_slow");
  level._effect["fx_la_smk_plume_distant_xxlg_white"] = loadfx("smoke/fx_la_smk_plume_distant_xxlg_white");
  level._effect["fx_smk_bldg_lg"] = loadfx("smoke/fx_smk_bldg_lg");
  level._effect["fx_fire_bldg_lg_dist"] = loadfx("fire/fx_fire_bldg_lg_dist");
  level._effect["fx_smk_bldg_lg_dist_dark"] = loadfx("smoke/fx_smk_bldg_lg_dist_dark");
  level._effect["fx_fire_bldg_xlg_dist"] = loadfx("fire/fx_fire_bldg_xlg_dist");
  level._effect["fx_smk_bldg_xlg_dist"] = loadfx("smoke/fx_smk_bldg_xlg_dist");
  level._effect["fx_fire_bldg_xxlg_dist"] = loadfx("fire/fx_fire_bldg_xxlg_dist");
  level._effect["fx_smk_bldg_xxlg_dist"] = loadfx("smoke/fx_smk_bldg_xxlg_dist");
  level._effect["fx_fire_bldg_xxlg_dist_tall"] = loadfx("fire/fx_fire_bldg_xxlg_dist_tall");
  level._effect["fx_smk_bldg_xxlg_dist_tall"] = loadfx("smoke/fx_smk_bldg_xxlg_dist_tall");
  level._effect["fx_elec_transformer_sparks_runner"] = loadfx("electrical/fx_elec_transformer_sparks_runner");
  level._effect["fx_elec_burst_shower_sm_runner"] = loadfx("env/electrical/fx_elec_burst_shower_sm_runner");
  level._effect["fx_la_road_flare"] = loadfx("light/fx_la_road_flare");
  level._effect["fx_la_road_flare_blue"] = loadfx("light/fx_la_road_flare_blue");
  level._effect["fx_vlight_car_alarm_headlight_os"] = loadfx("light/fx_vlight_car_alarm_headlight_os");
  level._effect["fx_vlight_car_alarm_taillight_os"] = loadfx("light/fx_vlight_car_alarm_taillight_os");
  level._effect["fx_paper_windy_slow"] = loadfx("debris/fx_paper_windy_slow");
}

wind_initial_setting() {
  setsaveddvar("wind_global_vector", "155 -84 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 16000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

main() {
  initmodelanims();
  precache_util_fx();
  precache_scripted_fx();
  precache_createfx_fx();
  footsteps();
  maps\createfx\la_1_fx::main();
  wind_initial_setting();
}

createfx_setup() {
  add_gump_function("la_1_gump_1a", ::createfx_setup_gump1a);
  add_gump_function("la_1_gump_1b", ::createfx_setup_gump1b);
  add_gump_function("la_1_gump_1c", ::createfx_setup_gump1c);
  add_gump_function("la_1_gump_1d", ::createfx_setup_gump1d);
  exploder(1001);
  level.skipto_point = tolower(getdvar(#"_id_1BEC029F"));

  if(level.skipto_point == "")
    level.skipto_point = "intro";

  maps\la_utility::load_gumps();
}

createfx_setup_gump1a() {
}

createfx_setup_gump1b() {
  run_scene_first_frame("cougar_crawl");
  run_scene_first_frame("cougar_crawl_harper");
  level waittill("gump_flushed");
  delete_scene_all("cougar_crawl");
  delete_scene_all("cougar_crawl_harper");
}

createfx_setup_gump1c() {
  run_scene("low_road_intro");
  run_scene("grouprappel_tbone");
  level waittill("gump_flushed");
  delete_scene_all("low_road_intro");
  delete_scene_all("grouprappel_tbone");
}

createfx_setup_gump1d() {
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_dust");
}