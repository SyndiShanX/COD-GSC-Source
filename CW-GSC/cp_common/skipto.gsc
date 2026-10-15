/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\skipto.gsc
***********************************************/

#using script_44b0b8420eabacad;
#using scripts\core_common\activities_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\traps_deployable;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\achievements;
#using scripts\cp_common\bb;
#using scripts\cp_common\challenges;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_player;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\load;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace skipto;

function private autoexec __init__system__() {
  system::register(#"skipto", &preinit, &postinit, &on_finalize_initialization, undefined);
}

function private preinit() {
  level flag::init("start_skiptos");
  level flag::init("level_has_skiptos");
  level flag::init("level_has_skipto_branches");
  level flag::init("skipto_spawns_ready");
  level flag::init("final_level");
  level flag::init("_exit");
  clientfield::register("toplayer", "catch_up_transition", 1, 1, "counter");
  clientfield::register("world", "set_last_map_dvar", 1, 1, "counter");
  level.map_name = getrootmapname();
  level.mission_name = getmissionname();
  level.var_2b1b0a8b = &objective_completed;
  level.var_f1eb9fe4 = &set_current_skipto;
  fields = getmapfields();
  world.var_82105eb4 = undefined;
  level.default_skipto = "_default";
  add_internal("_default");
  add_internal("no_game", &nogame);
  load_mission_table(#"gamedata/tables/cp/cp_mapmissions.csv", level.script);
  level.a_s_spawn_points = arraycombine(struct::get_array("cp_coop_spawn", "targetname"), struct::get_array("cp_coop_respawn", "targetname"), 0, 0);
  spawning::function_754c78a6(&function_f3d2a1c3);
  callback::on_spawned(&on_player_spawn);
  callback::on_connect(&on_player_connect);
}

function private postinit() {
  level thread entity_mover_main();
  level thread handle();
}

function function_228558fd(var_f2d4fd10 = 0, var_7a646627 = 0) {
  mission_array = [];

  for(i = 0; i < 99; i++) {
    mapname = getmapatindex(i);

    if(!isDefined(mapname)) {
      break;
    }

    mapbundle = getmapscriptbundle(mapname);

    if(isDefined(mapbundle)) {
      if(is_true(mapbundle.isSideMission)) {
        if(var_f2d4fd10) {
          array::add(mission_array, mapname);
        }

        continue;
      }

      if(is_true(mapbundle.issafehouse)) {
        if(var_7a646627) {
          array::add(mission_array, mapname);
        }

        continue;
      }

      array::add(mission_array, mapname);
    }
  }

  return mission_array;
}

function function_fb89516e(str_skipto) {
  return level flag::get(str_skipto);
}

function function_fbae1b12(str_skipto) {
  return level flag::get(str_skipto + "_completed");
}

function function_9a209ed9(str_skipto) {
  level flag::wait_till(str_skipto + "_completed");
}

function function_c0f982ff() {
  return arraycopy(level.skipto_current_objective);
}

function add(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_e5301d70, b_saved = 0) {
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
  assert(isDefined(var_e784b061), "<dev string:x5f>");
  struct = add_internal(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, undefined, b_saved, var_e5301d70);
  struct.public = 1;
  level flag::set("level_has_skiptos");
}

function add_saved(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_e5301d70) {
  struct = add(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_e5301d70, 1);
}

function add_branch(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before) {
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

  struct = add_internal(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before);
  struct.public = 1;
  level flag::set("level_has_skiptos");
  level flag::set("level_has_skipto_branches");
  return struct;
}

function add_branchend(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before) {
  struct = add_branch(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before);

  if(isDefined(struct)) {
    struct.looping = 1;
  }
}

function add_dev(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before, var_e5301d70) {
  if(is_dev(skipto)) {
    struct = add_internal(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before, 0, var_e5301d70);
    struct.dev_skipto = 1;
    return;
  }

  errormsg("<dev string:x95>");
}

function objective_leave_incomplete(skipto) {
  if(!isDefined(level.skipto_settings[skipto])) {
    assertmsg("<dev string:xc1>" + skipto + "<dev string:xe7>");
    return;
  }

  level.skipto_settings[skipto].objective_mark_complete = 0;

  foreach(player in level.players) {
    bb::logobjectivestatuschange(skipto, player, "leave_incomplete");
  }
}

function add_billboard(skipto, event_name, event_type, event_size, event_state) {
  if(!isDefined(level.billboards)) {
    level.billboards = [];
  }

  level.billboards[skipto] = array(event_name, event_type, event_size, event_state);
}

function add_internal(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before, b_saved, var_e5301d70) {
  assert(!isDefined(level._loadstarted), "<dev string:x11f>");
  msg = tolower(msg);
  struct = add_construct(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before, b_saved, var_e5301d70);
  level.skipto_settings[msg] = struct;
  level flag::init(msg);
  level flag::init(msg + "_completed");
  return struct;
}

function change(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before) {
  struct = level.skipto_settings[msg];

  if(isDefined(var_e784b061)) {
    struct.var_2c183249 = var_e784b061;
  }

  if(isDefined(var_dde96e3b)) {
    struct.var_4c644f8d = var_dde96e3b;
  }

  if(isDefined(str_name)) {
    struct.str_name = str_name;
  }

  if(isDefined(cleanup_func)) {
    struct.cleanup_func = cleanup_func;
  }

  if(isDefined(launch_after)) {
    struct.completion_conditions = struct parse_launch_after(launch_after);
  }

  if(isDefined(end_before)) {
    struct.end_before = strtok(end_before, ",");
    struct.next = struct.end_before;
  }
}

function set_skipto_cleanup_func(func) {
  level.func_skipto_cleanup = func;
}

function add_construct(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, launch_after, end_before, b_saved = 0, var_e5301d70) {
  struct = spawnStruct();
  struct.name = msg;
  struct.code_index = registerskipto(msg);
  struct.var_2c183249 = var_e784b061;
  struct.var_4c644f8d = var_dde96e3b;
  struct.str_name = str_name;
  struct.cleanup_func = cleanup_func;
  struct.next = [];
  struct.prev = [];
  struct.completion_conditions = "";
  struct.launch_after = [];
  struct.b_saved = b_saved;
  struct.var_e5301d70 = var_e5301d70;

  if(isDefined(launch_after)) {
    struct.completion_conditions = struct parse_launch_after(launch_after);
  }

  struct.end_before = [];

  if(isDefined(end_before)) {
    struct.end_before = strtok(end_before, ",");
    struct.next = struct.end_before;
  }

  struct.ent_movers = [];
  return struct;
}

function level_has_skipto_points() {
  return level flag::get("level_has_skiptos");
}

function parse_error(msg) {
  assertmsg(msg);
}

function split_top_level_and_or(instring) {
  op = "";
  ret = [];
  outindex = 0;
  ret[outindex] = "";
  paren = 0;

  for(i = 0; i < instring.size; i++) {
    c = getsubstr(instring, i, i + 1);

    if(c == "(") {
      paren++;
      ret[outindex] += c;
      continue;
    }

    if(c == ")") {
      paren--;
      ret[outindex] += c;
      continue;
    }

    if(paren == 0 && c == "&") {
      if(op == "|") {
        parse_error("<dev string:x143>" + instring);
      }

      op = "&";
      outindex++;
      ret[outindex] = "";
      continue;
    }

    if(paren == 0 && c == "|") {
      if(op == "&") {
        parse_error("<dev string:x143>" + instring);
      }

      op = "|";
      outindex++;
      ret[outindex] = "";
      continue;
    }

    ret[outindex] += c;
  }

  if(paren != 0) {
    parse_error("<dev string:x172>" + instring);
  }

  for(j = 0; j <= outindex; j++) {
    ret[j] = remove_parens(ret[j]);
  }

  if(outindex == 0) {
    return ret[outindex];
  }

  ret[#"op"] = op;
  return ret;
}

function remove_parens(instring) {
  c = getsubstr(instring, 0, 1);

  if(c == "(") {
    c2 = getsubstr(instring, instring.size - 1, instring.size);

    if(c2 != ")") {
      parse_error("<dev string:x172>" + instring);
    }

    s = getsubstr(instring, 1, instring.size - 1);
    return split_top_level_and_or(s);
  }

  if(!isDefined(self.launch_after)) {
    self.launch_after = [];
  } else if(!isarray(self.launch_after)) {
    self.launch_after = array(self.launch_after);
  }

  self.launch_after[self.launch_after.size] = instring;
  return instring;
}

function parse_launch_after(launch_after) {
  retval = split_top_level_and_or(launch_after);

  if(isarray(retval)) {
    return retval;
  }

  return "";
}

function check_skipto_condition(conditions, adding) {
  if(!isarray(conditions)) {
    if(isDefined(level.skipto_settings[conditions]) && (is_true(level.skipto_settings[conditions].objective_running) || isinarray(adding, conditions))) {
      return 0;
    }

    return 1;
  }

  if(conditions[#"op"] == "|") {
    for(i = 0; i < conditions.size - 1; i++) {
      if(check_skipto_condition(conditions[i], adding)) {
        return 1;
      }
    }

    return 0;
  }

  for(i = 0; i < conditions.size - 1; i++) {
    if(!check_skipto_condition(conditions[i], adding)) {
      return 0;
    }
  }

  return 1;
}

function check_skipto_conditions(objectives) {
  result = [];

  foreach(name in objectives) {
    if(check_skipto_condition(level.skipto_settings[name].completion_conditions, result)) {
      if(!isDefined(result)) {
        result = [];
      } else if(!isarray(result)) {
        result = array(result);
      }

      result[result.size] = name;
    }
  }

  return result;
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

function get_next_skiptos(skipto_name) {
  if(scene::function_a4dedc63()) {
    return function_f3c37963(skipto_name);
  }

  if(getgametypesetting(#"hash_72a2919d2ac65850")) {
    return function_694aaea7(skipto_name);
  }

  if(isDefined(level.skipto_settings[skipto_name])) {
    return level.skipto_settings[skipto_name].next;
  }

  return level.skipto_settings[#"_default"].next;
}

function function_694aaea7(skipto_name) {
  var_c23e8af7 = [];
  var_c23e8af7[0] = skipto_name;

  while(isDefined(level.skipto_settings[var_c23e8af7[0]])) {
    if(level.skipto_settings[var_c23e8af7[0]].next.size) {
      var_c23e8af7 = level.skipto_settings[var_c23e8af7[0]].next;

      if(var_c23e8af7.size && !is_true(level.skipto_settings[var_c23e8af7[0]].var_a3d14b6b)) {
        return var_c23e8af7;
      }

      continue;
    }

    return var_c23e8af7;
  }

  return level.skipto_settings[#"_default"].next;
}

function function_f3c37963(skipto_name) {
  var_c23e8af7 = [];
  var_c23e8af7[0] = skipto_name;

  while(isDefined(level.skipto_settings[var_c23e8af7[0]])) {
    if(level.skipto_settings[var_c23e8af7[0]].next.size) {
      var_c23e8af7 = level.skipto_settings[var_c23e8af7[0]].next;

      if(var_c23e8af7.size && is_true(level.skipto_settings[var_c23e8af7[0]].var_a3d14b6b)) {
        return var_c23e8af7;
      }

      continue;
    }

    return var_c23e8af7;
  }

  return level.skipto_settings[#"_default"].next;
}

function skiptos_to_string(skiptos) {
  skiptostr = "";
  first = 1;

  foreach(skipto in skiptos) {
    if(!first) {
      skiptostr += ",";
    }

    first = 0;
    skiptostr += skipto;
  }

  return skiptostr;
}

function get_current_skiptos(var_7e8557ba) {
  var_4aaf7303 = getdvarstring(#"skipto_jump");

  if(!isDefined(var_4aaf7303) || var_4aaf7303.size == 0) {
    var_4aaf7303 = getdvarstring(#"skipto_wipe");
  }

  if(isDefined(var_4aaf7303) && var_4aaf7303.size) {
    if(var_4aaf7303 == "_default") {
      var_4aaf7303 = "";
    }

    skiptos = strtok(var_4aaf7303, ",");
    return skiptos;
  }

  if(is_true(var_7e8557ba)) {
    skiptos = tolower(getdvarstring(#"sv_savegameskipto"));
  } else {
    skiptos = tolower(getskiptos());
  }

  result = strtok(skiptos, ",");
  return result;
}

function function_5011fee2(missionname = savegame::get_mission_name()) {
  mapbundle = getmapscriptbundle(missionname);

  if(isDefined(mapbundle) && isDefined(mapbundle.var_a04dfce6)) {
    return mapbundle.var_a04dfce6;
  }

  return "";
}

function function_547ca7d2(safehouse, var_fc9732a9 = 1) {
  mapbundle = getmapscriptbundle(safehouse);
  assert(isDefined(mapbundle) && isDefined(mapbundle.issafehouse));

  if(safehouse == #"cp_ger_hub_post_cuba" || safehouse == #"cp_ger_hub8") {
    var_fc9732a9 = 0;
  }

  if(isDefined(mapbundle) && is_true(mapbundle.issafehouse)) {
    skipto = "";

    if(safehouse == "cp_ger_hub") {
      skipto = "post_takedown";
    } else if(isDefined(mapbundle) && isDefined(mapbundle.var_a04dfce6)) {
      skipto = mapbundle.var_a04dfce6;
    }

    if(var_fc9732a9 && skipto != "") {
      skipto += "_skip_briefing";
    }
  }

  return skipto;
}

function function_3a4ee594(skipto_name) {
  if(!isDefined(level.skipto_settings[skipto_name])) {
    return -1;
  }

  return level.skipto_settings[skipto_name].code_index;
}

function function_a002f769() {
  if(!isDefined(level.skipto_point) || !isDefined(level.skipto_settings[level.skipto_point])) {
    return -1;
  }

  return level.skipto_settings[level.skipto_point].code_index;
}

function set_current_skipto(skipto = "", var_3bac111e) {
  if(skipto == "") {
    var_209694d6 = array("");
  } else {
    var_209694d6 = strtok(skipto, ",");
  }

  foreach(str_skipto in var_209694d6) {
    if(is_true(var_3bac111e) || str_skipto != "" && level.skipto_settings[str_skipto].b_saved === 1) {
      setskiptos(tolower(str_skipto), 1);
      continue;
    }

    setskiptos(tolower(str_skipto), 0);
  }
}

function set_current_skiptos(skiptos) {
  set_current_skipto(skiptos_to_string(skiptos));
}

function use_default_skipto() {
  if(!isDefined(level.default_skipto)) {
    level.default_skipto = "";
  }

  set_current_skipto(level.default_skipto);
}

function validate_skiptos(skiptos) {
  done = 0;

  while(isDefined(skiptos) && skiptos.size && !done) {
    done = 1;

    foreach(skipto in skiptos) {
      if(!isDefined(level.skipto_settings[skipto])) {
        arrayremovevalue(skiptos, skipto, 0);
        done = 0;
        break;
      }
    }
  }

  return skiptos;
}

function handle() {
  build_objective_tree();
  level flag::wait_till("start_skiptos");
  default_skiptos = get_next_skiptos("_default");
  skiptos = get_current_skiptos(1);
  var_4aaf7303 = getdvarstring(#"skipto_jump");

  if(isDefined(var_4aaf7303) && var_4aaf7303.size) {
    setDvar(#"skipto_jump", "");
  }

  var_4aaf7303 = getdvarstring(#"skipto_wipe");

  if(isDefined(var_4aaf7303) && var_4aaf7303.size) {
    setDvar(#"skipto_wipe", "");
  }

  skiptos = validate_skiptos(skiptos);
  assert(is_true(level.first_frame), "<dev string:x1a0>");

  if(isDefined(level.skipto_point)) {
    skiptos = [];
    skiptos[0] = level.skipto_point;
  }

  level.skipto_current_objective = skiptos;
  skipto = skiptos[0];

  if(isDefined(skipto) && isDefined(level.skipto_settings[skipto])) {
    level.skipto_point = skipto;
  }

  is_default = 0;
  start = level.skipto_current_objective;

  if(start.size < 1) {
    is_default = 1;
    start = default_skiptos;

    if(isDefined(level.default_skipto)) {
      level.skipto_point = level.default_skipto;
    }
  } else {
    level thread sndlevelstartduck_shutoff();
  }

  level.skipto_points = start;
  skipto = start[0];

  if(isDefined(skipto) && isDefined(level.skipto_settings[skipto])) {
    level.skipto_point = skipto;
  }

  if(start.size < 1) {
    level thread sndlevelstartduck_shutoff();
    level thread load::function_eb7b7382();
    return;
  }

  if(!is_default) {
    entity_mover_use_objectives(default_skiptos);
  }

  level flag::set(#"scene_on_load_wait");
  s_skipto = level.skipto_settings[start[0]];

  if(s_skipto.code_index != 3) {
    level.var_9caf4a12 = 1;
  }

  set_level_objective(start, 1);
  callback::callback(#"hash_7177603f5415549b");
  savegame::save();
  currentmission = savegame::get_mission_name();
  mapbundle = getmapscriptbundle(currentmission);

  if(isDefined(mapbundle) && !is_true(mapbundle.isSideMission)) {
    evidencedata = collectibles::function_293d81b4(1, currentmission);

    foreach(collectible in evidencedata) {
      collectibles::function_316c48a3(collectible.var_430d1d6a, collectible.index);
    }
  }

  thread util::function_62e48a();
}

function sndlevelstartduck_shutoff() {
  level flag::wait_till("all_players_spawned");
  level util::clientnotify("sndLevelStartDuck_Shutoff");
}

function nogame() {
  guys = getaiarray();
  guys = arraycombine(guys, getspawnerarray(), 1, 0);

  for(i = 0; i < guys.size; i++) {
    guys[i] delete();
  }
}

function is_dev(skipto) {
  substr = tolower(getsubstr(skipto, 0, 4));

  if(substr == "dev_") {
    return true;
  }

  return false;
}

function is_current_dev() {
  return is_dev(level.skipto_point);
}

function is_no_game() {
  if(!isDefined(level.skipto_point)) {
    return 0;
  }

  return issubstr(level.skipto_point, "no_game");
}

function do_no_game() {
  if(!is_no_game()) {
    return;
  }

  level.stop_load = 1;

  if(isDefined(level.custom_no_game_setupfunc)) {
    level[[level.custom_no_game_setupfunc]]();
  }

  level thread load::all_players_spawned();
  array::thread_all(getEntArray("water", "targetname"), &load::water_think);
  level waittill(#"eternity");
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

function private on_finalize_initialization() {
  level flag::set("start_skiptos");
}

function on_player_spawn() {
  if(!level flag::get("level_is_go")) {
    self function_cdbc8d16(1);
  }
}

function function_9ef3400f(var_41978c9a, var_8c5dfaf7, var_2f1fe3c5, var_67c0fc30) {
  var_c4a9921e = 0;
  var_16e96e14 = 0;

  if(isDefined(var_67c0fc30)) {
    var_16e96e14 = var_67c0fc30;
  }

  if(isDefined(var_2f1fe3c5)) {
    var_c4a9921e = var_2f1fe3c5;
  }

  var_54b76fa9 = var_16e96e14 - var_c4a9921e;
  self matchrecordsetcheckpointstat(var_8c5dfaf7, var_41978c9a, var_54b76fa9);
}

function function_da5051ef(objectivename, player) {
  if(!isDefined(player.var_62e314f8)) {
    return;
  }

  objectiveindex = level.skipto_settings[objectivename].code_index;
  player function_9ef3400f("kills_total", objectiveindex, player.var_62e314f8.kills, player.kills);
  totalshots = player stats::get_stat("PlayerStatsList", #"total_shots", #"statvalue");
  totalhits = player stats::get_stat("PlayerStatsList", #"hits", #"statvalue");

  if(isDefined(totalshots)) {
    player function_9ef3400f("shots_total", objectiveindex, player.var_62e314f8.shots, totalshots);
  }

  if(isDefined(totalhits)) {
    player function_9ef3400f("hits_total", objectiveindex, player.var_62e314f8.hits, totalhits);
  }

  player function_9ef3400f("incaps_total", objectiveindex, player.var_62e314f8.incaps, player.incaps);
  player function_9ef3400f("deaths_total", objectiveindex, player.var_62e314f8.deaths, player.deaths);
  player function_9ef3400f("revives_total", objectiveindex, player.var_62e314f8.revives, player.revives);
  player function_9ef3400f("headshots_total", objectiveindex, player.var_62e314f8.headshots, player.headshots);
  player function_9ef3400f("duration_total", objectiveindex, player.var_62e314f8.timestamp, gettime());
  player function_9ef3400f("score_total", objectiveindex, player.var_62e314f8.score, player.score);
  player function_9ef3400f("grenades_total", objectiveindex, player.var_62e314f8.grenadesused, player.grenadesused);
  player function_9ef3400f("igcSeconds", objectiveindex, player.var_62e314f8.var_4cf30477, player.totaligcviewtime);
  player function_9ef3400f("secondsPaused", objectiveindex, player.var_62e314f8.var_5b03b99, int(gettotalserverpausetime() / 1000));
  distancesprinted = 0;
  var_d72847a7 = 0;
  var_17cff347 = 0;
  wallruncount = 0;
  var_1bd74555 = 0;

  if(isDefined(player.movementtracking)) {
    if(isDefined(player.movementtracking.wallrunning)) {
      var_d72847a7 = player.movementtracking.wallrunning.distance;
      wallruncount = player.movementtracking.wallrunning.count;
    }

    if(isDefined(player.movementtracking.sprinting)) {
      distancesprinted = player.movementtracking.sprinting.distance;
    }

    if(isDefined(player.movementtracking.doublejump)) {
      var_17cff347 = player.movementtracking.doublejump.distance;
      var_1bd74555 = player.movementtracking.doublejump.count;
    }
  }

  player function_9ef3400f("distance_wallrun", objectiveindex, player.var_62e314f8.distance_wallrun, int(var_d72847a7));
  player function_9ef3400f("distance_sprinted", objectiveindex, player.var_62e314f8.distance_sprinted, int(distancesprinted));
  player function_9ef3400f("distance_boosted", objectiveindex, player.var_62e314f8.distance_boosted, int(var_17cff347));
  player function_9ef3400f("wallruns_total", objectiveindex, player.var_62e314f8.wallruns_total, int(wallruncount));
  player function_9ef3400f("boosts_total", objectiveindex, player.var_62e314f8.boosts_total, int(var_1bd74555));
  player matchrecordsetcheckpointstat(objectiveindex, "start_difficulty", player.var_62e314f8.difficulty);
  player matchrecordsetcheckpointstat(objectiveindex, "end_difficulty", level.gameskill);

  if(isDefined(level.sceneskippedcount)) {
    player matchrecordsetcheckpointstat(objectiveindex, "igcSkippedNum", level.sceneskippedcount);
  }
}

function function_7c7195b4(player) {
  if(!isDefined(player.var_62e314f8)) {
    player.var_62e314f8 = spawnStruct();
  }

  player.var_62e314f8.kills = player.kills;
  shots = player stats::get_stat("PlayerStatsList", #"total_shots", #"statvalue");
  player.var_62e314f8.shots = isDefined(shots) ? shots : 0;
  hits = player stats::get_stat("PlayerStatsList", #"hits", #"statvalue");
  player.var_62e314f8.hits = isDefined(hits) ? hits : 0;
  player.var_62e314f8.incaps = player.incaps;
  player.var_62e314f8.deaths = player.deaths;
  player.var_62e314f8.revives = player.revives;
  player.var_62e314f8.headshots = player.headshots;
  player.var_62e314f8.timestamp = gettime();
  player.var_62e314f8.score = player.score;
  player.var_62e314f8.grenadesused = player.grenadesused;
  player.var_62e314f8.var_4cf30477 = player.totaligcviewtime;
  player.var_62e314f8.var_5b03b99 = int(gettotalserverpausetime() / 1000);
  player.var_62e314f8.difficulty = level.gameskill;
  distancesprinted = 0;
  var_d72847a7 = 0;
  var_17cff347 = 0;
  wallruncount = 0;
  var_1bd74555 = 0;

  if(isDefined(player.movementtracking)) {
    if(isDefined(player.movementtracking.wallrunning)) {
      var_d72847a7 = player.movementtracking.wallrunning.distance;
      wallruncount = player.movementtracking.wallrunning.count;
    }

    if(isDefined(player.movementtracking.sprinting)) {
      distancesprinted = player.movementtracking.sprinting.distance;
    }

    if(isDefined(player.movementtracking.doublejump)) {
      var_17cff347 = player.movementtracking.doublejump.distance;
      var_1bd74555 = player.movementtracking.doublejump.count;
    }
  }

  player.var_62e314f8.distance_wallrun = int(var_d72847a7);
  player.var_62e314f8.distance_sprinted = int(distancesprinted);
  player.var_62e314f8.distance_boosted = int(var_17cff347);
  player.var_62e314f8.wallruns_total = int(wallruncount);
  player.var_62e314f8.boosts_total = int(var_1bd74555);
}

function on_player_connect() {
  if(is_true(level.deadops)) {
    return;
  }

  rootmapname = getrootmapname();

  if(!isDefined(rootmapname)) {
    return;
  }

  if(getdvarint(#"ui_blocksaves", 0) == 0) {
    if(self ishost()) {
      scoreboard_migrated = 1;

      if(sessionmodeisonlinegame()) {
        scoreboard_migrated = is_true(self stats::get_stat(#"scoreboard_migrated"));
      } else {
        scoreboard_migrated = is_true(self stats::get_stat(#"reservebools", 0));
      }

      if(!scoreboard_migrated) {
        self savegame::set_player_data("savegame_score", self function_8338f930("SCORE", rootmapname));
        self savegame::set_player_data("savegame_kills", self function_8338f930("KILLS", rootmapname));
        self savegame::set_player_data("savegame_assists", self function_8338f930("ASSISTS", rootmapname));
        self savegame::set_player_data("savegame_incaps", self function_8338f930("INCAPS", rootmapname));
        self savegame::set_player_data("savegame_revives", self function_8338f930("REVIVES", rootmapname));

        if(sessionmodeisonlinegame()) {
          self stats::set_stat(#"scoreboard_migrated", 1);
        } else {
          self stats::set_stat(#"reservebools", 0, 1);
        }

        uploadstats(self);
      }

      if(!isDefined(self savegame::get_player_data("savegame_score"))) {
        self savegame::set_player_data("savegame_score", 0);
      }

      if(!isDefined(self savegame::get_player_data("savegame_kills"))) {
        self savegame::set_player_data("savegame_kills", 0);
      }

      if(!isDefined(self savegame::get_player_data("savegame_assists"))) {
        self savegame::set_player_data("savegame_assists", 0);
      }

      if(!isDefined(self savegame::get_player_data("savegame_incaps"))) {
        self savegame::set_player_data("savegame_incaps", 0);
      }

      if(!isDefined(self savegame::get_player_data("savegame_revives"))) {
        self savegame::set_player_data("savegame_revives", 0);
      }

      self.pers[#"score"] = self savegame::get_player_data("savegame_score", 0);
      self.pers[#"kills"] = self savegame::get_player_data("savegame_kills", 0);
      self.pers[#"assists"] = self savegame::get_player_data("savegame_assists", 0);
      self.pers[#"incaps"] = self savegame::get_player_data("savegame_incaps", 0);
      self.pers[#"revives"] = self savegame::get_player_data("savegame_revives", 0);
      self.score = self.pers[#"score"];
      self.kills = self.pers[#"kills"];
      self.assists = self.pers[#"assists"];
      self.incaps = self.pers[#"incaps"];
      self.revives = self.pers[#"revives"];
    }
  }

  function_7c7195b4(self);
}

function objective_completed(name, var_28e39919 = 1, player, var_ce580a72) {
  assert(isDefined(level.skipto_settings[name]), "<dev string:x1b8>" + name + "<dev string:x1cc>");

  if(isDefined(name) && level flag::get(name + "_completed")) {
    return;
  }

  isplayeralive = 0;

  foreach(player in level.players) {
    if(isalive(player)) {
      isplayeralive = 1;
      break;
    }
  }

  if(!is_true(isplayeralive)) {
    return;
  }

  setDvar(#"npcdeathtracking_save", 1);

  foreach(statplayer in level.players) {
    if(statplayer istestclient()) {
      continue;
    }

    bb::logobjectivestatuschange(name, statplayer, "complete");
    statplayer globallogic_player::function_4d3e38fb();
  }

  if(isDefined(name)) {
    if(isDefined(player) && !isDefined(var_ce580a72)) {
      function_da5051ef(name, player);
    } else {
      foreach(lvlplayer in level.players) {
        function_da5051ef(name, lvlplayer);
      }
    }

    level stop_objective_logic(name, 0, 1, player);
  }

  if(var_28e39919) {
    next = get_next_skiptos(name);
    next = check_skipto_conditions(next);

    if(isDefined(next) && next.size > 0) {
      level set_level_objective(next, 0, player);
    }
  }
}

function change_completion_menu(objectives) {
  rootclear = "<dev string:x1f8>";
  adddebugcommand(rootclear);
  rootmenu = "<dev string:x221>";
  compmenu = rootmenu + "<dev string:x23c>";
  index = 1;

  foreach(objective in objectives) {
    name = objective + "<dev string:x249>" + index;
    index++;
    adddebugcommand(compmenu + name + "<dev string:x24e>" + "<dev string:x259>" + "<dev string:x26c>" + objective + "<dev string:x271>");
  }
}

function set_level_objective(objectives, starting, player) {
  clear_recursion();

  foreach(name in objectives) {
    if(isDefined(level.skipto_settings[name])) {
      stop_objective_logic(level.skipto_settings[name].prev, starting, 0, player);
    }
  }

  if(isDefined(level.func_skipto_cleanup)) {
    foreach(name in objectives) {
      thread[[level.func_skipto_cleanup]](name);
    }
  }

  start_objective_logic(objectives, starting);
  level.skipto_point = level.skipto_current_objective[0];

  if(!is_true(level.level_ending)) {
    set_current_skiptos(level.skipto_current_objective);
  }

  level notify(#"objective_changed", {
    #objectives: level.skipto_current_objective
  });
  activities::function_59e67711(objectives[0]);
  change_completion_menu(level.skipto_current_objective);

  if(isDefined(player)) {
    function_7c7195b4(player);
  } else {
    foreach(lvlplayer in level.players) {
      function_7c7195b4(lvlplayer);
    }
  }

  update_spawn_points(starting);
}

function update_spawn_points(b_starting) {
  level.var_cd012e52 = filter_player_spawnpoints();
  level flag::set("skipto_spawns_ready");
}

function start_objective_logic(name, starting, var_23522927 = 0) {
  if(isarray(name)) {
    if(starting && name.size > 1) {
      load::function_ba5622e();
      var_23522927 = 1;
      level flag::init("all_branch_func_starting");
    }

    level flag::wait_till("all_players_connected");

    foreach(element in name) {
      start_objective_logic(element, starting, var_23522927);
    }

    if(starting && name.size > 1) {
      load::function_eb7b7382();
      level flag::set("all_branch_func_starting");
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

      if(!getdvarint(#"art_review", 0)) {
        standard_objective_init(name, starting);
        level thread function_b7e9926c(name, starting, var_23522927);

        if(is_true(level.skipto_settings[name].b_saved)) {
          savegame::checkpoint_save(1);
        }
      }
    }

    if(!is_true(level.skipto_settings[name].logic_running) && isDefined(level.skipto_settings[name].logic_func)) {
      level.skipto_settings[name].logic_running = 1;
      thread[[level.skipto_settings[name].logic_func]](name);
    }
  }

  foreach(player in level.players) {
    bb::logobjectivestatuschange(name, player, "start");
  }
}

function private function_b7e9926c(name, starting, var_23522927) {
  s_skipto = level.skipto_settings[name];

  if(is_true(s_skipto.b_saved)) {
    savegame::function_7e0e735b();
  }

  if(isDefined(s_skipto.var_e5301d70)) {
    level districts::function_a7d79fcb(s_skipto.var_e5301d70, 1);
  }

  function_9ab01465();

  if(starting) {
    if(!var_23522927) {
      load::function_ba5622e();
    }

    if(isDefined(s_skipto.var_4c644f8d)) {
      [[s_skipto.var_4c644f8d]](name);
    }

    if(!var_23522927) {
      load::function_eb7b7382();
      teleport_heroes(name);
    } else {
      level flag::wait_till("all_branch_func_starting");
    }
  }

  if(isDefined(s_skipto.var_2c183249)) {
    [[s_skipto.var_2c183249]](name, starting);
  }
}

function private function_9ab01465() {
  foreach(player in getPlayers()) {
    player function_cdbc8d16(1);
  }
}

function private function_cdbc8d16(frozen) {
  assert(isPlayer(self));

  if(is_true(frozen)) {
    self val::set(#"skipto_freeze", "freezecontrols", 1);
    self val::set(#"skipto_freeze", "pre_load_ghost", 1);
    self thread function_3cdc5488();
    return;
  }

  self val::reset_all(#"skipto_freeze");
}

function private function_3cdc5488() {
  assert(isPlayer(self));
  self notify("3b7171c23ea95cd9");
  self endon("3b7171c23ea95cd9");
  self endon(#"disconnect");
  level flag::wait_till("level_is_go");
  self function_cdbc8d16(0);
}

function clear_recursion() {
  foreach(skipto in level.skipto_settings) {
    skipto.cleanup_recursion = 0;
  }
}

function stop_objective_logic(name, starting, direct, player) {
  if(isarray(name)) {
    foreach(element in name) {
      stop_objective_logic(element, starting, direct, player);
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

      if(!getdvarint(#"art_review", 0)) {
        if(isDefined(level.skipto_settings[name].cleanup_func)) {
          thread[[level.skipto_settings[name].cleanup_func]](name, starting, direct, player);
        }

        standard_objective_done(name, starting, direct, player);
      }

      level notify(name + "_terminate");
    }

    if(!is_true(level.skipto_settings[name].cleanup_recursion)) {
      level.skipto_settings[name].cleanup_recursion = 1;

      if(!is_true(level.skipto_settings[name].looping)) {
        prev = level.skipto_settings[name].prev;

        foreach(element in prev) {
          stop_objective_logic(element, starting, 0, player);
        }
      }

      if(starting && !cleaned) {
        if(!getdvarint(#"art_review", 0)) {
          if(isDefined(level.skipto_settings[name].cleanup_func)) {
            thread[[level.skipto_settings[name].cleanup_func]](name, starting, 0, player);
          }

          standard_objective_done(name, starting, 0, player);
        }
      }
    }
  }
}

function function_f3d2a1c3(e_player) {
  if(!level flag::get("level_has_skiptos")) {
    return "skipto_allies";
  }

  if(!level flag::get("skipto_spawns_ready")) {
    return "skipto_allies";
  }

  if(e_player.team === #"axis") {
    return "skipto_axis";
  } else if(e_player.team === #"allies") {
    return "skipto_allies";
  }

  return undefined;
}

function filter_player_spawnpoints(player, spawnpoints, str_skipto) {
  objectives = isDefined(str_skipto) ? str_skipto : level.skipto_current_objective;

  if(!isDefined(objectives) || !objectives.size) {
    objectives = get_current_skiptos();

    if(!isDefined(objectives) || !objectives.size) {
      objectives = level.default_skipto;
    }
  }

  if(!isarray(objectives) && objectives == "_default") {
    objectives = get_next_skiptos("_default");
  }

  filter = [];

  if(!isDefined(objectives)) {
    objectives = [];
  } else if(!isarray(objectives)) {
    objectives = array(objectives);
  }

  foreach(objective in objectives) {
    if(isDefined(level.skipto_settings[objective])) {
      if(is_true(level.skipto_settings[objective].public) || is_true(level.skipto_settings[objective].dev_skipto)) {
        if(!isDefined(filter)) {
          filter = [];
        } else if(!isarray(filter)) {
          filter = array(filter);
        }

        filter[filter.size] = objective;
      }
    }
  }

  var_52232523 = isDefined(spawnpoints) ? spawnpoints : level.a_s_spawn_points;

  if(filter.size == 0) {
    filter[0] = level.default_skipto;
  }

  if(isDefined(filter) && filter.size > 0) {
    anypoints = [];
    retpoints = [];

    foreach(point in var_52232523) {
      point.different_skipto = 0;

      if(isDefined(point.script_objective) && isinarray(filter, point.script_objective)) {
        if(!isDefined(retpoints)) {
          retpoints = [];
        } else if(!isarray(retpoints)) {
          retpoints = array(retpoints);
        }

        retpoints[retpoints.size] = point;
        continue;
      }

      if(!isDefined(point.script_objective)) {
        if(!isDefined(anypoints)) {
          anypoints = [];
        } else if(!isarray(anypoints)) {
          anypoints = array(anypoints);
        }

        anypoints[anypoints.size] = point;
        continue;
      }

      point.different_skipto = 1;
    }

    if(retpoints.size > 0) {
      return retpoints;
    }

    if(anypoints.size > 0) {
      return anypoints;
    }
  }

  return var_52232523;
}

function delete_start_spawns(str_skipto) {
  a_spawns = spawning::get_spawnpoint_array("cp_coop_spawn");

  foreach(spawn_point in a_spawns) {
    if(spawn_point.script_objective == str_skipto) {
      if(spawn_point.classname !== "script_model") {
        spawn_point delete();
        continue;
      }

      spawn_point struct::delete();
    }
  }
}

function teleport_heroes(str_skipto, var_dad37549) {
  if(!isDefined(level.heroes)) {
    level.heroes = [];
  }

  foreach(ai_hero in level.heroes) {
    b_success = teleport::hero(ai_hero, array(str_skipto, "script_objective"), var_dad37549);

    if(!b_success) {
      iprintlnbold("<dev string:x278>" + str_skipto);
    }
  }
}

function function_60ca00f5() {
  if(isDefined(level.var_7c9795bf)) {
    return level.var_7c9795bf;
  }

  if(isDefined(level.mission_name) && issubstr(tolower(level.mission_name), "cp_gm_")) {
    return tolower(level.mission_name);
  }

  var_266acb38 = getmaporder();

  if(var_266acb38 >= 0) {
    var_e5f80f4e = getmapfields(getmapatindex(var_266acb38));

    if(isDefined(var_e5f80f4e.var_c9d6f30a) && var_e5f80f4e.var_c9d6f30a.size > 0) {
      return var_e5f80f4e.var_c9d6f30a[0].nextmap;
    }

    return getmapatindex(var_266acb38 + 1);
  }
}

function function_455cb6c5(var_83104433) {
  if(isDefined(var_83104433)) {
    var_266acb38 = getmaporder();
    rootmapname = getrootmapname(tolower(var_83104433));

    if(var_266acb38 >= 0) {
      mapbundle = getmapscriptbundle(savegame::get_mission_name());

      if(isDefined(mapbundle) && isDefined(mapbundle.var_c9d6f30a)) {
        foreach(var_5c9a8c92 in mapbundle.var_c9d6f30a) {
          if(tolower(var_5c9a8c92.nextmap) == rootmapname) {
            return var_5c9a8c92.skipto;
          }
        }
      }

      var_cc500e2b = getmapscriptbundle(var_83104433);

      if(isDefined(var_cc500e2b) && isDefined(var_cc500e2b.var_a04dfce6)) {
        return var_cc500e2b.var_a04dfce6;
      }
    }
  }
}

function function_3a9156bf(mission_index) {
  var_9ba5cef7 = savegame::get_player_data("previous_mission", "");

  if(var_9ba5cef7.size == 0) {
    missionname = getmapatindex(mission_index - 1);

    if(isDefined(missionname) && missionname.size != 0) {
      var_9ba5cef7 = missionname;
    }
  }

  return var_9ba5cef7;
}

function function_6914f647() {
  player = getPlayers()[0];
  currentmission = savegame::get_mission_name();
  safehouse = savegame::get_player_data("previous_safehouse", "");

  if(safehouse.size != 0) {
    return safehouse;
  } else {
    missionindex = 0;
    var_4d75d53a = getmapscriptbundle(currentmission);

    if(isDefined(var_4d75d53a) && is_true(var_4d75d53a.isSideMission)) {
      missionindex = player stats::get_stat(#"hash_1e7fdd28f2a28f78", currentmission, #"missionindex");
    }

    if(!isDefined(missionindex) || missionindex == 0) {
      missionindex = getmaporder();
    }

    for(i = missionindex - 1; i >= 0; i--) {
      missionname = getmapatindex(i);
      mapbundle = getmapscriptbundle(missionname);
      missiondata = savegame::get_mission_data(#"persistent", missionname);

      if(isDefined(mapbundle) && is_true(mapbundle.issafehouse) && is_true(missiondata.unlocked) && missionname != #"cp_ger_hub_post_cuba" && missionname != #"cp_ger_hub8") {
        return missionname;
      }
    }
  }

  return "cp_ger_hub";
}

function function_99ddd76d() {
  safehouse = function_6914f647();

  if(safehouse == #"cp_ger_hub_post_yamantau") {
    return 1;
  }

  if(safehouse == #"cp_ger_hub_post_kgb") {
    return 2;
  }

  assert(safehouse != #"cp_ger_hub_post_cuba" && safehouse != #"cp_ger_hub8");
  return 0;
}

function function_cfb483b7() {
  safehouse = function_6914f647();
  skipto = function_547ca7d2(safehouse);
  load::function_cc51116c(safehouse, skipto);
}

function function_787007b6(rootmapname, stat_name) {
  if(!isDefined(rootmapname)) {
    return;
  }

  var_2102f84a = self function_8338f930(stat_name, rootmapname);
  var_7176c82c = self savegame::get_player_data("savegame_" + stat_name);
  var_aa0ccaed = self stats::get_stat(#"playerstatsbymap", rootmapname, #"currentstats", stat_name);
  var_2fc24ec6 = var_2102f84a - var_7176c82c;
  var_aa0ccaed += var_2fc24ec6;
  self stats::set_stat(#"playerstatsbymap", rootmapname, #"currentstats", stat_name, var_aa0ccaed);
}

function function_16c5b1f7() {
  assert(isDefined(self));
  assert(isPlayer(self));

  if(isDefined(self.var_993d990c)) {
    self closeluimenu(self.var_993d990c);

    if(self ishost()) {
      if(savegame::function_7642d0c9()) {}
    }
  }

  level flag::set("credits_done");
  self notify(#"hash_649f3572506356f2");
}

function function_521de2b3() {
  player = getPlayers()[0];

  if(!isDefined(player)) {
    return;
  }

  currentmission = savegame::get_mission_name();
  persistent = savegame::get_mission_data(#"persistent", currentmission);
  transient = savegame::get_mission_data(#"transient", currentmission);
  persistent.complete = 1;
  player stats::set_stat(#"mapdata", currentmission, #"complete", persistent.complete);

  if(!isDefined(persistent.var_8757a567)) {
    persistent.var_8757a567 = 0;
  }

  if(!isDefined(transient.gameskilllowest)) {
    transient.gameskilllowest = 0;
  }

  if(transient.gameskilllowest > persistent.var_8757a567) {
    persistent.var_8757a567 = transient.gameskilllowest;
  }

  player stats::set_stat(#"mapdata", currentmission, #"highestdifficulty", persistent.var_8757a567);
  evidencedata = collectibles::function_293d81b4(2, currentmission);

  foreach(collectible in evidencedata) {
    collectibles::function_316c48a3(collectible.var_430d1d6a, collectible.index);
  }

  uploadstats(player);
}

function level_completed(var_83104433 = function_60ca00f5(), var_585e39fb = function_455cb6c5(var_83104433)) {
  player = getPlayers()[0];

  if(!isPlayer(player)) {
    return;
  }

  if(isDefined(level.var_62b2e325)) {
    level thread[[level.var_62b2e325]]();
  }

  var_8e962e56 = load::function_f97a8023(var_83104433);
  var_8d9ef424 = 0;
  currentmission = savegame::get_mission_name();

  if(!is_final_level()) {
    var_4d75d53a = getmapscriptbundle(currentmission);
    is_safehouse = is_true(var_4d75d53a.issafehouse);
    var_510f193a = is_true(var_4d75d53a.isSideMission);
    var_5e7454e = 0;
    var_9ba5cef7 = savegame::get_player_data("previous_mission", "");

    if(var_9ba5cef7 != "") {
      var_43758eae = getmapscriptbundle(var_9ba5cef7);
      var_5e7454e = is_true(var_43758eae.issafehouse) && var_9ba5cef7 != #"cp_ger_hub_post_cuba" && var_9ba5cef7 != #"cp_ger_hub8";
    }

    if(!var_8e962e56) {
      if(is_safehouse) {
        if(player globallogic_ui::function_4e49c51d(#"hash_3ce5e1167ca8833c", #"hash_13f8ddd8c126fd85", 0, undefined, undefined, undefined, #"hash_30d957f8369ca911", #"hash_5d17f0de4da5d356")) {
          return;
        } else {
          globallogic::function_7b994f00();
        }
      } else if(player globallogic_ui::function_4e49c51d(#"hash_3ce5e1167ca8833c", #"hash_13f8ddd8c126fd85", 0, undefined, undefined, undefined, #"hash_30d957f8369ca911", #"hash_5d17f0de4da5d356")) {
        var_83104433 = function_6914f647();
        var_585e39fb = function_5011fee2(var_83104433);
      } else {
        var_8d9ef424 = 1;
      }
    } else if(var_5e7454e && !is_safehouse && !var_510f193a && savegame::function_ac15668a(currentmission)) {
      if(player globallogic_ui::function_4e49c51d(#"hash_40bb7b88b33df484", undefined, 0, undefined, undefined, undefined, #"hash_30d957f8369ca911", #"hash_1bcb1daaa79d6c2e")) {
        var_83104433 = function_6914f647();
        var_585e39fb = function_547ca7d2(var_83104433);
      }
    }
  }

  if(is_true(level.level_ending)) {
    return;
  }

  if(isDefined(level.skipto_point) && !is_final_level()) {
    objective_completed(level.skipto_point);
  }

  if(level.script === #"cp_ger_hub" || is_final_level()) {
    activities::function_59e67711("_exit");
  }

  level.level_ending = 1;
  setDvar(#"ui_busyblockingamemenu", 1);

  foreach(lvlplayer in level.players) {
    bb::logobjectivestatuschange("_level", lvlplayer, "complete");
    bb::logmatchsummary(lvlplayer);
  }

  matchrecordsetcurrentlevelcomplete();
  matchrecordsetleveldifficultyforindex(1, level.gameskill);
  outromovie = getmapoutromovie();

  if(isDefined(outromovie)) {
    level lui::prime_movie(outromovie);
  }

  if(level.var_7ddd2b02 !== 0) {
    level lui::screen_fade_out(1);
  }

  level notify(#"game_ended");
  util::wait_network_frame();
  set_current_skipto(var_585e39fb);

  foreach(player in getPlayers()) {
    player player::take_weapons();
    player savegame::set_player_data("saved_weapon", player._current_weapon.rootweapon.name);
    player savegame::set_player_data("saved_weapon_attachments", util::function_2146bd83(player._current_weapon));
    player savegame::set_player_data("saved_weapondata", player._weapons);
    player savegame::set_player_data("lives", player.lives);
    player._weapons = undefined;
    player.gun_removed = undefined;
  }

  player_decision::function_d04c220e();
  player_decision::function_ef22e409();
  savegame::set_player_data("previous_mission", savegame::get_mission_name());
  function_521de2b3();

  if(!is_final_level()) {
    savegame::save(var_83104433);
  } else {
    savegame::save();
    function_ec2973c9();
  }

  savegame::clear_mission_data(#"transient");
  world.checkpoint_used = undefined;

  foreach(player in getPlayers()) {
    player thread achievements::function_f854bc50(player, level.map_name, level.gameskill);
  }

  if(isDefined(outromovie)) {
    level thread lui::play_outro_movie(outromovie);
    snd::client_msg("outro_movie");
    player notify(#"menuresponse", {
      #menu: #"full_screen_movie", #response: #"skippable", #value: 1
    });
    level flag::wait_till_clear("playing_outro_movie");
  }

  if(!is_final_level()) {
    if(var_8d9ef424) {
      globallogic::function_7b994f00();
    } else {
      load::next_mission(var_83104433, var_585e39fb);
    }

    return;
  }

  foreach(e_player in level.players) {
    if(!isbot(e_player)) {
      world.var_f2c8b0cb[e_player.name] = e_player.curclass;
    }
  }

  level.var_7c9795bf = undefined;
  level flag::init("credits_done");
  level thread function_18193dd4();

  foreach(player in level.players) {
    player thread function_e8abcd84();
  }

  level flag::wait_till("credits_done");
  level notify(#"credits_done");
  music::setmusicstate("");
  util::wait_network_frame();
  globallogic::function_7b994f00();
}

function function_e8abcd84(var_7a179706 = 0) {
  self endon(#"disconnect", #"hash_649f3572506356f2");

  if(isDefined(self)) {
    if(var_7a179706) {
      self lui::open_script_dialog("ThankYouForPlaying");
    } else {
      self.var_993d990c = self openluimenu("Credit_Fullscreen", 1);
      self val::set(#"credits", "freezecontrols", 1);

      do {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
      }
      while(response != "skipCredits");

      self closeluimenu(self.var_993d990c);
      self val::reset(#"credits", "freezecontrols");
      self.var_993d990c = undefined;

      foreach(player in getPlayers()) {
        player function_16c5b1f7();
      }
    }

    return;
  }

  level flag::set("credits_done");
}

function function_18193dd4() {
  level endon(#"credits_done");
  var_6396ca45 = [];
  var_6396ca45[0] = ["mp_theme", 194.704];
  var_6396ca45[1] = ["kgb_combat", 179.428];
  var_6396ca45[2] = ["bells_theme", 278.95];
  var_6396ca45[3] = ["titlescreen", 198.512];
  var_6396ca45[4] = ["menu_theme_edit", 68.521];
  var_6396ca45[5] = ["", 10];

  while(true) {
    foreach(music_state in var_6396ca45) {
      state = music_state[0];
      seconds = float(music_state[1]);

      if(isstring(state) && isfloat(seconds) && seconds > 0) {
        music::setmusicstate(state);
        wait seconds;
      }
    }
  }
}

function function_8338f930(stat_name, rootmapname) {
  if(!isDefined(rootmapname)) {
    return 0;
  }

  laststat = self stats::get_stat(#"playerstatsbymap", rootmapname, #"currentstats", stat_name);
  var_a1bd2428 = self stats::get_stat(#"playerstatslist", stat_name, #"statvalue");

  if(!isDefined(laststat) || !isDefined(var_a1bd2428)) {
    return 0;
  }

  assert(laststat <= var_a1bd2428);
  return int(abs(var_a1bd2428 - laststat));
}

function private standard_objective_init(skipto, starting) {
  level flag::set(starting);
  level thread watch_completion(starting);

  level.current_skipto = starting;
  level notify(#"update_billboard");
}

function private standard_objective_done(skipto, starting, direct, player) {
  level flag::clear(player);
  level flag::set(player + "_completed");

  if(!isDefined(level.skipto_settings[player])) {
    assertmsg("<dev string:x2b1>" + player);
  }

  waittillframeend();

  if(!is_true(level.preserve_script_objective_ents)) {
    a_entities = getEntArray(player, "script_objective");

    foreach(entity in a_entities) {
      if(issentient(entity)) {
        if((!isDefined(level.heroes) || !isinarray(level.heroes, entity)) && entity.scriptvehicletype !== "player_hunter" && entity.scriptvehicletype !== "player_fav") {
          entity thread util::auto_delete();
        }

        continue;
      }

      entity delete();
    }

    level thread function_30523221(player);
    level thread function_8ca86687(player);
  }

  level thread traps_deployable::clean_traps(0, player, undefined);
}

function function_30523221(str_skipto) {
  var_5ed3cb1c = struct::get_script_bundle_instances("scene", array(str_skipto, "script_objective"));

  foreach(s_scene in var_5ed3cb1c) {
    s_scene scene::stop();
    s_scene struct::delete();

    arrayremovevalue(level.scene_roots, s_scene);

    waitframe(1);
  }
}

function function_8ca86687(str_skipto) {
  a_s_gameobjects = struct::get_array(str_skipto, "script_objective");

  foreach(s_gameobject in a_s_gameobjects) {
    if(isDefined(s_gameobject.mdl_gameobject)) {
      s_gameobject gameobjects::destroy_object(1, 1);
    }
  }
}

function watch_completion(name) {
  first_trigger = undefined;
  objective_triggers = trigger::get_all();

  foreach(trigger in objective_triggers) {
    if(trigger.var_4c81bb34 === name) {
      if(!isDefined(first_trigger)) {
        first_trigger = trigger;
      }

      first_trigger thread trigger_wait_completion(trigger, name);
    }
  }
}

function all_players_touching(trigger) {
  foreach(player in getPlayers()) {
    if(!player istouching(trigger)) {
      return false;
    }
  }

  return true;
}

function trigger_wait_completion(trigger, name) {
  trigger endon(#"death");
  level endon(name + "_terminate");

  if(trigger.script_noteworthy === "allplayers") {
    do {
      waitresult = trigger waittill(#"trigger");
      player = waitresult.activator;
    }
    while(!all_players_touching(trigger));
  } else {
    waitresult = trigger waittill(#"trigger");
    player = waitresult.activator;

    if(trigger.script_noteworthy === "warpplayers") {
      foreach(other_player in level.players) {
        if(other_player != player) {
          other_player thread catch_up_teleport();
        }
      }
    }
  }

  level thread objective_completed(name, 1, player);
}

function catch_up_teleport() {
  self.suicide = 0;
  self.teamkilled = 0;
  timepassed = undefined;

  if(isDefined(self.respawntimerstarttime)) {
    timepassed = (gettime() - self.respawntimerstarttime) / 1000;
  }

  self notify(#"death");
  self thread[[level.spawnclient]](timepassed);
  self.respawntimerstarttime = undefined;
}

function entity_mover_main() {
  entity_movers = struct::get_array("entity_objective_loc");

  foreach(mover in entity_movers) {
    if(!isDefined(mover.angles)) {
      mover.angles = (0, 0, 0);
    }

    if(isDefined(mover.script_objective) && isDefined(level.skipto_settings[mover.script_objective])) {
      if(!isDefined(level.skipto_settings[mover.script_objective].ent_movers)) {
        level.skipto_settings[mover.script_objective].ent_movers = [];
      } else if(!isarray(level.skipto_settings[mover.script_objective].ent_movers)) {
        level.skipto_settings[mover.script_objective].ent_movers = array(level.skipto_settings[mover.script_objective].ent_movers);
      }

      level.skipto_settings[mover.script_objective].ent_movers[level.skipto_settings[mover.script_objective].ent_movers.size] = mover;
    }
  }

  for(;;) {
    waitresult = level waittill(#"objective_changed");
    entity_mover_use_objectives(waitresult.objectives);
  }
}

function entity_mover_use_objectives(objectives) {
  foreach(objective in objectives) {
    foreach(mover in level.skipto_settings[objective].ent_movers) {
      thread apply_mover(mover);
    }
  }
}

function apply_mover(mover) {
  targets = getEntArray(mover.target, "targetname");

  if(isDefined(mover.script_noteworthy) && mover.script_noteworthy == "relative") {
    speed = 0;

    if(isDefined(mover.script_int)) {
      speed = mover.script_int;
    }

    if(speed == 0) {
      speed = float(function_60d95f53()) / 1000;
    }

    foreach(target in targets) {
      if(!isDefined(target.start_mover)) {
        target.start_mover = mover;
        target.last_mover = mover;
      } else {
        start_mover = target.last_mover;
      }

      if(!isDefined(start_mover)) {
        start_mover = mover;
        speed = float(function_60d95f53()) / 1000;
        continue;
      }

      assert(start_mover == target.last_mover, "<dev string:x2cd>");
    }

    if(!isDefined(start_mover) || start_mover == mover) {
      return;
    }

    script_mover = spawn("script_origin", start_mover.origin);
    script_mover.angles = start_mover.angles;

    foreach(target in targets) {
      target linkTo(script_mover, "", script_mover worldtolocalcoords(target.origin), target.angles - script_mover.angles);
    }

    util::wait_network_frame();
    script_mover moveTo(mover.origin, speed);
    script_mover rotateTo(mover.angles, speed);
    script_mover waittill(#"movedone");

    foreach(target in targets) {
      target.last_mover = mover;
      target unlink();
    }

    script_mover delete();
    return;
  }

  foreach(target in targets) {
    target.origin = mover.origin;

    if(isDefined(mover.angles)) {
      target.angles = mover.angles;
    }
  }
}

function set_final_level() {
  level flag::set("final_level");
}

function is_final_level() {
  return level flag::get("final_level");
}

function function_5533c39e(str_skipto, var_5e819c0f = 1) {
  assert(isDefined(level.skipto_settings[str_skipto]), "<dev string:x307>" + str_skipto);
  level.skipto_settings[str_skipto].var_a3d14b6b = var_5e819c0f;
}