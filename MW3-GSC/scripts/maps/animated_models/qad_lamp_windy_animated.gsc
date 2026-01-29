/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\animated_models\qad_lamp_windy_animated.gsc
********************************************************************/

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
  var_2 = "qad_lamp_windy_model";

  if(var_1) {
    level.anim_prop_models[var_2]["lamp_windy_a"] = % qad_lamp_windy_a;
    level.anim_prop_models[var_2]["lamp_windy_b"] = % qad_lamp_windy_b;
    level.anim_prop_models[var_2]["lamp_windy_c"] = % qad_lamp_windy_c;
  } else {
    level.anim_prop_models[var_2]["lamp_windy_a"] = "qad_lamp_windy_a";
    level.anim_prop_models[var_2]["lamp_windy_b"] = "qad_lamp_windy_b";
    level.anim_prop_models[var_2]["lamp_windy_c"] = "qad_lamp_windy_c";
  }
}