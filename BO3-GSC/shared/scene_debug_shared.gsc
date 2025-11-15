/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\scene_debug_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\scriptbundle_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace scene;

function autoexec __init__sytem__() {
  system::register("", & __init__, undefined, undefined);
}

function __init__() {
  if(getdvarstring("", "") == "") {
    setdvar("", "");
  }
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  level thread run_scene_tests();
  level thread toggle_scene_menu();
  level thread toggle_postfx_igc_loop();
  level thread function_f69ab75e();
}

function function_f69ab75e() {
  while(true) {
    level flagsys::wait_till("");
    foreach(var_4d881e03 in function_c4a37ed9()) {
      var_4d881e03 thread debug_display();
    }
    level flagsys::wait_till_clear("");
  }
}

function function_c4a37ed9() {
  a_scenes = arraycombine(struct::get_array("", ""), struct::get_array("", ""), 0, 0);
  foreach(a_active_scenes in level.active_scenes) {
    a_scenes = arraycombine(a_scenes, a_active_scenes, 0, 0);
  }
  return a_scenes;
}

function run_scene_tests() {
  level endon("run_scene_tests");
  level.scene_test_struct = spawnStruct();
  level.scene_test_struct.origin = (0, 0, 0);
  level.scene_test_struct.angles = (0, 0, 0);
  while(true) {
    str_scene = getdvarstring("");
    str_client_scene = getdvarstring("");
    str_mode = tolower(getdvarstring("", ""));
    b_capture = str_mode == "" || str_mode == "";
    if(b_capture) {
      if(ispc()) {
        if(str_scene != "") {
          setdvar("", str_scene);
          setdvar("", "");
        }
      } else {
        setdvar("", "");
      }
    } else {
      if(str_client_scene != "") {
        level util::clientnotify(str_client_scene + "");
        util::wait_network_frame();
      }
      if(str_scene != "") {
        setdvar("", "");
        clear_old_ents(str_scene);
        b_found = 0;
        a_scenes = struct::get_array(str_scene, "");
        foreach(s_instance in a_scenes) {
          if(isDefined(s_instance)) {
            b_found = 1;
            s_instance thread test_play(undefined, str_mode);
          }
        }
        if(!b_found && isDefined(level.active_scenes[str_scene])) {
          foreach(s_instance in level.active_scenes[str_scene]) {
            b_found = 1;
            s_instance thread test_play(str_scene, str_mode);
          }
        }
        if(!b_found) {
          level.scene_test_struct thread test_play(str_scene, str_mode);
        }
      }
    }
    str_scene = getdvarstring("");
    str_client_scene = getdvarstring("");
    if(str_client_scene != "") {
      level util::clientnotify(str_client_scene + "");
      util::wait_network_frame();
    }
    if(str_scene != "") {
      setdvar("", "");
      clear_old_ents(str_scene);
      b_found = 0;
      a_scenes = struct::get_array(str_scene, "");
      foreach(s_instance in a_scenes) {
        if(isDefined(s_instance)) {
          b_found = 1;
          s_instance thread test_init();
        }
      }
      if(!b_found) {
        level.scene_test_struct thread test_init(str_scene);
      }
      if(b_capture) {
        capture_scene(str_scene, str_mode);
      }
    }
    str_scene = getdvarstring("");
    str_client_scene = getdvarstring("");
    if(str_client_scene != "") {
      level util::clientnotify(str_client_scene + "");
      util::wait_network_frame();
    }
    if(str_scene != "") {
      setdvar("", "");
      level stop(str_scene, 1);
    }
    wait(0.05);
  }
}

function capture_scene(str_scene, str_mode) {
  setdvar("", 0);
  level play(str_scene, undefined, undefined, 1, undefined, str_mode);
}

function clear_old_ents(str_scene) {
  foreach(ent in getEntArray(str_scene, "")) {
    if(ent.scene_spawned === str_scene) {
      ent delete();
    }
  }
}

function toggle_scene_menu() {
  setdvar("", 0);
  n_scene_menu_last = -1;
  while(true) {
    n_scene_menu = getdvarstring("");
    if(n_scene_menu != "") {
      n_scene_menu = int(n_scene_menu);
      if(n_scene_menu != n_scene_menu_last) {
        switch (n_scene_menu) {
          case 1: {
            level thread display_scene_menu("");
            break;
          }
          case 2: {
            level thread display_scene_menu("");
            break;
          }
          default: {
            level flagsys::clear("");
            level notify("scene_menu_cleanup");
            setdvar("", 0);
            setdvar("", 1);
          }
        }
        n_scene_menu_last = n_scene_menu;
      }
    }
    wait(0.05);
  }
}

