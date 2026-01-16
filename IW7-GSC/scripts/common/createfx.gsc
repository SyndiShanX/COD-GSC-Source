/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\createfx.gsc
**************************************/

createeffect(var_0, var_1) {
  var_2 = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = var_2;
  var_2.v = [];
  var_2.v["type"] = var_0;
  var_2.v["fxid"] = var_1;
  var_2.v["angles"] = (0, 0, 0);
  var_2.v["origin"] = (0, 0, 0);
  return var_2;
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
  var_0 = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = var_0;
  var_0.v = [];
  var_0.v["type"] = "soundfx";
  var_0.v["fxid"] = "No FX";
  var_0.v["soundalias"] = "nil";
  var_0.v["angles"] = (0, 0, 0);
  var_0.v["origin"] = (0, 0, 0);
  var_0.v["server_culled"] = 1;

  if(getdvar("serverCulledSounds") != "1") {
    var_0.v["server_culled"] = 0;
  }

  return var_0;
}

createintervalsound() {
  var_0 = createloopsound();
  var_0.v["type"] = "soundfx_interval";
  var_0.v["delay_min"] = getintervalsounddelaymindefault();
  var_0.v["delay_max"] = getintervalsounddelaymaxdefault();
  return var_0;
}

createnewexploder() {
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_0 = createnewexploder_internal();
  level.createfxent[level.createfxent.size] = var_0;
  return var_0;
}

createnewexploder_internal(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.v = [];
  }

  var_0.v["type"] = "exploder";
  var_0.v["exploder_type"] = "normal";

  if(!isDefined(var_0.v["fxid"])) {
    var_0.v["fxid"] = "No FX";
  }

  if(!isDefined(var_0.v["soundalias"])) {
    var_0.v["soundalias"] = "nil";
  }

  if(!isDefined(var_0.v["loopsound"])) {
    var_0.v["loopsound"] = "nil";
  }

  if(!isDefined(var_0.v["angles"])) {
    var_0.v["angles"] = (0, 0, 0);
  }

  if(!isDefined(var_0.v["origin"])) {
    var_0.v["origin"] = (0, 0, 0);
  }

  if(!isDefined(var_0.v["exploder"])) {
    var_0.v["exploder"] = 1;
  }

  if(!isDefined(var_0.v["flag"])) {
    var_0.v["flag"] = "nil";
  }

  if(!isDefined(var_0.v["delay"]) || var_0.v["delay"] < 0) {
    var_0.v["delay"] = getexploderdelaydefault();
  }

  return var_0;
}

createexploderex(var_0, var_1) {
  var_2 = scripts\engine\utility::createexploder(var_0);
  var_2.v["exploder"] = var_1;
  return var_2;
}

createreactiveent(var_0) {
  var_1 = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = var_1;
  var_1.v = [];
  var_1.v["origin"] = (0, 0, 0);
  var_1.v["reactive_radius"] = 350;

  if(isDefined(var_0)) {
    var_1.v["fxid"] = var_0;
  } else {
    var_1.v["fxid"] = "No FX";
  }

  var_1.v["type"] = "reactive_fx";
  var_1.v["soundalias"] = "nil";
  return var_1;
}

set_origin_and_angles(var_0, var_1) {
  if(isDefined(level.createfx_offset)) {
    var_0 = var_0 + level.createfx_offset;
  }

  self.v["origin"] = var_0;
  self.v["angles"] = var_1;
}

set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglesToForward(self.v["angles"]);
}

createfx_common() {
  precacheshader("black");
  level._createfx = spawnStruct();
  level._createfx.grenade = spawn("script_origin", (0, 0, 0));
  level._createfx.grenade.fx = loadfx("vfx\core\expl\grenadeexp_default");
  level._createfx.grenade.sound = "frag_grenade_explode";
  level._createfx.grenade.radius = 256;
  precachemodel("axis_guide_createfx_rot");
  precachemodel("axis_guide_createfx");
  scripts\engine\utility::flag_init("createfx_saving");
  scripts\engine\utility::flag_init("createfx_started");

  if(!isDefined(level.createfx)) {
    level.createfx = [];
  }

  level.createfx_loopcounter = 0;
  wait 0.05;
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
  var_0 = [];
  var_0["loopfx"]["selected"] = (1, 1, 0.2);
  var_0["loopfx"]["highlighted"] = (0.4, 0.95, 1);
  var_0["loopfx"]["default"] = (0.3, 0.8, 1);
  var_0["oneshotfx"]["selected"] = (1, 1, 0.2);
  var_0["oneshotfx"]["highlighted"] = (0.4, 0.95, 1);
  var_0["oneshotfx"]["default"] = (0.3, 0.8, 1);
  var_0["exploder"]["selected"] = (1, 1, 0.2);
  var_0["exploder"]["highlighted"] = (1, 0.2, 0.2);
  var_0["exploder"]["default"] = (1, 0.1, 0.1);
  var_0["rainfx"]["selected"] = (1, 1, 0.2);
  var_0["rainfx"]["highlighted"] = (0.95, 0.4, 0.95);
  var_0["rainfx"]["default"] = (0.78, 0, 0.73);
  var_0["soundfx"]["selected"] = (1, 1, 0.2);
  var_0["soundfx"]["highlighted"] = (0.5, 1, 0.75);
  var_0["soundfx"]["default"] = (0.2, 0.9, 0.2);
  var_0["soundfx_interval"]["selected"] = (1, 1, 0.2);
  var_0["soundfx_interval"]["highlighted"] = (0.5, 1, 0.75);
  var_0["soundfx_interval"]["default"] = (0.2, 0.9, 0.2);
  var_0["reactive_fx"]["selected"] = (1, 1, 0.2);
  var_0["reactive_fx"]["highlighted"] = (0.5, 1, 0.75);
  var_0["reactive_fx"]["default"] = (0.2, 0.9, 0.2);
  level._createfx.colors = var_0;
}

