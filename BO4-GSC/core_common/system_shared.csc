/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\system_shared.csc
***********************************************/

#include scripts\core_common\flagsys_shared;

#namespace system;

register(str_name, func_preinit, func_postinit, reqs) {
  if(isDefined(level.system_funcs) && isDefined(level.system_funcs[str_name])) {
    assert(level.system_funcs[str_name].ignore, "<dev string:x38>" + function_9e72a96(str_name) + "<dev string:x43>");
    return;
  }

  if(!isDefined(level.system_funcs)) {
    level.system_funcs = [];
  }

  level.system_funcs[str_name] = spawnStruct();
  level.system_funcs[str_name].prefunc = func_preinit;
  level.system_funcs[str_name].postfunc = func_postinit;
  level.system_funcs[str_name].reqs = reqs;
  level.system_funcs[str_name].predone = !isDefined(func_preinit);
  level.system_funcs[str_name].postdone = !isDefined(func_postinit);
  level.system_funcs[str_name].ignore = 0;
}

exec_post_system(func) {
  if(!isDefined(func) || isDefined(func.ignore) && func.ignore) {
    return;
  }

  if(!func.postdone) {
    if(isDefined(func.reqs)) {
      function_5095b2c6(func);
    }

    func.postdone = 1;
    [[func.postfunc]]();
  }
}

function_5095b2c6(func) {
  assert(func.predone || func.ignore, "<dev string:x8d>");

  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        assert(isDefined(req), "<dev string:xf8>" + req + "<dev string:x120>");
        thread exec_post_system(level.system_funcs[req]);
      }

      return;
    }

    assert(isDefined(level.system_funcs[func.reqs]), "<dev string:xf8>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x120>");
    thread exec_post_system(level.system_funcs[func.reqs]);
  }
}

run_post_systems() {
  foreach(func in level.system_funcs) {
    function_5095b2c6(func);
    thread exec_post_system(func);
  }

  level flagsys::set("system_init_complete");
  level.system_funcs = undefined;
}

exec_pre_system(func) {
  if(!isDefined(func) || isDefined(func.ignore) && func.ignore) {
    return;
  }

  if(!func.predone) {
    if(isDefined(func.reqs)) {
      function_8dfa23e0(func);
    }

    [[func.prefunc]]();
    func.predone = 1;
  }
}

function_8dfa23e0(func) {
  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        assert(isDefined(req), "<dev string:xf8>" + req + "<dev string:x120>");
        thread exec_pre_system(level.system_funcs[req]);
      }

      return;
    }

    assert(isDefined(level.system_funcs[func.reqs]), "<dev string:xf8>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x120>");
    thread exec_pre_system(level.system_funcs[func.reqs]);
  }
}

run_pre_systems() {
  foreach(func in level.system_funcs) {
    function_8dfa23e0(func);
    thread exec_pre_system(func);
  }
}

wait_till(required_systems) {
  level flagsys::wait_till("system_init_complete");
}

ignore(str_name) {
  assert(!isDefined(level.gametype), "<dev string:x124>");

  if(!isDefined(level.system_funcs) || !isDefined(level.system_funcs[str_name])) {
    register(str_name, undefined, undefined, undefined);
  }

  level.system_funcs[str_name].ignore = 1;
}