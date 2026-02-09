/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_underpass.gsc
********************************************************/

main() {
  maps\mp\mp_underpass_precache::main();
  maps\createart\mp_underpass_art::main();
  maps\mp\mp_underpass_fx::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_underpass");
  setDvar("compassmaxrange", "2800");

  //setExpFog( 500, 3500, .5, 0.5, 0.45, 1, 0 );
  ambientPlay("ambient_mp_rain");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "3.1");
  setDvar("r_diffusecolorscale", ".78");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.3);
  setDvar("r_lightGridContrast", .5);

  if(level.ps3)
    setDvar("sm_sunShadowScale", "0.5"); // ps3 optimization
}