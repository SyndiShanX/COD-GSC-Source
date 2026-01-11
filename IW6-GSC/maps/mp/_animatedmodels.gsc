/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_animatedmodels.gsc
***************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  model_keys = GetArrayKeys(level.anim_prop_models);
  foreach(model_key in model_keys) {
    anim_keys = GetArrayKeys(level.anim_prop_models[model_key]);
    foreach(anim_key in anim_keys) {
      PrecacheMpAnim(level.anim_prop_models[model_key][anim_key]);
    }

  }

  waittillframeend;

  level.init_animatedmodels = [];

  animated_models = getEntArray("animated_model", "targetname");

  array_thread_amortized(animated_models, ::animateModel, 0.05);

  level.init_animatedmodels = undefined;
}

animateModel() {
  if(isDefined(self.animation)) {
    animation = self.animation;
  } else {
    keys = GetArrayKeys(level.anim_prop_models[self.model]);
    animkey = keys[RandomInt(keys.size)];
    animation = level.anim_prop_models[self.model][animkey];
  }

  self ScriptModelPlayAnim(animation);
  self willNeverChange();
}