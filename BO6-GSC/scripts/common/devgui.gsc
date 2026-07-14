/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\devgui.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace devgui;

function init_devgui() {
  if(!isDefined(level.devgui_cmd_funcs)) {
    level.devgui_cmd_funcs = [];
  }

  if(!isDefined(level.var_279e8c0ef2494a66)) {
    level.var_279e8c0ef2494a66 = [];
  }

  if(!isDefined(level.devgui_threads)) {
    level.devgui_threads = [];
  }

  level notify("<dev string:x24>");
  level thread monitor_devgui();
  setdevdvarifuninitialized(@ "hash_81d89e4abec64203", 0);
}

function add_debug_command_process() {
  while(level.var_3faf24edbc51cefd) {
    wait 0.1;
  }

  if(level.add_debug_command_process.size == 0) {
    return;
  }

  level.var_3faf24edbc51cefd = 1;

  if(!utility::issp()) {
    level utility::flag_wait("<dev string:x3c>");
  }

  if(getdvarint(@ "hash_a16da1867b1c0848", 0) == 1) {
    while(!isDefined(level.players.size) || level.players.size < getdvarint(@ "hash_6ad5a8e0d95c5aa4", 1)) {
      waitframe();
    }
  } else {
    while(!isDefined(level.player)) {
      waitframe();
    }
  }

  for(i = 0; i < level.add_debug_command_process.size; i++) {
    cmd = level.add_debug_command_process[i];
    cmd += "<dev string:x57>";

    while(!adddebugcommand(cmd)) {
      waitframe();
    }

    if(getdvarint(@ "hash_a16da1867b1c0848", 0) == 1 && utility::issharedfuncdefined(#"devgui", #"hash_4977958f159a16fc", 0) && utility::callsharedfunc(#"game", #"isdedicatedserver")) {
      foreach(player in level.players) {
        if(isDefined(player)) {
          while(!utility::callsharedfunc(#"devgui", #"hash_4977958f159a16fc", player, cmd)) {
            wait 1;

            if(!isDefined(player)) {
              break;
            }
          }
        }
      }

      if(i % 10 == 0) {
        waitframe();
      }
    }
  }

  level.var_3faf24edbc51cefd = undefined;
  level.add_debug_command_process = undefined;
}

function add_debug_command(cmd) {
  if(!isDefined(level.add_debug_command_process)) {
    level.add_debug_command_process = [];
  }

  level.add_debug_command_process[level.add_debug_command_process.size] = cmd;
  thread add_debug_command_process();
}

function add_devgui_command(path, cmd, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_900614a0226892b7));
    index = level.var_900614a0226892b7.index;
    level.var_900614a0226892b7.index++;
  }

  if(isDefined(level.var_900614a0226892b7) && isDefined(level.var_900614a0226892b7.base_path)) {
    path = level.var_900614a0226892b7.base_path + path;
  }

  thread add_debug_command("<dev string:x5c>" + path + "<dev string:x6c>" + index + "<dev string:x71>" + cmd + "<dev string:x78>");
}

function function_502a7d5e4d9dfa5b(path, name, func, toggle, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_900614a0226892b7));
    index = level.var_900614a0226892b7.index;
    level.var_900614a0226892b7.index++;
  }

  if(isDefined(level.var_900614a0226892b7) && isDefined(level.var_900614a0226892b7.base_path)) {
    path = level.var_900614a0226892b7.base_path + path;
  }

  name = utility::string_replace(name, "<dev string:x7e>", "<dev string:x83>", 100);
  thread add_debug_command("<dev string:x5c>" + path + "<dev string:x6c>" + index + "<dev string:x88>" + "<dev string:x95>" + "<dev string:x7e>" + name + "<dev string:x78>");
  level.devgui_cmd_funcs[name] = create_cmd(func, toggle);
}

function function_581b7f2e243b8ae4(path, dvar, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_900614a0226892b7));
    index = level.var_900614a0226892b7.index;
    level.var_900614a0226892b7.index++;
  }

  if(isDefined(level.var_900614a0226892b7) && isDefined(level.var_900614a0226892b7.base_path)) {
    path = level.var_900614a0226892b7.base_path + path;
  }

  thread add_debug_command("<dev string:xa7>" + path + "<dev string:x6c>" + index + "<dev string:xb8>" + dvar + "<dev string:x57>");
}

function function_eaac4ba4b3caf621(path, dvar_xhash, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_900614a0226892b7));
    index = level.var_900614a0226892b7.index;
    level.var_900614a0226892b7.index++;
  }

  if(isDefined(level.var_900614a0226892b7) && isDefined(level.var_900614a0226892b7.base_path)) {
    path = level.var_900614a0226892b7.base_path + path;
  }

  setdevdvarifuninitialized(dvar_xhash, 0);
  thread add_debug_command("<dev string:x5c>" + path + "<dev string:x6c>" + index + "<dev string:xbe>" + getxhashsourcename(dvar_xhash) + "<dev string:xcd>");
}

