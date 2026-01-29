/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\animated_models\vehicle_industrial_truck_anims.gsc
***************************************************************************/

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
  var_2 = "vehicle_industrial_truck_cab_korean";

  if(var_1) {
    level.anim_prop_models[var_2]["self.wind"] = % vehicle_industrial_truck_spin;
  } else {
    level.anim_prop_models[var_2]["self.wind"] = "vehicle_industrial_truck_spin";
  }
}