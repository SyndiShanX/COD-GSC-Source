/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\animated_models\foliage_pacific_palms06_animated.gsc
*****************************************************************************/

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
  var_2 = "foliage_pacific_palms06_animated";

  if(var_1) {
    level.anim_prop_models[var_2]["windy06"] = % qad_palms06_windy;
    level.anim_prop_models[var_2]["windy06_b"] = % qad_palms06_windy_b;
    level.anim_prop_models[var_2]["windy06_c"] = % qad_palms06_windy_c;
  } else {
    level.anim_prop_models[var_2]["windy06"] = "qad_palms06_windy";
    level.anim_prop_models[var_2]["windy06_b"] = "qad_palms06_windy_b";
    level.anim_prop_models[var_2]["windy06_c"] = "qad_palms06_windy_c";
  }
}