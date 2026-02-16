/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\512.gsc
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
  var_2.drawn = 1;

  if(isDefined(var_1) && isDefined(level.createfxbyfxid)) {
    var_3 = level.createfxbyfxid[var_1];

    if(!isDefined(var_3)) {
      var_3 = [];
    }
    var_3[var_3.size] = var_2;
    level.createfxbyfxid[var_1] = var_3;
  }

  return var_2;
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

add_effect(var_0, var_1) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }
  level._effect[var_0] = loadfx(var_1);
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

  if(getDvar("serverCulledSounds") != "1") {
    var_0.v["server_culled"] = 0;
  }
  var_0.drawn = 1;
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
  var_0 = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }
  level.createfxent[level.createfxent.size] = var_0;
  var_0.v = [];
  var_0.v["type"] = "exploder";
  var_0.v["fxid"] = "No FX";
  var_0.v["soundalias"] = "nil";
  var_0.v["loopsound"] = "nil";
  var_0.v["angles"] = (0, 0, 0);
  var_0.v["origin"] = (0, 0, 0);
  var_0.v["exploder"] = 1;
  var_0.v["flag"] = "nil";
  var_0.v["exploder_type"] = "normal";
  var_0.drawn = 1;
  return var_0;
}

createexploderex(var_0, var_1) {
  var_2 = common_scripts\utility::createexploder(var_0);
  var_2.v["exploder"] = var_1;
  return var_2;
}

set_origin_and_angles(var_0, var_1) {
  self.v["origin"] = var_0;
  self.v["angles"] = var_1;
}

set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglesToForward(self.v["angles"]);
}

createfx_common() {
  precacheshader("black");

  if(level.mp_createfx) {
    hack_start("painter_mp");
  } else {
    hack_start("painter");
  }
  common_scripts\utility::flag_init("createfx_saving");

  if(!isDefined(level.createfx)) {
    level.createfx = [];
  }
  level.createfx_loopcounter = 0;
  var_0 = getEntArray();

  foreach(var_2 in var_0) {
    if(isspawner(var_2)) {
      var_2 delete();
    }
  }

  var_4 = getEntArray("trigger_multiple", "classname");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_4[var_5] delete();
  }
  var_4 = getEntArray("trigger_radius", "classname");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_4[var_5] delete();
  }
  level notify("createfx_common_done");
}

