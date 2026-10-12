/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\system.gsc
***********************************************/

#using scripts\engine\utility;
#namespace system;

function register(str_name, reqs, func_preinit, func_postinit) {
  print("<dev string:x1c>" + (isxhash(str_name) ? getxhashsourcename(str_name) : str_name));

  level.system_funcs = default_to(level.system_funcs, []);

  if(isDefined(level.system_funcs[str_name])) {
    if(!(level.system_funcs[str_name].flags & 1)) {
      system_error("<dev string:x32>" + (isxhash(str_name) ? getxhashsourcename(str_name) : str_name) + "<dev string:x3e>");
    }

    return;
  }

  system = {
    #flags: 0, #reqs: reqs, #postfunc: func_postinit, #prefunc: func_preinit
  };
  system.flags |= isDefined(func_preinit) ? 0 : 2;
  system.flags |= isDefined(func_postinit) ? 0 : 4;
  level.system_funcs[str_name] = system;
}

function ignore(str_name) {
  if(isDefined(level.gametype)) {
    system_error("<dev string:x89>");
    return;
  }

  if(!isDefined(level.system_funcs[str_name])) {
    register(str_name);
  }

  level.system_funcs[str_name].flags |= 1;
}

function function_9c9c8162e507420() {
  if(!isDefined(level.system_funcs)) {
    return;
  }

  foreach(func in level.system_funcs) {
    function_5d3461c8ae875db7(func);

    if(!(func.flags & 8)) {
      thread exec_pre_system(func);
    }
  }
}

function function_d9624eb09b844ca1() {
  if(!isDefined(level.system_funcs)) {
    return;
  }

  foreach(func in level.system_funcs) {
    function_59d1eeac261314c4(func);

    if(!(func.flags & 8)) {
      thread exec_post_system(func);
    }
  }

  level.system_funcs = undefined;
  level flag_set("system_postinit_complete");
}

function private exec_post_system(func) {
  if(!isDefined(func) || func.flags & 1) {
    return;
  }

  if(!(func.flags & 4)) {
    if(isDefined(func.reqs)) {
      function_59d1eeac261314c4(func);
    }

    func.flags |= 4;
    [[func.postfunc]]();
  }
}

function private function_59d1eeac261314c4(func) {
  if(!(func.flags & 2 || func.flags & 1)) {
    system_error("<dev string:xc6>");
    func.flags |= 8;
    return;
  }

  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        if(!isDefined(req)) {
          system_error("<dev string:x132>" + req + "<dev string:x15b>");
          func.flags |= 8;
          continue;
        }

        thread exec_post_system(level.system_funcs[req]);
      }

      return;
    }

    if(!isDefined(level.system_funcs[func.reqs])) {
      system_error("<dev string:x132>" + (isxhash(func.reqs) ? getxhashsourcename(func.reqs) : func.reqs) + "<dev string:x15b>");
      func.flags |= 8;
      return;
    }

    thread exec_post_system(level.system_funcs[func.reqs]);
  }
}

function private exec_pre_system(func) {
  if(!isDefined(func) || func.flags & 1) {
    return;
  }

  if(!(func.flags & 2)) {
    if(isDefined(func.reqs)) {
      function_5d3461c8ae875db7(func);
    }

    [[func.prefunc]]();
    func.flags |= 2;
  }
}

function private function_5d3461c8ae875db7(func) {
  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        if(!isDefined(req)) {
          system_error("<dev string:x132>" + req + "<dev string:x15b>");
          func.flags |= 8;
          continue;
        }

        thread exec_pre_system(level.system_funcs[req]);
      }

      return;
    }

    if(!isDefined(level.system_funcs[func.reqs])) {
      system_error("<dev string:x132>" + (isxhash(func.reqs) ? getxhashsourcename(func.reqs) : func.reqs) + "<dev string:x15b>");
      func.flags |= 8;
      return;
    }

    thread exec_pre_system(level.system_funcs[func.reqs]);
  }
}

function function_3f680182ad0b9ef7() {
  level flag_wait("system_postinit_complete");
}

function system_error(msg) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    print("<dev string:x160>" + msg);
    return;
  }

  assertmsg(msg);
}