function create_scene_hud(scene_name, index) {
  player = level.host;
  alpha = 1;
  color = vectorscale((1, 1, 1), 0.9);
  if(index != -1) {
    if(index != 5) {
      alpha = 1 - ((abs(5 - index)) / 5);
    }
  }
  if(alpha == 0) {
    alpha = 0.05;
  }
  hudelem = player openluimenu("");
  player setluimenudata(hudelem, "", scene_name);
  player setluimenudata(hudelem, "", 100);
  player setluimenudata(hudelem, "", 80 + (index * 18));
  player setluimenudata(hudelem, "", 1000);
  return hudelem;
}

function display_scene_menu(str_type) {
  if(!isDefined(str_type)) {
    str_type = "";
  }
  level notify("scene_menu_cleanup");
  level endon("scene_menu_cleanup");
  waittillframeend();
  level flagsys::set("");
  setdvar("", 1);
  setdvar("", 0);
  level thread display_mode();
  hudelem = level.host openluimenu("");
  level.host setluimenudata(hudelem, "", "");
  level.host setluimenudata(hudelem, "", 100);
  level.host setluimenudata(hudelem, "", 520);
  level.host setluimenudata(hudelem, "", 500);
  a_scenedefs = get_scenedefs(str_type);
  if(str_type == "") {
    a_scenedefs = arraycombine(a_scenedefs, get_scenedefs(""), 0, 1);
  }
  names = [];
  foreach(s_scenedef in a_scenedefs) {
    array::add_sorted(names, s_scenedef.name, 0);
  }
  names[names.size] = "";
  elems = scene_list_menu();
  title = create_scene_hud(str_type + "", -1);
  selected = 0;
  up_pressed = 0;
  down_pressed = 0;
  held = 0;
  scene_list_settext(elems, names, selected);
  old_selected = selected;
  level thread scene_menu_cleanup(elems, title, hudelem);
  while(true) {
    scene_list_settext(elems, names, selected);
    if(held) {
      wait(0.5);
    }
    if(!up_pressed) {
      if(level.host util::up_button_pressed()) {
        up_pressed = 1;
        selected--;
      }
    } else {
      if(level.host util::up_button_held()) {
        held = 1;
        selected = selected - 10;
      } else if(!level.host util::up_button_pressed()) {
        held = 0;
        up_pressed = 0;
      }
    }
    if(!down_pressed) {
      if(level.host util::down_button_pressed()) {
        down_pressed = 1;
        selected++;
      }
    } else {
      if(level.host util::down_button_held()) {
        held = 1;
        selected = selected + 10;
      } else if(!level.host util::down_button_pressed()) {
        held = 0;
        down_pressed = 0;
      }
    }
    if(held) {
      if(selected < 0) {
        selected = 0;
      } else if(selected >= names.size) {
        selected = names.size - 1;
      }
    } else {
      if(selected < 0) {
        selected = names.size - 1;
      } else if(selected >= names.size) {
        selected = 0;
      }
    }
    if(level.host buttonpressed("")) {
      setdvar("", 0);
    }
    if(names[selected] != "") {
      if(level.host buttonpressed("") || level.host buttonpressed("")) {
        level.host move_to_scene(names[selected]);
        while(level.host buttonpressed("") || level.host buttonpressed("")) {
          wait(0.05);
        }
      } else if(level.host buttonpressed("") || level.host buttonpressed("")) {
        level.host move_to_scene(names[selected], 1);
        while(level.host buttonpressed("") || level.host buttonpressed("")) {
          wait(0.05);
        }
      }
    }
    if(level.host buttonpressed("") || level.host buttonpressed("") || level.host buttonpressed("")) {
      if(names[selected] == "") {
        setdvar("", 0);
      } else {
        if(is_scene_playing(names[selected])) {
          setdvar("", names[selected]);
        } else {
          if(is_scene_initialized(names[selected])) {
            setdvar("", names[selected]);
          } else {
            if(has_init_state(names[selected])) {
              setdvar("", names[selected]);
            } else {
              setdvar("", names[selected]);
            }
          }
        }
      }
      while(level.host buttonpressed("") || level.host buttonpressed("") || level.host buttonpressed("")) {
        wait(0.05);
      }
    }
    wait(0.05);
  }
}

function display_mode() {
  hudelem = level.host openluimenu("");
  level.host setluimenudata(hudelem, "", 100);
  level.host setluimenudata(hudelem, "", 490);
  level.host setluimenudata(hudelem, "", 500);
  while(level flagsys::get("")) {
    str_mode = tolower(getdvarstring("", ""));
    switch (str_mode) {
      case "": {
        level.host setluimenudata(hudelem, "", "");
        break;
      }
      case "": {
        level.host setluimenudata(hudelem, "", "");
        break;
      }
      case "": {
        level.host setluimenudata(hudelem, "", "");
        break;
      }
      case "": {
        level.host setluimenudata(hudelem, "", "");
        break;
      }
    }
    wait(0.05);
  }
  level.host closeluimenu(hudelem);
}

