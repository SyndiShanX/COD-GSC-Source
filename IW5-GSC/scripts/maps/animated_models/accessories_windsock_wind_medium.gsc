/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\animated_models\accessories_windsock_wind_medium.gsc
*****************************************************************************/

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
  var_2 = "accessories_windsock";

  if(var_1) {
    level.anim_prop_models[var_2]["wind_medium"] = % windsock_wind_medium;
  } else {
    level.anim_prop_models[var_2]["wind_medium"] = "windsock_wind_medium";
  }
}