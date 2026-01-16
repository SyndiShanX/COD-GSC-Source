/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\karma_fx;
#include maps\karma_anim;
#include maps\karma;

precache_util_fx() {
}

precache_scripted_fx() {
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["parting_clouds"] = loadfx("maps/karma/fx_kar_flight_intro");
  level._effect["flight_spotlight"] = loadfx("maps/karma/fx_kar_flight_spotlight");
  level._effect["flight_hologram"] = loadfx("maps/karma/fx_kar_flight_hologram");
  level._effect["flight_lights_glows1"] = loadfx("maps/karma/fx_kar_flight_lights_bulk_glows");
  level._effect["flight_lights_centers1"] = loadfx("maps/karma/fx_kar_flight_lights_bulk_centers");
  level._effect["flight_lights_glows2"] = loadfx("maps/karma/fx_kar_flight_lights_leftover_glows");
  level._effect["flight_lights_centers2"] = loadfx("maps/karma/fx_kar_flight_lights_leftover_centers");
  level._effect["flight_overhead_panel_centers"] = loadfx("maps/karma/fx_kar_flight_lights_bulk2_centers");
  level._effect["flight_overhead_panel_glows"] = loadfx("maps/karma/fx_kar_flight_lights_bulk2_glows");
  level._effect["flight_overhead_panel_centers2"] = loadfx("maps/karma/fx_kar_flight_lights_leftover2_centers");
  level._effect["flight_overhead_panel_glows2"] = loadfx("maps/karma/fx_kar_flight_lights_leftover2_glows");
  level._effect["flight_access_panel_01"] = loadfx("maps/karma/fx_kar_flight_lights3");
  level._effect["flight_access_panel_02"] = loadfx("maps/karma/fx_kar_flight_lights4");
  level._effect["flight_lights_3p"] = loadfx("maps/karma/fx_kar_flight_lights_3p");
  level._effect["flight_tread_player"] = loadfx("maps/karma/fx_kar_vtol_tread_1p");
  level._effect["vtol_exhaust"] = loadfx("vehicle/exhaust/fx_exhaust_heli_vtol");
  level._effect["elevator_lights"] = loadfx("maps/karma/fx_kar_elevator_lights");
  level._effect["ambient_boat_wake"] = loadfx("maps/karma/fx_kar_boat_wake1");
  level._effect["scanner_ping"] = loadfx("misc/fx_weapon_indicator01");
  level._effect["checkin_scanner_red"] = loadfx("light/fx_powerbutton_blink_red_sm");
  level._effect["checkin_scanner_green"] = loadfx("light/fx_powerbutton_constant_green_sm");
  level._effect["eye_light_friendly"] = loadfx("light/fx_vlight_metalstorm_eye_grn");
  level._effect["eye_light_enemy"] = loadfx("light/fx_vlight_metalstorm_eye_red");
  level._effect["crc_neck_stab_blood"] = loadfx("maps/karma/fx_kar_blood_neck_stab");
  level._effect["crc_neck_slash_blood"] = loadfx("maps/karma/fx_kar_blood_neck_child");
  level._effect["elevator_light"] = loadfx("light/fx_kar_light_spot_elevator");
  level._effect["spiderbot_scanner"] = loadfx("maps/karma/fx_kar_spider_scanner");
  level._effect["spiderbot_taser_infinite"] = loadfx("maps/karma/fx_kar_spider_taser_infinite");
  level._effect["blood_spurt"] = loadfx("maps/karma/fx_kar_blood_meatshield");
  level._effect["muzzle_flash"] = loadfx("maps/karma/fx_kar_muzzleflash01");
  level._effect["planet_static"] = loadfx("maps/karma/fx_kar_hologram_static1");
  level._effect["club_dance_floor_laser"] = loadfx("maps/karma/fx_kar_light_projectors2");
  level._effect["club_dj_cage_laser"] = loadfx("maps/karma/fx_kar_laser_cage1");
  level._effect["club_dj_front_laser1"] = loadfx("maps/karma/fx_kar_laser_stage1");
  level._effect["club_dj_front_laser2"] = loadfx("maps/karma/fx_kar_laser_stage2");
  level._effect["club_dance_floor_laser"] = loadfx("maps/karma/fx_kar_light_projectors2");
  level._effect["club_dj_cage_laser"] = loadfx("maps/karma/fx_kar_laser_cage1");
  level._effect["club_dj_front_laser2_disco"] = loadfx("maps/karma/fx_kar_laser_stage2_disco");
  level._effect["club_dj_front_laser2_fan"] = loadfx("maps/karma/fx_kar_laser_stage2_fan");
  level._effect["club_dj_front_laser2_light"] = loadfx("maps/karma/fx_kar_laser_stage2_light");
  level._effect["club_dj_front_laser2_roller"] = loadfx("maps/karma/fx_kar_laser_stage2_roller");
  level._effect["club_dj_front_laser2_shell"] = loadfx("maps/karma/fx_kar_laser_stage2_shell");
  level._effect["club_dj_front_laser2_smoke"] = loadfx("maps/karma/fx_kar_laser_stage2_smoke");
  level._effect["club_sun"] = loadfx("maps/karma/fx_kar_globe_glow1");
  level._effect["club_sun_small"] = loadfx("maps/karma/fx_kar_globe_glow2");
  level._effect["club_dj_front_laser_static"] = loadfx("maps/karma/fx_kar_laser_static1");
  level._effect["execution_blood"] = loadfx("maps/karma/fx_kar_blood_execution1");
  level._effect["club_tracers"] = loadfx("maps/karma/fx_kar_club_tracers1");
  level._effect["light_caution_red_flash"] = loadfx("light/fx_light_caution_red_flash");
  level._effect["light_caution_orange_flash"] = loadfx("light/fx_light_caution_orange_flash");
  level._effect["kar_ashtray01"] = loadfx("maps/karma/fx_kar_ashtray01");
  level._effect["kar_candle01"] = loadfx("maps/karma/fx_kar_candle01");
  level._effect["kar_shrimp_civ"] = loadfx("maps/karma/fx_kar_shrimp_01");
  level._effect["defalco_muzzle_flash"] = loadfx("maps/karma/fx_kar_muzzle_flash_custom");
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["tree_palm_sm_dest01"] = % fxanim_gp_tree_palm_sm_dest01_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_01"] = % fxanim_gp_seagull_circle_01_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_02"] = % fxanim_gp_seagull_circle_02_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_03"] = % fxanim_gp_seagull_circle_03_anim;
  level.scr_anim["fxanim_props"]["circle_bar"] = % fxanim_karma_circle_bar_anim;
  level.scr_anim["fxanim_props"]["balcony_block"] = % fxanim_karma_balcony_block_anim;
  level.scr_anim["fxanim_props"]["club_dj_lasers"] = % fxanim_karma_club_dj_lasers_anim;
  level.scr_anim["fxanim_props"]["club_dj_light_cage"] = % fxanim_karma_club_dj_light_cage_anim;
  level.scr_anim["fxanim_props"]["club_top_lasers"] = % fxanim_karma_club_top_lasers_anim;
  level.scr_anim["fxanim_props"]["windsock_01"] = % fxanim_gp_windsock_anim;
  level.scr_anim["fxanim_props"]["rail_chain"] = % fxanim_karma_rail_chain_anim;
  level.scr_anim["fxanim_props"]["step_sign"] = % fxanim_karma_step_sign_anim;
  level.scr_anim["fxanim_props"]["club_bar_shelves_01"] = % fxanim_karma_club_bar_shelves_01_anim;
  level.scr_anim["fxanim_props"]["club_bar_shelves_02"] = % fxanim_karma_club_bar_shelves_02_anim;
  level.scr_anim["fxanim_props"]["club_lights_fall_01"] = % fxanim_karma_club_lights_fall_01_anim;
  level.scr_anim["fxanim_props"]["club_lights_fall_02"] = % fxanim_karma_club_lights_fall_02_anim;
  level.scr_anim["fxanim_props"]["tarp_shootdown_01"] = % fxanim_gp_tarp_shootdown_01_anim;
  level.scr_anim["fxanim_props"]["tarp_shootdown_02"] = % fxanim_gp_tarp_shootdown_02_anim;
  level.scr_anim["fxanim_props"]["tarp_shootdown_bloody"] = % fxanim_gp_tarp_shootdown_bloody_anim;
  level.scr_anim["fxanim_props"]["solar_system"] = % fxanim_karma_solar_system_anim;
}

