/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\devgui.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace devgui;

function init_devgui() {
  if(!isDefined(level.var_7eea2b6a60c0f768)) {
    level.var_7eea2b6a60c0f768 = [];
  }

  if(!isDefined(level.var_a7a2b0c1756d86a3)) {
    level.var_a7a2b0c1756d86a3 = [];
  }

  if(!isDefined(level.devgui_threads)) {
    level.devgui_threads = [];
  }

  level notify("<dev string:x1c>");
  level thread monitor_devgui();
  setdevdvarifuninitialized(@ "hash_81d89e4abec64203", 0);
}

function function_de5696a0706893d4() {
  if(isDefined(level.var_3abeb9746c41d178)) {
    return;
  }

  if(level.var_de5696a0706893d4.size == 0) {
    return;
  }

  level.var_3abeb9746c41d178 = 1;

  if(!utility::issp()) {
    level scripts\engine\utility::flag_wait("<dev string:x31>");
  }

  while(!isDefined(level.player)) {
    waitframe();
  }

  for(i = 0; i < level.var_de5696a0706893d4.size; i++) {
    cmd = level.var_de5696a0706893d4[i];
    adddebugcommand(cmd + "<dev string:x49>");

    if(i % 5 == 0) {
      waitframe();
    }
  }

  level.var_3abeb9746c41d178 = undefined;
  level.var_de5696a0706893d4 = undefined;
}

function add_debug_command(cmd) {
  if(!isDefined(level.var_de5696a0706893d4)) {
    level.var_de5696a0706893d4 = [];
  }

  level.var_de5696a0706893d4[level.var_de5696a0706893d4.size] = cmd;
  thread function_de5696a0706893d4();
}

function add_devgui_command(path, cmd, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_d8852dd07270dbac));
    index = level.var_d8852dd07270dbac.index;
    level.var_d8852dd07270dbac.index++;
  }

  if(isDefined(level.var_d8852dd07270dbac) && isDefined(level.var_d8852dd07270dbac.base_path)) {
    path = level.var_d8852dd07270dbac.base_path + path;
  }

  thread add_debug_command("<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x5a>" + cmd + "<dev string:x5e>");
}

function function_a9a864379a098ad6(path, name, func, toggle, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_d8852dd07270dbac));
    index = level.var_d8852dd07270dbac.index;
    level.var_d8852dd07270dbac.index++;
  }

  if(isDefined(level.var_d8852dd07270dbac) && isDefined(level.var_d8852dd07270dbac.base_path)) {
    path = level.var_d8852dd07270dbac.base_path + path;
  }

  thread add_debug_command("<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x61>" + "<dev string:x69>" + "<dev string:x78>" + name + "<dev string:x5e>");
  level.var_7eea2b6a60c0f768[name] = create_cmd(func, toggle);
}

function function_df648211d66cd3dd(path, dvar, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_d8852dd07270dbac));
    index = level.var_d8852dd07270dbac.index;
    level.var_d8852dd07270dbac.index++;
  }

  if(isDefined(level.var_d8852dd07270dbac) && isDefined(level.var_d8852dd07270dbac.base_path)) {
    path = level.var_d8852dd07270dbac.base_path + path;
  }

  thread add_debug_command("<dev string:x7a>" + path + "<dev string:x58>" + index + "<dev string:x88>" + dvar + "<dev string:x49>");
}

function function_b2159fbbd7ac094e(path, dvar_xhash, index) {
  if(!isDefined(index)) {
    assert(isDefined(level.var_d8852dd07270dbac));
    index = level.var_d8852dd07270dbac.index;
    level.var_d8852dd07270dbac.index++;
  }

  if(isDefined(level.var_d8852dd07270dbac) && isDefined(level.var_d8852dd07270dbac.base_path)) {
    path = level.var_d8852dd07270dbac.base_path + path;
  }

  setdevdvarifuninitialized(dvar_xhash, 0);
  thread add_debug_command("<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x8b>" + getxhashsourcename(dvar_xhash) + "<dev string:x97>");
}

