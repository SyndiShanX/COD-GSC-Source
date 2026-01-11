/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\hanging_sheet_wind_medium.gsc
**************************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  model = "clothes_line_sheet_iw6";
  if(isSP()) {
    level.anim_prop_models[model]["wind_medium"] = % hanging_clothes_sheet_wind_medium;
  } else {
    level.anim_prop_models[model]["wind_medium"] = "hanging_clothes_sheet_wind_medium";
  }
}