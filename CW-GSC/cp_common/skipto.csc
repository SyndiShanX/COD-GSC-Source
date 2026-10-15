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
  level.skipto_current_objective = [];
  clientfield::register("toplayer", "catch_up_transition", 1, 1, "counter", &catch_up_transition, 0, 0);
  clientfield::register("world", "set_last_map_dvar", 1, 1, "counter", &set_last_map_dvar, 0, 0);
  level.default_skipto = "_default";
  add_internal("_default");
  add_internal("no_game");
  load_mission_table(#"gamedata/tables/cp/cp_mapmissions.csv", util::get_map_name());
  level thread watch_players_connect();
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

  if(isDefined(level.last_skipto)) {
    if(isDefined(level.skipto_settings[level.last_skipto])) {
      if(!isDefined(level.skipto_settings[level.last_skipto].end_before)) {
        level.skipto_settings[level.last_skipto].end_before = [];
      } else if(!isarray(level.skipto_settings[level.last_skipto].end_before)) {
        level.skipto_settings[level.last_skipto].end_before = array(level.skipto_settings[level.last_skipto].end_before);
      }

      level.skipto_settings[level.last_skipto].end_before[level.skipto_settings[level.last_skipto].end_before.size] = skipto;
    }

    launch_after = level.last_skipto;
  } else {
    if(isDefined(level.skipto_settings[level.default_skipto])) {
      if(!isDefined(level.skipto_settings[level.default_skipto].end_before)) {
        level.skipto_settings[level.default_skipto].end_before = [];
      } else if(!isarray(level.skipto_settings[level.default_skipto].end_before)) {
        level.skipto_settings[level.default_skipto].end_before = array(level.skipto_settings[level.default_skipto].end_before);
      }

      level.skipto_settings[level.default_skipto].end_before[level.skipto_settings[level.default_skipto].end_before.size] = skipto;
    }

    launch_after = level.default_skipto;
  }

  level.last_skipto = skipto;

  if(!isDefined(var_e784b061)) {
    assert(isDefined(var_e784b061), "<dev string:x5f>");
  }

  struct = add_internal(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, undefined);
  struct.public = 1;
  level flag::set("level_has_skiptos");
}

function add_branch(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before) {
  if(!isDefined(level.default_skipto)) {
    level.default_skipto = skipto;
  }

  if(is_dev(skipto)) {
    errormsg("<dev string:x38>");
    return;
  }

  if(!isDefined(launch_after)) {
    if(isDefined(level.skipto_settings[level.default_skipto])) {
      if(!isDefined(level.skipto_settings[level.default_skipto].end_before)) {
        level.skipto_settings[level.default_skipto].end_before = [];
      } else if(!isarray(level.skipto_settings[level.default_skipto].end_before)) {
        level.skipto_settings[level.default_skipto].end_before = array(level.skipto_settings[level.default_skipto].end_before);
      }

      level.skipto_settings[level.default_skipto].end_before[level.skipto_settings[level.default_skipto].end_before.size] = skipto;
    }

    launch_after = level.default_skipto;
  } else if(isDefined(level.skipto_settings[launch_after])) {
    if(!isDefined(level.skipto_settings[launch_after].end_before)) {
      level.skipto_settings[launch_after].end_before = [];
    } else if(!isarray(level.skipto_settings[launch_after].end_before)) {
      level.skipto_settings[launch_after].end_before = array(level.skipto_settings[launch_after].end_before);
    }

    level.skipto_settings[launch_after].end_before[level.skipto_settings[launch_after].end_before.size] = skipto;
  }

  level.last_skipto = skipto;

  if(!isDefined(var_e784b061)) {
    assert(isDefined(var_e784b061), "<dev string:x5f>");
  }

  struct = add_internal(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before);
  struct.public = 1;
  level flag::set("level_has_skiptos");
  level flag::set("level_has_skipto_branches");
}

function add_dev(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before) {
  if(!isDefined(level.default_skipto)) {
    level.default_skipto = skipto;
  }

  if(is_dev(skipto)) {
    struct = add_internal(skipto, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before);
    struct.dev_skipto = 1;
    return;
  }

  errormsg("<dev string:x95>");
}

function add_internal(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before) {
  assert(!isDefined(level._loadstarted), "<dev string:xc1>");
  msg = tolower(msg);
  struct = add_construct(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before);
  level.skipto_settings[msg] = struct;
  return struct;
}

function change(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before) {
  struct = level.skipto_settings[msg];

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
    struct.skipto_loc_string = loc_string;
  }

  if(isDefined(cleanup_func)) {
    struct.cleanup_func = cleanup_func;
  }

  if(isDefined(launch_after)) {
    if(!isDefined(struct.launch_after)) {
      struct.launch_after = [];
    } else if(!isarray(struct.launch_after)) {
      struct.launch_after = array(struct.launch_after);
    }

    struct.launch_after[struct.launch_after.size] = launch_after;
  }

  if(isDefined(end_before)) {
    struct.end_before = strtok(end_before, ",");
    struct.next = struct.end_before;
  }
}

