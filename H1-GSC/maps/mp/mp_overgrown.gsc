/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_overgrown.gsc
********************************/

main() {
  maps\mp\mp_overgrown_precache::main();
  maps\mp\mp_overgrown_fx::main();
  maps\createart\mp_overgrown_art::main();
  maps\mp\_load::main();
  maps\mp\_water::init();
  maps\mp\_compass::setupminimap("compass_map_mp_overgrown_dlc");
  ambientplay("amb_mp_overgrown_ext");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  setdvar("compassmaxrange", "2200");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  maps\mp\_utility::hardpointvisualsswap("hp_zone_1", "patch_hp_zone_1");
  level thread scriptpatchclip();
}

scriptpatchclip() {
  wait 1.0;

  if(!level.rankedmatch) {
    var_0 = maps\mp\_utility::spawnpatchclip("patchclip_ai_16_64_64", (1218, -4104, -86), (0, 0, 0));
    var_1 = getnodesinradiussorted((1136, -4112, -83), 256, 0)[0];
    var_2 = getnodesinradiussorted((1242, -4120, -78), 256, 0)[0];
    disconnectnodepair(var_1, var_2);
    var_1 = getnodesinradiussorted((1136, -4112, -83), 256, 0)[0];
    var_2 = getnodesinradiussorted((1304, -4096, -83), 256, 0)[0];
    disconnectnodepair(var_1, var_2);
    var_1 = getnodesinradiussorted((1136, -4112, -83), 256, 0)[0];
    var_2 = getnodesinradiussorted((1392, -4112, -83), 256, 0)[0];
    disconnectnodepair(var_1, var_2);
  }
}