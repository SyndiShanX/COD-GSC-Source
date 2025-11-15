/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\nicaragua_fx;
#include maps\nicaragua_mason_to_mission;

main() {
  level thread precache_fxanim_props();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  maps\createfx\nicaragua_fx::main();
}

precache_scripted_fx() {
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["sprint_blur"] = loadfx("maps/nicaragua/fx_rage_sprint_speed");
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["intro_cartel_blood"] = loadfx("maps/nicaragua/fx_intro_head_shot");
  level._effect["neck_stab_blood"] = loadfx("maps/nicaragua/fx_impact_neck_stab_glass");
  level._effect["neck_stab_glass"] = loadfx("maps/nicaragua/fx_neck_stab_glass_blood");
  level._effect["fire_ai_torso"] = loadfx("fire/fx_fire_ai_torso");
  level._effect["fire_ai_leg_left"] = loadfx("fire/fx_fire_ai_leg_left");
  level._effect["fire_ai_leg_right"] = loadfx("fire/fx_fire_ai_leg_right");
  level._effect["fire_ai_arm_left"] = loadfx("fire/fx_fire_ai_arm_left");
  level._effect["fire_ai_arm_right"] = loadfx("fire/fx_fire_ai_arm_right");
  level._effect["flesh_hit_shotgun_chest"] = loadfx("maps/nicaragua/fx_flesh_hit_shotgun_chest");
  level._effect["flesh_hit_axe_chest"] = loadfx("maps/nicaragua/fx_flesh_hit_axe_chest");
  level._effect["rage_mode_blood"] = loadfx("maps/nicaragua/fx_flesh_hit_body_rage");
  level._effect["cocaine_powder"] = loadfx("destructibles/fx_dest_accessories_cocaine");
  level._effect["blood_water_surface"] = loadfx("blood/fx_nic_blood_water_surface");
  level._effect["nic_water_tower_spill"] = loadfx("water/fx_nic_water_tower_spill");
  level._effect["mortar_wick"] = loadfx("weapon/molotov/fx_molotov_wick_phase1");
  level._effect["fx_gas_can_spill"] = loadfx("maps/nicaragua/fx_gas_can_spill");
  level._effect["fx_paper_spill_os"] = loadfx("maps/nicaragua/fx_paper_spill_os");
  level._effect["fx_match_light_and_throw"] = loadfx("fire/fx_match_light_and_throw");
  level._effecttype["mason_intro_mortar"] = "mortar";
  level._effect["mason_intro_mortar"] = loadfx("explosions/fx_nic_exp_mortar_dirt");
  level._effecttype["mason_hill_wave2_mortar"] = "mortar";
  level._effect["mason_hill_wave2_mortar"] = loadfx("explosions/fx_nic_exp_mortar_dirt");
  level._effecttype["mason_hill_porchhouse_mortar"] = "mortar";
  level._effect["mason_hill_porchhouse_mortar"] = loadfx("explosions/fx_nic_exp_mortar_dirt");
  level._effecttype["mason_bunker_mortar"] = "mortar";
  level._effect["mason_bunker_mortar"] = loadfx("explosions/fx_nic_exp_mortar_dirt");
  level.mortar = loadfx("explosions/fx_nic_exp_mortar_dirt");
}

