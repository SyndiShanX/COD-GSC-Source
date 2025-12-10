/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai_shared.csc
*************************************************/

#namespace ai_shared;

function autoexec main() {
  level._customactorcbfunc = &ai::spawned_callback;
}

#namespace ai;

function add_ai_spawn_function(spawn_func) {
  if(!isDefined(level.spawn_ai_func)) {
    level.spawn_ai_func = [];
  }
  func = [];
  func["function"] = spawn_func;
  level.spawn_ai_func[level.spawn_ai_func.size] = func;
}

function add_archetype_spawn_function(archetype, spawn_func) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }
  if(!isDefined(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = [];
  }
  func = [];
  func["function"] = spawn_func;
  if(!isDefined(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = [];
  } else if(!isarray(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = array(level.spawn_funcs[archetype]);
  }
  level.spawn_funcs[archetype][level.spawn_funcs[archetype].size] = func;
}

function spawned_callback(localclientnum) {
  if(isDefined(level.spawn_ai_func)) {
    for(index = 0; index < level.spawn_ai_func.size; index++) {
      func = level.spawn_ai_func[index];
      self thread[[func["function"]]](localclientnum);
    }
  }
  if(isDefined(level.spawn_funcs) && isDefined(level.spawn_funcs[self.archetype])) {
    for(index = 0; index < level.spawn_funcs[self.archetype].size; index++) {
      func = level.spawn_funcs[self.archetype][index];
      self thread[[func["function"]]](localclientnum);
    }
  }
}

function shouldregisterclientfieldforarchetype(archetype) {
  if(isDefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
    return false;
  }
  return true;
}