/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombietron_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  maps\createfx\zombietron_fx::main();
  precache_scripted_fx();
  precache_createfx_fx();
  footsteps();
}
footsteps() {}
precache_scripted_fx() {
  level._effect["edge_fog"] = LoadFX("maps/zombie/fx_fog_zombie_amb");
  level._effect["chest_light"] = LoadFX("env/light/fx_ray_sun_sm_short");
  level._effect["eye_glow"] = LoadFX("misc/fx_zombie_eye_single_zt");
  level._effect["headshot"] = LoadFX("impacts/fx_flesh_hit_body_fatal_lg_exit");
  level._effect["headshot_nochunks"] = LoadFX("impacts/fx_flesh_hit_body_fatal_lg_exit");
  level._effect["bloodspurt"] = LoadFX("impacts/fx_flesh_hit_body_fatal_lg_exit");
  level._effect["character_fire_pain_sm"] = LoadFX("env/fire/fx_fire_player_sm_1sec");
  level._effect["character_fire_death_sm"] = LoadFX("env/fire/fx_fire_player_md");
  level._effect["character_fire_death_torso"] = LoadFX("env/fire/fx_fire_player_torso");
  level._effect["def_explosion"] = LoadFX("explosions/fx_default_explosion");
  level._effect["betty_explode"] = LoadFX("weapon/bouncing_betty/fx_explosion_betty_generic");
  level._effect["explode"] = LoadFX("maps/zombie/fx_china_lake_exp");
  level._effect["respawn"] = LoadFX("misc/javelin_ignition");
  level._effect["torch_light"] = LoadFX("env/fire/fx_fire_sm");
  level._effect["capacitor_light"] = LoadFX("misc/fx_zombie_electric_trap_loc");
  level._effect["snow_light"] = LoadFX("env/light/fx_light_red_on_lg");
  level._effect["avalanche_fx"] = LoadFX("env/weather/fx_snow_wall_avalanche");
  level._effect["vespa_smoke_fx"] = LoadFX("vehicle/vfire/fx_pow_veh_smoke_sm");
  level._effect["waterfall_splash"] = LoadFX("maps/creek/fx_water_fall_mist");
  level._effect["snowfall"] = LoadFX("env/weather/fx_snow_flakes_windy_med_looping");
  level._effect["rainfall"] = LoadFX("maps/zombie/fx_zmbtron_hvy_rain");
  level._effect["lightning"] = LoadFX("env/weather/fx_lightning_flash_run");
  level._effect["fog_amb"] = LoadFX("maps/zombie/fx_fog_zombie_amb");
  level._effect["elec_sm"] = LoadFX("misc/fx_zombie_elec_trail");
  level._effect["stun_bear"] = LoadFX("maps/zombie/fx_zmbtron_stun_bear");
  level._effect["stun_bear_fade"] = LoadFX("maps/zombie/fx_zmbtron_stun_bear_fade");
  level._effect["stun_bear_explode"] = LoadFX("maps/zombie/fx_zmbtron_bear_butterfly");
  level._effect["fate_explode"] = LoadFX("misc/fx_exp_raygun_impact");
  level._effect["nuke_dust"] = loadfx("maps/zombie/fx_zombie_body_nuke_dust");
  level._effect["red_gem"] = loadfx("maps/zombie/fx_zmbtron_gem_trail_rd");
  level._effect["blue_gem"] = loadfx("maps/zombie/fx_zmbtron_gem_trail_blu");
  level._effect["white_gem"] = loadfx("maps/zombie/fx_zmbtron_gem_trail_wht");
  level._effect["powerup_on"] = loadfx("misc/fx_zombie_powerup_on_zt");
  level._effect["powerup_on_red"] = loadfx("misc/fx_zombie_powerup_on_red_zt");
  level._effect["powerup_on_silver"] = loadfx("misc/fx_zombie_powerup_on_silver_zt");
  level._effect["powerup_grabbed"] = loadfx("misc/fx_zombie_powerup_grab");
  level._effect["powerup_grabbed_wave"] = loadfx("misc/fx_zombie_powerup_wave");
  level._effect["electric_trap"] = loadfx("maps/zombie/fx_zombie_theater_electric_trap");
  level._effect["fire_trap"] = loadfx("env/fire/fx_fire_md");
  level._effect["shield"] = loadfx("misc/fx_zombietron_shield");
  level._effect["shield_gone"] = loadfx("misc/fx_zombietron_shield_gone");
  level._effect["red_shield"] = LoadFX("misc/fx_zombietron_shield_red");
  level._effect["bomb"] = loadfx("explosions/fx_exp_rocket_aerial");
  level._effect["coconut"] = LoadFX("maps/zombie/fx_zmbtron_elec_player_trailx10");
  level._effect["life_force"] = LoadFX("maps/zombie/fx_zmbtron_elec_trail_fast");
  level._effect["player1_light"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail_gr");
  level._effect["player2_light"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail");
  level._effect["player3_light"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail_rd");
  level._effect["player4_light"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail_yl");
  level._effect["white_light"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail_wh");
  level._effect["red_light"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail_rd");
  level._effect["orange_light"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail_or");
  level._effect["boss"] = loadfx("maps/zombie/fx_zmbtron_elec_player_trail_rd");
  level._effect["boss_takeoff"] = LoadFX("misc/javelin_ignition");
  level._effect["boss_groundhit"] = LoadFX("weapon/bouncing_betty/fx_explosion_betty_generic");
  level._effect["gib_death"] = loadfx("weapon/thunder_gun/fx_thundergun_exp");
  level._effect["big_blood"] = loadfx("weapon/thunder_gun/fx_thundergun_gib_dissolve");
  level._effect["chicken_done"] = loadfx("bio/animals/fx_chicken_death_feathers");
  level._effect["mini_turret_takeoff"] = LoadFX("misc/javelin_ignition");
  level._effect["monkey_glow"] = loadfx("maps/zombie/fx_zombie_monkey_light");
  level._effect["monkey_explode"] = loadfx("maps/zombie/fx_zmbtron_concussion_grenade");
  level._effect["spot_light"] = loadfx("maps/zombietron/fx_zmbtron_pandoras_light");
  level._effect["flashlight"] = loadfx("env/light/fx_flashlight_ai_spotlight");
  level._effect["trap_red"] = loadfx("maps/zombie/fx_zmbtron_elec_trap_light_red");
  level._effect["trap_green"] = loadfx("maps/zombie/fx_zmbtron_elec_trap_light_grn");
  level._effect["cow_explode"] = loadfx("maps/zombietron/fx_zmbtron_cow_explode");
  level._effect["barrel_ignite_fire"] = loadfx("destructibles/fx_barrel_ignite");
  level._effect["barrel_top_fire"] = loadfx("destructibles/fx_barrel_fire_top");
  level._effect["barrel_explode"] = loadfx("maps/zombie/fx_zmbtron_barrelexp");
}
precache_createfx_fx() {
  level._effect["fx_rain_sys_heavy_windy_1"] = LoadFx("env/weather/fx_rain_sys_heavy_windy_1");
  level._effect["fx_fog_low"] = loadfx("env/smoke/fx_fog_low");
  level._effect["fx_fog_low_sm"] = loadfx("env/smoke/fx_fog_low_sm");
  level._effect["fx_water_wake_creek"] = loadfx("env/water/fx_water_wake_creek");
  level._effect["fx_water_wake_creek_mouth"] = loadfx("env/water/fx_water_wake_creek_mouth");
  level._effect["fx_water_wake_creek_mouth_froth"] = loadfx("env/water/fx_water_wake_creek_mouth_froth");
  level._effect["fx_water_splash_creek_rocks"] = loadfx("maps/creek/fx_water_splash_creek_rocks");
  level._effect["fx_water_splash_creek_rocks_sm"] = loadfx("maps/creek/fx_water_splash_creek_rocks_sm");
  level._effect["fx_water_fall_sm"] = loadfx("maps/creek/fx_water_fall_sm");
  level._effect["fx_water_fall_xsm"] = loadfx("maps/creek/fx_water_fall_xsm");
  level._effect["fx_pow_cave_water_fall"] = loadfx("maps/pow/fx_pow_cave_water_fall");
  level._effect["fx_light_incandescent"] = loadfx("env/light/fx_light_incandescent");
  level._effect["fx_light_kow_ray_street"] = LoadFx("maps/kowloon/fx_light_kow_ray_street");
  level._effect["fx_zombie_light_glow_green"] = loadfx("maps/zombie/fx_zombie_light_glow_green");
  level._effect["fx_search_light_tower"] = loadfx("env/light/fx_search_light_tower");
  level._effect["fx_ray_lampost_white"] = loadfx("env/light/fx_ray_lampost_white");
  level._effect["fx_light_fluorescent_tubes"] = loadfx("env/light/fx_light_fluorescent_tubes");
  level._effect["fx_zmbtron_god_ray_lrg"] = loadfx("maps/zombietron/fx_zmbtron_god_ray_lrg");
  level._effect["fx_smk_smolder_rubble_md"] = LoadFx("env/smoke/fx_smk_smolder_rubble_md");
  level._effect["fx_smk_smolder_rubble_lg"] = LoadFx("env/smoke/fx_smk_smolder_rubble_lg");
  level._effect["fx_smk_plume_xsm_blk"] = LoadFx("env/smoke/fx_smk_plume_xsm_blk");
  level._effect["fx_fire_ember_column_lg"] = loadfx("env/fire/fx_fire_ember_column_lg");
  level._effect["fx_ash_embers_light"] = loadfx("env/fire/fx_ash_embers_light");
  level._effect["fx_fire_column_creep_xsm"] = loadfx("env/fire/fx_fire_column_creep_xsm");
  level._effect["fx_fire_column_xsm_thin"] = loadfx("env/fire/fx_fire_column_xsm_thin");
  level._effect["fx_fire_line_xsm_thin"] = loadfx("env/fire/fx_fire_line_xsm_thin");
  level._effect["fx_fire_wall_back_sm"] = loadfx("env/fire/fx_fire_wall_back_sm");
  level._effect["fx_fire_md"] = loadfx("env/fire/fx_fire_md");
  level._effect["fx_elec_short_random"] = loadfx("env/electrical/fx_elec_short_random");
  level._effect["fx_snow_wall_avalanche"] = loadfx("env/weather/fx_snow_wall_avalanche");
}