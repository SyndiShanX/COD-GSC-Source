/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_dart.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_dart_precache::main();
  maps\createart\mp_dart_art::main();
  maps\mp\mp_dart_fx::main();

  level thread maps\mp\mp_dart_events::breach();
  level thread maps\mp\mp_dart_events::gas_station();

  thread maps\mp\mp_dart_scriptlights::main();

  level.introVisionSet = "mpIntro_dart";

  maps\mp\_load::main();
  thread maps\mp\_fx::func_glass_handler();

  maps\mp\_compass::setupMiniMap("compass_map_mp_dart");

  if(level.ps3) {
    setDvar("sm_sunShadowScale", "0.6");
  } else if(level.xenon) {
    setDvar("sm_sunShadowScale", "0.7");
  }

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setdvar_cg_ng("r_specularColorScale", 1.5, 10);
  setdvar_cg_ng("r_diffuseColorScale", 1.48, 1.7325);
  setDvar("r_ssaofadedepth", 1089);
  setDvar("r_ssaorejectdepth", 1200);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level thread maps\mp\mp_dart_events::broken_walls();
  level thread maps\mp\mp_dart_events::player_connect_watch();
  level thread maps\mp\mp_dart_events::container_pathnode_watch();
  level thread initExtraCollision();
}

initExtraCollision() {
  collision1 = GetEnt("clip128x128x8", "targetname");
  collision1Ent = spawn("script_model", (468, -776, 212));
  collision1Ent.angles = (0, 0, -90);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);
}