createfxlogic() {
  waittillframeend;
  wait 0.05;

  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  if(getdvar("createfx_map") == "") {} else if(getdvar("createfx_map") == scripts\engine\utility::get_template_script_MAYBE()) {
    [[level.var_position_player]]();
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
  var_0 = (0, 0, 0);
  scripts\engine\utility::flag_set("createfx_started");

  if(!level.mp_createfx) {
    var_0 = level.player.origin;
  }

  var_1 = undefined;
  level.fx_rotating = 0;
  scripts\common\createfxmenu::setmenu("none");
  level.createfx_selecting = 0;
  level.createfx_inputlocked = 0;

  foreach(var_3 in level.createfxent) {
    var_3 post_entity_creation_function();
  }

  thread draw_distance();
  var_5 = undefined;
  thread createfx_autosave();

  for(;;) {
    var_6 = 0;
    var_7 = anglestoright(level.player getplayerangles());
    var_8 = anglesToForward(level.player getplayerangles());
    var_9 = anglestoup(level.player getplayerangles());
    var_10 = 0.85;
    var_11 = var_8 * 750;
    level.createfxcursor = bulletTrace(level.player getEye(), level.player getEye() + var_11, 0, undefined);
    var_12 = undefined;
    level.buttonclick = [];
    level.button_is_kb = [];
    process_button_held_and_clicked();
    var_13 = button_is_held("ctrl", "BUTTON_LSHLDR");
    var_14 = button_is_held("shift");
    var_15 = button_is_clicked("mouse1", "BUTTON_A");
    var_16 = button_is_held("mouse1", "BUTTON_A");
    scripts\common\createfxmenu::create_fx_menu();
    var_17 = "F5";

    if(getdvarint("createfx_use_f4")) {
      var_17 = "F4";
    }

    if(button_is_clicked(var_17)) {}

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

    if(!var_13 && !var_14 && button_is_clicked("g")) {
      select_all_exploders_of_currently_selected("exploder");
      select_all_exploders_of_currently_selected("flag");
    }

    if(var_14) {
      if(button_is_clicked("g")) {
        goto_selected();
      }
    }

    if(button_is_held("h", "F1") && !level.mp_createfx) {
      show_help();
      wait 0.05;
      continue;
    }

    if(button_is_clicked("BUTTON_LSTICK")) {
      copy_ents();
    }

    if(button_is_clicked("BUTTON_RSTICK")) {
      paste_ents();
    }

    if(var_13) {
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

    for(var_18 = 0; var_18 < level.createfxent.size; var_18++) {
      var_3 = level.createfxent[var_18];
      var_19 = vectornormalize(var_3.v["origin"] - (level.player.origin + (0, 0, 55)));
      var_20 = vectordot(var_8, var_19);

      if(var_20 < var_10) {
        continue;
      }
      var_10 = var_20;
      var_12 = var_3;
    }

    level.fx_highlightedent = var_12;

    if(isDefined(var_12)) {
      if(isDefined(var_1)) {
        if(var_1 != var_12) {
          if(!ent_is_selected(var_1)) {
            var_1 thread entity_highlight_disable();
          }

          if(!ent_is_selected(var_12)) {
            var_12 thread entity_highlight_enable();
          }
        }
      } else if(!ent_is_selected(var_12)) {
        var_12 thread entity_highlight_enable();
      }
    }

    manipulate_createfx_ents(var_12, var_15, var_16, var_13, var_7);
    var_6 = handle_selected_ents(var_6);
    wait 0.05;

    if(var_6) {
      update_selected_entities();
    }

    if(!level.mp_createfx) {
      var_0 = [
        }
        [level.var_position_player_get]](var_0);

    var_1 = var_12;

    if(last_selected_entity_has_changed(var_5)) {
      level.effect_list_offset = 0;
      clear_settable_fx();
      scripts\common\createfxmenu::setmenu("none");
    }

    if(level._createfx.selected_fx_ents.size) {
      var_5 = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
      continue;
    }

    var_5 = undefined;
  }
}

modify_player_speed() {
  var_0 = 0;
  var_1 = button_is_held("ctrl");

  if(button_is_held(".")) {
    if(var_1) {
      if(level._createfx.player_speed < 190) {
        level._createfx.player_speed = 190;
      } else {
        level._createfx.player_speed = level._createfx.player_speed + 10;
      }
    } else {
      level._createfx.player_speed = level._createfx.player_speed + 5;
    }

    var_0 = 1;
  } else if(button_is_held(",")) {
    if(var_1) {
      if(level._createfx.player_speed > 190) {
        level._createfx.player_speed = 190;
      } else {
        level._createfx.player_speed = level._createfx.player_speed - 10;
      }
    } else {
      level._createfx.player_speed = level._createfx.player_speed - 5;
    }

    var_0 = 1;
  }

  if(var_0) {
    level._createfx.player_speed = clamp(level._createfx.player_speed, 5, 500);
    [[level.var_player_speed]]();
    set_player_speed_hud();
  }
}

set_player_speed_hud() {
  if(level.mp_createfx) {
    return;
  }
  if(!isDefined(level._createfx.player_speed_hud)) {
    var_0 = newhudelem();
    var_0.alignx = "right";
    var_0.foreground = 1;
    var_0.fontscale = 1.2;
    var_0.alpha = 0.2;
    var_0.x = 320;
    var_0.y = 420;
    var_1 = newhudelem();
    var_1.alignx = "left";
    var_1.foreground = 1;
    var_1.fontscale = 1.2;
    var_1.alpha = 0.2;
    var_1.x = 320;
    var_1.y = 420;
    var_0.hud_value = var_1;
    level._createfx.player_speed_hud = var_0;
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

is_ent_filtered_out(var_0, var_1) {
  if(var_1 != "") {
    if(isDefined(var_0.v["type"]) && issubstr(var_0.v["type"], var_1)) {
      return 0;
    } else if(isDefined(var_0.v["fxid"]) && issubstr(var_0.v["fxid"], var_1)) {
      return 0;
    } else if(isDefined(var_0.v["soundalias"]) && issubstr(var_0.v["soundalias"], var_1)) {
      return 0;
    }

    return 1;
  }

  return 0;
}

manipulate_createfx_ents(var_0, var_1, var_2, var_3, var_4) {
  if(!level.createfx_draw_enabled) {
    return;
  }
  if(level._createfx.select_by_name) {
    level._createfx.select_by_name = 0;
    var_0 = undefined;
  } else if(select_by_substring()) {
    var_0 = undefined;
  }

  for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
    var_6 = level.createfxent[var_5];

    if(!var_6.drawn) {
      continue;
    }
    if(is_ent_filtered_out(var_6, getdvar("createfx_filter"))) {
      continue;
    }
    var_7 = getdvarfloat("createfx_scaleid");

    if(isDefined(var_0) && var_6 == var_0) {
      if(!scripts\common\createfxmenu::entities_are_selected()) {
        scripts\common\createfxmenu::display_fx_info(var_6);
      }

      if(var_1) {
        var_8 = index_is_selected(var_5);
        level.createfx_selecting = !var_8;

        if(!var_3) {
          var_9 = level._createfx.selected_fx_ents.size;
          clear_entity_selection();

          if(var_8 && var_9 == 1) {
            select_entity(var_5, var_6);
          }
        }

        toggle_entity_selection(var_5, var_6);
      } else if(var_2) {
        if(var_3) {
          if(level.createfx_selecting) {
            select_entity(var_5, var_6);
          }

          if(!level.createfx_selecting) {
            deselect_entity(var_5, var_6);
          }
        }
      }

      var_10 = "highlighted";
    } else {
      var_10 = "default";
    }

    if(index_is_selected(var_5)) {
      var_10 = "selected";
    }

    var_6 createfx_print3d(var_10, var_7, var_4);
  }
}

draw_origin(var_0, var_1) {
  var_2 = level.player getvieworigin();
  var_3 = level.player getplayerangles();
  var_4 = level._createfx.colors[self.v["type"]][var_1];
  var_5 = 0;
  var_6 = 1;
  var_7 = (0, 0, 0);
  var_8 = distancesquared(var_2, self.v["origin"]) < 36864;

  if(var_8) {
    var_9 = distance(var_2, self.v["origin"]);
    var_10 = var_9 / 176;
    var_5 = 1 - clamp(var_10, 0.0, 1.0);
    var_6 = clamp(var_10, 0.333, 1.0);
    var_11 = anglestoright(var_3) * -4;
    var_12 = anglestoup(var_3) * -4.666;
    var_7 = var_11 + var_12;
  }

  if(var_5 > 0) {
    var_13 = scripts\engine\utility::within_fov(var_2, var_3, self.v["origin"], 0.422618);

    if(var_13) {
      var_14 = 2.0;
      var_15 = 4.0;
      var_16 = anglesToForward(self.v["angles"]);
      var_16 = var_16 * (var_15 * var_0);
      var_17 = anglestoright(self.v["angles"]) * -1;
      var_17 = var_17 * (var_15 * var_0);
      var_18 = anglestoup(self.v["angles"]);
      var_18 = var_18 * (var_15 * var_0);
    }
  }
}

createfx_print3d(var_0, var_1, var_2) {
  draw_origin(var_1, var_0);

  if(self.textalpha > 0) {
    var_3 = get_print3d_text();
    var_4 = var_2 * (var_3[0].size * -2.93);
    var_5 = level._createfx.colors[self.v["type"]][var_0];

    if(isDefined(self.is_playing)) {
      var_5 = (1, 0.5, 0);
    }

    var_6 = 15;

    foreach(var_8 in var_3) {
      var_6 = var_6 - 13;
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
      var_0[0] = "reactive sound: " + self.v["soundalias"];

      if(!level.mp_createfx) {
        var_0[1] = "reactive FX: " + self.v["fxid"];
      }

      return var_0;
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

handle_selected_ents(var_0) {
  if(level._createfx.selected_fx_ents.size > 0) {
    var_0 = selected_ent_buttons(var_0);

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
      thread[[level.var_process_fx_rotater]]();

      if(button_is_clicked("enter", "p")) {
        reset_axis_of_selected_ents();
      }

      if(button_is_clicked("v")) {
        copy_angles_of_selected_ents();
      }

      for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
        level._createfx.selected_fx_ents[var_1] draw_axis();
      }

      if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0) {
        var_0 = 1;
      }
    } else {
      set_tool_hudelem("Mode:", "move");
      var_2 = get_selected_move_vector();

      for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
        var_3 = level._createfx.selected_fx_ents[var_1];

        if(isDefined(var_3.model)) {
          continue;
        }
        var_3 draw_cross();
        var_3.v["origin"] = var_3.v["origin"] + var_2;
      }

      if(distance((0, 0, 0), var_2) > 0) {
        var_0 = 1;
      }
    }
  } else {
    clear_tool_hud();
  }

  return var_0;
}

selected_ent_buttons(var_0) {
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
    var_0 = 1;
  }

  if(button_is_clicked("tab", "BUTTON_RSHLDR")) {
    move_selection_to_cursor();
    var_0 = 1;
  }

  if(button_is_clicked("e")) {
    convert_selection_to_exploder();
    var_0 = 1;
  }

  return var_0;
}

modify_rate() {
  var_0 = button_is_held("shift");
  var_1 = button_is_held("ctrl");

  if(button_is_clicked("=")) {
    if(var_0) {
      level._createfx.rate = level._createfx.rate + 1;
    } else if(var_1) {
      if(level._createfx.rate < 1) {
        level._createfx.rate = 1;
      } else {
        level._createfx.rate = level._createfx.rate + 10;
      }
    } else {
      level._createfx.rate = level._createfx.rate + 0.1;
    }
  } else if(button_is_clicked("-")) {
    if(var_0) {
      level._createfx.rate = level._createfx.rate - 1;
    } else if(var_1) {
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

  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_1.v["angles"] = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1].v["angles"];
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

reset_axis_of_selected_ents() {
  level notify("new_ent_selection");

  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_1.v["angles"] = (0, 0, 0);
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

last_selected_entity_has_changed(var_0) {
  if(isDefined(var_0)) {
    if(!scripts\common\createfxmenu::entities_are_selected()) {
      return 1;
    }
  } else {
    return scripts\common\createfxmenu::entities_are_selected();
  }

  return var_0 != level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}

drop_selection_to_ground() {
  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_2 = bulletTrace(var_1.v["origin"], var_1.v["origin"] + (0, 0, -2048), 0, undefined);
    var_1.v["origin"] = var_2["position"];
  }
}

set_off_exploders() {
  level notify("createfx_exploder_reset");
  var_0 = [];

  for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    var_2 = level._createfx.selected_fx_ents[var_1];

    if(isDefined(var_2.v["exploder"])) {
      var_0[var_2.v["exploder"]] = 1;
    }
  }

  var_3 = getarraykeys(var_0);

  for(var_1 = 0; var_1 < var_3.size; var_1++) {
    scripts\engine\utility::exploder(var_3[var_1]);
  }
}

draw_distance() {
  var_0 = 0;

  if(getdvarint("createfx_drawdist") == 0) {}

  for(;;) {
    var_1 = getdvarint("createfx_drawdist");
    var_1 = var_1 * var_1;

    for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
      var_3 = level.createfxent[var_2];
      var_3.drawn = distancesquared(level.player.origin, var_3.v["origin"]) <= var_1;
      var_0++;

      if(var_0 > 100) {
        var_0 = 0;
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
    scripts\engine\utility::flag_waitopen("createfx_saving");

    if(getdvarint("createfx_no_autosave")) {
      continue;
    }
    generate_fx_log(1);
  }
}

rotate_over_time(var_0, var_1) {
  level endon("new_ent_selection");
  var_2 = 0.1;

  for(var_3 = 0; var_3 < var_2 * 20; var_3++) {
    if(level.selectedrotate_pitch != 0) {
      var_0 addpitch(level.selectedrotate_pitch);
    } else if(level.selectedrotate_yaw != 0) {
      var_0 addyaw(level.selectedrotate_yaw);
    } else {
      var_0 addroll(level.selectedrotate_roll);
    }

    wait 0.05;
    var_0 draw_axis();

    for(var_4 = 0; var_4 < level._createfx.selected_fx_ents.size; var_4++) {
      var_5 = level._createfx.selected_fx_ents[var_4];

      if(isDefined(var_5.model)) {
        continue;
      }
      var_5.v["origin"] = var_1[var_4].origin;
      var_5.v["angles"] = var_1[var_4].angles;
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
  var_0 = level._createfx.options[level._createfx.selected_fx_option_index]["name"];

  for(var_1 = 0; var_1 < level.createfxent.size; var_1++) {
    var_2 = level.createfxent[var_1];

    if(!ent_is_selected(var_2)) {
      continue;
    }
    var_2 remove_option(var_0);
  }

  update_selected_entities();
  clear_settable_fx();
}

remove_option(var_0) {
  self.v[var_0] = undefined;
}

delete_selection() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.createfxent.size; var_1++) {
    var_2 = level.createfxent[var_1];

    if(ent_is_selected(var_2)) {
      if(isDefined(var_2.loopsound_ent)) {
        var_2.loopsound_ent stoploopsound();
        var_2.loopsound_ent delete();
      }

      if(isDefined(var_2.looper)) {
        var_2.looper delete();
      }

      var_2 notify("stop_loop");
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  level.createfxent = var_0;
  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
  clear_fx_hudelements();
  remove_axis_model();
}

move_selection_to_cursor() {
  var_0 = level.createfxcursor["position"];

  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }
  var_1 = get_center_of_array(level._createfx.selected_fx_ents);
  var_2 = var_1 - var_0;

  for(var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
    var_4 = level._createfx.selected_fx_ents[var_3];

    if(isDefined(var_4.model)) {
      continue;
    }
    var_4.v["origin"] = var_4.v["origin"] - var_2;

    if(level._createfx.snap2normal) {
      if(isDefined(level.createfxcursor["normal"])) {
        var_4.v["angles"] = vectortoangles(level.createfxcursor["normal"]);
      }
    }
  }
}

convert_selection_to_exploder() {
  if(level._createfx.selected_fx_ents.size < 1) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level._createfx.selected_fx_ents) {
    if(var_2.v["type"] == "oneshotfx") {
      var_0 = 1;
      createnewexploder_internal(var_2);
      continue;
    }
  }

  if(var_0) {
    scripts\common\createfxmenu::setmenu("none");
    scripts\common\createfxmenu::display_fx_info(scripts\common\createfxmenu::get_last_selected_ent());
  }
}

select_last_entity() {
  select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
}

select_all_exploders_of_currently_selected(var_0) {
  var_1 = [];

  foreach(var_3 in level._createfx.selected_fx_ents) {
    if(!isDefined(var_3.v[var_0])) {
      continue;
    }
    var_4 = var_3.v[var_0];
    var_1[var_4] = 1;
  }

  foreach(var_4, var_7 in var_1) {
    foreach(var_9, var_3 in level.createfxent) {
      if(index_is_selected(var_9)) {
        continue;
      }
      if(!isDefined(var_3.v[var_0])) {
        continue;
      }
      if(var_3.v[var_0] != var_4) {
        continue;
      }
      select_entity(var_9, var_3);
    }
  }

  update_selected_entities();
}

copy_ents() {
  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }
  var_0 = [];

  for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    var_2 = level._createfx.selected_fx_ents[var_1];
    var_3 = spawnStruct();
    var_3.v = var_2.v;
    var_3 post_entity_creation_function();
    var_0[var_0.size] = var_3;
  }

  level.stored_ents = var_0;
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

  for(var_0 = 0; var_0 < level.stored_ents.size; var_0++) {
    add_and_select_entity(level.stored_ents[var_0]);
  }

  move_selection_to_cursor();
  update_selected_entities();
  level.stored_ents = [];
  copy_ents();
}

add_and_select_entity(var_0) {
  level.createfxent[level.createfxent.size] = var_0;
  select_last_entity();
}

get_center_of_array(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = (var_1[0] + var_0[var_2].v["origin"][0], var_1[1] + var_0[var_2].v["origin"][1], var_1[2] + var_0[var_2].v["origin"][2]);
  }

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

goto_selected() {
  var_0 = undefined;

  if(level._createfx.selected_fx_ents.size > 0) {
    var_0 = get_center_of_array(level._createfx.selected_fx_ents);
  } else if(isDefined(level.fx_highlightedent)) {
    var_0 = level.fx_highlightedent.v["origin"];
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = vectortoangles(level.player.origin - var_0);
  var_2 = var_0 + anglesToForward(var_1) * 200;
  level.player setorigin(var_2 + (0, 0, -60));
  level.player setplayerangles(vectortoangles(var_0 - var_2));
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

print_fx_options(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level._createfx.options.size; var_3++) {
    var_4 = level._createfx.options[var_3];
    var_5 = var_4["name"];

    if(!isDefined(var_0.v[var_5])) {
      continue;
    }
    if(!scripts\common\createfxmenu::mask(var_4["mask"], var_0.v["type"])) {
      continue;
    }
    if(!level.mp_createfx) {
      if(scripts\common\createfxmenu::mask("fx", var_0.v["type"]) && var_5 == "fxid") {
        continue;
      }
      if(var_0.v["type"] == "exploder" && var_5 == "exploder") {
        continue;
      }
      var_6 = var_0.v["type"] + "\" + var_5;

      if(isDefined(level._createfx.defaults[var_6]) && level._createfx.defaults[var_6] == var_0.v[var_5]) {
        continue;
      }
    }

    if(var_4["type"] == "string") {
      var_7 = var_0.v[var_5] + "";

      if(var_7 == "nil") {
        continue;
      }
      cfxprintln(var_1 + "ent.v[\"" + var_5 + "\"] = \"" + var_0.v[var_5] + "\";");
      continue;
    }

    cfxprintln(var_1 + "ent.v[\"" + var_5 + "\"] = " + var_0.v[var_5] + ";");
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
  for(var_0 = 0; var_0 < level._createfx.hudelem_count; var_0++) {
    level._createfx.hudelems[var_0][0].color = (1, 1, 1);
  }
}

toggle_entity_selection(var_0, var_1) {
  if(isDefined(level._createfx.selected_fx[var_0])) {
    deselect_entity(var_0, var_1);
  } else {
    select_entity(var_0, var_1);
  }
}

select_entity(var_0, var_1) {
  if(isDefined(level._createfx.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  var_1 thread entity_highlight_enable();
  level._createfx.selected_fx[var_0] = 1;
  level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = var_1;
}

ent_is_highlighted(var_0) {
  if(!isDefined(level.fx_highlightedent)) {
    return 0;
  }

  return var_0 == level.fx_highlightedent;
}

deselect_entity(var_0, var_1) {
  if(!isDefined(level._createfx.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  level._createfx.selected_fx[var_0] = undefined;

  if(!ent_is_highlighted(var_1)) {
    var_1 thread entity_highlight_disable();
  }

  var_2 = [];

  for(var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
    if(level._createfx.selected_fx_ents[var_3] != var_1) {
      var_2[var_2.size] = level._createfx.selected_fx_ents[var_3];
    }
  }

  level._createfx.selected_fx_ents = var_2;
}

index_is_selected(var_0) {
  return isDefined(level._createfx.selected_fx[var_0]);
}

ent_is_selected(var_0) {
  for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    if(level._createfx.selected_fx_ents[var_1] == var_0) {
      return 1;
    }
  }

  return 0;
}

clear_entity_selection() {
  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    if(!ent_is_highlighted(level._createfx.selected_fx_ents[var_0])) {
      level._createfx.selected_fx_ents[var_0] thread entity_highlight_disable();
    }
  }

  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
}

draw_axis() {}

set_axis_model(var_0) {
  if(!isDefined(level._createfx.axis)) {
    level._createfx.axis = spawn("script_model", (0, 0, 0));
  } else if(level._createfx.axis.model != var_0) {
    level._createfx.axis setModel(var_0);
  }
}

remove_axis_model() {
  if(!isDefined(level._createfx.axis)) {
    return;
  }
  level._createfx.axis delete();
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

createfx_centerprint(var_0) {
  thread createfx_centerprint_thread(var_0);
}

createfx_centerprint_thread(var_0) {
  level notify("new_createfx_centerprint");
  level endon("new_createfx_centerprint");
  wait 4.5;
}

get_selected_move_vector() {
  var_0 = level.player getplayerangles()[1];
  var_1 = (0, var_0, 0);
  var_2 = anglestoright(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = anglestoup(var_1);
  var_5 = 0;
  var_6 = level._createfx.rate;

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedmove_forward < 0) {
      level.selectedmove_forward = 0;
    }

    level.selectedmove_forward = level.selectedmove_forward + var_6;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedmove_forward > 0) {
      level.selectedmove_forward = 0;
    }

    level.selectedmove_forward = level.selectedmove_forward - var_6;
  } else {
    level.selectedmove_forward = 0;
  }

  if(buttondown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedmove_right < 0) {
      level.selectedmove_right = 0;
    }

    level.selectedmove_right = level.selectedmove_right + var_6;
  } else if(buttondown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedmove_right > 0) {
      level.selectedmove_right = 0;
    }

    level.selectedmove_right = level.selectedmove_right - var_6;
  } else {
    level.selectedmove_right = 0;
  }

  if(buttondown("BUTTON_Y")) {
    if(level.selectedmove_up < 0) {
      level.selectedmove_up = 0;
    }

    level.selectedmove_up = level.selectedmove_up + var_6;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedmove_up > 0) {
      level.selectedmove_up = 0;
    }

    level.selectedmove_up = level.selectedmove_up - var_6;
  } else {
    level.selectedmove_up = 0;
  }

  var_7 = (0, 0, 0);
  var_7 = var_7 + var_3 * level.selectedmove_forward;
  var_7 = var_7 + var_2 * level.selectedmove_right;
  var_7 = var_7 + var_4 * level.selectedmove_up;
  return var_7;
}

set_anglemod_move_vector() {
  var_0 = level._createfx.rate;
  var_1 = level._createfx.snap2anglesnaps[level._createfx.snap2angle];

  if(var_1 != 0) {
    var_0 = 0;
  }

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedrotate_pitch < 0) {
      level.selectedrotate_pitch = 0;
    }

    level.selectedrotate_pitch = level.selectedrotate_pitch + var_1 + var_0;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedrotate_pitch > 0) {
      level.selectedrotate_pitch = 0;
    }

    level.selectedrotate_pitch = level.selectedrotate_pitch - var_1 - var_0;
  } else {
    level.selectedrotate_pitch = 0;
  }

  if(buttondown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedrotate_yaw < 0) {
      level.selectedrotate_yaw = 0;
    }

    level.selectedrotate_yaw = level.selectedrotate_yaw + var_1 + var_0;
  } else if(buttondown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedrotate_yaw > 0) {
      level.selectedrotate_yaw = 0;
    }

    level.selectedrotate_yaw = level.selectedrotate_yaw - var_1 - var_0;
  } else {
    level.selectedrotate_yaw = 0;
  }

  if(buttondown("BUTTON_Y")) {
    if(level.selectedrotate_roll < 0) {
      level.selectedrotate_roll = 0;
    }

    level.selectedrotate_roll = level.selectedrotate_roll + var_1 + var_0;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedrotate_roll > 0) {
      level.selectedrotate_roll = 0;
    }

    level.selectedrotate_roll = level.selectedrotate_roll - var_1 - var_0;
  } else {
    level.selectedrotate_roll = 0;
  }
}

