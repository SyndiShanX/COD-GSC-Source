/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\common\createfx.gsc
***************************************/

createeffect(param_00, param_01) {
  var_02 = spawnStruct();
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = var_02;
  var_02.v = [];
  var_02.v["type"] = param_00;
  var_02.v["fxid"] = param_01;
  var_02.v["angles"] = (0, 0, 0);
  var_02.v["origin"] = (0, 0, 0);
  return var_02;
}

getloopeffectdelaydefault() {
  return 0.5;
}

getoneshoteffectdelaydefault() {
  return -4;
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
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = var_00;
  var_00.v = [];
  var_00.v["type"] = "soundfx";
  var_00.v["fxid"] = "No FX";
  var_00.v["soundalias"] = "nil";
  var_00.v["angles"] = (0, 0, 0);
  var_00.v["origin"] = (0, 0, 0);
  var_00.v["server_culled"] = 1;
  if(getdvar("serverCulledSounds") != "1") {
    var_00.v["server_culled"] = 0;
  }

  return var_00;
}

createintervalsound() {
  var_00 = createloopsound();
  var_00.v["type"] = "soundfx_interval";
  var_00.v["delay_min"] = getintervalsounddelaymindefault();
  var_00.v["delay_max"] = getintervalsounddelaymaxdefault();
  return var_00;
}

createnewexploder() {
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_00 = createnewexploder_internal();
  level.createfxent[level.createfxent.size] = var_00;
  return var_00;
}

createnewexploder_internal(param_00) {
  if(!isDefined(param_00)) {
    param_00 = spawnStruct();
    param_00.v = [];
  }

  param_00.v["type"] = "exploder";
  param_00.v["exploder_type"] = "normal";
  if(!isDefined(param_00.v["fxid"])) {
    param_00.v["fxid"] = "No FX";
  }

  if(!isDefined(param_00.v["soundalias"])) {
    param_00.v["soundalias"] = "nil";
  }

  if(!isDefined(param_00.v["loopsound"])) {
    param_00.v["loopsound"] = "nil";
  }

  if(!isDefined(param_00.v["angles"])) {
    param_00.v["angles"] = (0, 0, 0);
  }

  if(!isDefined(param_00.v["origin"])) {
    param_00.v["origin"] = (0, 0, 0);
  }

  if(!isDefined(param_00.v["exploder"])) {
    param_00.v["exploder"] = 1;
  }

  if(!isDefined(param_00.v["flag"])) {
    param_00.v["flag"] = "nil";
  }

  if(!isDefined(param_00.v["delay"]) || param_00.v["delay"] < 0) {
    param_00.v["delay"] = getexploderdelaydefault();
  }

  return param_00;
}

createexploderex(param_00, param_01) {
  var_02 = scripts\engine\utility::createexploder(param_00);
  var_02.v["exploder"] = param_01;
  return var_02;
}

