/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\createfx\panama_fx;

main() {
  init_model_anims();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  footsteps();
  maps\createfx\panama_fx::main();
}

precache_scripted_fx() {
  level._effect["fx_vlight_brakelight_default"] = loadfx("light/fx_vlight_brakelight_default");
  level._effect["fx_vlight_headlight_default"] = loadfx("light/fx_vlight_headlight_default");
  level._effect["fx_vlight_headlight_foggy_default"] = loadfx("light/fx_vlight_headlight_foggy_default");
  level._effect["mason_splash"] = loadfx("bio/player/fx_player_water_splash");
  level._effect["player_splash"] = loadfx("bio/player/fx_player_water_splash_impact");
  level._effect["player_underwater"] = loadfx("bio/player/fx_player_underwater_bubbles_torso_loop");
  level._effect["glowstick_light"] = loadfx("light/fx_pan_light_glowstick");
  level._effect["zodiac_churn"] = loadfx("vehicle/water/fx_wake_zodiac_churn");
  level._effect["player_bubbles"] = loadfx("maps/panama/fx_pan_water_bubbles_player");
  level._effect["maginified_muzzle_flash"] = loadfx("weapon/muzzleflashes/fx_muz_lg_gas_flash_3p");
  level._effect["ac130_intense_fake"] = loadfx("maps/panama/fx_tracer_ac130_fake");
  level._effect["ac130_intense_fake_no_impact"] = loadfx("maps/panama/fx_tracer_ac130_fake_no_impact");
  level._effect["ac130_sky_light"] = loadfx("weapon/muzzleflashes/fx_ac130_vulcan_world");
  level._effect["jet_exhaust"] = loadfx("vehicle/exhaust/fx_exhaust_jet_afterburner");
  level._effect["jet_contrail"] = loadfx("trail/fx_geotrail_jet_contrail");
  level._effect["cessna_fire"] = loadfx("explosions/fx_exp_cessna_ground");
  level._effect["learjet_explosion"] = loadfx("vehicle/vexplosion/fx_vexp_learjet");
  level._effect["door_breach"] = loadfx("props/fx_door_breach");
  level._effect["knife_death"] = loadfx("impacts/fx_flesh_hit_neck_fatal");
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["nightingale_smoke"] = loadfx("weapon/grenade/fx_nightingale_grenade_smoke");
  level._effect["sniper_trail"] = loadfx("maps/panama/fx_pan_bullet_trail_sniper");
  level._effect["sniper_impact"] = loadfx("weapon/bullet/fx_flesh_gib_fatal_01");
  level._effect["mason_flashlight"] = loadfx("maps/panama/fx_pan_seals_signal_light");
  level._effect["noriega_punched_blood"] = loadfx("maps/panama/fx_pan_punch_noriega");
  level._effect["blood_knife"] = loadfx("maps/panama/fx_pan_blood_knife");
  level._effect["blood_knife_throw"] = loadfx("maps/panama/fx_pan_blood_knife_throw");
  level._effect["motel_blood_punch"] = loadfx("maps/panama/fx_pan_motel_punch_blood");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
}

