/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_animatedmodels.gsc
*********************************************/

main() {
  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];
  }

  var_00 = getarraykeys(level.anim_prop_models);
  foreach(var_02 in var_00) {
    var_03 = getarraykeys(level.anim_prop_models[var_02]);
    foreach(var_05 in var_03) {
      precachempanim(level.anim_prop_models[var_02][var_05]);
    }
  }

  waittillframeend;
  level.init_animatedmodels = [];
  var_08 = getEntArray("animated_model", "targetname");
  common_scripts\utility::array_thread(var_08, ::animatemodel);
  level.init_animatedmodels = undefined;
}

animatemodel() {
  if(isDefined(self.animation)) {
    var_00 = self.animation;
  } else {
    var_01 = getarraykeys(level.anim_prop_models[self.model]);
    var_02 = var_01[randomint(var_01.size)];
    var_00 = level.anim_prop_models[self.model][var_02];
  }

  self scriptmodelplayanim(var_00);
  self method_80D4();
}