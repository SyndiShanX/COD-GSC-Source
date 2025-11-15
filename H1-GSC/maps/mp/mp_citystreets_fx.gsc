/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_citystreets_fx.gsc
*****************************************/

main() {
  level._effect["00_particle_shadow_citystreets"] = loadfx("vfx\cloud\00_particle_shadow_citystreets");
  level._effect["ground_sand_skitter_blowing"] = loadfx("vfx\sand\ground_sand_skitter_blowing");
  level._effect["sand_storm_city_streets"] = loadfx("fx\weather\sand_storm_city_streets");
  level._effect["sand_storm_distant_dubsided"] = loadfx("fx\weather\sand_storm_distant_dubsided");
  level._effect["ambient_hallway_dust_mp"] = loadfx("vfx\map\mp_citystreets\ambient_hallway_dust_mp");
  level._effect["roach_flock_scatter_radial_nofly_runner"] = loadfx("vfx\animal\roach_flock_scatter_radial_nofly_runner");
  level._effect["ambient_hallway_dust_01"] = loadfx("vfx\map\ambush\ambient_hallway_dust_01");
  level._effect["mp_trash_blowing_runner"] = loadfx("vfx\map\mp_lost\mp_trash_blowing_runner");
  level._effect["sand_storm_small_mp"] = loadfx("vfx\map\mp_citystreets\sand_storm_small_mp");
  level._effect["sand_storm_mp"] = loadfx("vfx\map\mp_citystreets\sand_storm_mp");
  level._effect["amb_dust_unlit_dayonly"] = loadfx("vfx\dust\amb_dust_unlit_dayonly");
  level._effect["sand_tornado_s_runner"] = loadfx("vfx\sand\sand_tornado_s_runner");
  level._effect["fog_bog_a"] = loadfx("fx\weather\fog_bog_a");
  level._effect["amb_ash"] = loadfx("fx\smoke\amb_ash");
  level._effect["floodlight_white"] = loadfx("fx\misc\floodlight_white");
  level._effect["floodlight_yellow"] = loadfx("fx\misc\floodlight_yellow");
  level._effect["fluorescent_glow"] = loadfx("fx\misc\fluorescent_glow");
}