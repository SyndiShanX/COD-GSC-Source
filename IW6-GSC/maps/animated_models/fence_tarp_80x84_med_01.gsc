/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\fence_tarp_80x84_med_01.gsc
************************************************************/

#using_animtree("animated_props");

main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  var_0 = "fence_tarp_80x84";

  if(common_scripts\utility::issp())
    level.anim_prop_models[var_0]["wind"] = % fence_tarp_80x84_med_01;
  else
    level.anim_prop_models[var_0]["wind"] = "fence_tarp_80x84_med_01";
}