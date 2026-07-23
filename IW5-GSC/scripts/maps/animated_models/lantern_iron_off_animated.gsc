/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\animated_models\lantern_iron_off_animated.gsc
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
  var_2 = "lantern_iron_off_animated";

  if(var_1) {
    level.anim_prop_models[var_2]["self.wind"] = % lantern_iron_off_animated;
  } else {
    level.anim_prop_models[var_2]["self.wind"] = "lantern_iron_off_animated";
  }
}