createfxlogic() {
  waittillframeend;
  common_scripts\_createfxmenu::menu_init();

  if(!isDefined(level._effect)) {
    level._effect = [];
  }
  if(getDvar("createfx_map") == "") {} else if(getDvar("createfx_map") == common_scripts\utility::get_template_level()) {
    [[level.func_position_player]]();
  }
  level.createfxhudelements = [];
  level.createfx_hudelements = 30;
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
  var_2 = newhudelem();
  var_2.location = 0;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.foreground = 1;
  var_2.fontscale = 2;
  var_2.sort = 20;
  var_2.alpha = 1;
  var_2.x = 320;
  var_2.y = 233;
  var_2 settext(".");
  level.cleartextmarker = newhudelem();
  level.cleartextmarker.alpha = 0;
  level.cleartextmarker settext("marker");

  for(var_3 = 0; var_3 < level.createfx_hudelements; var_3++) {
    var_4 = [];

    for(var_5 = 0; var_5 < 1; var_5++) {
      var_6 = newhudelem();
      var_6.alignx = "left";
      var_6.location = 0;
      var_6.foreground = 1;
      var_6.fontscale = 1.4;
      var_6.sort = 20 - var_5;
      var_6.alpha = 1;
      var_6.x = 0 + var_0[var_5];
      var_6.y = 60 + var_1[var_5] + var_3 * 15;

      if(var_5 > 0) {
        var_6.color = (0, 0, 0);
      }
      var_4[var_4.size] = var_6;
    }

    level.createfxhudelements[var_3] = var_4;
  }

  var_4 = [];

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_6 = newhudelem();
    var_6.alignx = "center";
    var_6.location = 0;
    var_6.foreground = 1;
    var_6.fontscale = 1.4;
    var_6.sort = 20 - var_5;
    var_6.alpha = 1;
    var_6.x = 320 + var_0[var_5];
    var_6.y = 80 + var_1[var_5];

    if(var_5 > 0) {
      var_6.color = (0, 0, 0);
    }
    var_4[var_4.size] = var_6;
  }

  level.createfx_centerprint = var_4;
  level.selectedmove_up = 0;
  level.selectedmove_forward = 0;
  level.selectedmove_right = 0;
  level.selectedrotate_pitch = 0;
  level.selectedrotate_roll = 0;
  level.selectedrotate_yaw = 0;
  level.selected_fx = [];
  level.selected_fx_ents = [];
  level.createfx_lockedlist = [];
  level.createfx_lockedlist["escape"] = 1;
  level.createfx_lockedlist["BUTTON_LSHLDR"] = 1;
  level.createfx_lockedlist["BUTTON_RSHLDR"] = 1;
  level.createfx_lockedlist["mouse1"] = 1;
  level.createfx_lockedlist["ctrl"] = 1;
  level.createfx_draw_enabled = 1;
  level.last_displayed_ent = undefined;
  level.buttonisheld = [];
  var_7 = 0;
  var_8 = (0, 0, 0);

  if(!level.mp_createfx) {
    var_8 = level.player.origin;
  }
  var_9 = [];
  var_9["loopfx"]["selected"] = (1, 1, 0.2);
  var_9["loopfx"]["highlighted"] = (0.4, 0.95, 1);
  var_9["loopfx"]["default"] = (0.3, 0.8, 1);
  var_9["oneshotfx"]["selected"] = (1, 1, 0.2);
  var_9["oneshotfx"]["highlighted"] = (0.4, 0.95, 1);
  var_9["oneshotfx"]["default"] = (0.3, 0.8, 1);
  var_9["exploder"]["selected"] = (1, 1, 0.2);
  var_9["exploder"]["highlighted"] = (1, 0.2, 0.2);
  var_9["exploder"]["default"] = (1, 0.1, 0.1);
  var_9["rainfx"]["selected"] = (1, 1, 0.2);
  var_9["rainfx"]["highlighted"] = (0.95, 0.4, 0.95);
  var_9["rainfx"]["default"] = (0.78, 0, 0.73);
  var_9["soundfx"]["selected"] = (1, 1, 0.2);
  var_9["soundfx"]["highlighted"] = (0.5, 1, 0.75);
  var_9["soundfx"]["default"] = (0.2, 0.9, 0.2);
  var_9["soundfx_interval"]["selected"] = (1, 1, 0.2);
  var_9["soundfx_interval"]["highlighted"] = (0.5, 1, 0.75);
  var_9["soundfx_interval"]["default"] = (0.2, 0.9, 0.2);
  var_10 = undefined;
  level.fx_rotating = 0;
  common_scripts\_createfxmenu::setmenu("none");
  level.createfx_selecting = 0;
  var_11 = newhudelem();
  var_11.x = -120;
  var_11.y = 200;
  var_11.foreground = 0;
  var_11 setshader("black", 250, 160);
  var_11.alpha = 0;
  level.createfx_inputlocked = 0;

  for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
    var_12 = level.createfxent[var_3];
    var_12 post_entity_creation_function();
  }

  thread draw_distance();
  var_13 = undefined;
  thread createfx_autosave();

  for(;;) {
    var_14 = 0;
    var_15 = anglestoright(level.player getplayerangles());
    var_16 = anglesToForward(level.player getplayerangles());
    var_17 = anglestoup(level.player getplayerangles());
    var_18 = 0.85;
    var_19 = var_16 * 750;
    level.createfxcursor = bulletTrace(level.player getEye(), level.player getEye() + var_19, 0, undefined);
    var_20 = undefined;
    level.buttonclick = [];
    level.button_is_kb = [];
    process_button_held_and_clicked();
    var_21 = button_is_held("ctrl", "BUTTON_LSHLDR");
    var_22 = button_is_clicked("mouse1", "BUTTON_A");
    var_23 = button_is_held("mouse1", "BUTTON_A");
    common_scripts\_createfxmenu::create_fx_menu();

    if(button_is_clicked("shift", "BUTTON_X")) {
      var_7 = !var_7;
    }
    if(button_is_clicked("F5")) {}

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
    if(button_is_clicked("end", "l")) {
      drop_selection_to_ground();
      var_14 = 1;
    }

    if(button_is_clicked("escape")) {
      clear_settable_fx();
    }
    if(button_is_clicked("space")) {
      set_off_exploders();
    }
    if(button_is_clicked("g")) {
      select_all_exploders_of_currently_selected("exploder");
      select_all_exploders_of_currently_selected("flag");
    }

    if(button_is_clicked("tab", "BUTTON_RSHLDR")) {
      move_selection_to_cursor();
      var_14 = 1;
    }

    if(button_is_held("h", "F1")) {
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
    if(var_21) {
      if(button_is_clicked("c")) {
        copy_ents();
      }
      if(button_is_clicked("v")) {
        paste_ents();
      }
    }

    if(isDefined(level.selected_fx_option_index)) {
      common_scripts\_createfxmenu::menu_fx_option_set();
    }
    for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
      var_12 = level.createfxent[var_3];
      var_24 = vectornormalize(var_12.v["origin"] - (level.player.origin + (0, 0, 55)));
      var_25 = vectordot(var_16, var_24);

      if(var_25 < var_18) {
        continue;
      }
      var_18 = var_25;
      var_20 = var_12;
    }

    level.fx_highlightedent = var_20;

    if(isDefined(var_20)) {
      if(isDefined(var_10)) {
        if(var_10 != var_20) {
          if(!ent_is_selected(var_10)) {
            var_10 thread entity_highlight_disable();
          }
          if(!ent_is_selected(var_20)) {
            var_20 thread entity_highlight_enable();
          }
        }
      } else if(!ent_is_selected(var_20)) {
        var_20 thread entity_highlight_enable();
      }
    }

    manipulate_createfx_ents(var_20, var_22, var_23, var_21, var_9, var_15);

    if(var_7 && level.selected_fx_ents.size > 0) {
      thread[[level.func_process_fx_rotater]]();

      if(button_is_clicked("enter", "p")) {
        reset_axis_of_selected_ents();
      }
      if(button_is_clicked("v")) {
        copy_angles_of_selected_ents();
      }
      for(var_3 = 0; var_3 < level.selected_fx_ents.size; var_3++) {
        level.selected_fx_ents[var_3] draw_axis();
      }
      if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0) {
        var_14 = 1;
      }
      wait 0.05;
    } else {
      var_26 = get_selected_move_vector();

      for(var_3 = 0; var_3 < level.selected_fx_ents.size; var_3++) {
        var_12 = level.selected_fx_ents[var_3];

        if(isDefined(var_12.model)) {
          continue;
        }
        var_12.v["origin"] = var_12.v["origin"] + var_26;
      }

      if(distance((0, 0, 0), var_26) > 0) {
        var_14 = 1;
      }
      wait 0.05;
    }

    if(var_14) {
      update_selected_entities();
    }
    if(!level.mp_createfx) {
      var_8 = [[level.func_position_player_get]](var_8);
    }
    var_10 = var_20;

    if(last_selected_entity_has_changed(var_13)) {
      level.effect_list_offset = 0;
      clear_settable_fx();
      common_scripts\_createfxmenu::setmenu("none");
    }

    if(level.selected_fx_ents.size) {
      var_13 = level.selected_fx_ents[level.selected_fx_ents.size - 1];
      continue;
    }

    var_13 = undefined;
  }
}

