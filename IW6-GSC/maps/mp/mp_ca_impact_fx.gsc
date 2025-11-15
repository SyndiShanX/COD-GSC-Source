/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_ca_impact_fx.gsc
***************************************/

main() {
  level._effect["vfx_breach_wood"] = loadfx("vfx/moments/mp_ca_impact/vfx_impact_breach_wood");
  level._effect["vfx_fire_extinguisher"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_extinguisher");
  level._effect["vfx_ground_dust_impact"] = loadfx("vfx/moments/mp_ca_impact/vfx_ground_dust_impact");
  level._effect["vfx_ground_dust_impact_lg"] = loadfx("vfx/moments/mp_ca_impact/vfx_ground_dust_impact_lg");
  level._effect["vfx_steam_erratic"] = loadfx("vfx/moments/mp_ca_impact/vfx_steam_erratic");
  level._effect["vfx_motes_cloud"] = loadfx("vfx/moments/mp_ca_impact/vfx_motes_cloud");
  level._effect["vfx_flare_sm_soft"] = loadfx("vfx/moments/mp_ca_impact/vfx_flare_sm_soft");
  level._effect["vfx_fly_volume"] = loadfx("vfx/moments/mp_redriver/vfx_fly_volume");
  level._effect["vfx_bird_perch"] = loadfx("vfx/moments/mp_ca_impact/vfx_bird_perch");
  level._effect["vfx_bird_perch_sm"] = loadfx("vfx/moments/mp_ca_impact/vfx_bird_perch_sm");
  level._effect["vfx_roaches"] = loadfx("vfx/moments/mp_ca_impact/vfx_roaches");
  level._effect["vfx_glow_sm_soft"] = loadfx("vfx/moments/mp_ca_impact/vfx_glow_sm_soft");
  level._effect["vfx_glow_white"] = loadfx("vfx/moments/mp_ca_impact/vfx_glow_white");
  level._effect["vfx_glow_sm_sharp"] = loadfx("vfx/moments/mp_ca_impact/vfx_glow_sm_sharp");
  level._effect["vfx_fluorescent_glow"] = loadfx("vfx/moments/mp_ca_impact/vfx_fluorescent_glow");
  level._effect["vfx_water_thick"] = loadfx("vfx/moments/mp_ca_impact/vfx_water_thick");
  level._effect["vfx_water_thin"] = loadfx("vfx/moments/mp_ca_impact/vfx_water_thin");
  level._effect["vfx_wire_box_sparks"] = loadfx("vfx/moments/mp_ca_impact/vfx_wire_box_sparks");
  level._effect["vfx_ground_splash"] = loadfx("vfx/moments/mp_ca_impact/vfx_ground_splash");
  level._effect["vfx_ground_splash_dir"] = loadfx("vfx/moments/mp_ca_impact/vfx_ground_splash_dir");
  level._effect["vfx_wall_splash"] = loadfx("vfx/moments/mp_ca_impact/vfx_wall_splash");
  level._effect["vfx_ground_splash_lg"] = loadfx("vfx/moments/mp_ca_impact/vfx_ground_splash_lg");
  level._effect["vfx_ground_splash_edge"] = loadfx("vfx/moments/mp_ca_impact/vfx_ground_splash_edge");
  level._effect["vfx_wire_box_sparks_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_wire_box_sparks_parent");
  level._effect["vfx_water_drips"] = loadfx("vfx/moments/mp_ca_impact/vfx_water_drips");
  level._effect["vfx_falling_debris_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_falling_debris_parent");
  level._effect["vfx_falling_rubble_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_falling_rubble_parent");
  level._effect["vfx_falling_debris_sm_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_falling_debris_sm_parent");
  level._effect["vfx_steam_rising"] = loadfx("vfx/moments/mp_ca_impact/vfx_steam_rising");
  level._effect["vfx_steam_falling"] = loadfx("vfx/moments/mp_ca_impact/vfx_steam_falling");
  level._effect["vfx_steam_falling_ext"] = loadfx("vfx/moments/mp_ca_impact/vfx_steam_falling_ext");
  level._effect["vfx_fire_sm"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_sm");
  level._effect["vfx_fire_med"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_med");
  level._effect["vfx_fire_large"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_large");
  level._effect["vfx_fire_sm_alt"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_sm_alt");
  level._effect["vfx_fire_med_alt"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_med_alt");
  level._effect["vfx_fire_large_alt"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_large_alt");
  level._effect["vfx_fire_distance"] = loadfx("vfx/moments/mp_ca_impact/vfx_fire_distance");
  level._effect["vfx_smoke_med"] = loadfx("vfx/moments/mp_ca_impact/vfx_smoke_med");
  level._effect["vfx_smoke_plumes"] = loadfx("vfx/moments/mp_ca_impact/vfx_smoke_plumes");
  level._effect["vfx_falling_dust_sm_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_falling_dust_sm_parent");
  level._effect["vfx_ash"] = loadfx("vfx/moments/mp_ca_impact/vfx_ash");
  level._effect["vfx_add_fake"] = loadfx("vfx/moments/mp_ca_impact/vfx_add_fake");
  level._effect["vfx_add_fake_close"] = loadfx("vfx/moments/mp_ca_impact/vfx_add_fake_close");
  level._effect["vfx_add_fake_blue"] = loadfx("vfx/moments/mp_ca_impact/vfx_add_fake_blue");
  level._effect["vfx_add_fake_lg"] = loadfx("vfx/moments/mp_ca_impact/vfx_add_fake_lg");
  level._effect["vfx_firelight_soft_glow_med"] = loadfx("vfx/moments/mp_redriver/vfx_firelight_soft_glow_med");
  level._effect["vfx_heli_mod_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_heli_mod_parent");
  level._effect["vfx_splash_up_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_splash_up_parent");
  level._effect["vfx_splash_up_sm_parent"] = loadfx("vfx/moments/mp_ca_impact/vfx_splash_up_sm_parent");
  level._effect["vfx_pipe_leak"] = loadfx("vfx/moments/mp_ca_impact/vfx_pipe_leak");
  level._effect["vfx_pipe_leak_tall"] = loadfx("vfx/moments/mp_ca_impact/vfx_pipe_leak_tall");
  level._effect["vfx_drip_splash_lg"] = loadfx("vfx/moments/mp_ca_impact/vfx_drip_splash_lg");
  level._effect["scrnfx_water_bokeh_dots_cam_16"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_bokeh_dots_cam_16");
  level._effect["vfx_scrnfx_heat_haze_5"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_heat_haze_5");
  level._effect["vfx_wall_of_fire"] = loadfx("vfx/moments/mp_ca_impact/vfx_wall_of_fire");
  level._effect["vfx_watertank_bullet_hit"] = loadfx("vfx/moments/mp_ca_impact/vfx_watertank_bullet_hit");
  level._effect["vfx_com_pan_copper"] = loadfx("vfx/moments/mp_ca_impact/vfx_com_pan_copper");
  level._effect["vfx_com_pan_metal"] = loadfx("vfx/moments/mp_ca_impact/vfx_com_pan_metal");
  level._effect["vfx_mp_ca_impact_life_preserv"] = loadfx("vfx/moments/mp_ca_impact/vfx_mp_ca_impact_life_preserv");
}