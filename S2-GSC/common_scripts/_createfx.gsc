/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_createfx.gsc
*********************************************/

soundonly() {
  return getDvar("scr_createfx_type", "0") == "2";
}

fxonly() {
  return getDvar("scr_createfx_type", "0") == "1";
}

tracknoneditfx(param_00) {
  if(isDefined(level.tracked_ent)) {
    if(!isDefined(level.tracked_ents)) {
      level.tracked_ents = [];
    }

    level.tracked_ents[level.tracked_ents.size] = level.tracked_ent.v;
  }

  level.tracked_ent = param_00;
}

createeffect(param_00, param_01) {
  var_02 = spawnStruct();
  if(soundonly()) {
    tracknoneditfx(var_02);
  } else {
    if(!isDefined(level.createfxent)) {
      level.createfxent = [];
    }

    level.createfxent[level.createfxent.size] = var_02;
  }

  var_02.v = [];
  var_02.v["type"] = param_00;
  var_02.v["fxid"] = param_01;
  var_02.v["angles"] = (0, 0, 0);
  var_02.v["origin"] = (0, 0, 0);
  var_02.drawn = 1;
  if(isDefined(param_01) && isDefined(level.createfxbyfxid)) {
    var_03 = level.createfxbyfxid[param_01];
    if(!isDefined(var_03)) {
      var_03 = [];
    }

    var_03[var_03.size] = var_02;
    level.createfxbyfxid[param_01] = var_03;
  }

  return var_02;
}

getloopeffectdelaydefault() {
  return 0.5;
}

getoneshoteffectdelaydefault() {
  return -15;
}

getexploderdelaydefault() {
  return 0;
}

getintervalsounddelaymindefault() {
  return 0.75;
}

getintervalsounddelaymaxdefault() {
  return 2;
}

createloopsound() {
  var_00 = spawnStruct();
  if(fxonly()) {
    tracknoneditfx(var_00);
  } else {
    if(!isDefined(level.createfxent)) {
      level.createfxent = [];
    }

    level.createfxent[level.createfxent.size] = var_00;
  }

  var_00.v = [];
  var_00.v["type"] = "soundfx";
  var_00.v["fxid"] = "No FX";
  var_00.v["soundalias"] = "nil";
  var_00.v["angles"] = (0, 0, 0);
  var_00.v["origin"] = (0, 0, 0);
  var_00.v["server_culled"] = 1;
  if(getDvar("1189") != "1") {
    var_00.v["server_culled"] = 0;
  }

  var_00.drawn = 1;
  return var_00;
}

createintervalsound() {
  var_00 = createloopsound();
  var_00.v["type"] = "soundfx_interval";
  var_00.v["delay_min"] = getintervalsounddelaymindefault();
  var_00.v["delay_max"] = getintervalsounddelaymaxdefault();
  return var_00;
}

createdynamicambience() {
  var_00 = spawnStruct();
  if(fxonly()) {
    tracknoneditfx(var_00);
  } else {
    if(!isDefined(level.createfxent)) {
      level.createfxent = [];
    }

    level.createfxent[level.createfxent.size] = var_00;
  }

  var_00.v = [];
  var_00.v["origin"] = (0, 0, 0);
  var_00.v["dynamic_distance"] = 1000;
  var_00.v["fxid"] = "No FX";
  var_00.v["type"] = "soundfx_dynamic";
  var_00.v["ambiencename"] = "nil";
  return var_00;
}

createnewexploder() {
  var_00 = spawnStruct();
  if(fxonly()) {
    tracknoneditfx(var_00);
  } else {
    if(!isDefined(level.createfxent)) {
      level.createfxent = [];
    }

    level.createfxent[level.createfxent.size] = var_00;
  }

  var_00.v = [];
  var_00.v["type"] = "exploder";
  var_00.v["fxid"] = "No FX";
  var_00.v["soundalias"] = "nil";
  var_00.v["loopsound"] = "nil";
  var_00.v["angles"] = (0, 0, 0);
  var_00.v["origin"] = (0, 0, 0);
  var_00.v["exploder"] = 1;
  var_00.v["flag"] = "nil";
  var_00.v["exploder_type"] = "normal";
  var_00.drawn = 1;
  return var_00;
}

createexploderex(param_00, param_01) {
  var_02 = common_scripts\utility::createexploder(param_00);
  var_02.v["exploder"] = param_01;
  return var_02;
}

createreactiveent() {
  var_00 = spawnStruct();
  if(soundonly()) {
    tracknoneditfx(var_00);
  } else {
    if(!isDefined(level.createfxent)) {
      level.createfxent = [];
    }

    level.createfxent[level.createfxent.size] = var_00;
  }

  var_00.v = [];
  var_00.v["origin"] = (0, 0, 0);
  var_00.v["reactive_radius"] = 200;
  var_00.v["fxid"] = "No FX";
  var_00.v["type"] = "reactive_fx";
  var_00.v["soundalias"] = "nil";
  return var_00;
}

set_origin_and_angles(param_00, param_01) {
  if(isDefined(level.createfx_offset)) {
    param_00 = param_00 + level.createfx_offset;
  }

  self.v["origin"] = param_00;
  self.v["angles"] = param_01;
}

set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglesToForward(self.v["angles"]);
}

convertoneshotfx() {
  setdvarifuninitialized("curr_exp_num", 1);
  var_00 = getdvarint("curr_exp_num");
  for(var_01 = 0; var_01 < level._createfx.selected_fx_ents.size; var_01++) {
    var_02 = level._createfx.selected_fx_ents[var_01];
    if(var_02.v["type"] == "oneshotfx") {
      function_014E(var_02.looper, 1);
      wait 0.05;
      var_02 common_scripts\utility::pauseeffect();
      var_02.v["type"] = "exploder";
      var_02.v["exploder"] = var_00;
      var_02.v["delay"] = 0;
      var_02.v["exploder_type"] = "normal";
      var_02 common_scripts\utility::activate_individual_exploder();
      continue;
    }

    if(var_02.v["type"] == "exploder") {
      function_014E(var_02.looper, 1);
      wait 0.05;
      var_02.v["type"] = "oneshotfx";
      var_02 remove_option("exploder");
      var_02.v["delay"] = -15;
      var_02 remove_option("exploder_type");
    }
  }

  level._createfx.justconvertedoneshot = 1;
}

createfx_common() {
  level._createfx = spawnStruct();
  level._createfx.var_B1 = spawn("script_origin", (0, 0, 0));
  level._createfx.var_B1.fx = loadfx("vfx/explosion/frag_grenade_default");
  level._createfx.var_B1.sound = "null";
  level._createfx.var_B1.radius = 256;
  wait 0.05;
  common_scripts\utility::flag_init("createfx_saving");
  common_scripts\utility::flag_init("createfx_started");
  if(!isDefined(level.createfx)) {
    level.createfx = [];
  }

  level.createfx_loopcounter = 0;
  setDvar("ui_hidehud", "1");
  level notify("createfx_common_done");
}

init_level_variables() {
  level._createfx.selectedmove_up = 0;
  level._createfx.selectedmove_forward = 0;
  level._createfx.selectedmove_right = 0;
  level._createfx.selectedrotate_pitch = 0;
  level._createfx.selectedrotate_roll = 0;
  level._createfx.selectedrotate_yaw = 0;
  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
  level._createfx.justconvertedoneshot = 0;
  level._createfx.var_8C29 = 0;
  level._createfx.var_8BF0 = 0;
  level._createfx.rate = 1;
  level._createfx.snap2normal = 0;
  level._createfx.snap90deg = 0;
  level._createfx.localrot = 0;
  level._createfx.axismode = 0;
  level._createfx.select_by_name = 0;
  level._createfx.player_speed = getdvarfloat("5502");
}

init_locked_list() {
  level._createfx.lockedlist = [];
  level._createfx.lockedlist["escape"] = 1;
  level._createfx.lockedlist["BUTTON_LSHLDR"] = 1;
  level._createfx.lockedlist["BUTTON_RSHLDR"] = 1;
  level._createfx.lockedlist["mouse1"] = 1;
  level._createfx.lockedlist["ctrl"] = 1;
}

init_colors() {
  var_00 = [];
  var_00["loopfx"]["selected"] = (1, 1, 0.2);
  var_00["loopfx"]["highlighted"] = (0.4, 0.95, 1);
  var_00["loopfx"]["default"] = (0.3, 0.8, 1);
  var_00["oneshotfx"]["selected"] = (1, 1, 0.2);
  var_00["oneshotfx"]["highlighted"] = (0.3, 0.6, 1);
  var_00["oneshotfx"]["default"] = (0.1, 0.2, 1);
  var_00["exploder"]["selected"] = (1, 1, 0.2);
  var_00["exploder"]["highlighted"] = (1, 0.2, 0.2);
  var_00["exploder"]["default"] = (1, 0.1, 0.1);
  var_00["rainfx"]["selected"] = (1, 1, 0.2);
  var_00["rainfx"]["highlighted"] = (0.95, 0.4, 0.95);
  var_00["rainfx"]["default"] = (0.78, 0, 0.73);
  var_00["soundfx"]["selected"] = (1, 1, 0.2);
  var_00["soundfx"]["highlighted"] = (0.2, 1, 0.2);
  var_00["soundfx"]["default"] = (0.1, 1, 0.1);
  var_00["soundfx_interval"]["selected"] = (1, 1, 0.2);
  var_00["soundfx_interval"]["highlighted"] = (0.3, 1, 0.3);
  var_00["soundfx_interval"]["default"] = (0.1, 1, 0.1);
  var_00["reactive_fx"]["selected"] = (1, 1, 0.2);
  var_00["reactive_fx"]["highlighted"] = (0.5, 1, 0.75);
  var_00["reactive_fx"]["default"] = (0.2, 0.9, 0.2);
  var_00["soundfx_dynamic"]["selected"] = (1, 1, 0.2);
  var_00["soundfx_dynamic"]["highlighted"] = (0.3, 1, 0.3);
  var_00["soundfx_dynamic"]["default"] = (0.1, 1, 0.1);
  level._createfx.colors = var_00;
}

