/************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\behavior_tree_utility.gsc
************************************************************/

#namespace behaviortreenetworkutility;

function registerbehaviortreescriptapi(functionname, functionptr, allowedcallsperframe) {
  if(!isDefined(level._behaviortreescriptfunctions)) {
    level._behaviortreescriptfunctions = [];
  }

  assert(isDefined(functionname) && isDefined(functionptr), "<dev string:x38>");

  if(!is_true(level.var_70f1c402)) {
    assert(!isDefined(level._behaviortreescriptfunctions[functionname]), "<dev string:xaa>");
  }

  level._behaviortreescriptfunctions[functionname] = functionptr;

  if(isDefined(allowedcallsperframe)) {
    registerlimitedbehaviortreeapi(functionname, allowedcallsperframe);
  }
}

function registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
  if(!isDefined(level._behaviortreeactions)) {
    level._behaviortreeactions = [];
  }

  assert(isDefined(actionname), "<dev string:x10a>");

  if(!is_true(level.var_70f1c402)) {
    assert(!isDefined(level._behaviortreeactions[actionname]), "<dev string:x154>" + actionname + "<dev string:x18d>");
  }

  level._behaviortreeactions[actionname] = array();

  if(isDefined(startfuncptr)) {
    assert(isfunctionptr(startfuncptr), "<dev string:x1a8>");
    level._behaviortreeactions[actionname][#"bhtn_action_start"] = startfuncptr;
  }

  if(isDefined(updatefuncptr)) {
    assert(isfunctionptr(updatefuncptr), "<dev string:x1ed>");
    level._behaviortreeactions[actionname][#"bhtn_action_update"] = updatefuncptr;
  }

  if(isDefined(terminatefuncptr)) {
    assert(isfunctionptr(terminatefuncptr), "<dev string:x233>");
    level._behaviortreeactions[actionname][#"bhtn_action_terminate"] = terminatefuncptr;
  }
}