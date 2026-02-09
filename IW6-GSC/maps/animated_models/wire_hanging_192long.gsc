/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\wire_hanging_192long.gsc
*********************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  mapname = tolower(getDvar("mapname"));
  SP = true;
  if(string_starts_with(mapname, "mp_"))
    SP = false;

  model = "prop_wire_hanging_192long";
  if(SP) {
    level.anim_prop_models[model]["self.wind"] = % prop_wire_hanging_192long_wind1;
  } else
    level.anim_prop_models[model]["self.wind"] = "prop_wire_hanging_192long_wind1";
}