func_1B6D() {
  if(level.mp_createfx) {
    for(;;) {
      if(level._createfx.var_8BF0) {}

      wait(0.1);
    }
  }
}

createfxlogic() {
  waittillframeend;
  wait 0.05;
  wait(10);
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  if(getDvar("5855") == "") {} else if(getDvar("5855") == common_scripts\utility::get_template_level()) {
    [[level.func_position_player]]();
  }

  init_crosshair();
  common_scripts\_createfxmenu::init_menu();
  init_huds();
  init_tools_hud();
  init_crosshair();
  init_level_variables();
  init_locked_list();
  init_colors();
  if(getDvar("createfx_use_f4") == "") {}

  if(getDvar("createfx_no_autosave") == "") {}

  level.createfx_draw_enabled = 1;
  level.last_displayed_ent = undefined;
  level.buttonisheld = [];
  var_00 = (0, 0, 0);
  common_scripts\utility::flag_set("createfx_started");
  if(!level.mp_createfx) {
    var_00 = level.player.origin;
  }

  var_01 = undefined;
  level.fx_rotating = 0;
  common_scripts\_createfxmenu::setmenu("none");
  level.createfx_selecting = 0;
  level.createfx_inputlocked = 0;
  foreach(var_03 in level.createfxent) {
    var_03 post_entity_creation_function();
  }

  thread draw_distance();
  var_05 = undefined;
  thread createfx_autosave();
  level.createfx_last_movement_timer = 0;
  thread save_undo_buffer();
  thread setup_last_movement_timer();
  thread func_1B6D();
  thread func_0646();
  for(;;) {
    level.player notify("releasepadmonitors", "createfx");
    var_06 = 0;
    var_07 = anglestoright(level.player getplayerangles());
    var_08 = anglesToForward(level.player getplayerangles());
    var_09 = anglestoup(level.player getplayerangles());
    var_0A = 0.85;
    var_0B = var_08 * 750;
    level.createfxcursor = bulletTrace(level.player getEye(), level.player getEye() + var_0B, 0, undefined);
    var_0C = undefined;
    level.buttonclick = [];
    level.button_is_kb = [];
    process_button_held_and_clicked();
    var_0D = button_is_held("ctrl", "BUTTON_LSHLDR");
    var_0E = button_is_clicked("mouse1", "BUTTON_A");
    var_0F = button_is_held("mouse1", "BUTTON_A");
    var_10 = button_is_held("shift");
    common_scripts\_createfxmenu::create_fx_menu();
    var_11 = "F5";
    if(getdvarint("createfx_use_f4")) {
      var_11 = "F4";
    }

    if(button_is_clicked(var_11)) {}

    if(getdvarint("scr_createfx_dump")) {
      generate_fx_log();
    }

    if(button_is_clicked("F2")) {
      toggle_createfx_drawing();
    }

    if(button_is_clicked("ins")) {
      insert_effect();
    }

    if(button_is_clicked("del")) {
      delete_pressed();
    }

    if(button_is_clicked("escape")) {
      clear_settable_fx();
    }

    if(button_is_clicked("rightarrow", "space") && !level.createfx_menu_list_active) {
      set_off_exploders();
    }

    if(button_is_clicked("leftarrow") && !level.createfx_menu_list_active) {
      turn_off_exploders();
    }

    if(button_is_clicked("f")) {
      frame_selected();
    }

    if(button_is_clicked("j") && !var_10) {
      func_5984("next");
    }

    if(button_is_clicked("j") && var_10) {
      func_5984("prev");
    }

    if(button_is_clicked("u")) {
      select_by_name_list();
    }

    if(button_is_clicked("c")) {
      convertoneshotfx();
    }

    if(button_is_clicked("v")) {
      func_8C29();
    }

    if(button_is_clicked("b")) {
      func_8BF0();
    }

    if(button_is_clicked("r") && var_10) {
      func_7A4E();
    }

    modify_player_speed();
    if(!var_0D && button_is_clicked("g")) {
      select_all_exploders_of_currently_selected("exploder");
      select_all_exploders_of_currently_selected("flag");
      func_838C("fxid");
    }

    if(button_is_clicked("h", "F1")) {
      show_help();
    }

    if(button_is_clicked("BUTTON_LSTICK")) {
      copy_ents();
    }

    if(button_is_clicked("BUTTON_RSTICK")) {
      paste_ents();
    }

    if(button_is_clicked("z")) {
      undo();
    }

    if(button_is_clicked("z") && var_10) {
      redo();
    }

    if(var_0D) {
      if(button_is_clicked("c")) {
        copy_ents();
      }

      if(button_is_clicked("v")) {
        paste_ents();
      }

      if(button_is_clicked("g")) {
        spawn_grenade();
      }
    }

    if(isDefined(level._createfx.selected_fx_option_index)) {
      common_scripts\_createfxmenu::menu_fx_option_set();
    }

    for(var_12 = 0; var_12 < level.createfxent.size; var_12++) {
      var_03 = level.createfxent[var_12];
      var_13 = level.player getvieworigin();
      var_14 = vectorNormalize(var_03.v["origin"] - var_13);
      var_15 = vectordot(var_08, var_14);
      if(var_15 < var_0A) {
        continue;
      }

      var_0A = var_15;
      var_0C = var_03;
    }

    level.fx_highlightedent = var_0C;
    if(isDefined(var_0C)) {
      if(isDefined(var_01)) {
        if(var_01 != var_0C) {
          if(!ent_is_selected(var_01)) {
            var_01 thread entity_highlight_disable();
          }

          if(!ent_is_selected(var_0C)) {
            var_0C thread entity_highlight_enable();
          }
        }
      } else if(!ent_is_selected(var_0C)) {
        var_0C thread entity_highlight_enable();
      }
    }

    manipulate_createfx_ents(var_0C, var_0E, var_0F, var_0D, var_07);
    var_06 = handle_selected_ents(var_06);
    wait 0.05;
    if(var_06) {
      update_selected_ents();
    }

    if(!level.mp_createfx) {
      var_00 = [[level.func_position_player_get]](var_00);
    }

    var_01 = var_0C;
    if(last_selected_entity_has_changed(var_05)) {
      level.effect_list_offset = 0;
      clear_settable_fx();
      common_scripts\_createfxmenu::setmenu("none");
    }

    if(level._createfx.selected_fx_ents.size) {
      var_05 = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
      continue;
    }

    var_05 = undefined;
  }
}

modify_player_speed() {
  var_00 = 0;
  var_01 = button_is_held("ctrl");
  if(button_is_held(".")) {
    if(var_01) {
      if(level._createfx.player_speed < 190) {
        level._createfx.player_speed = 190;
      } else {
        level._createfx.player_speed = level._createfx.player_speed + 10;
      }
    } else {
      level._createfx.player_speed = level._createfx.player_speed + 5;
    }

    var_00 = 1;
  } else if(button_is_held(",")) {
    if(var_01) {
      if(level._createfx.player_speed > 190) {
        level._createfx.player_speed = 190;
      } else {
        level._createfx.player_speed = level._createfx.player_speed - 10;
      }
    } else {
      level._createfx.player_speed = level._createfx.player_speed - 5;
    }

    var_00 = 1;
  }

  if(var_00) {
    level._createfx.player_speed = clamp(level._createfx.player_speed, 5, 500);
    [[level.func_player_speed]]();
  }
}

