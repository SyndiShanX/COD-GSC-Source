/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_2_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\createfx\angola_2_fx;

main() {
  initmodelanims();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  footsteps();
  maps\createfx\angola_2_fx::main();
}

precache_scripted_fx() {
  level._effect["intro_heli_smoke"] = loadfx("maps/angola/fx_ango_alouette_smoke");
  level._effect["intro_heli_missle_exp"] = loadfx("maps/angola/fx_ango_player_heli_exp");
  level._effect["intro_heli_damage"] = loadfx("maps/angola/fx_ango_alouette_d_2");
  level._effect["hind_explosion"] = loadfx("maps/angola/fx_ango_hind_explosion");
  level._effect["ship_explosion"] = loadfx("maps/angola/fx_ango_ship_explosion");
  level._effect["ship_fire"] = loadfx("maps/angola/fx_ango_ship_fire");
  level._effect["heli_fire"] = loadfx("maps/angola/fx_ango_heli_fire_crash");
  level._effect["turret_explosion"] = loadfx("maps/angola/fx_ango_turret_exp");
  level._effect["aircraft_flares"] = loadfx("vehicle/vexplosion/fx_heli_chaff_flares");
  level._effect["medium_boat_explosion"] = loadfx("maps/angola/fx_ango_exp_med_boat");
  level._effect["medium_boat_damage"] = loadfx("maps/angola/fx_ango_sparks_med_boat");
  level._effect["water_explosion"] = loadfx("maps/angola/fx_ango_water_explosion");
  level._effect["hind_damage"] = loadfx("maps/angola/fx_ango_hind_damage");
  level._effect["hind_rotor_damage"] = loadfx("maps/angola/fx_ango_heli_fire_crash_2");
  level._effect["barge_sinking"] = loadfx("maps/angola/fx_ango_water_barge_sink_main");
  level._effect["woods_cough_water"] = loadfx("maps/angola/fx_ango_cough_water");
  level._effect["barge_aft_exp"] = loadfx("maps/angola/fx_ango_barge_aft_exp");
  level._effect["barge_wheelhouse_exp"] = loadfx("maps/angola/fx_ango_barge_wheelhouse_exp");
  level._effect["barge_woods_exp"] = loadfx("maps/angola/fx_ango_barge_woods_exp");
  level._effect["barge_truck_exp"] = loadfx("maps/angola/fx_ango_barge_truck_exp");
  level._effect["barge_truck_exp_2"] = loadfx("maps/angola/fx_ango_barge_truck_exp_2");
  level._effect["barge_truck_quarter_explosion"] = loadfx("maps/angola/fx_ango_barge_crew_quarter_exp");
  level._effect["gunboat_ram_right_splash"] = loadfx("maps/angola/fx_ango_boat_barge_dock_wake_r");
  level._effect["gunboat_ram_left_splash"] = loadfx("maps/angola/fx_ango_boat_barge_dock_wake_l");
  level._effect["player_wake_idle"] = loadfx("maps/angola/fx_ango_water_player_wake_idle");
  level._effect["player_wake"] = loadfx("maps/angola/fx_ango_water_player_wake");
  level._effect["player_wake_hand"] = loadfx("maps/angola/fx_ango_water_player_wake_hand");
  level._effect["barge_water_right"] = loadfx("maps/angola/fx_ango_water_barge_sink_sides");
  level._effect["barge_water_left"] = loadfx("maps/angola/fx_ango_water_barge_sink_sides_2");
  level._effect["housing_missile_explosion"] = loadfx("maps/angola/fx_ango_barge_wheelhouse_exp_2");
  level._effect["medium_boat_second_explosion"] = loadfx("maps/angola/fx_ango_sparks_med_boat_2");
  level._effect["small_boat_damage_1"] = loadfx("maps/angola/fx_ango_damage_sml_boat_ai");
  level._effect["medium_boat_damage_1"] = loadfx("maps/angola/fx_ango_damage_med_boat_ai");
  level._effect["head_blood"] = loadfx("maps/angola/fx_ango_blood_head");
  level._effect["fx_ango_container_light"] = loadfx("maps/angola/fx_ango_container_light");
  level._effect["fx_ango_container_dust"] = loadfx("maps/angola/fx_ango_container_dust");
  level._effect["water_splash_effect"] = loadfx("maps/angola/fx_ango_wake_player");
  level._effect["small_boat_smoke_trail"] = loadfx("maps/angola/fx_ango_sml_boat_smk_trail");
  level._effect["medium_boat_smoke_trail"] = loadfx("maps/angola/fx_ango_med_boat_smk_trail");
  level._effect["splash_fx"] = loadfx("maps/angola/fx_ango_boat_death_water_impact");
  level._effect["signature_death_explosion"] = loadfx("maps/angola/fx_ango_exp_boat_collide");
  level._effect["fx_ango_radio_sparks"] = loadfx("maps/angola/fx_ango_radio_sparks");
  level._effect["air_trail"] = loadfx("maps/angola/fx_ango_motion_lines");
  level._effect["heli_trail"] = loadfx("maps/angola/fx_ango_motion_lines_heli");
  level._effect["startled_birds"] = loadfx("maps/angola/fx_ango_birds_os");
  level._effect["truck_explosion"] = loadfx("vehicle/vexplosion/fx_vexp_truck_gaz66");
  level._effecttype["mortar_fx"] = "mortar";
  level._effect["mortar_fx"] = loadfx("explosions/fx_mortarExp_dirt");
  level._effect["container_bugs"] = loadfx("maps/angola/fx_ango_container_bugs");
  level._effect["truck_explosion_waterfall"] = loadfx("maps/angola/fx_ango_exp_truck");
  level._effect["water_bubbles_player"] = loadfx("maps/angola/fx_ango_water_bubbles_player");
  level._effect["hudson_shot_tracer"] = loadfx("maps/angola/fx_ango_tracer_outro_hudson");
  level._effect["barge_exhaust_intro"] = loadfx("vehicle/exhaust/fx_exhaust_barge_intro");
  level._effect["barge_exhaust"] = loadfx("vehicle/exhaust/fx_exhaust_barge");
  level._effect["panel_splash"] = loadfx("maps/angola/fx_ango_water_barge_panel");
}

