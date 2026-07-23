/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\_animatedmodels.gsc
********************************************************/

#include common_scripts\utility;
#using_animtree("animated_props");
main() {
  level.init_animatedmodels_dump = false;

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
  array_thread(animated_models, ::model_init);

  if(level.init_animatedmodels_dump) {
    assertmsg("anims not cached for animated prop model, Repackage Zones and Rebuild Precache Script in Launcher:");
  }

  array_thread(animated_models, ::animateModel);

  level.init_animatedmodels = undefined;
}

model_init() {
  if(!isDefined(level.anim_prop_models[self.model])) {
    level.init_animatedmodels_dump = true;
  }
}
animateModel() {
  keys = GetArrayKeys(level.anim_prop_models[self.model]);
  animkey = keys[RandomInt(keys.size)];

  self ScriptModelPlayAnim(level.anim_prop_models[self.model][animkey]);
  self willNeverChange();
}