toggle_createfx_drawing() {
  level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

insert_effect() {
  common_scripts\_createfxmenu::setmenu("creation");
  level.effect_list_offset = 0;
  clear_fx_hudelements();
  set_fx_hudelement("Pick effect type to create:");
  set_fx_hudelement("1. One Shot FX");
  set_fx_hudelement("2. Looping FX");
  set_fx_hudelement("3. Looping sound");
  set_fx_hudelement("4. Exploder");
  set_fx_hudelement("5. One Shot Sound");
  set_fx_hudelement("6. Reactive Sound");
  set_fx_hudelement("7. Dynamic Ambience");
  set_fx_hudelement("(x) Exit >");
}

is_ent_filtered_out(param_00, param_01) {
  if(param_01 != "") {
    if(isDefined(param_00.v["type"]) && issubstr(param_00.v["type"], param_01)) {
      return 0;
    } else if(isDefined(param_00.v["fxid"]) && issubstr(param_00.v["fxid"], param_01)) {
      return 0;
    } else if(isDefined(param_00.v["soundalias"]) && issubstr(param_00.v["soundalias"], param_01)) {
      return 0;
    } else if(isDefined(param_00.v["exploder"]) && issubstr(param_00.v["exploder"], param_01)) {
      return 0;
    }

    return 1;
  }

  return 0;
}

manipulate_createfx_ents(param_00, param_01, param_02, param_03, param_04) {
  if(!level.createfx_draw_enabled) {
    return;
  }

  if(level._createfx.select_by_name) {
    level._createfx.select_by_name = 0;
    param_00 = undefined;
  } else if(select_by_substring()) {
    param_00 = undefined;
  }

  for(var_05 = 0; var_05 < level.createfxent.size; var_05++) {
    var_06 = level.createfxent[var_05];
    if(!var_06.drawn) {
      continue;
    }

    if(is_ent_filtered_out(var_06, getDvar("createfx_filter"))) {
      continue;
    }

    var_07 = getdvarfloat("createfx_scaleid");
    if(isDefined(param_00) && var_06 == param_00) {
      if(!common_scripts\_createfxmenu::entities_are_selected()) {
        common_scripts\_createfxmenu::display_fx_info(var_06);
      }

      if(param_01) {
        var_08 = index_is_selected(var_05);
        level.createfx_help_active = 0;
        level.createfx_selecting = !var_08;
        if(!param_03) {
          var_09 = level._createfx.selected_fx_ents.size;
          clear_entity_selection();
          if(var_08 && var_09 == 1) {
            select_entity(var_05, var_06);
          }
        }

        toggle_entity_selection(var_05, var_06);
      } else if(param_02) {
        if(param_03) {
          if(level.createfx_selecting) {
            select_entity(var_05, var_06);
          }

          if(!level.createfx_selecting) {
            deselect_entity(var_05, var_06);
          }
        }
      }

      var_0A = "highlighted";
    } else {
      var_0A = "default";
    }

    if(index_is_selected(var_05)) {
      var_0A = "selected";
    }

    var_06 createfx_print3d(var_0A, var_07, param_04);
  }
}

draw_origin(param_00, param_01) {
  var_02 = level.player getvieworigin();
  var_03 = level.player getplayerangles();
  var_04 = level._createfx.colors[self.v["type"]][param_01];
  var_05 = 0;
  var_06 = 1;
  var_07 = (0, 0, 0);
  var_08 = int(max(16, getdvarfloat("createfx_crosshairdrawdist")));
  var_09 = int(max(16, getdvarfloat("createfx_accuratedrawdist")));
  var_0A = var_09 * var_09;
  var_0B = distancesquared(var_02, self.v["origin"]) < var_0A * param_00;
  if(var_0B) {
    var_0C = distance(var_02, self.v["origin"]);
    var_0D = var_0C / var_08 - 16;
    var_05 = 1 - clamp(var_0D, 0, 1);
    var_06 = clamp(var_0D, 0.333, 1);
    var_0E = anglestoright(var_03) * -2.5 * param_00;
    var_0F = anglestoup(var_03) * -3.5 * param_00;
    var_07 = var_0E + var_0F;
  }

  if(var_05 > 0) {
    var_10 = common_scripts\utility::within_fov(var_02, var_03, self.v["origin"], 0.422618);
    if(var_10) {
      var_11 = 2;
      var_12 = 4;
      var_13 = anglesToForward(self.v["angles"]);
      var_13 = var_13 * var_12 * param_00;
      var_14 = anglestoright(self.v["angles"]) * -1;
      var_14 = var_14 * var_12 * param_00;
      var_15 = anglestoup(self.v["angles"]);
      var_15 = var_15 * var_12 * param_00;
      var_16 = 0.333;
      var_17 = var_04 * (var_16, var_16, var_16) + (1, 0, 0);
      var_18 = var_04 * (var_16, var_16, var_16) + (0, 1, 0);
      var_19 = var_04 * (var_16, var_16, var_16) + (0, 0, 1);
    }
  }
}

createfx_print3d(param_00, param_01, param_02) {
  if(getdvarint("fx_showLightGridSampleOffset") != 0) {
    var_03 = getdvarfloat("4525");
    var_04 = anglesToForward(self.v["angles"]) * var_03;
  }

  draw_origin(param_01, param_00);
  if(self.textalpha > 0) {
    var_05 = get_print3d_text();
    var_06 = param_02 * var_05.size * -2.93 * param_01;
    var_07 = level._createfx.colors[self.v["type"]][param_00];
    if(isDefined(self.is_playing)) {
      var_07 = (1, 0.5, 0);
    }

    if(isDefined(self.v["reactive_radius"])) {
      return;
    }

    if(isDefined(self.v["dynamic_distance"])) {
      return;
    }
  }
}

get_print3d_text() {
  switch (self.v["type"]) {
    case "reactive_fx":
      return "reactive: " + self.v["soundalias"];

    case "soundfx_interval":
      return self.v["soundalias"];

    case "soundfx_dynamic":
      return "dynamic: " + self.v["ambiencename"];

    case "soundfx":
      return self.v["soundalias"];

    case "exploder":
      if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
        if(self.v["fxid"] == "No FX") {
          return "@)) " + self.v["soundalias"];
        } else {
          return self.v["fxid"] + " @))";
        }
      } else {
        return self.v["fxid"];
      }

      break;

    case "oneshotfx":
      if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
        return self.v["fxid"] + " @))";
      } else {
        return self.v["fxid"];
      }

      break;

    default:
      return self.v["fxid"];
  }
}

select_by_name_list() {
  level.effect_list_offset = 0;
  clear_fx_hudelements();
  common_scripts\_createfxmenu::setmenu("select_by_name");
  common_scripts\_createfxmenu::draw_effects_list();
}

func_8C29() {
  if(level._createfx.var_8C29) {} else {}

  level._createfx.var_8C29 = !level._createfx.var_8C29;
}

func_8BF0() {
  if(level.mp_createfx) {
    level._createfx.var_8BF0 = !level._createfx.var_8BF0;
  }
}

handle_selected_ents(param_00) {
  if(level._createfx.selected_fx_ents.size > 0 && level.createfx_help_active == 0) {
    param_00 = selected_ent_buttons(param_00);
    if(!current_mode_hud("selected_ents")) {
      new_tool_hud("selected_ents");
    }

    if(!isDefined(level._createfx.rate1)) {
      level._createfx.rate1 = "";
    }

    set_tool_hudelem("Rate", level._createfx.rate1);
    if(level._createfx.snap2normal) {
      var_01 = "on";
      var_02 = (0, 1, 0);
    } else {
      var_01 = "off";
      var_02 = (0.5, 0.5, 0.5);
    }

    set_tool_hudelem("Snap2Normal( S ):", var_01, var_02);
    if(level._createfx.snap90deg) {
      var_03 = "on";
      var_04 = (0, 1, 0);
    } else {
      var_03 = "off";
      var_04 = (0.5, 0.5, 0.5);
    }

    set_tool_hudelem("90deg Snap( L ):", var_03, var_04);
    if(level._createfx.localrot) {
      var_05 = "on";
      var_06 = (0, 1, 0);
    } else {
      var_05 = "off";
      var_06 = (0.5, 0.5, 0.5);
    }

    set_tool_hudelem("Local Rotation( R ):", var_05, var_06);
    set_tool_hudelem("Selection:", func_7E32());
    set_tool_hudelem("Camera Speed( </>):", level._createfx.player_speed);
    if(!level.mp_createfx) {
      set_tool_hudelem("Dist To Cam", level._createfx.var_83B0);
    }

    if(level._createfx.axismode && level._createfx.selected_fx_ents.size > 0) {
      level._createfx.rate1 = "of Rotation( -/+ ): " + level._createfx.rate;
      thread[[level.func_process_fx_rotater]]();
      if(button_is_clicked("p")) {
        reset_axis_of_selected_ent();
      }

      if(button_is_clicked("o")) {
        func_0B60();
      }

      if(button_is_clicked("i")) {
        copy_angles_of_selected_ents();
      }

      for(var_07 = 0; var_07 < level._createfx.selected_fx_ents.size; var_07++) {
        level._createfx.selected_fx_ents[var_07] draw_axis();
      }

      if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0) {
        param_00 = 1;
      }
    } else {
      level._createfx.rate1 = "of Movement( -/+ ): " + level._createfx.rate;
      var_08 = get_selected_move_vector();
      for(var_07 = 0; var_07 < level._createfx.selected_fx_ents.size; var_07++) {
        var_09 = level._createfx.selected_fx_ents[var_07];
        if(isDefined(var_09.model)) {
          continue;
        }

        if(level.mp_createfx && func_55E9(var_09.v["origin"] + var_08) != 1) {
          createfx_centerprint("Can\'t place FX outisde map bounds");
          var_08 = (0, 0, 0);
        }

        var_09.v["origin"] = var_09.v["origin"] + var_08;
      }

      if(distance((0, 0, 0), var_08) > 0) {
        thread save_undo_buffer();
        level.createfx_last_movement_timer = 0;
        param_00 = 1;
      }
    }
  } else {
    clear_tool_hud();
  }

  return param_00;
}

selected_ent_buttons(param_00) {
  var_01 = button_is_held("shift");
  if(button_is_clicked("BUTTON_X")) {
    toggle_axismode();
  }

  modify_rate();
  func_A163();
  if(button_is_clicked("s")) {
    toggle_snap2normal();
  }

  if(button_is_clicked("l")) {
    toggle_snap90deg();
  }

  if(button_is_clicked("r") && !var_01) {
    toggle_localrot();
  }

  if(button_is_clicked("end")) {
    drop_selection_to_ground();
    param_00 = 1;
  }

  if(button_is_clicked("tab", "BUTTON_RSHLDR")) {
    move_selection_to_cursor();
    param_00 = 1;
  }

  return param_00;
}

modify_rate() {
  var_00 = button_is_held("shift");
  var_01 = button_is_held("ctrl");
  if(button_is_clicked("=")) {
    if(var_00) {
      level._createfx.rate = level._createfx.rate + 0.025;
    } else if(var_01) {
      if(level._createfx.rate < 1) {
        level._createfx.rate = 1;
      } else {
        level._createfx.rate = level._createfx.rate + 10;
      }
    } else {
      level._createfx.rate = level._createfx.rate + 0.1;
    }
  } else if(button_is_clicked("-")) {
    if(var_00) {
      level._createfx.rate = level._createfx.rate - 0.025;
    } else if(var_01) {
      if(level._createfx.rate > 1) {
        level._createfx.rate = 1;
      } else {
        level._createfx.rate = 0.1;
      }
    } else {
      level._createfx.rate = level._createfx.rate - 0.1;
    }
  }

  level._createfx.rate = clamp(level._createfx.rate, 0.025, 100);
}

toggle_axismode() {
  level._createfx.axismode = !level._createfx.axismode;
}

toggle_snap2normal() {
  level._createfx.snap2normal = !level._createfx.snap2normal;
  if(level._createfx.snap2normal) {
    var_00 = "on";
    var_01 = (0, 1, 0);
  } else {
    var_00 = "off";
    var_01 = (0.5, 0.5, 0.5);
  }

  set_tool_hudelem("Snap2Normal( S ):", var_00, var_01);
}

toggle_snap90deg() {
  level._createfx.snap90deg = !level._createfx.snap90deg;
  if(level._createfx.snap90deg) {
    var_00 = "on";
    var_01 = (0, 1, 0);
  } else {
    var_00 = "off";
    var_01 = (0.5, 0.5, 0.5);
  }

  set_tool_hudelem("90deg Snap( L ):", var_00, var_01);
}

