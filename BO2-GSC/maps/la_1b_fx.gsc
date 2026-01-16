/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_1b_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\la_utility;
#include maps\la_plaza;
#include maps\createfx\la_1b_fx;

precache_util_fx() {
}

precache_scripted_fx() {
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["cougar_monitor"] = loadfx("light/fx_la_cougar_monitor_glow");
  level._effect["ce_f35_fx"] = loadfx("fire/fx_vfire_fa38_body");
  level._effect["ce_dest_cop_motorcycle"] = loadfx("maps/la/fx_la_bullet_impact_motorcycle");
  level._effect["ce_dest_cop_car_fx"] = loadfx("maps/la/fx_la_dest_squadcar_intro");
  level._effect["ce_cop_car_marks_left"] = loadfx("vehicle/treadfx/fx_treadfx_skid_stop_left_runner");
  level._effect["ce_cop_car_marks_right"] = loadfx("vehicle/treadfx/fx_treadfx_skid_stop_right_runner");
  level._effect["ce_bdog_tracer"] = loadfx("maps/la/fx_la_claw_muzzleflash_intro");
  level._effect["ce_cop_blood_fx_single"] = loadfx("maps/la/fx_la_policeman_death_intro");
  level._effect["ce_motocop_blood_fx_single"] = loadfx("maps/la/fx_la_motocop_death_intro");
  level._effect["ce_bdog_stun"] = loadfx("maps/la/fx_claw_stun_electric_intro");
  level._effect["ce_bdog_killshot"] = loadfx("impacts/fx_la_metalhit_claw_killshot");
  level._effect["ce_bdog_death"] = loadfx("destructibles/fx_claw_exp_death");
  level._effect["ce_harper_muzflash"] = loadfx("weapon/muzzleflashes/fx_muz_mstorm_flash_3p_lg_sp");
  level._effect["f35_exhaust_fly"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f38_afterburner");
  level._effect["f35_exhaust_hover_front"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f35_vtol_front");
  level._effect["f35_exhaust_hover_rear"] = loadfx("vehicle/exhaust/fx_exhaust_la1_f35_vtol_rear");
  level._effect["elec_transformer01_exp"] = loadfx("electrical/fx_elec_transformer_exp_lg_os");
  level._effect["elec_transformer02_exp"] = loadfx("electrical/fx_elec_transformer_exp_md_os");
  level._effect["brute_force_explosion"] = loadfx("explosions/fx_vexp_cougar");
  level._effect["vehicle_launch_trail"] = loadfx("trail/fx_trail_vehicle_push_generic");
  level._effect["car_explosion"] = loadfx("vehicle/vexplosion/fx_vexp_gen_up_runner_sp_future");
  level._effect["siren_light_bike"] = loadfx("light/fx_vlight_police_cycle_flashing");
  level._effect["siren_light"] = loadfx("light/fx_vlight_t6_police_car_siren_day");
  level._effect["f38crash_slide"] = loadfx("maps/la/fx_fa38_ground_impact_slide");
  level._effect["spire_collapse"] = loadfx("maps/la/fx_spire_collapse_center_dust");
  level._effect["laser_cutter_on"] = loadfx("props/fx_laser_cutter_on");
  level._effect["laser_cutter_sparking"] = loadfx("props/fx_laser_cutter_sparking");
  level._effect["la_building_debris_dust_trail"] = loadfx("dirt/fx_la_building_debris_dust_trail");
  level._effect["building_collapse_chunk_debris"] = loadfx("maps/la/fx_building_collapse_crunch_debris_sm");
  level._effect["sam_drone_explode"] = loadfx("explosions/fx_la_exp_drone_lg");
  level._effect["small_drone_bits_impact"] = loadfx("impacts/fx_impact_drone_piece");
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["apartment"] = % fxanim_la_apartment_anim;
  level.scr_anim["fxanim_props"]["debris_lrg_01"] = % fxanim_la_debris_fall_lrg_01_anim;
  level.scr_anim["fxanim_props"]["debris_lrg_02"] = % fxanim_la_debris_fall_lrg_02_anim;
  level.scr_anim["fxanim_props"]["debris_lrg_03"] = % fxanim_la_debris_fall_lrg_03_anim;
  level.scr_anim["fxanim_props"]["debris_sm_01"] = % fxanim_la_debris_fall_sm_01_anim;
  level.scr_anim["fxanim_props"]["debris_sm_02"] = % fxanim_la_debris_fall_sm_02_anim;
  level.scr_anim["fxanim_props"]["debris_sm_03"] = % fxanim_la_debris_fall_sm_03_anim;
  level.scr_anim["fxanim_props"]["drone_chunks"] = % fxanim_la_drone_chunks_anim;
  level.scr_anim["fxanim_props"]["f35_env_stay"] = % fxanim_la_f35_env_stay_anim;
  level.scr_anim["fxanim_props"]["f35_env_delete"] = % fxanim_la_f35_env_delete_anim;
  level.scr_anim["fxanim_props"]["f35_walkway"] = % fxanim_la_f35_walkway_anim;
  level.scr_anim["fxanim_props"]["f35_tower_01"] = % fxanim_la_f35_tower_01_anim;
  level.scr_anim["fxanim_props"]["f35_tower_02"] = % fxanim_la_f35_tower_02_anim;
  level.scr_anim["fxanim_props"]["f35_column"] = % fxanim_la_f35_column_anim;
  level.scr_anim["fxanim_props"]["bldg_convoy_block"] = % fxanim_la_bldg_convoy_block_anim;
  level.scr_anim["fxanim_props"]["spire_collapse"] = % fxanim_la_spire_collapse_anim;
  level.scr_anim["fxanim_props"]["f35_la_plaza_crash"] = % fxanim_la_f35_dead_anim;
  level.scr_anim["fxanim_props"]["bldg_collapse_01"] = % fxanim_la_bldg_collapse_01_anim;
  level.scr_anim["fxanim_props"]["skyscraper02_impact"] = % fxanim_la_skyscraper02_impact_anim;
  level.scr_anim["fxanim_props"]["skyscraper02"] = % fxanim_la_skyscraper02_anim;
  level.scr_anim["fxanim_props"]["alley_power_pole"] = % fxanim_la_alley_power_pole_anim;
  addnotetrack_fxontag("fxanim_props", "spire_collapse", "spire_glass_break", "spire_collapse", "bend_jnt");
  addnotetrack_exploder("fxanim_props", "drone_chunks_hit_lrg", 601, "drone_chunks");
  addnotetrack_fxontag("fxanim_props", "debris_lrg_01", "debris_hit_lrg", "fx_drone_wall_impact", "debris_lrg_01_jnt");
  addnotetrack_fxontag("fxanim_props", "debris_lrg_02", "debris_hit_lrg", "fx_drone_wall_impact", "debris_lrg_02_jnt");
  addnotetrack_fxontag("fxanim_props", "debris_lrg_03", "debris_hit_lrg", "fx_drone_wall_impact", "debris_lrg_03_jnt");
  addnotetrack_fxontag("fxanim_props", "debris_sm_01", "debris_hit_sm", "small_drone_bits_impact", "debris_sm_01_jnt");
  addnotetrack_fxontag("fxanim_props", "debris_sm_02", "debris_hit_sm", "small_drone_bits_impact", "debris_sm_02_jnt");
  addnotetrack_fxontag("fxanim_props", "debris_sm_03", "debris_hit_sm", "small_drone_bits_impact", "debris_sm_03_jnt");
  addnotetrack_level_notify("fxanim_props", "exploder 10630 #f35_hits_walkway", "f35_walkway_start", "f35_la_plaza_crash");
  addnotetrack_level_notify("fxanim_props", "exploder 10631 #f35_hits_ground", "f35_env_start", "f35_la_plaza_crash");
  addnotetrack_level_notify("fxanim_props", "exploder 10632 #f35_hits_tower_01", "f35_tower_01_start", "f35_la_plaza_crash");
  addnotetrack_level_notify("fxanim_props", "exploder 10633 #f35_hits_tower_02", "f35_tower_02_start", "f35_la_plaza_crash");
  addnotetrack_level_notify("fxanim_props", "exploder 10634 #f35_hits_column", "f35_column_start", "f35_la_plaza_crash");
  addnotetrack_fxontag("fxanim_props", "f35_la_plaza_crash", "exploder 10631 #f35_hits_ground", "f38crash_slide", "tag_gear");
  addnotetrack_customfunction("fxanim_props", undefined, maps\la_plaza::f35_crash_fx, "f35_la_plaza_crash");
  addnotetrack_fxontag("fxanim_props", "alley_power_pole", "exploder 10522 #transformer01_breaks_off", "elec_transformer01_exp", "tag_transformer01_jnt");
  addnotetrack_fxontag("fxanim_props", "alley_power_pole", "exploder 10523 #transformer02_sparks", "elec_transformer02_exp", "tag_transformer02_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10782 #bottom_chunks_break", "building_collapse_chunk_debris", "tag_chunk01_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10782 #bottom_chunks_break", "la_building_debris_dust_trail", "chunk04_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10783 #back_chunks_break", "building_collapse_chunk_debris", "tag_chunk02_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10783 #back_chunks_break", "la_building_debris_dust_trail", "chunk06_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10783 #back_chunks_break", "la_building_debris_dust_trail", "chunk07_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10783 #back_chunks_break", "la_building_debris_dust_trail", "chunk08_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10784 #front_chunks_break", "building_collapse_chunk_debris", "tag_chunk03_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10785 #front_top_chunk_break", "building_collapse_chunk_debris", "tag_chunk04_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10785 #front_top_chunk_break", "la_building_debris_dust_trail", "chunk18_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10786 #top_chunk_break", "building_collapse_chunk_debris", "tag_chunk05_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10786 #top_chunk_break", "building_collapse_chunk_debris", "tag_chunk06_jnt");
  addnotetrack_fxontag("fxanim_props", "skyscraper02", "exploder 10786 #top_chunk_break", "la_building_debris_dust_trail", "chunk09_jnt");
}

precache_createfx_fx() {
  level._effect["fx_lf_la_sun1"] = loadfx("lens_flares/fx_lf_la_sun2_flight");
  level._effect["fx_ce_bdog_grenade_exp"] = loadfx("explosions/fx_grenadeexp_blacktop");
  level._effect["fx_elec_transformer_exp_lg_os"] = loadfx("electrical/fx_elec_transformer_exp_lg_os");
  level._effect["fx_la_elec_live_wire_long"] = loadfx("electrical/fx_la_elec_live_wire_long");
  level._effect["fx_la_elec_live_wire_arc"] = loadfx("electrical/fx_la_elec_live_wire_arc");
  level._effect["fx_la_elec_live_wire_arc_angled"] = loadfx("electrical/fx_la_elec_live_wire_arc_angled");
  level._effect["fx_drone_wall_impact"] = loadfx("impacts/fx_drone_wall_impact");
  level._effect["fx_fa38_bridge_crash"] = loadfx("maps/la/fx_fa38_bridge_crash");
  level._effect["fx_fa38_ground_impact"] = loadfx("maps/la/fx_fa38_ground_impact");
  level._effect["fx_fa38_plane_slide_stop_dust"] = loadfx("maps/la/fx_fa38_plane_slide_stop_dust");
  level._effect["fx_la1_f38_cockpit_fire"] = loadfx("maps/la/fx_la1_f38_cockpit_fire");
  level._effect["fx_spire_collapse_base"] = loadfx("maps/la/fx_spire_collapse_base");
  level._effect["fx_la_exp_drone_building_impact"] = loadfx("explosions/fx_la_exp_drone_building_impact");
  level._effect["fx_la_exp_drone_building_secondary"] = loadfx("explosions/fx_la_exp_drone_building_secondary");
  level._effect["fx_la_exp_drone_building_exit"] = loadfx("explosions/fx_la_exp_drone_building_exit");
  level._effect["fx_building_collapse_dust_unsettle"] = loadfx("maps/la/fx_building_collapse_dust_unsettle");
  level._effect["fx_building_collapse_crunch_debris_runner"] = loadfx("maps/la/fx_building_collapse_crunch_debris_runner");
  level._effect["fx_building_collapse_crunch_debris_runner_side"] = loadfx("maps/la/fx_building_collapse_crunch_debris_runner_side");
  level._effect["fx_building_collapse_aftermath"] = loadfx("maps/la/fx_building_collapse_base_dust");
  level._effect["fx_building_collapse_rolling_dust"] = loadfx("maps/la/fx_building_collapse_rolling_dust");
  level._effect["fx_la1b_smk_signal"] = loadfx("smoke/fx_la1b_smk_signal");
  level._effect["fx_concrete_crumble_area_sm"] = loadfx("dirt/fx_concrete_crumble_area_sm");
  level._effect["fx_la_overpass_debris_area_md_line"] = loadfx("maps/la/fx_la_overpass_debris_area_md_line");
  level._effect["fx_la_overpass_debris_area_md_line_wide"] = loadfx("maps/la/fx_la_overpass_debris_area_md_line_wide");
  level._effect["fx_dust_crumble_sm_runner"] = loadfx("dirt/fx_dust_crumble_sm_runner");
  level._effect["fx_dust_crumble_md_runner"] = loadfx("dirt/fx_dust_crumble_md_runner");
  level._effect["fx_embers_falling_sm"] = loadfx("env/fire/fx_embers_falling_sm");
  level._effect["fx_embers_falling_md"] = loadfx("env/fire/fx_embers_falling_md");
  level._effect["fx_paper_windy_slow"] = loadfx("debris/fx_paper_windy_slow");
  level._effect["fx_fire_fuel_xsm"] = loadfx("fire/fx_fire_fuel_xsm");
  level._effect["fx_fire_fuel_sm"] = loadfx("fire/fx_fire_fuel_sm");
  level._effect["fx_fire_fuel_sm_smolder"] = loadfx("fire/fx_fire_fuel_sm_smolder");
  level._effect["fx_fire_fuel_sm_smoke"] = loadfx("fire/fx_fire_fuel_sm_smoke");
  level._effect["fx_fire_fuel_sm_line"] = loadfx("fire/fx_fire_fuel_sm_line");
  level._effect["fx_fire_fuel_sm_ground"] = loadfx("fire/fx_fire_fuel_sm_ground");
  level._effect["fx_fire_line_md"] = loadfx("env/fire/fx_fire_line_md");
  level._effect["fx_fire_sm_smolder"] = loadfx("env/fire/fx_fire_sm_smolder");
  level._effect["fx_debris_papers_fall_burning_xlg"] = loadfx("debris/fx_paper_burning_ash_falling_xlg");
  level._effect["fx_smk_fire_xlg_black_dist"] = loadfx("smoke/fx_smk_fire_xlg_black_dist");
  level._effect["fx_smk_battle_lg_gray_slow"] = loadfx("smoke/fx_smk_battle_lg_gray_slow");
  level._effect["fx_smk_smolder_gray_fast"] = loadfx("smoke/fx_smk_smolder_gray_fast");
  level._effect["fx_smk_smolder_gray_slow"] = loadfx("smoke/fx_smk_smolder_gray_slow");
  level._effect["fx_smk_smolder_rubble_lg"] = loadfx("smoke/fx_smk_smolder_rubble_lg");
  level._effect["fx_smk_smolder_rubble_xlg"] = loadfx("smoke/fx_smk_smolder_rubble_xlg");
  level._effect["fx_smk_fire_lg_black"] = loadfx("smoke/fx_smk_fire_lg_black");
  level._effect["fx_smk_fire_lg_white"] = loadfx("smoke/fx_smk_fire_lg_white");
  level._effect["fx_la1b_smk_bldg_med_near"] = loadfx("smoke/fx_la1b_smk_bldg_med_near");
  level._effect["fx_smk_bldg_xlg_dist_dark"] = loadfx("smoke/fx_smk_bldg_xlg_dist_dark");
  level._effect["fx_smk_field_room_md"] = loadfx("smoke/fx_smk_field_room_md");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_linger_lit_z"] = loadfx("smoke/fx_smk_linger_lit_z");
  level._effect["fx_fire_bldg_lg_dist"] = loadfx("fire/fx_fire_bldg_lg_dist");
  level._effect["fx_smk_bldg_lg_dist_dark"] = loadfx("smoke/fx_smk_bldg_lg_dist_dark");
  level._effect["fx_fire_bldg_xlg_dist"] = loadfx("fire/fx_fire_bldg_xlg_dist");
  level._effect["fx_smk_bldg_xlg_dist"] = loadfx("smoke/fx_smk_bldg_xlg_dist");
  level._effect["fx_fire_bldg_xxlg_dist"] = loadfx("fire/fx_fire_bldg_xxlg_dist");
  level._effect["fx_fire_bldg_xxlg_dist_tall"] = loadfx("fire/fx_fire_bldg_xxlg_dist_tall");
  level._effect["fx_smk_bldg_xxlg_dist_tall"] = loadfx("smoke/fx_smk_bldg_xxlg_dist_tall");
  level._effect["fx_elec_transformer_sparks_runner"] = loadfx("electrical/fx_elec_transformer_sparks_runner");
  level._effect["fx_elec_burst_shower_sm_runner"] = loadfx("env/electrical/fx_elec_burst_shower_sm_runner");
  level._effect["fx_elec_burst_shower_lg_runner"] = loadfx("env/electrical/fx_elec_burst_shower_lg_runner");
  level._effect["fx_la2_elec_burst_xlg_runner"] = loadfx("env/electrical/fx_la2_elec_burst_xlg_runner");
  level._effect["fx_la_road_flare"] = loadfx("light/fx_la_road_flare");
  level._effect["fx_la_building_rocket_hit"] = loadfx("maps/la/fx_la_building_rocket_hit");
  level._effect["fx_la_aerial_dog_fight_runner"] = loadfx("maps/la/fx_la_aerial_dog_fight_runner");
  level._effect["fx_la_aerial_straight_runner"] = loadfx("maps/la/fx_la_aerial_straight_runner");
  level._effect["fx_la1_f38_swarm"] = loadfx("maps/la/fx_la1_f38_swarm");
  level._effect["fx_water_fire_sprinkler_dribble"] = loadfx("water/fx_water_fire_sprinkler_dribble");
  level._effect["fx_water_fire_sprinkler_dribble_spatter"] = loadfx("water/fx_water_fire_sprinkler_dribble_spatter");
  level._effect["fx_water_spill_sm_splash"] = loadfx("water/fx_water_spill_sm_splash");
  level._effect["fx_light_recessed"] = loadfx("light/fx_light_recessed");
  level._effect["fx_water_pipe_broken_gush"] = loadfx("water/fx_water_pipe_broken_gush");
  level._effect["fx_dust_kickup_md_runner"] = loadfx("dirt/fx_dust_kickup_md_runner");
  level._effect["fx_dust_kickup_sm_runner"] = loadfx("dirt/fx_dust_kickup_sm_runner");
  level._effect["fx_water_splash_detail"] = loadfx("water/fx_water_splash_detail_md");
  level._effect["fx_la1b_cougar_intro_sparks"] = loadfx("maps/la/fx_la1b_cougar_intro_sparks");
  level._effect["fx_light_dust_motes_xsm_short"] = loadfx("light/fx_light_dust_motes_xsm_short");
  level._effect["fx_light_dust_motes_xsm_wide"] = loadfx("light/fx_light_dust_motes_xsm_wide");
}

wind_initial_setting() {
  setsaveddvar("wind_global_vector", "155 -84 0");
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
  maps\createfx\la_1b_fx::main();
  wind_initial_setting();
}

#using_animtree("animated_props");

createfx_setup() {
  m_cougar_crawl = spawn("script_model", (0, 0, 0));
  m_cougar_crawl setmodel("veh_t6_mil_cougar_destroyed");
  animation = % v_la_03_01_cougarcrawl_cougar;
  s_align = get_struct("align_cougar_crawl");
  m_cougar_crawl.origin = getstartorigin(s_align.origin, (0, 0, 0), animation);
  m_cougar_crawl.angles = getstartangles(s_align.origin, (0, 0, 0), animation);
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_dust");
}