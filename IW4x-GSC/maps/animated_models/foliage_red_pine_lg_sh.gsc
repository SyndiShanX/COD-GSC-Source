/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\foliage_red_pine_lg_sh.gsc
***********************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  mapname = tolower(getdvar("mapname"));
  SP = true;
  if(string_starts_with(mapname, "mp_"))
    SP = false;

  model = "foliage_red_pine_lg_sh";
  if(SP) {
    level.anim_prop_models[model]["sway"] = % foliage_tree_oak_1_sway;
  } else
    level.anim_prop_models[model]["sway"] = "foliage_tree_oak_1_sway";
}