precache_createfx_fx() {
  level._effect["fx_ango_heli_fire"] = loadfx("maps/angola/fx_ango_heli_fire");
  level._effect["fx_ango_fire_hut"] = loadfx("maps/angola/fx_ango_fire_hut");
  level._effect["fx_elec_ember_shower_os_int_runner"] = loadfx("electrical/fx_elec_ember_shower_os_int_runner");
  level._effect["fx_ango_fire_sm"] = loadfx("maps/angola/fx_ango_fire_sm");
  level._effect["fx_ango_fire_xsm"] = loadfx("maps/angola/fx_ango_fire_xsm");
  level._effect["fx_ango_falling_fire"] = loadfx("maps/angola/fx_ango_falling_fire");
  level._effect["fx_ango_godray_smoke_large"] = loadfx("maps/angola/fx_ango_godray_smoke_large");
  level._effect["fx_ango_godray_md"] = loadfx("maps/angola/fx_ango_godray_md");
  level._effect["fx_ango_godray_sml"] = loadfx("maps/angola/fx_ango_godray_sml");
  level._effect["fx_ango_godray_long"] = loadfx("maps/angola/fx_ango_godray_long");
  level._effect["fx_ango_falling_ash"] = loadfx("maps/angola/fx_ango_falling_ash");
  level._effect["fx_ango_steam_body"] = loadfx("maps/angola/fx_ango_steam_body");
  level._effect["fx_ango_lingering_dust_sml"] = loadfx("maps/angola/fx_ango_lingering_dust_sml");
  level._effect["fx_ango_waterfall_bottom"] = loadfx("maps/angola/fx_ango_waterfall_bottom");
  level._effect["fx_ango_water_ripples"] = loadfx("maps/angola/fx_ango_water_ripples");
  level._effect["fx_birds_circling"] = loadfx("bio/animals/fx_vultures_circling");
  level._effect["fx_ango_birds_circling_jungle"] = loadfx("maps/angola/fx_ango_birds_circling_jungle");
  level._effect["fx_ango_birds_runner"] = loadfx("maps/angola/fx_ango_birds_runner");
  level._effect["fx_ango_birds_runner_single"] = loadfx("maps/angola/fx_ango_birds_runner_single");
  level._effect["fx_ango_leaves_falling_exploder"] = loadfx("maps/angola/fx_ango_leaves_falling_exploder");
  level._effect["fx_insects_fly_swarm"] = loadfx("bio/insects/fx_insects_fly_swarm");
  level._effect["fx_leaves_falling_lite_sm"] = loadfx("maps/angola/fx_ango_leaves_falling");
  level._effect["fx_ango_grass_blowing"] = loadfx("maps/angola/fx_ango_grass_blowing");
  level._effect["fx_insects_dragonflies_ambient"] = loadfx("bio/insects/fx_insects_dragonflies_ambient");
  level._effect["fx_insects_butterfly_flutter"] = loadfx("bio/insects/fx_insects_butterfly_flutter");
  level._effect["fx_insects_moths_flutter"] = loadfx("bio/insects/fx_insects_moths_flutter");
  level._effect["fx_ango_river_wake_lrg"] = loadfx("maps/angola/fx_ango_river_wake_lrg");
  level._effect["fx_ango_river_wake_med"] = loadfx("maps/angola/fx_ango_river_wake_med");
  level._effect["fx_ango_river_wake_sml"] = loadfx("maps/angola/fx_ango_river_wake_sml");
  level._effect["fx_ango_exp_rock_wall"] = loadfx("maps/angola/fx_ango_exp_rock_wall");
  level._effect["fx_ango_exp_village_wall"] = loadfx("maps/angola/fx_ango_exp_village_wall");
  level._effect["fx_ango_exp_village_wall_2"] = loadfx("maps/angola/fx_ango_exp_village_wall_2");
  level._effect["fx_ango_exp_village_glass"] = loadfx("maps/angola/fx_ango_exp_village_glass");
  level._effect["fx_ango_exp_rock_water_impact"] = loadfx("maps/angola/fx_ango_exp_rock_water_impact");
  level._effect["fx_ango_exp_rock_dirt_impact"] = loadfx("maps/angola/fx_ango_exp_rock_dirt_impact");
  level._effect["fx_ango_waterfall_sm"] = loadfx("maps/angola/fx_ango_waterfall_sm");
  level._effect["fx_ango_waterfall_med"] = loadfx("maps/angola/fx_ango_waterfall_med");
  level._effect["fx_ango_water_splash_player"] = loadfx("maps/angola/fx_ango_water_splash_player");
  level._effect["fx_ango_shore_water"] = loadfx("maps/angola/fx_ango_shore_water");
  level._effect["fx_ango_water_barge_sink_ext"] = loadfx("maps/angola/fx_ango_water_barge_sink_ext");
  level._effect["fx_lf_angola2_sun1"] = loadfx("lens_flares/fx_lf_angola2_sun1");
  level._effect["fx_ango_stealth_mist"] = loadfx("maps/angola/fx_ango_stealth_mist");
  level._effect["fx_ango_birds_os"] = loadfx("maps/angola/fx_ango_birds_os");
  level._effect["fx_ango_heli_hut_crash"] = loadfx("maps/angola/fx_ango_heli_hut_crash");
  level._effect["fx_ango_watersplash_jungle"] = loadfx("maps/angola/fx_ango_watersplash_jungle");
  level._effect["fx_ango_heli_water_kickup_intro"] = loadfx("maps/angola/fx_ango_heli_water_kickup_intro");
  level._effect["fx_ango_outro_leaf_exploder"] = loadfx("maps/angola/fx_ango_outro_leaf_exploder");
  level._effect["fx_ango_outro_tree_foliage"] = loadfx("maps/angola/fx_ango_outro_tree_foliage");
  level._effect["fx_ango_outro_missile_foliage"] = loadfx("maps/angola/fx_ango_outro_missile_foliage");
  level._effect["fx_ango_outro_impact_foliage"] = loadfx("maps/angola/fx_ango_outro_impact_foliage");
  level._effect["fx_ango_outro_impact_tree"] = loadfx("maps/angola/fx_ango_outro_impact_tree");
  level._effect["fx_ango_river_fog"] = loadfx("maps/angola/fx_ango_river_fog");
  level._effect["fx_ango_river_fog_2"] = loadfx("maps/angola/fx_ango_river_fog_2");
  level._effect["fx_ango_river_intro_birds"] = loadfx("maps/angola/fx_ango_river_intro_birds");
  level._effect["fx_ango_river_intro_birds_near"] = loadfx("maps/angola/fx_ango_river_intro_birds_near");
  level._effect["fx_ango_river_waterfall_giant"] = loadfx("maps/angola/fx_ango_river_waterfall_giant");
  level._effect["fx_ango_river_waterfall_giant_2"] = loadfx("maps/angola/fx_ango_river_waterfall_giant_2");
  level._effect["fx_ango_water_woods"] = loadfx("maps/angola/fx_ango_water_woods");
  level._effect["fx_ango_heli_dust_outro"] = loadfx("maps/angola/fx_ango_heli_dust_outro");
  level._effect["def_explosion"] = loadfx("maps/angola/fx_ango_outro_missile_foliage");
  level._effect["def_muzzle_flash"] = loadfx("weapon/muzzleflashes/fx_standard_flash");
  level._effect["neckstab_stand_blood"] = loadfx("impacts/fx_melee_neck_stab");
  level._effect["punch_sweat"] = loadfx("maps/angola/fx_ango_head_punch");
  level._effect["smoketrail"] = loadfx("maps/afghanistan/fx_afgh_bullet_trail_sniper");
  level._effect["woods_muzzleflash"] = loadfx("maps/angola/fx_ango_woods_muzzleflash");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit_body_nonfatal_hero");
  level._effect["fx_ango_blood_outro"] = loadfx("maps/angola/fx_ango_blood_outro");
  level._effect["menendez_fight_muzzle_flash"] = loadfx("maps/angola/fx_ango_pistol_flash_hut");
}

