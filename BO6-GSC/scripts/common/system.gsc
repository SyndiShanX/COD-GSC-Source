/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\system.gsc
**************************************/

#using scripts\engine\utility;
#namespace system;

function register(str_name, reqs, func_preinit, func_postinit) {
  print("<dev string:x24>" + (isxhash(str_name) ? getxhashsourcename(str_name) : str_name) + "<dev string:x3a>");

  if(!isDefined(level.system_funcs)) {
    level.system_funcs = [];
  }

  if(isDefined(level.system_funcs[str_name])) {
    if(!(level.system_funcs[str_name].flags & 1)) {
      system_error("<dev string:x40>" + (isxhash(str_name) ? getxhashsourcename(str_name) : str_name) + "<dev string:x4c>");
    }

    return;
  }

  system = {
    #flags: 0, #reqs: reqs, #postfunc: func_postinit, #prefunc: func_preinit, #systemname: str_name
  };
  system.flags |= !isDefined(func_preinit) ? 2 : 0;
  system.flags |= !isDefined(func_postinit) ? 4 : 0;
  level.system_funcs[str_name] = system;
}

function ignore(str_name) {
  if(!isDefined(level.system_funcs[str_name])) {
    register(str_name);
  }

  if(isDefined(level.system_funcs[str_name].prefunc) && level.system_funcs[str_name].flags & 2) {
    system_error("Ignored systems must be set before pre_main begins for that system, use autoexec to ignore immediately without any waits.");
    return;
  }

  level.system_funcs[str_name].flags |= 1;
}

function event_handler[event_7b93597c75b40af7] function_10e3c751b4555649() {
  if(!isDefined(level.system_funcs)) {
    return;
  }

  utility::flag_set("system_preinit_started");

  foreach(func in level.system_funcs) {
    function_3b60b24986df0b24(func);

    if(!(func.flags & 8)) {
      thread exec_pre_system(func);
    }
  }

  utility::flag_set("system_preinit_complete");
}

function event_handler[event_14fc8041665deb8e] function_10a47e33bee6ee46() {
  if(!isDefined(level.system_funcs)) {
    return;
  }

  foreach(func in level.system_funcs) {
    function_895434efc7b1807d(func);

    if(!(func.flags & 8)) {
      thread exec_post_system(func);
    }
  }

  level.system_funcs = undefined;
  utility::flag_set("system_postinit_complete");
}

function private exec_post_system(func) {
  if(!isDefined(func) || func.flags & 1) {
    return;
  }

  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        if(level.system_funcs[req].flags & 1) {
          level.system_funcs[func.systemname].flags |= 1;
          return;
        }
      }
    } else if(level.system_funcs[func.reqs].flags & 1) {
      level.system_funcs[func.systemname].flags |= 1;
      return;
    }
  }

  if(!(func.flags & 4)) {
    if(isDefined(func.reqs)) {
      function_895434efc7b1807d(func);
    }

    func.flags |= 4;
    [[func.postfunc]]();
  }
}

function private function_895434efc7b1807d(func) {
  if(!(func.flags & 2 || func.flags & 1)) {
    system_error("<dev string:x97>");
    func.flags |= 8;
    return;
  }

  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        if(!isDefined(req)) {
          system_error("<dev string:x103>" + req + "<dev string:x12c>");
          func.flags |= 8;
          continue;
        }

        thread exec_post_system(level.system_funcs[req]);
      }

      return;
    }

    if(!isDefined(level.system_funcs[func.reqs])) {
      system_error("<dev string:x103>" + (isxhash(func.reqs) ? getxhashsourcename(func.reqs) : func.reqs) + "<dev string:x12c>");
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

  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        if(level.system_funcs[req].flags & 1) {
          level.system_funcs[func.systemname].flags |= 1;
          return;
        }
      }
    } else if(level.system_funcs[func.reqs].flags & 1) {
      level.system_funcs[func.systemname].flags |= 1;
      return;
    }
  }

  if(!(func.flags & 2)) {
    if(isDefined(func.reqs)) {
      function_3b60b24986df0b24(func);
    }

    [[func.prefunc]]();
    func.flags |= 2;
  }
}

function private function_3b60b24986df0b24(func) {
  if(isDefined(func.reqs)) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        if(!isDefined(req)) {
          system_error("<dev string:x103>" + req + "<dev string:x12c>");
          func.flags |= 8;
          continue;
        }

        thread exec_pre_system(level.system_funcs[req]);
      }

      return;
    }

    if(!isDefined(level.system_funcs[func.reqs])) {
      system_error("<dev string:x103>" + (isxhash(func.reqs) ? getxhashsourcename(func.reqs) : func.reqs) + "<dev string:x12c>");
      func.flags |= 8;
      return;
    }

    thread exec_pre_system(level.system_funcs[func.reqs]);
  }
}

function function_eca4bddb3f37e51b() {
  level utility::flag_wait("system_preinit_complete");
}

function function_85885b7687429f06() {
  level utility::flag_wait("system_postinit_complete");
}

function system_error(msg) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    print("<dev string:x131>" + msg);
    return;
  }

  assertmsg(msg);
}