update_selected_entities() {
  var_0 = 0;

  foreach(var_2 in level._createfx.selected_fx_ents) {
    if(var_2.v["type"] == "reactive_fx") {
      var_0 = 1;
    }

    var_2[[level.var_updatefx]]();
  }

  if(var_0) {
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
    var_0 = getarraykeys(level._effect);
  } else {
    var_0 = getarraykeys(level._effect);

    if(var_0.size == level._effect_keys.size) {
      return level._effect_keys;
    }
  }

  var_0 = scripts\engine\utility::alphabetize(var_0);
  level._effect_keys = var_0;
  return var_0;
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

  foreach(var_1 in level.createfxent) {
    if(var_1.v["type"] == "reactive_fx") {
      var_1 set_forward_and_up_vectors();
      var_1 scripts\common\fx::add_reactive_fx();
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
    var_0 = get_center_of_array(level._createfx.selected_fx_ents);
    var_1 = spawn("script_origin", var_0);
    var_1.v["angles"] = level._createfx.selected_fx_ents[0].v["angles"];
    var_1.v["origin"] = var_0;
    var_2 = [];

    for(var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
      var_2[var_3] = spawn("script_origin", level._createfx.selected_fx_ents[var_3].v["origin"]);
      var_2[var_3].angles = level._createfx.selected_fx_ents[var_3].v["angles"];
      var_2[var_3] linkto(var_1);
    }

    rotate_over_time(var_1, var_2);
    var_1 delete();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3] delete();
    }
  } else if(level._createfx.selected_fx_ents.size == 1) {
    var_4 = level._createfx.selected_fx_ents[0];
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2.angles = var_4.v["angles"];

    if(level.selectedrotate_pitch != 0) {
      var_2 addpitch(level.selectedrotate_pitch);
    } else if(level.selectedrotate_yaw != 0) {
      var_2 addyaw(level.selectedrotate_yaw);
    } else {
      var_2 addroll(level.selectedrotate_roll);
    }

    var_4.v["angles"] = var_2.angles;
    var_2 delete();
    wait 0.05;
  }

  level.fx_rotating = 0;
}

