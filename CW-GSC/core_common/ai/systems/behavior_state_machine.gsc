/*************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\behavior_state_machine.gsc
*************************************************************/

#namespace behaviorstatemachine;

function registerbsmscriptapiinternal(functionname, scriptfunction) {
  if(!isDefined(level._bsmscriptfunctions)) {
    level._bsmscriptfunctions = [];
  }

  assert(isDefined(scriptfunction) && isDefined(scriptfunction), "<dev string:x38>");

  if(!is_true(level.var_70f1c402)) {
    assert(!isDefined(level._bsmscriptfunctions[functionname]), "<dev string:x98>");
  }

  level._bsmscriptfunctions[functionname] = scriptfunction;
}