wind_init() {
  setsaveddvar("wind_global_vector", "142 96 0");
  setsaveddvar("wind_global_low_altitude", -100);
  setsaveddvar("wind_global_hi_altitude", 1775);
  setsaveddvar("wind_global_low_strength_percent", 0.4);
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["barge_wheelhouse"] = % fxanim_angola_barge_wheelhouse_anim;
  level.scr_anim["fxanim_props"]["barge_aft_debris"] = % fxanim_angola_barge_aft_debris_anim;
  level.scr_anim["fxanim_props"]["barge_side_debris"] = % fxanim_angola_barge_side_debris_anim;
  level.scr_anim["fxanim_props"]["hostage_hut"] = % fxanim_angola_hostage_hut_anim;
  level.scr_anim["fxanim_props"]["hostage_hut_wall"] = % fxanim_angola_hostage_hut_wall_anim;
  level.scr_anim["fxanim_props"]["river_debris_palette"] = % fxanim_angola_river_debris_palette_anim;
  level.scr_anim["fxanim_props"]["mortar_rocks"] = % fxanim_angola_mortar_rocks_anim;
  level.scr_anim["fxanim_props"]["river_debris_tire"] = % fxanim_angola_river_debris_tire_anim;
  level.scr_anim["fxanim_props"]["river_debris_group_01"] = % fxanim_angola_river_debris_group_01_anim;
  level.scr_anim["fxanim_props"]["river_debris_group_02"] = % fxanim_angola_river_debris_group_02_anim;
  level.scr_anim["fxanim_props"]["vine_01"] = % fxanim_gp_vine_bare_med_anim;
  level.scr_anim["fxanim_props"]["vine_02"] = % fxanim_gp_vine_bare_sm_anim;
  level.scr_anim["fxanim_props"]["vine_03"] = % fxanim_gp_vine_leaf_sm_anim;
  level.scr_anim["fxanim_props"]["vine_04"] = % fxanim_gp_vine_leaf_med_anim;
  level.scr_anim["fxanim_props"]["flag_horiz_rig_01"] = % fxanim_gp_flag_horiz_rig_01_anim;
  level.scr_anim["fxanim_props"]["barge_cables"] = % fxanim_angola_barge_cables_anim;
  level.scr_anim["fxanim_props"]["hind_crash"] = % fxanim_angola_hind_crash_anim;
  level.scr_anim["fxanim_props"]["river_debris_barrel"] = % fxanim_angola_river_debris_barrel_anim;
  level.scr_anim["fxanim_props"]["barge_tarp_rpg"] = % fxanim_angola_barge_tarp_rpg_anim;
  level.scr_anim["fxanim_props"]["crow_fly"] = % fxanim_angola_crow_anim;
  level.scr_anim["fxanim_props"]["crow_fly2"] = % fxanim_angola_crow_2_anim;
  level.scr_anim["fxanim_props"]["crow_log1"] = % fxanim_angola_crow_log1_anim;
  level.scr_anim["fxanim_props"]["crow_log2"] = % fxanim_angola_crow_log2_anim;
  level.scr_anim["fxanim_props"]["crow_up1"] = % fxanim_angola_crow_up1_anim;
  level.scr_anim["fxanim_props"]["crow_up2"] = % fxanim_angola_crow_up2_anim;
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
}