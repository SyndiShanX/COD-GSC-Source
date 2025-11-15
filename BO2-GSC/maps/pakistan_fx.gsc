/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\pakistan_fx;

main() {
  initmodelanims();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  footsteps();
  set_createfx_water_dvars_street();
  maps\createfx\pakistan_fx::main();
}

precache_scripted_fx() {
  level._effect["data_glove_glow"] = loadfx("light/fx_la_data_glove_glow");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["intro_claw_muzzle_flash"] = loadfx("maps/pakistan/fx_pak_claw_muzzleflash_intro");
  level._effect["intro_blood_single"] = loadfx("maps/la/fx_la_policeman_death_intro");
  level._effect["water_loop"] = loadfx("water/fx_water_pak_player_wake");
  level._effect["helicopter_drone_spotlight"] = loadfx("light/fx_vlight_firescout_spotlight");
  level._effect["helicopter_drone_spotlight_targeting"] = loadfx("light/fx_vlight_firescout_spotlight_targeting");
  level._effect["helicopter_drone_spotlight_cheap"] = loadfx("light/fx_vlight_firescout_spotlight_cheap");
  level._effect["frogger_car_interior_light"] = loadfx("light/fx_vlight_dome_civ_car_hatch");
  level._effect["cutter_on"] = loadfx("props/fx_laser_cutter_on");
  level._effect["cutter_spark"] = loadfx("props/fx_laser_cutter_sparking");
  level._effect["civ_bus_headlights"] = loadfx("light/fx_pak_vlight_civ_bus_headlights");
  level._effect["pak_bus_dam_pole_scrape"] = loadfx("maps/pakistan/fx_pak_bus_dam_pole_scrape");
  level._effect["drone_lens_flare"] = loadfx("lens_flares/fx_lf_pakistan_searchlight2");
  level._effect["claw_bootup"] = loadfx("maps/pakistan/fx_claw_intro_bootup");
  level._effect["claw_bootup_leg"] = loadfx("maps/pakistan/fx_claw_intro_bootup_leg");
}

play_water_fx() {
  n_client_flag = 4;
  self setclientflag(n_client_flag);
  self waittill("death");

  if(isDefined(self))
    self clearclientflag(n_client_flag);
}

