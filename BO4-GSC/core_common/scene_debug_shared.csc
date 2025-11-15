/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\scene_debug_shared.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace scene;

autoexec __init__system__() {
  system::register(#"scene_debug", &function_c3c9d0e5, undefined, undefined);
}

function_c3c9d0e5() {
  if(getdvarstring(#"scene_menu_mode", "<dev string:x38>") == "<dev string:x38>") {
    setdvar(#"scene_menu_mode", "<dev string:x3b>");
  }

  level thread run_scene_tests();
  level thread toggle_scene_menu();
}

run_scene_tests() {
  level endon(#"run_scene_tests");
  level.scene_test_struct = spawnStruct();
  level.scene_test_struct.origin = (0, 0, 0);
  level.scene_test_struct.angles = (0, 0, 0);

  while(true) {
    str_scene = getdvarstring(#"run_client_scene");
    str_mode = tolower(getdvarstring(#"scene_menu_mode", "<dev string:x3b>"));
    a_toks = strtok(str_scene, "<dev string:x45>");
    str_scene = a_toks[0];
    str_shot = a_toks[1];

    if(!isDefined(str_scene)) {
      str_scene = "<dev string:x38>";
    }

    if(str_scene != "<dev string:x38>") {
      setdvar(#"run_client_scene", "<dev string:x38>");
      clear_old_ents(str_scene);
      b_found = 0;
      a_scenes = struct::get_array(str_scene, "<dev string:x49>");

      foreach(s_instance in a_scenes) {
        if(isDefined(s_instance)) {
          b_found = 1;
          s_instance thread test_play(undefined, str_shot, str_mode);
        }
      }

      if(isDefined(level.active_scenes[str_scene])) {
        foreach(s_instance in level.active_scenes[str_scene]) {
          if(!isinarray(a_scenes, s_instance)) {
            b_found = 1;
            s_instance thread test_play(str_scene, str_shot, str_mode);
          }
        }
      }

      if(!b_found) {
        level.scene_test_struct thread test_play(str_scene, str_shot, str_mode);
      }
    }

    str_scene = getdvarstring(#"init_client_scene");

    if(str_scene != "<dev string:x38>") {
      setdvar(#"init_client_scene", "<dev string:x38>");
      clear_old_ents(str_scene);
      b_found = 0;
      a_scenes = struct::get_array(str_scene, "<dev string:x49>");

      foreach(s_instance in a_scenes) {
        if(isDefined(s_instance)) {
          b_found = 1;
          s_instance thread test_init();
        }
      }

      if(!b_found) {
        level.scene_test_struct thread test_init(str_scene);
      }
    }

    str_scene = getdvarstring(#"stop_client_scene");

    if(str_scene != "<dev string:x38>") {
      setdvar(#"stop_client_scene", "<dev string:x38>");
      function_d2785094(level.var_a572f325);
      level stop(str_scene, 1);
    }

    waitframe(1);
  }
}

clear_old_ents(str_scene) {
  foreach(ent in getEntArray(0)) {
    if(ent.scene_spawned === str_scene && ent.finished_scene === str_scene) {
      ent delete();
    }
  }
}

toggle_scene_menu() {
  setdvar(#"client_scene_menu", 0);
  n_scene_menu_last = -1;

  while(true) {
    n_scene_menu = getdvarstring(#"client_scene_menu");

    if(n_scene_menu != "<dev string:x38>") {
      n_scene_menu = int(n_scene_menu);

      if(n_scene_menu != n_scene_menu_last) {
        switch (n_scene_menu) {
          case 1:
            level thread display_scene_menu("<dev string:x5c>");
            break;
          case 2:
            level thread display_scene_menu("<dev string:x64>");
            break;
          default:
            level flagsys::clear(#"menu_open");
            level flagsys::clear(#"hash_4035a6aa4a6ba08d");
            level flagsys::clear(#"hash_7b50fddf7a4b9e2e");
            level flagsys::clear(#"hash_5bcd66a9c21f5b2d");
            level notify(#"scene_menu_cleanup");
            setdvar(#"cl_tacticalhud", 1);
            break;
        }

        n_scene_menu_last = n_scene_menu;
      }
    }

    waitframe(1);
  }
}

function_8ee42bf(o_scene) {
  if(isDefined(o_scene) && isDefined(o_scene._s)) {
    str_type = isDefined(o_scene._s.scenetype) ? o_scene._s.scenetype : "<dev string:x5c>";

    if(level flagsys::get(str_type + "<dev string:x6d>") && level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
      level thread display_scene_menu(o_scene._s.scenetype);
    }
  }
}

display_scene_menu(str_type, str_scene) {
  if(!isDefined(str_type)) {
    str_type = "<dev string:x5c>";
  }

  level flagsys::clear(#"hash_4035a6aa4a6ba08d");
  level flagsys::clear(#"hash_7b50fddf7a4b9e2e");
  level notify(#"scene_menu_cleanup");
  level endon(#"scene_menu_cleanup");
  waittillframeend();
  level flagsys::set(#"menu_open");
  setdvar(#"cl_tacticalhud", 0);
  b_shot_menu = 0;
  a_scenedefs = get_scenedefs(str_type);

  if(str_type == "<dev string:x5c>") {
    a_scenedefs = arraycombine(a_scenedefs, get_scenedefs("<dev string:x81>"), 0, 1);
  }

  names = [];

  if(isstring(str_scene)) {
    names[names.size] = "<dev string:x8d>";
    names[names.size] = "<dev string:x94>";
    names[names.size] = "<dev string:x38>";
    names = arraycombine(names, get_all_shot_names(str_scene), 1, 0);
    names[names.size] = "<dev string:x38>";
    names[names.size] = "<dev string:x9b>";
    names[names.size] = "<dev string:x38>";
    names[names.size] = "<dev string:xa2>";
    str_title = str_scene;
    b_shot_menu = 1;
    selected = isDefined(level.scene_menu_shot_index) ? level.scene_menu_shot_index : 0;
  } else {
    level flagsys::set(str_type + "<dev string:x6d>");
    names[0] = "<dev string:xa9>";
    names[1] = "<dev string:x38>";

    if(level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
      println("<dev string:xca>" + toupper(str_type) + "<dev string:xde>");
    }

    var_72acc069 = 1;

    foreach(s_scenedef in a_scenedefs) {
      if(s_scenedef.vmtype === "<dev string:xef>" && s_scenedef.scenetype === str_type) {
        if(level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
          if(is_active(s_scenedef.name) && function_c0f30783(s_scenedef)) {
            array::add_sorted(names, s_scenedef.name, 0);
            println("<dev string:xf8>" + toupper(str_type) + "<dev string:x10c>" + var_72acc069 + "<dev string:x110>" + s_scenedef.name);
            var_72acc069++;
          }

          continue;
        }

        if(function_c0f30783(s_scenedef)) {
          array::add_sorted(names, s_scenedef.name, 0);
        }
      }
    }

    if(level flagsys::get(#"hash_5bcd66a9c21f5b2d")) {
      println("<dev string:xca>" + toupper(str_type) + "<dev string:x119>");
    }

    names[names.size] = "<dev string:x128>";
    str_title = str_type + "<dev string:x12f>";
  }

  selected = 0;
  up_pressed = 0;
  down_pressed = 0;
  held = 0;
  old_selected = selected;

  while(true) {
    if(held) {
      scene_list_settext(names, selected, str_title, 30);
      wait 0.5;
    } else {
      scene_list_settext(names, selected, str_title, 1);
    }

    if(!up_pressed) {
      if(level.localplayers[0] util::up_button_pressed()) {
        up_pressed = 1;
        selected--;

        if(names[selected] === "<dev string:x38>") {
          selected--;
        }
      }
    } else if(level.localplayers[0] util::up_button_held()) {
      held = 1;
      selected -= 10;
    } else if(!level.localplayers[0] util::up_button_pressed()) {
      held = 0;
      up_pressed = 0;
    }

    if(!down_pressed) {
      if(level.localplayers[0] util::down_button_pressed()) {
        down_pressed = 1;
        selected++;

        if(names[selected] === "<dev string:x38>") {
          selected++;
        }
      }
    } else if(level.localplayers[0] util::down_button_held()) {
      held = 1;
      selected += 10;
    } else if(!level.localplayers[0] util::down_button_pressed()) {
      held = 0;
      down_pressed = 0;
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

    if(level.localplayers[0] buttonpressed("<dev string:x134>")) {
      if(b_shot_menu) {
        while(level.localplayers[0] buttonpressed("<dev string:x134>")) {
          waitframe(1);
        }

        level.scene_menu_shot_index = selected;
        level thread display_scene_menu(str_type);
      } else {
        level.scene_menu_shot_index = selected;
        setdvar(#"client_scene_menu", 0);
      }
    }

    if(level.localplayers[0] buttonpressed("<dev string:x13f>") || level.localplayers[0] buttonpressed("<dev string:x14a>") || level.localplayers[0] buttonpressed("<dev string:x155>")) {
      if(names[selected] == "<dev string:xa9>") {
        level flagsys::toggle("<dev string:x15d>");

        while(level.localplayers[0] buttonpressed("<dev string:x13f>") || level.localplayers[0] buttonpressed("<dev string:x14a>") || level.localplayers[0] buttonpressed("<dev string:x155>")) {
          waitframe(1);
        }

        level thread display_scene_menu(str_type);
      } else if(names[selected] == "<dev string:x128>") {
        setdvar(#"client_scene_menu", 0);
      } else if(b_shot_menu) {
        if(names[selected] == "<dev string:xa2>") {
          level.scene_menu_shot_index = selected;

          while(level.localplayers[0] buttonpressed("<dev string:x13f>") || level.localplayers[0] buttonpressed("<dev string:x14a>") || level.localplayers[0] buttonpressed("<dev string:x155>")) {
            waitframe(1);
          }

          level thread display_scene_menu(str_type);
        } else if(names[selected] == "<dev string:x9b>") {
          setdvar(#"stop_client_scene", str_scene);
        } else if(names[selected] == "<dev string:x8d>") {
          setdvar(#"init_client_scene", str_scene);
        } else if(names[selected] == "<dev string:x94>") {
          setdvar(#"run_client_scene", str_scene);
        } else {
          setdvar(#"run_client_scene", str_scene + "<dev string:x45>" + names[selected]);
        }
      }

      while(level.localplayers[0] buttonpressed("<dev string:x13f>") || level.localplayers[0] buttonpressed("<dev string:x14a>") || level.localplayers[0] buttonpressed("<dev string:x155>")) {
        waitframe(1);
      }

      if(!b_shot_menu && isDefined(names[selected]) && names[selected] != "<dev string:x38>") {
        level.scene_menu_shot_index = selected;
        level thread display_scene_menu(str_type, names[selected]);
      }
    }

    waitframe(1);
  }
}

function_c0f30783(s_scenedef) {
  if(!(isDefined(s_scenedef.var_241c5f3c) && s_scenedef.var_241c5f3c) || isDefined(s_scenedef.var_241c5f3c) && s_scenedef.var_241c5f3c && getdvarint(#"zm_debug_ee", 0)) {
    return 1;
  }

  return 0;
}

scene_list_settext(strings, n_selected, str_title, var_444abf97) {
  level thread _scene_list_settext(strings, n_selected, str_title, var_444abf97);
}

_scene_list_settext(strings, n_selected, str_title, var_444abf97) {
  if(!isDefined(var_444abf97)) {
    var_444abf97 = 1;
  }

  debug2dtext((150, 325, 0), str_title, (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
  str_mode = tolower(getdvarstring(#"scene_menu_mode", "<dev string:x3b>"));

  switch (str_mode) {
    case #"default":
      debug2dtext((150, 362.5, 0), "<dev string:x176>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
    case #"loop":
      debug2dtext((150, 362.5, 0), "<dev string:x186>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
    case #"capture_single":
      debug2dtext((150, 362.5, 0), "<dev string:x193>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
    case #"capture_series":
      debug2dtext((150, 362.5, 0), "<dev string:x1aa>", (1, 1, 1), 1, (0, 0, 0), 1, 1, var_444abf97);
      break;
  }

  for(i = 0; i < 16; i++) {
    index = i + n_selected - 5;

    if(isDefined(strings[index])) {
      text = strings[index];
    } else {
      text = "<dev string:x38>";
    }

    if(is_scene_playing(text)) {
      text += "<dev string:x1c1>";
      str_color = (0, 1, 0);
    } else if(is_scene_initialized(text)) {
      text += "<dev string:x1ce>";
      str_color = (0, 1, 0);
    } else {
      str_color = (1, 1, 1);
    }

    if(i == 5) {
      text = "<dev string:x1df>" + text + "<dev string:x1e3>";
      str_color = (0.8, 0.4, 0);
    }

    debug2dtext((136, 400 + i * 25, 0), text, str_color, 1, (0, 0, 0), 1, 1, var_444abf97);
  }
}

is_scene_playing(str_scene) {
  if(str_scene != "<dev string:x38>" && str_scene != "<dev string:x1e7>") {
    if(level flagsys::get(str_scene + "<dev string:x1ee>")) {
      return 1;
    }
  }

  return 0;
}

is_scene_initialized(str_scene) {
  if(str_scene != "<dev string:x38>" && str_scene != "<dev string:x1e7>") {
    if(level flagsys::get(str_scene + "<dev string:x1f9>")) {
      return 1;
    }
  }

  return 0;
}

test_init(arg1) {
  init(arg1, undefined, undefined, 1);
}

function_3bafd088(var_a572f325) {
  if(getdvarint(#"dvr_enable", 0) > 0 && getdvarint(#"scr_scene_dvr", 0) > 0) {
    if(!isDefined(var_a572f325)) {
      var_a572f325 = spawnStruct();
    }

    var_a572f325.drawbig = getdvarint(#"hash_13d62f4d290ef671", 0);
    var_a572f325.var_2640d68e = getdvarint(#"scr_show_shot_info_for_igcs", 0);
    var_a572f325.drawfps = getdvarint(#"cg_drawfps", 1);
    level.var_a572f325 = var_a572f325;
    setdvar(#"hash_13d62f4d290ef671", 1);
    setdvar(#"scr_show_shot_info_for_igcs", 1);
    setdvar(#"cg_drawfps", 0);
    adddebugcommand(0, "<dev string:x208>");
    wait 1;
  }

}

function_d2785094(var_a572f325) {
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

    setdvar(#"hash_13d62f4d290ef671", drawbig);
    setdvar(#"scr_show_shot_info_for_igcs", var_2640d68e);
    setdvar(#"cg_drawfps", drawfps);
    adddebugcommand(0, "<dev string:x216>");
  }

}

test_play(arg1, arg2, str_mode) {
  if(!isDefined(level.var_a572f325)) {
    level.var_a572f325 = spawnStruct();
  }

  var_a572f325 = spawnStruct();
  var_a572f325.name = arg1;

  if(!isDefined(var_a572f325.name)) {
    var_a572f325.name = self.scriptbundlename;
  }

  if(!isDefined(var_a572f325.name)) {
    var_a572f325.name = "<dev string:x3b>";
  }

  function_3bafd088(var_a572f325);
  play(arg1, arg2, undefined, 1, str_mode);
  function_d2785094(var_a572f325);
}

debug_display() {
  self endon(#"death");

  if(!(isDefined(self.debug_display) && self.debug_display) && self != level) {
    self.debug_display = 1;

    while(true) {
      level flagsys::wait_till("<dev string:x222>");
      debug_frames = randomintrange(5, 15);
      debug_time = debug_frames / 60;
      sphere(self.origin, 1, (0, 1, 1), 1, 1, 8, debug_frames);

      if(isDefined(self.scenes)) {
        foreach(i, o_scene in self.scenes) {
          n_offset = 15 * (i + 1);
          print3d(self.origin - (0, 0, n_offset), o_scene._str_name, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
          print3d(self.origin - (0, 0, n_offset + 5), "<dev string:x22f>" + (isDefined([
            [o_scene]
          ] - > function_2ba44cd0()) ? "<dev string:x38>" + [
            [o_scene]
          ] - > function_2ba44cd0() : "<dev string:x38>") + "<dev string:x241>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
          print3d(self.origin - (0, 0, n_offset + 10), "<dev string:x245>" + (isDefined(function_12479eba(o_scene._str_name)) ? "<dev string:x38>" + function_12479eba(o_scene._str_name) : "<dev string:x38>") + "<dev string:x257>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
        }
      } else if(isDefined(self.scriptbundlename)) {
        print3d(self.origin - (0, 0, 15), self.scriptbundlename, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
      } else {
        self.debug_display = 0;
        break;
      }

      wait debug_time;
    }
  }
}

