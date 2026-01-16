/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\behavior_tree_utility.gsc
************************************************************/

#namespace behaviortreenetworkutility;

registerbehaviortreescriptapi(functionname, functionptr, allowedcallsperframe) {
  if(!isDefined(level._behaviortreescriptfunctions)) {
    level._behaviortreescriptfunctions = [];
  }

  assert(isDefined(functionname) && isDefined(functionptr), "<dev string:x38>");
  assert(!isDefined(level._behaviortreescriptfunctions[functionname]), "<dev string:xa9>");
  level._behaviortreescriptfunctions[functionname] = functionptr;

  if(isDefined(allowedcallsperframe)) {
    registerlimitedbehaviortreeapi(functionname, allowedcallsperframe);
  }
}

registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
  if(!isDefined(level._behaviortreeactions)) {
    level._behaviortreeactions = [];
  }

  assert(isDefined(actionname), "<dev string:x108>");
  assert(!isDefined(level._behaviortreeactions[actionname]), "<dev string:x151>" + actionname + "<dev string:x189>");
  level._behaviortreeactions[actionname] = array();

  if(isDefined(startfuncptr)) {
    assert(isfunctionptr(startfuncptr), "<dev string:x1a3>");
    level._behaviortreeactions[actionname][#"bhtn_action_start"] = startfuncptr;
  }

  if(isDefined(updatefuncptr)) {
    assert(isfunctionptr(updatefuncptr), "<dev string:x1e7>");
    level._behaviortreeactions[actionname][#"bhtn_action_update"] = updatefuncptr;
  }

  if(isDefined(terminatefuncptr)) {
    assert(isfunctionptr(terminatefuncptr), "<dev string:x22c>");
    level._behaviortreeactions[actionname][#"bhtn_action_terminate"] = terminatefuncptr;
  }
}