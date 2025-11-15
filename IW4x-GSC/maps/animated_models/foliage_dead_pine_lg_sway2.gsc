/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\animated_models\foliage_dead_pine_lg_sway2.gsc
***************************************************************/

#include common_scripts\utility;

main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];


  model = "foliage_dead_pine_lg_animated_sway2";
  level.anim_prop_models[model]["sway2"] = "foliage_dead_pine_lg_mp_sway2";
}