precache_createfx_fx() {
  level._effect["fx_pak_exp_door_breach_intro"] = loadfx("explosions/fx_pak_exp_door_breach_intro");
  level._effect["fx_pak_smk_breach_intro"] = loadfx("smoke/fx_pak_smk_breach_intro");
  level._effect["fx_claw_intro_bootup_water_splash"] = loadfx("maps/pakistan/fx_claw_intro_bootup_water_splash");
  level._effect["fx_market_ceiling_collapse"] = loadfx("maps/pakistan/fx_market_ceiling_collapse");
  level._effect["fx_market_ceiling_water_impact"] = loadfx("maps/pakistan/fx_market_ceiling_water_impact");
  level._effect["fx_car_smash_impact"] = loadfx("maps/pakistan/fx_car_smash_impact");
  level._effect["fx_bus_smash_impact_column"] = loadfx("maps/pakistan/fx_bus_smash_impact_column");
  level._effect["fx_bus_smash_impact_column_splash"] = loadfx("maps/pakistan/fx_bus_smash_impact_column_splash");
  level._effect["fx_bus_smash_impact"] = loadfx("maps/pakistan/fx_bus_smash_impact");
  level._effect["fx_bus_wall_collapse"] = loadfx("maps/pakistan/fx_bus_wall_collapse");
  level._effect["fx_pak_bus_dam_pole_splash"] = loadfx("maps/pakistan/fx_pak_bus_dam_pole_splash");
  level._effect["fx_pak_bus_dam_bus_splash_1"] = loadfx("maps/pakistan/fx_pak_bus_dam_bus_splash_1");
  level._effect["fx_pak_water_splash_area_sm"] = loadfx("water/fx_pak_water_splash_area_sm");
  level._effect["fx_pak_archway_stone_crumble"] = loadfx("dirt/fx_pak_archway_stone_crumble");
  level._effect["fx_pak_water_stone_splash_sm"] = loadfx("water/fx_pak_water_stone_splash_sm");
  level._effect["fx_archway_collapse"] = loadfx("maps/pakistan/fx_archway_collapse");
  level._effect["fx_elec_transformer_exp_lg_os"] = loadfx("electrical/fx_elec_transformer_exp_lg_os");
  level._effect["fx_pak_water_gush_over_bus"] = loadfx("water/fx_pak_water_gush_over_bus");
  level._effect["fx_car_smash_corner_impact"] = loadfx("maps/pakistan/fx_car_smash_corner_impact");
  level._effect["fx_pak_concrete_pillar_crumble"] = loadfx("dirt/fx_pak_concrete_pillar_crumble");
  level._effect["fx_balcony_collapse_wood"] = loadfx("maps/pakistan/fx_pak1_balcony_collapse_wood");
  level._effect["fx_pak_light_glow_sign_kashmir"] = loadfx("light/fx_pak_light_glow_sign_kashmir");
  level._effect["fx_sign_kashmir_sparks_01"] = loadfx("maps/pakistan/fx_sign_kashmir_sparks_01");
  level._effect["fx_sign_kashmir_sparks_02"] = loadfx("maps/pakistan/fx_sign_kashmir_sparks_02");
  level._effect["fx_sign_dangle_break"] = loadfx("maps/pakistan/fx_sign_dangle_break");
  level._effect["fx_bank_wall_collapse"] = loadfx("maps/pakistan/fx_bank_wall_collapse");
  level._effect["fx_bank_wall_collapse_splash"] = loadfx("maps/pakistan/fx_bank_wall_collapse_splash");
  level._effect["fx_bank_wall_collapse_spark"] = loadfx("maps/pakistan/fx_bank_wall_collapse_spark");
  level._effect["fx_pak_dest_shelving_unit"] = loadfx("destructibles/fx_pak_dest_shelving_unit");
  level._effect["fx_rain_light_loop"] = loadfx("weather/fx_rain_light_loop");
  level._effect["fx_water_pipe_spill_sm_thin_short"] = loadfx("water/fx_water_pipe_spill_sm_thin_short");
  level._effect["fx_water_pipe_spill_sm_thin_tall"] = loadfx("water/fx_water_pipe_spill_sm_thin_tall");
  level._effect["fx_water_spill_sm"] = loadfx("water/fx_water_spill_sm");
  level._effect["fx_water_spill_sm_splash"] = loadfx("water/fx_water_spill_sm_splash");
  level._effect["fx_water_roof_spill_sm"] = loadfx("water/fx_water_roof_spill_sm");
  level._effect["fx_water_roof_spill_md"] = loadfx("water/fx_water_roof_spill_md");
  level._effect["fx_water_roof_spill_lg"] = loadfx("water/fx_water_roof_spill_lg");
  level._effect["fx_rain_spatter_06x30"] = loadfx("water/fx_rain_spatter_06x30");
  level._effect["fx_rain_spatter_06x60"] = loadfx("water/fx_rain_spatter_06x60");
  level._effect["fx_rain_spatter_06x120"] = loadfx("water/fx_rain_spatter_06x120");
  level._effect["fx_rain_spatter_06x200"] = loadfx("water/fx_rain_spatter_06x200");
  level._effect["fx_rain_spatter_06x300"] = loadfx("water/fx_rain_spatter_06x300");
  level._effect["fx_rain_spatter_25x25"] = loadfx("water/fx_rain_spatter_25x25");
  level._effect["fx_rain_spatter_25x50"] = loadfx("water/fx_rain_spatter_25x50");
  level._effect["fx_rain_spatter_25x120"] = loadfx("water/fx_rain_spatter_25x120");
  level._effect["fx_rain_spatter_50x50"] = loadfx("water/fx_rain_spatter_50x50");
  level._effect["fx_rain_spatter_50x120"] = loadfx("water/fx_rain_spatter_50x120");
  level._effect["fx_rain_spatter_50x200"] = loadfx("water/fx_rain_spatter_50x200");
  level._effect["fx_pak_water_pipe_spill_wake"] = loadfx("water/fx_pak_water_pipe_spill_wake");
  level._effect["fx_water_spill_splash_wide"] = loadfx("water/fx_water_spill_splash_wide");
  level._effect["fx_water_drips_light_30_long"] = loadfx("water/fx_water_drips_light_30_long");
  level._effect["fx_water_drips_hvy_30"] = loadfx("water/fx_water_drips_hvy_30");
  level._effect["fx_water_drips_hvy_120"] = loadfx("water/fx_water_drips_hvy_120");
  level._effect["fx_water_drips_hvy_120_tall"] = loadfx("water/fx_water_drips_hvy_120_tall");
  level._effect["fx_water_drips_hvy_200"] = loadfx("water/fx_water_drips_hvy_200");
  level._effect["fx_water_drips_hvy_200_tall"] = loadfx("water/fx_water_drips_hvy_200_tall");
  level._effect["fx_pak_water_froth_md_calm"] = loadfx("water/fx_pak_water_froth_md_calm");
  level._effect["fx_pak_water_froth_sm_front"] = loadfx("water/fx_pak_water_froth_sm_front");
  level._effect["fx_pak_water_froth_pole"] = loadfx("water/fx_pak_water_froth_pole");
  level._effect["fx_pak_water_froth_left_calm"] = loadfx("water/fx_pak_water_froth_left_calm");
  level._effect["fx_pak_water_froth_left_calm_sm"] = loadfx("water/fx_pak_water_froth_left_calm_sm");
  level._effect["fx_pak_water_froth_right_calm"] = loadfx("water/fx_pak_water_froth_right_calm");
  level._effect["fx_pak_water_froth_right_calm_sm"] = loadfx("water/fx_pak_water_froth_right_calm_sm");
  level._effect["fx_pak_water_froth_pole_calm"] = loadfx("water/fx_pak_water_froth_pole_calm");
  level._effect["fx_pak_water_froth_column_calm"] = loadfx("water/fx_pak_water_froth_column_calm");
  level._effect["fx_drain_pipes_flow"] = loadfx("maps/pakistan/fx_drain_pipes_flow");
  level._effect["fx_drain_pipes_splash"] = loadfx("maps/pakistan/fx_drain_pipes_splash");
  level._effect["fx_pak_water_slide_base_splash"] = loadfx("water/fx_pak_water_slide_base_splash");
  level._effect["fx_water_drips_light_120_w_splash"] = loadfx("water/fx_water_drips_light_120_w_splash");
  level._effect["fx_pak_sewer_drain_splash_thin"] = loadfx("water/fx_pak_sewer_drain_splash_thin");
  level._effect["fx_water_debris_dist"] = loadfx("maps/pakistan/fx_water_debris_dist");
  level._effect["fx_pak_light_overhead"] = loadfx("light/fx_pak_light_overhead");
  level._effect["fx_pak_light_overhead_blink"] = loadfx("light/fx_pak_light_overhead_blink");
  level._effect["fx_pak_light_overhead_rain"] = loadfx("light/fx_pak_light_overhead_rain");
  level._effect["fx_pak_light_overhead_rain_top"] = loadfx("light/fx_pak_light_overhead_rain_top");
  level._effect["fx_pak_light_single_thick"] = loadfx("light/fx_pak_light_single_thick");
  level._effect["fx_pak_light_ray_street_rain"] = loadfx("light/fx_pak_light_ray_street_rain");
  level._effect["fx_pak_light_square_flood"] = loadfx("light/fx_pak_light_square_flood");
  level._effect["fx_pak_light_glow_sign_red"] = loadfx("light/fx_pak_light_glow_sign_red");
  level._effect["fx_pak_light_glow_sign_red_wide"] = loadfx("light/fx_pak_light_glow_sign_red_wide");
  level._effect["fx_pak_light_glow_sign_white"] = loadfx("light/fx_pak_light_glow_sign_white");
  level._effect["fx_pak_light_glow_sign_white_wide"] = loadfx("light/fx_pak_light_glow_sign_white_wide");
  level._effect["fx_pak_light_glow_sign_white_lg"] = loadfx("light/fx_pak_light_glow_sign_white_lg");
  level._effect["fx_pak_light_window_glow"] = loadfx("light/fx_pak_light_window_glow");
  level._effect["fx_pak_light_fluorescent"] = loadfx("light/fx_pak_light_fluorescent");
  level._effect["fx_pak_light_fluorescent_cage"] = loadfx("light/fx_pak_light_fluorescent_cage");
  level._effect["fx_pak_light_fluorescent_double"] = loadfx("light/fx_pak_light_fluorescent_double");
  level._effect["fx_pak_light_fluorescent_double_flare"] = loadfx("light/fx_pak_light_fluorescent_double_flare");
  level._effect["fx_pak_light_fluorescent_ceiling_panel"] = loadfx("light/fx_pak_light_fluorescent_ceiling_panel");
  level._effect["fx_pak_light_overhead_warm"] = loadfx("light/fx_pak_light_overhead_warm");
  level._effect["fx_pak_light_overhead_warm_blink"] = loadfx("light/fx_pak_light_overhead_warm_blink");
  level._effect["fx_pak_light_glow_sign_drugs"] = loadfx("light/fx_pak_light_glow_sign_drugs");
  level._effect["fx_light_recessed"] = loadfx("light/fx_light_recessed");
  level._effect["fx_pak_light_emergency_flood"] = loadfx("light/fx_pak_light_emergency_flood");
  level._effect["fx_pak_vlight_car_bank"] = loadfx("light/fx_pak_vlight_car_bank");
  level._effect["fx_pak_light_ray_grate_warm"] = loadfx("light/fx_pak_light_ray_grate_warm");
  level._effect["fx_light_dust_motes_sm"] = loadfx("light/fx_light_dust_motes_sm");
  level._effect["fx_light_dust_motes_xsm_short"] = loadfx("light/fx_light_dust_motes_xsm_short");
  level._effect["fx_light_dust_motes_xsm_wide"] = loadfx("light/fx_light_dust_motes_xsm_wide");
  level._effect["fx_pak_light_wall_cage"] = loadfx("light/fx_pak_light_wall_cage");
  level._effect["fx_pak_vlight_car_bank_rain"] = loadfx("light/fx_pak_vlight_car_bank_rain");
  level._effect["fx_pak_light_glow_sign_hotel"] = loadfx("light/fx_pak_light_glow_sign_hotel");
  level._effect["fx_pak_light_ray_md"] = loadfx("light/fx_pak_light_ray_md");
  level._effect["fx_pak_light_ray_md_streak"] = loadfx("light/fx_pak_light_ray_md_streak");
  level._effect["fx_insects_fly_swarm"] = loadfx("bio/insects/fx_insects_fly_swarm");
  level._effect["fx_pak_debri_papers"] = loadfx("debris/fx_paper_falling");
  level._effect["fx_elec_transformer_sparks_runner"] = loadfx("electrical/fx_elec_transformer_sparks_runner");
  level._effect["fx_pak_fog_low"] = loadfx("fog/fx_pak_fog_low");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_linger_lit_slow"] = loadfx("smoke/fx_smk_linger_lit_slow");
  level._effect["fx_smk_tin_hat_sm"] = loadfx("smoke/fx_smk_tin_hat_sm");
}

