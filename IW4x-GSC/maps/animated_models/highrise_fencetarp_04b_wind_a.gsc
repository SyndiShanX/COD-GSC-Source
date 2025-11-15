/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\highrise_fencetarp_04b_wind_a.gsc
******************************************************************/

#include common_scripts\utility;

main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];


  model = "highrise_fencetarp_04b_wind_a";
  level.anim_prop_models[model]["wind_a"] = "mp_storm_fencetarp_04_windA";
}

