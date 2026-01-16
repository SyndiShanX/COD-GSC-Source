/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_createfx.gsc
****************************************/

soundonly() {
  return getdvar("scr_createfx_type", "0") == "2";
}

fxonly() {
  return getdvar("scr_createfx_type", "0") == "1";
}

tracknoneditfx(var_0) {
  if(isdefined(level.tracked_ent)) {
    if(!isdefined(level.tracked_ents))
      level.tracked_ents = [];

    level.tracked_ents[level.tracked_ents.size] = level.tracked_ent.v;
  }

  level.tracked_ent = var_0;
}

createeffect(var_0, var_1) {
  var_2 = spawnstruct();

  if(soundonly())
    tracknoneditfx(var_2);
  else {
    if(!isdefined(level.createfxent))
      level.createfxent = [];

    level.createfxent[level.createfxent.size] = var_2;
  }

  var_2.v = [];
  var_2.v["type"] = var_0;
  var_2.v["fxid"] = var_1;
  var_2.v["angles"] = (0, 0, 0);
  var_2.v["origin"] = (0, 0, 0);
  var_2.drawn = 1;

  if(isdefined(var_1) && isdefined(level.createfxbyfxid)) {
    var_3 = level.createfxbyfxid[var_1];

    if(!isdefined(var_3))
      var_3 = [];

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

createloopsound() {
  var_0 = spawnstruct();

  if(fxonly())
    tracknoneditfx(var_0);
  else {
    if(!isdefined(level.createfxent))
      level.createfxent = [];

    level.createfxent[level.createfxent.size] = var_0;
  }

  var_0.v = [];
  var_0.v["type"] = "soundfx";
  var_0.v["fxid"] = "No FX";
  var_0.v["soundalias"] = "nil";
  var_0.v["angles"] = (0, 0, 0);
  var_0.v["origin"] = (0, 0, 0);
  var_0.v["server_culled"] = 1;

  if(getdvar("serverCulledSounds") != "1")
    var_0.v["server_culled"] = 0;

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

createdynamicambience() {
  var_0 = spawnstruct();

  if(fxonly())
    tracknoneditfx(var_0);
  else {
    if(!isdefined(level.createfxent))
      level.createfxent = [];

    level.createfxent[level.createfxent.size] = var_0;
  }

  var_0.v = [];
  var_0.v["origin"] = (0, 0, 0);
  var_0.v["dynamic_distance"] = 1000;
  var_0.v["fxid"] = "No FX";
  var_0.v["type"] = "soundfx_dynamic";
  var_0.v["ambiencename"] = "nil";
  return var_0;
}

createnewexploder() {
  var_0 = spawnstruct();

  if(fxonly())
    tracknoneditfx(var_0);
  else {
    if(!isdefined(level.createfxent))
      level.createfxent = [];

    level.createfxent[level.createfxent.size] = var_0;
  }

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

createreactiveent() {
  var_0 = spawnstruct();

  if(soundonly())
    tracknoneditfx(var_0);
  else {
    if(!isdefined(level.createfxent))
      level.createfxent = [];

    level.createfxent[level.createfxent.size] = var_0;
  }

  var_0.v = [];
  var_0.v["origin"] = (0, 0, 0);
  var_0.v["reactive_radius"] = 200;
  var_0.v["fxid"] = "No FX";
  var_0.v["type"] = "reactive_fx";
  var_0.v["soundalias"] = "nil";
  return var_0;
}

set_origin_and_angles(var_0, var_1) {
  if(isdefined(level.createfx_offset))
    var_0 = var_0 + level.createfx_offset;

  self.v["origin"] = var_0;
  self.v["angles"] = var_1;
}

set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglestoforward(self.v["angles"]);
}

convertoneshotfx() {
  if(level._createfx.selected_fx_ents.size < 1) {
    return;
  }
  setdvarifuninitialized("curr_exp_num", 1);
  var_0 = getdvarint("curr_exp_num");
  var_1 = 0;

  foreach(var_3 in level._createfx.selected_fx_ents) {
    if(var_3.v["type"] == "oneshotfx") {
      var_1 = 1;
      setfxkillondelete(var_3.looper, 1);
      waitframe();
      var_3 common_scripts\utility::pauseeffect();
      var_3.v["type"] = "exploder";
      var_3.v["exploder"] = var_0;
      var_3.v["exploder_type"] = "normal";
      var_3 common_scripts\utility::activate_individual_exploder();
      continue;
    }

    iprintln("^3Cannot convert createfx ent to exploder type=" + var_3.v["type"] + " at " + var_3.v["origin"]);
  }

  if(var_1)
    level._createfx.justconvertedoneshot = 1;
}

createfx_common() {
  precacheshader("black");
  level._createfx = spawnstruct();
  level._createfx.grenade = spawn("script_origin", (0, 0, 0));
  level._createfx.grenade.fx = loadfx("vfx\explosion\frag_grenade_default");
  level._createfx.grenade.sound = "null";
  level._createfx.grenade.radius = 256;
  wait 0.05;
  common_scripts\utility::flag_init("createfx_saving");
  common_scripts\utility::flag_init("createfx_started");

  if(!isdefined(level.createfx))
    level.createfx = [];

  level.createfx_loopcounter = 0;
  setdvar("ui_hidehud", "1");
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
  level._createfx.rate = 1;
  level._createfx.snap2normal = 0;
  level._createfx.snap90deg = 0;
  level._createfx.localrot = 0;
  level._createfx.axismode = 0;
  level._createfx.select_by_name = 0;
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
  var_0["oneshotfx"]["highlighted"] = (0.3, 0.6, 1);
  var_0["oneshotfx"]["default"] = (0.1, 0.2, 1);
  var_0["exploder"]["selected"] = (1, 1, 0.2);
  var_0["exploder"]["highlighted"] = (1, 0.2, 0.2);
  var_0["exploder"]["default"] = (1, 0.1, 0.1);
  var_0["rainfx"]["selected"] = (1, 1, 0.2);
  var_0["rainfx"]["highlighted"] = (0.95, 0.4, 0.95);
  var_0["rainfx"]["default"] = (0.78, 0, 0.73);
  var_0["soundfx"]["selected"] = (1, 1, 0.2);
  var_0["soundfx"]["highlighted"] = (0.2, 1, 0.2);
  var_0["soundfx"]["default"] = (0.1, 1, 0.1);
  var_0["soundfx_interval"]["selected"] = (1, 1, 0.2);
  var_0["soundfx_interval"]["highlighted"] = (0.3, 1, 0.3);
  var_0["soundfx_interval"]["default"] = (0.1, 1, 0.1);
  var_0["reactive_fx"]["selected"] = (1, 1, 0.2);
  var_0["reactive_fx"]["highlighted"] = (0.5, 1, 0.75);
  var_0["reactive_fx"]["default"] = (0.2, 0.9, 0.2);
  var_0["soundfx_dynamic"]["selected"] = (1, 1, 0.2);
  var_0["soundfx_dynamic"]["highlighted"] = (0.3, 1, 0.3);
  var_0["soundfx_dynamic"]["default"] = (0.1, 1, 0.1);
  level._createfx.colors = var_0;
}

createfxlogic() {
  waittillframeend;
  wait 0.05;

  if(getdvarint("createfx_god_mode") == 1) {}

  if(getdvarint("createfx_demigod_mode") == 1) {}

  if(!isdefined(level._effect))
    level._effect = [];

  if(getdvar("createfx_map") == "") {} else if(getdvar("createfx_map") == common_scripts\utility::get_template_level())
    [[level.func_position_player]]();

  init_crosshair();
  common_scripts\_createfxmenu::init_menu();
  init_huds();
  init_tool_hud();
  init_crosshair();
  init_level_variables();
  init_locked_list();
  init_colors();

  if(getdvar("createfx_use_f4") == "") {}

  if(getdvar("createfx_no_autosave") == "") {}

  level.createfx_draw_enabled = 1;
  level.last_displayed_ent = undefined;
  level.buttonisheld = [];
  var_0 = (0, 0, 0);
  common_scripts\utility::flag_set("createfx_started");

  if(!level.mp_createfx)
    var_0 = level.player.origin;

  var_1 = undefined;
  level.fx_rotating = 0;
  common_scripts\_createfxmenu::setmenu("none");
  level.createfx_selecting = 0;
  var_2 = newhudelem();
  var_2.x = -120;
  var_2.y = 200;
  var_2.foreground = 0;
  var_2 setshader("black", 250, 160);
  var_2.alpha = 0;
  level.createfx_inputlocked = 0;

  foreach(var_4 in level.createfxent)
  var_4 post_entity_creation_function();

  thread draw_distance();
  var_6 = undefined;
  thread createfx_autosave();
  level.createfx_last_movement_timer = 0;
  thread save_undo_buffer();
  thread setup_last_movement_timer();

  for (;;) {
    var_7 = 0;
    var_8 = anglestoright(level.player getplayerangles());
    var_9 = anglestoforward(level.player getplayerangles());
    var_10 = anglestoup(level.player getplayerangles());
    var_11 = 0.85;
    var_12 = var_9 * 750;
    level.createfxcursor = bullettrace(level.player geteye(), level.player geteye() + var_12, 0, undefined);
    var_13 = undefined;
    level.buttonclick = [];
    level.button_is_kb = [];
    process_button_held_and_clicked();
    var_14 = button_is_held("ctrl", "BUTTON_LSHLDR");
    var_15 = button_is_clicked("mouse1", "BUTTON_A");
    var_16 = button_is_held("mouse1", "BUTTON_A");
    var_17 = button_is_held("shift");
    common_scripts\_createfxmenu::create_fx_menu();
    var_18 = "F5";

    if(getdvarint("createfx_use_f4"))
      var_18 = "F4";

    if(button_is_clicked(var_18)) {

    }

    if(getdvarint("scr_createfx_dump"))
      generate_fx_log();

    if(button_is_clicked("F2"))
      toggle_createfx_drawing();

    if(button_is_clicked("ins"))
      insert_effect();

    if(button_is_clicked("del"))
      delete_pressed();

    if(button_is_clicked("escape"))
      clear_settable_fx();

    if(button_is_clicked("rightarrow", "space") && !level.createfx_menu_list_active)
      set_off_exploders();

    if(button_is_clicked("leftarrow") && !level.createfx_menu_list_active)
      turn_off_exploders();

    if(button_is_clicked("f"))
      frame_selected();

    if(button_is_clicked("u"))
      select_by_name_list();

    if(button_is_clicked("c"))
      convertoneshotfx();

    modify_player_speed();

    if(!var_14 && button_is_clicked("g")) {
      select_all_exploders_of_currently_selected("exploder");
      select_all_exploders_of_currently_selected("flag");
    }

    if(button_is_clicked("h", "F1"))
      show_help();

    if(button_is_clicked("BUTTON_LSTICK"))
      copy_ents();

    if(button_is_clicked("BUTTON_RSTICK"))
      paste_ents();

    if(button_is_clicked("z"))
      undo();

    if(button_is_clicked("z") && var_17)
      redo();

    if(var_14) {
      if(button_is_clicked("c"))
        copy_ents();

      if(button_is_clicked("v"))
        paste_ents();

      if(button_is_clicked("g"))
        spawn_grenade();
    }

    if(isdefined(level._createfx.selected_fx_option_index))
      common_scripts\_createfxmenu::menu_fx_option_set();

    for (var_19 = 0; var_19 < level.createfxent.size; var_19++) {
      var_4 = level.createfxent[var_19];
      var_20 = level.player getvieworigin();
      var_21 = vectornormalize(var_4.v["origin"] - var_20);
      var_22 = vectordot(var_9, var_21);

      if(var_22 < var_11) {
        continue;
      }
      var_11 = var_22;
      var_13 = var_4;
    }

    level.fx_highlightedent = var_13;

    if(isdefined(var_13)) {
      if(isdefined(var_1)) {
        if(var_1 != var_13) {
          if(!ent_is_selected(var_1))
            var_1 thread entity_highlight_disable();

          if(!ent_is_selected(var_13))
            var_13 thread entity_highlight_enable();
        }
      } else if(!ent_is_selected(var_13))
        var_13 thread entity_highlight_enable();
    }

    manipulate_createfx_ents(var_13, var_15, var_16, var_14, var_8);
    var_7 = handle_selected_ents(var_7);
    wait 0.05;

    if(var_7)
      update_selected_entities();

    if(!level.mp_createfx)
      var_0 = [
        [level.func_position_player_get]
      ](var_0);

    var_1 = var_13;

    if(last_selected_entity_has_changed(var_6)) {
      level.effect_list_offset = 0;
      clear_settable_fx();
      common_scripts\_createfxmenu::setmenu("none");
    }

    if(level._createfx.selected_fx_ents.size) {
      var_6 = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
      continue;
    }

    var_6 = undefined;
  }
}

modify_player_speed() {
  var_0 = 0;
  var_1 = button_is_held("ctrl");

  if(button_is_held(".")) {
    if(var_1) {
      if(level._createfx.player_speed < 190)
        level._createfx.player_speed = 190;
      else
        level._createfx.player_speed = level._createfx.player_speed + 10;
    } else
      level._createfx.player_speed = level._createfx.player_speed + 5;

    var_0 = 1;
  } else if(button_is_held(",")) {
    if(var_1) {
      if(level._createfx.player_speed > 190)
        level._createfx.player_speed = 190;
      else
        level._createfx.player_speed = level._createfx.player_speed - 10;
    } else
      level._createfx.player_speed = level._createfx.player_speed - 5;

    var_0 = 1;
  }

  if(var_0) {
    level._createfx.player_speed = clamp(level._createfx.player_speed, 5, 500);
    [
      [level.func_player_speed]
    ]();
    set_player_speed_hud();
  }
}

set_player_speed_hud() {
  if(!isdefined(level._createfx.player_speed_hud)) {
    var_0 = newhudelem();
    var_0.alignx = "right";
    var_0.foreground = 1;
    var_0.fontscale = 1.2;
    var_0.alpha = 1.0;
    var_0.x = 120;
    var_0.y = 420;
    var_1 = newhudelem();
    var_1.alignx = "left";
    var_1.foreground = 1;
    var_1.fontscale = 1.2;
    var_1.alpha = 1.0;
    var_1.x = 120;
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
  set_fx_hudelement("(c) Cancel >");
  set_fx_hudelement("(x) Exit >");
}

is_ent_filtered_out(var_0, var_1) {
  if(var_1 != "") {
    if(isdefined(var_0.v["type"]) && issubstr(var_0.v["type"], var_1))
      return 0;
    else if(isdefined(var_0.v["fxid"]) && issubstr(var_0.v["fxid"], var_1))
      return 0;
    else if(isdefined(var_0.v["soundalias"]) && issubstr(var_0.v["soundalias"], var_1))
      return 0;
    else if(isdefined(var_0.v["exploder"]) && issubstr(var_0.v["exploder"], var_1))
      return 0;

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
  } else if(select_by_substring())
    var_0 = undefined;

  for (var_5 = 0; var_5 < level.createfxent.size; var_5++) {
    var_6 = level.createfxent[var_5];

    if(!var_6.drawn) {
      continue;
    }
    if(is_ent_filtered_out(var_6, getdvar("createfx_filter"))) {
      continue;
    }
    var_7 = getdvarfloat("createfx_scaleid");

    if(isdefined(var_0) && var_6 == var_0) {
      if(!common_scripts\_createfxmenu::entities_are_selected())
        common_scripts\_createfxmenu::display_fx_info(var_6);

      if(var_1) {
        var_8 = index_is_selected(var_5);
        level.createfx_help_active = 0;
        level.createfx_selecting = !var_8;

        if(!var_3) {
          var_9 = level._createfx.selected_fx_ents.size;
          clear_entity_selection();

          if(var_8 && var_9 == 1)
            select_entity(var_5, var_6);
        }

        toggle_entity_selection(var_5, var_6);
      } else if(var_2) {
        if(var_3) {
          if(level.createfx_selecting)
            select_entity(var_5, var_6);

          if(!level.createfx_selecting)
            deselect_entity(var_5, var_6);
        }
      }

      var_10 = "highlighted";
    } else
      var_10 = "default";

    if(index_is_selected(var_5))
      var_10 = "selected";

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
  var_8 = int(max(16, getdvarfloat("createfx_crosshairdrawdist")));
  var_9 = int(max(16, getdvarfloat("createfx_accuratedrawdist")));
  var_10 = var_9 * var_9;
  var_11 = distancesquared(var_2, self.v["origin"]) < var_10 * var_0;

  if(var_11) {
    var_12 = distance(var_2, self.v["origin"]);
    var_13 = var_12 / (var_8 - 16);
    var_5 = 1 - clamp(var_13, 0.0, 1.0);
    var_6 = clamp(var_13, 0.333, 1.0);
    var_14 = anglestoright(var_3) * -2.5 * var_0;
    var_15 = anglestoup(var_3) * -3.5 * var_0;
    var_7 = var_14 + var_15;
  }

  if(var_5 > 0) {
    var_16 = common_scripts\utility::within_fov(var_2, var_3, self.v["origin"], 0.422618);

    if(var_16) {
      var_17 = 2.0;
      var_18 = 4.0;
      var_19 = anglestoforward(self.v["angles"]);
      var_19 = var_19 * (var_18 * var_0);
      var_20 = anglestoright(self.v["angles"]) * -1;
      var_20 = var_20 * (var_18 * var_0);
      var_21 = anglestoup(self.v["angles"]);
      var_21 = var_21 * (var_18 * var_0);
    }
  }
}

createfx_print3d(var_0, var_1, var_2) {
  if(getdvarint("fx_showLightGridSampleOffset") != 0) {
    var_3 = getdvarfloat("fx_lightGridSampleOffset");
    var_4 = anglestoforward(self.v["angles"]) * var_3;
  }

  draw_origin(var_1, var_0);

  if(self.textalpha > 0) {
    var_5 = get_print3d_text();
    var_6 = var_2 * (var_5.size * -2.93) * var_1;
    var_7 = level._createfx.colors[self.v["type"]][var_0];

    if(isdefined(self.is_playing))
      var_7 = (1, 0.5, 0);

    if(isdefined(self.v["reactive_radius"])) {
      return;
    }
    if(isdefined(self.v["dynamic_distance"])) {
      return;
    }
    return;
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
      if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
        if(self.v["fxid"] == "No FX")
          return "@)) " + self.v["soundalias"];
        else
          return self.v["fxid"] + " @))";
      } else
        return self.v["fxid"];
    case "oneshotfx":
      if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
        return self.v["fxid"] + " @))";
      else
        return self.v["fxid"];
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

handle_selected_ents(var_0) {
  if(level._createfx.selected_fx_ents.size > 0 && level.createfx_help_active == 0) {
    var_0 = selected_ent_buttons(var_0);

    if(!current_mode_hud("selected_ents")) {
      new_tool_hud("selected_ents");
      set_tool_hudelem("Mode:", "move");
      set_tool_hudelem("Move Rate(-\+):", level._createfx.rate);

      if(level._createfx.snap2normal) {
        var_1 = "on";
        var_2 = (0, 1, 0);
      } else {
        var_1 = "off";
        var_2 = (0.5, 0.5, 0.5);
      }

      set_tool_hudelem("Snap2Normal(S):", var_1, var_2);

      if(level._createfx.snap90deg) {
        var_3 = "on";
        var_4 = (0, 1, 0);
      } else {
        var_3 = "off";
        var_4 = (0.5, 0.5, 0.5);
      }

      set_tool_hudelem("90deg Snap(L):", var_3, var_4);

      if(level._createfx.localrot) {
        var_5 = "on";
        var_6 = (0, 1, 0);
      } else {
        var_5 = "off";
        var_6 = (0.5, 0.5, 0.5);
      }

      set_tool_hudelem("Local Rotation(R):", var_5, var_6);
    }

    if(level._createfx.axismode && level._createfx.selected_fx_ents.size > 0) {
      set_tool_hudelem("Mode:", "rotate");
      thread[[level.func_process_fx_rotater]]();

      if(button_is_clicked("p"))
        reset_axis_of_selected_ents();

      if(button_is_clicked("o"))
        aim_axis_of_selected_ents();

      if(button_is_clicked("v"))
        copy_angles_of_selected_ents();

      for (var_7 = 0; var_7 < level._createfx.selected_fx_ents.size; var_7++)
        level._createfx.selected_fx_ents[var_7] draw_axis();

      if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0)
        var_0 = 1;
    } else {
      set_tool_hudelem("Mode:", "move");
      var_8 = get_selected_move_vector();

      for (var_7 = 0; var_7 < level._createfx.selected_fx_ents.size; var_7++) {
        var_9 = level._createfx.selected_fx_ents[var_7];

        if(isdefined(var_9.model)) {
          continue;
        }
        var_9.v["origin"] = var_9.v["origin"] + var_8;
      }

      if(distance((0, 0, 0), var_8) > 0) {
        thread save_undo_buffer();
        level.createfx_last_movement_timer = 0;
        var_0 = 1;
      }
    }
  } else
    clear_tool_hud();

  return var_0;
}

selected_ent_buttons(var_0) {
  if(button_is_clicked("BUTTON_X"))
    toggle_axismode();

  modify_rate();

  if(button_is_clicked("s"))
    toggle_snap2normal();

  if(button_is_clicked("l"))
    toggle_snap90deg();

  if(button_is_clicked("r"))
    toggle_localrot();

  if(button_is_clicked("end")) {
    drop_selection_to_ground();
    var_0 = 1;
  }

  if(button_is_clicked("tab", "BUTTON_RSHLDR")) {
    move_selection_to_cursor();
    var_0 = 1;
  }

  return var_0;
}

modify_rate() {
  var_0 = button_is_held("shift");
  var_1 = button_is_held("ctrl");

  if(button_is_clicked("=")) {
    if(var_0)
      level._createfx.rate = level._createfx.rate + 0.025;
    else if(var_1) {
      if(level._createfx.rate < 1)
        level._createfx.rate = 1;
      else
        level._createfx.rate = level._createfx.rate + 10;
    } else
      level._createfx.rate = level._createfx.rate + 0.1;
  } else if(button_is_clicked("-")) {
    if(var_0)
      level._createfx.rate = level._createfx.rate - 0.025;
    else if(var_1) {
      if(level._createfx.rate > 1)
        level._createfx.rate = 1;
      else
        level._createfx.rate = 0.1;
    } else
      level._createfx.rate = level._createfx.rate - 0.1;
  }

  level._createfx.rate = clamp(level._createfx.rate, 0.025, 100);
  set_tool_hudelem("Move Rate(-\+):", level._createfx.rate);
}

toggle_axismode() {
  level._createfx.axismode = !level._createfx.axismode;
}

toggle_snap2normal() {
  level._createfx.snap2normal = !level._createfx.snap2normal;

  if(level._createfx.snap2normal) {
    var_0 = "on";
    var_1 = (0, 1, 0);
  } else {
    var_0 = "off";
    var_1 = (0.5, 0.5, 0.5);
  }

  set_tool_hudelem("Snap2Normal(S):", var_0, var_1);
}

toggle_snap90deg() {
  level._createfx.snap90deg = !level._createfx.snap90deg;

  if(level._createfx.snap90deg) {
    var_0 = "on";
    var_1 = (0, 1, 0);
  } else {
    var_0 = "off";
    var_1 = (0.5, 0.5, 0.5);
  }

  set_tool_hudelem("90deg Snap(L):", var_0, var_1);
}

toggle_localrot() {
  level._createfx.localrot = !level._createfx.localrot;

  if(level._createfx.localrot) {
    var_0 = "on";
    var_1 = (0, 1, 0);
  } else {
    var_0 = "off";
    var_1 = (0.5, 0.5, 0.5);
  }

  set_tool_hudelem("Local Rotation(R):", var_0, var_1);
}

copy_angles_of_selected_ents() {
  thread save_undo_buffer();
  level notify("new_ent_selection");

  for (var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_1.v["angles"] = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1].v["angles"];
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
  level.createfx_last_movement_timer = 0;
}

aim_axis_of_selected_ents() {
  thread save_undo_buffer();
  level notify("new_ent_selection");
  var_0 = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];

  for (var_1 = 0; var_1 < level._createfx.selected_fx_ents.size - 1; var_1++) {
    var_2 = level._createfx.selected_fx_ents[var_1];
    var_3 = vectortoangles(var_0.v["origin"] - var_2.v["origin"]);
    var_2.v["angles"] = var_3;
    var_2 set_forward_and_up_vectors();
  }

  update_selected_entities();
  level.createfx_last_movement_timer = 0;
}

reset_axis_of_selected_ents() {
  level notify("new_ent_selection");
  thread save_undo_buffer();

  for (var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_1.v["angles"] = (0, 0, 0);
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
  level.createfx_last_movement_timer = 0;
}

last_selected_entity_has_changed(var_0) {
  if(isdefined(var_0)) {
    if(!common_scripts\_createfxmenu::entities_are_selected())
      return 1;
  } else
    return common_scripts\_createfxmenu::entities_are_selected();

  return var_0 != level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}

drop_selection_to_ground() {
  thread save_undo_buffer();

  for (var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_2 = bullettrace(var_1.v["origin"], var_1.v["origin"] + (0, 0, -2048), 0, undefined);
    var_1.v["origin"] = var_2["position"];
  }

  level.createfx_last_movement_timer = 0;
}

set_off_exploders() {
  level notify("createfx_exploder_reset");
  var_0 = [];

  for (var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    var_2 = level._createfx.selected_fx_ents[var_1];

    if(isdefined(var_2.v["exploder"]))
      var_0[var_2.v["exploder"]] = 1;
  }

  var_3 = getarraykeys(var_0);

  for (var_1 = 0; var_1 < var_3.size; var_1++)
    common_scripts\_exploder::exploder(var_3[var_1]);
}

turn_off_exploders() {
  level notify("createfx_exploder_reset");
  var_0 = [];

  for (var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    var_2 = level._createfx.selected_fx_ents[var_1];

    if(isdefined(var_2.v["exploder"]))
      var_0[var_2.v["exploder"]] = 1;
  }

  var_3 = getarraykeys(var_0);

  for (var_1 = 0; var_1 < var_3.size; var_1++)
    common_scripts\_exploder::kill_exploder(var_3[var_1]);
}

draw_distance() {
  var_0 = 0;

  if(getdvarint("createfx_drawdist") == 0) {}

  for (;;) {
    var_1 = getdvarint("createfx_drawdist");
    var_1 = var_1 * var_1;

    for (var_2 = 0; var_2 < level.createfxent.size; var_2++) {
      var_3 = level.createfxent[var_2];
      var_3.drawn = distancesquared(level.player.origin, var_3.v["origin"]) <= var_1;
      var_0++;

      if(var_0 > 100) {
        var_0 = 0;
        wait 0.05;
      }
    }

    if(level.createfxent.size == 0)
      wait 0.05;
  }
}

createfx_autosave() {
  setdvarifuninitialized("createfx_autosave_time", "300");

  for (;;) {
    wait(getdvarint("createfx_autosave_time"));
    common_scripts\utility::flag_waitopen("createfx_saving");

    if(getdvarint("createfx_no_autosave")) {
      continue;
    }
    generate_fx_log(1);
  }
}

rotate_over_time(var_0, var_1) {
  level endon("new_ent_selection");
  var_2 = 0.1;

  for (var_3 = 0; var_3 < var_2 * 20; var_3++) {
    if(level.selectedrotate_pitch != 0)
      var_0 addpitch(level.selectedrotate_pitch);
    else if(level.selectedrotate_roll != 0)
      var_0 addyaw(level.selectedrotate_roll);
    else
      var_0 addroll(level.selectedrotate_yaw);

    wait 0.05;
    var_0 draw_axis();

    for (var_4 = 0; var_4 < level._createfx.selected_fx_ents.size; var_4++) {
      var_5 = level._createfx.selected_fx_ents[var_4];

      if(isdefined(var_5.model)) {
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
  if(!isdefined(level._createfx.selected_fx_option_index)) {
    return;
  }
  var_0 = level._createfx.options[level._createfx.selected_fx_option_index]["name"];

  for (var_1 = 0; var_1 < level.createfxent.size; var_1++) {
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
  save_undo_buffer();
  var_0 = [];

  for (var_1 = 0; var_1 < level.createfxent.size; var_1++) {
    var_2 = level.createfxent[var_1];

    if(ent_is_selected(var_2)) {
      if(isdefined(var_2.loopsound_ent)) {
        var_2.loopsound_ent stoploopsound();
        var_2.loopsound_ent delete();
      }

      if(isdefined(var_2.looper))
        var_2.looper delete();

      var_2 notify("stop_loop");
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  level.createfxent = var_0;
  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
  clear_fx_hudelements();
  save_redo_buffer();
}

move_selection_to_cursor() {
  thread save_undo_buffer();
  var_0 = level.createfxcursor["position"];

  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }
  var_1 = get_center_of_array(level._createfx.selected_fx_ents);
  var_2 = var_1 - var_0;

  for (var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
    var_4 = level._createfx.selected_fx_ents[var_3];

    if(isdefined(var_4.model)) {
      continue;
    }
    var_4.v["origin"] = var_4.v["origin"] - var_2;

    if(level._createfx.snap2normal) {
      if(isdefined(level.createfxcursor["normal"]))
        var_4.v["angles"] = vectortoangles(level.createfxcursor["normal"]);
    }
  }

  level.createfx_last_movement_timer = 0;
}

select_last_entity() {
  select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
}

reselect_entitites() {
  var_0 = [];

  for (var_1 = 0; var_1 < level.createfxent.size; var_1++) {
    if(index_is_selected(var_1))
      var_0[var_0.size] = var_1;
  }

  clear_entity_selection();
  select_index_array(var_0);
}

select_all_exploders_of_currently_selected(var_0) {
  var_1 = [];

  foreach(var_3 in level._createfx.selected_fx_ents) {
    if(!isdefined(var_3.v[var_0])) {
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
      if(!isdefined(var_3.v[var_0])) {
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

  for (var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    var_2 = level._createfx.selected_fx_ents[var_1];
    var_3 = spawnstruct();
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
  if(!isdefined(level.stored_ents)) {
    return;
  }
  clear_entity_selection();

  for (var_0 = 0; var_0 < level.stored_ents.size; var_0++)
    add_and_select_entity(level.stored_ents[var_0]);

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

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_1 = (var_1[0] + var_0[var_2].v["origin"][0], var_1[1] + var_0[var_2].v["origin"][1], var_1[2] + var_0[var_2].v["origin"][2]);

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

get_radius_of_array(var_0) {
  var_1 = var_0[0].v["origin"];
  var_2 = var_0[0].v["origin"];
  var_3 = var_1[0];
  var_4 = var_1[1];
  var_5 = var_1[2];
  var_6 = var_2[0];
  var_7 = var_2[1];
  var_8 = var_2[2];

  for (var_9 = 0; var_9 < var_0.size; var_9++) {
    var_10 = var_0[var_9].v["origin"];

    if(var_10[0] < var_1[0])
      var_3 = var_10[0];

    if(var_10[0] > var_2[0])
      var_6 = var_10[0];

    if(var_10[1] < var_1[1])
      var_4 = var_10[1];

    if(var_10[1] > var_2[1])
      var_7 = var_10[1];

    if(var_10[2] < var_1[2])
      var_5 = var_10[2];

    if(var_10[2] > var_2[2])
      var_8 = var_10[2];
  }

  var_1 = (var_3, var_4, var_5);
  var_2 = (var_6, var_7, var_8);
  var_11 = distance(var_2, var_1);
  return var_11;
}

ent_draw_axis() {
  self endon("death");

  for (;;) {
    draw_axis();
    wait 0.05;
  }
}

rotation_is_occuring() {
  if(level.selectedrotate_roll != 0)
    return 1;

  if(level.selectedrotate_pitch != 0)
    return 1;

  return level.selectedrotate_yaw != 0;
}

print_fx_options(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < level._createfx.options.size; var_3++) {
    var_4 = level._createfx.options[var_3];

    if(isdefined(var_4["nowrite"]) && var_4["nowrite"]) {
      continue;
    }
    var_5 = var_4["name"];

    if(!isdefined(var_0.v[var_5])) {
      continue;
    }
    if(!common_scripts\_createfxmenu::mask(var_4["mask"], var_0.v["type"])) {
      continue;
    }
    if(!level.mp_createfx) {
      if(common_scripts\_createfxmenu::mask("fx", var_0.v["type"]) && var_5 == "fxid") {
        continue;
      }
      if(var_0.v["type"] == "exploder" && var_5 == "exploder") {
        continue;
      }
      var_6 = var_0.v["type"] + "\" + var_5;

      if(isdefined(level._createfx.defaults[var_6]) && level._createfx.defaults[var_6] == var_0.v[var_5])
        continue;
    }

    if(var_4["type"] == "string") {
      var_7 = var_0.v[var_5] + "";

      if(var_7 == "nil") {
        continue;
      }
      if(var_5 == "platform" && var_7 == "all") {
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

  for (;;) {
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

  for (;;) {
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
  for (var_0 = 0; var_0 < level._createfx.hudelem_count; var_0++)
    level._createfx.hudelems[var_0][0].color = (1, 1, 1);
}

toggle_entity_selection(var_0, var_1) {
  if(isdefined(level._createfx.selected_fx[var_0]))
    deselect_entity(var_0, var_1);
  else
    select_entity(var_0, var_1);
}

select_entity(var_0, var_1) {
  if(isdefined(level._createfx.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  var_1 thread entity_highlight_enable();
  level._createfx.selected_fx[var_0] = 1;
  level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = var_1;
  level.createfx_menu_list_active = 0;
}

ent_is_highlighted(var_0) {
  if(!isdefined(level.fx_highlightedent))
    return 0;

  return var_0 == level.fx_highlightedent;
}

deselect_entity(var_0, var_1) {
  if(!isdefined(level._createfx.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  level._createfx.selected_fx[var_0] = undefined;

  if(!ent_is_highlighted(var_1))
    var_1 thread entity_highlight_disable();

  var_2 = [];

  for (var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
    if(level._createfx.selected_fx_ents[var_3] != var_1)
      var_2[var_2.size] = level._createfx.selected_fx_ents[var_3];
  }

  level._createfx.selected_fx_ents = var_2;
}

index_is_selected(var_0) {
  return isdefined(level._createfx.selected_fx[var_0]);
}

ent_is_selected(var_0) {
  for (var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    if(level._createfx.selected_fx_ents[var_1] == var_0)
      return 1;
  }

  return 0;
}

clear_entity_selection() {
  for (var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    if(!ent_is_highlighted(level._createfx.selected_fx_ents[var_0]))
      level._createfx.selected_fx_ents[var_0] thread entity_highlight_disable();
  }

  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
}

draw_axis() {}

draw_cross() {}

createfx_centerprint(var_0) {
  thread createfx_centerprint_thread(var_0);
}

createfx_centerprint_thread(var_0) {
  level notify("new_createfx_centerprint");
  level endon("new_createfx_centerprint");

  for (var_1 = 0; var_1 < 5; var_1++) {}

  wait 4.5;

  for (var_1 = 0; var_1 < 5; var_1++) {}
}

get_selected_move_vector() {
  var_0 = level.player getplayerangles()[1];
  var_1 = (0, var_0, 0);
  var_2 = anglestoright(var_1);
  var_3 = anglestoforward(var_1);
  var_4 = anglestoup(var_1);
  var_5 = 0;
  var_6 = level._createfx.rate;

  if(buttondown("DPAD_UP")) {
    if(level.selectedmove_forward < 0)
      level.selectedmove_forward = 0;

    level.selectedmove_forward = level.selectedmove_forward + var_6;
  } else if(buttondown("DPAD_DOWN")) {
    if(level.selectedmove_forward > 0)
      level.selectedmove_forward = 0;

    level.selectedmove_forward = level.selectedmove_forward - var_6;
  } else
    level.selectedmove_forward = 0;

  if(buttondown("DPAD_RIGHT")) {
    if(level.selectedmove_right < 0)
      level.selectedmove_right = 0;

    level.selectedmove_right = level.selectedmove_right + var_6;
  } else if(buttondown("DPAD_LEFT")) {
    if(level.selectedmove_right > 0)
      level.selectedmove_right = 0;

    level.selectedmove_right = level.selectedmove_right - var_6;
  } else
    level.selectedmove_right = 0;

  if(buttondown("BUTTON_Y")) {
    if(level.selectedmove_up < 0)
      level.selectedmove_up = 0;

    level.selectedmove_up = level.selectedmove_up + var_6;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedmove_up > 0)
      level.selectedmove_up = 0;

    level.selectedmove_up = level.selectedmove_up - var_6;
  } else
    level.selectedmove_up = 0;

  var_7 = (0, 0, 0);
  var_7 = var_7 + var_3 * level.selectedmove_forward;
  var_7 = var_7 + var_2 * level.selectedmove_right;
  var_7 = var_7 + var_4 * level.selectedmove_up;
  return var_7;
}

set_anglemod_move_vector() {
  if(!level._createfx.snap90deg)
    var_0 = level._createfx.rate;
  else
    var_0 = 90;

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedrotate_pitch < 0)
      level.selectedrotate_pitch = 0;

    level.selectedrotate_pitch = level.selectedrotate_pitch + var_0;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedrotate_pitch > 0)
      level.selectedrotate_pitch = 0;

    level.selectedrotate_pitch = level.selectedrotate_pitch - var_0;
  } else
    level.selectedrotate_pitch = 0;

  if(buttondown("DPAD_LEFT")) {
    if(level.selectedrotate_yaw < 0)
      level.selectedrotate_yaw = 0;

    level.selectedrotate_yaw = level.selectedrotate_yaw + var_0;
  } else if(buttondown("DPAD_RIGHT")) {
    if(level.selectedrotate_yaw > 0)
      level.selectedrotate_yaw = 0;

    level.selectedrotate_yaw = level.selectedrotate_yaw - var_0;
  } else
    level.selectedrotate_yaw = 0;

  if(buttondown("BUTTON_Y")) {
    if(level.selectedrotate_roll < 0)
      level.selectedrotate_roll = 0;

    level.selectedrotate_roll = level.selectedrotate_roll + var_0;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedrotate_roll > 0)
      level.selectedrotate_roll = 0;

    level.selectedrotate_roll = level.selectedrotate_roll - var_0;
  } else
    level.selectedrotate_roll = 0;
}

update_selected_entities() {
  var_0 = 0;

  foreach(var_2 in level._createfx.selected_fx_ents) {
    if(var_2.v["type"] == "reactive_fx")
      var_0 = 1;

    var_2[[level.func_updatefx]]();
  }

  if(var_0)
    refresh_reactive_fx_ents();
}

stop_fx_looper() {
  if(isdefined(self.looper))
    self.looper delete();

  stop_loopsound();
}

stop_fx_looper_on_exploder() {
  self endon("death");
  level waittill("exploding_" + self.v["stop_on_exploder"]);
  stop_fx_looper();
}

stop_loopsound() {
  self notify("stop_loop");

  if(isdefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }
}

func_get_level_fx() {
  if(!isdefined(level._effect_keys))
    var_0 = getarraykeys(level._effect);
  else {
    var_0 = getarraykeys(level._effect);

    if(var_0.size == level._effect_keys.size)
      return level._effect_keys;
  }

  var_0 = common_scripts\utility::alphabetize(var_0);
  level._effect_keys = var_0;
  return var_0;
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

  foreach(var_1 in level.createfxent) {
    if(var_1.v["type"] == "reactive_fx") {
      var_1 set_forward_and_up_vectors();
      var_1 common_scripts\_fx::add_reactive_fx();
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
    var_0 = get_center_of_array(level._createfx.selected_fx_ents);
    var_1 = spawn("script_origin", var_0);
    var_1.v["angles"] = level._createfx.selected_fx_ents[0].v["angles"];
    var_1.v["origin"] = var_0;
    var_2 = [];

    for (var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
      var_2[var_3] = spawn("script_origin", level._createfx.selected_fx_ents[var_3].v["origin"]);
      var_2[var_3].angles = level._createfx.selected_fx_ents[var_3].v["angles"];
      var_2[var_3] linktosynchronizedparent(var_1);
    }

    rotate_over_time(var_1, var_2);
    var_1 delete();

    for (var_3 = 0; var_3 < var_2.size; var_3++)
      var_2[var_3] delete();
  } else if(level._createfx.selected_fx_ents.size > 0) {
    foreach(var_5 in level._createfx.selected_fx_ents) {
      var_2 = spawn("script_origin", (0, 0, 0));
      var_2.angles = var_5.v["angles"];

      if(level.selectedrotate_pitch != 0)
        var_2 addpitch(level.selectedrotate_pitch);
      else if(level.selectedrotate_yaw != 0)
        var_2 addyaw(level.selectedrotate_yaw);
      else
        var_2 addroll(level.selectedrotate_roll);

      var_5.v["angles"] = var_2.angles;
      var_2 delete();
    }

    wait 0.05;
  }

  level.fx_rotating = 0;
}

spawn_grenade() {
  playfx(level._createfx.grenade.fx, level.createfxcursor["position"]);
  level._createfx.grenade playsound(level._createfx.grenade.sound);
  radiusdamage(level.createfxcursor["position"], level._createfx.grenade.radius, 50, 5, undefined, "MOD_EXPLOSIVE");
  level notify("code_damageradius", undefined, level._createfx.grenade.radius, level.createfxcursor["position"]);
}

show_help() {
  if(level.createfx_help_active == 1) {
    clear_fx_hudelements();
    level.createfx_help_active = 0;
    level.createfx_menu_list_active = 0;
    reselect_entitites();
  } else {
    level.createfx_help_active = 1;
    level.createfx_menu_list_active = 1;
    common_scripts\_createfxmenu::draw_help_list();
    thread common_scripts\_createfxmenu::help_navigation_buttons();
    clear_tool_hud();
  }

  wait 0.2;
}

generate_fx_log(var_0) {}

write_entity(var_0, var_1) {
  var_2 = "\t";

  if(getdvarint("scr_map_exploder_dump")) {
    if(!isdefined(var_0.model))
      return;
  } else if(isdefined(var_0.model)) {
    return;
  }
  if(var_0.v["type"] == "loopfx")
    cfxprintln(var_2 + "ent = createLoopEffect(\"" + var_0.v["fxid"] + "\");");

  if(var_0.v["type"] == "oneshotfx")
    cfxprintln(var_2 + "ent = createOneshotEffect(\"" + var_0.v["fxid"] + "\");");

  if(var_0.v["type"] == "exploder") {
    if(isdefined(var_0.v["exploder"]) && !level.mp_createfx)
      cfxprintln(var_2 + "ent = createExploderEx(\"" + var_0.v["fxid"] + "\", \"" + var_0.v["exploder"] + "\");");
    else
      cfxprintln(var_2 + "ent = createExploder(\"" + var_0.v["fxid"] + "\");");
  }

  if(var_0.v["type"] == "soundfx")
    cfxprintln(var_2 + "ent = createLoopSound();");

  if(var_0.v["type"] == "soundfx_interval")
    cfxprintln(var_2 + "ent = createIntervalSound();");

  if(var_0.v["type"] == "reactive_fx")
    cfxprintln(var_2 + "ent = createReactiveEnt();");

  if(var_0.v["type"] == "soundfx_dynamic")
    cfxprintln(var_2 + "ent = createDynamicAmbience();");

  cfxprintln(var_2 + "ent set_origin_and_angles(" + var_0.v["origin"] + ", " + var_0.v["angles"] + ");");
  print_fx_options(var_0, var_2, var_1);
  cfxprintln("");
}

write_log(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "\t";
  cfxprintlnstart();
  cfxprintln("\\_createfx generated. Do not touch!!");
  cfxprintln("#include common_scripts\\utility;");
  cfxprintln("#include common_scripts\\_createfx;\n");
  cfxprintln("");
  cfxprintln("main()");
  cfxprintln("{");
  var_6 = var_0.size;

  if(isdefined(var_4))
    var_6 = var_6 + var_4.size;

  cfxprintln(var_5 + "// CreateFX " + var_1 + " entities placed: " + var_6);

  foreach(var_8 in var_0) {
    if(level.createfx_loopcounter > 16) {
      level.createfx_loopcounter = 0;
      wait 0.1;
    }

    level.createfx_loopcounter++;
    write_entity(var_8, var_2);
  }

  if(isdefined(var_4)) {
    foreach(var_11 in var_4) {
      if(level.createfx_loopcounter > 16) {
        level.createfx_loopcounter = 0;
        wait 0.1;
      }

      level.createfx_loopcounter++;
      var_8 = spawnstruct();
      var_8.v = var_11;
      write_entity(var_8, var_2);
    }
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

    for (var_5 = 0; var_5 < 3; var_5++) {
      var_3[var_5] = var_2.v["origin"][var_5];
      var_4[var_5] = var_2.v["angles"][var_5];

      if(var_3[var_5] < var_0 && var_3[var_5] > var_0 * -1)
        var_3[var_5] = 0;

      if(var_4[var_5] < var_0 && var_4[var_5] > var_0 * -1)
        var_4[var_5] = 0;
    }

    var_2.v["origin"] = (var_3[0], var_3[1], var_3[2]);
    var_2.v["angles"] = (var_4[0], var_4[1], var_4[2]);
  }
}

get_createfx_array(var_0) {
  var_1 = get_createfx_types(var_0);
  var_2 = [];

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = [];

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

  for (var_12 = 0; var_12 < var_1.size; var_12++) {
    foreach(var_7 in var_2[var_12])
    var_11[var_11.size] = var_7;
  }

  return var_11;
}

get_createfx_types(var_0) {
  var_1 = [];

  if(var_0 == "fx") {
    var_1[0] = "loopfx";
    var_1[1] = "oneshotfx";
    var_1[2] = "exploder";
  } else {
    var_1[0] = "soundfx";
    var_1[1] = "soundfx_interval";
    var_1[2] = "reactive_fx";
    var_1[3] = "soundfx_dynamic";
  }

  return var_1;
}

is_createfx_type(var_0, var_1) {
  var_2 = get_createfx_types(var_1);

  foreach(var_4 in var_2) {
    if(var_0.v["type"] == var_4)
      return 1;
  }

  return 0;
}

createfx_filter_types() {
  var_0 = [];
  var_0[0] = "soundfx";
  var_0[1] = "loopfx";
  var_0[2] = "oneshotfx";
  var_0[3] = "exploder";
  var_0[4] = "soundfx_interval";
  var_0[5] = "reactive_fx";
  var_0[6] = "soundfx_dynamic";
  var_1 = [];

  foreach(var_4, var_3 in var_0)
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

  for (var_12 = 0; var_12 < var_0.size; var_12++) {
    foreach(var_6 in var_1[var_12])
    var_11[var_11.size] = var_6;
  }

  level.createfxent = var_11;
}

cfxprintlnstart() {
  common_scripts\utility::fileprint_launcher_start_file();
}

cfxprintln(var_0) {
  common_scripts\utility::fileprint_launcher(var_0);
}

cfxprintlnend(var_0, var_1, var_2) {
    var_3 = 1;

    if(var_1 != "" || var_0)
      var_3 = 0;

    if(common_scripts\utility::issp()) {
      var_4 = common_scripts\utility::get_template_level() + var_1 + "_" + var_2 + ".gsc";

      if(var_0)
        var_4 = "backup_" + var_2 + ".gsc";
    } else {
      var_4 = common_scripts\utility::get_template_level() + var_1 + "_" + var_2 + ".gsc";

      if(var_0)
        var_4 = "backup.gsc";
    }

    common_scripts\utility::fileprint_launcher_end_file("\share\raw\maps\createfx\" + var_4, var_3);
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
      add_kb_button("g");
      add_kb_button("c");
      add_kb_button("h");
      add_kb_button("i");
      add_kb_button("f");
      add_kb_button("k");
      add_kb_button("l");
      add_kb_button("m");
      add_kb_button("o");
      add_kb_button("p");
      add_kb_button("r");
      add_kb_button("s");
      add_kb_button("u");
      add_kb_button("v");
      add_kb_button("x");
      add_kb_button("y");
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
      if(isdefined(level._createfx.lockedlist[var_0]))
        return 0;

      return kb_locked(var_0);
    }

    kb_locked(var_0) {
      return level.createfx_inputlocked && isdefined(level.button_is_kb[var_0]);
    }

    add_button(var_0) {
      if(locked(var_0)) {
        return;
      }
      if(!isdefined(level.buttonisheld[var_0])) {
        if(level.player buttonpressed(var_0)) {
          level.buttonisheld[var_0] = 1;
          level.buttonclick[var_0] = 1;
        }
      } else if(!level.player buttonpressed(var_0))
        level.buttonisheld[var_0] = undefined;
    }

    add_kb_button(var_0) {
      level.button_is_kb[var_0] = 1;
      add_button(var_0);
    }

    buttondown(var_0, var_1) {
      return buttonpressed_internal(var_0) || buttonpressed_internal(var_1);
    }

    buttonpressed_internal(var_0) {
      if(!isdefined(var_0))
        return 0;

      if(kb_locked(var_0))
        return 0;

      return level.player buttonpressed(var_0);
    }

    button_is_held(var_0, var_1) {
      if(isdefined(var_1)) {
        if(isdefined(level.buttonisheld[var_1]))
          return 1;
      }

      return isdefined(level.buttonisheld[var_0]);
    }

    button_is_clicked(var_0, var_1) {
      if(isdefined(var_1)) {
        if(isdefined(level.buttonclick[var_1]))
          return 1;
      }

      return isdefined(level.buttonclick[var_0]);
    }

    init_huds() {
      level._createfx.hudelems = [];
      level._createfx.hudelem_count = 30;
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

      for (var_2 = 0; var_2 < level._createfx.hudelem_count; var_2++) {
        var_3 = [];

        for (var_4 = 0; var_4 < 1; var_4++) {
          var_5 = newhudelem();
          var_5.alignx = "left";
          var_5.location = 0;
          var_5.foreground = 1;
          var_5.fontscale = 1.4;
          var_5.sort = 20 - var_4;
          var_5.alpha = 1;
          var_5.x = 0 + var_0[var_4];
          var_5.y = 60 + var_1[var_4] + var_2 * 15;

          if(var_4 > 0)
            var_5.color = (0, 0, 0);

          var_3[var_3.size] = var_5;
        }

        level._createfx.hudelems[var_2] = var_3;
      }

      var_3 = [];

      for (var_4 = 0; var_4 < 5; var_4++) {
        var_5 = newhudelem();
        var_5.alignx = "center";
        var_5.location = 0;
        var_5.foreground = 1;
        var_5.fontscale = 1.4;
        var_5.sort = 20 - var_4;
        var_5.alpha = 1;
        var_5.x = 320 + var_0[var_4];
        var_5.y = 80 + var_1[var_4];

        if(var_4 > 0)
          var_5.color = (0, 0, 0);

        var_3[var_3.size] = var_5;
      }

      level.createfx_centerprint = var_3;
    }

    init_crosshair() {
      var_0 = newhudelem();
      var_0.location = 0;
      var_0.alignx = "center";
      var_0.aligny = "middle";
      var_0.foreground = 1;
      var_0.fontscale = 2;
      var_0.sort = 20;
      var_0.alpha = 1;
      var_0.x = 320;
      var_0.y = 233;
    }

    clear_fx_hudelements() {
      level.cleartextmarker clearalltextafterhudelem();

      for (var_0 = 0; var_0 < level._createfx.hudelem_count; var_0++) {
        for (var_1 = 0; var_1 < 1; var_1++) {

        }
      }

      level.fxhudelements = 0;
    }

    set_fx_hudelement(var_0) {
      for (var_1 = 0; var_1 < 1; var_1++) {}

      level.fxhudelements++;
    }

    init_tool_hud() {
      if(!isdefined(level._createfx.tool_hudelems))
        level._createfx.tool_hudelems = [];

      if(!isdefined(level._createfx.tool_hud_visible))
        level._createfx.tool_hud_visible = 1;

      if(!isdefined(level._createfx.tool_hud))
        level._createfx.tool_hud = "";
    }

    new_tool_hud(var_0) {
      foreach(var_3, var_2 in level._createfx.tool_hudelems) {
        if(isdefined(var_2.value_hudelem))
          var_2.value_hudelem destroy();

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
      if(isdefined(level._createfx.tool_hudelems[var_0]))
        return level._createfx.tool_hudelems[var_0];

      return undefined;
    }

    set_tool_hudelem(var_0, var_1, var_2) {
      var_3 = get_tool_hudelem(var_0);

      if(!isdefined(var_3)) {
        var_3 = new_tool_hudelem(level._createfx.tool_hudelems.size);
        level._createfx.tool_hudelems[var_0] = var_3;
        var_3.text = var_0;
      }

      if(isdefined(var_1)) {
        if(isdefined(var_3.value_hudelem))
          var_4 = var_3.value_hudelem;
        else {
          var_4 = new_tool_hudelem(level._createfx.tool_hudelems.size);
          var_4.x = var_4.x + 110;
          var_4.y = var_3.y;
          var_3.value_hudelem = var_4;
        }

        if(isdefined(var_4.text) && var_4.text == var_1) {
          return;
        }
        var_4.text = var_1;

        if(!isdefined(var_2))
          var_2 = (1, 1, 1);

        var_4.color = var_2;
      }
    }

    select_by_substring() {
      var_0 = getdvar("select_by_substring");

      if(var_0 == "")
        return 0;

      setdvar("select_by_substring", "");
      var_1 = [];

      foreach(var_4, var_3 in level.createfxent) {
        if(issubstr(var_3.v["fxid"], var_0))
          var_1[var_1.size] = var_4;
      }

      if(var_1.size == 0)
        return 0;

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
      foreach(var_2, var_1 in level._createfx.selected_fx_ents)
      deselect_entity(var_2, var_1);
    }

    setup_last_movement_timer() {
      wait 0.5;

      for (;;) {
        level.createfx_last_movement_timer = level.createfx_last_movement_timer + 0.05;

        if(level.createfx_last_movement_timer == 0.15) {
          foreach(var_1 in level._createfx.selected_fx_ents) {
            if(var_1.v["type"] == "exploder")
              var_1 common_scripts\utility::activate_individual_exploder();
          }

          common_scripts\_createfxmenu::display_current_translation();
          save_redo_buffer();
        }

        if(level.createfx_last_movement_timer == 0.05) {
          var_1 = common_scripts\_createfxmenu::get_last_selected_ent();
          common_scripts\_createfxmenu::display_current_translation();
        }

        wait 0.05;
      }
    }

    frame_selected() {
      if(level._createfx.selected_fx_ents.size < 1) {
        return;
      }
      if(level._createfx.selected_fx_ents.size > 1) {
        var_0 = get_center_of_array(level._createfx.selected_fx_ents);
        var_1 = get_radius_of_array(level._createfx.selected_fx_ents) + 200;
      } else {
        var_0 = level._createfx.selected_fx_ents[0].v["origin"];
        var_1 = 200;
      }

      var_2 = anglestoforward(level.player getplayerangles());
      var_3 = var_2 * (-1 * var_1);
      var_4 = level.player geteye();
      var_5 = var_4 - level.player.origin;
      level.player setorigin(var_0 + var_3 - var_5);
    }

    clear_all_loopers() {
      foreach(var_1 in level.createfxent) {
        if(isdefined(var_1.looper))
          var_1.looper delete();

        var_1 stop_loopsound();
      }
    }

    restart_oneshots() {
      foreach(var_1 in level.createfxent) {
        if(var_1.v["type"] == "oneshotfx")
          var_1 restart_fx_looper();
      }
    }

    restart_selected_exploders() {
      foreach(var_1 in level._createfx.selected_fx_ents) {
        if(isdefined(var_1) && var_1.v["type"] == "exploder")
          var_1 common_scripts\utility::activate_individual_exploder();
      }
    }

    save_undo_buffer() {
      if(isdefined(level.createfxent) && level.createfx_last_movement_timer > 0.15)
        level.createfxent_undo = copystructarrayvalues(level.createfxent);
    }

    save_redo_buffer() {
      if(isdefined(level.createfxent))
        level.createfxent_redo = copystructarrayvalues(level.createfxent);
    }

    undo() {
      if(isdefined(level.createfxent_undo)) {
        clear_all_loopers();
        level.createfxent = [];
        level.createfxent = copystructarrayvalues(level.createfxent_undo);
        clear_fx_hudelements();
        reselect_entitites();
        restart_oneshots();
        restart_selected_exploders();
      }
    }

    redo() {
      if(isdefined(level.createfxent_redo)) {
        clear_all_loopers();
        level.createfxent = [];
        level.createfxent = copystructarrayvalues(level.createfxent_redo);
        clear_fx_hudelements();
        reselect_entitites();
        restart_oneshots();
        restart_selected_exploders();
      }
    }

    copystructarrayvalues(var_0) {
      var_1 = [];

      if(var_0.size > 0) {
        for (var_2 = 0; var_2 < var_0.size; var_2++) {
          var_3 = spawnstruct();

          if(isdefined(var_0[var_2].v)) {
            var_3.v = [];
            var_3.v["type"] = var_0[var_2].v["type"];
            var_3.v["fxid"] = var_0[var_2].v["fxid"];
            var_3.v["soundalias"] = var_0[var_2].v["soundalias"];
            var_3.v["loopsound"] = var_0[var_2].v["loopsound"];
            var_3.v["angles"] = var_0[var_2].v["angles"];
            var_3.v["origin"] = var_0[var_2].v["origin"];
            var_3.v["exploder"] = var_0[var_2].v["exploder"];
            var_3.v["flag"] = var_0[var_2].v["flag"];
            var_3.v["exploder_type"] = var_0[var_2].v["exploder_type"];
            var_3.v["server_culled"] = var_0[var_2].v["server_culled"];
            var_3.v["delay_min"] = var_0[var_2].v["delay_min"];
            var_3.v["delay_max"] = var_0[var_2].v["delay_max"];
            var_3.v["delay"] = var_0[var_2].v["delay"];
            var_3.v["forward"] = var_0[var_2].v["forward"];
            var_3.v["up"] = var_0[var_2].v["up"];
            var_3.v["tintcolor"] = var_0[var_2].v["tintcolor"];
            var_3.v["tintalpha"] = var_0[var_2].v["tintalpha"];
            var_3.v["fadein"] = var_0[var_2].v["fadein"];
            var_3.v["fadeout"] = var_0[var_2].v["fadeout"];
            var_3.v["emissive"] = var_0[var_2].v["emissive"];
            var_3.v["sizescale"] = var_0[var_2].v["sizescale"];
            var_3.v["repeat"] = var_0[var_2].v["repeat"];
            var_3.v["reactive_radius"] = var_0[var_2].v["reactive_radius"];
            var_3.v["ambiencename"] = var_0[var_2].v["ambiencename"];
            var_3.v["dynamic_distance"] = var_0[var_2].v["dynamic_distance"];

            if(!level.mp_createfx) {
              var_3.v["firefx"] = var_0[var_2].v["firefx"];
              var_3.v["firefxdelay"] = var_0[var_2].v["firefxdelay"];
              var_3.v["firefxtimeout"] = var_0[var_2].v["firefxtimeout"];
              var_3.v["firefxsound"] = var_0[var_2].v["firefxsound"];
              var_3.v["damage"] = var_0[var_2].v["damage"];
              var_3.v["damage_radius"] = var_0[var_2].v["damage_radius"];
              var_3.v["earthquake"] = var_0[var_2].v["earthquake"];
              var_3.v["ender"] = var_0[var_2].v["ender"];
              var_3.v["rumble"] = var_0[var_2].v["rumble"];
              var_3.v["stoppable"] = var_0[var_2].v["stoppable"];
            }

            var_3.model = var_0[var_2].model;
            var_1[var_2] = var_3;
          }

          var_1[var_2].drawn = var_0[var_2].drawn;
          var_1[var_2].textalpha = var_0[var_2].textalpha;
        }
      }

      return var_1;
    }

    removefxentwithentity(var_0) {
      var_1 = [];

      foreach(var_4, var_3 in level.createfxent) {
        if(isdefined(var_3.model) && var_3.model == var_0) {
          continue;
        }
        var_1[var_1.size] = var_3;
      }

      level.createfxent = var_1;
    }