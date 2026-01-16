/************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\animated_models\foliage_codo_plantain_1.gsc
************************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isdefined(level.anim_prop_models))
    level.anim_prop_models = [];

  model = "foliage_codo_plantain_animated";

  level.anim_prop_models[model]["sway"] = "foliage_codo_plantain_sway";
}