/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\animatedmodels.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\utility;
#namespace animatedmodels;

function main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  model_keys = getarraykeys(level.anim_prop_models);

  foreach(model_key in model_keys) {
    anim_keys = getarraykeys(level.anim_prop_models[model_key]);

    foreach(anim_key in anim_keys) {
      precachempanim(level.anim_prop_models[model_key][anim_key]);
    }
  }

  waittillframeend();
  level.init_animatedmodels = [];
  animated_models = getEntArray("animated_model", "targetname");
  array_thread_amortized(animated_models, &animatemodel, 0.05);
  level.init_animatedmodels = undefined;
}

function animatemodel() {
  if(isDefined(self.animation)) {
    animation = self.animation;
  } else {
    keys = getarraykeys(level.anim_prop_models[self.model]);
    animkey = keys[randomint(keys.size)];
    animation = level.anim_prop_models[self.model][animkey];
  }

  self scriptmodelplayanim(animation);
  self willneverchange();
}