function function_cd4e263c1f3018ae(path, var_e11b81b22afc5869, func, toggle, index) {
  var_e11b81b22afc5869 = utility::string_replace(var_e11b81b22afc5869, "<dev string:x7e>", "<dev string:x83>", 100);
  params = strtok(var_e11b81b22afc5869, "<dev string:xd7>");
  name = params[0];
  params[0] = undefined;

  if(isint(0)) {
    function_cdc669dbc8ea2101(params);
  }

  if(!isDefined(index)) {
    assert(isDefined(level.var_900614a0226892b7));
    index = level.var_900614a0226892b7.index;
    level.var_900614a0226892b7.index++;
  }

  if(isDefined(level.var_900614a0226892b7) && isDefined(level.var_900614a0226892b7.base_path)) {
    path = level.var_900614a0226892b7.base_path + path;
  }

  thread add_debug_command("<dev string:x5c>" + path + "<dev string:x6c>" + index + "<dev string:x88>" + "<dev string:x95>" + "<dev string:x7e>" + var_e11b81b22afc5869 + "<dev string:x78>");
  level.var_279e8c0ef2494a66[name] = create_cmd(func, toggle);
}

function function_9082edeb5db93280(base_path) {
  assert(!isDefined(level.var_900614a0226892b7), "<dev string:xdc>");

  if(isDefined(level.var_900614a0226892b7)) {
    assertmsg("<dev string:x116>" + level.var_900614a0226892b7.base_path);
  }

  level.var_900614a0226892b7 = spawnStruct();
  level.var_900614a0226892b7.index = 0;
  level.var_900614a0226892b7.base_path = base_path;
}

function function_77df7fe7dd273e10() {
  assert(isDefined(level.var_900614a0226892b7));
  level.var_900614a0226892b7 = undefined;
}

function function_97024c0a6d1256a6() {
  player = level.players[0];
  player_forward = anglesToForward(player getplayerangles());
  result = trace::ray_trace(player getEye(), player getEye() + player_forward * 10000);

  if(isDefined(result["<dev string:x13f>"]) && isDefined(result["<dev string:x14b>"]) && result["<dev string:x14b>"] < 1) {
    new_pos = utility::drop_to_ground(result["<dev string:x13f>"] + -1 * player_forward * 32, 24, -300) + (0, 0, 16);
    return new_pos;
  }

  return undefined;
}

function function_847216deb449a506(params) {
  model = params[0];
  spawn_location = function_97024c0a6d1256a6();
  spawn_z_offset = getdvarfloat(@ "hash_2ae4e76b04454913", 0);
  spawned_object = spawn("<dev string:x157>", spawn_location + (0, 0, spawn_z_offset));
  spawned_object setModel(model);
}

function function_3f8a26ec96988e80(dvar, dvar_hash) {
  iprintlnbold("<dev string:x167>" + dvar + "<dev string:x172>" + !getdvarint(dvar_hash, 0));
  setDvar(dvar_hash, !getdvarint(dvar_hash, 0));
}

function function_d6e3d253db54504f(name) {
  return isDefined(self.devgui_threads) && isDefined(self) && isDefined(self.devgui_threads[name]);
}

function toggle_thread(name, func, params) {
  if(!isDefined(self.devgui_threads)) {
    self.devgui_threads = [];
  }

  if(function_d6e3d253db54504f(name)) {
    self.devgui_threads[name] notify("<dev string:x178>");
    self.devgui_threads[name] = undefined;
    return;
  }

  self.devgui_threads[name] = spawnStruct();
  self.devgui_threads[name] endon("<dev string:x178>");
  self.devgui_threads[name] endon("<dev string:x18f>");

  if(isDefined(params)) {
    [[func]](params);
  } else {
    [[func]]();
  }

  self.devgui_threads[name] = undefined;
}

function private monitor_devgui() {
  level endon("<dev string:x198>");
  level endon("<dev string:x24>");

  while(true) {
    waitframe();
    name = getDvar(@ "scr_devgui_cmd");

    if(name == "<dev string:x1a6>") {
      continue;
    }

    setDvar(@ "scr_devgui_cmd", "<dev string:x1a6>");

    if(isDefined(level.devgui_cmd_funcs[name])) {
      if(level.devgui_cmd_funcs[name].toggle) {
        level thread toggle_thread(name, level.devgui_cmd_funcs[name].func);
      } else {
        thread[[level.devgui_cmd_funcs[name].func]]();
      }

      continue;
    }

    tokens = strtok(name, "<dev string:xd7>");
    name = tokens[0];
    params = arraycopy(tokens);
    params[0] = undefined;

    if(isint(0)) {
      function_cdc669dbc8ea2101(params);
    }

    if(isDefined(level.var_279e8c0ef2494a66[name])) {
      if(level.var_279e8c0ef2494a66[name].toggle) {
        level thread toggle_thread(name, level.var_279e8c0ef2494a66[name].func, params);
        continue;
      }

      thread[[level.var_279e8c0ef2494a66[name].func]](params);
    }
  }
}

function private create_cmd(func, toggle) {
  cmd = spawnStruct();
  cmd.func = func;
  cmd.toggle = istrue(toggle);
  return cmd;
}

# /