/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\blackout_fx;
#include maps\blackout_hangar;

main() {
  initmodelanims();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  maps\createfx\blackout_fx::main();
}

precache_scripted_fx() {
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  anim._effect["tazer_knuckles_vomit"] = loadfx("weapon/taser/fx_taser_knuckles_vomit");
  level._effect["data_glove_glow"] = loadfx("light/fx_com_data_glove_glow");
  level._effect["camera_recording"] = loadfx("maps/command_center/fx_com_camera_light_red");
  level._effect["handcuffs_light"] = loadfx("maps/command_center/fx_com_handcuff_light_red");
  level._effect["door_light_locked"] = loadfx("maps/command_center/fx_com_door_light_red");
  level._effect["door_light_unlocked"] = loadfx("maps/command_center/fx_com_door_light_green");
  level._effect["turret_death"] = loadfx("destructibles/fx_cic_turret_death");
  level._effect["fx_wire_spark"] = loadfx("maps/command_center/fx_com_camera_wire_sparks");
  level._effect["intro_punch_spit"] = loadfx("maps/command_center/fx_com_intro_punch_spit");
  level._effect["menendez_shoots_guard"] = loadfx("maps/command_center/fx_com_headshot_blood_intro");
  level._effect["cic_turret_bloodbath"] = loadfx("maps/command_center/fx_com_cic_bloodbath");
  level._effect["taser_knuckles_start"] = loadfx("weapon/taser/fx_taser_knuckles_ambient_start");
  level._effect["steam_burst_1"] = loadfx("maps/command_center/fx_com_pipe_steam_burst");
  level._effect["sparks"] = loadfx("maps/command_center/fx_com_torch_cutter");
  level._effect["fx_la_drones_above_city"] = loadfx("maps/la/fx_la_drones_above_city");
  level._effect["f35_exhaust_hover_front"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f35_vtol_front");
  level._effect["f35_exhaust_hover_rear"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f35_vtol_rear");
  level._effect["f35_exhaust_fly"] = loadfx("vehicle/exhaust/fx_com_exhaust_f35_afterburner");
  level._effect["fx_turret_flash"] = loadfx("weapon/muzzleflashes/fx_muz_ar_flash_3p");
  level._effect["fx_f38_turret_flash"] = loadfx("weapon/muzzleflashes/fx_drone_minigun_1p");
  level._effect["fx_laser_cutter_on"] = loadfx("electrical/fx_com_weld_spark_burst_2");
  level._effect["laser_cutter_sparking"] = loadfx("props/fx_com_laser_cutter_sparking_2");
  level._effect["super_kill_blood"] = loadfx("maps/command_center/fx_com_headshot_blood");
  level._effect["super_kill_blood_2"] = loadfx("maps/command_center/fx_com_headshot_blood_2");
  level._effect["super_kill_blood_3"] = loadfx("maps/command_center/fx_com_headshot_blood_3");
  level._effect["super_kill_blood_defalco"] = loadfx("maps/command_center/fx_com_headshot_blood_defalco");
  level._effect["super_kill_blood_defalco_2"] = loadfx("maps/command_center/fx_com_headshot_blood_defalco_2");
  level._effect["super_kill_blood_karma"] = loadfx("maps/command_center/fx_com_headshot_blood_karma");
  level._effect["super_kill_blood_farid"] = loadfx("maps/command_center/fx_com_headshot_blood_farid");
  level._effect["karma_neck_blood"] = loadfx("maps/command_center/fx_com_karma_neck_blood");
  level._effect["super_kill_muzzle_flash"] = loadfx("maps/command_center/fx_com_muzzle_flash_hero");
  level._effect["briggs_blood"] = loadfx("maps/command_center/fx_com_briggs_blood");
  level._effect["karma_slap"] = loadfx("maps/command_center/fx_com_karma_slap_blood");
  level._effect["farid_cough_blood"] = loadfx("maps/command_center/fx_com_superkill_blood_cough");
  level._effect["super_kill_ground_hit"] = loadfx("maps/command_center/fx_com_superkill_body_impact");
  level._effect["emergency_light_small"] = loadfx("maps/command_center/fx_com_emergency_lights_sml");
  level._effect["harper_shoots_salazar"] = loadfx("maps/command_center/fx_com_harper_headshot");
  level._effect["drone_swarm_fake_missile"] = loadfx("maps/command_center/fx_com_fake_avenger_missile");
  level._effect["crosby_shot"] = loadfx("maps/command_center/fx_com_headshot_blood_intro");
  level._effect["crosby_shot_muzzleflash"] = loadfx("weapon/muzzleflashes/fx_pistol_flash_base");
}

precache_createfx_fx() {
  level._effect["fx_com_sparks_slow"] = loadfx("maps/command_center/fx_com_sparks_slow");
  level._effect["fx_com_sparks"] = loadfx("maps/command_center/fx_com_sparks");
  level._effect["fx_com_water_drips"] = loadfx("maps/command_center/fx_com_water_drips");
  level._effect["fx_com_pipe_water"] = loadfx("maps/command_center/fx_com_pipe_water");
  level._effect["fx_com_pipe_steam"] = loadfx("maps/command_center/fx_com_pipe_steam");
  level._effect["fx_com_pipe_steam_slow"] = loadfx("maps/command_center/fx_com_pipe_steam_slow");
  level._effect["fx_com_distant_exp_1"] = loadfx("maps/command_center/fx_com_distant_exp_1");
  level._effect["fx_com_distant_exp_2"] = loadfx("maps/command_center/fx_com_distant_exp_2");
  level._effect["fx_com_pipe_steam_exp_3"] = loadfx("maps/command_center/fx_com_pipe_steam_exp_3");
  level._effect["fx_com_stairwell_lrg"] = loadfx("maps/command_center/fx_com_stairwell_lrg");
  level._effect["fx_com_vent_steam"] = loadfx("maps/command_center/fx_com_vent_steam");
  level._effect["fx_com_distant_exp_water"] = loadfx("maps/command_center/fx_com_distant_exp_water");
  level._effect["fx_com_distant_exp_flak"] = loadfx("maps/command_center/fx_com_distant_exp_flak");
  level._effect["fx_com_distant_smoke"] = loadfx("maps/command_center/fx_com_distant_smoke");
  level._effect["fx_com_distant_smoke_2"] = loadfx("maps/command_center/fx_com_distant_smoke_2");
  level._effect["fx_com_distant_smoke_sml"] = loadfx("maps/command_center/fx_com_distant_smoke_sml");
  level._effect["fx_com_deck_fire_lrg"] = loadfx("maps/command_center/fx_com_deck_fire_lrg");
  level._effect["fx_com_deck_fire_sml"] = loadfx("maps/command_center/fx_com_deck_fire_sml");
  level._effect["fx_com_int_fire_sml"] = loadfx("maps/command_center/fx_com_int_fire_sml");
  level._effect["fx_com_int_fire_sml_2"] = loadfx("maps/command_center/fx_com_int_fire_sml_2");
  level._effect["fx_com_deck_ember_sml"] = loadfx("maps/command_center/fx_com_deck_ember_sml");
  level._effect["fx_com_deck_takeoff_steam"] = loadfx("maps/command_center/fx_com_deck_takeoff_steam");
  level._effect["fx_com_carrier_runner"] = loadfx("maps/command_center/fx_com_carrier_runner");
  level._effect["fx_com_menendez_spotlight"] = loadfx("maps/command_center/fx_com_menendez_spotlight");
  level._effect["fx_com_oil_drips"] = loadfx("maps/command_center/fx_com_oil_drips");
  level._effect["fx_com_steam_debri"] = loadfx("maps/command_center/fx_com_steam_debri");
  level._effect["fx_com_deck_oil_fire"] = loadfx("maps/command_center/fx_com_deck_oil_fire");
  level._effect["fx_com_pipe_steam_exp_1"] = loadfx("maps/command_center/fx_com_pipe_steam_exp_1");
  level._effect["fx_com_pipe_steam_exp_2"] = loadfx("maps/command_center/fx_com_pipe_steam_exp_2");
  level._effect["fx_com_ceiling_collapse"] = loadfx("maps/command_center/fx_com_ceiling_collapse");
  level._effect["fx_com_deck_exp_vtol"] = loadfx("maps/command_center/fx_com_deck_exp_vtol");
  level._effect["fx_com_deck_exp_f38"] = loadfx("maps/command_center/fx_com_deck_exp_f38");
  level._effect["fx_com_deck_exp_f38_sml"] = loadfx("maps/command_center/fx_com_deck_exp_f38_sml");
  level._effect["fx_com_deck_dust"] = loadfx("maps/command_center/fx_com_deck_dust");
  level._effect["fx_com_water_leak"] = loadfx("maps/command_center/fx_com_water_leak");
  level._effect["fx_com_exp_sparks"] = loadfx("maps/command_center/fx_com_exp_sparks");
  level._effect["fx_com_glass_shatter"] = loadfx("maps/command_center/fx_com_glass_shatter");
  level._effect["fx_com_glass_shatter_f38"] = loadfx("maps/command_center/fx_com_glass_shatter_f38");
  level._effect["fx_com_water_ship_sink"] = loadfx("maps/command_center/fx_com_water_ship_sink");
  level._effect["fx_com_distant_ship_exp"] = loadfx("maps/command_center/fx_com_distant_ship_exp");
  level._effect["fx_com_window_break_paper"] = loadfx("maps/command_center/fx_com_window_break_paper");
  level._effect["fx_com_elev_fa38_impact"] = loadfx("maps/command_center/fx_com_elev_fa38_impact");
  level._effect["fx_com_elev_fa38_exp"] = loadfx("maps/command_center/fx_com_elev_fa38_exp");
  level._effect["fx_com_elev_fa38_debri_trail"] = loadfx("maps/command_center/fx_com_elev_fa38_debri_trail");
  level._effect["fx_com_elev_fa38_debri_trail_2"] = loadfx("maps/command_center/fx_com_elev_fa38_debri_trail_2");
  level._effect["fx_com_elev_fa38_debri_trail_3"] = loadfx("maps/command_center/fx_com_elev_fa38_debri_trail_3");
  level._effect["fx_com_elev_fa38_water_impact"] = loadfx("maps/command_center/fx_com_elev_fa38_water_impact");
  level._effect["fx_com_f38_slide"] = loadfx("maps/command_center/fx_com_f38_slide");
  level._effect["fx_com_drone_slide"] = loadfx("maps/command_center/fx_com_drone_slide");
  level._effect["fx_com_drone_slide_2"] = loadfx("maps/command_center/fx_com_drone_slide_2");
  level._effect["fx_com_drone_slide_3"] = loadfx("maps/command_center/fx_com_drone_slide_3");
  level._effect["fx_com_light_beam"] = loadfx("maps/command_center/fx_com_light_beam");
  level._effect["fx_com_emergency_lights"] = loadfx("maps/command_center/fx_com_emergency_lights");
  level._effect["fx_com_emergency_lights_2"] = loadfx("maps/command_center/fx_com_emergency_lights_2");
  level._effect["fx_com_hanger_godray"] = loadfx("maps/command_center/fx_com_hanger_godray");
  level._effect["fx_com_flourescent_glow_white"] = loadfx("maps/command_center/fx_com_flourescent_glow_white");
  level._effect["fx_com_flourescent_glow_warm"] = loadfx("maps/command_center/fx_com_flourescent_glow_warm");
  level._effect["fx_com_flourescent_glow_green"] = loadfx("maps/command_center/fx_com_flourescent_glow_green");
  level._effect["fx_com_intro_glow"] = loadfx("maps/command_center/fx_com_intro_glow");
  level._effect["fx_com_ceiling_smoke"] = loadfx("maps/command_center/fx_com_ceiling_smoke");
  level._effect["fx_com_hangar_smoke"] = loadfx("maps/command_center/fx_com_hangar_smoke");
  level._effect["fx_com_int_water_splash"] = loadfx("maps/command_center/fx_com_int_water_splash");
  level._effect["fx_com_oil_spill"] = loadfx("maps/command_center/fx_com_oil_spill");
  level._effect["fx_com_oil_spill_fire"] = loadfx("maps/command_center/fx_com_oil_spill_fire");
  level._effect["fx_com_ground_steam_2"] = loadfx("maps/command_center/fx_com_ground_steam_2");
  level._effect["fx_com_ceiling_steam"] = loadfx("maps/command_center/fx_com_ceiling_steam");
  level._effect["fx_com_ground_steam"] = loadfx("maps/command_center/fx_com_ground_steam");
  level._effect["fx_com_light_ray_grill"] = loadfx("maps/command_center/fx_com_light_ray_grill");
  level._effect["fx_com_large_ship_wake"] = loadfx("maps/command_center/fx_com_large_ship_wake");
  level._effect["fx_com_exp_f38_balcony"] = loadfx("maps/command_center/fx_com_exp_f38_balcony");
  level._effect["fx_com_blood_drips"] = loadfx("maps/command_center/fx_com_blood_drips");
  level._effect["fx_com_eye_scanner"] = loadfx("maps/command_center/fx_com_eye_scanner");
  level._effect["fx_com_salazar_bloodpool"] = loadfx("maps/command_center/fx_com_salazar_bloodpool");
  level._effect["fx_com_flourescent_glow_cool"] = loadfx("maps/command_center/fx_com_flourescent_glow_cool");
  level._effect["fx_com_flourescent_glow_cool_sm"] = loadfx("maps/command_center/fx_com_flourescent_glow_cool_sm");
  level._effect["fx_lf_commandcenter_light1"] = loadfx("lens_flares/fx_lf_commandcenter_light1");
  level._effect["fx_lf_commandcenter_light2"] = loadfx("lens_flares/fx_lf_commandcenter_light2");
  level._effect["fx_lf_commandcenter_light3"] = loadfx("lens_flares/fx_lf_commandcenter_light3");
  level._effect["fx_lf_commandcenter_light4"] = loadfx("lens_flares/fx_lf_commandcenter_light4");
  level._effect["fx_lf_commandcenter_light1_cic"] = loadfx("lens_flares/fx_lf_commandcenter_light1_cic");
  level._effect["fx_lf_commandcenter_sun1"] = loadfx("lens_flares/fx_lf_commandcenter_sun1");
  level._effect["fx_lf_commandcenter_small_light"] = loadfx("lens_flares/fx_lf_commandcenter_small_light");
  level._effect["fx_lf_commandcenter_beam_light"] = loadfx("lens_flares/fx_lf_commandcenter_beam_light");
  level._effect["fx_com_dust_superkill"] = loadfx("maps/command_center/fx_com_dust_superkill");
  level._effect["fx_com_glow_sml_blue"] = loadfx("maps/command_center/fx_com_glow_sml_blue");
  level._effect["fx_com_hologram_glow"] = loadfx("maps/command_center/fx_com_hologram_glow");
  level._effect["fx_com_hologram_static"] = loadfx("maps/command_center/fx_com_hologram_static");
  level._effect["fx_com_superkill_decal"] = loadfx("maps/command_center/fx_com_superkill_decal");
}

wind_init() {
  setsaveddvar("wind_global_vector", "1 0 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["flag_horiz_rig_01"] = % fxanim_gp_flag_horiz_rig_01_anim;
  level.scr_anim["fxanim_props"]["stairwell_ceiling"] = % fxanim_black_stairwell_ceiling_anim;
  level.scr_anim["fxanim_props"]["pipes_block"] = % fxanim_black_pipes_block_anim;
  level.scr_anim["fxanim_props"]["life_preserver"] = % fxanim_gp_life_preserver_anim;
  level.scr_anim["fxanim_props"]["life_preserver_long"] = % fxanim_gp_life_preserver_long_anim;
  level.scr_anim["fxanim_props"]["wirespark_long"] = % fxanim_gp_wirespark_long_anim;
  level.scr_anim["fxanim_props"]["wirespark_med"] = % fxanim_gp_wirespark_med_anim;
  level.scr_anim["fxanim_props"]["elevator_debris"] = % fxanim_black_elevator_debris_anim;
  level.scr_anim["fxanim_props"]["pipes_break_loop_01"] = % fxanim_black_pipes_break_loop_01_anim;
  level.scr_anim["fxanim_props"]["pipes_break_loop_02"] = % fxanim_black_pipes_break_loop_02_anim;
  level.scr_anim["fxanim_props"]["pipes_break_burst_01"] = % fxanim_black_pipes_break_burst_01_anim;
  level.scr_anim["fxanim_props"]["pipes_break_burst_02"] = % fxanim_black_pipes_break_burst_02_anim;
  level.scr_anim["fxanim_props"]["drone_cover_01"] = % fxanim_black_drone_cover_01_anim;
  level.scr_anim["fxanim_props"]["drone_cover_02"] = % fxanim_black_drone_cover_02_anim;
  level.scr_anim["fxanim_props"]["f38_launch_fail"] = % fxanim_black_f38_launch_fail_anim;
  level.scr_anim["fxanim_props"]["f38_failed_landing_gear"] = % fxanim_black_f38_launch_fail_gear_anim;
  level.scr_anim["fxanim_props"]["deck_vtol_1"] = % fxanim_black_deck_vtol_01_anim;
  level.scr_anim["fxanim_props"]["deck_vtol_2"] = % fxanim_black_deck_vtol_02_anim;
  level.scr_anim["fxanim_props"]["deck_vtol_3"] = % fxanim_black_deck_vtol_03_anim;
  level.scr_anim["fxanim_props"]["deck_vtol_4"] = % fxanim_black_deck_vtol_04_anim;
  level.scr_anim["fxanim_props"]["emergency_light"] = % fxanim_gp_blk_emergency_light_anim;
  level.scr_anim["fxanim_props"]["f38_bridge_chunks"] = % fxanim_black_f38_bridge_chunks_anim;
  level.scr_anim["fxanim_props"]["wakeup_light"] = % fxanim_black_mason_wakeup_light_anim;
  addnotetrack_customfunction("fxanim_props", "debris_impact", maps\blackout_hangar::elevator_debris_rumble, "elevator_debris");
}