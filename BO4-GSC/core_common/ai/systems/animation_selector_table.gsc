/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\animation_selector_table.gsc
***************************************************************/

#namespace animationselectortable;

registeranimationselectortableevaluator(functionname, functionptr) {
  if(!isDefined(level._astevaluatorscriptfunctions)) {
    level._astevaluatorscriptfunctions = [];
  }

  functionname = tolower(functionname);
  assert(isDefined(functionname) && isDefined(functionptr));
  assert(!isDefined(level._astevaluatorscriptfunctions[functionname]));
  level._astevaluatorscriptfunctions[functionname] = functionptr;
}