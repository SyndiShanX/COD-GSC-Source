/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\animated_models\oil_pump_jack02.gsc
********************************************************/

#include common_scripts\utility;

main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  model = "oil_pump_jack02";
  level.anim_prop_models[model]["operate"] = "oil_pump_2";
}