/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\tarp_tattered_thin_02.gsc
**********************************************************/

#using_animtree("animated_props");

main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  var_0 = tolower(getDvar("mapname"));
  var_1 = 1;

  if(common_scripts\utility::string_starts_with(var_0, "mp_"))
    var_1 = 0;

  var_2 = "tarp_tattered_thin_02";

  if(var_1)
    level.anim_prop_models[var_2]["self.wind"] = % tarp_tattered_thin_02_anim;
  else
    level.anim_prop_models[var_2]["self.wind"] = "tarp_tattered_thin_02_anim";
}