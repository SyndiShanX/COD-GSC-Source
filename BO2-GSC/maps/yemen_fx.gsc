/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\yemen_fx;
#include maps\yemen_utility;

precache_util_fx() {
}

precache_scripted_fx() {
  level._effect["drone_weapon_flash"] = loadfx("weapon/muzzleflashes/fx_muz_ar_flash_3p");
  level._effect["speech_vtol_exp"] = loadfx("maps/yemen/fx_vtol_exp1");
  level._effect["crashing_vtol"] = loadfx("maps/yemen/fx_vtol_exp1");
  level._effect["explosion_midair_heli"] = loadfx("maps/yemen/fx_vtol_exp2");
  level._effect["moral_vtol_explosion"] = loadfx("maps/yemen/fx_vtol_exp3");
  level._effect["explosion_midair_heli_engine1"] = loadfx("maps/yemen/fx_vtol_engine_burn1");
  level._effect["fx_yem_gascan_explo"] = loadfx("maps/yemen/fx_yem_gascan_explo");
  level._effect["th_gaspipe_exp"] = loadfx("maps/yemen/fx_gaspipe_explosion01");
  level._effect["th_generator_exp"] = loadfx("maps/yemen/fx_yem_elec_burst_fire_sm");
  level._effect["th_pipe_steam"] = loadfx("maps/yemen/fx_pipes_spraying01");
  level._effect["th_rpgammo_exp"] = loadfx("maps/yemen/fx_rpg_explosion01");
  level._effect["th_wires_sparking"] = loadfx("maps/yemen/fx_yem_elec_burst_xsm");
  level._effect["balcony_explosion"] = loadfx("maps/yemen/fx_balcony_explosion01");
  level._effect["balcony_debris_atplayer"] = loadfx("maps/yemen/fx_debris_atplayer");
  level._effect["cutter_on"] = loadfx("props/fx_laser_cutter_on");
  level._effect["cutter_spark"] = loadfx("props/fx_laser_cutter_sparking");
  level._effect["vtol_attack_explosion"] = loadfx("explosions/fx_grenadeexp_concrete");
  level._effect["morals_fhj_rocket_trail"] = loadfx("maps/yemen/fx_rpg_trail1");
  level._effect["morals_rocket_exp"] = loadfx("explosions/fx_exp_anti_tank_mine");
  level._effect["morals_arm_light"] = loadfx("maps/yemen/fx_arm_light");
  level._effect["quadrotor_crash"] = loadfx("destructibles/fx_quadrotor_crash01");
  level._effect["flesh_hit"] = loadfx("impacts/fx_flesh_hit");
  level._effect["morals_punch"] = loadfx("maps/yemen/fx_yemen_head_punch");
  level._effect["muzzle_flash"] = loadfx("maps/yemen/fx_yemen_moral_choice_muzzleflash");
  level._effect["muzzle_flash_menendez"] = loadfx("maps/yemen/fx_yemen_moral_death_muzzleflash");
  level._effect["harper_blood"] = loadfx("maps/yemen/fx_harper_headshot");
  level._effect["harper_blood_pool"] = loadfx("maps/yemen/fx_harper_headshot_decal");
  level.heli_crash_smoke_trail_fx = loadfx("maps/yemen/fx_vtol_exp2");
}

#using_animtree("fxanim_props");

