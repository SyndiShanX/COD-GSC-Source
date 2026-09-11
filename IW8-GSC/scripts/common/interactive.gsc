/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\interactive.gsc
***********************************************/

function entity_used(var0, var1) {
  if(!isDefined(var0.interactive_used_func_id)) {
    return;
  }

  if(!isDefined(level.interactive_used_funcs)) {
    return;
  }

  if(!isDefined(level.interactive_used_funcs[var0.interactive_used_func_id])) {
    return;
  }

  GscBinSkip1(0x74, level.interactive_used_funcs[var0.interactive_used_func_id], var0, var1);
}

function interactive_addusedcallback(var0, var1) {
  if(!isDefined(level.interactive_used_funcs)) {
    level.interactive_used_funcs = [];
    level.interactive_used_funcs_unique_id = 0;
  }

  if(!isDefined(var1)) {
    while(isDefined(level.interactive_used_funcs[level.interactive_used_funcs_unique_id])) {
      level.interactive_used_funcs_unique_id++;
    }

    var1 = level.interactive_used_funcs_unique_id;
    level.interactive_used_funcs_unique_id++;
  }

  level.interactive_used_funcs[var1] = var0;
  return var1;
}

function interactive_addusedcallbacktoentity(var0) {
  self.interactive_used_func_id = var0;
}

function interactive_removeusedcallbackfromentity() {
  self.interactive_used_func_id = undefined;
}