toggle_localrot() {
  level._createfx.localrot = !level._createfx.localrot;
  if(level._createfx.localrot) {
    var_00 = "on";
    var_01 = (0, 1, 0);
  } else {
    var_00 = "off";
    var_01 = (0.5, 0.5, 0.5);
  }

  set_tool_hudelem("Local Rotation( R ):", var_00, var_01);
}

func_A163() {
  if(level._createfx.selected_fx_ents.size < 1) {
    level._createfx.var_83B0 = 0;
    return;
  }

  if(level._createfx.selected_fx_ents.size == 1) {
    var_00 = level._createfx.selected_fx_ents[0].v["origin"];
  } else {
    var_00 = get_center_of_array(level._createfx.selected_fx_ents);
  }

  level._createfx.var_83B0 = distance(var_00, level.player getEye());
}

func_7E32() {
  if(level._createfx.selected_fx_ents.size < 1) {
    return "";
  }

  if(level._createfx.selected_fx_ents.size == 1) {
    var_00 = "fxid";
    if(level._createfx.selected_fx_ents[0].v["fxid"] == "No FX") {
      if(isDefined(level._createfx.selected_fx_ents[0].v["soundalias"]) && level._createfx.selected_fx_ents[0].v["soundalias"] != "null") {
        var_00 = "soundalias";
      } else if(isDefined(level._createfx.selected_fx_ents[0].v["ambiencename"]) && level._createfx.selected_fx_ents[0].v["ambiencename"] != "null") {
        var_00 = "ambiencename";
      }
    }

    var_01 = level._createfx.selected_fx_ents[0].v[var_00];
    var_02 = [];
    foreach(var_05, var_04 in level.createfxent) {
      if(isDefined(var_04.v[var_00]) && issubstr(var_04.v[var_00], var_01)) {
        if(var_00 == "soundalias") {
          if(var_04.v["type"] == "soundfx_interval" || var_04.v["type"] == "soundfx") {
            var_02[var_02.size] = var_05;
          }

          continue;
        }

        var_02[var_02.size] = var_05;
      }
    }

    var_06 = 0;
    if(var_02.size > 1) {
      for(var_05 = 0; var_05 < var_02.size; var_05++) {
        if(level.createfxent[var_02[var_05]] == level._createfx.selected_fx_ents[0]) {
          var_06 = var_05;
        }
      }
    }

    return var_06 + 1 + " of " + var_02.size + " placed";
  }

  return level._createfx.selected_fx_ents.size + " entities";
}

copy_angles_of_selected_ents() {
  thread save_undo_buffer();
  level notify("new_ent_selection");
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    var_01 = level._createfx.selected_fx_ents[var_00];
    var_01.v["angles"] = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1].v["angles"];
    var_01 set_forward_and_up_vectors();
  }

  update_selected_ents();
  level.createfx_last_movement_timer = 0;
}

func_0B60() {
  thread save_undo_buffer();
  level notify("new_ent_selection");
  var_00 = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
  if(level._createfx.selected_fx_ents.size == 1 && !level.mp_createfx) {
    var_01 = level._createfx.selected_fx_ents[0];
    var_02 = vectortoangles(-1 * [[level.var_3F0F]]());
    var_01.v["angles"] = var_02;
    var_01 set_forward_and_up_vectors();
  } else {
    for(var_03 = 0; var_03 < level._createfx.selected_fx_ents.size - 1; var_03++) {
      var_01 = level._createfx.selected_fx_ents[var_03];
      var_02 = vectortoangles(var_00.v["origin"] - var_01.v["origin"]);
      var_01.v["angles"] = var_02;
      var_01 set_forward_and_up_vectors();
    }
  }

  update_selected_ents();
  level.createfx_last_movement_timer = 0;
}

func_7A4E() {
  thread save_undo_buffer();
  level notify("new_ent_selection");
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    var_01 = level._createfx.selected_fx_ents[var_00];
    var_01.v["delay"] = randomfloatrange(-30, -1);
  }

  update_selected_ents();
  level.createfx_last_movement_timer = 0;
}

reset_axis_of_selected_ent() {
  level notify("new_ent_selection");
  thread save_undo_buffer();
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    var_01 = level._createfx.selected_fx_ents[var_00];
    var_01.v["angles"] = (0, 0, 0);
    var_01 set_forward_and_up_vectors();
  }

  update_selected_ents();
  level.createfx_last_movement_timer = 0;
}

last_selected_entity_has_changed(param_00) {
  if(isDefined(param_00)) {
    if(!common_scripts\_createfxmenu::entities_are_selected()) {
      return 1;
    }
  } else {
    return common_scripts\_createfxmenu::entities_are_selected();
  }

  return param_00 != level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}

drop_selection_to_ground() {
  thread save_undo_buffer();
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    var_01 = level._createfx.selected_fx_ents[var_00];
    var_02 = bulletTrace(var_01.v["origin"], var_01.v["origin"] + (0, 0, -2048), 0, undefined);
    var_01.v["origin"] = var_02["position"];
  }

  level.createfx_last_movement_timer = 0;
}

set_off_exploders() {
  level notify("createfx_exploder_reset");
  var_00 = [];
  for(var_01 = 0; var_01 < level._createfx.selected_fx_ents.size; var_01++) {
    var_02 = level._createfx.selected_fx_ents[var_01];
    if(isDefined(var_02.v["exploder"])) {
      var_00[var_02.v["exploder"]] = 1;
    }
  }

  var_03 = getarraykeys(var_00);
  for(var_01 = 0; var_01 < var_03.size; var_01++) {
    common_scripts\_exploder::exploder(var_03[var_01]);
  }
}

turn_off_exploders() {
  level notify("createfx_exploder_reset");
  var_00 = [];
  for(var_01 = 0; var_01 < level._createfx.selected_fx_ents.size; var_01++) {
    var_02 = level._createfx.selected_fx_ents[var_01];
    if(isDefined(var_02.v["exploder"])) {
      var_00[var_02.v["exploder"]] = 1;
    }
  }

  var_03 = getarraykeys(var_00);
  for(var_01 = 0; var_01 < var_03.size; var_01++) {
    common_scripts\_exploder::kill_exploder(var_03[var_01]);
  }
}

draw_distance() {
  var_00 = 0;
  if(getdvarint("createfx_drawdist") == 0) {}

  for(;;) {
    var_01 = getdvarint("createfx_drawdist");
    var_01 = var_01 * var_01;
    for(var_02 = 0; var_02 < level.createfxent.size; var_02++) {
      var_03 = level.createfxent[var_02];
      var_03.drawn = distancesquared(level.player.origin, var_03.v["origin"]) <= var_01;
      var_00++;
      if(var_00 > 100) {
        var_00 = 0;
        wait 0.05;
      }
    }

    if(level.createfxent.size == 0) {
      wait 0.05;
    }
  }
}

createfx_autosave() {
  setdvarifuninitialized("createfx_autosave_time", "300");
  for(;;) {
    wait(getdvarint("createfx_autosave_time"));
    common_scripts\utility::flag_waitopen("createfx_saving");
    if(getdvarint("createfx_no_autosave")) {
      continue;
    }

    generate_fx_log(1);
  }
}

rotate_over_time(param_00, param_01) {
  level endon("new_ent_selection");
  var_02 = 0.1;
  for(var_03 = 0; var_03 < var_02 * 20; var_03++) {
    if(level.selectedrotate_pitch != 0) {
      param_00 addpitch(level.selectedrotate_pitch);
    } else if(level.selectedrotate_roll != 0) {
      param_00 addyaw(level.selectedrotate_roll);
    } else {
      param_00 addroll(level.selectedrotate_yaw);
    }

    wait 0.05;
    param_00 draw_axis();
    for(var_04 = 0; var_04 < level._createfx.selected_fx_ents.size; var_04++) {
      var_05 = level._createfx.selected_fx_ents[var_04];
      if(isDefined(var_05.model)) {
        continue;
      }

      var_05.v["origin"] = param_01[var_04].origin;
      var_05.v["angles"] = param_01[var_04].angles;
    }
  }
}

delete_pressed() {
  if(level.createfx_inputlocked) {
    remove_selected_option();
    return;
  }

  delete_selection();
}

remove_selected_option() {
  if(!isDefined(level._createfx.selected_fx_option_index)) {
    return;
  }

  var_00 = level._createfx.options[level._createfx.selected_fx_option_index]["name"];
  for(var_01 = 0; var_01 < level.createfxent.size; var_01++) {
    var_02 = level.createfxent[var_01];
    if(!ent_is_selected(var_02)) {
      continue;
    }

    var_02 remove_option(var_00);
  }

  update_selected_ents();
  clear_settable_fx();
}

remove_option(param_00) {
  self.v[param_00] = undefined;
}

