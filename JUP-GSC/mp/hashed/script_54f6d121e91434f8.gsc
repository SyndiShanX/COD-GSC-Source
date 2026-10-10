/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_54f6d121e91434f8.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_2ad63d7d28d317d7;

function function_a1f71337a6844055() {
  self.conditions = [];
  self.var_cb7d9fafcbb7a3da = 1;
}

function function_cb7d9fafcbb7a3da() {
  return istrue(self.var_cb7d9fafcbb7a3da);
}

function addcondition(var_21a51c1826b9a6aa, var_92e7ff758311df4f, var_a5bcfea80579d73d, uniquename, description) {
  if(!isDefined(uniquename)) {
    uniquename = undefined;
  }

  if(!isDefined(description)) {
    description = "No Description Given.";
  }

  assertex(var_21a51c1826b9a6aa function_cb7d9fafcbb7a3da(), "<dev string:x1c>");
  conditioninfo = spawnStruct();
  conditioninfo.function = var_92e7ff758311df4f;
  conditioninfo.params = var_a5bcfea80579d73d;
  conditioninfo.uniquename = uniquename;
  conditioninfo.description = description;
  var_21a51c1826b9a6aa.conditions[var_21a51c1826b9a6aa.conditions.size] = conditioninfo;
}

function removecondition(var_21a51c1826b9a6aa, uniquename) {
  assertex(var_21a51c1826b9a6aa function_cb7d9fafcbb7a3da(), "<dev string:x1c>");

  for(index = 0; index < var_21a51c1826b9a6aa.conditions.size; index++) {
    conditioninfo = var_21a51c1826b9a6aa.conditions[index];

    if(isDefined(conditioninfo.uniquename) && conditioninfo.uniquename == uniquename) {
      var_21a51c1826b9a6aa.conditions = array_remove_index(var_21a51c1826b9a6aa.conditions, index);
      break;
    }
  }
}

function function_ff70694fdb2c244a(var_21a51c1826b9a6aa) {
  assertex(var_21a51c1826b9a6aa function_cb7d9fafcbb7a3da(), "<dev string:x1c>");
  var_21a51c1826b9a6aa.conditions = [];
}

function function_93587d5ba6247f36(var_21a51c1826b9a6aa, object) {
  assertex(var_21a51c1826b9a6aa function_cb7d9fafcbb7a3da(), "<dev string:x1c>");

  foreach(condition in var_21a51c1826b9a6aa.conditions) {
    result = [[condition.function]](object, condition.params);

    if(!result) {
      return false;
    }
  }

  return true;
}

function function_ff013f3a89dabca4(var_21a51c1826b9a6aa, object) {
  assertex(var_21a51c1826b9a6aa function_cb7d9fafcbb7a3da(), "<dev string:x1c>");

  foreach(condition in var_21a51c1826b9a6aa.conditions) {
    result = [[condition.function]](object, condition.params);

    if(!result) {
      return function_8a34819737ceea8f(0, condition.description);
    }
  }

  return function_8a34819737ceea8f(1);
}

function function_21987527fd4733ad(var_21a51c1826b9a6aa, object, var_ef09bb69811327d1, var_5288a299caa0504e, var_717b087350a6df2f, var_3b7ed38c07818629) {
  var_cb7d9fafcbb7a3da = var_21a51c1826b9a6aa function_cb7d9fafcbb7a3da();
  objectisdefined = isDefined(object);
  var_3938d5f50103e0fa = isfunction(var_ef09bb69811327d1);
  var_8105433f3dcf58a = !isDefined(var_5288a299caa0504e) || isstruct(var_5288a299caa0504e);
  var_a28904f7e273e263 = 1;

  if(!var_cb7d9fafcbb7a3da) {
    iprintln("<dev string:x92>");
    var_a28904f7e273e263 = 0;
  }

  if(!objectisdefined) {
    iprintln("<dev string:xca>");
    var_a28904f7e273e263 = 0;
  }

  if(!var_3938d5f50103e0fa) {
    iprintln("<dev string:xf6>");
    var_a28904f7e273e263 = 0;
  }

  if(!var_8105433f3dcf58a) {
    iprintln("<dev string:x157>");
    var_a28904f7e273e263 = 0;
  }

  if(!var_a28904f7e273e263) {
    assertmsg("<dev string:x1be>");
    return;
  }

  level thread function_1b7df7adf29a85c6(var_21a51c1826b9a6aa, object, var_ef09bb69811327d1, var_5288a299caa0504e, var_717b087350a6df2f, var_3b7ed38c07818629);
}

function private function_1b7df7adf29a85c6(var_21a51c1826b9a6aa, object, var_ef09bb69811327d1, var_5288a299caa0504e, var_717b087350a6df2f, var_3b7ed38c07818629) {
  var_3b7ed38c07818629 = default_to(var_3b7ed38c07818629, 0.5);
  var_717b087350a6df2f = default_to(var_717b087350a6df2f, 5);
  var_be685114ee68c2f3 = gettime();
  var_3e0486861622f2e1 = 1;

  while(var_3e0486861622f2e1) {
    var_b7d39a4661f3460 = gettime();
    timepassedinseconds = (var_b7d39a4661f3460 - var_be685114ee68c2f3) / 1000;

    if(isDefined(object) && function_93587d5ba6247f36(var_21a51c1826b9a6aa, object)) {
      object thread[[var_ef09bb69811327d1]](var_5288a299caa0504e);
      var_3e0486861622f2e1 = 0;
      return;
    }

    if(timepassedinseconds >= var_717b087350a6df2f) {
      var_3e0486861622f2e1 = 0;
      break;
    }

    wait var_3b7ed38c07818629;
  }
}

function private function_8a34819737ceea8f(var_f422d25d885419b5, description) {
  if(!isDefined(description)) {
    description = "No Description Given.";
  }

  var_2e1dd56cac3d3e71 = spawnStruct();
  var_2e1dd56cac3d3e71.var_3cae69b2d0f4ae72 = var_f422d25d885419b5;
  var_2e1dd56cac3d3e71.var_4b6d8587438ed9aa = description;
  return var_2e1dd56cac3d3e71;
}