/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\animatedmodels.gsc
***********************************************/

function main() {
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

  waittillframeend();
  level.init_animatedmodels = [];
  var_8 = getEntArray("animated_model", "targetname");
  scripts\engine\utility::array_thread_amortized(var_8, &animatemodel, 0.05);
  level.init_animatedmodels = undefined;
}

function animatemodel() {
  jumpiffalse(isDefined(self.animation)) LOC_00000016;
  var_0 = self.animation;
  goto LOC_00000042;
}