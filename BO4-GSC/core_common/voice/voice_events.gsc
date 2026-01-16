/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\voice\voice_events.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace voice_events;

autoexec __init__system__() {
  system::register(#"voice_events", &__init__, undefined, undefined);
}

__init__() {
  level.var_d5d1ddd5 = [];
  level.var_a95b39fd = [];
  level.var_fde3243f = [];
}

register_handler(event, handlerfunc) {
  assert(isDefined(event), "<dev string:x38>");
  assert(isfunctionptr(handlerfunc), "<dev string:x5c>");
  funcs = level.var_d5d1ddd5[event];

  if(!isDefined(funcs)) {
    funcs = [];
    level.var_d5d1ddd5[event] = funcs;
  }

  funcs[funcs.size] = handlerfunc;
}

function_840acc1c(event, handlerfunc, priority = 0, var_c10e92a2 = undefined) {
  assert(isDefined(event), "<dev string:x38>");
  assert(isfunctionptr(handlerfunc), "<dev string:x5c>");
  assert(isint(priority) || isfloat(priority), "<dev string:x8f>");
  assert(!isDefined(var_c10e92a2) || isfunctionptr(var_c10e92a2), "<dev string:xab>");
  assert(!isDefined(level.var_a95b39fd[event]), "<dev string:xdf>" + event);
  handler = {
    #handlerfunc: handlerfunc, 
    #priority: priority, 
    #var_c10e92a2: var_c10e92a2
  };
  level.var_a95b39fd[event] = handler;
}

create_queue(queuename) {
  assert(isDefined(queuename), "<dev string:x10b>");
  assert(!isDefined(level.var_fde3243f[queuename]), "<dev string:x150>" + queuename);

  if(!isDefined(queuename) || isDefined(level.var_fde3243f[queuename])) {
    return;
  }

  queue = [];
  level.var_fde3243f[queuename] = queue;
  level thread function_accf7a2e(queue);
}

queue_event(queuename, event, handlerfunc, priority = 0, params = undefined) {
  assert(isDefined(queuename), "<dev string:x186>");
  assert(isDefined(level.var_fde3243f[queuename]), "<dev string:x1ca>" + queuename);
  assert(isDefined(event), "<dev string:x1fc>");
  assert(isfunctionptr(handlerfunc), "<dev string:x23c>");
  assert(isint(priority) || isfloat(priority), "<dev string:x28b>");
  assert(!isDefined(params) || isstruct(params), "<dev string:x2c3>");
  queue = level.var_fde3243f[queuename];

  if(!isDefined(queue) || !isDefined(event) || !isfunctionptr(handlerfunc)) {
    return;
  }

  if(!isint(priority) && !isfloat(priority)) {
    return;
  }

  item = spawnStruct();
  item.context = self;
  item.time = gettime();
  item.event = event;
  item.priority = priority;
  item.handlerfunc = handlerfunc;
  item.params = params;
  queue_item(queue, item);
}

function_c710099c(event, params) {
  funcs = level.var_d5d1ddd5[event];

  if(isDefined(funcs)) {
    foreach(func in funcs) {
      self thread[[func]](event, params);
    }
  }

  handler = level.var_a95b39fd[event];

  if(!isDefined(handler)) {
    return;
  }

  var_c10e92a2 = handler.var_c10e92a2;

  foreach(name, queue in level.var_fde3243f) {
    item = spawnStruct();
    item.context = self;
    item.time = gettime();
    item.priority = handler.priority;
    item.event = event;
    item.handlerfunc = handler.handlerfunc;

    if(isstruct(params)) {
      item.params = structcopy(params);
    }

    if(!isDefined(var_c10e92a2) || self[[var_c10e92a2]](name, queue, item)) {
      queue_item(queue, item);
    }
  }
}

private queue_item(&queue, item) {
  for(i = 0; i < queue.size; i++) {
    if(queue[i].priority < item.priority) {
      break;
    }
  }

  arrayinsert(queue, item, i);
}

private function_accf7a2e(&queue) {
  level endon(#"game_ended");

  while(true) {
    while(queue.size > 0) {
      item = queue[0];
      arrayremoveindex(queue, 0);

      if(!isDefined(item.context)) {
        continue;
      }

      item.context[[item.handlerfunc]](item.event, item.params);
    }

    waitframe(1);
  }
}