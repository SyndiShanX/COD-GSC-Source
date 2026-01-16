/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_2_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\createfx\panama_2_fx;

main() {
  init_model_anims();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  footsteps();
  maps\createfx\panama_2_fx::main();
  level thread veh_destructible_headlights();
  level thread play_ambulence_light_fx();
}

precache_scripted_fx() {
  level._effect["fx_vlight_brakelight_default"] = loadfx("light/fx_vlight_brakelight_default");
  level._effect["fx_vlight_headlight_default"] = loadfx("light/fx_vlight_headlight_default");
  level._effect["ac130_intense_fake"] = loadfx("maps/panama/fx_tracer_ac130_fake");
  level._effect["ac130_sky_light"] = loadfx("weapon/muzzleflashes/fx_ac130_vulcan_world");
  level._effect["fx_dest_hydrant_water"] = loadfx("destructibles/fx_dest_hydrant_water");
  level._effect["jet_exhaust"] = loadfx("vehicle/exhaust/fx_exhaust_jet_afterburner");
  level._effect["jet_contrail"] = loadfx("trail/fx_geotrail_jet_contrail");
  level._effect["ambulance_siren"] = loadfx("maps/panama/fx_pan_ambulance_glow");
  level._effect["ir_strobe"] = loadfx("weapon/grenade/fx_strobe_grenade_runner");
  level._effect["flashlight"] = loadfx("env/light/fx_flashlight_ai");
  level._effect["digbat_doubletap"] = loadfx("impacts/fx_head_fatal_lg_side");
  level._effect["all_sky_exp"] = loadfx("maps/panama/fx_sky_exp_orange");
  level._effect["on_fire_tor"] = loadfx("fire/fx_fire_ai_torso");
  level._effect["on_fire_leg"] = loadfx("fire/fx_fire_ai_leg");
  level._effect["on_fire_arm"] = loadfx("fire/fx_fire_ai_arm");
  level._effect["molotov_lit"] = loadfx("weapon/molotov/fx_molotov_wick");
  level._effect["nightingale_smoke"] = loadfx("weapon/grenade/fx_nightingale_grenade_smoke");
  level._effect["apache_spotlight"] = loadfx("light/fx_vlight_apache_spotlight");
  level._effect["apache_spotlight_cheap"] = loadfx("light/fx_vlight_apache_spotlight_cheap");
  level._effect["soldier_impact_blood"] = loadfx("impacts/fx_flesh_hit_body_nogib_yaxis");
  level._effect["elevator_light"] = loadfx("env/light/fx_light_flicker_warm_sm");
  level._effect["mason_fatal_shot"] = loadfx("impacts/fx_flesh_hit_head_fatal_mason");
  level._effect["player_knee_shot_l"] = loadfx("impacts/fx_flesh_hit_knee_blowout_l");
  level._effect["player_knee_shot_r"] = loadfx("impacts/fx_flesh_hit_knee_blowout_r");
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["claymore_laser"] = loadfx("weapon/claymore/fx_claymore_laser");
  level._effect["claymore_explode"] = loadfx("explosions/fx_grenadeexp_dirt");
  level._effect["claymore_gib"] = loadfx("explosions/fx_exp_death_gib");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["ambulence_light_fx"] = loadfx("maps/panama/fx_pan_ambulance_spotlight");
}

