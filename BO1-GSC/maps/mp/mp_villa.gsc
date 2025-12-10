/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_villa.gsc
**************************************/

#include maps\mp\_utility;

main() {
  maps\mp\mp_villa_fx::main();
  precachemodel("collision_geo_64x64x256");
  precachemodel("collision_geo_32x32x128");
  precachemodel("collision_geo_32x32x32");
  maps\mp\_load::main();
  maps\mp\mp_villa_amb::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_villa_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_villa");
  }
  maps\mp\gametypes\_teamset_cubans::level_init();
  setdvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_MAPNAME_A";
  game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_MAPNAME_B";
  game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_MAPNAME_C";
  game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_MAPNAME_D";
  game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_MAPNAME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
  spawncollision("collision_geo_64x64x256", "collider", (4790, 1863, 388), (0, 30.8, 0));
  spawncollision("collision_geo_32x32x128", "collider", (4329, 3735, 144), (0, 0, 0));
  spawncollision("collision_geo_32x32x32", "collider", (2512, 3818, 113), (0, 45, 0));
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  level thread startLightning();
}
startLightning() {
  while(1) {
    self thread trigger_lightning_exploder();
    wait(30 + randomfloat(40));
  }
}
trigger_lightning_exploder() {
  randomExploder = randomint(4);
  switch (randomExploder) {
    case 0:
      exploder(1001);
      playsoundatposition("amb_thunder_clap", (259.2, -801, 1197));
      break;
    case 1:
      exploder(1002);
      playsoundatposition("amb_thunder_clap", (2523, -17012, 1174));
      break;
    case 2:
      exploder(1003);
      playsoundatposition("amb_thunder_clap", (6457, -611, 1145));
      break;
    case 3:
      exploder(1004);
      playsoundatposition("amb_thunder_clap", (4981, 1335, 890));
      break;
  }
}