delete_selection() {
  save_undo_buffer();
  var_00 = [];
  for(var_01 = 0; var_01 < level.createfxent.size; var_01++) {
    var_02 = level.createfxent[var_01];
    if(ent_is_selected(var_02)) {
      var_02 stop_loopsound();
      if(isDefined(var_02.looper)) {
        var_02.looper delete();
      }

      var_02 notify("stop_loop");
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  level.createfxent = var_00;
  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
  clear_fx_hudelements();
  save_redo_buffer();
}

move_selection_to_cursor() {
  thread save_undo_buffer();
  var_00 = level.createfxcursor["position"];
  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }

  if(level.mp_createfx && func_55E9(var_00) != 1) {
    createfx_centerprint("Can\'t Place FX Outside Map Bounds");
    return;
  }

  var_01 = get_center_of_array(level._createfx.selected_fx_ents);
  var_02 = var_01 - var_00;
  for(var_03 = 0; var_03 < level._createfx.selected_fx_ents.size; var_03++) {
    var_04 = level._createfx.selected_fx_ents[var_03];
    if(isDefined(var_04.model)) {
      continue;
    }

    var_04.v["origin"] = var_04.v["origin"] - var_02;
    if(level._createfx.snap2normal) {
      if(isDefined(level.createfxcursor["normal"])) {
        var_04.v["angles"] = vectortoangles(level.createfxcursor["normal"]);
      }
    }
  }

  level.createfx_last_movement_timer = 0;
}

select_last_entity() {
  select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
}

reselect_entities() {
  var_00 = [];
  for(var_01 = 0; var_01 < level.createfxent.size; var_01++) {
    if(index_is_selected(var_01)) {
      var_00[var_00.size] = var_01;
    }
  }

  clear_entity_selection();
  select_index_array(var_00);
}

select_all_exploders_of_currently_selected(param_00) {
  var_01 = [];
  foreach(var_03 in level._createfx.selected_fx_ents) {
    if(!isDefined(var_03.v[param_00])) {
      continue;
    }

    var_04 = var_03.v[param_00];
    var_01[var_04] = 1;
  }

  foreach(var_04, var_07 in var_01) {
    foreach(var_09, var_03 in level.createfxent) {
      if(index_is_selected(var_09)) {
        continue;
      }

      if(!isDefined(var_03.v[param_00])) {
        continue;
      }

      if(var_03.v[param_00] != var_04) {
        continue;
      }

      select_entity(var_09, var_03);
    }
  }

  update_selected_ents();
}

func_838C(param_00) {
  var_01 = [];
  foreach(var_03 in level._createfx.selected_fx_ents) {
    if(!isDefined(var_03.v[param_00]) || var_03.v["type"] != "oneshotfx") {
      continue;
    }

    var_04 = var_03.v[param_00];
    var_01[var_04] = 1;
  }

  foreach(var_04, var_07 in var_01) {
    foreach(var_09, var_03 in level.createfxent) {
      if(index_is_selected(var_09)) {
        continue;
      }

      if(!isDefined(var_03.v[param_00])) {
        continue;
      }

      if(var_03.v[param_00] != var_04) {
        continue;
      }

      select_entity(var_09, var_03);
    }
  }

  update_selected_ents();
}

copy_ents() {
  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }

  var_00 = [];
  for(var_01 = 0; var_01 < level._createfx.selected_fx_ents.size; var_01++) {
    var_02 = level._createfx.selected_fx_ents[var_01];
    var_03 = spawnStruct();
    var_03.v = var_02.v;
    var_03 post_entity_creation_function();
    var_00[var_00.size] = var_03;
  }

  level.stored_ents = var_00;
}

post_entity_creation_function() {
  self.textalpha = 0;
  self.drawn = 1;
}

paste_ents() {
  if(!isDefined(level.stored_ents)) {
    return;
  }

  clear_entity_selection();
  for(var_00 = 0; var_00 < level.stored_ents.size; var_00++) {
    func_08FE(level.stored_ents[var_00]);
  }

  move_selection_to_cursor();
  update_selected_ents();
  level.stored_ents = [];
  copy_ents();
}

func_08FE(param_00) {
  level.createfxent[level.createfxent.size] = param_00;
  select_last_entity();
}

get_center_of_array(param_00) {
  var_01 = (0, 0, 0);
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_01 = (var_01[0] + param_00[var_02].v["origin"][0], var_01[1] + param_00[var_02].v["origin"][1], var_01[2] + param_00[var_02].v["origin"][2]);
  }

  return (var_01[0] / param_00.size, var_01[1] / param_00.size, var_01[2] / param_00.size);
}

get_radius_of_array(param_00) {
  var_01 = param_00[0].v["origin"];
  var_02 = param_00[0].v["origin"];
  var_03 = var_01[0];
  var_04 = var_01[1];
  var_05 = var_01[2];
  var_06 = var_02[0];
  var_07 = var_02[1];
  var_08 = var_02[2];
  for(var_09 = 0; var_09 < param_00.size; var_09++) {
    var_0A = param_00[var_09].v["origin"];
    if(var_0A[0] < var_01[0]) {
      var_03 = var_0A[0];
    }

    if(var_0A[0] > var_02[0]) {
      var_06 = var_0A[0];
    }

    if(var_0A[1] < var_01[1]) {
      var_04 = var_0A[1];
    }

    if(var_0A[1] > var_02[1]) {
      var_07 = var_0A[1];
    }

    if(var_0A[2] < var_01[2]) {
      var_05 = var_0A[2];
    }

    if(var_0A[2] > var_02[2]) {
      var_08 = var_0A[2];
    }
  }

  var_01 = (var_03, var_04, var_05);
  var_02 = (var_06, var_07, var_08);
  var_0B = distance(var_02, var_01);
  return var_0B;
}

ent_draw_axis() {
  self endon("death");
  for(;;) {
    draw_axis();
    wait 0.05;
  }
}

rotation_is_occuring() {
  if(level.selectedrotate_roll != 0) {
    return 1;
  }

  if(level.selectedrotate_pitch != 0) {
    return 1;
  }

  return level.selectedrotate_yaw != 0;
}

print_fx_options(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < level._createfx.options.size; var_03++) {
    var_04 = level._createfx.options[var_03];
    if(isDefined(var_04["nowrite"]) && var_04["nowrite"]) {
      continue;
    }

    var_05 = var_04["name"];
    if(!isDefined(param_00.v[var_05])) {
      continue;
    }

    if(!common_scripts\_createfxmenu::mask(var_04["mask"], param_00.v["type"])) {
      continue;
    }

    if(!level.mp_createfx) {
      if(common_scripts\_createfxmenu::mask("fx", param_00.v["type"]) && var_05 == "fxid") {
        continue;
      }

      if(param_00.v["type"] == "exploder" && var_05 == "exploder") {
        continue;
      }

      var_06 = param_00.v["type"] + "/" + var_05;
      if(isDefined(level._createfx.defaults[var_06]) && level._createfx.defaults[var_06] == param_00.v[var_05]) {
        continue;
      }
    }

    if(var_04["type"] == "string") {
      var_07 = param_00.v[var_05] + "";
      if(var_07 == "nil") {
        continue;
      }

      if(var_05 == "platform" && var_07 == "all") {
        continue;
      }

      cfxprintln(param_01 + "ent.v[ \" + var_05 + "\" ] = \" + param_00.v[var_05] + "\";");
      continue;
    }

    cfxprintln(param_01 + "ent.v[ \" + var_05 + "\" ] = " + param_00.v[var_05] + ";");
  }
}

entity_highlight_disable() {
  self notify("highlight change");
  self endon("highlight change");
  for(;;) {
    self.textalpha = self.textalpha * 0.85;
    self.textalpha = self.textalpha - 0.05;
    if(self.textalpha < 0) {
      break;
    }

    wait 0.05;
  }

  self.textalpha = 0;
}

entity_highlight_enable() {
  self notify("highlight change");
  self endon("highlight change");
  for(;;) {
    self.textalpha = self.textalpha + 0.05;
    self.textalpha = self.textalpha * 1.25;
    if(self.textalpha > 1) {
      break;
    }

    wait 0.05;
  }

  self.textalpha = 1;
}

clear_settable_fx() {
  level.createfx_inputlocked = 0;
  level._createfx.selected_fx_option_index = undefined;
  reset_fx_hud_colors();
}

reset_fx_hud_colors() {
  for(var_00 = 0; var_00 < level._createfx.hudelem_count; var_00++) {
    level._createfx.hudelems[var_00].color = (1, 1, 1);
  }
}

toggle_entity_selection(param_00, param_01) {
  if(isDefined(level._createfx.selected_fx[param_00])) {
    deselect_entity(param_00, param_01);
    return;
  }

  select_entity(param_00, param_01);
}

select_entity(param_00, param_01) {
  if(isDefined(level._createfx.selected_fx[param_00])) {
    return;
  }

  clear_settable_fx();
  level notify("new_ent_selection");
  param_01 thread entity_highlight_enable();
  level._createfx.selected_fx[param_00] = 1;
  level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = param_01;
  level.createfx_menu_list_active = 0;
}

ent_is_highlighted(param_00) {
  if(!isDefined(level.fx_highlightedent)) {
    return 0;
  }

  return param_00 == level.fx_highlightedent;
}

deselect_entity(param_00, param_01) {
  if(!isDefined(level._createfx.selected_fx[param_00])) {
    return;
  }

  clear_settable_fx();
  level notify("new_ent_selection");
  level._createfx.selected_fx[param_00] = undefined;
  if(!ent_is_highlighted(param_01)) {
    param_01 thread entity_highlight_disable();
  }

  var_02 = [];
  for(var_03 = 0; var_03 < level._createfx.selected_fx_ents.size; var_03++) {
    if(level._createfx.selected_fx_ents[var_03] != param_01) {
      var_02[var_02.size] = level._createfx.selected_fx_ents[var_03];
    }
  }

  level._createfx.selected_fx_ents = var_02;
}

index_is_selected(param_00) {
  return isDefined(level._createfx.selected_fx[param_00]);
}

ent_is_selected(param_00) {
  for(var_01 = 0; var_01 < level._createfx.selected_fx_ents.size; var_01++) {
    if(level._createfx.selected_fx_ents[var_01] == param_00) {
      return 1;
    }
  }

  return 0;
}

clear_entity_selection() {
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    if(!ent_is_highlighted(level._createfx.selected_fx_ents[var_00])) {
      level._createfx.selected_fx_ents[var_00] thread entity_highlight_disable();
    }
  }

  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
}

draw_axis() {}

draw_cross() {}

createfx_centerprint(param_00) {
  thread createfx_centerprint_thread(param_00);
}

createfx_centerprint_thread(param_00) {
  level notify("new_createfx_centerprint");
  level endon("new_createfx_centerprint");
  wait(4.5);
}

