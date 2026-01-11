/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\ow_crane_hook.gsc
**************************************************/

#using_animtree("animated_props");

main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  var_0 = tolower(getdvar("mapname"));
  var_1 = 1;

  if(common_scripts\utility::string_starts_with(var_0, "mp_")) {
    var_1 = 0;
  }

  var_2 = "ow_crane_cable";

  if(var_1) {
    level.anim_prop_models[var_2]["sway"] = % ow_crane_cable_wind;
  }
  else {
    level.anim_prop_models[var_2]["sway"] = "ow_crane_cable_wind";
  }
}