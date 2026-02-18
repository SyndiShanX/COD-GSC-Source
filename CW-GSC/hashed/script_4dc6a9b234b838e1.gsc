/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4dc6a9b234b838e1.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_cc411409;

function preinit() {
  if(!isDefined(level.var_30858358)) {
    clientfield::register("scriptmover", "ragdoll_launcher_id", 1, getminbitcountfornum(7), "int");
    clientfield::register("scriptmover", "ragdoll_launcher_mag", 1, getminbitcountfornum(4), "int");
    clientfield::register("actor", "ragdoll_launcher_id", 1, getminbitcountfornum(7), "int");
    level.var_30858358 = [];
  }
}

function function_9a7edbff(origin, magnitude) {
  for(i = 1; i < 7; i++) {
    if(!isentity(level.var_30858358[i])) {
      level.var_30858358[i] = util::spawn_model(#"tag_origin", origin);
      level.var_30858358[i] clientfield::set("ragdoll_launcher_id", i);
      level.var_30858358[i] clientfield::set("ragdoll_launcher_mag", magnitude);
      level.var_30858358[i].index = i;
      level.var_30858358[i].magnitude = magnitude;
      level.var_30858358[i] thread function_9cffb95a();
      return level.var_30858358[i];
    }
  }
}

function ragdoll_launch(var_ed6db408, magnitude) {
  if(!(isDefined(self) && isDefined(magnitude)) || is_true(self.var_873d65bd)) {
    return;
  }

  assert(magnitude <= 3, "<dev string:x38>" + magnitude + "<dev string:x70>");

  if(isvec(var_ed6db408)) {
    var_218aaae3 = function_72d3bca6(level.var_30858358, var_ed6db408, undefined, 0, 32);

    foreach(var_887796fa in var_218aaae3) {
      if(var_887796fa.magnitude === magnitude) {
        launcher = var_887796fa;
        break;
      }
    }

    if(!isDefined(launcher)) {
      launcher = function_9a7edbff(var_ed6db408, magnitude);
    }
  } else if(isentity(var_ed6db408)) {
    launcher = var_ed6db408;
  }

  if(!isDefined(launcher)) {
    return;
  }

  launcher thread function_9cffb95a();
  self startragdoll();
  self clientfield::set("ragdoll_launcher_id", launcher.index);
}

function private function_9cffb95a() {
  self endon(#"death");
  self notify("15629674c8c062da");
  self endon("15629674c8c062da");
  wait 0.5;
  function_12d36686(self.index);
}

function private function_12d36686(index) {
  assert(isentity(level.var_30858358[index]), "<dev string:x91>");
  level.var_30858358[index] deletedelay();
  level.var_30858358[index] = undefined;
}