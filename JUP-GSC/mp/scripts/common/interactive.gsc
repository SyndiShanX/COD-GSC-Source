/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\interactive.gsc
***********************************************/

#using scripts\engine\utility;
#namespace interactive;

function entity_used(entity, player) {
  if(!isDefined(entity.interactive_used_func_id)) {
    return;
  }

  if(!isDefined(level.interactive_used_funcs)) {
    return;
  }

  if(!isDefined(level.interactive_used_funcs[entity.interactive_used_func_id])) {
    return;
  }

  thread[[level.interactive_used_funcs[entity.interactive_used_func_id]]](entity, player);
}

function interactive_addusedcallback(usedcallback, id) {
  if(!isDefined(level.interactive_used_funcs)) {
    level.interactive_used_funcs = [];
    level.interactive_used_funcs_unique_id = 0;
  }

  if(!isDefined(id)) {
    while(isDefined(level.interactive_used_funcs[level.interactive_used_funcs_unique_id])) {
      level.interactive_used_funcs_unique_id++;
    }

    id = level.interactive_used_funcs_unique_id;
    level.interactive_used_funcs_unique_id++;
  }

  level.interactive_used_funcs[id] = usedcallback;
  return id;
}

function interactive_addusedcallbacktoentity(id) {
  self.interactive_used_func_id = id;
}

function interactive_removeusedcallbackfromentity() {
  self.interactive_used_func_id = undefined;
}

function function_366418be14db1a9f(usable, player) {
  if(isDefined(usable.var_d19dfa5205fce031)) {
    result = [[usable.var_d19dfa5205fce031]](usable, player);
    assert(isstruct(result) && isDefined(result.type) && isDefined(result.string));
    return result;
  }

  return undefined;
}

function function_14ec0a1f46d4d2d0(usable, player) {
  if(isDefined(usable.var_ee69e6a611184cfb)) {
    result = [[usable.var_ee69e6a611184cfb]](usable, player);
    return result;
  }

  return 1;
}