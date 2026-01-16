/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_1b_fx.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\la_1b_fx;
#include clientscripts\_fx;

precache_util_fx() {
}

precache_scripted_fx() {
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

main() {
  clientscripts\createfx\la_1b_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_util_fx();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}