createreactiveent(param_00) {
  var_01 = spawnStruct();
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = var_01;
  var_01.v = [];
  var_01.v["origin"] = (0, 0, 0);
  var_01.v["reactive_radius"] = 350;
  if(isDefined(param_00)) {
    var_01.v["fxid"] = param_00;
  } else {
    var_01.v["fxid"] = "No FX";
  }

  var_01.v["type"] = "reactive_fx";
  var_01.v["soundalias"] = "nil";
  return var_01;
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

createfx_common() {
  precacheshader("black");
  level._createfx = spawnStruct();
  level._createfx.objective_position = spawn("script_origin", (0, 0, 0));
  level._createfx.objective_position.fx = loadfx("vfx\core\expl\grenadeexp_default");
  level._createfx.objective_position.sound = "frag_grenade_explode";
  level._createfx.objective_position.fgetarg = 256;
  precachemodel("axis_guide_createfx_rot");
  precachemodel("axis_guide_createfx");
  scripts\engine\utility::flag_init("createfx_saving");
  scripts\engine\utility::flag_init("createfx_started");
  if(!isDefined(level.createfx)) {
    level.createfx = [];
  }

  level.createfx_loopcounter = 0;
  wait(0.05);
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
  level._createfx.rate = 1;
  level._createfx.snap2normal = 0;
  level._createfx.snap2angle = 0;
  level._createfx.snap2anglesnaps = [0, 90, 45, 15];
  level._createfx.axismode = 0;
  level._createfx.select_by_name = 0;
  level._createfx.drawaxis = 1;
  level._createfx.player_speed = getdvarfloat("g_speed");
  set_player_speed_hud();
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
  var_00["oneshotfx"]["highlighted"] = (0.4, 0.95, 1);
  var_00["oneshotfx"]["default"] = (0.3, 0.8, 1);
  var_00["exploder"]["selected"] = (1, 1, 0.2);
  var_00["exploder"]["highlighted"] = (1, 0.2, 0.2);
  var_00["exploder"]["default"] = (1, 0.1, 0.1);
  var_00["rainfx"]["selected"] = (1, 1, 0.2);
  var_00["rainfx"]["highlighted"] = (0.95, 0.4, 0.95);
  var_00["rainfx"]["default"] = (0.78, 0, 0.73);
  var_00["soundfx"]["selected"] = (1, 1, 0.2);
  var_00["soundfx"]["highlighted"] = (0.5, 1, 0.75);
  var_00["soundfx"]["default"] = (0.2, 0.9, 0.2);
  var_00["soundfx_interval"]["selected"] = (1, 1, 0.2);
  var_00["soundfx_interval"]["highlighted"] = (0.5, 1, 0.75);
  var_00["soundfx_interval"]["default"] = (0.2, 0.9, 0.2);
  var_00["reactive_fx"]["selected"] = (1, 1, 0.2);
  var_00["reactive_fx"]["highlighted"] = (0.5, 1, 0.75);
  var_00["reactive_fx"]["default"] = (0.2, 0.9, 0.2);
  level._createfx.colors = var_00;
}

createfxlogic() {
  waittillframeend;
  wait(0.05);
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  if(getdvar("createfx_map") == "") {} else if(getdvar("createfx_map") == scripts\engine\utility::get_template_script_MAYBE()) {
    [[level.func_position_player]]();
  }

  init_crosshair();
  scripts\common\createfxmenu::init_menu();
  init_huds();
  init_tool_hud();
  init_level_variables();
  init_locked_list();
  init_colors();
  level.player setclientomnvar("ui_hide_hud", 1);
  setdvarifuninitialized("createfx_filter", "");
  setdvarifuninitialized("createfx_vfxonly", "0");
  if(getdvar("createfx_use_f4") == "") {}

  if(getdvar("createfx_no_autosave") == "") {}

  level.createfx_draw_enabled = 1;
  level.last_displayed_ent = undefined;
  level.buttonisheld = [];
  var_00 = (0, 0, 0);
  scripts\engine\utility::flag_set("createfx_started");
  if(!level.mp_createfx) {
    var_00 = level.player.origin;
  }

  var_01 = undefined;
  level.fx_rotating = 0;
  scripts\common\createfxmenu::setmenu("none");
  level.createfx_selecting = 0;
  level.createfx_inputlocked = 0;
  foreach(var_03 in level.createfxent) {
    var_03 post_entity_creation_function();
  }

  thread draw_distance();
  var_05 = undefined;
  thread createfx_autosave();
  for(;;) {
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
    var_0E = button_is_held("shift");
    var_0F = button_is_clicked("mouse1", "BUTTON_A");
    var_10 = button_is_held("mouse1", "BUTTON_A");
    scripts\common\createfxmenu::create_fx_menu();
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

    if(button_is_clicked("z")) {
      toggle_createfx_axis();
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

    if(button_is_clicked("space")) {
      set_off_exploders();
    }

    if(button_is_clicked("u")) {
      select_by_name_list();
    }

    modify_player_speed();
    if(!var_0D && !var_0E && button_is_clicked("g")) {
      select_all_exploders_of_currently_selected("exploder");
      select_all_exploders_of_currently_selected("flag");
    }

    if(var_0E) {
      if(button_is_clicked("g")) {
        goto_selected();
      }
    }

    if(button_is_held("h", "F1") && !level.mp_createfx) {
      show_help();
      wait(0.05);
      continue;
    }

    if(button_is_clicked("BUTTON_LSTICK")) {
      copy_ents();
    }

    if(button_is_clicked("BUTTON_RSTICK")) {
      paste_ents();
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
      scripts\common\createfxmenu::menu_fx_option_set();
    }

    for(var_12 = 0; var_12 < level.createfxent.size; var_12++) {
      var_03 = level.createfxent[var_12];
      var_13 = vectornormalize(var_03.v["origin"] - level.player.origin + (0, 0, 55));
      var_14 = vectordot(var_08, var_13);
      if(var_14 < var_0A) {
        continue;
      }

      var_0A = var_14;
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

    manipulate_createfx_ents(var_0C, var_0F, var_10, var_0D, var_07);
    var_06 = handle_selected_ents(var_06);
    wait(0.05);
    if(var_06) {
      update_selected_entities();
    }

    if(!level.mp_createfx) {
      var_00 = [
        [level.func_position_player_get]
      ](var_00);
    }

    var_01 = var_0C;
    if(last_selected_entity_has_changed(var_05)) {
      level.effect_list_offset = 0;
      clear_settable_fx();
      scripts\common\createfxmenu::setmenu("none");
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
    set_player_speed_hud();
  }
}

set_player_speed_hud() {
  if(level.mp_createfx) {
    return;
  }

  if(!isDefined(level._createfx.player_speed_hud)) {
    var_00 = newhudelem();
    var_00.alignx = "right";
    var_00.foreground = 1;
    var_00.fontscale = 1.2;
    var_00.alpha = 0.2;
    var_00.x = 320;
    var_00.y = 420;
    var_01 = newhudelem();
    var_01.alignx = "left";
    var_01.foreground = 1;
    var_01.fontscale = 1.2;
    var_01.alpha = 0.2;
    var_01.x = 320;
    var_01.y = 420;
    var_00.hud_value = var_01;
    level._createfx.player_speed_hud = var_00;
  }

  level._createfx.player_speed_hud.hud_value setvalue(level._createfx.player_speed);
}

toggle_createfx_drawing() {
  level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

insert_effect() {
  scripts\common\createfxmenu::setmenu("creation");
  level.effect_list_offset = 0;
  clear_fx_hudelements();
  set_fx_hudelement("Pick effect type to create:");
  set_fx_hudelement("1. One Shot FX");
  if(!level.mp_createfx) {
    set_fx_hudelement("2. Looping FX");
    set_fx_hudelement("3. Looping sound");
    set_fx_hudelement("4. Exploder");
    set_fx_hudelement("5. One Shot Sound");
    set_fx_hudelement("6. Reactive FX");
  } else {
    set_fx_hudelement("2. Looping sound");
    set_fx_hudelement("3. Exploder");
    set_fx_hudelement("4. One Shot Sound");
    set_fx_hudelement("5. Reactive FX");
  }

  set_fx_hudelement("(c) Cancel >");
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

    if(is_ent_filtered_out(var_06, getdvar("createfx_filter"))) {
      continue;
    }

    var_07 = getdvarfloat("createfx_scaleid");
    if(isDefined(param_00) && var_06 == param_00) {
      if(!scripts\common\createfxmenu::entities_are_selected()) {
        scripts\common\createfxmenu::display_fx_info(var_06);
      }

      if(param_01) {
        var_08 = index_is_selected(var_05);
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
  var_08 = distancesquared(var_02, self.v["origin"]) < -28672;
  if(var_08) {
    var_09 = distance(var_02, self.v["origin"]);
    var_0A = var_09 / 176;
    var_05 = 1 - clamp(var_0A, 0, 1);
    var_06 = clamp(var_0A, 0.333, 1);
    var_0B = anglestoright(var_03) * -4;
    var_0C = anglestoup(var_03) * -4.666;
    var_07 = var_0B + var_0C;
  }

  if(var_05 > 0) {
    var_0D = scripts\engine\utility::within_fov(var_02, var_03, self.v["origin"], 0.422618);
    if(var_0D) {
      var_0E = 2;
      var_0F = 4;
      var_10 = anglesToForward(self.v["angles"]);
      var_10 = var_10 * var_0F * param_00;
      var_11 = anglestoright(self.v["angles"]) * -1;
      var_11 = var_11 * var_0F * param_00;
      var_12 = anglestoup(self.v["angles"]);
      var_12 = var_12 * var_0F * param_00;
    }
  }
}

createfx_print3d(param_00, param_01, param_02) {
  draw_origin(param_01, param_00);
  if(self.textalpha > 0) {
    var_03 = get_print3d_text();
    var_04 = param_02 * var_03[0].size * -2.93;
    var_05 = level._createfx.colors[self.v["type"]][param_00];
    if(isDefined(self.is_playing)) {
      var_05 = (1, 0.5, 0);
    }

    var_06 = 15;
    foreach(var_08 in var_03) {
      var_06 = var_06 - 13;
    }

    if(isDefined(self.v["reactive_radius"])) {
      if(self.v["fxid"] == "No FX" && !getdvarint("createfx_vfxonly")) {
        return;
      }
    }
  }
}

get_print3d_text() {
  switch (self.v["type"]) {
    case "reactive_fx":
      var_00[0] = "reactive sound: " + self.v["soundalias"];
      if(!level.mp_createfx) {
        var_00[1] = "reactive FX: " + self.v["fxid"];
      }
      return var_00;

    case "soundfx_interval":
    case "soundfx":
      return [self.v["soundalias"]];

    default:
      return [self.v["fxid"]];
  }
}

select_by_name_list() {
  level.effect_list_offset = 0;
  clear_fx_hudelements();
  scripts\common\createfxmenu::setmenu("select_by_name");
  scripts\common\createfxmenu::draw_effects_list();
}

handle_selected_ents(param_00) {
  if(level._createfx.selected_fx_ents.size > 0) {
    param_00 = selected_ent_buttons(param_00);
    if(!current_mode_hud("selected_ents")) {
      new_tool_hud("selected_ents");
      set_tool_hudelem("Selected Ent Mode");
      set_tool_hudelem("Mode:", "move");
      set_tool_hudelem("Rate:", level._createfx.rate);
      set_tool_hudelem("Snap2Normal:", level._createfx.snap2normal);
      set_tool_hudelem("Snap2Angle:", level._createfx.snap2anglesnaps[level._createfx.snap2angle]);
    }

    if(level._createfx.axismode && level._createfx.selected_fx_ents.size > 0) {
      set_tool_hudelem("Mode:", "rotate");
      thread[[level.func_process_fx_rotater]]();
      if(button_is_clicked("enter", "p")) {
        reset_axis_of_selected_ents();
      }

      if(button_is_clicked("v")) {
        copy_angles_of_selected_ents();
      }

      for(var_01 = 0; var_01 < level._createfx.selected_fx_ents.size; var_01++) {
        level._createfx.selected_fx_ents[var_01] draw_axis();
      }

      if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0) {
        param_00 = 1;
      }
    } else {
      set_tool_hudelem("Mode:", "move");
      var_02 = get_selected_move_vector();
      for(var_01 = 0; var_01 < level._createfx.selected_fx_ents.size; var_01++) {
        var_03 = level._createfx.selected_fx_ents[var_01];
        if(isDefined(var_03.model)) {
          continue;
        }

        var_03 draw_cross();
        var_03.v["origin"] = var_03.v["origin"] + var_02;
      }

      if(distance((0, 0, 0), var_02) > 0) {
        param_00 = 1;
      }
    }
  } else {
    clear_tool_hud();
  }

  return param_00;
}

selected_ent_buttons(param_00) {
  if(button_is_clicked("shift", "BUTTON_X")) {
    toggle_axismode();
  }

  modify_rate();
  if(button_is_clicked("s")) {
    toggle_snap2normal();
  }

  if(button_is_clicked("r")) {
    toggle_snap2angle();
  }

  if(button_is_clicked("end", "l")) {
    drop_selection_to_ground();
    param_00 = 1;
  }

  if(button_is_clicked("tab", "BUTTON_RSHLDR")) {
    move_selection_to_cursor();
    param_00 = 1;
  }

  if(button_is_clicked("e")) {
    convert_selection_to_exploder();
    param_00 = 1;
  }

  return param_00;
}

modify_rate() {
  var_00 = button_is_held("shift");
  var_01 = button_is_held("ctrl");
  if(button_is_clicked("=")) {
    if(var_00) {
      level._createfx.rate = level._createfx.rate + 1;
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
      level._createfx.rate = level._createfx.rate - 1;
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

  level._createfx.rate = clamp(level._createfx.rate, 0.1, 100);
  set_tool_hudelem("Rate:", level._createfx.rate);
}

toggle_axismode() {
  level._createfx.axismode = !level._createfx.axismode;
}

toggle_snap2normal() {
  level._createfx.snap2normal = !level._createfx.snap2normal;
  set_tool_hudelem("Snap2Normal:", level._createfx.snap2normal);
}

toggle_snap2angle() {
  level._createfx.snap2angle = level._createfx.snap2angle + 1;
  if(level._createfx.snap2angle >= level._createfx.snap2anglesnaps.size) {
    level._createfx.snap2angle = 0;
  }

  set_tool_hudelem("Snap2Angle:", level._createfx.snap2anglesnaps[level._createfx.snap2angle]);
}

copy_angles_of_selected_ents() {
  level notify("new_ent_selection");
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    var_01 = level._createfx.selected_fx_ents[var_00];
    var_01.v["angles"] = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1].v["angles"];
    var_01 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

reset_axis_of_selected_ents() {
  level notify("new_ent_selection");
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    var_01 = level._createfx.selected_fx_ents[var_00];
    var_01.v["angles"] = (0, 0, 0);
    var_01 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

last_selected_entity_has_changed(param_00) {
  if(isDefined(param_00)) {
    if(!scripts\common\createfxmenu::entities_are_selected()) {
      return 1;
    }
  } else {
    return scripts\common\createfxmenu::entities_are_selected();
  }

  return param_00 != level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}

drop_selection_to_ground() {
  for(var_00 = 0; var_00 < level._createfx.selected_fx_ents.size; var_00++) {
    var_01 = level._createfx.selected_fx_ents[var_00];
    var_02 = bulletTrace(var_01.v["origin"], var_01.v["origin"] + (0, 0, -2048), 0, undefined);
    var_01.v["origin"] = var_02["position"];
  }
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
    scripts\engine\utility::exploder(var_03[var_01]);
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
        wait(0.05);
      }
    }

    if(level.createfxent.size == 0) {
      wait(0.05);
    }
  }
}

createfx_autosave() {
  setdvarifuninitialized("createfx_autosave_time", "300");
  for(;;) {
    wait(getdvarint("createfx_autosave_time"));
    scripts\engine\utility::flag_waitopen("createfx_saving");
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
      param_00 getnodeyawtoenemy(level.selectedrotate_pitch);
    } else if(level.selectedrotate_yaw != 0) {
      param_00 addyaw(level.selectedrotate_yaw);
    } else {
      param_00 getnodeyawtoorigin(level.selectedrotate_roll);
    }

    wait(0.05);
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

  update_selected_entities();
  clear_settable_fx();
}

remove_option(param_00) {
  self.v[param_00] = undefined;
}

delete_selection() {
  var_00 = [];
  for(var_01 = 0; var_01 < level.createfxent.size; var_01++) {
    var_02 = level.createfxent[var_01];
    if(ent_is_selected(var_02)) {
      if(isDefined(var_02.loopsound_ent)) {
        var_02.loopsound_ent stoploopsound();
        var_02.loopsound_ent delete();
      }

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
  remove_axis_model();
}

move_selection_to_cursor() {
  var_00 = level.createfxcursor["position"];
  if(level._createfx.selected_fx_ents.size <= 0) {
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
}

convert_selection_to_exploder() {
  if(level._createfx.selected_fx_ents.size < 1) {
    return;
  }

  var_00 = 0;
  foreach(var_02 in level._createfx.selected_fx_ents) {
    if(var_02.v["type"] == "oneshotfx") {
      var_00 = 1;
      createnewexploder_internal(var_02);
      continue;
    }
  }

  if(var_00) {
    scripts\common\createfxmenu::setmenu("none");
    scripts\common\createfxmenu::display_fx_info(scripts\common\createfxmenu::get_last_selected_ent());
  }
}

select_last_entity() {
  select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
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

  update_selected_entities();
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
    add_and_select_entity(level.stored_ents[var_00]);
  }

  move_selection_to_cursor();
  update_selected_entities();
  level.stored_ents = [];
  copy_ents();
}

add_and_select_entity(param_00) {
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

goto_selected() {
  var_00 = undefined;
  if(level._createfx.selected_fx_ents.size > 0) {
    var_00 = get_center_of_array(level._createfx.selected_fx_ents);
  } else if(isDefined(level.fx_highlightedent)) {
    var_00 = level.fx_highlightedent.v["origin"];
  }

  if(!isDefined(var_00)) {
    return;
  }

  var_01 = vectortoangles(level.player.origin - var_00);
  var_02 = var_00 + anglesToForward(var_01) * 200;
  level.player setorigin(var_02 + (0, 0, -60));
  level.player setplayerangles(vectortoangles(var_00 - var_02));
}

ent_draw_axis() {
  self endon("death");
  for(;;) {
    draw_axis();
    wait(0.05);
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
    var_05 = var_04["name"];
    if(!isDefined(param_00.v[var_05])) {
      continue;
    }

    if(!scripts\common\createfxmenu::mask(var_04["mask"], param_00.v["type"])) {
      continue;
    }

    if(!level.mp_createfx) {
      if(scripts\common\createfxmenu::mask("fx", param_00.v["type"]) && var_05 == "fxid") {
        continue;
      }

      if(param_00.v["type"] == "exploder" && var_05 == "exploder") {
        continue;
      }

      var_06 = param_00.v["type"] + "\" + var_05;
      if(isDefined(level._createfx.defaults[var_06]) && level._createfx.defaults[var_06] == param_00.v[var_05]) {
        continue;
      }
    }

    if(var_04["type"] == "string") {
      var_07 = param_00.v[var_05] + "";
      if(var_07 == "nil") {
        continue;
      }

      cfxprintln(param_01 + "ent.v[\" + var_05 + "\
        "] = \" + param_00.v[var_05] + "\
        ";");
      continue;
    }

    cfxprintln(param_01 + "ent.v[\" + var_05 + "\
      "] = " + param_00.v[var_05] + ";");
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

    wait(0.05);
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

    wait(0.05);
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
    level._createfx.hudelems[var_00][0].color = (1, 1, 1);
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

set_axis_model(param_00) {
  if(!isDefined(level._createfx.var_55)) {
    level._createfx.var_55 = spawn("script_model", (0, 0, 0));
    return;
  }

  if(level._createfx.var_55.model != param_00) {
    level._createfx.var_55 setModel(param_00);
  }
}

remove_axis_model() {
  if(!isDefined(level._createfx.var_55)) {
    return;
  }

  level._createfx.var_55 delete();
}

draw_cross() {}

toggle_createfx_axis() {
  level._createfx.drawaxis++;
  if(level._createfx.drawaxis > 2) {
    level._createfx.drawaxis = 0;
  }

  if(level._createfx.drawaxis != 1) {
    remove_axis_model();
  }
}

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
  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedmove_forward < 0) {
      level.selectedmove_forward = 0;
    }

    level.selectedmove_forward = level.selectedmove_forward + var_06;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedmove_forward > 0) {
      level.selectedmove_forward = 0;
    }

    level.selectedmove_forward = level.selectedmove_forward - var_06;
  } else {
    level.selectedmove_forward = 0;
  }

  if(buttondown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedmove_right < 0) {
      level.selectedmove_right = 0;
    }

    level.selectedmove_right = level.selectedmove_right + var_06;
  } else if(buttondown("kp_leftarrow", "DPAD_LEFT")) {
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
  var_00 = level._createfx.rate;
  var_01 = level._createfx.snap2anglesnaps[level._createfx.snap2angle];
  if(var_01 != 0) {
    var_00 = 0;
  }

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedrotate_pitch < 0) {
      level.selectedrotate_pitch = 0;
    }

    level.selectedrotate_pitch = level.selectedrotate_pitch + var_01 + var_00;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedrotate_pitch > 0) {
      level.selectedrotate_pitch = 0;
    }

    level.selectedrotate_pitch = level.selectedrotate_pitch - var_01 - var_00;
  } else {
    level.selectedrotate_pitch = 0;
  }

  if(buttondown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedrotate_yaw < 0) {
      level.selectedrotate_yaw = 0;
    }

    level.selectedrotate_yaw = level.selectedrotate_yaw + var_01 + var_00;
  } else if(buttondown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedrotate_yaw > 0) {
      level.selectedrotate_yaw = 0;
    }

    level.selectedrotate_yaw = level.selectedrotate_yaw - var_01 - var_00;
  } else {
    level.selectedrotate_yaw = 0;
  }

  if(buttondown("BUTTON_Y")) {
    if(level.selectedrotate_roll < 0) {
      level.selectedrotate_roll = 0;
    }

    level.selectedrotate_roll = level.selectedrotate_roll + var_01 + var_00;
    return;
  }

  if(buttondown("BUTTON_B")) {
    if(level.selectedrotate_roll > 0) {
      level.selectedrotate_roll = 0;
    }

    level.selectedrotate_roll = level.selectedrotate_roll - var_01 - var_00;
    return;
  }

  level.selectedrotate_roll = 0;
}

update_selected_entities() {
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

  var_00 = scripts\engine\utility::alphabetize(var_00);
  level._effect_keys = var_00;
  return var_00;
}

restart_fx_looper() {
  stop_fx_looper();
  set_forward_and_up_vectors();
  switch (self.v["type"]) {
    case "oneshotfx":
      scripts\common\fx::create_triggerfx();
      break;

    case "loopfx":
      scripts\common\fx::create_looper();
      break;

    case "soundfx":
      scripts\common\fx::create_loopsound();
      break;

    case "soundfx_interval":
      scripts\common\fx::create_interval_sound();
      break;
  }
}

refresh_reactive_fx_ents() {
  level._fx.reactive_fx_ents = undefined;
  foreach(var_01 in level.createfxent) {
    if(var_01.v["type"] == "reactive_fx") {
      var_01 set_forward_and_up_vectors();
      var_01 scripts\common\fx::add_reactive_fx();
    }
  }
}

process_fx_rotater() {
  if(level.fx_rotating) {
    return;
  }

  set_anglemod_move_vector();
  if(!rotation_is_occuring()) {
    return;
  }

  level.fx_rotating = 1;
  if(level._createfx.selected_fx_ents.size > 1) {
    var_00 = get_center_of_array(level._createfx.selected_fx_ents);
    var_01 = spawn("script_origin", var_00);
    var_01.v["angles"] = level._createfx.selected_fx_ents[0].v["angles"];
    var_01.v["origin"] = var_00;
    var_02 = [];
    for(var_03 = 0; var_03 < level._createfx.selected_fx_ents.size; var_03++) {
      var_02[var_03] = spawn("script_origin", level._createfx.selected_fx_ents[var_03].v["origin"]);
      var_02[var_03].angles = level._createfx.selected_fx_ents[var_03].v["angles"];
      var_02[var_03] linkto(var_01);
    }

    rotate_over_time(var_01, var_02);
    var_01 delete();
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      var_02[var_03] delete();
    }
  } else if(level._createfx.selected_fx_ents.size == 1) {
    var_04 = level._createfx.selected_fx_ents[0];
    var_02 = spawn("script_origin", (0, 0, 0));
    var_02.angles = var_04.v["angles"];
    if(level.selectedrotate_pitch != 0) {
      var_02 getnodeyawtoenemy(level.selectedrotate_pitch);
    } else if(level.selectedrotate_yaw != 0) {
      var_02 addyaw(level.selectedrotate_yaw);
    } else {
      var_02 getnodeyawtoorigin(level.selectedrotate_roll);
    }

    var_04.v["angles"] = var_02.angles;
    var_02 delete();
    wait(0.05);
  }

  level.fx_rotating = 0;
}

spawn_grenade() {
  playFX(level._createfx.objective_position.fx, level.createfxcursor["position"]);
  level._createfx.objective_position playSound(level._createfx.objective_position.sound);
  radiusdamage(level.createfxcursor["position"], level._createfx.objective_position.fgetarg, 50, 5, undefined, "MOD_EXPLOSIVE");
  level notify("code_damageradius", undefined, level._createfx.objective_position.fgetarg, level.createfxcursor["position"]);
}

show_help() {
  clear_fx_hudelements();
  set_fx_hudelement("Help:");
  set_fx_hudelement("InsertInsert entity");
  set_fx_hudelement("L Drop selected entities to the ground");
  set_fx_hudelement("A Add option to the selected entities");
  set_fx_hudelement("P Reset the rotation of the selected entities");
  set_fx_hudelement("V Copy the angles from the most recently selected fx onto all selected fx.");
  set_fx_hudelement("DeleteKill the selected entities");
  set_fx_hudelement("ESCAPECancel out of option-modify-mode, must have console open");
  set_fx_hudelement("Ctrl-CCopy");
  set_fx_hudelement("Ctrl-VPaste");
  set_fx_hudelement("F2Toggle createfx dot and text drawing");
  set_fx_hudelement("F5SAVES your work");
  set_fx_hudelement("DpadMove selected entitise on X\Y or rotate pitch\yaw");
  set_fx_hudelement("A buttonToggle the selection of the current entity");
  set_fx_hudelement("X buttonToggle entity rotation mode");
  set_fx_hudelement("Y buttonMove selected entites up or rotate roll");
  set_fx_hudelement("B buttonMove selected entites down or rotate roll");
  set_fx_hudelement("R ShoulderMove selected entities to the cursor");
  set_fx_hudelement("L ShoulderHold to select multiple entites");
  set_fx_hudelement("L JoyClickCopy");
  set_fx_hudelement("R JoyClickPaste");
  set_fx_hudelement("N UFO");
  set_fx_hudelement("T Toggle Timescale FAST");
  set_fx_hudelement("Y Toggle Timescale SLOW");
  set_fx_hudelement("[Toggle FX Visibility");
  set_fx_hudelement("] Toggle ShowTris");
  set_fx_hudelement("F11 Toggle FX Profile");
}

generate_fx_log(param_00) {}

write_log(param_00, param_01, param_02, param_03) {
  var_04 = "\t";
  cfxprintlnstart();
  cfxprintln("\\_createfx generated. Do not touch!!");
  cfxprintln("#include scripts\\common\\utility;");
  cfxprintln("#include scripts\\common\\createfx;\n");
  cfxprintln("");
  cfxprintln("main()");
  cfxprintln("{");
  cfxprintln(var_04 + "\\CreateFX " + param_01 + " entities placed: " + param_00.size);
  foreach(var_06 in param_00) {
    if(level.createfx_loopcounter > 16) {
      level.createfx_loopcounter = 0;
      wait(0.1);
    }

    level.createfx_loopcounter++;
    if(getdvarint("scr_map_exploder_dump")) {
      if(!isDefined(var_06.model)) {
        continue;
      }
    } else if(isDefined(var_06.model)) {
      continue;
    }

    if(var_06.v["type"] == "oneshotfx") {
      cfxprintln(var_04 + "ent = createOneshotEffect(\" + var_06.v["
        fxid "] + "\
        ");");
    }

    if(var_06.v["type"] == "loopfx") {
      cfxprintln(var_04 + "ent = createLoopEffect(\" + var_06.v["
        fxid "] + "\
        ");");
    }

    if(var_06.v["type"] == "exploder") {
      if(isDefined(var_06.v["exploder"]) && !level.mp_createfx) {
        cfxprintln(var_04 + "ent = createExploderEx(\" + var_06.v["
          fxid "] + "\
          ", \" + var_06.v["
          exploder "] + "\
          ");");
      } else {
        cfxprintln(var_04 + "ent = createExploder(\" + var_06.v["
          fxid "] + "\
          ");");
      }
    }

    if(var_06.v["type"] == "soundfx") {
      cfxprintln(var_04 + "ent = createLoopSound();");
    }

    if(var_06.v["type"] == "soundfx_interval") {
      cfxprintln(var_04 + "ent = createIntervalSound();");
    }

    if(var_06.v["type"] == "reactive_fx") {
      if(param_01 == "fx" && var_06.v["fxid"] != "No FX" && !level.mp_createfx) {
        cfxprintln(var_04 + "ent = createReactiveEnt(\" + var_06.v["
          fxid "] + "\
          ");");
      } else if(param_01 == "sound" && var_06.v["fxid"] == "No FX") {
        cfxprintln(var_04 + "ent = createReactiveEnt();");
      } else {
        continue;
      }
    }

    cfxprintln(var_04 + "ent set_origin_and_angles(" + var_06.v["origin"] + ", " + var_06.v["angles"] + ");");
    print_fx_options(var_06, var_04, param_02);
    cfxprintln("");
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
    var_01[0] = "oneshotfx";
    var_01[1] = "loopfx";
    var_01[2] = "exploder";
    var_01[3] = "reactive_fx";
  } else {
    var_01[0] = "soundfx";
    var_01[1] = "soundfx_interval";
    var_01[2] = "reactive_fx";
  }

  return var_01;
}

check_reactive_fx_type(param_00, param_01) {
  if(param_00.v["fxid"] != "No FX" && param_01 == "fx") {
    return 1;
  }

  if(param_00.v["fxid"] == "No FX" && param_01 == "sound") {
    return 1;
  }

  return 0;
}

is_createfx_type(param_00, param_01) {
  var_02 = get_createfx_types(param_01);
  if(param_00.v["type"] == "reactive_fx") {
    if(check_reactive_fx_type(param_00, param_01)) {
      return 1;
    } else {
      return 0;
    }
  }

  foreach(var_04 in var_02) {
    if(param_00.v["type"] == var_04) {
      return 1;
    }
  }

  return 0;
}

createfx_filter_types() {
  var_00 = [];
  var_00[var_00.size] = "soundfx";
  var_00[var_00.size] = "oneshotfx";
  var_00[var_00.size] = "exploder";
  var_00[var_00.size] = "soundfx_interval";
  var_00[var_00.size] = "reactive_fx";
  if(!level.mp_createfx) {
    var_00[var_00.size] = "loopfx";
  }

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
  scripts\engine\utility::fileprint_launcher_start_file();
}

cfxprintln(param_00) {
  scripts\engine\utility::fileprint_launcher(param_00);
}

cfxprintlnend(param_00, param_01, param_02) {
    var_03 = 1;
    if(param_01 != "" || param_00) {
      var_03 = 0;
    }

    if(scripts\engine\utility::issp()) {
      var_04 = scripts\engine\utility::get_template_script_MAYBE() + param_01 + "_" + param_02 + ".gsc";
      if(param_00) {
        var_04 = "backup_" + param_02 + ".gsc";
      }
    } else {
      var_04 = scripts\engine\utility::get_template_script_MAYBE() + param_02 + "_" + var_03 + ".gsc";
      if(param_00) {
        var_04 = "backup.gsc";
      }
    }

    var_05 = scripts\engine\utility::get_template_script_MAYBE();
    var_06 = get_raw_or_devraw_subdir();
    var_07 = get_gamemode_subdir();
    scripts\engine\utility::fileprint_launcher_end_file("\share\" + var_06 + "\
      scripts\" + var_07 + "\
      maps\" + var_05 + "\
      gen\" + var_04,var_03);
    }

    get_raw_or_devraw_subdir() {
      if(isDefined(level.createfx_devraw_map) && level.createfx_devraw_map) {
        return "devraw";
      }

      return "raw";
    }

    get_gamemode_subdir() {
      if(scripts\engine\utility::iscp()) {
        return "cp";
      }

      if(scripts\engine\utility::issp()) {
        return "sp";
      }

      return "mp";
    }

    process_button_held_and_clicked() {
      add_button("mouse1");
      add_button("BUTTON_RSHLDR");
      add_button("BUTTON_LSHLDR");
      add_button("BUTTON_RSTICK");
      add_button("BUTTON_LSTICK");
      add_button("BUTTON_A");
      add_button("BUTTON_B");
      add_button("BUTTON_X");
      add_button("BUTTON_Y");
      add_button("DPAD_UP");
      add_button("DPAD_LEFT");
      add_button("DPAD_RIGHT");
      add_button("DPAD_DOWN");
      add_kb_button("shift");
      add_kb_button("ctrl");
      add_kb_button("escape");
      add_kb_button("F1");
      add_kb_button("F5");
      add_kb_button("F4");
      add_kb_button("F2");
      add_kb_button("a");
      add_kb_button("e");
      add_kb_button("g");
      add_kb_button("c");
      add_kb_button("h");
      add_kb_button("i");
      add_kb_button("k");
      add_kb_button("l");
      add_kb_button("m");
      add_kb_button("p");
      add_kb_button("r");
      add_kb_button("s");
      add_kb_button("u");
      add_kb_button("v");
      add_kb_button("x");
      add_kb_button("z");
      add_kb_button("del");
      add_kb_button("end");
      add_kb_button("tab");
      add_kb_button("ins");
      add_kb_button("add");
      add_kb_button("space");
      add_kb_button("enter");
      add_kb_button("1");
      add_kb_button("2");
      add_kb_button("3");
      add_kb_button("4");
      add_kb_button("5");
      add_kb_button("6");
      add_kb_button("7");
      add_kb_button("8");
      add_kb_button("9");
      add_kb_button("0");
      add_kb_button("-");
      add_kb_button("=");
      add_kb_button(",");
      add_kb_button(".");
      add_kb_button("[");
      add_kb_button("]");
      add_kb_button("leftarrow");
      add_kb_button("rightarrow");
      add_kb_button("uparrow");
      add_kb_button("downarrow");
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

    add_button(param_00) {
      if(locked(param_00)) {
        return;
      }

      if(!isDefined(level.buttonisheld[param_00])) {
        if(level.player buttonpressed(param_00)) {
          level.buttonisheld[param_00] = 1;
          level.buttonclick[param_00] = 1;
          return;
        }

        return;
      }

      if(!level.player buttonpressed(param_00)) {
        level.buttonisheld[param_00] = undefined;
      }
    }

    add_kb_button(param_00) {
      level.button_is_kb[param_00] = 1;
      add_button(param_00);
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

      return level.player buttonpressed(param_00);
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
      level._createfx.hudelem_count = 30;
      if(level.mp_createfx) {
        level._createfx.hudelem_count = 16;
      }

      var_00 = [];
      var_01 = [];
      var_00[0] = 0;
      var_01[0] = 0;
      var_00[1] = 1;
      var_01[1] = 1;
      var_00[2] = -2;
      var_01[2] = 1;
      var_00[3] = 1;
      var_01[3] = -1;
      var_00[4] = -2;
      var_01[4] = -1;
      level.cleartextmarker = newhudelem();
      level.cleartextmarker.alpha = 0;
      level.cleartextmarker.archived = 0;
      for(var_02 = 0; var_02 < level._createfx.hudelem_count; var_02++) {
        var_03 = [];
        for(var_04 = 0; var_04 < 1; var_04++) {
          var_05 = newhudelem();
          var_05.alignx = "left";
          var_05.archived = 0;
          var_05.location = 0;
          var_05.foreground = 1;
          var_05.fontscale = 1.4;
          var_05.sort = 20 - var_04;
          var_05.alpha = 1;
          var_05.x = 0 + var_00[var_04];
          var_05.y = 60 + var_01[var_04] + var_02 * 15;
          if(var_04 > 0) {
            var_05.color = (0, 0, 0);
          }

          var_03[var_03.size] = var_05;
        }

        level._createfx.hudelems[var_02] = var_03;
      }

      var_06 = newhudelem();
      var_06.archived = 0;
      var_06.alignx = "center";
      var_06.location = 0;
      var_06.foreground = 1;
      var_06.fontscale = 1.4;
      var_06.sort = 20;
      var_06.alpha = 1;
      var_06.x = 320;
      var_06.y = 40;
      level.createfx_centerprint = var_06;
    }

    init_crosshair() {
      var_00 = newhudelem();
      var_00.archived = 0;
      var_00.location = 0;
      var_00.alignx = "center";
      var_00.aligny = "middle";
      var_00.foreground = 1;
      var_00.fontscale = 1;
      var_00.sort = 20;
      var_00.alpha = 1;
      var_00.x = 320;
      var_00.y = 233;
    }

    clear_fx_hudelements() {
      level.cleartextmarker clearalltextafterhudelem();
      for(var_00 = 0; var_00 < level._createfx.hudelem_count; var_00++) {
        for(var_01 = 0; var_01 < 1; var_01++) {}
      }

      level.fxhudelements = 0;
    }

    set_fx_hudelement(param_00) {
      for(var_01 = 0; var_01 < 1; var_01++) {}

      level.fxhudelements++;
    }

    init_tool_hud() {
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
      var_01.archived = 0;
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

    set_tool_hudelem(param_00, param_01) {
      if(level.mp_createfx) {
        return;
      }

      var_02 = get_tool_hudelem(param_00);
      if(!isDefined(var_02)) {
        var_02 = new_tool_hudelem(level._createfx.tool_hudelems.size);
        level._createfx.tool_hudelems[param_00] = var_02;
        var_02.text = param_00;
      }

      if(isDefined(param_01)) {
        if(isDefined(var_02.value_hudelem)) {
          var_03 = var_02.value_hudelem;
        } else {
          var_03 = new_tool_hudelem(level._createfx.tool_hudelems.size);
          var_03.x = var_03.x + 100;
          var_03.y = var_02.y;
          var_02.value_hudelem = var_03;
        }

        if(isDefined(var_03.text) && var_03.text == param_01) {
          return;
        }

        var_03.text = param_01;
      }
    }

    select_by_substring() {
      var_00 = getdvar("select_by_substring");
      if(var_00 == "") {
        return 0;
      }

      setdvar("select_by_substring", "");
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
      foreach(var_02, var_01 in level._createfx.selected_fx_ents) {
        deselect_entity(var_02, var_01);
      }
    }