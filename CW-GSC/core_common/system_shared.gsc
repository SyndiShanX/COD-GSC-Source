/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\system_shared.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#namespace system;

function register(str_name, func_preinit, func_postinit, var_e9137475, reqs) {
  if(isDefined(level.system_funcs[str_name])) {
    assert(level.system_funcs[str_name].flags & 1, "<dev string:x38>" + function_9e72a96(str_name) + "<dev string:x44>");
    return;
  }

  if(!isDefined(level.system_funcs)) {
    level.system_funcs = [];
  }

  system = {
    #prefunc: func_preinit, #postfunc: func_postinit, #var_f30a1800: var_e9137475, #reqs: reqs, #flags: 0
  };
  system.flags |= isDefined(func_preinit) ? 0 : 2;
  system.flags |= isDefined(func_postinit) ? 0 : 4;
  system.flags |= isDefined(var_e9137475) ? 0 : 8;
  level.system_funcs[str_name] = system;
}

function exec_post_system(func) {
  if(!isDefined(func) || func.flags & 1) {
    return;
  }

  if(!(func.flags & 4)) {
    if(isDefined(func.reqs)) {
      function_5095b2c6(func);
    }

    func.flags |= 4;
    [[func.postfunc]]();
  }
}

function function_5095b2c6(func) {
  assert(func.flags & 2 || func.flags & 1, "<dev string:x8f>");

  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        assert(isDefined(req), "<dev string:xfb>" + req + "<dev string:x124>");
        thread exec_post_system(level.system_funcs[req]);
      }

      return;
    }

    assert(isDefined(level.system_funcs[func.reqs]), "<dev string:xfb>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x124>");
    thread exec_post_system(level.system_funcs[func.reqs]);
  }
}

function run_post_systems() {
  foreach(func in level.system_funcs) {
    function_5095b2c6(func);
    thread exec_post_system(func);
  }

  level flag::set("system_postinit_complete");
}

function exec_pre_system(func) {
  if(!isDefined(func) || func.flags & 1) {
    return;
  }

  if(!(func.flags & 2)) {
    if(isDefined(func.reqs)) {
      function_8dfa23e0(func);
    }

    [[func.prefunc]]();
    func.flags |= 2;
  }
}

function function_8dfa23e0(func) {
  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        assert(isDefined(req), "<dev string:xfb>" + req + "<dev string:x124>");
        thread exec_pre_system(level.system_funcs[req]);
      }

      return;
    }

    assert(isDefined(level.system_funcs[func.reqs]), "<dev string:xfb>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x124>");
    thread exec_pre_system(level.system_funcs[func.reqs]);
  }
}

function run_pre_systems() {
  foreach(func in level.system_funcs) {
    function_8dfa23e0(func);
    thread exec_pre_system(func);
  }
}

function function_6cc01f0(func) {
  if(!isDefined(func) || func.flags & 1) {
    return;
  }

  if(!(func.flags & 8)) {
    if(isDefined(func.reqs)) {
      function_3e3686fa(func);
    }

    [[func.var_f30a1800]]();
    func.flags |= 8;
  }
}

function function_3e3686fa(func) {
  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        assert(isDefined(req), "<dev string:xfb>" + req + "<dev string:x124>");
        thread function_6cc01f0(level.system_funcs[req]);
      }

      return;
    }

    assert(isDefined(level.system_funcs[func.reqs]), "<dev string:xfb>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x124>");
    thread function_6cc01f0(level.system_funcs[func.reqs]);
  }
}

function function_b1553822() {
  foreach(func in level.system_funcs) {
    function_3e3686fa(func);
    thread function_6cc01f0(func);
  }

  level.system_funcs = undefined;
}

function function_c11b0642() {
  level flag::wait_till(#"system_postinit_complete");
}

function ignore(str_name) {
  assert(!isDefined(level.gametype), "<dev string:x129>");

  if(!isDefined(level.system_funcs[str_name])) {
    register(str_name);
  }

  level.system_funcs[str_name].flags |= 1;
}