function set_skipto_cleanup_func(func) {
  level.func_skipto_cleanup = func;
}

function add_construct(msg, var_e784b061, var_dde96e3b, var_48a6b9bd, loc_string, cleanup_func, launch_after, end_before) {
  struct = spawnStruct();
  struct.name = msg;
  struct.var_2c183249 = var_e784b061;
  struct.var_4c644f8d = var_dde96e3b;
  struct.var_48a6b9bd = var_48a6b9bd;
  struct.skipto_loc_string = loc_string;
  struct.cleanup_func = cleanup_func;
  struct.next = [];
  struct.prev = [];
  struct.completion_conditions = "";
  struct.launch_after = [];

  if(isDefined(launch_after)) {
    if(!isDefined(struct.launch_after)) {
      struct.launch_after = [];
    } else if(!isarray(struct.launch_after)) {
      struct.launch_after = array(struct.launch_after);
    }

    struct.launch_after[struct.launch_after.size] = launch_after;
  }

  struct.end_before = [];

  if(isDefined(end_before)) {
    struct.end_before = strtok(end_before, ",");
    struct.next = struct.end_before;
  }

  struct.ent_movers = [];
  return struct;
}

function build_objective_tree() {
  foreach(struct in level.skipto_settings) {
    if(is_true(struct.public)) {
      if(struct.launch_after.size) {
        foreach(launch_after in struct.launch_after) {
          if(isDefined(level.skipto_settings[launch_after])) {
            if(!isinarray(level.skipto_settings[launch_after].next, struct.name)) {
              if(!isDefined(level.skipto_settings[launch_after].next)) {
                level.skipto_settings[launch_after].next = [];
              } else if(!isarray(level.skipto_settings[launch_after].next)) {
                level.skipto_settings[launch_after].next = array(level.skipto_settings[launch_after].next);
              }

              level.skipto_settings[launch_after].next[level.skipto_settings[launch_after].next.size] = struct.name;
            }

            continue;
          }

          if(!isDefined(level.skipto_settings[#"_default"].next)) {
            level.skipto_settings[#"_default"].next = [];
          } else if(!isarray(level.skipto_settings[#"_default"].next)) {
            level.skipto_settings[#"_default"].next = array(level.skipto_settings[#"_default"].next);
          }

          level.skipto_settings[#"_default"].next[level.skipto_settings[#"_default"].next.size] = struct.name;
        }
      } else {
        if(!isDefined(level.skipto_settings[#"_default"].next)) {
          level.skipto_settings[#"_default"].next = [];
        } else if(!isarray(level.skipto_settings[#"_default"].next)) {
          level.skipto_settings[#"_default"].next = array(level.skipto_settings[#"_default"].next);
        }

        level.skipto_settings[#"_default"].next[level.skipto_settings[#"_default"].next.size] = struct.name;
      }

      foreach(end_before in struct.end_before) {
        if(isDefined(level.skipto_settings[end_before])) {
          if(!isDefined(level.skipto_settings[end_before].prev)) {
            level.skipto_settings[end_before].prev = [];
          } else if(!isarray(level.skipto_settings[end_before].prev)) {
            level.skipto_settings[end_before].prev = array(level.skipto_settings[end_before].prev);
          }

          level.skipto_settings[end_before].prev[level.skipto_settings[end_before].prev.size] = struct.name;
        }
      }
    }
  }

  foreach(struct in level.skipto_settings) {
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

function level_has_skipto_points() {
  return level flag::get("level_has_skiptos");
}

function get_current_skiptos() {
  skiptos = tolower(getskiptos());
  result = strtok(skiptos, ",");
  return result;
}

function handle() {
  wait_for_first_player();
  build_objective_tree();
  run_initial_logic();
  skiptos = get_current_skiptos();

  foreach(str_skipto in skiptos) {
    if(isDefined(level.skipto_settings[str_skipto])) {
      var_48a6b9bd = level.skipto_settings[str_skipto].var_48a6b9bd;

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

  set_level_objective(skiptos, 1);

  while(true) {
    level waittill(#"skiptos_changed");
    level thread function_4fcf7c1();
  }
}

function private function_4fcf7c1() {
  waitframe(1);
  skiptos = get_current_skiptos();
  set_level_objective(skiptos, 0);
}

function set_cleanup_func(func) {
  level.func_skipto_cleanup = func;
}

function default_skipto(skipto) {
  level.default_skipto = skipto;
}

function convert_token(str, fromtok, totok) {
  sarray = strtok(str, fromtok);
  ostr = "";
  first = 1;

  foreach(s in sarray) {
    if(!first) {
      ostr += totok;
    }

    first = 0;
    ostr += s;
  }

  return ostr;
}

function load_mission_table(table, levelname, sublevel = "") {
  index = 0;

  for(row = tablelookuprow(table, index); isDefined(row); row = tablelookuprow(table, index)) {
    if(row[0] == levelname && row[1] == sublevel) {
      skipto = row[2];
      launch_after = row[3];
      end_before = row[4];
      end_before = convert_token(end_before, "+", ",");
      locstr = row[5];
      add_branch(skipto, &load_mission_init, locstr, undefined, launch_after, end_before);
    }

    index++;
  }
}

function load_mission_init() {}

function wait_for_first_player() {
  level flag::wait_till("skipto_player_connected");
}

function watch_players_connect() {
  if(!level flag::exists("skipto_player_connected")) {
    level flag::init("skipto_player_connected");
  }

  callback::add_callback(#"on_localclient_connect", &on_player_connect);
}

function on_player_connect(localclientnum) {
  level flag::set("skipto_player_connected");
}

function set_level_objective(objectives, starting) {
  clear_recursion();

  if(starting) {
    foreach(objective in objectives) {
      if(isDefined(level.skipto_settings[objective])) {
        stop_objective_logic(level.skipto_settings[objective].prev, starting);
      }
    }
  } else {
    foreach(skipto in level.skipto_settings) {
      if(is_true(skipto.objective_running) && !isinarray(objectives, skipto.name)) {
        stop_objective_logic(skipto.name, starting);
      }
    }
  }

  if(isDefined(level.func_skipto_cleanup)) {
    foreach(name in objectives) {
      thread[[level.func_skipto_cleanup]](name);
    }
  }

  start_objective_logic(objectives, starting);
  level.skipto_point = level.skipto_current_objective[0];
  level.skipto_current_objective = objectives;
  level notify(#"objective_changed", {
    #objectives: level.skipto_current_objective
  });
}

function run_initial_logic(objectives) {
  foreach(skipto in level.skipto_settings) {
    if(!is_true(skipto.logic_running)) {
      skipto.logic_running = 1;

      if(isDefined(skipto.logic_func)) {
        thread[[skipto.logic_func]](skipto.name);
      }
    }
  }
}

function start_objective_logic(name, starting) {
  if(isarray(name)) {
    foreach(element in name) {
      start_objective_logic(element, starting);
    }

    return;
  }

  if(isDefined(level.skipto_settings[name])) {
    if(!is_true(level.skipto_settings[name].objective_running)) {
      if(!isinarray(level.skipto_current_objective, name)) {
        if(!isDefined(level.skipto_current_objective)) {
          level.skipto_current_objective = [];
        } else if(!isarray(level.skipto_current_objective)) {
          level.skipto_current_objective = array(level.skipto_current_objective);
        }

        level.skipto_current_objective[level.skipto_current_objective.size] = name;
      }

      level notify(name + "_init");
      level.skipto_settings[name].objective_running = 1;
      standard_objective_init(name, starting);
      level thread function_b7e9926c(name, starting);
    }
  }
}

function private function_b7e9926c(name, starting) {
  if(starting) {
    if(isDefined(level.skipto_settings[name].var_4c644f8d)) {
      [[level.skipto_settings[name].var_4c644f8d]](name);
    }
  }

  if(isDefined(level.skipto_settings[name].var_2c183249)) {
    [[level.skipto_settings[name].var_2c183249]](name);
  }
}

function clear_recursion() {
  foreach(skipto in level.skipto_settings) {
    skipto.cleanup_recursion = 0;
  }
}

function stop_objective_logic(name, starting) {
  if(isarray(name)) {
    foreach(element in name) {
      stop_objective_logic(element, starting);
    }

    return;
  }

  if(isDefined(level.skipto_settings[name])) {
    cleaned = 0;

    if(is_true(level.skipto_settings[name].objective_running)) {
      cleaned = 1;
      level.skipto_settings[name].objective_running = 0;

      if(isinarray(level.skipto_current_objective, name)) {
        arrayremovevalue(level.skipto_current_objective, name);
      }

      if(isDefined(level.skipto_settings[name].cleanup_func)) {
        thread[[level.skipto_settings[name].cleanup_func]](name, starting);
      }

      standard_objective_done(name, starting);
      level notify(name + "_terminate");
    }

    if(starting && !is_true(level.skipto_settings[name].cleanup_recursion)) {
      level.skipto_settings[name].cleanup_recursion = 1;
      stop_objective_logic(level.skipto_settings[name].prev, starting);

      if(!cleaned) {
        if(isDefined(level.skipto_settings[name].cleanup_func)) {
          thread[[level.skipto_settings[name].cleanup_func]](name, starting);
        }

        standard_objective_done(name, starting);
      }
    }
  }
}

function set_last_map_dvar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  missionname = util::get_map_name();
  setDvar(#"last_map", missionname);
}

function private standard_objective_init(objective, starting) {}

function private standard_objective_done(objective, starting) {}

function catch_up_transition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  postfx::playpostfxbundle(#"pstfx_cp_transition_sprite");
}

function function_17cc9832() {
  level waittill(#"aar");
}