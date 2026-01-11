/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_storm_spring_fx.gsc
******************************************/

main() {
  level._effect["smoke_plume_white_01"] = loadfx("smoke/smoke_plume_white_01");
  level._effect["smoke_plume_white_02"] = loadfx("smoke/smoke_plume_white_02");

  level._effect["insects_carcass_flies_c"] = loadfx("misc/insects_carcass_flies_c");
  level._effect["oxygen_leak"] = loadfx("distortion/oxygen_leak");

  level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");

  if(getdvar("clientSideEffects") != "1") {
    maps\createfx\mp_storm_spring_fx::main();
  }
}