/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2694.gsc
**************************************/

main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  var_0 = getarraykeys(level.anim_prop_models);

  foreach(var_2 in var_0) {
    var_3 = getarraykeys(level.anim_prop_models[var_2]);

    foreach(var_5 in var_3) {
      precachempanim(level.anim_prop_models[var_2][var_5]);
    }
  }

  waittillframeend;
  level.init_animatedmodels = [];
  var_8 = getEntArray("animated_model", "targetname");
  scripts\engine\utility::array_thread_safe(var_8, ::animatemodel, 0.05);
  level.init_animatedmodels = undefined;
}

animatemodel() {
  if(isDefined(self.animation)) {
    var_0 = self.animation;
  } else {
    var_1 = getarraykeys(level.anim_prop_models[self.model]);
    var_2 = var_1[randomint(var_1.size)];
    var_0 = level.anim_prop_models[self.model][var_2];
  }

  self scriptmodelplayanim(var_0);
  self willneverchange();
}