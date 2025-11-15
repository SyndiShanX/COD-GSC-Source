/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_makin_day_fx.gsc
*****************************************************/

#include maps\mp\_utility;

main() {
  maps\mp\createart\mp_makin_day_art::main();
  precacheFX();
  spawnFX();
}

precacheFX() {
  level._effect["mp_insects_swarm"] = loadfx("maps/mp_maps/fx_mp_insect_swarm");
  level._effect["mp_water_splash_small"] = loadfx("maps/mp_maps/fx_mp_water_splash_small");
  level._effect["mp_water_wake_flow"] = loadfx("maps/mp_maps/fx_mp_water_wake_flow");
  level._effect["mp_light_glow_indoor_short_loop"] = loadfx("maps/mp_maps/fx_mp_light_glow_indoor_short_loop");
  level._effect["mp_light_glow_lantern"] = loadfx("maps/mp_maps/fx_mp_light_glow_lantern_day");
  level._effect["mp_ray_sun_xsm"] = loadfx("maps/mp_maps/fx_mp_ray_sun_xsm");
  level._effect["mp_ray_sun_sm"] = loadfx("maps/mp_maps/fx_mp_ray_sun_sm");
  level._effect["mp_ray_sun_md"] = loadfx("maps/mp_maps/fx_mp_ray_sun_md");
  level._effect["mp_ray_sun_md_1sd"] = loadfx("maps/mp_maps/fx_mp_ray_sun_md_1sd");
  level._effect["mp_smoke_crater"] = loadfx("maps/mp_maps/fx_mp_smoke_crater");
}

spawnFX() {
  maps\mp\createfx\mp_makin_day_fx::main();
}