/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_skipto.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\load_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace skipto;

function autoexec __init__sytem__() {
  system::register("skipto", & __init__, & __main__, undefined);
}

function __init__() {
  level flag::init("running_skipto");
  level flag::init("level_has_skiptos");
  level flag::init("level_has_skipto_branches");
  level.skipto_current_objective = [];
  clientfield::register("toplayer", "catch_up_transition", 1, 1, "counter", & catch_up_transition, 0, 0);
  clientfield::register("world", "set_last_map_dvar", 1, 1, "counter", & set_last_map_dvar, 0, 0);
  add_internal("_default");
  add_internal("no_game");
  load_mission_table("gamedata/tables/cp/cp_mapmissions.csv", getdvarstring("mapname"));
  level thread watch_players_connect();
  level thread function_91c7f6af();
}

function __main__() {
  level thread handle();
  nextmapmodel = getuimodel(getglobaluimodel(), "nextMap");
  if(!util::is_safehouse()) {
    nextmapmodel = createuimodel(getglobaluimodel(), "nextMap");
    setuimodelvalue(nextmapmodel, getdvarstring("ui_mapname"));
  }
}

function add(skipto, func, loc_string, cleanup_func, launch_after, end_before) {
  if(!isDefined(level.default_skipto)) {
    level.default_skipto = skipto;
  }
  if(is_dev(skipto)) {
    errormsg("");
    return;
  }
  if(isDefined(launch_after) || isDefined(end_before)) {
    errormsg("");
    return;
  }
  if(level flag::get("level_has_skipto_branches")) {
    errormsg("");
  }
  if(!isDefined(launch_after)) {
    if(isDefined(level.last_skipto)) {
      if(isDefined(level.skipto_settings[level.last_skipto])) {
        if(!isDefined(level.skipto_settings[level.last_skipto].end_before) || level.skipto_settings[level.last_skipto].end_before.size < 1) {
          if(!isDefined(level.skipto_settings[level.last_skipto].end_before)) {
            level.skipto_settings[level.last_skipto].end_before = [];
          } else if(!isarray(level.skipto_settings[level.last_skipto].end_before)) {
            level.skipto_settings[level.last_skipto].end_before = array(level.skipto_settings[level.last_skipto].end_before);
          }
        }
        level.skipto_settings[level.last_skipto].end_before[level.skipto_settings[level.last_skipto].end_before.size] = skipto;
      }
    }
    if(isDefined(level.last_skipto)) {
      launch_after = level.last_skipto;
    }
    level.last_skipto = skipto;
  }
  if(!isDefined(func)) {
    assert(isDefined(func), "");
  }
  struct = add_internal(skipto, func, loc_string, cleanup_func, launch_after, end_before);
  struct.public = 1;
  level flag::set("level_has_skiptos");
}

function add_branch(skipto, func, loc_string, cleanup_func, launch_after, end_before) {
  if(!isDefined(level.default_skipto)) {
    level.default_skipto = skipto;
  }
  if(is_dev(skipto)) {
    errormsg("");
    return;
  }
  if(!isDefined(launch_after) && !isDefined(end_before)) {
    errormsg("");
    return;
  }
  if(!isDefined(launch_after)) {
    if(isDefined(level.last_skipto)) {
      if(isDefined(level.skipto_settings[level.last_skipto])) {
        if(!isDefined(level.skipto_settings[level.last_skipto].end_before) || level.skipto_settings[level.last_skipto].end_before.size < 1) {
          if(!isDefined(level.skipto_settings[level.last_skipto].end_before)) {
            level.skipto_settings[level.last_skipto].end_before = [];
          } else if(!isarray(level.skipto_settings[level.last_skipto].end_before)) {
            level.skipto_settings[level.last_skipto].end_before = array(level.skipto_settings[level.last_skipto].end_before);
          }
        }
        level.skipto_settings[level.last_skipto].end_before[level.skipto_settings[level.last_skipto].end_before.size] = skipto;
      }
    }
    if(isDefined(level.last_skipto)) {
      launch_after = level.last_skipto;
    }
    level.last_skipto = skipto;
  }
  if(!isDefined(func)) {
    assert(isDefined(func), "");
  }
  struct = add_internal(skipto, func, loc_string, cleanup_func, launch_after, end_before);
  struct.public = 1;
  level flag::set("level_has_skiptos");
  level flag::set("level_has_skipto_branches");
}

