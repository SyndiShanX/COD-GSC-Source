/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\mp_flooded_water_debris_spiral.gsc
*******************************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  mapname = tolower(getDvar("mapname"));
  SP = true;
  if(string_starts_with(mapname, "mp_"))
    SP = false;

  model = "debris_water_trash";
  if(SP) {
    level.anim_prop_models[model]["debris_water_trash"] = % debris_water_trash_spiral_anim;
  } else
    level.anim_prop_models[model]["debris_water_trash"] = "debris_water_trash_spiral_anim";
}