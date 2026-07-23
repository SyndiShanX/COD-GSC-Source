/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\animated_models\ow_chute_corner_hang_idle.gsc
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
  var_2 = "ow_parachute";

  if(var_1) {
    level.anim_prop_models[var_2]["corner_hang_idle"] = % ow_chute_corner_hang_idle;
  } else {
    level.anim_prop_models[var_2]["corner_hang_idle"] = "ow_chute_corner_hang_idle";
  }
}