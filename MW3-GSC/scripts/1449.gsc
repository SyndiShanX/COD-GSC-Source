/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1449.gsc
**************************************/

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
  var_2 = "fence_tarp_140x56";

  if(var_1) {
    level.anim_prop_models[var_2]["wind"] = % fence_tarp_140x56_med_01;
  } else {
    level.anim_prop_models[var_2]["wind"] = "fence_tarp_140x56_med_01";
  }
}