get_selected_move_vector() {
  var_00 = level.player getplayerangles()[1];
  var_01 = (0, var_00, 0);
  var_02 = anglestoright(var_01);
  var_03 = anglesToForward(var_01);
  var_04 = anglestoup(var_01);
  var_05 = 0;
  var_06 = level._createfx.rate;
  if(buttondown("DPAD_UP")) {
    if(level.selectedmove_forward < 0) {
      level.selectedmove_forward = 0;
    }

    level.selectedmove_forward = level.selectedmove_forward + var_06;
  } else if(buttondown("DPAD_DOWN")) {
    if(level.selectedmove_forward > 0) {
      level.selectedmove_forward = 0;
    }

    level.selectedmove_forward = level.selectedmove_forward - var_06;
  } else {
    level.selectedmove_forward = 0;
  }

  if(buttondown("DPAD_RIGHT")) {
    if(level.selectedmove_right < 0) {
      level.selectedmove_right = 0;
    }

    level.selectedmove_right = level.selectedmove_right + var_06;
  } else if(buttondown("DPAD_LEFT")) {
    if(level.selectedmove_right > 0) {
      level.selectedmove_right = 0;
    }

    level.selectedmove_right = level.selectedmove_right - var_06;
  } else {
    level.selectedmove_right = 0;
  }

  if(buttondown("BUTTON_Y")) {
    if(level.selectedmove_up < 0) {
      level.selectedmove_up = 0;
    }

    level.selectedmove_up = level.selectedmove_up + var_06;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedmove_up > 0) {
      level.selectedmove_up = 0;
    }

    level.selectedmove_up = level.selectedmove_up - var_06;
  } else {
    level.selectedmove_up = 0;
  }

  var_07 = (0, 0, 0);
  var_07 = var_07 + var_03 * level.selectedmove_forward;
  var_07 = var_07 + var_02 * level.selectedmove_right;
  var_07 = var_07 + var_04 * level.selectedmove_up;
  return var_07;
}

set_anglemod_move_vector() {
  if(!level._createfx.snap90deg) {
    var_00 = level._createfx.rate;
  } else {
    var_00 = 90;
  }

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedrotate_pitch < 0) {
      level.selectedrotate_pitch = 0;
    }

    level.selectedrotate_pitch = level.selectedrotate_pitch + var_00;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedrotate_pitch > 0) {
      level.selectedrotate_pitch = 0;
    }

    level.selectedrotate_pitch = level.selectedrotate_pitch - var_00;
  } else {
    level.selectedrotate_pitch = 0;
  }

  if(buttondown("DPAD_LEFT")) {
    if(level.selectedrotate_yaw < 0) {
      level.selectedrotate_yaw = 0;
    }

    level.selectedrotate_yaw = level.selectedrotate_yaw + var_00;
  } else if(buttondown("DPAD_RIGHT")) {
    if(level.selectedrotate_yaw > 0) {
      level.selectedrotate_yaw = 0;
    }

    level.selectedrotate_yaw = level.selectedrotate_yaw - var_00;
  } else {
    level.selectedrotate_yaw = 0;
  }

  if(buttondown("BUTTON_Y")) {
    if(level.selectedrotate_roll < 0) {
      level.selectedrotate_roll = 0;
    }

    level.selectedrotate_roll = level.selectedrotate_roll + var_00;
    return;
  }

  if(buttondown("BUTTON_B")) {
    if(level.selectedrotate_roll > 0) {
      level.selectedrotate_roll = 0;
    }

    level.selectedrotate_roll = level.selectedrotate_roll - var_00;
    return;
  }

  level.selectedrotate_roll = 0;
}

update_selected_ents() {
  var_00 = 0;
  foreach(var_02 in level._createfx.selected_fx_ents) {
    if(var_02.v["type"] == "reactive_fx") {
      var_00 = 1;
    }

    var_02[[level.func_updatefx]]();
  }

  if(var_00) {
    refresh_reactive_fx_ents();
  }
}

stop_fx_looper() {
  if(isDefined(self.looper)) {
    self.looper delete();
  }

  stop_loopsound();
}

stop_loopsound() {
  self notify("stop_loop");
  common_scripts\utility::func_3F51();
}

func_get_level_fx() {
  if(!isDefined(level._effect_keys)) {
    var_00 = getarraykeys(level._effect);
  } else {
    var_00 = getarraykeys(level._effect);
    if(var_00.size == level._effect_keys.size) {
      return level._effect_keys;
    }
  }

  var_00 = common_scripts\utility::alphabetize(var_00);
  level._effect_keys = var_00;
  return var_00;
}

restart_fx_looper() {
  stop_fx_looper();
  set_forward_and_up_vectors();
  switch (self.v["type"]) {
    case "loopfx":
      common_scripts\_fx::create_looper();
      break;

    case "oneshotfx":
      common_scripts\_fx::create_triggerfx();
      break;

    case "soundfx":
      common_scripts\_fx::create_loopsound();
      break;

    case "soundfx_interval":
      common_scripts\_fx::create_interval_sound();
      break;

    case "soundfx_dynamic":
      common_scripts\_fx::create_dynamicambience();
      break;
  }
}

refresh_reactive_fx_ents() {
  level._fx.reactive_fx_ents = undefined;
  foreach(var_01 in level.createfxent) {
    if(var_01.v["type"] == "reactive_fx") {
      var_01 set_forward_and_up_vectors();
      var_01 common_scripts\_fx::add_reactive_fx();
    }
  }
}

process_fx_rotater() {
  if(level.fx_rotating) {
    thread save_undo_buffer();
    level.createfx_last_movement_timer = 0;
    return;
  }

  set_anglemod_move_vector();
  if(!rotation_is_occuring()) {
    return;
  }

  level.fx_rotating = 1;
  if(level._createfx.selected_fx_ents.size > 1 && !level._createfx.localrot) {
    var_00 = get_center_of_array(level._createfx.selected_fx_ents);
    var_01 = spawn("script_origin", var_00);
    var_01.v["angles"] = level._createfx.selected_fx_ents[0].v["angles"];
    var_01.v["origin"] = var_00;
    var_02 = [];
    for(var_03 = 0; var_03 < level._createfx.selected_fx_ents.size; var_03++) {
      var_02[var_03] = spawn("script_origin", level._createfx.selected_fx_ents[var_03].v["origin"]);
      var_02[var_03].angles = level._createfx.selected_fx_ents[var_03].v["angles"];
      var_02[var_03] linktosynchronizedparent(var_01);
    }

    rotate_over_time(var_01, var_02);
    var_01 delete();
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      var_02[var_03] delete();
    }
  } else if(level._createfx.selected_fx_ents.size > 0) {
    foreach(var_05 in level._createfx.selected_fx_ents) {
      var_02 = spawn("script_origin", (0, 0, 0));
      var_02.angles = var_05.v["angles"];
      if(level.selectedrotate_pitch != 0) {
        var_02 addpitch(level.selectedrotate_pitch);
      } else if(level.selectedrotate_yaw != 0) {
        var_02 addyaw(level.selectedrotate_yaw);
      } else {
        var_02 addroll(level.selectedrotate_roll);
      }

      var_05.v["angles"] = var_02.angles;
      var_02 delete();
    }

    wait 0.05;
  }

  level.fx_rotating = 0;
}

spawn_grenade() {
  playFX(level._createfx.var_B1.fx, level.createfxcursor["position"]);
  level._createfx.var_B1 playSound(level._createfx.var_B1.sound);
  radiusdamage(level.createfxcursor["position"], level._createfx.var_B1.radius, 50, 5, undefined, "MOD_EXPLOSIVE");
  level notify("code_damageradius", undefined, level._createfx.var_B1.radius, level.createfxcursor["position"]);
}

show_help() {
  if(level.createfx_help_active == 1) {
    clear_fx_hudelements();
    level.createfx_help_active = 0;
    level.createfx_menu_list_active = 0;
    reselect_entities();
  } else {
    level.createfx_help_active = 1;
    level.createfx_menu_list_active = 1;
    common_scripts\_createfxmenu::draw_help_list();
    thread common_scripts\_createfxmenu::help_navigation_buttons();
    clear_tool_hud();
  }

  wait(0.2);
}

generate_fx_log(param_00) {}

write_entity(param_00, param_01) {
  var_02 = "\t";
  if(getdvarint("scr_map_exploder_dump")) {
    if(!isDefined(param_00.model)) {
      return;
    }
  } else if(isDefined(param_00.model)) {
    return;
  }

  if(param_00.v["type"] == "loopfx") {
    cfxprintln(var_02 + "ent = createLoopEffect( \" + param_00.v["fxid "] + "\" );");
  }

  if(param_00.v["type"] == "oneshotfx") {
    cfxprintln(var_02 + "ent = createOneshotEffect( \" + param_00.v["fxid "] + "\" );");
  }

  if(param_00.v["type"] == "exploder") {
    if(isDefined(param_00.v["exploder"]) && !level.mp_createfx) {
      cfxprintln(var_02 + "ent = createExploderEx( \" + param_00.v["fxid "] + "\", \" + param_00.v["exploder "] + "\" );");
    } else {
      cfxprintln(var_02 + "ent = createExploder( \" + param_00.v["fxid "] + "\" );");
    }
  }

  if(param_00.v["type"] == "soundfx") {
    cfxprintln(var_02 + "ent = createLoopSound();");
  }

  if(param_00.v["type"] == "soundfx_interval") {
    cfxprintln(var_02 + "ent = createIntervalSound();");
  }

  if(param_00.v["type"] == "reactive_fx") {
    cfxprintln(var_02 + "ent = createReactiveEnt();");
  }

  if(param_00.v["type"] == "soundfx_dynamic") {
    cfxprintln(var_02 + "ent = createDynamicAmbience();");
  }

  cfxprintln(var_02 + "ent set_origin_and_angles( " + param_00.v["origin"] + ", " + param_00.v["angles"] + " );");
  print_fx_options(param_00, var_02, param_01);
  cfxprintln("");
}

write_log(param_00, param_01, param_02, param_03, param_04) {
  var_05 = "\t";
  cfxprintlnstart();
  cfxprintln("cfxprintln(\"#include common_scripts\\utility;");
  cfxprintln("#include common_scripts\\_createfx;\n");
  cfxprintln("");
  cfxprintln("main()");
  cfxprintln("{");
  var_06 = param_00.size;
  if(isDefined(param_04)) {
    var_07 = 0;
    foreach(var_09 in param_04) {
      if(!isDefined(var_09["radiant"])) {
        var_07++;
      }
    }

    var_06 = var_06 + var_07;
  }

  cfxprintln(var_05 + "foreach(var_0C in param_00) {
    if(level.createfx_loopcounter > 16) {
      level.createfx_loopcounter = 0;
      wait(0.1);
    }

    level.createfx_loopcounter++; write_entity(var_0C, param_02);
  }

  if(isDefined(param_04)) {
    foreach(var_09 in param_04) {
      if(level.createfx_loopcounter > 16) {
        level.createfx_loopcounter = 0;
        wait(0.1);
      }

      if(!isDefined(var_09["radiant"])) {
        level.createfx_loopcounter++;
        var_0C = spawnStruct();
        var_0C.v = var_09;
        write_entity(var_0C, param_02);
      }
    }
  }

  cfxprintln("}");
  cfxprintln(" ");
  cfxprintlnend(param_02, param_03, param_01);
}

