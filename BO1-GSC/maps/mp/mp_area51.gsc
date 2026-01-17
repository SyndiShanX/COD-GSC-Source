/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_area51.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_area51_fx::main();
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_area51_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_area51");
  }
  maps\mp\mp_area51_amb::main();
  maps\mp\gametypes\_teamset_urbanspecops::level_init();
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
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  level thread apple_damage_think();
}
apple_damage_think() {
  apple_struct = GetStruct("apple_origin", "targetname");
  radius = 2;
  height = 5;
  if(!isDefined(apple_struct)) {
    return;
  }
  damage_trigger = spawn("trigger_damage", apple_struct.origin - (0, 0, 1), 0, radius, height);
  for(;;) {
    damage_trigger waittill("damage", amount, attacker, direction, point, type);
    if(!isDefined(type)) {
      continue;
    }
    if(type != "MOD_PISTOL_BULLET" && type != "MOD_RIFLE_BULLET") {
      continue;
    }
    level ClientNotify("afx");
    wait(0.5);
  }
}