precache_createfx_fx() {
  level._effect["fx_lf_nicaragua_sun_mason"] = loadfx("lens_flares/fx_lf_nicaragua_sun");
  level._effect["fx_lf_nicaragua_sun_menendez"] = loadfx("lens_flares/fx_lf_nicaragua_sun_menendez");
  level._effect["fx_nic_light_sun_ray_intro"] = loadfx("light/fx_nic_light_sun_ray_intro");
  level._effect["fx_glass_impact_josefina"] = loadfx("maps/nicaragua/fx_glass_impact_josefina");
  level._effect["fx_nic_blood_splat_decal"] = loadfx("blood/fx_nic_blood_splat_decal");
  level._effect["fx_mud_splat_noriega_punch"] = loadfx("maps/nicaragua/fx_mud_splat_noriega_punch");
  level._effect["fx_impact_bridge_drop"] = loadfx("maps/nicaragua/fx_impact_bridge_drop");
  level._effect["fx_nic_fire_barn_backdraft"] = loadfx("fire/fx_nic_fire_barn_backdraft");
  level._effect["fx_stables_roof_collapse_wood"] = loadfx("maps/nicaragua/fx_stables_roof_collapse_wood");
  level._effect["fx_stables_roof_collapse_impact"] = loadfx("maps/nicaragua/fx_stables_roof_collapse_impact");
  level._effect["fx_stables_ammo_cookoff_runner"] = loadfx("maps/nicaragua/fx_stables_ammo_cookoff_runner");
  level._effect["fx_nic_exp_weapons_cache"] = loadfx("explosions/fx_nic_exp_weapons_cache");
  level._effect["fx_gate_crash"] = loadfx("maps/nicaragua/fx_gate_crash");
  level._effect["fx_nic_fire_wall_josefina"] = loadfx("fire/fx_nic_fire_wall_josefina");
  level._effect["fx_nic_fire_wall_josefina_md"] = loadfx("fire/fx_nic_fire_wall_josefina_md");
  level._effect["fx_nic_exp_grenade_shattered"] = loadfx("explosions/fx_nic_exp_grenade_shattered");
  level._effect["fx_nic_water_tower_spill_splash"] = loadfx("water/fx_nic_water_tower_spill_splash");
  level._effect["fx_nic_water_tower_splash_river"] = loadfx("water/fx_nic_water_tower_splash_river");
  level._effect["fx_exp_fountain"] = loadfx("maps/nicaragua/fx_exp_fountain");
  level._effect["fx_dest_archway_top"] = loadfx("maps/nicaragua/fx_dest_archway_top");
  level._effect["fx_dest_archway_ground_impact"] = loadfx("maps/nicaragua/fx_dest_archway_ground_impact");
  level._effect["fx_nic_exp_hut_core"] = loadfx("explosions/fx_nic_exp_hut_core");
  level._effect["fx_nic_exp_hut_up"] = loadfx("explosions/fx_nic_exp_hut_up");
  level._effect["fx_cocaine_cloud_linger"] = loadfx("maps/nicaragua/fx_cocaine_cloud_linger");
  level._effect["fx_nic_dust_ceiling_loose_os"] = loadfx("dirt/fx_nic_dust_ceiling_loose_os");
  level._effect["fx_nic_dust_ceiling_loose_lg_os"] = loadfx("dirt/fx_nic_dust_ceiling_loose_lg_os");
  level._effect["fx_door_breach"] = loadfx("props/fx_door_breach");
  level._effect["fx_match_throw"] = loadfx("maps/nicaragua/fx_match_throw");
  level._effect["fx_manila_folder_disintegrate"] = loadfx("maps/nicaragua/fx_manila_folder_disintegrate");
  level._effect["fx_nic_dust_scuffle_woods"] = loadfx("dirt/fx_nic_dust_scuffle_woods");
  level._effect["fx_nic_impact_head_scuffle_woods"] = loadfx("dirt/fx_nic_impact_head_scuffle_woods");
  level._effect["fx_rotorwash_littlebird_outro"] = loadfx("maps/nicaragua/fx_rotorwash_littlebird_outro");
  level._effect["fx_rotor_wash_dust_room_fill"] = loadfx("maps/nicaragua/fx_rotor_wash_dust_room_fill");
  level._effect["fx_fire_xsm"] = loadfx("fire/fx_nic_fire_xsm");
  level._effect["fx_fire_line_xsm"] = loadfx("fire/fx_nic_fire_line_xsm");
  level._effect["fx_fire_sm_smolder"] = loadfx("fire/fx_nic_fire_sm_smolder");
  level._effect["fx_fire_line_sm"] = loadfx("fire/fx_nic_fire_line_sm");
  level._effect["fx_fire_edge_windblown_md"] = loadfx("fire/fx_nic_fire_edge_windblown_md");
  level._effect["fx_fire_wall_wood_ext_md"] = loadfx("fire/fx_fire_wall_wood_ext_md");
  level._effect["fx_fire_wall_md"] = loadfx("env/fire/fx_fire_wall_md");
  level._effect["fx_fire_ceiling_md"] = loadfx("fire/fx_nic_fire_ceiling_md");
  level._effect["fx_ceiling_edge_md"] = loadfx("fire/fx_nic_fire_ceiling_edge_md");
  level._effect["fx_nic_fire_ceiling_edge_sm"] = loadfx("fire/fx_nic_fire_ceiling_edge_sm");
  level._effect["fx_nic_fire_building_md"] = loadfx("fire/fx_nic_fire_building_md");
  level._effect["fx_nic_fire_building_md_dist"] = loadfx("fire/fx_nic_fire_building_md_dist");
  level._effect["fx_fire_fireplace_md"] = loadfx("fire/fx_fire_fireplace_md");
  level._effect["fx_fire_wood_floor_int"] = loadfx("fire/fx_fire_wood_floor_int");
  level._effect["fx_fire_ceiling_rafter_lg"] = loadfx("fire/fx_nic_fire_ceiling_rafter_lg");
  level._effect["fx_fire_ceiling_rafter_md"] = loadfx("fire/fx_nic_fire_ceiling_rafter_md");
  level._effect["fx_fire_ceiling_rafter_md_long"] = loadfx("fire/fx_nic_fire_ceiling_rafter_md_long");
  level._effect["fx_fire_eaves_md"] = loadfx("fire/fx_nic_fire_eaves_md");
  level._effect["fx_fire_eaves_md_left"] = loadfx("fire/fx_nic_fire_eaves_md_left");
  level._effect["fx_fire_eaves_md_right"] = loadfx("fire/fx_nic_fire_eaves_md_right");
  level._effect["fx_fire_eaves_lg_left"] = loadfx("fire/fx_nic_fire_eaves_lg_left");
  level._effect["fx_fire_eaves_lg_right"] = loadfx("fire/fx_nic_fire_eaves_lg_right");
  level._effect["fx_fire_window_md_dist"] = loadfx("fire/fx_fire_window_md_dist");
  level._effect["fx_fire_line_xsm_pole"] = loadfx("fire/fx_nic_fire_line_xsm_pole");
  level._effect["fx_fire_line_sm_pole"] = loadfx("fire/fx_nic_fire_line_sm_pole");
  level._effect["fx_fire_pole_md_long"] = loadfx("fire/fx_nic_fire_pole_md_long");
  level._effect["fx_fire_smolder_area_sm"] = loadfx("fire/fx_fire_smolder_area_sm");
  level._effect["fx_smk_field_room_md_hvy"] = loadfx("smoke/fx_smk_field_room_md_hvy_dark");
  level._effect["fx_smk_hanging_interior_lg"] = loadfx("smoke/fx_smk_hanging_interior_lg");
  level._effect["fx_smk_hanging_interior_end"] = loadfx("smoke/fx_smk_hanging_interior_end");
  level._effect["fx_smk_wood_sm_black"] = loadfx("smoke/fx_smk_wood_sm_black");
  level._effect["fx_smk_wood_md"] = loadfx("smoke/fx_smk_wood_md_black");
  level._effect["fx_smk_wood_lg"] = loadfx("smoke/fx_smk_wood_lg_black");
  level._effect["fx_smk_fire_lg_black"] = loadfx("smoke/fx_smk_fire_lg_black");
  level._effect["fx_smk_plume_md_blk_wispy_dist_slow"] = loadfx("smoke/fx_smk_plume_md_blk_wispy_dist_slow");
  level._effect["fx_smk_plume_md_blk_wispy_dist"] = loadfx("smoke/fx_smk_plume_md_blk_wispy_dist");
  level._effect["fx_smk_smolder_rubble_md_int"] = loadfx("smoke/fx_smk_smolder_rubble_md_int");
  level._effect["fx_smk_ceiling_crawl"] = loadfx("smoke/fx_smk_ceiling_crawl");
  level._effect["fx_smk_ceiling_crawl_sm"] = loadfx("smoke/fx_smk_ceiling_crawl_sm");
  level._effect["fx_smk_ceiling_crawl_sm_straight"] = loadfx("smoke/fx_smk_ceiling_crawl_sm_straight");
  level._effect["fx_smk_hallway_md"] = loadfx("smoke/fx_smk_hallway_md_dark");
  level._effect["fx_smk_wood_wispy_lg_dark_dist"] = loadfx("smoke/fx_smk_wood_wispy_lg_dark_dist");
  level._effect["fx_nic_smk_plume_lg_gray_dark"] = loadfx("smoke/fx_nic_smk_plume_lg_gray_dark");
  level._effect["fx_nic_smk_dust_post_explosion"] = loadfx("smoke/fx_nic_smk_dust_post_explosion");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_linger_lit_slow"] = loadfx("smoke/fx_smk_linger_lit_slow");
  level._effect["fx_smk_linger_lit_slow_bright"] = loadfx("smoke/fx_smk_linger_lit_slow_bright");
  level._effect["fx_smk_linger_lit_z"] = loadfx("smoke/fx_smk_linger_lit_z");
  level._effect["fx_nic_smk_linger_lit_long"] = loadfx("smoke/fx_nic_smk_linger_lit_long");
  level._effect["fx_nic_smk_linger_lit_bright_lg"] = loadfx("smoke/fx_nic_smk_linger_lit_bright_lg");
  level._effect["fx_nic_fog_stream_low"] = loadfx("fog/fx_nic_fog_stream_low");
  level._effect["fx_fog_lg_rising_dist"] = loadfx("fog/fx_fog_lg_rising_dist");
  level._effect["fx_nic_waterfall_drop_md"] = loadfx("water/fx_nic_waterfall_drop_md");
  level._effect["fx_nic_waterfall_drop_sm"] = loadfx("water/fx_nic_waterfall_drop_sm");
  level._effect["fx_nic_waterfall_splash_rock_md_right"] = loadfx("water/fx_nic_waterfall_splash_rock_md_right");
  level._effect["fx_nic_waterfall_splash_bottom"] = loadfx("water/fx_nic_waterfall_splash_bottom");
  level._effect["fx_nic_tinhat_cage"] = loadfx("light/fx_nic_light_tinhat_cage");
  level._effect["fx_nic_light_fluorescent"] = loadfx("light/fx_nic_light_fluorescent");
  level._effect["fx_nic_sun_rays_post_explosion"] = loadfx("light/fx_nic_sun_rays_post_explosion");
  level._effect["fx_light_dust_motes_sm"] = loadfx("light/fx_light_dust_motes_sm");
  level._effect["fx_light_dust_motes_xsm_short"] = loadfx("light/fx_light_dust_motes_xsm_short");
  level._effect["fx_light_dust_motes_xsm_wide"] = loadfx("light/fx_light_dust_motes_xsm_wide");
  level._effect["fx_nic_light_sun_ray_double_md"] = loadfx("light/fx_nic_light_sun_ray_double_md");
  level._effect["fx_nic_light_sun_ray_lg"] = loadfx("light/fx_nic_light_sun_ray_lg");
  level._effect["fx_nic_light_sun_ray_lg_streak"] = loadfx("light/fx_nic_light_sun_ray_lg_streak");
  level._effect["fx_nic_light_sun_ray_lg_wide"] = loadfx("light/fx_nic_light_sun_ray_lg_wide");
  level._effect["fx_nic_light_sun_ray_lg_wide_streak"] = loadfx("light/fx_nic_light_sun_ray_lg_wide_streak");
  level._effect["fx_nic_light_sun_rays_stables"] = loadfx("light/fx_nic_light_sun_rays_stables");
  level._effect["fx_nic_light_sun_ray_md"] = loadfx("light/fx_nic_light_sun_ray_md");
  level._effect["fx_nic_light_sun_ray_md_wide_1s"] = loadfx("light/fx_nic_light_sun_ray_md_wide_1s");
  level._effect["fx_nic_light_sun_ray_md_1s"] = loadfx("light/fx_nic_light_sun_ray_md_1s");
  level._effect["fx_nic_light_sun_ray_md_short"] = loadfx("light/fx_nic_light_sun_ray_md_short");
  level._effect["fx_nic_light_sun_ray_md_short_1s"] = loadfx("light/fx_nic_light_sun_ray_md_short_1s");
  level._effect["fx_nic_light_sun_ray_md_streak"] = loadfx("light/fx_nic_light_sun_ray_md_streak");
  level._effect["fx_nic_light_sun_ray_md_streak_1s"] = loadfx("light/fx_nic_light_sun_ray_md_streak_1s");
  level._effect["fx_sawdust_floating"] = loadfx("debris/fx_sawdust_floating");
  level._effect["fx_waterfall_rainbow"] = loadfx("light/fx_waterfall_rainbow");
  level._effect["fx_nic_light_sun_ray_josephina"] = loadfx("light/fx_nic_light_sun_ray_josephina");
  level._effect["fx_ash_burning_falling_interior"] = loadfx("debris/fx_ash_burning_falling_interior");
  level._effect["fx_embers_falling_lg"] = loadfx("fire/fx_embers_falling_lg");
  level._effect["fx_embers_falling_md"] = loadfx("env/fire/fx_embers_falling_md");
  level._effect["fx_ash_embers_falling_detail_long"] = loadfx("debris/fx_ash_embers_falling_detail_long_outside");
  level._effect["fx_ash_embers_falling_2000x1000"] = loadfx("debris/fx_ash_embers_falling_2000x1000");
  level._effect["fx_ash_embers_up_lg"] = loadfx("debris/fx_ash_embers_up_lg");
  level._effect["fx_fire_falling_sm_int"] = loadfx("fire/fx_fire_falling_sm_int");
  level._effect["fx_birds_ambient_right"] = loadfx("bio/animals/fx_birds_ambient_right");
}

