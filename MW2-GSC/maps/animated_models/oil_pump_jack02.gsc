/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\animated_models\oil_pump_jack02.gsc
********************************************************/

#include common_scripts\utility;

main() {
  if(!isdefined(level.anim_prop_models))
    level.anim_prop_models = [];

  // Uses .animation
  model = "oil_pump_jack02";
  level.anim_prop_models[model]["operate"] = "oil_pump_2";
}

// SP not currently supported because this requires updating "animated_props" animtree