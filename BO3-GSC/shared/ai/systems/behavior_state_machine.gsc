/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\behavior_state_machine.gsc
********************************************************/

#namespace behaviorstatemachine;

function registerbsmscriptapiinternal(functionname, scriptfunction) {
  if(!isDefined(level._bsmscriptfunctions)) {
    level._bsmscriptfunctions = [];
  }
  functionname = tolower(functionname);
  assert(isDefined(scriptfunction) && isDefined(scriptfunction), "");
  assert(!isDefined(level._bsmscriptfunctions[functionname]), "");
  level._bsmscriptfunctions[functionname] = scriptfunction;
}