copy_angles_of_selected_ents() {
  level notify("new_ent_selection");

  for(var_0 = 0; var_0 < level.selected_fx_ents.size; var_0++) {
    var_1 = level.selected_fx_ents[var_0];
    var_1.v["angles"] = level.selected_fx_ents[level.selected_fx_ents.size - 1].v["angles"];
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

reset_axis_of_selected_ents() {
  level notify("new_ent_selection");

  for(var_0 = 0; var_0 < level.selected_fx_ents.size; var_0++) {
    var_1 = level.selected_fx_ents[var_0];
    var_1.v["angles"] = (0, 0, 0);
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

last_selected_entity_has_changed(var_0) {
  if(isDefined(var_0)) {
    if(!common_scripts\_createfxmenu::entities_are_selected()) {
      return 1;
    }
  } else {
    return common_scripts\_createfxmenu::entities_are_selected();
  }
  return var_0 != level.selected_fx_ents[level.selected_fx_ents.size - 1];
}

createfx_showorigin(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18) {}

drop_selection_to_ground() {
  for(var_0 = 0; var_0 < level.selected_fx_ents.size; var_0++) {
    var_1 = level.selected_fx_ents[var_0];
    var_2 = bulletTrace(var_1.v["origin"], var_1.v["origin"] + (0, 0, -2048), 0, undefined);
    var_1.v["origin"] = var_2["position"];
  }
}

set_off_exploders() {
  level notify("createfx_exploder_reset");
  var_0 = [];

  for(var_1 = 0; var_1 < level.selected_fx_ents.size; var_1++) {
    var_2 = level.selected_fx_ents[var_1];

    if(isDefined(var_2.v["exploder"])) {
      var_0[var_2.v["exploder"]] = 1;
    }
  }

  var_3 = getarraykeys(var_0);

  for(var_1 = 0; var_1 < var_3.size; var_1++) {
    common_scripts\utility::exploder(var_3[var_1]);
  }
}

draw_distance() {
  var_0 = 0;

  if(getdvarint("createfx_drawdist") == 0) {}

  for(;;) {
    var_1 = getdvarint("createfx_drawdist");

    for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
      var_3 = level.createfxent[var_2];
      var_3.drawn = distance(level.player.origin, var_3.v["origin"]) <= var_1;
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
  for(;;) {
    wait 300;
    common_scripts\utility::flag_waitopen("createfx_saving");
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

    for(var_4 = 0; var_4 < level.selected_fx_ents.size; var_4++) {
      var_5 = level.selected_fx_ents[var_4];

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
  if(!isDefined(level.selected_fx_option_index)) {
    return;
  }
  var_0 = level.createfx_options[level.selected_fx_option_index]["name"];

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
      if(isDefined(var_2.looper)) {
        var_2.looper delete();
      }
      var_2 notify("stop_loop");
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  level.createfxent = var_0;
  level.selected_fx = [];
  level.selected_fx_ents = [];
  clear_fx_hudelements();
}

move_selection_to_cursor() {
  var_0 = level.createfxcursor["position"];

  if(level.selected_fx_ents.size <= 0) {
    return;
  }
  var_1 = get_center_of_array(level.selected_fx_ents);
  var_2 = var_1 - var_0;

  for(var_3 = 0; var_3 < level.selected_fx_ents.size; var_3++) {
    var_4 = level.selected_fx_ents[var_3];

    if(isDefined(var_4.model)) {
      continue;
    }
    var_4.v["origin"] = var_4.v["origin"] - var_2;
  }
}

insert_effect() {
  common_scripts\_createfxmenu::setmenu("creation");
  level.effect_list_offset = 0;
  clear_fx_hudelements();
  set_fx_hudelement("Pick effect type to create:");
  set_fx_hudelement("1. One Shot fx");
  set_fx_hudelement("2. Looping fx");
  set_fx_hudelement("3. Looping sound");
  set_fx_hudelement("4. Exploder");
  set_fx_hudelement("5. One Shot Sound");
  set_fx_hudelement("(c) Cancel");
  set_fx_hudelement("(x) Exit");
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
  set_fx_hudelement("DpadMove selected entitise on X/Y or rotate pitch/yaw");
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
  set_fx_hudelement("[ Toggle FX Visibility");
  set_fx_hudelement("] Toggle ShowTris");
  set_fx_hudelement("F11 Toggle FX Profile");
}

select_last_entity() {
  select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
}

select_all_exploders_of_currently_selected(var_0) {
  var_1 = [];

  foreach(var_3 in level.selected_fx_ents) {
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
  if(level.selected_fx_ents.size <= 0) {
    return;
  }
  var_0 = [];

  for(var_1 = 0; var_1 < level.selected_fx_ents.size; var_1++) {
    var_2 = level.selected_fx_ents[var_1];
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

print_fx_options(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.createfx_options.size; var_4++) {
    var_5 = level.createfx_options[var_4];
    var_6 = var_5["name"];

    if(!isDefined(var_0.v[var_6])) {
      continue;
    }
    if(!common_scripts\_createfxmenu::mask(var_5["mask"], var_0.v["type"])) {
      continue;
    }
    if(!level.mp_createfx) {
      if(common_scripts\_createfxmenu::mask("fx", var_0.v["type"]) && var_6 == "fxid") {
        continue;
      }
      if(var_0.v["type"] == "exploder" && var_6 == "exploder") {
        continue;
      }
      var_7 = var_0.v["type"] + "/" + var_6;

      if(isDefined(level.createfxdefaults[var_7]) && level.createfxdefaults[var_7] == var_0.v[var_6]) {
        continue;
      }
    }

    if(var_5["type"] == "string") {
      var_8 = var_0.v[var_6] + "";

      if(var_8 == "nil") {
        continue;
      }
      cfxprintln(var_2, var_1 + "ent.v[ \"" + var_6 + "\" ] = \"" + var_0.v[var_6] + "\";");
      continue;
    }

    cfxprintln(var_2, var_1 + "ent.v[ \"" + var_6 + "\" ] = " + var_0.v[var_6] + ";");
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

toggle_createfx_drawing() {
  level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

manipulate_createfx_ents(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!level.createfx_draw_enabled) {
    return;
  }
  for(var_6 = 0; var_6 < level.createfxent.size; var_6++) {
    var_7 = level.createfxent[var_6];

    if(!var_7.drawn) {
      continue;
    }
    var_8 = getdvarfloat("createfx_scaleid");

    if(isDefined(var_0) && var_7 == var_0) {
      if(!common_scripts\_createfxmenu::entities_are_selected()) {
        common_scripts\_createfxmenu::display_fx_info(var_7);
      }
      if(var_1) {
        var_9 = index_is_selected(var_6);
        level.createfx_selecting = !var_9;

        if(!var_3) {
          var_10 = level.selected_fx_ents.size;
          clear_entity_selection();

          if(var_9 && var_10 == 1) {
            select_entity(var_6, var_7);
          }
        }

        toggle_entity_selection(var_6, var_7);
      } else if(var_2) {
        if(var_3) {
          if(level.createfx_selecting) {
            select_entity(var_6, var_7);
          }
          if(!level.createfx_selecting) {
            deselect_entity(var_6, var_7);
          }
        }
      }

      var_11 = "highlighted";

      if(index_is_selected(var_6)) {
        var_11 = "selected";
      }
      if(var_7.textalpha > 0) {
        var_12 = var_5 * (var_7.v["fxid"].size * -2.93 * var_8);
      }
      continue;
    }

    var_11 = "default";

    if(index_is_selected(var_6)) {
      var_11 = "selected";
    }
    if(var_7.textalpha > 0) {
      var_12 = var_5 * (var_7.v["fxid"].size * -2.93);
    }
  }
}

clear_settable_fx() {
  level.createfx_inputlocked = 0;
  level.selected_fx_option_index = undefined;
  reset_fx_hud_colors();
}

reset_fx_hud_colors() {
  for(var_0 = 0; var_0 < level.createfx_hudelements; var_0++) {
    level.createfxhudelements[var_0][0].color = (1, 1, 1);
  }
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

toggle_entity_selection(var_0, var_1) {
  if(isDefined(level.selected_fx[var_0])) {
    deselect_entity(var_0, var_1);
  } else {
    select_entity(var_0, var_1);
  }
}

select_entity(var_0, var_1) {
  if(isDefined(level.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  var_1 thread entity_highlight_enable();
  level.selected_fx[var_0] = 1;
  level.selected_fx_ents[level.selected_fx_ents.size] = var_1;
}

ent_is_highlighted(var_0) {
  if(!isDefined(level.fx_highlightedent)) {
    return 0;
  }
  return var_0 == level.fx_highlightedent;
}

deselect_entity(var_0, var_1) {
  if(!isDefined(level.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  level.selected_fx[var_0] = undefined;

  if(!ent_is_highlighted(var_1)) {
    var_1 thread entity_highlight_disable();
  }
  var_2 = [];

  for(var_3 = 0; var_3 < level.selected_fx_ents.size; var_3++) {
    if(level.selected_fx_ents[var_3] != var_1) {
      var_2[var_2.size] = level.selected_fx_ents[var_3];
    }
  }

  level.selected_fx_ents = var_2;
}

index_is_selected(var_0) {
  return isDefined(level.selected_fx[var_0]);
}

ent_is_selected(var_0) {
  for(var_1 = 0; var_1 < level.selected_fx_ents.size; var_1++) {
    if(level.selected_fx_ents[var_1] == var_0) {
      return 1;
    }
  }

  return 0;
}

clear_entity_selection() {
  for(var_0 = 0; var_0 < level.selected_fx_ents.size; var_0++) {
    if(!ent_is_highlighted(level.selected_fx_ents[var_0])) {
      level.selected_fx_ents[var_0] thread entity_highlight_disable();
    }
  }

  level.selected_fx = [];
  level.selected_fx_ents = [];
}

draw_axis() {
  var_0 = 25 * getdvarfloat("createfx_scaleid");
  var_1 = anglesToForward(self.v["angles"]);
  var_1 = var_1 * var_0;
  var_2 = anglestoright(self.v["angles"]);
  var_2 = var_2 * var_0;
  var_3 = anglestoup(self.v["angles"]);
  var_3 = var_3 * var_0;
}

clear_fx_hudelements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(var_0 = 0; var_0 < level.createfx_hudelements; var_0++) {
    for(var_1 = 0; var_1 < 1; var_1++) {
      level.createfxhudelements[var_0][var_1] settext("");
    }
  }

  level.fxhudelements = 0;
}

set_fx_hudelement(var_0) {
  for(var_1 = 0; var_1 < 1; var_1++) {
    level.createfxhudelements[level.fxhudelements][var_1] settext(var_0);
  }
  level.fxhudelements++;
}

createfx_centerprint(var_0) {
  thread createfx_centerprint_thread(var_0);
}

createfx_centerprint_thread(var_0) {
  level notify("new_createfx_centerprint");
  level endon("new_createfx_centerprint");

  for(var_1 = 0; var_1 < 5; var_1++) {
    level.createfx_centerprint[var_1] settext(var_0);
  }
  wait 4.5;

  for(var_1 = 0; var_1 < 5; var_1++) {
    level.createfx_centerprint[var_1] settext("");
  }
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
  return level.player buttonPressed(var_0);
}

get_selected_move_vector() {
  var_0 = level.player getplayerangles()[1];
  var_1 = (0, var_0, 0);
  var_2 = anglestoright(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = anglestoup(var_1);
  var_5 = 0;
  var_6 = 1;

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

process_button_held_and_clicked() {
  add_button("mouse1");
  add_kb_button("shift");
  add_kb_button("ctrl");
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
  add_kb_button("escape");
  add_kb_button("a");
  add_kb_button("g");
  add_button("F1");
  add_button("F5");
  add_button("F2");
  add_kb_button("c");
  add_kb_button("h");
  add_kb_button("i");
  add_kb_button("k");
  add_kb_button("l");
  add_kb_button("m");
  add_kb_button("p");
  add_kb_button("x");
  add_button("del");
  add_kb_button("end");
  add_kb_button("tab");
  add_kb_button("ins");
  add_kb_button("add");
  add_kb_button("space");
  add_kb_button("enter");
  add_kb_button("v");
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
}

locked(var_0) {
  if(isDefined(level.createfx_lockedlist[var_0])) {
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
    if(level.player buttonPressed(var_0)) {
      level.buttonisheld[var_0] = 1;
      level.buttonclick[var_0] = 1;
    }
  } else if(!level.player buttonPressed(var_0)) {
    level.buttonisheld[var_0] = undefined;
  }
}

add_kb_button(var_0) {
  level.button_is_kb[var_0] = 1;
  add_button(var_0);
}

set_anglemod_move_vector() {
  var_0 = 2;

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedrotate_pitch < 0) {
      level.selectedrotate_pitch = 0;
    }
    level.selectedrotate_pitch = level.selectedrotate_pitch + var_0;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedrotate_pitch > 0) {
      level.selectedrotate_pitch = 0;
    }
    level.selectedrotate_pitch = level.selectedrotate_pitch - var_0;
  } else {
    level.selectedrotate_pitch = 0;
  }
  if(buttondown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedrotate_yaw < 0) {
      level.selectedrotate_yaw = 0;
    }
    level.selectedrotate_yaw = level.selectedrotate_yaw + var_0;
  } else if(buttondown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedrotate_yaw > 0) {
      level.selectedrotate_yaw = 0;
    }
    level.selectedrotate_yaw = level.selectedrotate_yaw - var_0;
  } else {
    level.selectedrotate_yaw = 0;
  }
  if(buttondown("BUTTON_Y")) {
    if(level.selectedrotate_roll < 0) {
      level.selectedrotate_roll = 0;
    }
    level.selectedrotate_roll = level.selectedrotate_roll + var_0;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedrotate_roll > 0) {
      level.selectedrotate_roll = 0;
    }
    level.selectedrotate_roll = level.selectedrotate_roll - var_0;
  } else {
    level.selectedrotate_roll = 0;
  }
}

cfxprintlnstart() {
  common_scripts\utility:: fileprint_launcher_start_file();
}

cfxprintln(var_0, var_1) {
  common_scripts\utility:: fileprint_launcher(var_1);

    if(var_0 == -1) {
      return;
    }
}

cfxprintlnend(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_2 != "" || var_1) {
    var_3 = 0;
  }
  var_4 = common_scripts\utility::get_template_level() + var_2 + "_fx.gsc";

  if(var_1) {
    var_4 = "backup.gsc";
  }
  common_scripts\utility:: fileprint_launcher_end_file("/share/raw/maps/createfx/" + var_4, var_3);
}

update_selected_entities() {
  for(var_0 = 0; var_0 < level.selected_fx_ents.size; var_0++) {
    var_1 = level.selected_fx_ents[var_0];
    var_1[[level.func_updatefx]]();
  }
}

hack_start(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "painter_mp";
  }
  precachemenu(var_0);
  wait 0.05;

  if(var_0 == "painter_mp") {
    return;
  }
  level.player openpopupmenu(var_0);
  level.player closepopupmenu(var_0);
}

get_player() {
  return getEntArray("player", "classname")[0];
}

createfx_orgranize_array() {
  var_0 = [];
  var_0[0] = "soundfx";
  var_0[1] = "loopfx";
  var_0[2] = "oneshotfx";
  var_0[3] = "exploder";
  var_0[4] = "soundfx_interval";
  var_1 = [];

  foreach(var_4, var_3 in var_0) {}
  var_1[var_4] = [];

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
    foreach(var_6 in var_1[var_12]) {}
    var_11[var_11.size] = var_6;
  }

  level.createfxent = var_11;
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

  var_0 = common_scripts\utility::alphabetize(var_0);
  level._effect_keys = var_0;
  return var_0;
}

restart_fx_looper() {
  stop_fx_looper();
  set_forward_and_up_vectors();

  if(self.v["type"] == "loopfx") {
    common_scripts\_fx::create_looper();
  }
  if(self.v["type"] == "oneshotfx") {
    common_scripts\_fx::create_triggerfx();
  }
  if(self.v["type"] == "soundfx") {
    common_scripts\_fx::create_loopsound();
  }
  if(self.v["type"] == "soundfx_interval") {
    common_scripts\_fx::create_interval_sound();
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

  if(level.selected_fx_ents.size > 1) {
    var_0 = get_center_of_array(level.selected_fx_ents);
    var_1 = spawn("script_origin", var_0);
    var_1.v["angles"] = level.selected_fx_ents[0].v["angles"];
    var_1.v["origin"] = var_0;
    var_2 = [];

    for(var_3 = 0; var_3 < level.selected_fx_ents.size; var_3++) {
      var_2[var_3] = spawn("script_origin", level.selected_fx_ents[var_3].v["origin"]);
      var_2[var_3].angles = level.selected_fx_ents[var_3].v["angles"];
      var_2[var_3] linkto(var_1);
    }

    rotate_over_time(var_1, var_2);
    var_1 delete();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3] delete();
    }
  } else if(level.selected_fx_ents.size == 1) {
    var_4 = level.selected_fx_ents[0];
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

generate_fx_log(var_0) {}