initmodelanims() {
  level.scr_anim["fxanim_props"]["vtol1_crash"] = % fxanim_yemen_vtol1_crash_anim;
  level.scr_anim["fxanim_props"]["canopy_collapse"] = % fxanim_yemen_market_canopy_collapse_anim;
  level.scr_anim["fxanim_props"]["bridge_explode"] = % fxanim_yemen_bridge_explode_anim;
  level.scr_anim["fxanim_props"]["bridge_explode_02"] = % fxanim_yemen_bridge_explode_02_anim;
  level.scr_anim["fxanim_props"]["bridge_drop"] = % fxanim_yemen_bridge_drop_anim;
  level.scr_anim["fxanim_props"]["vtol2_crash"] = % fxanim_yemen_vtol2_crash_anim;
  level.scr_anim["fxanim_props"]["balcony_courtyard"] = % fxanim_yemen_balcony_courtyard_anim;
  level.scr_anim["fxanim_props"]["balcony_courtyard2"] = % fxanim_yemen_balcony_courtyard02_anim;
  level.scr_anim["fxanim_props"]["rock_slide"] = % fxanim_yemen_rock_slide_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_01"] = % fxanim_gp_seagull_circle_01_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_02"] = % fxanim_gp_seagull_circle_02_anim;
  level.scr_anim["fxanim_props"]["seagull_circle_03"] = % fxanim_gp_seagull_circle_03_anim;
  level.scr_anim["fxanim_props"]["falling_rocks"] = % fxanim_yemen_falling_rocks_anim;
  level.scr_anim["fxanim_props"]["market_canopy"] = % fxanim_yemen_market_canopy_anim;
  level.scr_anim["fxanim_props"]["canopy_01"] = % fxanim_yemen_cloth_canopy01_anim;
  level.scr_anim["fxanim_props"]["canopy_02"] = % fxanim_yemen_cloth_canopy02_anim;
  level.scr_anim["fxanim_props"]["canopy_03"] = % fxanim_yemen_cloth_canopy03_anim;
  level.scr_anim["fxanim_props"]["canopy_04"] = % fxanim_yemen_cloth_canopy04_anim;
  level.scr_anim["fxanim_props"]["canopy_05"] = % fxanim_yemen_cloth_canopy05_anim;
  level.scr_anim["fxanim_props"]["canopy_06"] = % fxanim_yemen_cloth_canopy06_anim;
  level.scr_anim["fxanim_props"]["canopy_07"] = % fxanim_yemen_cloth_canopy07_anim;
  level.scr_anim["fxanim_props"]["canopy_08"] = % fxanim_yemen_cloth_canopy08_anim;
  level.scr_anim["fxanim_props"]["canopy_09"] = % fxanim_yemen_cloth_canopy09_anim;
  level.scr_anim["fxanim_props"]["canopy_10"] = % fxanim_yemen_cloth_canopy10_anim;
  level.scr_anim["fxanim_props"]["canopy_11"] = % fxanim_yemen_cloth_canopy11_anim;
  level.scr_anim["fxanim_props"]["canopy_12"] = % fxanim_yemen_cloth_canopy12_anim;
  level.scr_anim["fxanim_props"]["canopy_13"] = % fxanim_yemen_cloth_canopy13_anim;
  level.scr_anim["fxanim_props"]["wire_coil"] = % fxanim_gp_wire_coil_01_anim;
  level.scr_anim["fxanim_props"]["awning_fast"] = % fxanim_gp_awning_store_mideast_fast_anim;
  level.scr_anim["fxanim_props"]["awning_xl"] = % fxanim_gp_awning_store_mideast_xl_anim;
  level.scr_anim["fxanim_props"]["tarp_white_stripe"] = % fxanim_gp_tarp_white_stripe_anim;
  level.scr_anim["fxanim_props"]["banner_menendez"] = % fxanim_yemen_banner_menendez_anim;
  level.scr_anim["fxanim_props"]["banner_menendez_scaled"] = % fxanim_yemen_banner_menendez_scaled_anim;
}

