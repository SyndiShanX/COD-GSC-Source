/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_drivein.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_drivein_fx::main();
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_drivein_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_drivein");
  }
  maps\mp\mp_drivein_amb::main();
  maps\mp\createart\mp_drivein_art::main();
  maps\mp\gametypes\_teamset_urbanspecops::level_init();
  setdvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = & "MPUI_CALLSIGN_MAPNAME_A";
  game["strings"]["war_callsign_b"] = & "MPUI_CALLSIGN_MAPNAME_B";
  game["strings"]["war_callsign_c"] = & "MPUI_CALLSIGN_MAPNAME_C";
  game["strings"]["war_callsign_d"] = & "MPUI_CALLSIGN_MAPNAME_D";
  game["strings"]["war_callsign_e"] = & "MPUI_CALLSIGN_MAPNAME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  level.const_fx_exploder_police_barricades = 1001;
  level thread policeBarricades();
}
policeBarricades() {
  waittillframeend;
  if(level.wagermatch) {
    if(isDefined(level.const_fx_exploder_police_barricades)) {
      exploder(level.const_fx_exploder_police_barricades);
    }
  }
}

