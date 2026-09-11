/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\interactive.gsc
***********************************************/

function entity_used(var_0, var_1) {
  if(!isDefined(var_0.interactive_used_func_id)) {
    return;
  }

  if(!isDefined(level.interactive_used_funcs)) {
    return;
  }

  if(!isDefined(level.interactive_used_funcs[var_0.interactive_used_func_id])) {
    return;
  }

  GscBinSkip1(0x74, level.interactive_used_funcs[var_0.interactive_used_func_id], var_0, var_1);
}

function interactive_addusedcallback(var_0, var_1) {
  if(!isDefined(level.interactive_used_funcs)) {
    level.interactive_used_funcs = [];
    level.interactive_used_funcs_unique_id = 0;
  }

  if(!isDefined(var_1)) {
    while(isDefined(level.interactive_used_funcs[level.interactive_used_funcs_unique_id])) {
      level.interactive_used_funcs_unique_id++;
    }

    var_1 = level.interactive_used_funcs_unique_id;
    level.interactive_used_funcs_unique_id++;
  }

  level.interactive_used_funcs[var_1] = var_0;
  return var_1;
}

function interactive_addusedcallbacktoentity(var_0) {
  self.interactive_used_func_id = var_0;
}

function interactive_removeusedcallbackfromentity() {
  self.interactive_used_func_id = undefined;
}