spawn_grenade() {
  playFX(level._createfx.grenade.fx, level.createfxcursor["position"]);
  level._createfx.grenade playSound(level._createfx.grenade.sound);
  radiusdamage(level.createfxcursor["position"], level._createfx.grenade.radius, 50, 5, undefined, "MOD_EXPLOSIVE");
  level notify("code_damageradius", undefined, level._createfx.grenade.radius, level.createfxcursor["position"]);
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

generate_fx_log(var_0) {}

write_log(var_0, var_1, var_2, var_3) {
  var_4 = "\\t";
  cfxprintlnstart();
  cfxprintln("\\_createfx generated. Do not touch!!");
  cfxprintln("#include scripts\\common\\utility;");
  cfxprintln("#include scripts\\common\\createfx;\\n");
  cfxprintln("");
  cfxprintln("main()");
  cfxprintln("{");
  cfxprintln(var_4 + "\\CreateFX " + var_1 + " entities placed: " + var_0.size);

  foreach(var_6 in var_0) {
    if(level.createfx_loopcounter > 16) {
      level.createfx_loopcounter = 0;
      wait 0.1;
    }

    level.createfx_loopcounter++;

    if(getdvarint("scr_map_exploder_dump")) {
      if(!isDefined(var_6.model)) {
        continue;
      }
    } else if(isDefined(var_6.model)) {
      continue;
    }
    if(var_6.v["type"] == "oneshotfx") {
      cfxprintln(var_4 + "ent = createOneshotEffect(\"" + var_6.v["fxid"] + "\");");
    }

    if(var_6.v["type"] == "loopfx") {
      cfxprintln(var_4 + "ent = createLoopEffect(\"" + var_6.v["fxid"] + "\");");
    }

    if(var_6.v["type"] == "exploder") {
      if(isDefined(var_6.v["exploder"]) && !level.mp_createfx) {
        cfxprintln(var_4 + "ent = createExploderEx(\"" + var_6.v["fxid"] + "\", \"" + var_6.v["exploder"] + "\");");
      } else {
        cfxprintln(var_4 + "ent = createExploder(\"" + var_6.v["fxid"] + "\");");
      }
    }

    if(var_6.v["type"] == "soundfx") {
      cfxprintln(var_4 + "ent = createLoopSound();");
    }

    if(var_6.v["type"] == "soundfx_interval") {
      cfxprintln(var_4 + "ent = createIntervalSound();");
    }

    if(var_6.v["type"] == "reactive_fx") {
      if(var_1 == "fx" && var_6.v["fxid"] != "No FX" && !level.mp_createfx) {
        cfxprintln(var_4 + "ent = createReactiveEnt(\"" + var_6.v["fxid"] + "\");");
      } else if(var_1 == "sound" && var_6.v["fxid"] == "No FX") {
        cfxprintln(var_4 + "ent = createReactiveEnt();");
      } else {
        continue;
      }
    }

    cfxprintln(var_4 + "ent set_origin_and_angles(" + var_6.v["origin"] + ", " + var_6.v["angles"] + ");");
    print_fx_options(var_6, var_4, var_2);
    cfxprintln("");
  }

  cfxprintln("}");
  cfxprintln(" ");
  cfxprintlnend(var_2, var_3, var_1);
}

createfx_adjust_array() {
  var_0 = 0.1;

  foreach(var_2 in level.createfxent) {
    var_3 = [];
    var_4 = [];

    for(var_5 = 0; var_5 < 3; var_5++) {
      var_3[var_5] = var_2.v["origin"][var_5];
      var_4[var_5] = var_2.v["angles"][var_5];

      if(var_3[var_5] < var_0 && var_3[var_5] > var_0 * -1) {
        var_3[var_5] = 0;
      }

      if(var_4[var_5] < var_0 && var_4[var_5] > var_0 * -1) {
        var_4[var_5] = 0;
      }
    }

    var_2.v["origin"] = (var_3[0], var_3[1], var_3[2]);
    var_2.v["angles"] = (var_4[0], var_4[1], var_4[2]);
  }
}

get_createfx_array(var_0) {
  var_1 = get_createfx_types(var_0);
  var_2 = [];

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = [];
  }

  foreach(var_7 in level.createfxent) {
    var_8 = 0;

    foreach(var_5, var_0 in var_1) {
      if(var_7.v["type"] != var_0) {
        continue;
      }
      var_8 = 1;
      var_2[var_5][var_2[var_5].size] = var_7;
      break;
    }
  }

  var_11 = [];

  for(var_12 = 0; var_12 < var_1.size; var_12++) {
    foreach(var_7 in var_2[var_12]) {
      var_11[var_11.size] = var_7;
    }
  }

  return var_11;
}

