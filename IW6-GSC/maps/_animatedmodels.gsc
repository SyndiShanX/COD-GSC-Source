/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_animatedmodels.gsc
*****************************************************/

#using_animtree("animated_props");

main() {
  waittillframeend;
  init_wind_if_uninitialized();
  level.init_animatedmodels_dump = [];
  level.anim_prop_models_animtree = #animtree;

  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  if(!isDefined(level.anim_prop_init_threads))
    level.anim_prop_init_threads = [];

  var_0 = getEntArray("animated_model", "targetname");
  common_scripts\utility::array_thread(var_0, ::model_init);

  if(isDefined(level.init_animatedmodels_dump) && level.init_animatedmodels_dump.size) {
    var_1 = " ";

    foreach(var_3 in level.init_animatedmodels_dump)
    var_1 = var_1 + (var_3 + " ");
  }

  foreach(var_6 in var_0) {
    if(isDefined(level.anim_prop_init_threads[var_6.model])) {
      var_6 thread[[level.anim_prop_init_threads[var_6.model]]]();
      continue;
    }

    var_7 = getarraykeys(level.anim_prop_models[var_6.model]);
    var_8 = 0;

    foreach(var_10 in var_7) {
      if(var_10 == "still") {
        var_8 = 1;
        break;
      }
    }

    if(var_8)
      var_6 thread animatetreewind();
    else
      var_6 thread animatemodel();
  }
}

init_wind_if_uninitialized() {
  if(isDefined(level.wind)) {
    return;
  }
  level.wind = spawnStruct();
  level.wind.rate = 0.4;
  level.wind.weight = 1;
  level.wind.variance = 0.2;
}

model_init() {
  if(!isDefined(level.anim_prop_models[self.model])) {
    if(!already_dumpped(level.init_animatedmodels_dump, self.model))
      level.init_animatedmodels_dump[level.init_animatedmodels_dump.size] = self.model;
  }
}

already_dumpped(var_0, var_1) {
  if(var_0.size <= 0)
    return 0;

  foreach(var_3 in var_0) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}

animatemodel() {
  self useanimtree(#animtree);
  var_0 = getarraykeys(level.anim_prop_models[self.model]);
  var_1 = var_0[randomint(var_0.size)];
  var_2 = level.anim_prop_models[self.model][var_1];
  self setanim(var_2, 1, self getanimtime(var_2), 1);
  self setanimtime(var_2, randomfloatrange(0, 1));
}

animatetreewind() {
  self useanimtree(#animtree);
  var_0 = "strong";

  for(;;) {
    thread blendtreeanims(var_0);
    level waittill("windchange", var_0);
  }
}

blendtreeanims(var_0) {
  level endon("windchange");
  var_1 = level.wind.weight;
  var_2 = level.wind.rate + randomfloat(level.wind.variance);
  self setanim(level.anim_prop_models[self.model]["still"], 1, self getanimtime(level.anim_prop_models[self.model]["still"]), var_2);
  self setanim(level.anim_prop_models[self.model][var_0], var_1, self getanimtime(level.anim_prop_models[self.model][var_0]), var_2);
}