precache_createfx_fx() {
  level._effect["fx_prop_beer_open"] = loadfx("maps/panama/fx_prop_beer_open");
  level._effect["fx_tracers_antiair_night"] = loadfx("weapon/antiair/fx_tracers_antiair_night");
  level._effect["fx_flak_field_30k"] = loadfx("explosions/fx_flak_field_30k");
  level._effect["fx_ambient_bombing_10000"] = loadfx("weapon/bomb/fx_ambient_bombing_10000");
  level._effect["fx_seagulls_circle_overhead"] = loadfx("bio/animals/fx_seagulls_circle_overhead");
  level._effect["fx_pan_seagulls_near"] = loadfx("maps/panama/fx_pan_seagulls_near");
  level._effect["fx_pan_seagulls_shore_distant"] = loadfx("maps/panama/fx_pan_seagulls_shore_distant");
  level._effect["fx_pan_exp_condo"] = loadfx("maps/panama/fx_pan_exp_condo");
  level._effect["fx_pan_hotel_blood_decal"] = loadfx("maps/panama/fx_pan_hotel_blood_decal");
  level._effect["fx_pan_hotel_blood_impact"] = loadfx("maps/panama/fx_pan_hotel_blood_impact");
  level._effect["fx_pan_signal_flare"] = loadfx("maps/panama/fx_pan_signal_flare");
  level._effect["fx_pan_signal_flare_falling"] = loadfx("maps/panama/fx_pan_signal_flare_falling");
  level._effect["fx_pan_signal_flare_light"] = loadfx("maps/panama/fx_pan_signal_flare_light");
  level._effect["fx_table_cash_drop_panama"] = loadfx("props/fx_table_cash_drop_panama");
  level._effect["fx_motel_tv_destroyed"] = loadfx("props/fx_tv_motel_destroy");
  level._effect["fx_dest_condo_dust_linger"] = loadfx("maps/panama/fx_dest_condo_dust_linger");
  level._effect["fx_light_runway_line"] = loadfx("env/light/fx_light_runway_line");
  level._effect["fx_spotlight"] = loadfx("maps/panama/fx_pan_spotlight");
  level._effect["fx_shrimp_paratrooper_ambient"] = loadfx("bio/shrimps/fx_shrimp_paratrooper_ambient");
  level._effect["fx_insects_ambient"] = loadfx("bio/insects/fx_insects_ambient");
  level._effect["fx_insects_swarm_less_md_light"] = loadfx("bio/insects/fx_insects_swarm_less_md_light");
  level._effect["fx_insects_fireflies"] = loadfx("bio/insects/fx_insects_fireflies");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_smolder_rubble_md"] = loadfx("smoke/fx_smk_smolder_rubble_md");
  level._effect["fx_smk_smolder_rubble_lg"] = loadfx("smoke/fx_smk_smolder_rubble_lg");
  level._effect["fx_pipe_roof_steam_sm"] = loadfx("smoke/fx_pipe_roof_steam_sm");
  level._effect["fx_pan1_vista_smoke_hanging"] = loadfx("smoke/fx_pan1_vista_smoke_hanging");
  level._effect["fx_fire_column_creep_xsm"] = loadfx("env/fire/fx_fire_column_creep_xsm");
  level._effect["fx_fire_line_xsm"] = loadfx("env/fire/fx_fire_line_xsm");
  level._effect["fx_fire_md_smolder"] = loadfx("maps/panama/fx_fire_md_smolder_pan");
  level._effect["fx_ash_embers_heavy"] = loadfx("maps/panama/fx_pan_ash_embers_heavy");
  level._effect["fx_embers_up_dist"] = loadfx("env/fire/fx_embers_up_dist");
  level._effect["fx_debris_papers_fall_burning"] = loadfx("env/debris/fx_debris_papers_fall_burning");
  level._effect["fx_debris_papers_narrow"] = loadfx("env/debris/fx_debris_papers_narrow");
  level._effect["fx_debris_papers_obstructed"] = loadfx("env/debris/fx_debris_papers_obstructed");
  level._effect["fx_debris_papers_windy_slow"] = loadfx("env/debris/fx_debris_papers_windy_slow");
  level._effect["fx_elec_burst_shower_sm_runner"] = loadfx("env/electrical/fx_elec_burst_shower_sm_runner");
  level._effect["fx_fog_lit_overhead_amber"] = loadfx("fog/fx_fog_lit_overhead_amber");
  level._effect["fx_fog_lit_radial_amber"] = loadfx("fog/fx_fog_lit_radial_amber");
  level._effect["fx_fog_thick_800x800"] = loadfx("maps/panama/fx_pan_fog_thick_800x800");
  level._effect["fx_fog_thick_800x800_green"] = loadfx("fog/fx_fog_thick_800x800_green");
  level._effect["fx_smk_pan_hallway_med"] = loadfx("maps/panama/fx_smk_pan_hallway_med");
  level._effect["fx_smk_pan_room_med"] = loadfx("maps/panama/fx_smk_pan_room_med");
  level._effect["fx_pan_powerline_sparks_runner"] = loadfx("maps/panama/fx_pan_powerline_sparks_runner");
  level._effect["fx_pan_shoreline_froth"] = loadfx("maps/panama/fx_pan_shoreline_froth");
  level._effect["fx_pan_rocks_froth"] = loadfx("maps/panama/fx_pan_rocks_froth");
  level._effect["fx_pan_buoy_froth"] = loadfx("maps/panama/fx_pan_buoy_froth");
  level._effect["fx_pan_fog_trench_600x1200"] = loadfx("maps/panama/fx_pan_fog_trench_600x1200");
  level._effect["fx_fire_pan_billow_condo"] = loadfx("maps/panama/fx_fire_pan_billow_condo");
  level._effect["fx_smk_pan_billow_condo"] = loadfx("maps/panama/fx_smk_pan_billow_condo");
  level._effect["fx_pan_truck_smk"] = loadfx("maps/panama/fx_pan_truck_smk");
  level._effect["fx_pan_dust_motes_med"] = loadfx("maps/panama/fx_pan_dust_motes_med");
  level._effect["fx_light_tinhat_cage_white"] = loadfx("env/light/fx_light_tinhat_cage_white");
  level._effect["fx_light_tinhat_cage_yellow"] = loadfx("light/fx_light_tinhat_cage_yellow");
  level._effect["fx_pan_light_overhead"] = loadfx("light/fx_pan_light_overhead_low");
  level._effect["fx_light_floodlight_bright"] = loadfx("maps/panama/fx_pan_light_floodlight_bright");
  level._effect["fx_light_floodlight_dim_sm_amber"] = loadfx("maps/panama/fx_pan_floodlight_dim_sm_amber");
  level._effect["fx_light_flourescent_glow_cool"] = loadfx("light/fx_light_flourescent_glow_cool");
  level._effect["fx_pan_light_flourescent_glow_workshop"] = loadfx("light/fx_pan_light_flourescent_glow_workshop");
  level._effect["fx_pan_streetlight_glow"] = loadfx("light/fx_pan_streetlight_glow");
  level._effect["fx_pan_streetlight_flicker_glow"] = loadfx("light/fx_pan_streetlight_flicker_glow");
  level._effect["fx_pan_light_tower_red_blink"] = loadfx("light/fx_pan_light_tower_red_blink");
  level._effect["fx_light_portable_flood_beam"] = loadfx("light/fx_light_portable_flood_beam");
  level._effect["fx_light_desklamp_glow"] = loadfx("light/fx_light_desklamp_glow");
  level._effect["fx_pan_lightbulb_glow"] = loadfx("light/fx_pan_lightbulb_glow");
  level._effect["fx_pan_hotel_light_glow"] = loadfx("maps/panama/fx_pan_hotel_light_glow");
  level._effect["fx_pan_hotel_light_glow_dim"] = loadfx("maps/panama/fx_pan_hotel_light_glow_dim");
  level._effect["fx_pan_hotel_light_glow_dim_2"] = loadfx("maps/panama/fx_pan_hotel_light_glow_dim_2");
  level._effect["fx_pan_light_el_torito"] = loadfx("maps/panama/fx_pan_light_el_torito");
  level._effect["fx_pan_bbq_fire"] = loadfx("maps/panama/fx_pan_bbq_fire");
  level._effect["fx_pan_buoy_light"] = loadfx("maps/panama/fx_pan_buoy_light");
  level._effect["fx_vlight_brakelight_pan"] = loadfx("light/fx_vlight_brakelight_pan");
  level._effect["fx_pan_jeep_spot_light"] = loadfx("maps/panama/fx_pan_jeep_spot_light");
  level._effect["fx_pan_fire_med"] = loadfx("maps/panama/fx_pan_fire_med");
  level._effect["fx_pan_fire_lg"] = loadfx("maps/panama/fx_pan_fire_lg");
  level._effect["fx_pan_fire_light"] = loadfx("maps/panama/fx_pan_fire_light");
  level._effect["fx_elec_transformer_exp_huge_bg_ch"] = loadfx("maps/panama/fx_elec_transformer_exp_huge_bg_ch");
  level._effect["fx_pan_shed_godray"] = loadfx("maps/panama/fx_pan_shed_godray");
  level._effect["fx_pan_light_beam_jet"] = loadfx("maps/panama/fx_pan_light_beam_jet");
  level._effect["fx_pan_lock_break"] = loadfx("maps/panama/fx_pan_lock_break");
  level._effect["fx_pan_vista_glow_blue"] = loadfx("maps/panama/fx_pan_vista_glow_blue");
  level._effect["fx_pan_vista_glow_green"] = loadfx("maps/panama/fx_pan_vista_glow_green");
  level._effect["fx_pan_vista_glow_orange"] = loadfx("maps/panama/fx_pan_vista_glow_orange");
  level._effect["fx_pan_light_tinhat_cage_cool"] = loadfx("maps/panama/fx_pan_light_tinhat_cage_cool");
  level._effect["fx_pan_light_tinhat_cage_yellow"] = loadfx("maps/panama/fx_pan_light_tinhat_cage_yellow");
  level._effect["fx_pan_spotlight_table"] = loadfx("maps/panama/fx_pan_spotlight_table");
  level._effect["fx_pan_spotlight_table_2"] = loadfx("maps/panama/fx_pan_spotlight_table_2");
  level._effect["fx_pan_spotlight_garage"] = loadfx("maps/panama/fx_pan_spotlight_garage");
  level._effect["fx_lf_panama_moon1"] = loadfx("lens_flares/fx_lf_panama_moon1");
  level._effect["fx_pan_embers_condo"] = loadfx("maps/panama/fx_pan_embers_condo");
  level._effect["fx_pan_condo_rubble_impact"] = loadfx("maps/panama/fx_pan_condo_rubble_impact");
  level._effect["fx_pan_condo_rubble_collapse"] = loadfx("maps/panama/fx_pan_condo_rubble_collapse");
  level._effect["fx_pan_hangar_godray"] = loadfx("maps/panama/fx_pan_hangar_godray");
  level._effect["fx_pan_ac130_paratroopers"] = loadfx("maps/panama/fx_pan_ac130_paratroopers");
}

