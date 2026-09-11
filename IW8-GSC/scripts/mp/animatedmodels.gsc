/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\animatedmodels.gsc
***********************************************/

function main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  var0 = getarraykeys(level.anim_prop_models);

  foreach(var2 in var0) {
    var3 = getarraykeys(level.anim_prop_models[var2]);

    foreach(var5 in var3) {
      precachempanim(level.anim_prop_models[var2][var5]);
    }
  }

  waittillframeend();
  level.init_animatedmodels = [];
  var8 = getEntArray("animated_model", "targetname");
  scripts\engine\utility::array_thread_amortized(var8, &animatemodel, 0.05);
  level.init_animatedmodels = undefined;
}

function animatemodel() {
  jumpiffalse(isDefined(self.animation)) LOC_00000016;
  var0 = self.animation;
  goto LOC_00000042;
}