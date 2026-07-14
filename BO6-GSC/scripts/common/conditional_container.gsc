/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\conditional_container.gsc
****************************************************/

#using scripts\engine\utility;
#namespace conditional_container;

function function_e235be9fe32422e8() {
  self.conditions = [];
  self.var_c8c41d427db6c4ef = 1;
}

function function_c8c41d427db6c4ef() {
  return istrue(self.var_c8c41d427db6c4ef);
}

function addcondition(conditionalcontainer, conditionalfunction, var_13191a8dc227bdb0, uniquename = undefined, description = "pz\xa8k\x1f^ *\x80\xd2\x96\xd9\x04\x1e\xa2\xa1b\xd9}\x01\xb5") {
  assert(conditionalcontainer function_c8c41d427db6c4ef(), "<dev string:x24>");
  conditioninfo = spawnStruct();
  conditioninfo.function = conditionalfunction;
  conditioninfo.params = var_13191a8dc227bdb0;
  conditioninfo.uniquename = uniquename;
  conditioninfo.description = description;
  conditionalcontainer.conditions[conditionalcontainer.conditions.size] = conditioninfo;
}

function removecondition(conditionalcontainer, uniquename) {
  assert(conditionalcontainer function_c8c41d427db6c4ef(), "<dev string:x24>");

  for(index = 0; index < conditionalcontainer.conditions.size; index++) {
    conditioninfo = conditionalcontainer.conditions[index];

    if(isDefined(conditioninfo.uniquename) && conditioninfo.uniquename == uniquename) {
      conditionalcontainer.conditions = utility::array_remove_index(conditionalcontainer.conditions, index);
      break;
    }
  }
}

function removeallconditions(conditionalcontainer) {
  assert(conditionalcontainer function_c8c41d427db6c4ef(), "<dev string:x24>");
  conditionalcontainer.conditions = [];
}

function function_ac8003c33335a40f(conditionalcontainer, object) {
  assert(conditionalcontainer function_c8c41d427db6c4ef(), "<dev string:x24>");

  foreach(condition in conditionalcontainer.conditions) {
    result = [[condition.function]](object, condition.params);

    if(!result) {
      return false;
    }
  }

  return true;
}

function function_842ec868071aa01(conditionalcontainer, object) {
  assert(conditionalcontainer function_c8c41d427db6c4ef(), "<dev string:x24>");

  foreach(condition in conditionalcontainer.conditions) {
    result = [[condition.function]](object, condition.params);

    if(!result) {
      return function_8f05256e3889764e(0, condition.description);
    }
  }

  return function_8f05256e3889764e(1);
}

function function_686ab16ee1028ef8(conditionalcontainer, object, var_6849427c17ac801c, var_697421e27d38a8b, var_da26f4bd13fcbfde, var_a3b4ebf9d5a4f00c) {
  var_c8c41d427db6c4ef = conditionalcontainer function_c8c41d427db6c4ef();
  objectisdefined = isDefined(object);
  var_773eced8f1562ac3 = isfunction(var_6849427c17ac801c);
  var_ec78c42e8d330ffb = !isDefined(var_697421e27d38a8b) || isstruct(var_697421e27d38a8b);
  var_9f74cdaad351e5aa = 1;

  if(!var_c8c41d427db6c4ef) {
    iprintln("<dev string:x9a>");
    var_9f74cdaad351e5aa = 0;
  }

  if(!objectisdefined) {
    iprintln("<dev string:xd2>");
    var_9f74cdaad351e5aa = 0;
  }

  if(!var_773eced8f1562ac3) {
    iprintln("<dev string:xfe>");
    var_9f74cdaad351e5aa = 0;
  }

  if(!var_ec78c42e8d330ffb) {
    iprintln("<dev string:x15f>");
    var_9f74cdaad351e5aa = 0;
  }

  if(!var_9f74cdaad351e5aa) {
    assertmsg("<dev string:x1c6>");
    return;
  }

  level thread function_7b01391418c5955b(conditionalcontainer, object, var_6849427c17ac801c, var_697421e27d38a8b, var_da26f4bd13fcbfde, var_a3b4ebf9d5a4f00c);
}

function private function_7b01391418c5955b(conditionalcontainer, object, var_6849427c17ac801c, var_697421e27d38a8b, var_da26f4bd13fcbfde = 5, var_a3b4ebf9d5a4f00c = 0.5) {
  var_a1196f031fda9b46 = gettime();
  shouldcontinuecheckingconditions = 1;

  while(shouldcontinuecheckingconditions) {
    var_5cddad9708503a49 = gettime();
    timepassedinseconds = (var_5cddad9708503a49 - var_a1196f031fda9b46) / 1000;

    if(isDefined(object) && function_ac8003c33335a40f(conditionalcontainer, object)) {
      object thread[[var_6849427c17ac801c]](var_697421e27d38a8b);
      shouldcontinuecheckingconditions = 0;
      return;
    }

    if(timepassedinseconds >= var_da26f4bd13fcbfde) {
      shouldcontinuecheckingconditions = 0;
      break;
    }

    wait var_a3b4ebf9d5a4f00c;
  }
}

function private function_8f05256e3889764e(var_d3af8c29bfe0a478, description = "pz\xa8k\x1f^ *\x80\xd2\x96\xd9\x04\x1e\xa2\xa1b\xd9}\x01\xb5") {
  var_d5ea1c68a25283d4 = spawnStruct();
  var_d5ea1c68a25283d4.var_7e345f8f7da0e7f = var_d3af8c29bfe0a478;
  var_d5ea1c68a25283d4.var_fee0db179ee578bb = description;
  return var_d5ea1c68a25283d4;
}