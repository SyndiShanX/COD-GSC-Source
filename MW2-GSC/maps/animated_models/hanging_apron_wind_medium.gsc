/**************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\animated_models\hanging_apron_wind_medium.gsc
**************************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isdefined(level.anim_prop_models))
    level.anim_prop_models = [];

  // Would use isSP() but this runs before we can
  mapname = tolower(getdvar("mapname"));
  SP = true;
  if(string_starts_with(mapname, "mp_"))
    SP = false;

  model = "hanging_apron";
  if(SP)
    level.anim_prop_models[model]["wind_medium"] = % hanging_clothes_apron_wind_medium;
  else
    level.anim_prop_models[model]["wind_medium"] = "hanging_clothes_apron_wind_medium";
}