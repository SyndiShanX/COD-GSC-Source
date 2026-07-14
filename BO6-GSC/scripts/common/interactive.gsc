/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\interactive.gsc
******************************************/

#namespace interactive;

function event_handler[entity_used] entity_used(entity, player) {
  profilestart();

  if(!isDefined(entity.interactive_used_func_id)) {
    profilestop();
    return;
  }

  if(!isDefined(level.interactive_used_funcs)) {
    profilestop();
    return;
  }

  if(!isDefined(level.interactive_used_funcs[entity.interactive_used_func_id])) {
    profilestop();
    return;
  }

  thread[[level.interactive_used_funcs[entity.interactive_used_func_id]]](entity, player);
  profilestop();
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

function function_bb62c739af2034bc(usable, player) {
  if(isDefined(usable.interact_hint_callback)) {
    result = [[usable.interact_hint_callback]](usable, player);
    assert(isstruct(result) && isDefined(result.type) && (isDefined(result.string) || isDefined(result.title)), "<dev string:x24>");
    return result;
  }

  return undefined;
}

function function_c4873dab195cf2fb(usable, player) {
  if(isDefined(usable.var_1e6940caec363c36)) {
    result = [[usable.var_1e6940caec363c36]](usable, player);
    return result;
  }

  return 1;
}