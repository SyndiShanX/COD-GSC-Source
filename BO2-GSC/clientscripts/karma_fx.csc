/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\karma_fx.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\karma_fx;
#include clientscripts\_fx;

precache_util_fx() {
}

precache_scripted_fx() {
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

main() {
  clientscripts\createfx\karma_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_util_fx();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}