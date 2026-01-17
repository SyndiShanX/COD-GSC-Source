/*******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\behavior_tree_utility.gsc
*******************************************************/

#namespace behaviortreenetwork;

function registerbehaviortreescriptapiinternal(functionname, functionptr) {
  if(!isDefined(level._behaviortreescriptfunctions)) {
    level._behaviortreescriptfunctions = [];
  }
  functionname = tolower(functionname);
  assert(isDefined(functionname) && isDefined(functionptr), "");
  assert(!isDefined(level._behaviortreescriptfunctions[functionname]), "");
  level._behaviortreescriptfunctions[functionname] = functionptr;
}

function registerbehaviortreeactioninternal(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
  if(!isDefined(level._behaviortreeactions)) {
    level._behaviortreeactions = [];
  }
  actionname = tolower(actionname);
  assert(isstring(actionname), "");
  assert(!isDefined(level._behaviortreeactions[actionname]), ("" + actionname) + "");
  level._behaviortreeactions[actionname] = array();
  if(isDefined(startfuncptr)) {
    assert(isfunctionptr(startfuncptr), "");
    level._behaviortreeactions[actionname]["bhtn_action_start"] = startfuncptr;
  }
  if(isDefined(updatefuncptr)) {
    assert(isfunctionptr(updatefuncptr), "");
    level._behaviortreeactions[actionname]["bhtn_action_update"] = updatefuncptr;
  }
  if(isDefined(terminatefuncptr)) {
    assert(isfunctionptr(terminatefuncptr), "");
    level._behaviortreeactions[actionname]["bhtn_action_terminate"] = terminatefuncptr;
  }
}

#namespace behaviortreenetworkutility;

function registerbehaviortreescriptapi(functionname, functionptr) {
  behaviortreenetwork::registerbehaviortreescriptapiinternal(functionname, functionptr);
}

function registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
  behaviortreenetwork::registerbehaviortreeactioninternal(actionname, startfuncptr, updatefuncptr, terminatefuncptr);
}