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
  level.var_2b1b0a8b = &function_4e3ab877;
  level.var_f1eb9fe4 = &function_8722a51a;
  fields = getmapfields();
  world.var_82105eb4 = undefined;
  level.var_46d8992a = "_default";
  function_7d6f76df("_default");
  function_7d6f76df("no_game", &function_3d4f3242);
  function_16ad9e86(#"gamedata/tables/cp/cp_mapmissions.csv", level.script);
  level.a_s_spawn_points = arraycombine(struct::get_array("cp_coop_spawn", "targetname"), struct::get_array("cp_coop_respawn", "targetname"), 0, 0);
  spawning::function_754c78a6(&function_f3d2a1c3);
  callback::on_spawned(&on_player_spawn);
  callback::on_connect(&on_player_connect);
}

function private postinit() {
  level thread function_ff45bb89();
  level thread handle();
}

function function_228558fd(var_f2d4fd10 = 0, var_7a646627 = 0) {
  var_6bf31125 = [];

  for(i = 0; i < 99; i++) {
    mapname = getmapatindex(i);

    if(!isDefined(mapname)) {
      break;
    }

    mapbundle = function_2717b55f(mapname);

    if(isDefined(mapbundle)) {
      if(is_true(mapbundle.isSideMission)) {
        if(var_f2d4fd10) {
          array::add(var_6bf31125, mapname);
        }

        continue;
      }

      if(is_true(mapbundle.issafehouse)) {
        if(var_7a646627) {
          array::add(var_6bf31125, mapname);
        }

        continue;
      }

      array::add(var_6bf31125, mapname);
    }
  }

  return var_6bf31125;
}

function function_fb89516e(var_d3440450) {
  return level flag::get(var_d3440450);
}

function function_fbae1b12(var_d3440450) {
  return level flag::get(var_d3440450 + "_completed");
}

function function_9a209ed9(var_d3440450) {
  level flag::wait_till(var_d3440450 + "_completed");
}

function function_c0f982ff() {
  return arraycopy(level.var_28c22d88);
}

function add(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_e5301d70, var_4444a90d = 0) {
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
  assert(isDefined(var_e784b061), "<dev string:x5f>");
  struct = function_7d6f76df(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, undefined, var_4444a90d, var_e5301d70);
  struct.public = 1;
  level flag::set("level_has_skiptos");
}

function function_eb91535d(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_e5301d70) {
  struct = add(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_e5301d70, 1);
}

function function_9c003a50(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d) {
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

  struct = function_7d6f76df(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d);
  struct.public = 1;
  level flag::set("level_has_skiptos");
  level flag::set("level_has_skipto_branches");
  return struct;
}

function function_faeed11(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d) {
  struct = function_9c003a50(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d);

  if(isDefined(struct)) {
    struct.looping = 1;
  }
}

function add_dev(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d, var_e5301d70) {
  if(is_dev(skipto)) {
    struct = function_7d6f76df(skipto, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d, 0, var_e5301d70);
    struct.var_f36d5247 = 1;
    return;
  }

  errormsg("<dev string:x95>");
}

function function_227d7faa(skipto) {
  if(!isDefined(level.var_c55064fd[skipto])) {
    assertmsg("<dev string:xc1>" + skipto + "<dev string:xe7>");
    return;
  }

  level.var_c55064fd[skipto].var_39911cf2 = 0;

  foreach(player in level.players) {
    bb::function_47cb52f6(skipto, player, "leave_incomplete");
  }
}

function function_94c5792c(skipto, event_name, event_type, event_size, var_e96e3d07) {
  if(!isDefined(level.billboards)) {
    level.billboards = [];
  }

  level.billboards[skipto] = array(event_name, event_type, event_size, var_e96e3d07);
}

function function_7d6f76df(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d, var_4444a90d, var_e5301d70) {
  assert(!isDefined(level._loadstarted), "<dev string:x11f>");
  msg = tolower(msg);
  struct = function_5d3e3cf9(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d, var_4444a90d, var_e5301d70);
  level.var_c55064fd[msg] = struct;
  level flag::init(msg);
  level flag::init(msg + "_completed");
  return struct;
}

function change(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d) {
  struct = level.var_c55064fd[msg];

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

  if(isDefined(var_672c77b1)) {
    struct.var_67ea79fe = struct function_5579990(var_672c77b1);
  }

  if(isDefined(var_89f09f8d)) {
    struct.var_89f09f8d = strtok(var_89f09f8d, ",");
    struct.next = struct.var_89f09f8d;
  }
}

function function_b0cce1ee(func) {
  level.var_8252160a = func;
}

function function_5d3e3cf9(msg, var_e784b061, var_dde96e3b, str_name, cleanup_func, var_672c77b1, var_89f09f8d, var_4444a90d = 0, var_e5301d70) {
  struct = spawnStruct();
  struct.name = msg;
  struct.var_8a2e8898 = registerskipto(msg);
  struct.var_2c183249 = var_e784b061;
  struct.var_4c644f8d = var_dde96e3b;
  struct.str_name = str_name;
  struct.cleanup_func = cleanup_func;
  struct.next = [];
  struct.prev = [];
  struct.var_67ea79fe = "";
  struct.var_672c77b1 = [];
  struct.var_4444a90d = var_4444a90d;
  struct.var_e5301d70 = var_e5301d70;

  if(isDefined(var_672c77b1)) {
    struct.var_67ea79fe = struct function_5579990(var_672c77b1);
  }

  struct.var_89f09f8d = [];

  if(isDefined(var_89f09f8d)) {
    struct.var_89f09f8d = strtok(var_89f09f8d, ",");
    struct.next = struct.var_89f09f8d;
  }

  struct.var_80fa98d9 = [];
  return struct;
}

