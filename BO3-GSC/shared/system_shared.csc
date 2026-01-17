/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\system_shared.csc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#namespace system;

function register(str_system, func_preinit, func_postinit, reqs = []) {
  if(isDefined(level.system_funcs) && isDefined(level.system_funcs[str_system])) {
    return;
  }
  if(!isDefined(level.system_funcs)) {
    level.system_funcs = [];
  }
  level.system_funcs[str_system] = spawnStruct();
  level.system_funcs[str_system].prefunc = func_preinit;
  level.system_funcs[str_system].postfunc = func_postinit;
  level.system_funcs[str_system].reqs = reqs;
  level.system_funcs[str_system].predone = !isDefined(func_preinit);
  level.system_funcs[str_system].postdone = !isDefined(func_postinit);
  level.system_funcs[str_system].ignore = 0;
}

function exec_post_system(req) {
  if(!isDefined(level.system_funcs[req])) {
    assertmsg(("" + req) + "");
  }
  if(level.system_funcs[req].ignore) {
    return;
  }
  if(!level.system_funcs[req].postdone) {
    [[level.system_funcs[req].postfunc]]();
    level.system_funcs[req].postdone = 1;
  }
}

function run_post_systems() {
  foreach(key, func in level.system_funcs) {
    assert(func.predone || func.ignore, "");
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        thread exec_post_system(req);
      }
    } else {
      thread exec_post_system(func.reqs);
    }
    thread exec_post_system(key);
  }
  if(!level flag::exists("system_init_complete")) {
    level flag::init("system_init_complete", 0);
  }
  level flag::set("system_init_complete");
}

function exec_pre_system(req) {
  if(!isDefined(level.system_funcs[req])) {
    assertmsg(("" + req) + "");
  }
  if(level.system_funcs[req].ignore) {
    return;
  }
  if(!level.system_funcs[req].predone) {
    [[level.system_funcs[req].prefunc]]();
    level.system_funcs[req].predone = 1;
  }
}

function run_pre_systems() {
  foreach(key, func in level.system_funcs) {
    if(isarray(func.reqs)) {
      foreach(req in func.reqs) {
        thread exec_pre_system(req);
      }
    } else {
      thread exec_pre_system(func.reqs);
    }
    thread exec_pre_system(key);
  }
}

function wait_till(required_systems) {
  if(!level flag::exists("system_init_complete")) {
    level flag::init("system_init_complete", 0);
  }
  level flag::wait_till("system_init_complete");
}

function ignore(str_system) {
  assert(!isDefined(level.gametype), "");
  if(!isDefined(level.system_funcs) || !isDefined(level.system_funcs[str_system])) {
    register(str_system, undefined, undefined, undefined);
  }
  level.system_funcs[str_system].ignore = 1;
}

function is_system_running(str_system) {
  if(!isDefined(level.system_funcs) || !isDefined(level.system_funcs[str_system])) {
    return 0;
  }
  return level.system_funcs[str_system].postdone;
}