precache_createfx_fx() {
  level._effect["fx_balcony_explosion"] = loadfx("maps/yemen/fx_balcony_explosion01");
  level._effect["fx_bridge_explosion01"] = loadfx("maps/yemen/fx_bridge_explosion01");
  level._effect["fx_wall_explosion01"] = loadfx("maps/yemen/fx_wall_explosion01");
  level._effect["fx_wall_explosion02"] = loadfx("maps/yemen/fx_wall_explosion02");
  level._effect["fx_ceiling_collapse01"] = loadfx("maps/yemen/fx_ceiling_collapse01");
  level._effect["fx_ceiling_collapse02"] = loadfx("maps/yemen/fx_ceiling_collapse02");
  level._effect["fx_shockwave01"] = loadfx("maps/yemen/fx_shockwave01");
  level._effect["fx_yemen_rockpuff02_custom"] = loadfx("maps/yemen/fx_yemen_rockpuff02_custom");
  level._effect["fx_yemen_rockpuff02"] = loadfx("maps/yemen/fx_yemen_rockpuff02");
  level._effect["fx_gascontainer_explosion01"] = loadfx("maps/yemen/fx_gascontainer_explosion01");
  level._effect["fx_yem_elec_burst_fire_sm"] = loadfx("maps/yemen/fx_yem_elec_burst_fire_sm");
  level._effect["fx_yem_elec_burst_xsm"] = loadfx("maps/yemen/fx_yem_elec_burst_xsm");
  level._effect["fx_yem_dest_roof_impact"] = loadfx("maps/yemen/fx_yem_dest_roof_impact");
  level._effect["fx_yem_dest_wall_impact"] = loadfx("maps/yemen/fx_yem_dest_wall_impact");
  level._effect["fx_yem_dest_wall_vtol_tall"] = loadfx("maps/yemen/fx_yem_dest_wall_vtol_tall");
  level._effect["fx_yem_vtol_ground_impact"] = loadfx("maps/yemen/fx_yem_vtol_ground_impact");
  level._effect["fx_yem_fire_column_lg"] = loadfx("maps/yemen/fx_yem_fire_column_lg");
  level._effect["fx_yem_vfire_car_compact"] = loadfx("maps/yemen/fx_yem_vfire_civ_car_compact");
  level._effect["fx_yemen_car_exp_custom"] = loadfx("maps/yemen/fx_yemen_car_exp_custom");
  level._effect["fx_vfire_t6_civ_car_compact"] = loadfx("maps/yemen/fx_yem_vfire_civ_car_compact");
  level._effect["fx_yem_dust_windy_sm"] = loadfx("maps/yemen/fx_yem_dust_windy_sm");
  level._effect["fx_lensflare_exp_hexes_lg_red"] = loadfx("light/fx_lensflare_exp_hexes_lg_red");
  level._effect["fx_heathaze_md"] = loadfx("maps/yemen/fx_heathaze_md");
  level._effect["fx_yemen_lights_warm"] = loadfx("maps/yemen/fx_yemen_lights_warm");
  level._effect["fx_yemen_smoke_column_distant2"] = loadfx("maps/yemen/fx_yemen_smoke_column_distant2");
  level._effect["fx_harper_headshot_decal"] = loadfx("maps/yemen/fx_harper_headshot_decal");
  level._effect["fx_fireplace01"] = loadfx("maps/yemen/fx_fireplace01");
  level._effect["fx_yem_fire_detail"] = loadfx("maps/yemen/fx_yem_fire_detail");
  level._effect["fx_yem_god_ray_med_thin"] = loadfx("maps/yemen/fx_yem_god_ray_med_thin");
  level._effect["fx_yem_god_ray_xlg"] = loadfx("maps/yemen/fx_yem_god_ray_xlg");
  level._effect["fx_yem_god_ray_stained"] = loadfx("maps/yemen/fx_yem_god_ray_stained");
  level._effect["fx_yemen_dust01"] = loadfx("maps/yemen/fx_yemen_dust01");
  level._effect["fx_light_spot_yemen1"] = loadfx("maps/yemen/fx_light_spot_yemen1");
  level._effect["fx_light_spot_yemen2"] = loadfx("maps/yemen/fx_light_spot_yemen2");
  level._effect["fx_light_spot_yemen_morals1"] = loadfx("maps/yemen/fx_light_spot_yemen_morals1");
  level._effect["fx_light_spot_yemen_morals2"] = loadfx("maps/yemen/fx_light_spot_yemen_morals2");
  level._effect["fx_light_spot_yemen_morals3"] = loadfx("maps/yemen/fx_light_spot_yemen_morals3");
  level._effect["fx_light_spot_yemen_morals_shot1"] = loadfx("maps/yemen/fx_light_spot_yemen_morals_shot1");
  level._effect["fx_vtol_moral_fire1"] = loadfx("maps/yemen/fx_vtol_moral_fire1");
  level._effect["fx_moral_fire1"] = loadfx("maps/yemen/fx_moral_fire1");
  level._effect["fx_vtol_moral_thruster_fire"] = loadfx("maps/yemen/fx_vtol_moral_thruster_fire");
  level._effect["fx_vtol_crash_impact1"] = loadfx("maps/yemen/fx_vtol_crash_impact1");
  level._effect["fx_vtol_crash_impact2"] = loadfx("maps/yemen/fx_vtol_crash_impact2");
  level._effect["fx_vtol_crash_dust1"] = loadfx("maps/yemen/fx_vtol_crash_dust1");
  level._effect["fx_yem_rotor_wash_morals"] = loadfx("maps/yemen/fx_yem_rotor_wash_morals");
  level._effect["fx_yem_vtol_ground_impact_sm"] = loadfx("maps/yemen/fx_yem_vtol_ground_impact_sm");
  level._effect["fx_yem_explo_window"] = loadfx("maps/yemen/fx_yem_explo_window");
  level._effect["fx_yemen_dustwind01"] = loadfx("maps/yemen/fx_yemen_dustwind01");
  level._effect["fx_yemen_smokewind01"] = loadfx("maps/yemen/fx_yemen_smokewind01");
  level._effect["fx_yemen_burningdrone02"] = loadfx("maps/yemen/fx_yemen_burningdrone02");
  level._effect["fx_yemen_burningfoliage_custom01"] = loadfx("maps/yemen/fx_yemen_burningfoliage_custom01");
  level._effect["fx_yemen_rotorwash01"] = loadfx("maps/yemen/fx_yemen_rotorwash01");
  level._effect["fx_yemen_ash01"] = loadfx("maps/yemen/fx_yemen_ash01");
  level._effect["fx_yemen_dustyledge01"] = loadfx("maps/yemen/fx_yemen_dustyledge01");
  level._effect["fx_yemen_dustyledge03"] = loadfx("maps/yemen/fx_yemen_dustyledge03");
  level._effect["fx_yemen_dustyledge04"] = loadfx("maps/yemen/fx_yemen_dustyledge04_parent");
  level._effect["fx_yemen_dustyledge06"] = loadfx("maps/yemen/fx_yemen_dustyledge06_parent");
  level._effect["fx_yemen_leaves_blow01"] = loadfx("maps/yemen/fx_yemen_leaves_blow01");
  level._effect["fx_yemen_leaves_blow02"] = loadfx("maps/yemen/fx_yemen_leaves_blow02");
  level._effect["fx_yemen_mist01"] = loadfx("maps/yemen/fx_yemen_mist01");
  level._effect["fx_yemen_mist02"] = loadfx("maps/yemen/fx_yemen_mist02");
  level._effect["fx_yemen_pcloud_dustfast01"] = loadfx("maps/yemen/fx_yemen_pcloud_dustfast01");
  level._effect["fx_yemen_pcloud_dustfast02"] = loadfx("maps/yemen/fx_yemen_pcloud_dustfast02");
  level._effect["fx_yemen_vistamist01"] = loadfx("maps/yemen/fx_yemen_vistamist01");
  level._effect["fx_yemen_vistamist02"] = loadfx("maps/yemen/fx_yemen_vistamist02");
  level._effect["fx_yemen_wake01"] = loadfx("maps/yemen/fx_yemen_wake01");
  level._effect["fx_yemen_smoldering01"] = loadfx("maps/yemen/fx_yemen_smoldering01");
  level._effect["fx_yemen_smoldering02"] = loadfx("maps/yemen/fx_yemen_smoldering02");
  level._effect["fx_yemen_crepuscular01"] = loadfx("maps/yemen/fx_yemen_crepuscular01");
  level._effect["fx_yemen_smokeflare01"] = loadfx("maps/yemen/fx_yemen_smokeflare01");
  level._effect["fx_firetorch01"] = loadfx("maps/yemen/fx_firetorch01");
  level._effect["fx_yem_smoke_pile"] = loadfx("maps/yemen/fx_yem_smoke_pile");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_seagulls_circle_overhead"] = loadfx("maps/yemen/fx_overhead_seagulls");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_debris_papers"] = loadfx("maps/yemen/fx_yemen_debris_papers");
  level._effect["fx_vtol_engine_burn1"] = loadfx("maps/yemen/fx_vtol_engine_burn1");
  level._effect["fx_vtol_engine_burn2"] = loadfx("maps/yemen/fx_vtol_engine_burn2");
  level._effect["fx_god_ray_vtol"] = loadfx("maps/yemen/fx_yem_god_ray_vtol");
  level._effect["fx_lf_yemen_sun1"] = loadfx("lens_flares/fx_lf_yemen_sun1");
  level._effect["fx_yemen_light1"] = loadfx("maps/yemen/fx_yemen_light1");
  level._effect["fx_fire_line_xsm_thin"] = loadfx("env/fire/fx_fire_line_xsm_thin");
  level._effect["fx_snow_windy_heavy_md_slow"] = loadfx("env/weather/fx_snow_windy_heavy_md_slow");
  level._effect["fx_yemen_rotorwash_market1"] = loadfx("maps/yemen/fx_yemen_rotorwash_market1");
  level._effect["fx_yemen_paratroopers"] = loadfx("maps/yemen/fx_yemen_paratroopers");
  level._effect["fx_yemen_paratroopers_parent"] = loadfx("maps/yemen/fx_yemen_paratroopers_parent");
  level._effect["fx_yemen_vtols"] = loadfx("maps/yemen/fx_yemen_vtols");
  level._effect["fx_yemen_vtols_parent"] = loadfx("maps/yemen/fx_yemen_vtols_parent");
  level._effect["fx_yemen_vtols_death"] = loadfx("maps/yemen/fx_yemen_vtols_death");
  level._effect["fx_yemen_vtols_death_parent"] = loadfx("maps/yemen/fx_yemen_vtols_death_parent");
  level._effect["fx_yemen_vtol_smoke"] = loadfx("maps/yemen/fx_yem_trail_vtol_smoke");
}

wind_initial_setting() {
  setsaveddvar("wind_global_vector", "-172 28 0");
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
  maps\createfx\yemen_fx::main();
  wind_initial_setting();
}

footsteps() {
  loadfx("bio/player/fx_footstep_dust");
  loadfx("bio/player/fx_footstep_dust");
}

createfx_setup() {
  level.skipto_point = tolower(getdvar(#"_id_1BEC029F"));

  if(level.skipto_point == "")
    level.skipto_point = "speech";

  maps\yemen_utility::load_gumps();
}