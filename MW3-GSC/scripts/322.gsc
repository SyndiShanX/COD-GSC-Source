/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\322.gsc
**************************************/

#using_animtree("animated_props");

main() {
  waittillframeend;
  _id_1E41();
  level._id_1E3D = [];
  level._id_1E3E = #animtree;

  if(!isDefined(level.anim_prop_models)) {
    level.anim_prop_models = [];

  }
  if(!isDefined(level._id_1E40)) {
    level._id_1E40 = [];

  }
  var_0 = getEntArray("animated_model", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_1E46);

  if(isDefined(level._id_1E3D) && level._id_1E3D.size) {
    var_1 = " ";

    foreach(var_3 in level._id_1E3D) {}
    var_1 = var_1 + (var_3 + " ");
  }

  foreach(var_6 in var_0) {
    if(isDefined(level._id_1E40[var_6.model])) {
      var_6 thread[[level._id_1E40[var_6.model]]]();
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

    if(var_8) {
      var_6 thread _id_1E49();
    } else {
      var_6 thread animatemodel();
    }
  }
}

_id_1E41() {
  if(isDefined(level._id_1E42)) {
    return;
  }
  level._id_1E42 = spawnStruct();
  level._id_1E42._id_1E43 = 0.4;
  level._id_1E42.weight = 1;
  level._id_1E42._id_1E45 = 0.2;
}

_id_1E46() {
  if(!isDefined(level.anim_prop_models[self.model])) {
    if(!_id_1E47(level._id_1E3D, self.model)) {
      level._id_1E3D[level._id_1E3D.size] = self.model;
    }
  }
}

_id_1E47(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;

  }
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
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

_id_1E49() {
  self useanimtree(#animtree);
  var_0 = "strong";

  for(;;) {
    thread _id_1E4A(var_0);
    level waittill("windchange", var_0);
  }
}

_id_1E4A(var_0) {
  level endon("windchange");
  var_1 = level._id_1E42.weight;
  var_2 = level._id_1E42._id_1E43 + randomfloat(level._id_1E42._id_1E45);
  self setanim(level.anim_prop_models[self.model]["still"], 1, self getanimtime(level.anim_prop_models[self.model]["still"]), var_2);
  self setanim(level.anim_prop_models[self.model][var_0], var_1, self getanimtime(level.anim_prop_models[self.model][var_0]), var_2);
}