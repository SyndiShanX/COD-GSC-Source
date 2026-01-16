/***************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\animated_models\foliage_tree_palm_med_2.gsc
***************************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isdefined(level.anim_prop_models))
    level.anim_prop_models = [];

  model = "foliage_tree_palm_med_2";

  level.anim_prop_models[model]["sway"] = "palmtree_med2_sway";
}