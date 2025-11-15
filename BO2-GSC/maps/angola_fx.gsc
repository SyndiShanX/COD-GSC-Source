/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\createfx\angola_fx;

main() {
  precache_fxanim_props();
  precache_util_fx();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  footsteps();
  maps\createfx\angola_fx::main();
}

precache_util_fx() {
  level.mortar = loadfx("explosions/fx_default_explosion");
  level.mortarteam_incoming_sound = "prj_incoming";
  level.mortarteam_exp_sound = "exp_mortar_sm";
}

precache_scripted_fx() {
  level._effect["fx_ango_intro_truck_fade"] = loadfx("maps/angola/fx_ango_intro_truck_fade");
  level._effect["fx_ango_intro_truck_fade_fire"] = loadfx("maps/angola/fx_ango_intro_truck_fade_fire");
  level._effect["fx_ango_intro_arm_fire"] = loadfx("maps/angola/fx_ango_intro_arm_fire");
  level._effect["fx_ango_intro_head_fire"] = loadfx("maps/angola/fx_ango_intro_head_fire");
  level._effect["fx_ango_intro_shoulder_fire"] = loadfx("maps/angola/fx_ango_intro_shoulder_fire");
  level._effect["drone_impact"] = loadfx("impacts/fx_deathfx_drone_gib");
  level._effect["drone_impact_fx"] = loadfx("impacts/fx_flesh_hit_body_fatal_exit");
  level._effect["fx_ango_treadfx_dust"] = loadfx("vehicle/treadfx/fx_ango_treadfx_dust");
  level._effect["scene_weapon_flash"] = loadfx("weapon/muzzleflashes/fx_muz_ar_flash_3p");
  level._effect["fx_ango_alouette_gun_damage"] = loadfx("maps/angola/fx_ango_alouette_gun_damage");
  level._effect["fx_ango_buffel_smoke"] = loadfx("maps/angola/fx_ango_buffel_smoke");
  level._effect["buffel_explode"] = loadfx("maps/angola/fx_ango_vehicle_explosion");
  level._effecttype["mortar_savannah"] = "mortar";
  level._effect["mortar_savannah"] = loadfx("maps/angola/fx_ango_explosion_child");
  level._effecttype["mortar_riverbed"] = "mortar";
  level._effect["mortar_riverbed"] = loadfx("maps/angola/fx_ango_explosion_child");
  level._effecttype["mortar_intro"] = "mortar";
  level._effect["mortar_intro"] = loadfx("maps/angola/fx_ango_explosion_child");
  level._effecttype["mortar_savannah_start"] = "mortar";
  level._effect["mortar_savannah_start"] = loadfx("maps/angola/fx_ango_explosion_child");
  level._effect["heli_target_reticule"] = loadfx("misc/fx_heli_ui_airstrike_grn");
  level._effect["fx_vlight_brakelight_default"] = loadfx("light/fx_vlight_brakelight_default");
  level._effect["fx_vlight_headlight_default"] = loadfx("light/fx_vlight_headlight_default");
  level._effect["fx_eland_taillight"] = loadfx("vehicle/light/fx_eland_taillight");
  level._effect["fx_buffel_taillight"] = loadfx("vehicle/light/fx_buffel_taillight");
  level._effect["fx_buffel_headlight"] = loadfx("vehicle/light/fx_buffel_headlight");
  level._effect["fx_eland_headlight"] = loadfx("vehicle/light/fx_eland_headlight");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["mortar_flash_special"] = loadfx("maps/angola/fx_ango_mortar_launch_fake");
}