wind_init() {
  setsaveddvar("wind_global_vector", "1 0 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

#using_animtree("fxanim_props");

init_model_anims() {
  level.scr_anim["fxanim_props"]["pant01"] = % fxanim_gp_pant01_anim;
  level.scr_anim["fxanim_props"]["shirt01"] = % fxanim_gp_shirt01_anim;
  level.scr_anim["fxanim_props"]["shirt02"] = % fxanim_gp_shirt02_anim;
  level.scr_anim["fxanim_props"]["cloth_sheet"] = % fxanim_gp_cloth_sheet_anim;
  level.scr_anim["fxanim_props"]["windsock"] = % fxanim_gp_windsock_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_01"] = % fxanim_gp_seagull_circle_01_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_02"] = % fxanim_gp_seagull_circle_02_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_03"] = % fxanim_gp_seagull_circle_03_anim;
  level.scr_anim["fxanim_props"]["xmas_lights"] = % fxanim_gp_xmas_lights_anim;
  level.scr_anim["fxanim_props"]["buoy_fast"] = % fxanim_gp_buoy_fast_anim;
  level.scr_anim["fxanim_props"]["radar_tower"] = % fxanim_panama_radar_tower_anim;
  level.scr_anim["fxanim_props"]["bldg_rubble"] = % fxanim_panama_bldg_rubble_anim;
  level.scr_anim["fxanim_props"]["flag_horiz_rig_02"] = % fxanim_gp_flag_horiz_rig_02_anim;
  level.scr_anim["fxanim_props"]["bldg_rubble_02"] = % fxanim_panama_bldg_rubble02_anim;
  level.scr_anim["fxanim_props"]["private_jet"] = % fxanim_panama_private_jet_anim;
  level.scr_anim["fxanim_props"]["xmas_lights_palm"] = % fxanim_gp_xmas_lights_palm_anim;
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_mud");
  loadfx("bio/player/fx_footstep_water");
}