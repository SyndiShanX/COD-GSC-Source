/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\animated_models\ferris_wheel.gsc
********************************************************/

#include common_scripts\utility;

main() {
  if(!isdefined(level.anim_prop_models))
    level.anim_prop_models = [];

  model = "ferris_wheel_animated";
  level.anim_prop_models[model]["rotate"] = "ferris_wheel_anim";
}

// SP not currently supported because this requires updating "animated_props" animtree