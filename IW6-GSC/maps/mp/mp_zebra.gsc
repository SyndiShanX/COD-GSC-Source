/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zebra.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_zebra_precache::main();
  maps\createart\mp_zebra_art::main();
  maps\mp\mp_zebra_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_zebra");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  setdvar_cg_ng("r_specularColorScale", 1.7, 10);

  setdvar("r_reactiveMotionWindAmplitudeScale", 1);
  setdvar("r_reactiveMotionWindAreaScale", 10);
  setdvar("r_reactiveMotionWindDir", (0.3, -1, 0.3));
  setdvar("r_reactiveMotionWindFrequencyScale", 1);
  setdvar("r_reactiveMotionWindStrength", 20);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  tu_fix_door_trigger_positions();

  maps\mp\gametypes\_door::door_system_init("door_switch");
}

tu_fix_door_trigger_positions() {
  names = ["slide_door", "garage_door"];

  foreach(name in names) {
    door_ents = getEntArray(name, "targetname");

    foreach(ent in door_ents) {
      if(isDefined(ent.classname) && ent.classname == "trigger_multiple") {
        if(isDefined(ent.script_parameters) && IsSubStr(ent.script_parameters, "prone_only=true")) {
          continue;
        }

        if(name == "slide_door") {
          ent.origin = (ent.origin[0] + 4, ent.origin[1], ent.origin[2]);
        } else if(name == "garage_door") {
          ent.origin = (ent.origin[0] - 8.5, ent.origin[1], ent.origin[2]);
        }
      }
    }
  }
}