wind_init() {
  setsaveddvar("wind_global_vector", "-144 84 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

#using_animtree("fxanim_props");

precache_fxanim_props() {
  level.scr_anim["fxanim_props"]["barn_explode_01"] = % fxanim_nic_barn_explode_01_anim;
  level.scr_anim["fxanim_props"]["barn_explode_02"] = % fxanim_nic_barn_explode_02_anim;
  level.scr_anim["fxanim_props"]["hut_river"] = % fxanim_nic_hut_river_anim;
  level.scr_anim["fxanim_props"]["watertower_river"] = % fxanim_nic_watertower_river_anim;
  level.scr_anim["fxanim_props"]["porch_explode"] = % fxanim_nic_porch_explode_anim;
  level.scr_anim["fxanim_props"]["hut_explode"] = % fxanim_nic_hut_explode_anim;
  level.scr_anim["fxanim_props"]["hut_explode_watertower"] = % fxanim_nic_hut_explode_watertower_anim;
  level.scr_anim["fxanim_props"]["gate_crash"] = % fxanim_nic_gate_crash_anim;
  level.scr_anim["fxanim_props"]["sunshade_reed"] = % fxanim_gp_sunshade_reed_anim;
  level.scr_anim["fxanim_props"]["trough_break_1"] = % fxanim_nic_trough_break_1_anim;
  level.scr_anim["fxanim_props"]["trough_break_2"] = % fxanim_nic_trough_break_2_anim;
  level.scr_anim["fxanim_props"]["truck_fence"] = % fxanim_nic_truck_fence_anim;
  level.scr_anim["fxanim_props"]["fountain"] = % fxanim_nic_fountain_anim;
  level.scr_anim["fxanim_props"]["archway"] = % fxanim_nic_archway_anim;
  level.scr_anim["fxanim_props"]["bridge_drop"] = % fxanim_nic_bridge_drop_anim;
  level.scr_anim["fxanim_props"]["curtains_sheer"] = % fxanim_nic_curtains_sheer_anim;
  level.scr_anim["fxanim_props"]["market_canopy"] = % fxanim_yemen_market_canopy_anim;
  level.scr_anim["fxanim_props"]["blanket"] = % fxanim_nic_blanket_anim;
  addnotetrack_exploder("fxanim_props", "exploder 10210 #bridge_drop_impact", 120);
  addnotetrack_stop_exploder("fxanim_props", "exploder 10320 #barn_roof_collapse", 320);
  addnotetrack_stop_exploder("fxanim_props", "exploder 10323 #barn_roof_impact_03", 323);
  addnotetrack_customfunction("fxanim_props", "exploder 10712 #arch_impacts_ground", maps\nicaragua_mason_to_mission::arch_impacts_ground);
  addnotetrack_fxontag("fxanim_props", "watertower_river", "exploder 10611 #river_watertower_burst", "nic_water_tower_spill", "tub_jnt");
  addnotetrack_fxontag("fxanim_props", "hut_explode_watertower", "exploder 10646 #water_tower_impact", "nic_water_tower_spill", "tub_jnt");
}