createfx_adjust_array() {
  var_00 = 0.1;
  foreach(var_02 in level.createfxent) {
    var_03 = [];
    var_04 = [];
    for(var_05 = 0; var_05 < 3; var_05++) {
      var_03[var_05] = var_02.v["origin"][var_05];
      var_04[var_05] = var_02.v["angles"][var_05];
      if(var_03[var_05] < var_00 && var_03[var_05] > var_00 * -1) {
        var_03[var_05] = 0;
      }

      if(var_04[var_05] < var_00 && var_04[var_05] > var_00 * -1) {
        var_04[var_05] = 0;
      }
    }

    var_02.v["origin"] = (var_03[0], var_03[1], var_03[2]);
    var_02.v["angles"] = (var_04[0], var_04[1], var_04[2]);
  }
}

get_createfx_array(param_00) {
  var_01 = get_createfx_types(param_00);
  var_02 = [];
  foreach(var_05, var_04 in var_01) {
    var_02[var_05] = [];
  }

  foreach(var_07 in level.createfxent) {
    var_08 = 0;
    foreach(var_05, param_00 in var_01) {
      if(var_07.v["type"] != param_00) {
        continue;
      }

      var_08 = 1;
      var_02[var_05][var_02[var_05].size] = var_07;
      break;
    }
  }

  var_0B = [];
  for(var_0C = 0; var_0C < var_01.size; var_0C++) {
    foreach(var_07 in var_02[var_0C]) {
      var_0B[var_0B.size] = var_07;
    }
  }

  return var_0B;
}

get_createfx_types(param_00) {
  var_01 = [];
  if(param_00 == "fx") {
    var_01[0] = "loopfx";
    var_01[1] = "oneshotfx";
    var_01[2] = "exploder";
  } else {
    var_01[0] = "soundfx";
    var_01[1] = "soundfx_interval";
    var_01[2] = "reactive_fx";
    var_01[3] = "soundfx_dynamic";
  }

  return var_01;
}

is_createfx_type(param_00, param_01) {
  var_02 = get_createfx_types(param_01);
  foreach(var_04 in var_02) {
    if(param_00.v["type"] == var_04) {
      return 1;
    }
  }

  return 0;
}

createfx_filter_types() {
  var_00 = [];
  var_00[0] = "soundfx";
  var_00[1] = "loopfx";
  var_00[2] = "oneshotfx";
  var_00[3] = "exploder";
  var_00[4] = "soundfx_interval";
  var_00[5] = "reactive_fx";
  var_00[6] = "soundfx_dynamic";
  var_01 = [];
  foreach(var_04, var_03 in var_00) {
    var_01[var_04] = [];
  }

  foreach(var_06 in level.createfxent) {
    var_07 = 0;
    foreach(var_04, var_09 in var_00) {
      if(var_06.v["type"] != var_09) {
        continue;
      }

      var_07 = 1;
      var_01[var_04][var_01[var_04].size] = var_06;
      break;
    }
  }

  var_0B = [];
  for(var_0C = 0; var_0C < var_00.size; var_0C++) {
    foreach(var_06 in var_01[var_0C]) {
      var_0B[var_0B.size] = var_06;
    }
  }

  level.createfxent = var_0B;
}

cfxprintlnstart() {
  common_scripts\utility:: fileprint_launcher_start_file();
}

cfxprintln(param_00) {
  common_scripts\utility:: fileprint_launcher(param_00);
}

cfxprintlnend(param_00, param_01, param_02) {
  var_03 = 1;
  if(param_01 != "" || param_00) {
    var_03 = 0;
  }

  if(common_scripts\utility::issp()) {
    var_04 = common_scripts\utility::get_template_level() + param_01 + "_" + param_02 + ".gsc";
    if(param_00) {
      var_04 = "backup_" + param_02 + ".gsc";
    }
  } else {
    var_04 = common_scripts\utility::get_template_level() + param_02 + "_" + var_03 + ".gsc";
    if(param_00) {
      var_04 = "backup.gsc";
    }
  }

  common_scripts\utility:: fileprint_launcher_end_file("/share/raw/maps/createfx/" + var_04,var_03);
}

process_button_held_and_clicked() {
  func_0905("mouse1");
  func_0905("BUTTON_RSHLDR");
  func_0905("BUTTON_LSHLDR");
  func_0905("BUTTON_RSTICK");
  func_0905("BUTTON_LSTICK");
  func_0905("BUTTON_A");
  func_0905("BUTTON_B");
  func_0905("BUTTON_X");
  func_0905("BUTTON_Y");
  func_0905("DPAD_UP");
  func_0905("DPAD_LEFT");
  func_0905("DPAD_RIGHT");
  func_0905("DPAD_DOWN");
  func_0938("shift");
  func_0938("ctrl");
  func_0938("escape");
  func_0938("F1");
  func_0938("F5");
  func_0938("F4");
  func_0938("F2");
  func_0938("a");
  func_0938("b");
  func_0938("g");
  func_0938("c");
  func_0938("h");
  func_0938("i");
  func_0938("j");
  func_0938("f");
  func_0938("k");
  func_0938("l");
  func_0938("m");
  func_0938("o");
  func_0938("p");
  func_0938("r");
  func_0938("s");
  func_0938("u");
  func_0938("v");
  func_0938("x");
  func_0938("y");
  func_0938("z");
  func_0938("del");
  func_0938("end");
  func_0938("tab");
  func_0938("ins");
  func_0938("add");
  func_0938("space");
  func_0938("enter");
  func_0938("1");
  func_0938("2");
  func_0938("3");
  func_0938("4");
  func_0938("5");
  func_0938("6");
  func_0938("7");
  func_0938("8");
  func_0938("9");
  func_0938("0");
  func_0938("-");
  func_0938("=");
  func_0938(",");
  func_0938(".");
  func_0938("[");
  func_0938("]");
  func_0938("leftarrow");
  func_0938("rightarrow");
  func_0938("uparrow");
  func_0938("downarrow");
}

locked(param_00) {
  if(isDefined(level._createfx.lockedlist[param_00])) {
    return 0;
  }

  return kb_locked(param_00);
}

kb_locked(param_00) {
  return level.createfx_inputlocked && isDefined(level.button_is_kb[param_00]);
}

func_0905(param_00) {
  if(locked(param_00)) {
    return;
  }

  if(!isDefined(level.buttonisheld[param_00])) {
    if(level.player buttonpresseddevonly(param_00)) {
      level.buttonisheld[param_00] = 1;
      level.buttonclick[param_00] = 1;
      return;
    }

    return;
  }

  if(!level.player buttonpresseddevonly(param_00)) {
    level.buttonisheld[param_00] = undefined;
  }
}

func_0938(param_00) {
  level.button_is_kb[param_00] = 1;
  func_0905(param_00);
}

buttondown(param_00, param_01) {
  return buttonpressed_internal(param_00) || buttonpressed_internal(param_01);
}

buttonpressed_internal(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(kb_locked(param_00)) {
    return 0;
  }

  return level.player buttonpresseddevonly(param_00);
}

button_is_held(param_00, param_01) {
  if(isDefined(param_01)) {
    if(isDefined(level.buttonisheld[param_01])) {
      return 1;
    }
  }

  return isDefined(level.buttonisheld[param_00]);
}

button_is_clicked(param_00, param_01) {
  if(isDefined(param_01)) {
    if(isDefined(level.buttonclick[param_01])) {
      return 1;
    }
  }

  return isDefined(level.buttonclick[param_00]);
}

init_huds() {
  level._createfx.hudelems = [];
  level._createfx.hudelem_count = 20;
  level.cleartextmarker = newhudelem();
  level.cleartextmarker.alpha = 0;
  for(var_00 = 0; var_00 < level._createfx.hudelem_count; var_00++) {
    var_01 = newhudelem();
    var_01.alignx = "left";
    var_01.location = 0;
    var_01.foreground = 1;
    var_01.fontscale = 1.4;
    var_01.sort = 20;
    var_01.alpha = 1;
    var_01.y = 60 + var_00 * 15;
    level._createfx.hudelems[var_00] = var_01;
  }

  var_01 = newhudelem();
  var_01.alignx = "center";
  var_01.location = 0;
  var_01.foreground = 1;
  var_01.fontscale = 1.4;
  var_01.sort = 20;
  var_01.alpha = 1;
  var_01.color = (1, 1, 0);
  var_01.x = 320;
  var_01.y = 240;
  level.createfx_centerprint = var_01;
}

init_crosshair() {
  var_00 = newhudelem();
  var_00.location = 0;
  var_00.alignx = "center";
  var_00.aligny = "middle";
  var_00.foreground = 1;
  var_00.fontscale = 2;
  var_00.sort = 20;
  var_00.alpha = 1;
  var_00.x = 320;
  var_00.y = 233;
}

clear_fx_hudelements() {
  level.cleartextmarker clearalltextafterhudelem();
  for(var_00 = 0; var_00 < level._createfx.hudelem_count; var_00++) {}

  level.fxhudelements = 0;
}

set_fx_hudelement(param_00) {
  level.fxhudelements++;
}

init_tools_hud() {
  if(!isDefined(level._createfx.tool_hudelems)) {
    level._createfx.tool_hudelems = [];
  }

  if(!isDefined(level._createfx.tool_hud_visible)) {
    level._createfx.tool_hud_visible = 1;
  }

  if(!isDefined(level._createfx.tool_hud)) {
    level._createfx.tool_hud = "";
  }
}