precache_createfx_fx() {
  level._effect["fx_ac130_dropping_paratroopers"] = loadfx("bio/shrimps/fx_ac130_dropping_paratroopers");
  level._effect["fx_all_sky_exp"] = loadfx("maps/panama/fx_sky_exp_orange");
  level._effect["fx_gazebo_rubble_falling"] = loadfx("maps/panama/fx_gazebo_rubble_falling");
  level._effect["fx_gazebo_roof_impact"] = loadfx("maps/panama/fx_gazebo_roof_impact");
  level._effect["fx_gazebo_pillar_break"] = loadfx("maps/panama/fx_gazebo_pillar_break");
  level._effect["fx_gazebo_roof_collapse"] = loadfx("maps/panama/fx_gazebo_roof_collapse");
  level._effect["fx_gazebo_roof_collapse_start"] = loadfx("maps/panama/fx_gazebo_roof_collapse_start");
  level._effect["fx_apc_store_front_crash"] = loadfx("maps/panama/fx_apc_store_front_crash");
  level._effect["fx_bulletholes"] = loadfx("impacts/fx_bulletholes");
  level._effect["fx_building_collapse_exp_sm"] = loadfx("maps/panama/fx_building_collapse_exp_sm");
  level._effect["fx_building_collapse_front"] = loadfx("maps/panama/fx_building_collapse_front");
  level._effect["fx_building_collapse_debri"] = loadfx("maps/panama/fx_building_collapse_debri");
  level._effect["fx_building_collapse_side"] = loadfx("maps/panama/fx_building_collapse_side");
  level._effect["fx_exp_window_fire"] = loadfx("explosions/fx_exp_window_fire");
  level._effect["fx_clinic_ceiling_collapse"] = loadfx("maps/panama/fx_clinic_ceiling_collapse");
  level._effect["fx_impacts_apache_escape"] = loadfx("maps/panama/fx_impacts_apache_escape");
  level._effect["fx_exp_water_tower"] = loadfx("explosions/fx_exp_water_tower");
  level._effect["fx_heli_rotor_wash_finale"] = loadfx("maps/panama/fx_heli_rotor_wash_finale");
  level._effect["fx_pan_door_kick"] = loadfx("maps/panama/fx_pan_door_kick");
  level._effect["fx_shrimp_paratrooper_ambient"] = loadfx("bio/shrimps/fx_shrimp_paratrooper_ambient");
  level._effect["fx_insects_swarm_less_md_light"] = loadfx("maps/panama/fx_pan_insects_swarm_md_light");
  level._effect["fx_pan_fire_light"] = loadfx("maps/panama/fx_pan_fire_light");
  level._effect["fx_pan_fire_light_2"] = loadfx("maps/panama/fx_pan_fire_light_2");
  level._effect["fx_dust_crumble_md_runner"] = loadfx("maps/panama/fx_pan_dust_crumble");
  level._effect["fx_dust_crumble_sm_runner"] = loadfx("dirt/fx_dust_crumble_sm_runner");
  level._effect["fx_dust_crumble_int_sm_runner"] = loadfx("env/dirt/fx_dust_crumble_int_sm_runner");
  level._effect["fx_elec_transformer_sparks_runner"] = loadfx("electrical/fx_elec_transformer_sparks_runner");
  level._effect["fx_elec_ember_shower_os_la_runner"] = loadfx("maps/panama/fx_pan_powerline_sparks_runner");
  level._effect["fx_light_dust_motes_xsm_wide"] = loadfx("light/fx_light_dust_motes_xsm_wide");
  level._effect["fx_vlight_headlight_foggy_default"] = loadfx("light/fx_vlight_headlight_foggy_default");
  level._effect["fx_smk_fire_md_black"] = loadfx("smoke/fx_smk_fire_md_black");
  level._effect["fx_smk_fire_lg_black"] = loadfx("maps/panama/fx_pan_smk_lg_black");
  level._effect["fx_smk_fire_lg_white"] = loadfx("smoke/fx_smk_fire_lg_white");
  level._effect["fx_smk_linger_lit"] = loadfx("maps/panama/fx_pan_smk_linger_lit");
  level._effect["fx_smk_smolder_rubble_md"] = loadfx("smoke/fx_smk_smolder_rubble_md");
  level._effect["fx_smk_smolder_rubble_lg"] = loadfx("maps/panama/fx_pan_smk_smolder_rubble");
  level._effect["fx_smk_smolder_sm_int"] = loadfx("smoke/fx_smk_smolder_sm_int");
  level._effect["fx_smk_ceiling_crawl"] = loadfx("smoke/fx_smk_ceiling_crawl");
  level._effect["fx_smk_plume_lg_wht"] = loadfx("smoke/fx_smk_plume_lg_wht");
  level._effect["fx_pan_smk_plume_black_bg_xlg"] = loadfx("smoke/fx_pan_smk_plume_black_bg_xlg");
  level._effect["fx_fire_column_creep_xsm"] = loadfx("env/fire/fx_fire_column_creep_xsm");
  level._effect["fx_fire_column_creep_sm"] = loadfx("env/fire/fx_fire_column_creep_sm");
  level._effect["fx_fire_wall_md"] = loadfx("env/fire/fx_fire_wall_md");
  level._effect["fx_fire_ceiling_md"] = loadfx("env/fire/fx_fire_ceiling_md");
  level._effect["fx_fire_line_xsm"] = loadfx("env/fire/fx_fire_line_xsm");
  level._effect["fx_fire_line_sm"] = loadfx("env/fire/fx_fire_line_sm");
  level._effect["fx_fire_line_md"] = loadfx("env/fire/fx_fire_line_md");
  level._effect["fx_fire_sm_smolder"] = loadfx("env/fire/fx_fire_sm_smolder");
  level._effect["fx_fire_md_smolder"] = loadfx("env/fire/fx_fire_md_smolder");
  level._effect["fx_embers_falling_md"] = loadfx("env/fire/fx_embers_falling_md");
  level._effect["fx_embers_falling_sm"] = loadfx("env/fire/fx_embers_falling_sm");
  level._effect["fx_ash_embers_heavy"] = loadfx("maps/panama/fx_pan2_ash_embers_heavy");
  level._effect["fx_embers_up_dist"] = loadfx("env/fire/fx_embers_up_dist");
  level._effect["fx_debris_papers_fall_burning"] = loadfx("env/debris/fx_debris_papers_fall_burning");
  level._effect["fx_debris_papers_narrow"] = loadfx("maps/panama/fx_pan_papers_narrow");
  level._effect["fx_debris_papers_obstructed"] = loadfx("maps/panama/fx_pan_papers_obstructed");
  level._effect["fx_debris_papers_windy_slow"] = loadfx("maps/panama/fx_pan_papers_windy_slow");
  level._effect["fx_pan_light_overhead"] = loadfx("light/fx_pan_light_overhead");
  level._effect["fx_pan_light_overhead_no_beam"] = loadfx("light/fx_pan_light_overhead_no_beam");
  level._effect["fx_pan_light_overhead_no_beam_sml"] = loadfx("light/fx_pan_light_overhead_no_beam_sml");
  level._effect["fx_pan_light_overhead_flicker"] = loadfx("light/fx_pan_light_overhead_flicker");
  level._effect["fx_lf_panama_moon1"] = loadfx("lens_flares/fx_lf_panama_moon1");
  level._effect["fx_smk_pan_hallway_med"] = loadfx("maps/panama/fx_smk_pan_hallway_med");
  level._effect["fx_smk_pan_room_med"] = loadfx("maps/panama/fx_smk_pan_room_med");
  level._effect["fx_cloud_layer_fire_close"] = loadfx("maps/panama/fx_cloud_layer_fire_close");
  level._effect["fx_cloud_layer_rolling_3_lg"] = loadfx("maps/panama/fx_cloud_layer_rolling_3_lg");
  level._effect["fx_flak_field_30k"] = loadfx("explosions/fx_flak_field_30k");
  level._effect["fx_tracers_antiair_night"] = loadfx("weapon/antiair/fx_tracers_antiair_night");
  level._effect["fx_pan_flak_field_flash"] = loadfx("maps/panama/fx_pan_flak_field_flash");
  level._effect["fx_ambient_bombing_10000"] = loadfx("weapon/bomb/fx_ambient_bombing_clouds");
  level._effect["fx_water_drip_light_long_noripple"] = loadfx("env/water/fx_water_drip_light_long_noripple");
  level._effect["fx_water_drip_light_short_noripple"] = loadfx("env/water/fx_water_drip_light_short_noripple");
  level._effect["fx_exp_window_smoke"] = loadfx("explosions/fx_exp_window_smoke");
  level._effect["fx_exp_pan_window_glass"] = loadfx("maps/panama/fx_exp_pan_window_glass");
  level._effect["fx_slums_roof_collapse"] = loadfx("maps/panama/fx_slums_roof_collapse");
  level._effect["fx_slums_roof_collapse_2"] = loadfx("maps/panama/fx_slums_roof_collapse_2");
  level._effect["fx_slums_roof_collapse_3"] = loadfx("maps/panama/fx_slums_roof_collapse_3");
  level._effect["fx_slums_roof_collapse_4"] = loadfx("maps/panama/fx_slums_roof_collapse_4");
  level._effect["fx_civ_smallwagon_light"] = loadfx("vehicle/light/fx_civ_smallwagon_light");
  level._effect["fx_civ_van_headlight_r"] = loadfx("vehicle/light/fx_civ_van_headlight_r");
  level._effect["fx_civ_van_headlight_l"] = loadfx("vehicle/light/fx_civ_van_headlight_l");
  level._effect["fx_civ_van_taillight_r"] = loadfx("vehicle/light/fx_pan_civ_van_taillight_r");
  level._effect["fx_civ_van_taillight_l"] = loadfx("vehicle/light/fx_pan_civ_van_taillight_l");
  level._effect["fx_pan_fire_xsml"] = loadfx("maps/panama/fx_pan_fire_xsml");
  level._effect["fx_clinic_flourescent_glow"] = loadfx("maps/panama/fx_clinic_flourescent_glow");
  level._effect["fx_pan_flourescent_lights_lrg"] = loadfx("maps/panama/fx_pan_flourescent_lights_lrg");
  level._effect["fx_fire_fire_light_sml"] = loadfx("maps/panama/fx_fire_fire_light_sml");
  level._effect["fx_pan_slums_dust"] = loadfx("maps/panama/fx_pan_slums_dust");
  level._effect["fx_pan_car_fire_smk"] = loadfx("maps/panama/fx_pan_car_fire_smk");
}