precache_createfx_fx() {
  level._effect["fx_kar_shrimp_crowd_neutral"] = loadfx("maps/karma/fx_kar_shrimp_crowd_neutral");
  level._effect["fx_seagulls_shore_distant"] = loadfx("maps/karma/fx_kar_seagulls_distant");
  level._effect["fx_seagulls_circle_overhead"] = loadfx("maps/karma/fx_kar_seagulls_overhead");
  level._effect["fx_kar_elec_box_power_surge"] = loadfx("electrical/fx_kar_elec_box_power_surge");
  level._effect["fx_kar_elec_vent_field"] = loadfx("maps/karma/fx_kar_elec_vent_field");
  level._effect["fx_powerbutton_blink_green_sm"] = loadfx("light/fx_powerbutton_blink_green_sm");
  level._effect["fx_powerbutton_constant_green_sm"] = loadfx("light/fx_powerbutton_constant_green_sm");
  level._effect["fx_powerbutton_constant_red_sm"] = loadfx("light/fx_powerbutton_constant_red_sm");
  level._effect["fx_powerbutton_blink_red_sm"] = loadfx("light/fx_powerbutton_blink_red_sm");
  level._effect["fx_powerbutton_blink_red_sm_vent"] = loadfx("light/fx_powerbutton_blink_red_sm_vent");
  level._effect["fx_kar_eye_scanner"] = loadfx("maps/karma/fx_kar_eye_scanner");
  level._effect["fx_flashbang_breach_godray"] = loadfx("maps/karma/fx_flashbang_breach_godray");
  level._effect["fx_crc_projector_glow"] = loadfx("maps/karma/fx_crc_projector_glow");
  level._effect["fx_kar_smk_grenade_hall_fill_os"] = loadfx("smoke/fx_kar_smk_grenade_hall_fill_os");
  level._effect["fx_kar_smk_grenade_hall_spillout_os"] = loadfx("smoke/fx_kar_smk_grenade_hall_spillout_os");
  level._effect["fx_kar_spotlight_crc"] = loadfx("maps/karma/fx_kar_spotlight_crc");
  level._effect["fx_shrimp_kar_dance_female_a"] = loadfx("bio/shrimps/fx_shrimp_kar_dance_female_a");
  level._effect["fx_shrimp_kar_dance_female_b"] = loadfx("bio/shrimps/fx_shrimp_kar_dance_female_b");
  level._effect["fx_shrimp_kar_dance_male_a"] = loadfx("bio/shrimps/fx_shrimp_kar_dance_male_a");
  level._effect["fx_shrimp_kar_dance_male_b"] = loadfx("bio/shrimps/fx_shrimp_kar_dance_male_b");
  level._effect["fx_shrimp_group_dance01"] = loadfx("bio/shrimps/fx_shrimp_group_dance01");
  level._effect["fx_shrimp_group_dance02"] = loadfx("bio/shrimps/fx_shrimp_group_dance02");
  level._effect["fx_shrimp_group_hangout02_strobe"] = loadfx("bio/shrimps/fx_shrimp_group_hangout02_strobe");
  level._effect["fx_kar_club_spotlight"] = loadfx("maps/karma/fx_kar_club_spotlight");
  level._effect["fx_kar_club_dancefloor"] = loadfx("maps/karma/fx_kar_club_dancefloor");
  level._effect["fx_kar_club_dancefloor2"] = loadfx("maps/karma/fx_kar_club_dancefloor2");
  level._effect["fx_kar_club_mist1"] = loadfx("maps/karma/fx_kar_club_mist1");
  level._effect["fx_kar_flare01"] = loadfx("maps/karma/fx_kar_flare01");
  level._effect["fx_kar_towerlights"] = loadfx("maps/karma/fx_kar_towerlights");
  level._effect["fx_kar_club_floormist2"] = loadfx("maps/karma/fx_kar_club_floormist2");
  level._effect["fx_kar_club_floormist2_blue"] = loadfx("maps/karma/fx_kar_club_floormist2_blue");
  level._effect["fx_kar_clouds_lg"] = loadfx("maps/karma/fx_kar_clouds_lg");
  level._effect["fx_lf_karma_club01"] = loadfx("lens_flares/fx_lf_karma_club01");
  level._effect["fx_lf_karma_club02"] = loadfx("lens_flares/fx_lf_karma_club02");
  level._effect["fx_lf_karma_light_plain1"] = loadfx("lens_flares/fx_lf_karma_light_plain1");
  level._effect["fx_lf_karma_light_plain1_white"] = loadfx("lens_flares/fx_lf_karma_light_plain1_white");
  level._effect["fx_lf_karma_sun1"] = loadfx("lens_flares/fx_lf_karma_sun1");
  level._effect["fx_lf_karma_sun2"] = loadfx("lens_flares/fx_lf_karma_sun2");
  level._effect["fx_lf_karma_sun2_reflection"] = loadfx("lens_flares/fx_lf_karma_sun2_reflection");
  level._effect["fx_kar_spotlights1"] = loadfx("maps/karma/fx_kar_spotlights1");
  level._effect["fx_kar_flight_end_spotlight"] = loadfx("maps/karma/fx_kar_flight_end_spotlight");
  level._effect["fx_kar_dancefloor_spotlight"] = loadfx("maps/karma/fx_kar_dancefloor_spotlight");
  level._effect["fx_kar_sconce1"] = loadfx("maps/karma/fx_kar_sconce1");
  level._effect["fx_kar_sconce2"] = loadfx("maps/karma/fx_kar_sconce2");
  level._effect["fx_kar_club_bardive_dest1"] = loadfx("maps/karma/fx_kar_club_bardive_dest1");
  level._effect["fx_kar_laser_static2"] = loadfx("maps/karma/fx_kar_laser_static2");
  level._effect["fx_kar_club_stage_mist1"] = loadfx("maps/karma/fx_kar_club_stage_mist1");
  level._effect["fx_kar_club_mist2"] = loadfx("maps/karma/fx_kar_club_mist2");
  level._effect["fx_kar_mist1"] = loadfx("maps/karma/fx_kar_mist1");
  level._effect["fx_kar_floor_glow1"] = loadfx("maps/karma/fx_kar_floor_glow1");
  level._effect["fx_kar_starfield1"] = loadfx("maps/karma/fx_kar_starfield1");
  level._effect["fx_kar_starfield2"] = loadfx("maps/karma/fx_kar_starfield2");
  level._effect["fx_kar_globe_steam1"] = loadfx("maps/karma/fx_kar_globe_steam1");
  level._effect["fx_kar_stairs1"] = loadfx("maps/karma/fx_kar_stairs1");
  level._effect["fx_kar_clubmist1"] = loadfx("maps/karma/fx_kar_clubmist1");
  level._effect["fx_kar_clubmist2"] = loadfx("maps/karma/fx_kar_clubmist2");
  level._effect["fx_kar_club_godray"] = loadfx("maps/karma/fx_kar_club_godray");
  level._effect["fx_kar_checkin_godray"] = loadfx("maps/karma/fx_kar_checkin_godray");
  level._effect["fx_kar_checkin_godray_wide"] = loadfx("maps/karma/fx_kar_checkin_godray_wide");
  level._effect["fx_kar_ocean_mist1"] = loadfx("maps/karma/fx_kar_ocean_mist1");
  level._effect["fx_kar_ocean_mist2"] = loadfx("maps/karma/fx_kar_ocean_mist2");
  level._effect["fx_kar_water_glints1"] = loadfx("maps/karma/fx_kar_water_glints1");
  level._effect["fx_kar_water_glints2"] = loadfx("maps/karma/fx_kar_water_glints2");
  level._effect["fx_kar_water_glints3"] = loadfx("maps/karma/fx_kar_water_glints3");
  level._effect["fx_kar_dust01"] = loadfx("maps/karma/fx_kar_dust01");
  level._effect["fx_kar_dust02"] = loadfx("maps/karma/fx_kar_dust02");
  level._effect["fx_kar_vent_steam01"] = loadfx("maps/karma/fx_kar_vent_steam01");
  level._effect["fx_kar_vent_steam02"] = loadfx("maps/karma/fx_kar_vent_steam02");
  level._effect["fx_kar_vent_steam03"] = loadfx("maps/karma/fx_kar_vent_steam03");
  level._effect["fx_kar_fountain_details01"] = loadfx("maps/karma/fx_kar_fountain_details01");
  level._effect["fx_kar_fountain_details02"] = loadfx("maps/karma/fx_kar_fountain_details02");
  level._effect["fx_kar_fountain_details05"] = loadfx("maps/karma/fx_kar_fountain_details05");
  level._effect["fx_kar_fountain_show"] = loadfx("maps/karma/fx_kar_fountain_show");
  level._effect["fx_kar_fountain_show2"] = loadfx("maps/karma/fx_kar_fountain_show2");
  level._effect["fx_kar_machinery01"] = loadfx("maps/karma/fx_kar_machinery01");
  level._effect["fx_kar_machinery02"] = loadfx("maps/karma/fx_kar_machinery02");
  level._effect["fx_snow_windy_heavy_md_slow"] = loadfx("env/weather/fx_snow_windy_heavy_md_slow");
  level._effect["fx_light_beams_smoke_hard"] = loadfx("env/light/fx_light_beams_smoke_hard");
  level._effect["fx_light_beams_smoke"] = loadfx("env/light/fx_light_beams_smoke");
  level._effect["fx_light_c401"] = loadfx("env/light/fx_light_c401");
  level._effect["fx_kar_debris_papers_windy_os_loop"] = loadfx("maps/karma/fx_kar_debris_papers_windy_os_loop1");
  level._effect["fx_light_laser_fan_runner02"] = loadfx("env/light/fx_light_laser_fan_runner02");
  level._effect["fx_light_laser_shell_runner02"] = loadfx("env/light/fx_light_laser_shell_runner02");
  level._effect["fx_light_laser_smoke_cool_oneshot_run"] = loadfx("env/light/fx_light_laser_smoke_cool_oneshot_run");
  level._effect["fx_light_laser_smoke_spin_runner02"] = loadfx("env/light/fx_light_laser_smoke_spin_runner02");
  level._effect["fx_pipe_steam_md"] = loadfx("env/smoke/fx_pipe_steam_md");
  level._effect["fx_pipe_steam_xsm"] = loadfx("maps/karma/fx_kar_pipe_steam_xsm");
  level._effect["fx_kar_steam_corridor_xsm"] = loadfx("smoke/fx_kar_steam_corridor_xsm");
  level._effect["fx_steam_hallway_md"] = loadfx("smoke/fx_steam_hallway_md");
  level._effect["fx_kar_light_ray_fan"] = loadfx("light/fx_kar_light_ray_fan");
  level._effect["fx_kar_light_ray_vent_grill_xsm"] = loadfx("light/fx_kar_light_ray_vent_grill_xsm");
  level._effect["fx_kar_light_ray_vent_grill_sm"] = loadfx("light/fx_kar_light_ray_vent_grill_sm");
  level._effect["fx_kar_light_ray_vent_grill_md"] = loadfx("light/fx_kar_light_ray_vent_grill_md");
  level._effect["fx_kar_dust_motes_vent"] = loadfx("dirt/fx_kar_dust_motes_vent");
  level._effect["fx_kar_dust_motes_vent_lit"] = loadfx("dirt/fx_kar_dust_motes_vent_lit");
  level._effect["fx_kar_spiderbot_drips"] = loadfx("maps/karma/fx_kar_spiderbot_drips");
  level._effect["fx_kar_light_ray_grill_sm_fade"] = loadfx("maps/karma/fx_kar_light_ray_grill_sm_fade");
  level._effect["fx_kar_ceiling_steam"] = loadfx("maps/karma/fx_kar_ceiling_steam");
  level._effect["fx_kar_rat_steam"] = loadfx("maps/karma/fx_kar_rat_steam");
  level._effect["fx_kar_construction_mist"] = loadfx("maps/karma/fx_kar_construction_mist");
  level._effect["fx_kar_light_outdoor"] = loadfx("maps/karma/fx_kar_light_outdoor_flare");
  level._effect["fx_elevator_godray"] = loadfx("maps/karma/fx_elevator_godray");
  level._effect["fx_kar_kiosk_dust"] = loadfx("maps/karma/fx_kar_kiosk_dust");
  level._effect["fx_kar_kiosk_plant_dust"] = loadfx("maps/karma/fx_kar_kiosk_plant_dust");
  level._effect["fx_kar_glass_glints2"] = loadfx("maps/karma/fx_kar_glass_glints2");
  level._effect["fx_lf_karma_solar"] = loadfx("lens_flares/fx_lf_karma_solar");
}

wind_initial_setting() {
  setsaveddvar("wind_global_vector", "86.1767 149.316 18.6");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 2775);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

main() {
  initmodelanims();
  precache_util_fx();
  precache_scripted_fx();
  precache_createfx_fx();
  footsteps();
  maps\createfx\karma_fx::main();
  wind_initial_setting();
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_dust");
}

createfx_setup() {
  maps\karma_anim::arrival_anims();
  maps\karma_anim::checkin_anims();
  maps\karma_anim::dropdown_anims();
  maps\karma_anim::spiderbot_anims();
  maps\karma_anim::construction_anims();
  maps\karma_anim::club_anims();
  level.skipto_point = tolower(getdvar(#"_id_1BEC029F"));

  if(level.skipto_point == "")
    level.skipto_point = "arrival";

  maps\karma::load_gumps_karma();
}

createfx_setup_gump_checkin() {
}

createfx_setup_gump_hotel() {
}

createfx_setup_gump_construction() {
}

createfx_setup_gump_club() {
}