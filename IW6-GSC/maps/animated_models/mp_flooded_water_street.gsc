/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\mp_flooded_water_street.gsc
************************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  mapname = tolower(getdvar("mapname"));
  SP = true;
  if(string_starts_with(mapname, "mp_")) {
    SP = false;
  }

  model = "mp_flooded_street_water";
  if(SP) {
    level.anim_prop_models[model]["mp_flooded_street_water"] = % mp_flooded_street_water_anim;
  } else
    level.anim_prop_models[model]["mp_flooded_street_water"] = "mp_flooded_street_water_anim";
}