function scene_list_menu() {
  hud_array = [];
  for(i = 0; i < 22; i++) {
    hud = create_scene_hud("", i);
    hud_array[hud_array.size] = hud;
  }
  return hud_array;
}

function scene_list_settext(hud_array, strings, num) {
  for(i = 0; i < hud_array.size; i++) {
    index = i + (num - 5);
    if(isDefined(strings[index])) {
      text = strings[index];
    } else {
      text = "";
    }
    if(is_scene_playing(text)) {
      level.host setluimenudata(hud_array[i], "", 1);
      text = text + "";
    } else {
      if(is_scene_initialized(text)) {
        level.host setluimenudata(hud_array[i], "", 1);
        text = text + "";
      } else {
        level.host setluimenudata(hud_array[i], "", 0.5);
      }
    }
    if(i == 5) {
      level.host setluimenudata(hud_array[i], "", 1);
      text = ("" + text) + "";
    }
    level.host setluimenudata(hud_array[i], "", text);
  }
}

function is_scene_playing(str_scene) {
  if(str_scene != "" && str_scene != "") {
    if(level flagsys::get(str_scene + "")) {
      return true;
    }
  }
  return false;
}

function is_scene_initialized(str_scene) {
  if(str_scene != "" && str_scene != "") {
    if(level flagsys::get(str_scene + "")) {
      return true;
    }
  }
  return false;
}

function scene_menu_cleanup(elems, title, hudelem) {
  level waittill("scene_menu_cleanup");
  level.host closeluimenu(title);
  for(i = 0; i < elems.size; i++) {
    level.host closeluimenu(elems[i]);
  }
  level.host closeluimenu(hudelem);
}

function test_init(arg1) {
  init(arg1, undefined, undefined, 1);
}

function test_play(arg1, str_mode) {
  play(arg1, undefined, undefined, 1, undefined, str_mode);
}

function debug_display() {
  self endon("death");
  self notify("hash_87671d41");
  self endon("hash_87671d41");
  level endon("kill_anim_debug");
  while(true) {
    debug_frames = randomintrange(5, 15);
    debug_time = debug_frames / 20;
    v_origin = (isDefined(self.origin) ? self.origin : (0, 0, 0));
    sphere(v_origin, 1, (1, 1, 0), 1, 1, 8, debug_frames);
    if(isDefined(self.scenes)) {
      foreach(i, o_scene in self.scenes) {
        n_offset = 15 * (i + 1);
        print3d(v_origin - (0, 0, n_offset), [
          [o_scene]
        ] - > get_name(), (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
        print3d(v_origin - (0, 0, n_offset + 5), ("" + (isDefined([
          [o_scene]
        ] - > get_state()) ? "" + ([
          [o_scene]
        ] - > get_state()) : "")) + "", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
      }
    } else {
      if(isDefined(self.scriptbundlename)) {
        print3d(v_origin - vectorscale((0, 0, 1), 15), self.scriptbundlename, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
      } else {
        break;
      }
    }
    wait(debug_time);
  }
}

function move_to_scene(str_scene, b_reverse_dir) {
  if(!isDefined(b_reverse_dir)) {
    b_reverse_dir = 0;
  }
  if(!level.debug_current_scene_name === str_scene) {
    level.debug_current_scene_instances = struct::get_array(str_scene, "");
    level.debug_current_scene_index = 0;
    level.debug_current_scene_name = str_scene;
  } else {
    if(b_reverse_dir) {
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
  }
  if(level.debug_current_scene_instances.size == 0) {
    s_bundle = struct::get_script_bundle("", str_scene);
    if(isDefined(s_bundle.aligntarget)) {
      e_align = get_existing_ent(s_bundle.aligntarget, 0, 1);
      if(isDefined(e_align)) {
        level.host set_origin(e_align.origin);
      } else {
        scriptbundle::error_on_screen("");
      }
    } else {
      scriptbundle::error_on_screen("");
    }
  } else {
    s_scene = level.debug_current_scene_instances[level.debug_current_scene_index];
    level.host set_origin(s_scene.origin);
  }
}

function set_origin(v_origin) {
  if(!self isinmovemode("", "")) {
    adddebugcommand("");
  }
  self setorigin(v_origin);
}

function toggle_postfx_igc_loop() {
  while(true) {
    if(getdvarint("", 0)) {
      array::run_all(level.activeplayers, & clientfield::increment_to_player, "", 1);
      wait(4);
    }
    wait(1);
  }
}