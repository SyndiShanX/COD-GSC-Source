/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\animation_selector_table.gsc
**********************************************************/

#namespace animationselectortable;

function registeranimationselectortableevaluator(functionname, functionptr) {
  if(!isDefined(level._astevaluatorscriptfunctions)) {
    level._astevaluatorscriptfunctions = [];
  }
  functionname = tolower(functionname);
  assert(isDefined(functionname) && isDefined(functionptr));
  assert(!isDefined(level._astevaluatorscriptfunctions[functionname]));
  level._astevaluatorscriptfunctions[functionname] = functionptr;
}