precache_createfx_fx() {
  level._effect["fx_ango_intro_truck_fire"] = loadfx("maps/angola/fx_ango_intro_truck_fire");
  level._effect["fx_ango_blood_handprint"] = loadfx("maps/angola/fx_ango_blood_handprint");
  level._effect["fx_ango_intro_truck_fire_wall"] = loadfx("maps/angola/fx_ango_intro_truck_fire_wall");
  level._effect["fx_ango_dust_distant_lrg"] = loadfx("maps/angola/fx_ango_dust_distant_lrg");
  level._effect["fx_ango_smoke_distant_lrg"] = loadfx("maps/angola/fx_ango_smoke_distant_lrg");
  level._effect["fx_ango_smoke_distant_lrg_2"] = loadfx("maps/angola/fx_ango_smoke_distant_lrg_2");
  level._effect["fx_ango_vehicle_fire"] = loadfx("maps/angola/fx_ango_vehicle_fire");
  level._effect["fx_ango_vehicle_fire_2"] = loadfx("maps/angola/fx_ango_vehicle_fire_2");
  level._effect["fx_ango_fire_sm"] = loadfx("maps/angola/fx_ango_fire_sm");
  level._effect["fx_ango_hill_outro_fire_sm"] = loadfx("maps/angola/fx_ango_hill_outro_fire_sm");
  level._effect["fx_ango_hill_outro_fire_med"] = loadfx("maps/angola/fx_ango_hill_outro_fire_med");
  level._effect["fx_ango_fire_sm"] = loadfx("maps/angola/fx_ango_fire_sm");
  level._effect["fx_ango_falling_ash"] = loadfx("maps/angola/fx_ango_falling_ash");
  level._effect["fx_ango_steam_body"] = loadfx("maps/angola/fx_ango_steam_outro");
  level._effect["fx_ango_rising_smoke"] = loadfx("maps/angola/fx_ango_rising_smoke");
  level._effect["fx_ango_dust_sml"] = loadfx("maps/angola/fx_ango_dust_sml");
  level._effect["fx_ango_dust_sml_dark"] = loadfx("maps/angola/fx_ango_dust_sml_dark");
  level._effect["fx_ango_lingering_dust_sml"] = loadfx("maps/angola/fx_ango_lingering_dust_sml");
  level._effect["fx_ango_lingering_dust_heavy"] = loadfx("maps/angola/fx_ango_lingering_dust_heavy");
  level._effect["fx_ango_oil_drips"] = loadfx("maps/angola/fx_ango_oil_drips");
  level._effect["fx_birds_circling"] = loadfx("bio/animals/fx_vultures_circling");
  level._effect["fx_ango_birds_runner"] = loadfx("maps/angola/fx_ango_birds_runner");
  level._effect["fx_ango_explosion_runner"] = loadfx("maps/angola/fx_ango_explosion_runner");
  level._effect["fx_insects_fly_swarm"] = loadfx("bio/insects/fx_insects_fly_swarm");
  level._effect["fx_leaves_falling_lite_sm"] = loadfx("maps/angola/fx_ango_leaves_falling");
  level._effect["fx_ango_shrimp_horde"] = loadfx("maps/angola/fx_ango_shrimp_horde");
  level._effect["fx_ango_shrimp_horde_side"] = loadfx("maps/angola/fx_ango_shrimp_horde_side");
  level._effect["fx_ango_grass_blowing"] = loadfx("maps/angola/fx_ango_grass_blowing");
  level._effect["fx_insects_dragonflies_ambient"] = loadfx("bio/insects/fx_insects_dragonflies_ambient");
  level._effect["fx_insects_butterfly_flutter"] = loadfx("bio/insects/fx_insects_butterfly_flutter");
  level._effect["fx_insects_moths_flutter"] = loadfx("bio/insects/fx_insects_moths_flutter");
  level._effect["fx_ango_heat_distortion"] = loadfx("maps/angola/fx_ango_heat_distortion");
  level._effect["fx_ango_heat_distortion_no_fade"] = loadfx("maps/angola/fx_ango_heat_distortion_no_fade");
  level._effect["fx_ango_heat_distortion_distant"] = loadfx("maps/angola/fx_ango_heat_distortion_distant");
  level._effect["fx_ango_intro_glass_impact"] = loadfx("maps/angola/fx_ango_intro_glass_impact");
  level._effect["fx_lf_angola1_sun1"] = loadfx("lens_flares/fx_lf_angola1_sun1");
  level._effect["fx_lf_angola1_sun2"] = loadfx("lens_flares/fx_lf_angola1_sun2");
  level._effect["fx_ango_intro_fire_spotlight"] = loadfx("maps/angola/fx_ango_intro_fire_spotlight");
  level._effect["fx_ango_intro_fire_spotlight_2"] = loadfx("maps/angola/fx_ango_intro_fire_spotlight_2");
  level._effect["fx_ango_intro_reflection_light"] = loadfx("maps/angola/fx_ango_intro_reflection_light");
  level._effect["fx_ango_smoke_outro"] = loadfx("maps/angola/fx_ango_smoke_outro");
  level._effect["fx_ango_hill_outro_black_smoke"] = loadfx("maps/angola/fx_ango_hill_outro_black_smoke");
  level._effect["fx_ango_hill_outro_black_smoke_2"] = loadfx("maps/angola/fx_ango_hill_outro_black_smoke_2");
  level._effect["fx_ango_hill_outro_black_smoke_3"] = loadfx("maps/angola/fx_ango_hill_outro_black_smoke_3");
  level._effect["fx_ango_heli_dust_outro"] = loadfx("maps/angola/fx_ango_heli_dust_outro");
  level._effect["fx_ango_intro_ext_truck_fire"] = loadfx("maps/angola/fx_ango_intro_ext_truck_fire");
  level._effect["fx_ango_intro_ext_truck_fire_2"] = loadfx("maps/angola/fx_ango_intro_ext_truck_fire_2");
}

wind_init() {
  setsaveddvar("wind_global_vector", "142 96 0");
  setsaveddvar("wind_global_low_altitude", -100);
  setsaveddvar("wind_global_hi_altitude", 1775);
  setsaveddvar("wind_global_low_strength_percent", 0.4);
}

precache_fxanim_props() {
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
}