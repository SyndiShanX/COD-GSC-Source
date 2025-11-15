/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\iplane_fx.gsc
*****************************************************/

main() {
  fx();
}

fx() {
  level._effect["dirt_blow_by"] = loadfx("vfx/ambient/sand/iplane_blowing_motes");
  level._effect["dirt_two"] = loadfx("vfx/ambient/sand/iplane_blowing_motes_two");
  level._effect["scrap_plane_on_ground"] = loadfx("vfx/moments/iplane/vfx_iplane_scrape_airplane");
  level._effect["escape_dust_hijack1"] = loadfx("fx/dust/decompression_cabin_fastwind");
  level._effect["clouds"] = loadfx("fx/maps/hijack/cloud_tunnel");
  level._effect["window_volumetric_l"] = loadfx("fx/maps/hijack/window_volumetric_long");
  level._effect["window_volumetric"] = loadfx("fx/maps/hijack/window_volumetric");
  level._effect["f15_missile_trail"] = loadfx("vfx/gameplay/smoke_trails/vfx_smktrail_hand_cheap");
  level._effect["red_small_front"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_15_nolight");
  level._effect["aerial_explosion_large"] = loadfx("vfx/moments/jungle_ghost/aerial_explosion_large_wind");
  level._effect["red_new_2"] = loadfx("vfx/ambient/lights/vfx_red_dlight_sm");
  level._effect["dlight_glow_medium_red"] = loadfx("vfx/ambient/lights/dlight_glow_medium_red");
  level._effect["flying_face_fx"] = loadfx("fx/weather/flying_particulates");
  level._effect["open_ramp_wind_funnel_crash"] = loadfx("vfx/moments/jungle_ghost/vfx_aircrash_windcaos");
  level._effect["open_ramp_wind_funnel_opening"] = loadfx("vfx/moments/jungle_ghost/vfx_aircrash_windcaos_quarter");
  level._effect["open_ramp_wind_funnel_inter"] = loadfx("vfx/moments/jungle_ghost/vfx_aircrash_windcaos_half");
  level._effect["tail_rip_off_explosion"] = loadfx("vfx/moments/jungle_ghost/aerial_explosion_large_wind");
  level._effect["green_glow"] = loadfx("vfx/ambient/lights/vfx_green_dlight_sm");
}