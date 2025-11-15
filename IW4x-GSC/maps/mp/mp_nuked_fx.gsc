/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_nuked_fx.gsc
**************************************/

#include maps\mp\_utility;

precache_util_fx() {}

precache_scripted_fx() {}

precache_createfx_fx() {
  level._effect["fx_insects_butterfly_flutter"] = loadfx("bio/insects/fx_insects_butterfly_flutter");
  level._effect["fx_insects_butterfly_flutter_radial"] = loadfx("bio/insects/fx_insects_butterfly_flutter_radial");

  level._effect["fx_mp_nuked_glint"] = loadfx("maps/mp_maps/fx_mp_nuked_glint");
  level._effect["fx_glow_codolamp"] = loadfx("env/light/fx_glow_codolamp");
  level._effect["fx_mp_nuked_glint_sm"] = loadfx("maps/mp_maps/fx_mp_nuked_glint_sm");
  level._effect["fx_mp_nuked_glint_lg"] = loadfx("maps/mp_maps/fx_mp_nuked_glint_lg");
  level._effect["fx_mp_nuked_double_rainbow"] = loadfx("maps/mp_maps/fx_mp_nuked_double_rainbow");
  level._effect["fx_mp_nuked_double_rainbow_lg"] = loadfx("maps/mp_maps/fx_mp_nuked_double_rainbow_lg");






  level._effect["fx_mp_nuked_nuclear_explosion"] = loadfx("maps/mp_maps/fx_mp_nuked_nuclear_explosion");

  level._effect["fx_mp_nuked_sprinkler"] = loadfx("maps/mp_maps/fx_mp_nuked_sprinkler");
  level._effect["fx_mp_nuked_hose_spray"] = loadfx("maps/mp_maps/fx_mp_nuked_hose_spray");

  level._effect["fx_mp_nuked_glass_break"] = loadfx("maps/mp_maps/fx_mp_nuked_glass_break");
}

main() {
  precache_util_fx();
  precache_createfx_fx();
  precache_scripted_fx();

  maps\createfx\mp_nuked_fx::main();


  if(getdvar("clientSideEffects") != "1")
    maps\createfx\mp_nuked_fx::main();
}