wind_init() {
  setsaveddvar("wind_global_vector", "-145 -110 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

footsteps() {
}

#using_animtree("fxanim_props");
#using_animtree("animated_props");
#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["market_car_crash"] = % fxanim_pak_market_car_crash_anim;
  level.scr_anim["fxanim_props"]["market_bus_crash"] = % fxanim_pak_market_bus_crash_anim;
  level.scr_anim["fxanim_props"]["bus_dam_1st_hit"] = % fxanim_pak_bus_dam_1st_hit_anim;
  level.scr_anim["fxanim_props"]["bus_dam_wedge_wall"] = % fxanim_pak_bus_dam_wedge_wall_anim;
  level.scr_anim["fxanim_props"]["bus_dam_wedge_wall2"] = % fxanim_pak_bus_dam_wedge_wall2_anim;
  level.scr_anim["fxanim_props"]["bus_dam_wedge_wall3"] = % fxanim_pak_bus_dam_wedge_wall3_anim;
  level.scr_anim["fxanim_props"]["bus_dam_break_wall"] = % fxanim_pak_bus_dam_break_wall_anim;
  level.scr_anim["fxanim_props"]["bus_dam_collapse_wall"] = % fxanim_pak_bus_dam_break_wall_collapse_anim;
  level.scr_anim["fxanim_props"]["bus_dam_fence"] = % fxanim_pak_bus_dam_fence_collapse_anim;
  level.scr_anim["fxanim_props"]["break_wall_crumble"] = % fxanim_pak_bus_dam_break_wall_crumble_anim;
  level.scr_anim["fxanim_props"]["sign_dangle_start_loop"] = % fxanim_pak_sign_dangle_start_loop_anim;
  level.scr_anim["fxanim_props"]["sign_dangle_end_loop"] = % fxanim_pak_sign_dangle_end_loop_anim;
  level.scr_anim["fxanim_props"]["sign_dangle_break"] = % fxanim_pak_sign_dangle_break_anim;
  level.scr_anim["fxanim_props"]["kashmir_sign_break"] = % fxanim_pak_sign_kashmir_break_anim;
  level.scr_anim["fxanim_props"]["kashmir_sign_loop"] = % fxanim_pak_sign_kashmir_loop_anim;
  level.scr_anim["fxanim_props"]["awning_fast"] = % fxanim_gp_awning_store_mideast_fast_anim;
  level.scr_anim["fxanim_props"]["awning_med_fast"] = % fxanim_gp_awning_store_mideast_med_fast_anim;
  level.scr_anim["fxanim_props"]["market_ceiling_01"] = % fxanim_pak_market_ceiling_01_anim;
  level.scr_anim["fxanim_props"]["market_ceiling_02"] = % fxanim_pak_market_ceiling_02_anim;
  level.scr_anim["fxanim_props"]["car_corner_crash"] = % fxanim_pak_car_corner_bldg_anim;
  level.scr_anim["fxanim_props"]["shelving_dest01"] = % fxanim_gp_shelving_unit_dest01_anim;
  level.scr_anim["fxanim_props"]["shelving_dest02"] = % fxanim_gp_shelving_unit_dest02_anim;
  level.scr_anim["fxanim_props"]["power_pole_break"] = % fxanim_pak_power_pole_anim;
  level.scr_anim["fxanim_props"]["market_bus_crash_bus"] = % fxanim_pak_market_bus_crash_bus_anim;
  level.scr_anim["fxanim_props"]["market_car_crash_car"] = % fxanim_pak_market_car_crash_car_anim;
  level.scr_anim["fxanim_props"]["market_car_crash_idle"] = % fxanim_pak_market_car_crash_idle_anim;
  level.scr_anim["fxanim_props"]["market_bus_crash_car"] = % fxanim_pak_market_bus_crash_car_anim;
  level.scr_anim["fxanim_props"]["bus_dam_start"] = % fxanim_pak_bus_dam_enter_bus_anim;
  level.scr_anim["fxanim_props"]["bus_dam_idle"] = % fxanim_pak_bus_dam_idle_bus_anim;
  level.scr_anim["fxanim_props"]["bus_dam_exit"] = % fxanim_pak_bus_dam_exit_bus_anim;
  level.scr_anim["fxanim_props"]["balcony_collapse"] = % fxanim_pak_balcony_collapse_anim;
  level.scr_anim["fxanim_props"]["market_bus_shelf_01"] = % fxanim_pak_market_bus_shelf_01_anim;
  level.scr_anim["fxanim_props"]["market_bus_shelf_02"] = % fxanim_pak_market_bus_shelf_02_anim;
  level.scr_anim["fxanim_props"]["market_bus_shelf_03"] = % fxanim_pak_market_bus_shelf_03_anim;
  level.scr_anim["fxanim_props"]["market_bus_shelf_04"] = % fxanim_pak_market_bus_shelf_04_anim;
  level.scr_anim["fxanim_props"]["sheet_med01"] = % fxanim_gp_cloth_sheet_med_anim;
  level.scr_anim["fxanim_props"]["bank_collapse"] = % fxanim_pak_bank_collapse_anim;
  level.scr_anim["fxanim_props"]["rat_alley01"] = % fxanim_pak_rat_alley01_anim;
  level.scr_anim["fxanim_props"]["rat_alley02"] = % fxanim_pak_rat_alley02_anim;
  level.scr_anim["fxanim_props"]["rat_alley03"] = % fxanim_pak_rat_alley03_anim;
  level.scr_anim["fxanim_props"]["rat_box"] = % fxanim_pak_rat_boxes_anim;
  level.scr_anim["fxanim_props"]["rat_sewer01"] = % fxanim_pak_rat_sewer01_anim;
  level.scr_anim["fxanim_props"]["rat_sewer02"] = % fxanim_pak_rat_sewer02_anim;
  level.scr_anim["fxanim_props"]["rat_sewer03"] = % fxanim_pak_rat_sewer03_anim;
  level.scr_anim["fxanim_props"]["rat_sewer04"] = % fxanim_pak_rat_sewer04_anim;
  level.scr_anim["fxanim_props"]["rat_sewer05"] = % fxanim_pak_rat_sewer05_anim;
  level.scr_anim["fxanim_props"]["rat_sewer06"] = % fxanim_pak_rat_sewer06_anim;
  level.scr_anim["fxanim_props"]["rat_sewer07"] = % fxanim_pak_rat_sewer07_anim;
  addnotetrack_stop_exploder("fxanim_props", "exploder 10240 #kashmir_spark_01", 240);
}

set_createfx_water_dvars_street() {
  setdvar("r_waterwavespeed", "1.092 1.060 1.085 1.045");
  setdvar("r_waterwaveamplitude", "3.0 1.25 2.69307 2.95");
  setdvar("r_waterwavewavelength", "111.9 77 187.6 245");
  setdvar("r_waterwaveangle", "70.6 46.9 117.1 179.67");
  setdvar("r_waterwavephase", "0 0 0 0");
  setdvar("r_waterwavesteepness", "1 1 1 1");
  setdvar("r_waterwavebase", "12");
}