/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\animation_selector_table.gsc
**********************************************************/

#namespace animationselectortable;

function registeranimationselectortableevaluator(functionname, functionptr) {
  if(!isdefined(level._astevaluatorscriptfunctions)) {
    level._astevaluatorscriptfunctions = [];
  }
  functionname = tolower(functionname);
  assert(isdefined(functionname) && isdefined(functionptr));
  assert(!isdefined(level._astevaluatorscriptfunctions[functionname]));
  level._astevaluatorscriptfunctions[functionname] = functionptr;
}