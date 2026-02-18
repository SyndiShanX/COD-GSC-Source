/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\scene_debug_shared.gsc
***********************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace scene;

function private autoexec __init__system__() {
  system::register(#"scene_debug", &function_c3c9d0e5, undefined, undefined, undefined);
}

function function_c3c9d0e5() {
  if(getdvarstring(#"scene_menu_mode", "<dev string:x38>") == "<dev string:x38>") {
    setDvar(#"scene_menu_mode", "<dev string:x3c>");
  }

  if(!isDefined(level.scene_roots)) {
    level.scene_roots = [];
  }

  setDvar(#"run_client_scene", "<dev string:x38>");
  setDvar(#"init_client_scene", "<dev string:x38>");
  setDvar(#"stop_client_scene", "<dev string:x38>");
  setDvar(#"hash_62cdb8fd35a5a4c3", 0);
  level thread run_scene_tests();
  level thread toggle_scene_menu();
  level thread toggle_postfx_igc_loop();
  level thread debug_display_all();
  level thread function_42edf155();
}

function run_scene_tests() {
  level endon(#"run_scene_tests");
  var_cdb63291 = 0;

  while(true) {
    str_run_scene = getdvarstring(#"run_scene");
    a_toks = strtok(str_run_scene, "<dev string:x47>");
    str_scene = a_toks[0];
    str_shot = a_toks[1];
    str_mode = tolower(getdvarstring(#"scene_menu_mode", "<dev string:x3c>"));

    if(str_mode == "<dev string:x3c>" && isDefined(a_toks[2])) {
      str_mode = a_toks[2];
    }

    if(!isDefined(str_scene)) {
      str_scene = "<dev string:x38>";
    }

    str_client_scene = getdvarstring(#"run_client_scene");
    b_capture = 0;

    if(b_capture) {
      if(str_scene != "<dev string:x38>") {
        setDvar(#"init_scene", str_scene);
        setDvar(#"run_scene", "<dev string:x38>");
      }
    } else {
      if(str_client_scene != "<dev string:x38>") {
        level util::clientnotify(str_client_scene + "<dev string:x4c>");
        util::wait_network_frame();
      }

      if(str_scene != "<dev string:x38>") {
        setDvar(#"run_scene", "<dev string:x38>");
        b_series = str_mode == "<dev string:x58>";

        if(str_mode == "<dev string:x6a>" || str_mode == "<dev string:x58>") {
          str_mode += "<dev string:x7c>" + getdvarstring(#"hash_3018c0b9207d1c", "<dev string:x87>");
          str_mode += "<dev string:x8c>" + getdvarstring(#"hash_51617678bebb961a", "<dev string:x95>");
          str_mode += "<dev string:x9b>" + getdvarstring(#"hash_4bf15ae7a6fbf73c", "<dev string:xa4>");
          str_mode += "<dev string:xab>" + getdvarstring(#"hash_7b946c8966b56a8e", "<dev string:x87>");
        }

        level thread test_play(str_scene, str_shot, str_mode);
      }
    }

    str_scene = getdvarstring(#"init_scene");
    str_client_scene = getdvarstring(#"init_client_scene");

    if(str_client_scene != "<dev string:x38>") {
      level util::clientnotify(str_client_scene + "<dev string:xb5>");
      util::wait_network_frame();
    }

    if(str_scene != "<dev string:x38>") {
      setDvar(#"init_scene", "<dev string:x38>");
      level thread test_play(str_scene, undefined, "<dev string:xc1>");

      if(b_capture) {
        capture_scene(str_scene, str_mode);
      }
    }

    str_scene = getdvarstring(#"stop_scene");
    str_client_scene = getdvarstring(#"stop_client_scene");

    if(str_client_scene != "<dev string:x38>") {
      level util::clientnotify(str_client_scene + "<dev string:xc9>");
      util::wait_network_frame();
    }

    if(str_scene != "<dev string:x38>") {
      setDvar(#"stop_scene", "<dev string:x38>");
      function_d2785094(level.var_a572f325);
      level stop(str_scene);
    }

    str_scene = getdvarstring(#"clear_scene");

    if(str_scene != "<dev string:x38>") {
      setDvar(#"clear_scene", "<dev string:x38>");
      function_d2785094(level.var_a572f325);
      level stop(str_scene);
      level delete_scene_spawned_ents(str_scene);
    }

    if(var_cdb63291 != getdvarint(#"hash_62cdb8fd35a5a4c3", 0)) {
      var_cdb63291 = getdvarint(#"hash_62cdb8fd35a5a4c3", 0);

      if(var_cdb63291 == 1) {
        adddebugcommand("<dev string:xd5>");
      } else {
        adddebugcommand("<dev string:x10b>");
      }
    }

    waitframe(1);
  }
}

function capture_scene(str_scene, str_mode) {
  setDvar(#"scene_menu", 0);
  level play(str_scene, undefined, undefined, 1, str_mode);
}

function toggle_scene_menu() {
  setDvar(#"scene_menu", 0);
  n_scene_menu_last = -1;

  while(true) {
    n_scene_menu = getdvarstring(#"scene_menu");

    if(n_scene_menu != "<dev string:x38>") {
      n_scene_menu = int(n_scene_menu);

      if(n_scene_menu != n_scene_menu_last) {
        switch (n_scene_menu) {
          case 1:
            level thread display_scene_menu("<dev string:x12b>");
            break;
          case 2:
            level thread display_scene_menu("<dev string:x134>");
            break;
          default:
            function_1f93be7b();
            level flag::clear(#"menu_open");
            level flag::clear(#"menu_open");
            level flag::clear(#"hash_4035a6aa4a6ba08d");
            level flag::clear(#"hash_7b50fddf7a4b9e2e");
            level flag::clear(#"hash_5bcd66a9c21f5b2d");
            level notify(#"scene_menu_cleanup");
            setDvar(#"bgcache_disablewarninghints", 0);
            setDvar(#"cl_tacticalhud", 1);
            break;
        }

        n_scene_menu_last = n_scene_menu;
      }
    }

    waitframe(1);
  }
}

function function_8ee42bf(o_scene) {
  if(isDefined(o_scene) && isDefined(o_scene._s)) {
    str_type = isDefined(o_scene._s.scenetype) ? o_scene._s.scenetype : "<dev string:x12b>";

    if(level flag::get(str_type + "<dev string:x13e>") && level flag::get(#"hash_5bcd66a9c21f5b2d")) {
      level thread display_scene_menu(o_scene._s.scenetype);
    }
  }
}

function function_70042fe2(str_scene) {
  if(!level flag::get("<dev string:x153>")) {
    level flag::set("<dev string:x153>");
    level.var_a97df3b7 = str_scene;
    function_27f5972e(str_scene);
  }
}

function function_1f93be7b() {
  if(level flag::get("<dev string:x153>") && isDefined(level.var_a97df3b7)) {
    level flag::clear("<dev string:x153>");
    function_f81475ae(level.var_a97df3b7);
    level.var_a97df3b7 = undefined;
  }
}

function display_scene_menu(str_type, str_scene) {
  if(!isDefined(str_type)) {
    str_type = "<dev string:x12b>";
  }

  level flag::clear(#"hash_4035a6aa4a6ba08d");
  level flag::clear(#"hash_7b50fddf7a4b9e2e");
  level notify(#"scene_menu_cleanup");
  level endon(#"scene_menu_cleanup");
  waittillframeend();
  level flag::set(#"menu_open");
  setDvar(#"bgcache_disablewarninghints", 1);
  setDvar(#"cl_tacticalhud", 0);
  names = [];
  b_shot_menu = 0;

  if(isstring(str_scene)) {
    names[names.size] = "<dev string:x16e>";
    names[names.size] = "<dev string:x176>";
    names[names.size] = "<dev string:x38>";
    names = arraycombine(names, get_all_shot_names(str_scene), 1, 0);
    names[names.size] = "<dev string:x38>";
    names[names.size] = "<dev string:x17e>";
    names[names.size] = "<dev string:x186>";
    names[names.size] = "<dev string:x38>";
    names[names.size] = "<dev string:x18f>";
    str_title = str_scene;
    b_shot_menu = 1;
    selected = isDefined(level.scene_menu_shot_index) ? level.scene_menu_shot_index : 0;
  } else {
    level flag::set(str_type + "<dev string:x13e>");

    if(level flag::get(#"hash_5bcd66a9c21f5b2d")) {
      println("<dev string:x197>" + toupper(str_type) + "<dev string:x1ac>");
    }

    var_72acc069 = 1;

    foreach(str_scenedef in level.scenedefs) {
      s_scenedef = getscriptbundle(str_scenedef);

      if(s_scenedef.vmtype !== "<dev string:x1be>" && s_scenedef.scenetype === str_type) {
        if(level flag::get(#"hash_5bcd66a9c21f5b2d")) {
          if(is_scene_active(s_scenedef.name) && function_c0f30783(s_scenedef)) {
            array::add_sorted(names, s_scenedef.name, 0);
            println("<dev string:x197>" + toupper(str_type) + "<dev string:x1c8>" + var_72acc069 + "<dev string:x1cd>" + s_scenedef.name);
            var_72acc069++;
          }

          continue;
        }

        if(function_c0f30783(s_scenedef)) {
          array::add_sorted(names, s_scenedef.name, 0);
        }
      }
    }

    if(level flag::get(#"hash_5bcd66a9c21f5b2d")) {
      println("<dev string:x197>" + toupper(str_type) + "<dev string:x1d7>");
    }

    foreach(str_scene_name in names) {
      str_prefix = getsubstr(str_scene_name, 0, 4);

      if(str_prefix == "<dev string:x1e7>") {
        arrayremovevalue(names, str_scene_name);
        array::push_front(names, str_scene_name);
      }
    }

    names[names.size] = "<dev string:x38>";
    names[names.size] = "<dev string:x1ef>";
    array::push_front(names, "<dev string:x38>");
    array::push_front(names, "<dev string:x1f7>");
    str_title = str_type + "<dev string:x219>";
    selected = isDefined(level.scene_menu_index) ? level.scene_menu_index : 0;
  }

  if(selected > names.size - 1) {
    selected = 0;
  }

  if(!b_shot_menu && !level flag::get(#"scene_menu_disable")) {
    debug2dtext((150, 410 + 400, 0), "<dev string:x21e>", (1, 1, 1), 1, (0, 0, 0), 1, 2);
  }

  up_pressed = 0;
  down_pressed = 0;
  held = 0;
  old_selected = selected;

  while(true) {
    if(!isDefined(level.host)) {
      waitframe(1);
      continue;
    }

    if(b_shot_menu) {
      if(isDefined(level.last_scene_state) && isDefined(level.last_scene_state[str_scene])) {
        str_title = str_scene + "<dev string:x243>" + level.last_scene_state[str_scene] + "<dev string:x249>";
      } else {
        str_title = str_scene;
      }

      function_70042fe2(str_scene);
    } else {
      function_1f93be7b();
    }

    if(held) {
      scene_list_settext(names, selected, str_title, b_shot_menu, 10);
      wait 0.5;
    } else {
      scene_list_settext(names, selected, str_title, b_shot_menu, 1);
    }

    if(!up_pressed) {
      if(level.host util::up_button_pressed()) {
        up_pressed = 1;
        selected--;

        if(names[selected] === "<dev string:x38>") {
          selected--;
        }
      }
    } else if(level.host util::up_button_held()) {
      held = 1;
      selected -= 10;
    } else if(!level.host util::up_button_pressed()) {
      held = 0;
      up_pressed = 0;
    }

    if(!down_pressed) {
      if(level.host util::down_button_pressed()) {
        down_pressed = 1;
        selected++;

        if(names[selected] === "<dev string:x38>") {
          selected++;
        }
      }
    } else if(level.host util::down_button_held()) {
      held = 1;
      selected += 10;
    } else if(!level.host util::down_button_pressed()) {
      held = 0;
      down_pressed = 0;
    }

    if(!down_pressed && !up_pressed) {
      if(names[selected] === "<dev string:x38>") {
        selected++;
      }
    }

    if(held) {
      if(selected < 0) {
        selected = 0;
      } else if(selected >= names.size) {
        selected = names.size - 1;
      }
    } else if(selected < 0) {
      selected = names.size - 1;
    } else if(selected >= names.size) {
      selected = 0;
    }

    if(level.host buttonPressed("<dev string:x24e>")) {
      if(b_shot_menu) {
        while(level.host buttonPressed("<dev string:x24e>")) {
          waitframe(1);
        }

        level.scene_menu_shot_index = selected;
        level thread display_scene_menu(str_type);
      } else {
        level.scene_menu_index = selected;
        setDvar(#"scene_menu", 0);
      }
    }

    if(names[selected] != "<dev string:x1ef>" && !b_shot_menu) {
      if(level.host buttonPressed("<dev string:x25a>") || level.host buttonPressed("<dev string:x268>")) {
        level.host move_to_scene(names[selected]);

        while(level.host buttonPressed("<dev string:x25a>") || level.host buttonPressed("<dev string:x268>")) {
          waitframe(1);
        }
      } else if(level.host buttonPressed("<dev string:x276>") || level.host buttonPressed("<dev string:x283>")) {
        level.host move_to_scene(names[selected], 1);

        while(level.host buttonPressed("<dev string:x276>") || level.host buttonPressed("<dev string:x283>")) {
          waitframe(1);
        }
      }
    }

    if(b_shot_menu && function_940c526f() && isDefined(str_scene) && function_9730988a(str_scene, names[selected])) {
      setDvar(#"run_scene", str_scene + "<dev string:x47>" + names[selected] + "<dev string:x47>" + "<dev string:x290>");
    } else if(function_606f1f21()) {
      if(names[selected] == "<dev string:x1f7>") {
        level flag::toggle("<dev string:x2a2>");

        while(function_606f1f21()) {
          waitframe(1);
        }

        level thread display_scene_menu(str_type);
      } else if(names[selected] == "<dev string:x1ef>") {
        setDvar(#"scene_menu", 0);
      } else if(b_shot_menu) {
        if(names[selected] == "<dev string:x18f>") {
          level.scene_menu_shot_index = selected;

          while(function_606f1f21()) {
            waitframe(1);
          }

          level thread display_scene_menu(str_type);
        } else if(names[selected] == "<dev string:x17e>") {
          setDvar(#"stop_scene", str_scene);
        } else if(names[selected] == "<dev string:x186>") {
          setDvar(#"clear_scene", str_scene);
        } else if(names[selected] == "<dev string:x16e>") {
          setDvar(#"init_scene", str_scene);
        } else if(names[selected] == "<dev string:x176>") {
          setDvar(#"run_scene", str_scene);
        } else {
          setDvar(#"run_scene", str_scene + "<dev string:x47>" + names[selected]);
        }
      }

      while(function_606f1f21() || function_940c526f()) {
        waitframe(1);
      }

      if(!b_shot_menu && isDefined(names[selected]) && names[selected] != "<dev string:x38>") {
        level.scene_menu_index = selected;
        level thread display_scene_menu(str_type, names[selected]);
      }
    }

    waitframe(1);
  }
}

function function_c0f30783(s_scenedef) {
  if(!is_true(s_scenedef.var_241c5f3c) || is_true(s_scenedef.var_241c5f3c) && getdvarint(#"zm_debug_ee", 0)) {
    return 1;
  }

  return 0;
}

function function_606f1f21() {
  if(level.host buttonPressed("<dev string:x2bc>") || level.host buttonPressed("<dev string:x2c8>") || level.host buttonPressed("<dev string:x2d4>")) {
    return 1;
  }

  return 0;
}

function function_940c526f() {
  if(level.host buttonPressed("<dev string:x2dd>")) {
    return 1;
  }

  return 0;
}

function scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_444abf97) {
  if(!level flag::get(#"scene_menu_disable")) {
    thread _scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_444abf97);
  }
}

function private _scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_444abf97) {
  if(!isDefined(b_shot_menu)) {
    b_shot_menu = 0;
  }

  if(!isDefined(var_444abf97)) {
    var_444abf97 = 1;
  }

  debug2dtext((150, 325, 0), str_title, (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
  str_mode = tolower(getdvarstring(#"scene_menu_mode", "<dev string:x3c>"));

  switch (str_mode) {
    case # "default":
      debug2dtext((150, 362.5, 0), "<dev string:x2e9>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
    case # "loop":
      debug2dtext((150, 362.5, 0), "<dev string:x2fa>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
    case # "capture_single":
      debug2dtext((150, 362.5, 0), "<dev string:x308>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
    case # "capture_series":
      debug2dtext((150, 362.5, 0), "<dev string:x326>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
  }

  for(i = 0; i < 16; i++) {
    index = i + n_selected - 5;

    if(isDefined(strings[index])) {
      text = strings[index];
    } else {
      text = "<dev string:x38>";
    }

    str_scene = text;

    if(isDefined(level.last_scene_state) && isDefined(level.last_scene_state[text])) {
      text += "<dev string:x243>" + level.last_scene_state[text] + "<dev string:x249>";
    }

    if(i == 5) {
      text = "<dev string:x33d>" + text + "<dev string:x343>";
      str_color = (0.8, 0.4, 0);
    } else if(is_scene_active(str_scene)) {
      str_color = (0, 1, 0);
    } else {
      str_color = (1, 1, 1);
    }

    debug2dtext((136, 400 + i * 25, 0), text, str_color, 1, (0, 0, 0), 1, 1, var_444abf97);
  }

  if(b_shot_menu) {
    debug2dtext((150, 410 + 400, 0), "<dev string:x348>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
    return;
  }

  debug2dtext((150, 410 + 400, 0), "<dev string:x21e>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
}

function is_scene_active(str_scene) {
  if(str_scene != "<dev string:x38>" && str_scene != "<dev string:x1ef>") {
    if(level is_active(str_scene)) {
      return 1;
    }
  }

  return 0;
}

function function_3bafd088(var_a572f325) {
  if(getdvarint(#"dvr_enable", 0) > 0 && getdvarint(#"scr_scene_dvr", 0) > 0) {
    if(!isDefined(var_a572f325)) {
      var_a572f325 = spawnStruct();
    }

    var_a572f325.drawbig = getdvarint(#"hash_13d62f4d290ef671", 0);
    var_a572f325.var_2640d68e = getdvarint(#"scr_show_shot_info_for_igcs", 0);
    var_a572f325.drawfps = getdvarint(#"cg_drawfps", 1);
    level.var_a572f325 = var_a572f325;
    setDvar(#"hash_13d62f4d290ef671", 1);
    setDvar(#"scr_show_shot_info_for_igcs", 1);
    setDvar(#"cg_drawfps", 0);
    adddebugcommand("<dev string:x38f>");
    wait 1;
  }
}

function function_d2785094(var_a572f325) {
  if(getdvarint(#"dvr_enable", 0) > 0 && getdvarint(#"scr_scene_dvr", 0) > 0) {
    drawbig = 0;
    var_2640d68e = 0;
    drawfps = 1;

    if(isDefined(var_a572f325)) {
      if(isDefined(var_a572f325.drawbig)) {
        drawbig = var_a572f325.drawbig;
      }

      if(isDefined(var_a572f325.var_2640d68e)) {
        var_2640d68e = var_a572f325.var_2640d68e;
      }

      if(isDefined(var_a572f325.drawfps)) {
        drawfps = var_a572f325.drawfps;
      }
    }

    setDvar(#"hash_13d62f4d290ef671", drawbig);
    setDvar(#"scr_show_shot_info_for_igcs", var_2640d68e);
    setDvar(#"cg_drawfps", drawfps);
    adddebugcommand("<dev string:x39e>");
  }
}

function test_play(arg1, arg2, str_mode) {
  n_skipto = getdvarfloat(#"scr_scene_skipto_time", 0);

  if(n_skipto > 0) {
    str_mode += "<dev string:x3ab>" + n_skipto;
  }

  var_a572f325 = spawnStruct();
  var_a572f325.name = arg1;

  if(!isDefined(var_a572f325.name)) {
    var_a572f325.name = self.scriptbundlename;
  }

  if(!isDefined(var_a572f325.name)) {
    var_a572f325.name = "<dev string:x3c>";
  }

  function_3bafd088(var_a572f325);
  play(arg1, arg2, undefined, 1, str_mode);
  function_d2785094(var_a572f325);
}

function debug_display_all() {
  while(true) {
    level flag::wait_till("<dev string:x3b7>");
    debug_frames = randomintrange(5, 10);
    debug_time = debug_frames / 20;

    if(isDefined(level.scene_roots)) {
      arrayremovevalue(level.scene_roots, undefined);

      foreach(scene in level.scene_roots) {
        scene debug_display(debug_frames);
      }
    }

    wait debug_time;
  }
}

function debug_display(debug_frames) {
  sphere(debug_display_origin(), 1, (1, 1, 0), 1, 1, 8, debug_frames);
  i = 0;

  if(self == level) {
    b_found = 0;

    if(isDefined(self.scene_ents)) {
      foreach(k, scene in self.scene_ents) {
        if(isarray(scene)) {
          foreach(ent in scene) {
            if(isDefined(ent)) {
              b_found = 1;
              print_scene_debug(debug_frames, i, k, self.last_scene_state_instance[k]);
              i++;
              break;
            }
          }
        }
      }
    }

    if(!b_found) {
      return;
    }

    return;
  }

  if(isDefined(self.last_scene_state_instance)) {
    foreach(str_scene, str_state in self.last_scene_state_instance) {
      print_scene_debug(debug_frames, i, str_scene, str_state);
      i++;
    }

    return;
  }

  if(isDefined(self.scriptbundlename)) {
    if(ishash(self.scriptbundlename)) {
      str_scene = function_9e72a96(self.scriptbundlename);
    } else {
      str_scene = self.scriptbundlename;
    }

    n_offset = 15;
    print3d(debug_display_origin() - (0, 0, n_offset), str_scene, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
  }
}

function print_scene_debug(debug_frames, i, str_scene, str_state) {
  v_origin = debug_display_origin();
  n_offset = 15 * (i + 1);
  str_scene = function_9e72a96(str_scene);
  print3d(v_origin - (0, 0, n_offset), str_scene, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
  print3d(v_origin - (0, 0, n_offset + 5), "<dev string:x3c5>" + str_state + "<dev string:x3ca>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
}

function debug_display_origin() {
  if(self == level) {
    return (0, 0, 0);
  }

  return self.origin;
}

function move_to_scene(str_scene, b_reverse_dir) {
  if(!isDefined(b_reverse_dir)) {
    b_reverse_dir = 0;
  }

  if(level.debug_current_scene_name !== str_scene) {
    level.debug_current_scene_instances = struct::get_array(str_scene, "<dev string:x3cf>");
    level.debug_current_scene_index = 0;
    level.debug_current_scene_name = str_scene;
  } else if(b_reverse_dir) {
    level.debug_current_scene_index--;

    if(level.debug_current_scene_index == -1) {
      level.debug_current_scene_index = level.debug_current_scene_instances.size - 1;
    }
  } else {
    level.debug_current_scene_index++;

    if(level.debug_current_scene_index == level.debug_current_scene_instances.size) {
      level.debug_current_scene_index = 0;
    }
  }

  if(level.debug_current_scene_instances.size == 0) {
    s_bundle = getscriptbundle(str_scene);

    if(!isDefined(s_bundle)) {
      error_on_screen("<dev string:x3e3>" + str_scene);
    } else if(isDefined(s_bundle.aligntarget)) {
      e_align = get_existing_ent(s_bundle.aligntarget, 0, 1);

      if(isDefined(e_align)) {
        level.host set_origin(e_align.origin);
      } else {
        error_on_screen("<dev string:x40a>");
      }
    } else {
      error_on_screen("<dev string:x43d>");
    }

    return;
  }

  s_scene = level.debug_current_scene_instances[level.debug_current_scene_index];
  level.host set_origin(s_scene.origin);
}

function set_origin(v_origin) {
  if(!self isinmovemode("<dev string:x46f>", "<dev string:x476>")) {
    adddebugcommand("<dev string:x476>");
  }

  self setorigin(v_origin);
}

function toggle_postfx_igc_loop() {
  while(true) {
    if(getdvarint(#"scr_postfx_igc_loop", 0)) {
      array::run_all(function_a1ef346b(), &clientfield::increment_to_player, "<dev string:x480>", 1);
      wait 4;
    }

    wait 1;
  }
}

function function_42edf155() {
  while(true) {
    requestflag = getdvarint(#"hash_1c68b689a2dac0fa", 0);

    if(requestflag != 0) {
      position_x = 0;
      position_y = 0;
      position_z = 0;
      angle_x = 0;
      angle_y = 0;
      angle_z = 0;
      align_target = getdvarstring(#"hash_442538f50d245600");
      align_tag = getdvarstring(#"hash_2004f1dddc83a63b");
      s = get_existing_ent(align_target, 0, 1);

      if(isDefined(s)) {
        if(align_tag != "<dev string:x38>") {
          s = animation::_get_align_pos(s, align_tag);
        }

        position_x = s.origin[0];
        position_y = s.origin[1];
        position_z = s.origin[2];
        angle_x = s.angles[0];
        angle_y = s.angles[1];
        angle_z = s.angles[2];
      }

      setDvar(#"hash_6c03d4e558bf8abd", position_x);
      setDvar(#"hash_6c03d3e558bf890a", position_y);
      setDvar(#"hash_6c03d2e558bf8757", position_z);
      setDvar(#"hash_277ac0be2726df0f", angle_x);
      setDvar(#"hash_277abfbe2726dd5c", angle_y);
      setDvar(#"hash_277ac2be2726e275", angle_z);
      setDvar(#"hash_1c68b689a2dac0fa", 0);
    }

    waitframe(1);
  }
}