get_createfx_types(var_0) {
  var_1 = [];

  if(var_0 == "fx") {
    var_1[0] = "oneshotfx";
    var_1[1] = "loopfx";
    var_1[2] = "exploder";
    var_1[3] = "reactive_fx";
  } else {
    var_1[0] = "soundfx";
    var_1[1] = "soundfx_interval";
    var_1[2] = "reactive_fx";
  }

  return var_1;
}

check_reactive_fx_type(var_0, var_1) {
  if(var_0.v["fxid"] != "No FX" && var_1 == "fx") {
    return 1;
  }

  if(var_0.v["fxid"] == "No FX" && var_1 == "sound") {
    return 1;
  }

  return 0;
}

is_createfx_type(var_0, var_1) {
  var_2 = get_createfx_types(var_1);

  if(var_0.v["type"] == "reactive_fx") {
    if(check_reactive_fx_type(var_0, var_1)) {
      return 1;
    } else {
      return 0;
    }
  }

  foreach(var_4 in var_2) {
    if(var_0.v["type"] == var_4) {
      return 1;
    }
  }

  return 0;
}

createfx_filter_types() {
  var_0 = [];
  var_0[var_0.size] = "soundfx";
  var_0[var_0.size] = "oneshotfx";
  var_0[var_0.size] = "exploder";
  var_0[var_0.size] = "soundfx_interval";
  var_0[var_0.size] = "reactive_fx";

  if(!level.mp_createfx) {
    var_0[var_0.size] = "loopfx";
  }

  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_4] = [];
  }

  foreach(var_6 in level.createfxent) {
    var_7 = 0;

    foreach(var_4, var_9 in var_0) {
      if(var_6.v["type"] != var_9) {
        continue;
      }
      var_7 = 1;
      var_1[var_4][var_1[var_4].size] = var_6;
      break;
    }
  }

  var_11 = [];

  for(var_12 = 0; var_12 < var_0.size; var_12++) {
    foreach(var_6 in var_1[var_12]) {
      var_11[var_11.size] = var_6;
    }
  }

  level.createfxent = var_11;
}

