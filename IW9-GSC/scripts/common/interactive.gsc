/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\interactive.gsc
***********************************************/

entity_used(entity, player) {
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

interactive_addusedcallback(_id_055AA0066A9F3E9F, id) {
  if(!isDefined(level.interactive_used_funcs)) {
    level.interactive_used_funcs = [];
    level.interactive_used_funcs_unique_id = 0;
  }

  if(!isDefined(id)) {
    while(isDefined(level.interactive_used_funcs[level.interactive_used_funcs_unique_id]))
      level.interactive_used_funcs_unique_id++;

    id = level.interactive_used_funcs_unique_id;
    level.interactive_used_funcs_unique_id++;
  }

  level.interactive_used_funcs[id] = _id_055AA0066A9F3E9F;
  return id;
}

interactive_addusedcallbacktoentity(id) {
  self.interactive_used_func_id = id;
}

interactive_removeusedcallbackfromentity() {
  self.interactive_used_func_id = undefined;
}