/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\animated_models\foliage_tree_palm_bushy_3.gsc
**********************************************************************/

#using_animtree("animated_props");

main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }
  var_0 = tolower(getDvar("mapname"));
  var_1 = 1;

  if(common_scripts\utility::string_starts_with(var_0, "mp_")) {
    var_1 = 0;
  }
  var_2 = "foliage_tree_palm_bushy_3";

  if(var_1) {
    level.anim_prop_models[var_2]["still"] = % palmtree_bushy3_still;
    level.anim_prop_models[var_2]["strong"] = % palmtree_bushy3_sway;
  } else {
    level.anim_prop_models[var_2]["strong"] = "palmtree_mp_bushy3_sway";
  }
}