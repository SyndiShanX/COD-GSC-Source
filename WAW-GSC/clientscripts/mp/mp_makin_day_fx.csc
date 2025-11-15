/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_makin_day_fx.csc
*****************************************************/

#include clientscripts\mp\_utility;

precache_util_fx() {}
precache_scripted_fx() {}
precache_createfx_fx() {
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

main() {
  clientscripts\mp\createfx\mp_makin_day_fx::main();
  clientscripts\mp\_fx::reportNumEffects();
  precache_util_fx();
  precache_createfx_fx();
  disableFX = GetDvarInt("disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }
}