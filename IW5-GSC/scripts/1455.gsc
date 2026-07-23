/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1455.gsc
**************************************/

#using_animtree("animated_props");

main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }
  var_0 = "oil_pump_jack01";

  if(common_scripts\utility::issp()) {
    level.anim_prop_models[var_0]["operate"] = % oilpump_pump01;
  } else {
    level.anim_prop_models[var_0]["operate"] = "oilpump_pump01";
  }
}