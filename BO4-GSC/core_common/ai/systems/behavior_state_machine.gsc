/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\behavior_state_machine.gsc
*************************************************************/

#namespace behaviorstatemachine;

registerbsmscriptapiinternal(functionname, scriptfunction) {
  if(!isDefined(level._bsmscriptfunctions)) {
    level._bsmscriptfunctions = [];
  }

  assert(isDefined(scriptfunction) && isDefined(scriptfunction), "<dev string:x38>");
  assert(!isDefined(level._bsmscriptfunctions[functionname]), "<dev string:x97>");
  level._bsmscriptfunctions[functionname] = scriptfunction;
}