function add_dev(skipto, func, loc_string, cleanup_func, launch_after, end_before) {
  if(!isDefined(level.default_skipto)) {
    level.default_skipto = skipto;
  }
  if(is_dev(skipto)) {
    struct = add_internal(skipto, func, loc_string, cleanup_func, launch_after, end_before);
    struct.dev_skipto = 1;
    return;
  }
  errormsg("");
}

function add_internal(msg, func, loc_string, cleanup_func, launch_after, end_before) {
  assert(!isDefined(level._loadstarted), "");
  msg = tolower(msg);
  struct = add_construct(msg, func, loc_string, cleanup_func, launch_after, end_before);
  level.skipto_settings[msg] = struct;
  return struct;
}

function change(msg, func, loc_string, cleanup_func, launch_after, end_before) {
  struct = level.skipto_settings[msg];
  if(isDefined(func)) {
    struct.skipto_func = func;
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

function add_construct(msg, func, loc_string, cleanup_func, launch_after, end_before) {
  struct = spawnStruct();
  struct.name = msg;
  struct.skipto_func = func;
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
    if(isDefined(struct.public) && struct.public) {
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
          if(!isDefined(level.skipto_settings["_default"].next)) {
            level.skipto_settings["_default"].next = [];
          } else if(!isarray(level.skipto_settings["_default"].next)) {
            level.skipto_settings["_default"].next = array(level.skipto_settings["_default"].next);
          }
          level.skipto_settings["_default"].next[level.skipto_settings["_default"].next.size] = struct.name;
        }
      } else {
        if(!isDefined(level.skipto_settings["_default"].next)) {
          level.skipto_settings["_default"].next = [];
        } else if(!isarray(level.skipto_settings["_default"].next)) {
          level.skipto_settings["_default"].next = array(level.skipto_settings["_default"].next);
        }
        level.skipto_settings["_default"].next[level.skipto_settings["_default"].next.size] = struct.name;
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
    if(isDefined(struct.public) && struct.public) {
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
  set_level_objective(skiptos, 1);
  while(true) {
    level waittill("skiptos_changed");
    skiptos = get_current_skiptos();
    set_level_objective(skiptos, 0);
  }
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
      ostr = ostr + totok;
    }
    first = 0;
    ostr = ostr + s;
  }
  return ostr;
}

function load_mission_table(table, levelname, sublevel = "") {
  index = 0;
  row = tablelookuprow(table, index);
  while(isDefined(row)) {
    if(row[0] == levelname && row[1] == sublevel) {
      skipto = row[2];
      launch_after = row[3];
      end_before = row[4];
      end_before = convert_token(end_before, "+", ",");
      locstr = row[5];
      add_branch(skipto, & load_mission_init, locstr, undefined, launch_after, end_before);
    }
    index++;
    row = tablelookuprow(table, index);
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
  callback::add_callback("hash_da8d7d74", & on_player_connect);
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
      if(isDefined(skipto.objective_running) && skipto.objective_running && !isinarray(objectives, skipto.name)) {
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
  level notify("objective_changed", level.skipto_current_objective);
  level.skipto_current_objective = objectives;
}

function run_initial_logic(objectives) {
  foreach(skipto in level.skipto_settings) {
    if(!(isDefined(skipto.logic_running) && skipto.logic_running)) {
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
  } else if(isDefined(level.skipto_settings[name])) {
    if(!(isDefined(level.skipto_settings[name].objective_running) && level.skipto_settings[name].objective_running)) {
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
      if(isDefined(level.skipto_settings[name].skipto_func)) {
        thread[[level.skipto_settings[name].skipto_func]](name, starting);
      }
    }
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
  } else if(isDefined(level.skipto_settings[name])) {
    cleaned = 0;
    if(isDefined(level.skipto_settings[name].objective_running) && level.skipto_settings[name].objective_running) {
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
    if(starting && (!(isDefined(level.skipto_settings[name].cleanup_recursion) && level.skipto_settings[name].cleanup_recursion))) {
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
  var_1df2da04 = getdvarstring("ui_mapname");
  setdvar("last_map", var_1df2da04);
}

function private standard_objective_init(objective, starting) {}

function private standard_objective_done(objective, starting) {}

function catch_up_transition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  postfx::playpostfxbundle("pstfx_cp_transition_sprite");
}

function function_91c7f6af() {
  level waittill("aar");
  audio::snd_set_snapshot("cmn_aar_screen");
}