/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1456.gsc
**************************************/

#using_animtree("animated_props");

main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];

  }
  var_0 = "oil_pump_jack02";

  if(common_scripts\utility::issp()) {
    level.anim_prop_models[var_0]["operate"] = % oilpump_pump02;
  } else {
    level.anim_prop_models[var_0]["operate"] = "oilpump_pump02";
  }
}