new_tool_hud(param_00) {
  foreach(var_03, var_02 in level._createfx.tool_hudelems) {
    if(isDefined(var_02.value_hudelem)) {
      var_02.value_hudelem destroy();
    }

    var_02 destroy();
    level._createfx.tool_hudelems[var_03] = undefined;
  }

  level._createfx.tool_hud = param_00;
}

current_mode_hud(param_00) {
  return level._createfx.tool_hud == param_00;
}

clear_tool_hud() {
  new_tool_hud("");
}

new_tool_hudelem(param_00) {
  var_01 = newhudelem();
  var_01.alignx = "left";
  var_01.location = 0;
  var_01.foreground = 1;
  var_01.fontscale = 1.2;
  var_01.alpha = 1;
  var_01.x = 0;
  var_01.y = 320 + param_00 * 15;
  return var_01;
}

get_tool_hudelem(param_00) {
  if(isDefined(level._createfx.tool_hudelems[param_00])) {
    return level._createfx.tool_hudelems[param_00];
  }

  return undefined;
}

set_tool_hudelem(param_00, param_01, param_02) {
  var_03 = get_tool_hudelem(param_00);
  if(!isDefined(var_03)) {
    var_03 = new_tool_hudelem(level._createfx.tool_hudelems.size);
    level._createfx.tool_hudelems[param_00] = var_03;
    var_03.text = param_00;
  }

  if(isDefined(param_01)) {
    if(!isDefined(param_02)) {
      param_02 = (1, 1, 1);
    }

    var_03.color = param_02;
  }
}

select_by_substring() {
  var_00 = getDvar("select_by_substring");
  if(var_00 == "") {
    return 0;
  }

  setDvar("select_by_substring", "");
  var_01 = [];
  foreach(var_04, var_03 in level.createfxent) {
    if(issubstr(var_03.v["fxid"], var_00)) {
      var_01[var_01.size] = var_04;
    }
  }

  if(var_01.size == 0) {
    return 0;
  }

  deselect_all_ents();
  select_index_array(var_01);
  foreach(var_06 in var_01) {
    var_03 = level.createfxent[var_06];
    select_entity(var_06, var_03);
  }

  return 1;
}

select_index_array(param_00) {
  foreach(var_02 in param_00) {
    var_03 = level.createfxent[var_02];
    select_entity(var_02, var_03);
  }
}

deselect_all_ents() {
  foreach(var_01 in level._createfx.selected_fx_ents) {
    var_02 = func_44C7(var_01);
    deselect_entity(var_02, var_01);
  }
}

setup_last_movement_timer() {
  wait(0.5);
  for(;;) {
    level.createfx_last_movement_timer = level.createfx_last_movement_timer + 0.05;
    if(level.createfx_last_movement_timer == 0.15) {
      foreach(var_01 in level._createfx.selected_fx_ents) {
        if(var_01.v["type"] == "exploder") {
          var_01 common_scripts\utility::activate_individual_exploder();
        }
      }

      common_scripts\_createfxmenu::display_current_translations();
      save_redo_buffer();
    }

    if(level.createfx_last_movement_timer == 0.05) {
      var_01 = common_scripts\_createfxmenu::get_last_selected_ent();
      common_scripts\_createfxmenu::display_current_translations();
    }

    wait 0.05;
  }
}

frame_selected() {
  if(level._createfx.selected_fx_ents.size < 1) {
    return;
  }

  if(level._createfx.selected_fx_ents.size > 1) {
    var_00 = get_center_of_array(level._createfx.selected_fx_ents);
    var_01 = get_radius_of_array(level._createfx.selected_fx_ents) + 200;
  } else {
    var_00 = level._createfx.selected_fx_ents[0].v["origin"];
    var_01 = 200;
  }

  var_02 = anglesToForward(level.player getplayerangles());
  var_03 = var_02 * -1 * var_01;
  var_04 = level.player getEye();
  var_05 = var_04 - level.player.origin;
  level.player setOrigin(var_00 + var_03 - var_05);
}

func_5984(param_00) {
  if(level._createfx.selected_fx_ents.size < 1) {
    return;
  }

  var_01 = "fxid";
  if(level._createfx.selected_fx_ents[0].v["fxid"] == "No FX" && level._createfx.selected_fx_ents[0].v["soundalias"] != "null") {
    var_01 = "soundalias";
  }

  var_02 = level._createfx.selected_fx_ents[0].v[var_01];
  var_03 = [];
  foreach(var_06, var_05 in level.createfxent) {
    if(isDefined(var_05.v[var_01]) && issubstr(var_05.v[var_01], var_02)) {
      if(var_01 == "soundalias") {
        if(var_05.v["type"] == "soundfx_interval" || var_05.v["type"] == "soundfx") {
          var_03[var_03.size] = var_06;
        }

        continue;
      }

      var_03[var_03.size] = var_06;
    }
  }

  var_07 = 0;
  if(var_03.size > 1) {
    for(var_06 = 0; var_06 < var_03.size; var_06++) {
      if(level.createfxent[var_03[var_06]] == level._createfx.selected_fx_ents[0]) {
        var_07 = var_06;
      }
    }

    if(var_07 >= var_03.size - 1 && param_00 == "next") {
      var_08 = var_03[0];
    } else if(var_08 == 0 && var_01 == "prev") {
      var_08 = var_04[var_04.size - 1];
    } else if(var_01 == "next") {
      var_08 = var_04[var_08 + 1];
    } else {
      var_08 = var_04[var_08 - 1];
    }

    deselect_all_ents();
    select_entity(var_08, level.createfxent[var_08]);
    frame_selected();
  }
}

clear_all_loopers() {
  foreach(var_01 in level.createfxent) {
    if(isDefined(var_01.looper)) {
      var_01.looper delete();
    }

    var_01 stop_loopsound();
  }
}

restart_oneshots() {
  foreach(var_01 in level.createfxent) {
    if(var_01.v["type"] == "oneshotfx") {
      var_01 restart_fx_looper();
    }
  }
}

restart_selected_exploders() {
  foreach(var_01 in level._createfx.selected_fx_ents) {
    if(isDefined(var_01) && var_01.v["type"] == "exploder") {
      var_01 common_scripts\utility::activate_individual_exploder();
    }
  }
}

save_undo_buffer() {
  if(isDefined(level.createfxent) && level.createfx_last_movement_timer > 0.15) {
    level.createfxent_redo = copystructarrayvalues(level.createfxent);
  }
}

save_redo_buffer() {
  if(isDefined(level.createfxent)) {
    level.var_2805 = copystructarrayvalues(level.createfxent);
  }
}

undo() {
  if(isDefined(level.createfxent_redo)) {
    clear_all_loopers();
    level.createfxent = [];
    level.createfxent = copystructarrayvalues(level.createfxent_redo);
    clear_fx_hudelements();
    reselect_entities();
    restart_oneshots();
    restart_selected_exploders();
  }
}

redo() {
  if(isDefined(level.var_2805)) {
    clear_all_loopers();
    level.createfxent = [];
    level.createfxent = copystructarrayvalues(level.var_2805);
    clear_fx_hudelements();
    reselect_entities();
    restart_oneshots();
    restart_selected_exploders();
  }
}

copystructarrayvalues(param_00) {
  var_01 = [];
  if(param_00.size > 0) {
    for(var_02 = 0; var_02 < param_00.size; var_02++) {
      var_03 = spawnStruct();
      if(isDefined(param_00[var_02].v)) {
        var_03.v = [];
        var_03.v["type"] = param_00[var_02].v["type"];
        var_03.v["fxid"] = param_00[var_02].v["fxid"];
        var_03.v["soundalias"] = param_00[var_02].v["soundalias"];
        var_03.v["loopsound"] = param_00[var_02].v["loopsound"];
        var_03.v["angles"] = param_00[var_02].v["angles"];
        var_03.v["origin"] = param_00[var_02].v["origin"];
        var_03.v["exploder"] = param_00[var_02].v["exploder"];
        var_03.v["flag"] = param_00[var_02].v["flag"];
        var_03.v["exploder_type"] = param_00[var_02].v["exploder_type"];
        var_03.v["server_culled"] = param_00[var_02].v["server_culled"];
        var_03.v["delay_min"] = param_00[var_02].v["delay_min"];
        var_03.v["delay_max"] = param_00[var_02].v["delay_max"];
        var_03.v["delay"] = param_00[var_02].v["delay"];
        var_03.v["forward"] = param_00[var_02].v["forward"];
        var_03.v["up"] = param_00[var_02].v["up"];
        var_01[var_02] = var_03;
      }

      var_01[var_02].drawn = param_00[var_02].drawn;
      var_01[var_02].textalpha = param_00[var_02].textalpha;
    }
  }

  return var_01;
}

removefxentwithentity(param_00) {
  var_01 = [];
  foreach(var_03 in level.createfxent) {
    if(isDefined(var_03.model) && var_03.model == param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  level.createfxent = var_01;
}

func_44C7(param_00) {
  for(var_01 = 0; var_01 < level.createfxent.size; var_01++) {
    if(param_00 == level.createfxent[var_01]) {
      return var_01;
    }
  }
}

func_55E9(param_00) {
  var_01 = level.var_5FEB - (32768, 32768, 32768);
  var_02 = level.var_5FEB + (32768, 32768, 32768);
  var_03 = param_00[0] > var_01[0] && param_00[0] < var_02[0];
  var_04 = param_00[1] > var_01[1] && param_00[1] < var_02[1];
  var_05 = param_00[2] > var_01[2] && param_00[2] < var_02[2];
  if(var_03 && var_04 && var_05) {
    return 1;
  }

  return 0;
}

func_0646() {
  wait(0.25);
  level._createfx.selected_fx_ents = [];
  for(var_00 = 0; var_00 < level.createfxent.size; var_00++) {
    var_01 = level.createfxent[var_00];
    if(isDefined(var_01.v["type"]) == 0) {
      continue;
    }

    if(var_01.v["type"] == "soundfx") {
      level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = var_01;
    }
  }

  update_selected_ents();
  level._createfx.selected_fx_ents = [];
}