function function_88b0c3ba() {
  return level flag::get("level_has_skiptos");
}

function function_3e8267cc(msg) {
  assertmsg(msg);
}

function function_e3b9f1f5(instring) {
  op = "";
  ret = [];
  outindex = 0;
  ret[outindex] = "";
  var_b47752c3 = 0;

  for(i = 0; i < instring.size; i++) {
    c = getsubstr(instring, i, i + 1);

    if(c == "(") {
      var_b47752c3++;
      ret[outindex] += c;
      continue;
    }

    if(c == ")") {
      var_b47752c3--;
      ret[outindex] += c;
      continue;
    }

    if(var_b47752c3 == 0 && c == "&") {
      if(op == "|") {
        function_3e8267cc("<dev string:x143>" + instring);
      }

      op = "&";
      outindex++;
      ret[outindex] = "";
      continue;
    }

    if(var_b47752c3 == 0 && c == "|") {
      if(op == "&") {
        function_3e8267cc("<dev string:x143>" + instring);
      }

      op = "|";
      outindex++;
      ret[outindex] = "";
      continue;
    }

    ret[outindex] += c;
  }

  if(var_b47752c3 != 0) {
    function_3e8267cc("<dev string:x172>" + instring);
  }

  for(j = 0; j <= outindex; j++) {
    ret[j] = function_6fe3a223(ret[j]);
  }

  if(outindex == 0) {
    return ret[outindex];
  }

  ret[#"op"] = op;
  return ret;
}

function function_6fe3a223(instring) {
  c = getsubstr(instring, 0, 1);

  if(c == "(") {
    c2 = getsubstr(instring, instring.size - 1, instring.size);

    if(c2 != ")") {
      function_3e8267cc("<dev string:x172>" + instring);
    }

    s = getsubstr(instring, 1, instring.size - 1);
    return function_e3b9f1f5(s);
  }

  if(!isDefined(self.var_672c77b1)) {
    self.var_672c77b1 = [];
  } else if(!isarray(self.var_672c77b1)) {
    self.var_672c77b1 = array(self.var_672c77b1);
  }

  self.var_672c77b1[self.var_672c77b1.size] = instring;
  return instring;
}

function function_5579990(var_672c77b1) {
  retval = function_e3b9f1f5(var_672c77b1);

  if(isarray(retval)) {
    return retval;
  }

  return "";
}

function function_4350c864(conditions, adding) {
  if(!isarray(conditions)) {
    if(isDefined(level.var_c55064fd[conditions]) && (is_true(level.var_c55064fd[conditions].var_9dd617f2) || isinarray(adding, conditions))) {
      return 0;
    }

    return 1;
  }

  if(conditions[#"op"] == "|") {
    for(i = 0; i < conditions.size - 1; i++) {
      if(function_4350c864(conditions[i], adding)) {
        return 1;
      }
    }

    return 0;
  }

  for(i = 0; i < conditions.size - 1; i++) {
    if(!function_4350c864(conditions[i], adding)) {
      return 0;
    }
  }

  return 1;
}

function function_896ee7c3(objectives) {
  result = [];

  foreach(name in objectives) {
    if(function_4350c864(level.var_c55064fd[name].var_67ea79fe, result)) {
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

          if(!isDefined(level.var_c55064fd[#"_default"].next)) {
            level.var_c55064fd[#"_default"].next = [];
          } else if(!isarray(level.var_c55064fd[#"_default"].next)) {
            level.var_c55064fd[#"_default"].next = array(level.var_c55064fd[#"_default"].next);
          }

          level.var_c55064fd[#"_default"].next[level.var_c55064fd[#"_default"].next.size] = struct.name;
        }
      } else {
        if(!isDefined(level.var_c55064fd[#"_default"].next)) {
          level.var_c55064fd[#"_default"].next = [];
        } else if(!isarray(level.var_c55064fd[#"_default"].next)) {
          level.var_c55064fd[#"_default"].next = array(level.var_c55064fd[#"_default"].next);
        }

        level.var_c55064fd[#"_default"].next[level.var_c55064fd[#"_default"].next.size] = struct.name;
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

function function_375821d8(skipto_name) {
  if(scene::function_a4dedc63()) {
    return function_f3c37963(skipto_name);
  }

  if(getgametypesetting(#"hash_72a2919d2ac65850")) {
    return function_694aaea7(skipto_name);
  }

  if(isDefined(level.var_c55064fd[skipto_name])) {
    return level.var_c55064fd[skipto_name].next;
  }

  return level.var_c55064fd[#"_default"].next;
}

function function_694aaea7(skipto_name) {
  var_c23e8af7 = [];
  var_c23e8af7[0] = skipto_name;

  while(isDefined(level.var_c55064fd[var_c23e8af7[0]])) {
    if(level.var_c55064fd[var_c23e8af7[0]].next.size) {
      var_c23e8af7 = level.var_c55064fd[var_c23e8af7[0]].next;

      if(var_c23e8af7.size && !is_true(level.var_c55064fd[var_c23e8af7[0]].var_a3d14b6b)) {
        return var_c23e8af7;
      }

      continue;
    }

    return var_c23e8af7;
  }

  return level.var_c55064fd[#"_default"].next;
}

function function_f3c37963(skipto_name) {
  var_c23e8af7 = [];
  var_c23e8af7[0] = skipto_name;

  while(isDefined(level.var_c55064fd[var_c23e8af7[0]])) {
    if(level.var_c55064fd[var_c23e8af7[0]].next.size) {
      var_c23e8af7 = level.var_c55064fd[var_c23e8af7[0]].next;

      if(var_c23e8af7.size && is_true(level.var_c55064fd[var_c23e8af7[0]].var_a3d14b6b)) {
        return var_c23e8af7;
      }

      continue;
    }

    return var_c23e8af7;
  }

  return level.var_c55064fd[#"_default"].next;
}

function function_116cfcba(skiptos) {
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

function function_5a61e21a(var_7e8557ba) {
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

function function_5011fee2(missionname = savegame::function_8136eb5a()) {
  mapbundle = function_2717b55f(missionname);

  if(isDefined(mapbundle) && isDefined(mapbundle.var_a04dfce6)) {
    return mapbundle.var_a04dfce6;
  }

  return "";
}

function function_547ca7d2(safehouse, var_fc9732a9 = 1) {
  mapbundle = function_2717b55f(safehouse);
  assert(isDefined(mapbundle) && isDefined(mapbundle.issafehouse));

  if(safehouse == # "cp_ger_hub_post_cuba" || safehouse == # "cp_ger_hub8") {
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
  if(!isDefined(level.var_c55064fd[skipto_name])) {
    return -1;
  }

  return level.var_c55064fd[skipto_name].var_8a2e8898;
}

function function_a002f769() {
  if(!isDefined(level.var_b28c2c3a) || !isDefined(level.var_c55064fd[level.var_b28c2c3a])) {
    return -1;
  }

  return level.var_c55064fd[level.var_b28c2c3a].var_8a2e8898;
}

function function_8722a51a(skipto = "", var_3bac111e) {
  if(skipto == "") {
    var_209694d6 = array("");
  } else {
    var_209694d6 = strtok(skipto, ",");
  }

  foreach(var_d3440450 in var_209694d6) {
    if(is_true(var_3bac111e) || var_d3440450 != "" && level.var_c55064fd[var_d3440450].var_4444a90d === 1) {
      setskiptos(tolower(var_d3440450), 1);
      continue;
    }

    setskiptos(tolower(var_d3440450), 0);
  }
}

function function_2bc844d6(skiptos) {
  function_8722a51a(function_116cfcba(skiptos));
}

function function_6a4ace51() {
  if(!isDefined(level.var_46d8992a)) {
    level.var_46d8992a = "";
  }

  function_8722a51a(level.var_46d8992a);
}

function function_9e3233ed(skiptos) {
  done = 0;

  while(isDefined(skiptos) && skiptos.size && !done) {
    done = 1;

    foreach(skipto in skiptos) {
      if(!isDefined(level.var_c55064fd[skipto])) {
        arrayremovevalue(skiptos, skipto, 0);
        done = 0;
        break;
      }
    }
  }

  return skiptos;
}

function handle() {
  function_a59cd1c9();
  level flag::wait_till("start_skiptos");
  var_9bbdab8b = function_375821d8("_default");
  skiptos = function_5a61e21a(1);
  var_4aaf7303 = getdvarstring(#"skipto_jump");

  if(isDefined(var_4aaf7303) && var_4aaf7303.size) {
    setDvar(#"skipto_jump", "");
  }

  var_4aaf7303 = getdvarstring(#"skipto_wipe");

  if(isDefined(var_4aaf7303) && var_4aaf7303.size) {
    setDvar(#"skipto_wipe", "");
  }

  skiptos = function_9e3233ed(skiptos);
  assert(is_true(level.first_frame), "<dev string:x1a0>");

  if(isDefined(level.var_b28c2c3a)) {
    skiptos = [];
    skiptos[0] = level.var_b28c2c3a;
  }

  level.var_28c22d88 = skiptos;
  skipto = skiptos[0];

  if(isDefined(skipto) && isDefined(level.var_c55064fd[skipto])) {
    level.var_b28c2c3a = skipto;
  }

  is_default = 0;
  start = level.var_28c22d88;

  if(start.size < 1) {
    is_default = 1;
    start = var_9bbdab8b;

    if(isDefined(level.var_46d8992a)) {
      level.var_b28c2c3a = level.var_46d8992a;
    }
  } else {
    level thread sndlevelstartduck_shutoff();
  }

  level.var_d0fc1e7c = start;
  skipto = start[0];

  if(isDefined(skipto) && isDefined(level.var_c55064fd[skipto])) {
    level.var_b28c2c3a = skipto;
  }

  if(start.size < 1) {
    level thread sndlevelstartduck_shutoff();
    level thread load::function_eb7b7382();
    return;
  }

  if(!is_default) {
    function_da9b925(var_9bbdab8b);
  }

  level flag::set(#"scene_on_load_wait");
  var_3d5f0584 = level.var_c55064fd[start[0]];

  if(var_3d5f0584.var_8a2e8898 != 3) {
    level.var_9caf4a12 = 1;
  }

  function_51726ac8(start, 1);
  callback::callback(#"hash_7177603f5415549b");
  savegame::save();
  currentmission = savegame::function_8136eb5a();
  mapbundle = function_2717b55f(currentmission);

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

function function_3d4f3242() {
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

function function_53c3e1eb() {
  return is_dev(level.var_b28c2c3a);
}

function function_2758c617() {
  if(!isDefined(level.var_b28c2c3a)) {
    return 0;
  }

  return issubstr(level.var_b28c2c3a, "no_game");
}

function function_90e25b64() {
  if(!function_2758c617()) {
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

  objectiveindex = level.var_c55064fd[objectivename].var_8a2e8898;
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
  var_313c84fd = 0;
  var_d72847a7 = 0;
  var_17cff347 = 0;
  var_1940d7af = 0;
  var_1bd74555 = 0;

  if(isDefined(player.movementtracking)) {
    if(isDefined(player.movementtracking.wallrunning)) {
      var_d72847a7 = player.movementtracking.wallrunning.distance;
      var_1940d7af = player.movementtracking.wallrunning.count;
    }

    if(isDefined(player.movementtracking.sprinting)) {
      var_313c84fd = player.movementtracking.sprinting.distance;
    }

    if(isDefined(player.movementtracking.doublejump)) {
      var_17cff347 = player.movementtracking.doublejump.distance;
      var_1bd74555 = player.movementtracking.doublejump.count;
    }
  }

  player function_9ef3400f("distance_wallrun", objectiveindex, player.var_62e314f8.distance_wallrun, int(var_d72847a7));
  player function_9ef3400f("distance_sprinted", objectiveindex, player.var_62e314f8.distance_sprinted, int(var_313c84fd));
  player function_9ef3400f("distance_boosted", objectiveindex, player.var_62e314f8.distance_boosted, int(var_17cff347));
  player function_9ef3400f("wallruns_total", objectiveindex, player.var_62e314f8.wallruns_total, int(var_1940d7af));
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
  var_313c84fd = 0;
  var_d72847a7 = 0;
  var_17cff347 = 0;
  var_1940d7af = 0;
  var_1bd74555 = 0;

  if(isDefined(player.movementtracking)) {
    if(isDefined(player.movementtracking.wallrunning)) {
      var_d72847a7 = player.movementtracking.wallrunning.distance;
      var_1940d7af = player.movementtracking.wallrunning.count;
    }

    if(isDefined(player.movementtracking.sprinting)) {
      var_313c84fd = player.movementtracking.sprinting.distance;
    }

    if(isDefined(player.movementtracking.doublejump)) {
      var_17cff347 = player.movementtracking.doublejump.distance;
      var_1bd74555 = player.movementtracking.doublejump.count;
    }
  }

  player.var_62e314f8.distance_wallrun = int(var_d72847a7);
  player.var_62e314f8.distance_sprinted = int(var_313c84fd);
  player.var_62e314f8.distance_boosted = int(var_17cff347);
  player.var_62e314f8.wallruns_total = int(var_1940d7af);
  player.var_62e314f8.boosts_total = int(var_1bd74555);
}

function on_player_connect() {
  if(is_true(level.var_cc83507)) {
    return;
  }

  rootmapname = getrootmapname();

  if(!isDefined(rootmapname)) {
    return;
  }

  if(getdvarint(#"ui_blocksaves", 0) == 0) {
    if(self ishost()) {
      var_ea1ac9c = 1;

      if(sessionmodeisonlinegame()) {
        var_ea1ac9c = is_true(self stats::get_stat(#"hash_46e7db8ceaba5b2f"));
      } else {
        var_ea1ac9c = is_true(self stats::get_stat(#"hash_d4aef679e9c5e94", 0));
      }

      if(!var_ea1ac9c) {
        self savegame::set_player_data("savegame_score", self function_8338f930("SCORE", rootmapname));
        self savegame::set_player_data("savegame_kills", self function_8338f930("KILLS", rootmapname));
        self savegame::set_player_data("savegame_assists", self function_8338f930("ASSISTS", rootmapname));
        self savegame::set_player_data("savegame_incaps", self function_8338f930("INCAPS", rootmapname));
        self savegame::set_player_data("savegame_revives", self function_8338f930("REVIVES", rootmapname));

        if(sessionmodeisonlinegame()) {
          self stats::set_stat(#"hash_46e7db8ceaba5b2f", 1);
        } else {
          self stats::set_stat(#"hash_d4aef679e9c5e94", 0, 1);
        }

        uploadstats(self);
      }

      if(!isDefined(self savegame::function_2ee66e93("savegame_score"))) {
        self savegame::set_player_data("savegame_score", 0);
      }

      if(!isDefined(self savegame::function_2ee66e93("savegame_kills"))) {
        self savegame::set_player_data("savegame_kills", 0);
      }

      if(!isDefined(self savegame::function_2ee66e93("savegame_assists"))) {
        self savegame::set_player_data("savegame_assists", 0);
      }

      if(!isDefined(self savegame::function_2ee66e93("savegame_incaps"))) {
        self savegame::set_player_data("savegame_incaps", 0);
      }

      if(!isDefined(self savegame::function_2ee66e93("savegame_revives"))) {
        self savegame::set_player_data("savegame_revives", 0);
      }

      self.pers[#"score"] = self savegame::function_2ee66e93("savegame_score", 0);
      self.pers[#"kills"] = self savegame::function_2ee66e93("savegame_kills", 0);
      self.pers[#"assists"] = self savegame::function_2ee66e93("savegame_assists", 0);
      self.pers[#"incaps"] = self savegame::function_2ee66e93("savegame_incaps", 0);
      self.pers[#"revives"] = self savegame::function_2ee66e93("savegame_revives", 0);
      self.score = self.pers[#"score"];
      self.kills = self.pers[#"kills"];
      self.assists = self.pers[#"assists"];
      self.incaps = self.pers[#"incaps"];
      self.revives = self.pers[#"revives"];
    }
  }

  function_7c7195b4(self);
}

function function_4e3ab877(name, var_28e39919 = 1, player, var_ce580a72) {
  assert(isDefined(level.var_c55064fd[name]), "<dev string:x1b8>" + name + "<dev string:x1cc>");

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

  setDvar(#"hash_328d096ed229649d", 1);

  foreach(statplayer in level.players) {
    if(statplayer istestclient()) {
      continue;
    }

    bb::function_47cb52f6(name, statplayer, "complete");
    statplayer globallogic_player::function_4d3e38fb();
  }

  if(isDefined(name)) {
    if(isDefined(player) && !isDefined(var_ce580a72)) {
      function_da5051ef(name, player);
    } else {
      foreach(var_bd93cbe5 in level.players) {
        function_da5051ef(name, var_bd93cbe5);
      }
    }

    level function_60288de7(name, 0, 1, player);
  }

  if(var_28e39919) {
    next = function_375821d8(name);
    next = function_896ee7c3(next);

    if(isDefined(next) && next.size > 0) {
      level function_51726ac8(next, 0, player);
    }
  }
}

function function_54d73210(objectives) {
  rootclear = "<dev string:x1f8>";
  adddebugcommand(rootclear);
  var_cbb67a83 = "<dev string:x221>";
  var_7b015bbc = var_cbb67a83 + "<dev string:x23c>";
  index = 1;

  foreach(objective in objectives) {
    name = objective + "<dev string:x249>" + index;
    index++;
    adddebugcommand(var_7b015bbc + name + "<dev string:x24e>" + "<dev string:x259>" + "<dev string:x26c>" + objective + "<dev string:x271>");
  }
}

function function_51726ac8(objectives, starting, player) {
  function_fc434ec9();

  foreach(name in objectives) {
    if(isDefined(level.var_c55064fd[name])) {
      function_60288de7(level.var_c55064fd[name].prev, starting, 0, player);
    }
  }

  if(isDefined(level.var_8252160a)) {
    foreach(name in objectives) {
      thread[[level.var_8252160a]](name);
    }
  }

  function_d037bbec(objectives, starting);
  level.var_b28c2c3a = level.var_28c22d88[0];

  if(!is_true(level.level_ending)) {
    function_2bc844d6(level.var_28c22d88);
  }

  level notify(#"objective_changed", {
    #objectives: level.var_28c22d88
  });
  activities::function_59e67711(objectives[0]);
  function_54d73210(level.var_28c22d88);

  if(isDefined(player)) {
    function_7c7195b4(player);
  } else {
    foreach(var_bd93cbe5 in level.players) {
      function_7c7195b4(var_bd93cbe5);
    }
  }

  update_spawn_points(starting);
}

function update_spawn_points(var_50cc0d4f) {
  level.var_cd012e52 = function_ffdc86a2();
  level flag::set("skipto_spawns_ready");
}

function function_d037bbec(name, starting, var_23522927 = 0) {
  if(isarray(name)) {
    if(starting && name.size > 1) {
      load::function_ba5622e();
      var_23522927 = 1;
      level flag::init("all_branch_func_starting");
    }

    level flag::wait_till("all_players_connected");

    foreach(element in name) {
      function_d037bbec(element, starting, var_23522927);
    }

    if(starting && name.size > 1) {
      load::function_eb7b7382();
      level flag::set("all_branch_func_starting");
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

      if(!getdvarint(#"art_review", 0)) {
        function_d8ddef0(name, starting);
        level thread function_b7e9926c(name, starting, var_23522927);

        if(is_true(level.var_c55064fd[name].var_4444a90d)) {
          savegame::checkpoint_save(1);
        }
      }
    }

    if(!is_true(level.var_c55064fd[name].var_a9880cee) && isDefined(level.var_c55064fd[name].var_d177b2f)) {
      level.var_c55064fd[name].var_a9880cee = 1;
      thread[[level.var_c55064fd[name].var_d177b2f]](name);
    }
  }

  foreach(player in level.players) {
    bb::function_47cb52f6(name, player, "start");
  }
}

function private function_b7e9926c(name, starting, var_23522927) {
  var_3d5f0584 = level.var_c55064fd[name];

  if(is_true(var_3d5f0584.var_4444a90d)) {
    savegame::function_7e0e735b();
  }

  if(isDefined(var_3d5f0584.var_e5301d70)) {
    level districts::function_a7d79fcb(var_3d5f0584.var_e5301d70, 1);
  }

  function_9ab01465();

  if(starting) {
    if(!var_23522927) {
      load::function_ba5622e();
    }

    if(isDefined(var_3d5f0584.var_4c644f8d)) {
      [[var_3d5f0584.var_4c644f8d]](name);
    }

    if(!var_23522927) {
      load::function_eb7b7382();
      function_6f46b798(name);
    } else {
      level flag::wait_till("all_branch_func_starting");
    }
  }

  if(isDefined(var_3d5f0584.var_2c183249)) {
    [[var_3d5f0584.var_2c183249]](name, starting);
  }
}

function private function_9ab01465() {
  foreach(player in getplayers()) {
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

function function_fc434ec9() {
  foreach(skipto in level.var_c55064fd) {
    skipto.var_a6ddf9d6 = 0;
  }
}

function function_60288de7(name, starting, direct, player) {
  if(isarray(name)) {
    foreach(element in name) {
      function_60288de7(element, starting, direct, player);
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

      if(!getdvarint(#"art_review", 0)) {
        if(isDefined(level.var_c55064fd[name].cleanup_func)) {
          thread[[level.var_c55064fd[name].cleanup_func]](name, starting, direct, player);
        }

        function_9b847391(name, starting, direct, player);
      }

      level notify(name + "_terminate");
    }

    if(!is_true(level.var_c55064fd[name].var_a6ddf9d6)) {
      level.var_c55064fd[name].var_a6ddf9d6 = 1;

      if(!is_true(level.var_c55064fd[name].looping)) {
        prev = level.var_c55064fd[name].prev;

        foreach(element in prev) {
          function_60288de7(element, starting, 0, player);
        }
      }

      if(starting && !cleaned) {
        if(!getdvarint(#"art_review", 0)) {
          if(isDefined(level.var_c55064fd[name].cleanup_func)) {
            thread[[level.var_c55064fd[name].cleanup_func]](name, starting, 0, player);
          }

          function_9b847391(name, starting, 0, player);
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

  if(e_player.team === # "axis") {
    return "skipto_axis";
  } else if(e_player.team === # "allies") {
    return "skipto_allies";
  }

  return undefined;
}

function function_ffdc86a2(player, spawnpoints, var_d3440450) {
  objectives = isDefined(var_d3440450) ? var_d3440450 : level.var_28c22d88;

  if(!isDefined(objectives) || !objectives.size) {
    objectives = function_5a61e21a();

    if(!isDefined(objectives) || !objectives.size) {
      objectives = level.var_46d8992a;
    }
  }

  if(!isarray(objectives) && objectives == "_default") {
    objectives = function_375821d8("_default");
  }

  filter = [];

  if(!isDefined(objectives)) {
    objectives = [];
  } else if(!isarray(objectives)) {
    objectives = array(objectives);
  }

  foreach(objective in objectives) {
    if(isDefined(level.var_c55064fd[objective])) {
      if(is_true(level.var_c55064fd[objective].public) || is_true(level.var_c55064fd[objective].var_f36d5247)) {
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
    filter[0] = level.var_46d8992a;
  }

  if(isDefined(filter) && filter.size > 0) {
    var_1baeb4e5 = [];
    var_a76bf581 = [];

    foreach(point in var_52232523) {
      point.var_2d830bf1 = 0;

      if(isDefined(point.script_objective) && isinarray(filter, point.script_objective)) {
        if(!isDefined(var_a76bf581)) {
          var_a76bf581 = [];
        } else if(!isarray(var_a76bf581)) {
          var_a76bf581 = array(var_a76bf581);
        }

        var_a76bf581[var_a76bf581.size] = point;
        continue;
      }

      if(!isDefined(point.script_objective)) {
        if(!isDefined(var_1baeb4e5)) {
          var_1baeb4e5 = [];
        } else if(!isarray(var_1baeb4e5)) {
          var_1baeb4e5 = array(var_1baeb4e5);
        }

        var_1baeb4e5[var_1baeb4e5.size] = point;
        continue;
      }

      point.var_2d830bf1 = 1;
    }

    if(var_a76bf581.size > 0) {
      return var_a76bf581;
    }

    if(var_1baeb4e5.size > 0) {
      return var_1baeb4e5;
    }
  }

  return var_52232523;
}

function function_cf991ea5(var_d3440450) {
  a_spawns = spawning::get_spawnpoint_array("cp_coop_spawn");

  foreach(spawn_point in a_spawns) {
    if(spawn_point.script_objective == var_d3440450) {
      if(spawn_point.classname !== "script_model") {
        spawn_point delete();
        continue;
      }

      spawn_point struct::delete();
    }
  }
}

function function_6f46b798(var_d3440450, var_dad37549) {
  if(!isDefined(level.heroes)) {
    level.heroes = [];
  }

  foreach(ai_hero in level.heroes) {
    b_success = teleport::hero(ai_hero, array(var_d3440450, "script_objective"), var_dad37549);

    if(!b_success) {
      iprintlnbold("<dev string:x278>" + var_d3440450);
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
      mapbundle = function_2717b55f(savegame::function_8136eb5a());

      if(isDefined(mapbundle) && isDefined(mapbundle.var_c9d6f30a)) {
        foreach(var_5c9a8c92 in mapbundle.var_c9d6f30a) {
          if(tolower(var_5c9a8c92.nextmap) == rootmapname) {
            return var_5c9a8c92.skipto;
          }
        }
      }

      var_cc500e2b = function_2717b55f(var_83104433);

      if(isDefined(var_cc500e2b) && isDefined(var_cc500e2b.var_a04dfce6)) {
        return var_cc500e2b.var_a04dfce6;
      }
    }
  }
}

function function_3a9156bf(mission_index) {
  var_9ba5cef7 = savegame::function_2ee66e93("previous_mission", "");

  if(var_9ba5cef7.size == 0) {
    missionname = getmapatindex(mission_index - 1);

    if(isDefined(missionname) && missionname.size != 0) {
      var_9ba5cef7 = missionname;
    }
  }

  return var_9ba5cef7;
}

function function_6914f647() {
  player = getplayers()[0];
  currentmission = savegame::function_8136eb5a();
  safehouse = savegame::function_2ee66e93("previous_safehouse", "");

  if(safehouse.size != 0) {
    return safehouse;
  } else {
    missionindex = 0;
    var_4d75d53a = function_2717b55f(currentmission);

    if(isDefined(var_4d75d53a) && is_true(var_4d75d53a.isSideMission)) {
      missionindex = player stats::get_stat(#"hash_1e7fdd28f2a28f78", currentmission, #"missionindex");
    }

    if(!isDefined(missionindex) || missionindex == 0) {
      missionindex = getmaporder();
    }

    for(i = missionindex - 1; i >= 0; i--) {
      missionname = getmapatindex(i);
      mapbundle = function_2717b55f(missionname);
      missiondata = savegame::function_6440b06b(#"persistent", missionname);

      if(isDefined(mapbundle) && is_true(mapbundle.issafehouse) && is_true(missiondata.unlocked) && missionname != # "cp_ger_hub_post_cuba" && missionname != # "cp_ger_hub8") {
        return missionname;
      }
    }
  }

  return "cp_ger_hub";
}

function function_99ddd76d() {
  safehouse = function_6914f647();

  if(safehouse == # "cp_ger_hub_post_yamantau") {
    return 1;
  }

  if(safehouse == # "cp_ger_hub_post_kgb") {
    return 2;
  }

  assert(safehouse != # "cp_ger_hub_post_cuba" && safehouse != # "cp_ger_hub8");
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
  var_7176c82c = self savegame::function_2ee66e93("savegame_" + stat_name);
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
  player = getplayers()[0];

  if(!isDefined(player)) {
    return;
  }

  currentmission = savegame::function_8136eb5a();
  persistent = savegame::function_6440b06b(#"persistent", currentmission);
  transient = savegame::function_6440b06b(#"transient", currentmission);
  persistent.complete = 1;
  player stats::set_stat(#"mapdata", currentmission, #"complete", persistent.complete);

  if(!isDefined(persistent.var_8757a567)) {
    persistent.var_8757a567 = 0;
  }

  if(!isDefined(transient.var_9ac9bc79)) {
    transient.var_9ac9bc79 = 0;
  }

  if(transient.var_9ac9bc79 > persistent.var_8757a567) {
    persistent.var_8757a567 = transient.var_9ac9bc79;
  }

  player stats::set_stat(#"mapdata", currentmission, #"highestdifficulty", persistent.var_8757a567);
  evidencedata = collectibles::function_293d81b4(2, currentmission);

  foreach(collectible in evidencedata) {
    collectibles::function_316c48a3(collectible.var_430d1d6a, collectible.index);
  }

  uploadstats(player);
}

function function_1c2dfc20(var_83104433 = function_60ca00f5(), var_585e39fb = function_455cb6c5(var_83104433)) {
  player = getplayers()[0];

  if(!isPlayer(player)) {
    return;
  }

  if(isDefined(level.var_62b2e325)) {
    level thread[[level.var_62b2e325]]();
  }

  var_8e962e56 = load::function_f97a8023(var_83104433);
  var_8d9ef424 = 0;
  currentmission = savegame::function_8136eb5a();

  if(!function_3b424100()) {
    var_4d75d53a = function_2717b55f(currentmission);
    is_safehouse = is_true(var_4d75d53a.issafehouse);
    var_510f193a = is_true(var_4d75d53a.isSideMission);
    var_5e7454e = 0;
    var_9ba5cef7 = savegame::function_2ee66e93("previous_mission", "");

    if(var_9ba5cef7 != "") {
      var_43758eae = function_2717b55f(var_9ba5cef7);
      var_5e7454e = is_true(var_43758eae.issafehouse) && var_9ba5cef7 != # "cp_ger_hub_post_cuba" && var_9ba5cef7 != # "cp_ger_hub8";
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

  if(isDefined(level.var_b28c2c3a) && !function_3b424100()) {
    function_4e3ab877(level.var_b28c2c3a);
  }

  if(level.script === # "cp_ger_hub" || function_3b424100()) {
    activities::function_59e67711("_exit");
  }

  level.level_ending = 1;
  setDvar(#"ui_busyblockingamemenu", 1);

  foreach(var_bd93cbe5 in level.players) {
    bb::function_47cb52f6("_level", var_bd93cbe5, "complete");
    bb::function_74cad77c(var_bd93cbe5);
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
  function_8722a51a(var_585e39fb);

  foreach(player in getplayers()) {
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
  savegame::set_player_data("previous_mission", savegame::function_8136eb5a());
  function_521de2b3();

  if(!function_3b424100()) {
    savegame::save(var_83104433);
  } else {
    savegame::save();
    function_ec2973c9();
  }

  savegame::function_81534803(#"transient");
  world.var_b86bf11e = undefined;

  foreach(player in getplayers()) {
    player thread achievements::function_f854bc50(player, level.map_name, level.gameskill);
  }

  if(isDefined(outromovie)) {
    level thread lui::play_outro_movie(outromovie);
    snd::client_msg("outro_movie");
    player notify(#"menuresponse", {
      #menu: # "full_screen_movie", #response: # "skippable", #value: 1
    });
    level flag::wait_till_clear("playing_outro_movie");
  }

  if(!function_3b424100()) {
    if(var_8d9ef424) {
      globallogic::function_7b994f00();
    } else {
      load::function_c9154eb7(var_83104433, var_585e39fb);
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

      foreach(player in getplayers()) {
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

function private function_d8ddef0(skipto, starting) {
  level flag::set(starting);
  level thread function_4e6fcdc(starting);

  level.var_c2ccaeac = starting;
  level notify(#"hash_5dae2b0da59b0c78");
}

function private function_9b847391(skipto, starting, direct, player) {
  level flag::clear(player);
  level flag::set(player + "_completed");

  if(!isDefined(level.var_c55064fd[player])) {
    assertmsg("<dev string:x2b1>" + player);
  }

  waittillframeend();

  if(!is_true(level.var_60233e4f)) {
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

function function_30523221(var_d3440450) {
  var_5ed3cb1c = struct::get_script_bundle_instances("scene", array(var_d3440450, "script_objective"));

  foreach(s_scene in var_5ed3cb1c) {
    s_scene scene::stop();
    s_scene struct::delete();

    arrayremovevalue(level.scene_roots, s_scene);

    waitframe(1);
  }
}

function function_8ca86687(var_d3440450) {
  a_s_gameobjects = struct::get_array(var_d3440450, "script_objective");

  foreach(s_gameobject in a_s_gameobjects) {
    if(isDefined(s_gameobject.mdl_gameobject)) {
      s_gameobject gameobjects::destroy_object(1, 1);
    }
  }
}

function function_4e6fcdc(name) {
  var_b9d08f6 = undefined;
  var_349107cf = trigger::get_all();

  foreach(trigger in var_349107cf) {
    if(trigger.var_4c81bb34 === name) {
      if(!isDefined(var_b9d08f6)) {
        var_b9d08f6 = trigger;
      }

      var_b9d08f6 thread function_7a7bc9dc(trigger, name);
    }
  }
}

function function_8916f54(trigger) {
  foreach(player in getplayers()) {
    if(!player istouching(trigger)) {
      return false;
    }
  }

  return true;
}

function function_7a7bc9dc(trigger, name) {
  trigger endon(#"death");
  level endon(name + "_terminate");

  if(trigger.script_noteworthy === "allplayers") {
    do {
      waitresult = trigger waittill(#"trigger");
      player = waitresult.activator;
    }
    while(!function_8916f54(trigger));
  } else {
    waitresult = trigger waittill(#"trigger");
    player = waitresult.activator;

    if(trigger.script_noteworthy === "warpplayers") {
      foreach(other_player in level.players) {
        if(other_player != player) {
          other_player thread function_133d9d8c();
        }
      }
    }
  }

  level thread function_4e3ab877(name, 1, player);
}

function function_133d9d8c() {
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

function function_ff45bb89() {
  var_6c1cefb8 = struct::get_array("entity_objective_loc");

  foreach(mover in var_6c1cefb8) {
    if(!isDefined(mover.angles)) {
      mover.angles = (0, 0, 0);
    }

    if(isDefined(mover.script_objective) && isDefined(level.var_c55064fd[mover.script_objective])) {
      if(!isDefined(level.var_c55064fd[mover.script_objective].var_80fa98d9)) {
        level.var_c55064fd[mover.script_objective].var_80fa98d9 = [];
      } else if(!isarray(level.var_c55064fd[mover.script_objective].var_80fa98d9)) {
        level.var_c55064fd[mover.script_objective].var_80fa98d9 = array(level.var_c55064fd[mover.script_objective].var_80fa98d9);
      }

      level.var_c55064fd[mover.script_objective].var_80fa98d9[level.var_c55064fd[mover.script_objective].var_80fa98d9.size] = mover;
    }
  }

  for(;;) {
    waitresult = level waittill(#"objective_changed");
    function_da9b925(waitresult.objectives);
  }
}

function function_da9b925(objectives) {
  foreach(objective in objectives) {
    foreach(mover in level.var_c55064fd[objective].var_80fa98d9) {
      thread function_28af793c(mover);
    }
  }
}

function function_28af793c(mover) {
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
      if(!isDefined(target.var_c4572c87)) {
        target.var_c4572c87 = mover;
        target.var_6e36f61d = mover;
      } else {
        var_c4572c87 = target.var_6e36f61d;
      }

      if(!isDefined(var_c4572c87)) {
        var_c4572c87 = mover;
        speed = float(function_60d95f53()) / 1000;
        continue;
      }

      assert(var_c4572c87 == target.var_6e36f61d, "<dev string:x2cd>");
    }

    if(!isDefined(var_c4572c87) || var_c4572c87 == mover) {
      return;
    }

    script_mover = spawn("script_origin", var_c4572c87.origin);
    script_mover.angles = var_c4572c87.angles;

    foreach(target in targets) {
      target linkto(script_mover, "", script_mover worldtolocalcoords(target.origin), target.angles - script_mover.angles);
    }

    util::wait_network_frame();
    script_mover moveto(mover.origin, speed);
    script_mover rotateto(mover.angles, speed);
    script_mover waittill(#"movedone");

    foreach(target in targets) {
      target.var_6e36f61d = mover;
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

function function_f02f0c63() {
  level flag::set("final_level");
}

function function_3b424100() {
  return level flag::get("final_level");
}

function function_5533c39e(var_d3440450, var_5e819c0f = 1) {
  assert(isDefined(level.var_c55064fd[var_d3440450]), "<dev string:x307>" + var_d3440450);
  level.var_c55064fd[var_d3440450].var_a3d14b6b = var_5e819c0f;
}