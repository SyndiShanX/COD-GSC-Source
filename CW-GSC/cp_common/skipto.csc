/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\skipto.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace skipto;

function private autoexec __init__system__() {
  system::register(#"skipto", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level flag::init("level_has_skiptos");
  level flag::init("level_has_skipto_branches");
  level.var_28c22d88 = [];
  clientfield::register("toplayer", "catch_up_transition", 1, 1, "counter", &catch_up_transition, 0, 0);
  clientfield::register("world", "set_last_map_dvar", 1, 1, "counter", &set_last_map_dvar, 0, 0);
  level.var_46d8992a = "_default";
  function_7d6f76df("_default");
  function_7d6f76df("no_game");
  function_16ad9e86(#"gamedata/tables/cp/cp_mapmissions.csv", util::get_map_name());
  level thread function_e377e813();
  level thread function_17cc9832();
}

function private postinit() {
  level thread handle();
}

function add(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func) {
  if(is_dev(skipto)) {
    errormsg("<dev string:x38>");
    return;
  }

  if(isDefined(level.var_70b370e5)) {
    if(isDefined(level.var_c55064fd[level.var_70b370e5])) {
      if(!isDefined(level.var_c55064fd[level.var_70b370e5].var_89f09f8d)) {
        level.var_c55064fd[level.var_70b370e5].var_89f09f8d = [];
      } else if(!isarray(level.var_c55064fd[level.var_70b370e5].var_89f09f8d)) {
        level.var_c55064fd[level.var_70b370e5].var_89f09f8d = array(level.var_c55064fd[level.var_70b370e5].var_89f09f8d);
      }

      level.var_c55064fd[level.var_70b370e5].var_89f09f8d[level.var_c55064fd[level.var_70b370e5].var_89f09f8d.size] = skipto;
    }

    var_672c77b1 = level.var_70b370e5;
  } else {
    if(isDefined(level.var_c55064fd[level.var_46d8992a])) {
      if(!isDefined(level.var_c55064fd[level.var_46d8992a].var_89f09f8d)) {
        level.var_c55064fd[level.var_46d8992a].var_89f09f8d = [];
      } else if(!isarray(level.var_c55064fd[level.var_46d8992a].var_89f09f8d)) {
        level.var_c55064fd[level.var_46d8992a].var_89f09f8d = array(level.var_c55064fd[level.var_46d8992a].var_89f09f8d);
      }

      level.var_c55064fd[level.var_46d8992a].var_89f09f8d[level.var_c55064fd[level.var_46d8992a].var_89f09f8d.size] = skipto;
    }

    var_672c77b1 = level.var_46d8992a;
  }

  level.var_70b370e5 = skipto;

  if(!isDefined(var_e784b061)) {
    assert(isDefined(var_e784b061), "<dev string:x5f>");
  }

  struct = function_7d6f76df(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, undefined);
  struct.public = 1;
  level flag::set("level_has_skiptos");
}

function function_9c003a50(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d) {
  if(!isDefined(level.var_46d8992a)) {
    level.var_46d8992a = skipto;
  }

  if(is_dev(skipto)) {
    errormsg("<dev string:x38>");
    return;
  }

  if(!isDefined(var_672c77b1)) {
    if(isDefined(level.var_c55064fd[level.var_46d8992a])) {
      if(!isDefined(level.var_c55064fd[level.var_46d8992a].var_89f09f8d)) {
        level.var_c55064fd[level.var_46d8992a].var_89f09f8d = [];
      } else if(!isarray(level.var_c55064fd[level.var_46d8992a].var_89f09f8d)) {
        level.var_c55064fd[level.var_46d8992a].var_89f09f8d = array(level.var_c55064fd[level.var_46d8992a].var_89f09f8d);
      }

      level.var_c55064fd[level.var_46d8992a].var_89f09f8d[level.var_c55064fd[level.var_46d8992a].var_89f09f8d.size] = skipto;
    }

    var_672c77b1 = level.var_46d8992a;
  } else if(isDefined(level.var_c55064fd[var_672c77b1])) {
    if(!isDefined(level.var_c55064fd[var_672c77b1].var_89f09f8d)) {
      level.var_c55064fd[var_672c77b1].var_89f09f8d = [];
    } else if(!isarray(level.var_c55064fd[var_672c77b1].var_89f09f8d)) {
      level.var_c55064fd[var_672c77b1].var_89f09f8d = array(level.var_c55064fd[var_672c77b1].var_89f09f8d);
    }

    level.var_c55064fd[var_672c77b1].var_89f09f8d[level.var_c55064fd[var_672c77b1].var_89f09f8d.size] = skipto;
  }

  level.var_70b370e5 = skipto;

  if(!isDefined(var_e784b061)) {
    assert(isDefined(var_e784b061), "<dev string:x5f>");
  }

  struct = function_7d6f76df(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d);
  struct.public = 1;
  level flag::set("level_has_skiptos");
  level flag::set("level_has_skipto_branches");
}

function add_dev(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d) {
  if(!isDefined(level.var_46d8992a)) {
    level.var_46d8992a = skipto;
  }

  if(is_dev(skipto)) {
    struct = function_7d6f76df(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d);
    struct.var_f36d5247 = 1;
    return;
  }

  errormsg("<dev string:x95>");
}

function function_7d6f76df(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d) {
  assert(!isDefined(level._loadstarted), "<dev string:xc1>");
  msg = tolower(msg);
  struct = function_5d3e3cf9(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d);
  level.var_c55064fd[msg] = struct;
  return struct;
}

function change(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d) {
  struct = level.var_c55064fd[msg];

  if(isDefined(var_e784b061)) {
    struct.var_2c183249 = var_e784b061;
  }

  if(isDefined(var_dde96e3b)) {
    struct.var_4c644f8d = var_dde96e3b;
  }

  if(isDefined(var_48a6b9bd)) {
    struct.var_48a6b9bd = var_48a6b9bd;
  }

  if(isDefined(loc_string)) {
    struct.var_7dd8ffdb = loc_string;
  }

  if(isDefined(cleanup_func)) {
    struct.cleanup_func = cleanup_func;
  }

  if(isDefined(var_672c77b1)) {
    if(!isDefined(struct.var_672c77b1)) {
      struct.var_672c77b1 = [];
    } else if(!isarray(struct.var_672c77b1)) {
      struct.var_672c77b1 = array(struct.var_672c77b1);
    }

    struct.var_672c77b1[struct.var_672c77b1.size] = var_672c77b1;
  }

  if(isDefined(var_89f09f8d)) {
    struct.var_89f09f8d = strtok(var_89f09f8d, ",");
    struct.next = struct.var_89f09f8d;
  }
}

function function_b0cce1ee(func) {
  level.var_8252160a = func;
}

function function_5d3e3cf9(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, var_672c77b1, var_89f09f8d) {
  struct = spawnStruct();
  struct.name = msg;
  struct.var_2c183249 = var_e784b061;
  struct.var_4c644f8d = var_dde96e3b;
  struct.var_48a6b9bd = var_48a6b9bd;
  struct.var_7dd8ffdb = loc_string;
  struct.cleanup_func = cleanup_func;
  struct.next = [];
  struct.prev = [];
  struct.var_67ea79fe = "";
  struct.var_672c77b1 = [];

  if(isDefined(var_672c77b1)) {
    if(!isDefined(struct.var_672c77b1)) {
      struct.var_672c77b1 = [];
    } else if(!isarray(struct.var_672c77b1)) {
      struct.var_672c77b1 = array(struct.var_672c77b1);
    }

    struct.var_672c77b1[struct.var_672c77b1.size] = var_672c77b1;
  }

  struct.var_89f09f8d = [];

  if(isDefined(var_89f09f8d)) {
    struct.var_89f09f8d = strtok(var_89f09f8d, ",");
    struct.next = struct.var_89f09f8d;
  }

  struct.var_80fa98d9 = [];
  return struct;
}

function function_a59cd1c9() {
  foreach(struct in level.var_c55064fd) {
    if(is_true(struct.public)) {
      if(struct.var_672c77b1.size) {
        foreach(var_672c77b1 in struct.var_672c77b1) {
          if(isDefined(level.var_c55064fd[var_672c77b1])) {
            if(!isinarray(level.var_c55064fd[var_672c77b1].next, struct.name)) {
              if(!isDefined(level.var_c55064fd[var_672c77b1].next)) {
                level.var_c55064fd[var_672c77b1].next = [];
              } else if(!isarray(level.var_c55064fd[var_672c77b1].next)) {
                level.var_c55064fd[var_672c77b1].next = array(level.var_c55064fd[var_672c77b1].next);
              }

              level.var_c55064fd[var_672c77b1].next[level.var_c55064fd[var_672c77b1].next.size] = struct.name;
            }

            continue;
          }

          if(!isDefined(level.var_c55064fd[# "_default"].next)) {
            level.var_c55064fd[# "_default"].next = [];
          } else if(!isarray(level.var_c55064fd[# "_default"].next)) {
            level.var_c55064fd[# "_default"].next = array(level.var_c55064fd[# "_default"].next);
          }

          level.var_c55064fd[# "_default"].next[level.var_c55064fd[# "_default"].next.size] = struct.name;
        }
      } else {
        if(!isDefined(level.var_c55064fd[# "_default"].next)) {
          level.var_c55064fd[# "_default"].next = [];
        } else if(!isarray(level.var_c55064fd[# "_default"].next)) {
          level.var_c55064fd[# "_default"].next = array(level.var_c55064fd[# "_default"].next);
        }

        level.var_c55064fd[# "_default"].next[level.var_c55064fd[# "_default"].next.size] = struct.name;
      }

      foreach(var_89f09f8d in struct.var_89f09f8d) {
        if(isDefined(level.var_c55064fd[var_89f09f8d])) {
          if(!isDefined(level.var_c55064fd[var_89f09f8d].prev)) {
            level.var_c55064fd[var_89f09f8d].prev = [];
          } else if(!isarray(level.var_c55064fd[var_89f09f8d].prev)) {
            level.var_c55064fd[var_89f09f8d].prev = array(level.var_c55064fd[var_89f09f8d].prev);
          }

          level.var_c55064fd[var_89f09f8d].prev[level.var_c55064fd[var_89f09f8d].prev.size] = struct.name;
        }
      }
    }
  }

  foreach(struct in level.var_c55064fd) {
    if(is_true(struct.public)) {
      if(struct.next.size < 1) {
        if(!isDefined(struct.next)) {
          struct.next = [];
        } else if(!isarray(struct.next)) {
          struct.next = array(struct.next);
        }

        struct.next[struct.next.size] = "_exit";
      }
    }
  }
}

function is_dev(skipto) {
  substr = tolower(getsubstr(skipto, 0, 4));

  if(substr == "dev_") {
    return true;
  }

  return false;
}

function function_88b0c3ba() {
  return level flag::get("level_has_skiptos");
}

function function_5a61e21a() {
  skiptos = tolower(getskiptos());
  result = strtok(skiptos, ",");
  return result;
}

function handle() {
  function_955e50d();
  function_a59cd1c9();
  function_4b70d35f();
  skiptos = function_5a61e21a();

  foreach(var_d3440450 in skiptos) {
    if(isDefined(level.var_c55064fd[var_d3440450])) {
      var_48a6b9bd = level.var_c55064fd[var_d3440450].var_48a6b9bd;

      if(isDefined(var_48a6b9bd) && !isinarray(skiptos, var_48a6b9bd)) {
        if(!isDefined(skiptos)) {
          skiptos = [];
        } else if(!isarray(skiptos)) {
          skiptos = array(skiptos);
        }

        skiptos[skiptos.size] = var_48a6b9bd;
      }
    }
  }

  function_51726ac8(skiptos, 1);

  while(true) {
    level waittill(#"skiptos_changed");
    level thread function_4fcf7c1();
  }
}

function private function_4fcf7c1() {
  waitframe(1);
  skiptos = function_5a61e21a();
  function_51726ac8(skiptos, 0);
}

function function_f52ec735(func) {
  level.var_8252160a = func;
}

function function_46d8992a(skipto) {
  level.var_46d8992a = skipto;
}

function function_abaeef51(str, var_d5779ab5, var_54e5e046) {
  sarray = strtok(str, var_d5779ab5);
  var_cc407339 = "";
  first = 1;

  foreach(s in sarray) {
    if(!first) {
      var_cc407339 += var_54e5e046;
    }

    first = 0;
    var_cc407339 += s;
  }

  return var_cc407339;
}

function function_16ad9e86(table, levelname, var_4469951e = "") {
  index = 0;

  for(row = tablelookuprow(table, index); isDefined(row); row = tablelookuprow(table, index)) {
    if(row[0] == levelname && row[1] == var_4469951e) {
      skipto = row[2];
      var_672c77b1 = row[3];
      var_89f09f8d = row[4];
      var_89f09f8d = function_abaeef51(var_89f09f8d, "+", ",");
      locstr = row[5];
      function_9c003a50(skipto, &function_9e68c55e, locstr, undefined, var_672c77b1, var_89f09f8d);
    }

    index++;
  }
}

function function_9e68c55e() {}

function function_955e50d() {
  level flag::wait_till("skipto_player_connected");
}

function function_e377e813() {
  if(!level flag::exists("skipto_player_connected")) {
    level flag::init("skipto_player_connected");
  }

  callback::add_callback(#"on_localclient_connect", &on_player_connect);
}

function on_player_connect(localclientnum) {
  level flag::set("skipto_player_connected");
}

function function_51726ac8(objectives, starting) {
  function_fc434ec9();

  if(starting) {
    foreach(objective in objectives) {
      if(isDefined(level.var_c55064fd[objective])) {
        function_60288de7(level.var_c55064fd[objective].prev, starting);
      }
    }
  } else {
    foreach(skipto in level.var_c55064fd) {
      if(is_true(skipto.var_9dd617f2) && !isinarray(objectives, skipto.name)) {
        function_60288de7(skipto.name, starting);
      }
    }
  }

  if(isDefined(level.var_8252160a)) {
    foreach(name in objectives) {
      thread[[level.var_8252160a]](name);
    }
  }

  function_d037bbec(objectives, starting);
  level.var_b28c2c3a = level.var_28c22d88[0];
  level.var_28c22d88 = objectives;
  level notify(#"objective_changed", {
    #objectives: level.var_28c22d88
  });
}

function function_4b70d35f(objectives) {
  foreach(skipto in level.var_c55064fd) {
    if(!is_true(skipto.var_a9880cee)) {
      skipto.var_a9880cee = 1;

      if(isDefined(skipto.var_d177b2f)) {
        thread[[skipto.var_d177b2f]](skipto.name);
      }
    }
  }
}

function function_d037bbec(name, starting) {
  if(isarray(name)) {
    foreach(element in name) {
      function_d037bbec(element, starting);
    }

    return;
  }

  if(isDefined(level.var_c55064fd[name])) {
    if(!is_true(level.var_c55064fd[name].var_9dd617f2)) {
      if(!isinarray(level.var_28c22d88, name)) {
        if(!isDefined(level.var_28c22d88)) {
          level.var_28c22d88 = [];
        } else if(!isarray(level.var_28c22d88)) {
          level.var_28c22d88 = array(level.var_28c22d88);
        }

        level.var_28c22d88[level.var_28c22d88.size] = name;
      }

      level notify(name + "_init");
      level.var_c55064fd[name].var_9dd617f2 = 1;
      function_d8ddef0(name, starting);
      level thread function_b7e9926c(name, starting);
    }
  }
}

function private function_b7e9926c(name, starting) {
  if(starting) {
    if(isDefined(level.var_c55064fd[name].var_4c644f8d)) {
      [[level.var_c55064fd[name].var_4c644f8d]](name);
    }
  }

  if(isDefined(level.var_c55064fd[name].var_2c183249)) {
    [[level.var_c55064fd[name].var_2c183249]](name);
  }
}

function function_fc434ec9() {
  foreach(skipto in level.var_c55064fd) {
    skipto.var_a6ddf9d6 = 0;
  }
}

function function_60288de7(name, starting) {
  if(isarray(name)) {
    foreach(element in name) {
      function_60288de7(element, starting);
    }

    return;
  }

  if(isDefined(level.var_c55064fd[name])) {
    cleaned = 0;

    if(is_true(level.var_c55064fd[name].var_9dd617f2)) {
      cleaned = 1;
      level.var_c55064fd[name].var_9dd617f2 = 0;

      if(isinarray(level.var_28c22d88, name)) {
        arrayremovevalue(level.var_28c22d88, name);
      }

      if(isDefined(level.var_c55064fd[name].cleanup_func)) {
        thread[[level.var_c55064fd[name].cleanup_func]](name, starting);
      }

      function_9b847391(name, starting);
      level notify(name + "_terminate");
    }

    if(starting && !is_true(level.var_c55064fd[name].var_a6ddf9d6)) {
      level.var_c55064fd[name].var_a6ddf9d6 = 1;
      function_60288de7(level.var_c55064fd[name].prev, starting);

      if(!cleaned) {
        if(isDefined(level.var_c55064fd[name].cleanup_func)) {
          thread[[level.var_c55064fd[name].cleanup_func]](name, starting);
        }

        function_9b847391(name, starting);
      }
    }
  }
}

function set_last_map_dvar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  missionname = util::get_map_name();
  setDvar(#"last_map", missionname);
}

function private function_d8ddef0(objective, starting) {}

function private function_9b847391(objective, starting) {}

function catch_up_transition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  postfx::playpostfxbundle(#"hash_4c8b84239d3d1056");
}

function function_17cc9832() {
  level waittill(#"aar");
}