function function_b23a59dfb4ca49a1(path, var_9af94c1035c9530e, func, toggle, index) {
  tokens = strtok(var_9af94c1035c9530e, "<dev string:x9e>");
  name = tokens[0];
  params = scripts\engine\utility::array_remove_index(tokens, 0, 0);

  if(!isDefined(index)) {
    assert(isDefined(level.var_d8852dd07270dbac));
    index = level.var_d8852dd07270dbac.index;
    level.var_d8852dd07270dbac.index++;
  }

  if(isDefined(level.var_d8852dd07270dbac) && isDefined(level.var_d8852dd07270dbac.base_path)) {
    path = level.var_d8852dd07270dbac.base_path + path;
  }

  thread add_debug_command("<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x61>" + "<dev string:x69>" + "<dev string:x78>" + var_9af94c1035c9530e + "<dev string:x5e>");
  level.var_a7a2b0c1756d86a3[name] = create_cmd(func, toggle);
}

function function_6e7290c8ee4f558b(base_path) {
  assertex(!isDefined(level.var_d8852dd07270dbac), "<dev string:xa0>");

  if(isDefined(level.var_d8852dd07270dbac)) {
    assertmsg("<dev string:xd7>" + level.var_d8852dd07270dbac.base_path);
  }

  level.var_d8852dd07270dbac = spawnStruct();
  level.var_d8852dd07270dbac.index = 0;
  level.var_d8852dd07270dbac.base_path = base_path;
}

function function_fe953f000498048f() {
  assert(isDefined(level.var_d8852dd07270dbac));
  level.var_d8852dd07270dbac = undefined;
}

function function_9b4c82dba041b23d() {
  player = level.players[0];
  player_forward = anglesToForward(player getplayerangles());
  result = scripts\engine\trace::ray_trace(player getEye(), player getEye() + player_forward * 10000);

  if(isDefined(result["<dev string:xfd>"]) && isDefined(result["<dev string:x106>"]) && result["<dev string:x106>"] < 1) {
    new_pos = drop_to_ground(result["<dev string:xfd>"] + -1 * player_forward * 32, 24, -300) + (0, 0, 16);
    return new_pos;
  }

  return undefined;
}

function function_5ee398aaf3f11e0d(params) {
  model = params[0];
  spawn_location = function_9b4c82dba041b23d();
  var_3f04053a805fbbc5 = getdvarfloat(@ "hash_2ae4e76b04454913", 0);
  spawned_object = spawn("<dev string:x10f>", spawn_location + (0, 0, var_3f04053a805fbbc5));
  spawned_object setModel(model);
}

function function_2fb888667001fc39(dvar, dvar_hash) {
  iprintlnbold("<dev string:x11c>" + dvar + "<dev string:x124>" + !getdvarint(dvar_hash, 0));
  setDvar(dvar_hash, !getdvarint(dvar_hash, 0));
}

function function_7ac3c4c1bce16dd2(name) {
  return isDefined(self) && isDefined(self.devgui_threads) && isDefined(self.devgui_threads[name]);
}

function toggle_thread(name, func, params) {
  if(!isDefined(self.devgui_threads)) {
    self.devgui_threads = [];
  }

  if(function_7ac3c4c1bce16dd2(name)) {
    self.devgui_threads[name] notify("<dev string:x127>");
    self.devgui_threads[name] = undefined;
    return;
  }

  self.devgui_threads[name] = spawnStruct();
  self.devgui_threads[name] endon("<dev string:x127>");
  self.devgui_threads[name] endon("<dev string:x13b>");

  if(isDefined(params)) {
    [[func]](params);
  } else {
    [[func]]();
  }

  self.devgui_threads[name] = undefined;
}

function private monitor_devgui() {
  level endon("<dev string:x141>");
  level endon("<dev string:x1c>");

  while(true) {
    waitframe();
    name = getDvar(@ "hash_f8ef099ef036c45e");

    if(name == "<dev string:x14c>") {
      continue;
    }

    setDvar(@ "hash_f8ef099ef036c45e", "<dev string:x14c>");

    if(isDefined(level.var_7eea2b6a60c0f768[name])) {
      if(level.var_7eea2b6a60c0f768[name].toggle) {
        level thread toggle_thread(name, level.var_7eea2b6a60c0f768[name].func);
      } else {
        [[level.var_7eea2b6a60c0f768[name].func]]();
      }

      continue;
    }

    tokens = strtok(name, "<dev string:x9e>");
    name = tokens[0];
    params = scripts\engine\utility::array_remove_index(tokens, 0, 0);

    if(isDefined(level.var_a7a2b0c1756d86a3[name])) {
      if(level.var_a7a2b0c1756d86a3[name].toggle) {
        level thread toggle_thread(name, level.var_a7a2b0c1756d86a3[name].func, params);
        continue;
      }

      [[level.var_a7a2b0c1756d86a3[name].func]](params);
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