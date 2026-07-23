/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_favela.gsc
********************************************************/

main() {
  maps\mp\mp_favela_precache::main();

  maps\createart\mp_favela_art::main();
  maps\mp\mp_favela_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_favela");

  level.airstrikeHeightScale = 1.5;

  ambientPlay("ambient_mp_favela");

  switch (level.gameType) {
    case "oneflag":
      game["attackers"] = "allies";
      game["defenders"] = "axis";
      break;
    default:
      game["attackers"] = "axis";
      game["defenders"] = "allies";
      break;
  }

  setDvar("r_specularcolorscale", "2.8");
  setDvar("compassmaxrange", "1500");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.25);
  setDvar("r_lightGridContrast", .45);
}