cfxprintlnstart() {
  scripts\engine\utility::fileprint_launcher_start_file();
}

cfxprintln(var_0) {
  scripts\engine\utility::fileprint_launcher(var_0);
}

cfxprintlnend(var_0, var_1, var_2) {
    var_3 = 1;

    if(var_1 != "" || var_0) {
      var_3 = 0;
    }

    if(scripts\engine\utility::issp()) {
      var_4 = scripts\engine\utility::get_template_script_MAYBE() + var_1 + "_" + var_2 + ".gsc";

      if(var_0) {
        var_4 = "backup_" + var_2 + ".gsc";
      }
    } else {
      var_4 = scripts\engine\utility::get_template_script_MAYBE() + var_1 + "_" + var_2 + ".gsc";

      if(var_0) {
        var_4 = "backup.gsc";
      }
    }

    var_5 = scripts\engine\utility::get_template_script_MAYBE();
    var_6 = get_raw_or_devraw_subdir();
    var_7 = get_gamemode_subdir();
    scripts\engine\utility::fileprint_launcher_end_file("\share\" + var_6 + "\
      scripts\" + var_7 + "\
      maps\" + var_5 + "\
      gen\" + var_4, var_3);
    }

    get_raw_or_devraw_subdir() {
      if(isDefined(level.createfx_devraw_map) && level.createfx_devraw_map) {
        return "devraw";
      } else {
        return "raw";
      }
    }

    get_gamemode_subdir() {
      if(scripts\engine\utility::iscp()) {
        return "cp";
      } else if(scripts\engine\utility::issp()) {
        return "sp";
      } else {
        return "mp";
      }
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

    locked(var_0) {
      if(isDefined(level._createfx.lockedlist[var_0])) {
        return 0;
      }

      return kb_locked(var_0);
    }

    kb_locked(var_0) {
      return level.createfx_inputlocked && isDefined(level.button_is_kb[var_0]);
    }

    add_button(var_0) {
      if(locked(var_0)) {
        return;
      }
      if(!isDefined(level.buttonisheld[var_0])) {
        if(level.player buttonpressed(var_0)) {
          level.buttonisheld[var_0] = 1;
          level.buttonclick[var_0] = 1;
        }
      } else if(!level.player buttonpressed(var_0)) {
        level.buttonisheld[var_0] = undefined;
      }
    }

    add_kb_button(var_0) {
      level.button_is_kb[var_0] = 1;
      add_button(var_0);
    }

    buttondown(var_0, var_1) {
      return buttonpressed_internal(var_0) || buttonpressed_internal(var_1);
    }

    buttonpressed_internal(var_0) {
      if(!isDefined(var_0)) {
        return 0;
      }

      if(kb_locked(var_0)) {
        return 0;
      }

      return level.player buttonpressed(var_0);
    }

    button_is_held(var_0, var_1) {
      if(isDefined(var_1)) {
        if(isDefined(level.buttonisheld[var_1])) {
          return 1;
        }
      }

      return isDefined(level.buttonisheld[var_0]);
    }

    button_is_clicked(var_0, var_1) {
      if(isDefined(var_1)) {
        if(isDefined(level.buttonclick[var_1])) {
          return 1;
        }
      }

      return isDefined(level.buttonclick[var_0]);
    }

    init_huds() {
      level._createfx.hudelems = [];
      level._createfx.hudelem_count = 30;

      if(level.mp_createfx) {
        level._createfx.hudelem_count = 16;
      }

      var_0 = [];
      var_1 = [];
      var_0[0] = 0;
      var_1[0] = 0;
      var_0[1] = 1;
      var_1[1] = 1;
      var_0[2] = -2;
      var_1[2] = 1;
      var_0[3] = 1;
      var_1[3] = -1;
      var_0[4] = -2;
      var_1[4] = -1;
      level.cleartextmarker = newhudelem();
      level.cleartextmarker.alpha = 0;
      level.cleartextmarker.archived = 0;

      for(var_2 = 0; var_2 < level._createfx.hudelem_count; var_2++) {
        var_3 = [];

        for(var_4 = 0; var_4 < 1; var_4++) {
          var_5 = newhudelem();
          var_5.alignx = "left";
          var_5.archived = 0;
          var_5.location = 0;
          var_5.foreground = 1;
          var_5.fontscale = 1.4;
          var_5.sort = 20 - var_4;
          var_5.alpha = 1;
          var_5.x = 0 + var_0[var_4];
          var_5.y = 60 + var_1[var_4] + var_2 * 15;

          if(var_4 > 0) {
            var_5.color = (0, 0, 0);
          }

          var_3[var_3.size] = var_5;
        }

        level._createfx.hudelems[var_2] = var_3;
      }

      var_6 = newhudelem();
      var_6.archived = 0;
      var_6.alignx = "center";
      var_6.location = 0;
      var_6.foreground = 1;
      var_6.fontscale = 1.4;
      var_6.sort = 20;
      var_6.alpha = 1;
      var_6.x = 320;
      var_6.y = 40;
      level.createfx_centerprint = var_6;
    }

    init_crosshair() {
      var_0 = newhudelem();
      var_0.archived = 0;
      var_0.location = 0;
      var_0.alignx = "center";
      var_0.aligny = "middle";
      var_0.foreground = 1;
      var_0.fontscale = 1;
      var_0.sort = 20;
      var_0.alpha = 1;
      var_0.x = 320;
      var_0.y = 233;
    }

    clear_fx_hudelements() {
      level.cleartextmarker clearalltextafterhudelem();

      for(var_0 = 0; var_0 < level._createfx.hudelem_count; var_0++) {
        for(var_1 = 0; var_1 < 1; var_1++) {}
      }

      level.fxhudelements = 0;
    }

    set_fx_hudelement(var_0) {
      for(var_1 = 0; var_1 < 1; var_1++) {}

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

    new_tool_hud(var_0) {
      foreach(var_3, var_2 in level._createfx.tool_hudelems) {
        if(isDefined(var_2.value_hudelem)) {
          var_2.value_hudelem destroy();
        }

        var_2 destroy();
        level._createfx.tool_hudelems[var_3] = undefined;
      }

      level._createfx.tool_hud = var_0;
    }

    current_mode_hud(var_0) {
      return level._createfx.tool_hud == var_0;
    }

    clear_tool_hud() {
      new_tool_hud("");
    }

    new_tool_hudelem(var_0) {
      var_1 = newhudelem();
      var_1.archived = 0;
      var_1.alignx = "left";
      var_1.location = 0;
      var_1.foreground = 1;
      var_1.fontscale = 1.2;
      var_1.alpha = 1;
      var_1.x = 0;
      var_1.y = 320 + var_0 * 15;
      return var_1;
    }

    get_tool_hudelem(var_0) {
      if(isDefined(level._createfx.tool_hudelems[var_0])) {
        return level._createfx.tool_hudelems[var_0];
      }

      return undefined;
    }

    set_tool_hudelem(var_0, var_1) {
      if(level.mp_createfx) {
        return;
      }
      var_2 = get_tool_hudelem(var_0);

      if(!isDefined(var_2)) {
        var_2 = new_tool_hudelem(level._createfx.tool_hudelems.size);
        level._createfx.tool_hudelems[var_0] = var_2;
        var_2.text = var_0;
      }

      if(isDefined(var_1)) {
        if(isDefined(var_2.value_hudelem)) {
          var_3 = var_2.value_hudelem;
        } else {
          var_3 = new_tool_hudelem(level._createfx.tool_hudelems.size);
          var_3.x = var_3.x + 100;
          var_3.y = var_2.y;
          var_2.value_hudelem = var_3;
        }

        if(isDefined(var_3.text) && var_3.text == var_1) {
          return;
        }
        var_3.text = var_1;
      }
    }

    select_by_substring() {
      var_0 = getdvar("select_by_substring");

      if(var_0 == "") {
        return 0;
      }

      setdvar("select_by_substring", "");
      var_1 = [];

      foreach(var_4, var_3 in level.createfxent) {
        if(issubstr(var_3.v["fxid"], var_0)) {
          var_1[var_1.size] = var_4;
        }
      }

      if(var_1.size == 0) {
        return 0;
      }

      deselect_all_ents();
      select_index_array(var_1);

      foreach(var_6 in var_1) {
        var_3 = level.createfxent[var_6];
        select_entity(var_6, var_3);
      }

      return 1;
    }

    select_index_array(var_0) {
      foreach(var_2 in var_0) {
        var_3 = level.createfxent[var_2];
        select_entity(var_2, var_3);
      }
    }

    deselect_all_ents() {
      foreach(var_2, var_1 in level._createfx.selected_fx_ents) {
        deselect_entity(var_2, var_1);
      }
    }