wind_init() {
  setsaveddvar("wind_global_vector", "1 0 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

#using_animtree("fxanim_props");

init_model_anims() {
  level.scr_anim["fxanim_props"]["wall_fall"] = % fxanim_panama_wall_fall_anim;
  level.scr_anim["fxanim_props"]["laundromat_wall"] = % fxanim_panama_laundromat_wall_anim;
  level.scr_anim["fxanim_props"]["laundromat_apc"] = % fxanim_panama_laundromat_apc_anim;
  level.scr_anim["fxanim_props"]["wall_tackle"] = % fxanim_panama_wall_tackle_anim;
  level.scr_anim["fxanim_props"]["ceiling_collapse"] = % fxanim_panama_ceiling_collapse_anim;
  level.scr_anim["fxanim_props"]["water_tower"] = % fxanim_panama_water_tower_anim;
  level.scr_anim["fxanim_props"]["library"] = % fxanim_panama_library_anim;
  level.scr_anim["fxanim_props"]["library_dome1"] = % fxanim_panama_library_dome1_anim;
  level.scr_anim["fxanim_props"]["library_dome2"] = % fxanim_panama_library_dome2_anim;
  level.scr_anim["fxanim_props"]["overlook_building"] = % fxanim_panama_overlook_building_anim;
  level.scr_anim["fxanim_props"]["gazebo"] = % fxanim_panama_gazebo_anim;
  level.scr_anim["fxanim_props"]["pant01"] = % fxanim_gp_pant01_anim;
  level.scr_anim["fxanim_props"]["shirt01"] = % fxanim_gp_shirt01_anim;
  level.scr_anim["fxanim_props"]["shirt02"] = % fxanim_gp_shirt02_anim;
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_mud");
  loadfx("bio/player/fx_footstep_water");
}

veh_destructible_headlights() {
  wait 1;
  a_destructibles = getentarray("destructible", "targetname");

  foreach(e_destructible in a_destructibles) {
    if(e_destructible.destructibledef == "veh_t6_smallhatch_destructible_white")
      e_destructible thread small_hatch_headlights();
  }
}

small_hatch_headlights() {
  self play_fx("fx_civ_smallwagon_light", self.origin, undefined, "break", 1, "tag_origin");
}

play_ambulence_light_fx() {
  wait 2;
  ambulence_light_struct = getstructarray("ambulence_light_struct", "targetname");

  for(i = 0; i < ambulence_light_struct.size; i++) {
    ambulence_fx = spawn("script_model", ambulence_light_struct[i].origin);
    ambulence_fx.angles = (0, 0, 0);
    ambulence_fx setmodel("tag_origin");
    ambulence_fx.targetname = "ambulence_fx";
    playfxontag(level._effect["ambulence_light_fx"], ambulence_fx, "tag_origin");
    ambulence_fx thread spinning(i);
  }
}

spinning(num) {
  level endon("kill_spinning_ambulence_fx");

  while(true) {
    if(isDefined(self)) {
      self rotateyaw(360, 1);
      wait 1;
    }
  }
}