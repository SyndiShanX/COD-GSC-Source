/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_1_fx.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\la_1_fx;
#include clientscripts\_fx;

precache_util_fx() {
}

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_lf_la_1_sun"] = loadfx("lens_flares/fx_lf_la_sun2_flight");
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
  level._effect["fx_la1_tracers_dronekill"] = loadfx("weapon/antiair/fx_la1_tracers_dronekill");
  level._effect["fx_la1_rocket_dronekill"] = loadfx("weapon/antiair/fx_la1_rocket_dronekill");
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
  level._effect["fx_la_drones_above_city"] = loadfx("maps/la/fx_la_drones_above_city");
  level._effect["fx_elec_burst_shower_sm_runner"] = loadfx("env/electrical/fx_elec_burst_shower_sm_runner");
  level._effect["fx_la_road_flare"] = loadfx("light/fx_la_road_flare");
  level._effect["fx_la_road_flare_blue"] = loadfx("light/fx_la_road_flare_blue");
  level._effect["fx_vlight_car_alarm_headlight_os"] = loadfx("light/fx_vlight_car_alarm_headlight_os");
  level._effect["fx_vlight_car_alarm_taillight_os"] = loadfx("light/fx_vlight_car_alarm_taillight_os");
  level._effect["fx_paper_windy_slow"] = loadfx("debris/fx_paper_windy_slow");
}

main() {
  clientscripts\createfx\la_1_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_util_fx();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}