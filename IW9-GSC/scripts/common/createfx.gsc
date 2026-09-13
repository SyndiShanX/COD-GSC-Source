/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\createfx.gsc
***********************************************/

createeffect(type, _id_8C44BF99399EDF9A, _id_265E032B267ABF38) {
  ent = spawnStruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  if(!isDefined(_id_265E032B267ABF38))
    level.createfxent[level.createfxent.size] = ent;

  ent.v = [];
  ent.v["type"] = type;
  ent.v["fxid"] = _id_8C44BF99399EDF9A;
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  return ent;
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
  ent = spawnStruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v["type"] = "soundfx";
  ent.v["fxid"] = "No FX";
  ent.v["soundalias"] = "nil";
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.v["server_culled"] = 1;

  if(getDvar("serverculledsounds") != "1")
    ent.v["server_culled"] = 0;

  return ent;
}

createintervalsound() {
  ent = createloopsound();
  ent.v["type"] = "soundfx_interval";
  ent.v["delay_min"] = getintervalsounddelaymindefault();
  ent.v["delay_max"] = getintervalsounddelaymaxdefault();
  return ent;
}

createnewexploder() {
  if(!isDefined(level.createfxent))
    level.createfxent = [];

  ent = createnewexploder_internal();
  level.createfxent[level.createfxent.size] = ent;
  return ent;
}

add_exploder(_id_2724EA192F3E906D, ent) {
  array = [];

  if(isDefined(level.createfxexploders[_id_2724EA192F3E906D]))
    array = level.createfxexploders[_id_2724EA192F3E906D];

  array[array.size] = ent;
  level.createfxexploders[_id_2724EA192F3E906D] = array;
}

createnewexploder_internal(ent) {
  if(!isDefined(ent)) {
    ent = spawnStruct();
    ent.v = [];
  }

  ent.v["type"] = "exploder";
  ent.v["exploder_type"] = "normal";

  if(!isDefined(ent.v["fxid"]))
    ent.v["fxid"] = "No FX";

  if(!isDefined(ent.v["soundalias"]))
    ent.v["soundalias"] = "nil";

  if(!isDefined(ent.v["loopsound"]))
    ent.v["loopsound"] = "nil";

  if(!isDefined(ent.v["angles"]))
    ent.v["angles"] = (0, 0, 0);

  if(!isDefined(ent.v["origin"]))
    ent.v["origin"] = (0, 0, 0);

  if(!isDefined(ent.v["exploder"]))
    ent.v["exploder"] = 1;

  if(!isDefined(ent.v["flag"]))
    ent.v["flag"] = "nil";

  if(!isDefined(ent.v["delay"]) || ent.v["delay"] < 0)
    ent.v["delay"] = getexploderdelaydefault();

  return ent;
}

createexploderex(_id_8C44BF99399EDF9A, _id_2724EA192F3E906D) {
  ent = scripts\engine\utility::createexploder(_id_8C44BF99399EDF9A);
  ent.v["exploder"] = _id_2724EA192F3E906D;
  return ent;
}

createreactiveent(_id_8C44BF99399EDF9A) {
  ent = spawnStruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v["origin"] = (0, 0, 0);
  ent.v["reactive_radius"] = 350;

  if(isDefined(_id_8C44BF99399EDF9A))
    ent.v["fxid"] = _id_8C44BF99399EDF9A;
  else
    ent.v["fxid"] = "No FX";

  ent.v["type"] = "reactive_fx";
  ent.v["soundalias"] = "nil";
  return ent;
}

set_origin_and_angles(origin, angles) {
  if(isDefined(level.createfx_offset))
    origin = origin + level.createfx_offset;

  self.v["origin"] = origin;
  self.v["angles"] = angles;
}

set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglesToForward(self.v["angles"]);
}

createfx_common() {
  precacheshader("black");
  level._createfx = spawnStruct();
  level._createfx.grenade = spawn("script_origin", (0, 0, 0));
  level._createfx.grenade.fx = loadfx("vfx/core/expl/grenadeexp_default");
  level._createfx.grenade.sound = "iw9_frag_grenade_expl_trans";
  level._createfx.grenade.radius = 256;
  precachemodel("axis_guide_createfx_rot");
  precachemodel("axis_guide_createfx");
  scripts\engine\utility::flag_init("createfx_saving");
  scripts\engine\utility::flag_init("createfx_started");

  if(!isDefined(level.createfx))
    level.createfx = [];

  level.createfx_loopcounter = 0;
  waitframe();
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
  level._createfx.lockedlist["lctrl"] = 1;
  level._createfx.lockedlist["rctrl"] = 1;
}

init_colors() {
  colors = [];
  colors["loopfx"]["selected"] = (1, 1, 0.2);
  colors["loopfx"]["highlighted"] = (0.4, 0.95, 1);
  colors["loopfx"]["default"] = (0.3, 0.8, 1);
  colors["oneshotfx"]["selected"] = (1, 1, 0.2);
  colors["oneshotfx"]["highlighted"] = (0.4, 0.95, 1);
  colors["oneshotfx"]["default"] = (0.3, 0.8, 1);
  colors["exploder"]["selected"] = (1, 1, 0.2);
  colors["exploder"]["highlighted"] = (1, 0.2, 0.2);
  colors["exploder"]["default"] = (1, 0.1, 0.1);
  colors["rainfx"]["selected"] = (1, 1, 0.2);
  colors["rainfx"]["highlighted"] = (0.95, 0.4, 0.95);
  colors["rainfx"]["default"] = (0.78, 0, 0.73);
  colors["soundfx"]["selected"] = (1, 1, 0.2);
  colors["soundfx"]["highlighted"] = (0.5, 1, 0.75);
  colors["soundfx"]["default"] = (0.2, 0.9, 0.2);
  colors["soundfx_interval"]["selected"] = (1, 1, 0.2);
  colors["soundfx_interval"]["highlighted"] = (0.5, 1, 0.75);
  colors["soundfx_interval"]["default"] = (0.2, 0.9, 0.2);
  colors["reactive_fx"]["selected"] = (1, 1, 0.2);
  colors["reactive_fx"]["highlighted"] = (0.5, 1, 0.75);
  colors["reactive_fx"]["default"] = (0.2, 0.9, 0.2);
  level._createfx.colors = colors;
}

createfxlogic() {
  waittillframeend;
  waitframe();

  if(!isDefined(level._effect))
    level._effect = [];

  if(getDvar("createfx_map") == "") {} else if(getDvar("createfx_map") == level.script)
    [[level.func_position_player]]();

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

  if(getDvar("createfx_use_f4") == "") {}

  if(getDvar("createfx_no_autosave") == "") {}

  level.createfx_draw_enabled = 1;
  level.last_displayed_ent = undefined;
  level.buttonisheld = [];
  _id_918CDF5248017E62 = (0, 0, 0);
  scripts\engine\utility::flag_set("createfx_started");

  if(!level.mp_createfx)
    _id_918CDF5248017E62 = level.player.origin;

  _id_FAD54797E80B2073 = undefined;
  level.fx_rotating = 0;
  scripts\common\createfxmenu::setmenu("none");
  level.createfx_selecting = 0;
  level.createfx_inputlocked = 0;

  foreach(ent in level.createfxent)
  ent post_entity_creation_function();

  thread draw_distance();
  _id_AB4C4FF4C79448B2 = undefined;
  thread createfx_autosave();

  for(;;) {
    _id_C42084C511513568 = 0;
    right = anglestoright(level.player getplayerangles());
    forward = anglesToForward(level.player getplayerangles());
    up = anglestoup(level.player getplayerangles());
    dot = 0.85;
    _id_FC03616D10F9D715 = forward * 750;
    level.createfxcursor = scripts\engine\trace::_bullet_trace(level.player getEye(), level.player getEye() + _id_FC03616D10F9D715, 0, undefined);
    _id_28A98862B74A27D7 = undefined;
    level.buttonclick = [];
    level.button_is_kb = [];
    process_button_held_and_clicked();
    _id_1A5797AD0580E73F = button_is_held("lctrl", "rctrl", "BUTTON_LSHLDR");
    _id_8B0AE62EDF960F34 = button_is_held("lshift", "rshift");
    _id_24762EC425490DD4 = button_is_clicked("mouse1", "BUTTON_A");
    _id_7AFF3F1E76C5C9E3 = button_is_held("mouse1", "BUTTON_A");
    scripts\common\createfxmenu::create_fx_menu();
    _id_B6499A03C15010EB = "F5";

    if(getdvarint("createfx_use_f4"))
      _id_B6499A03C15010EB = "F4";

    if(button_is_clicked(_id_B6499A03C15010EB)) {}

    if(getdvarint("scr_createfx_dump"))
      generate_fx_log();

    if(button_is_clicked("F2"))
      toggle_createfx_drawing();

    if(button_is_clicked("z"))
      toggle_createfx_axis();

    if(button_is_clicked("ins"))
      insert_effect();

    if(button_is_clicked("del"))
      delete_pressed();

    if(button_is_clicked("escape"))
      clear_settable_fx();

    if(button_is_clicked("space"))
      set_off_exploders();

    if(button_is_clicked("u"))
      select_by_name_list();

    modify_player_speed();

    if(!_id_1A5797AD0580E73F && !_id_8B0AE62EDF960F34 && button_is_clicked("g")) {
      select_all_exploders_of_currently_selected("exploder");
      select_all_exploders_of_currently_selected("flag");
    }

    if(_id_8B0AE62EDF960F34) {
      if(button_is_clicked("g"))
        goto_selected();
    }

    if(button_is_held("h", "F1") && !level.mp_createfx) {
      show_help();
      waitframe();
      continue;
    }

    if(button_is_clicked("BUTTON_LSTICK"))
      copy_ents();

    if(button_is_clicked("BUTTON_RSTICK"))
      paste_ents();

    if(_id_1A5797AD0580E73F) {
      if(button_is_clicked("c"))
        copy_ents();

      if(button_is_clicked("v"))
        paste_ents();

      if(button_is_clicked("g"))
        spawn_grenade();
    }

    if(isDefined(level._createfx.selected_fx_option_index))
      scripts\common\createfxmenu::menu_fx_option_set();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.createfxent.size; _id_AC0E594AC96AA3A8++) {
      ent = level.createfxent[_id_AC0E594AC96AA3A8];
      _id_2A83DF6C49112D96 = vectorNormalize(ent.v["origin"] - (level.player.origin + (0, 0, 55)));
      _id_1B67C55A5634F958 = vectordot(forward, _id_2A83DF6C49112D96);

      if(_id_1B67C55A5634F958 < dot) {
        continue;
      }
      dot = _id_1B67C55A5634F958;
      _id_28A98862B74A27D7 = ent;
    }

    level.fx_highlightedent = _id_28A98862B74A27D7;

    if(isDefined(_id_28A98862B74A27D7)) {
      if(isDefined(_id_FAD54797E80B2073)) {
        if(_id_FAD54797E80B2073 != _id_28A98862B74A27D7) {
          if(!ent_is_selected(_id_FAD54797E80B2073))
            _id_FAD54797E80B2073 thread entity_highlight_disable();

          if(!ent_is_selected(_id_28A98862B74A27D7))
            _id_28A98862B74A27D7 thread entity_highlight_enable();
        }
      } else if(!ent_is_selected(_id_28A98862B74A27D7))
        _id_28A98862B74A27D7 thread entity_highlight_enable();
    }

    manipulate_createfx_ents(_id_28A98862B74A27D7, _id_24762EC425490DD4, _id_7AFF3F1E76C5C9E3, _id_1A5797AD0580E73F, right);
    _id_C42084C511513568 = handle_selected_ents(_id_C42084C511513568);
    waitframe();

    if(_id_C42084C511513568)
      update_selected_entities();

    if(!level.mp_createfx)
      _id_918CDF5248017E62 = [[level.func_position_player_get]](_id_918CDF5248017E62);

    _id_FAD54797E80B2073 = _id_28A98862B74A27D7;

    if(last_selected_entity_has_changed(_id_AB4C4FF4C79448B2)) {
      level.effect_list_offset = 0;
      clear_settable_fx();
      scripts\common\createfxmenu::setmenu("none");
    }

    if(level._createfx.selected_fx_ents.size) {
      _id_AB4C4FF4C79448B2 = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
      continue;
    }

    _id_AB4C4FF4C79448B2 = undefined;
  }
}

modify_player_speed() {
  _id_2397885C1F2BCDDB = 0;
  _id_C1977E8B68ED0D96 = button_is_held("lctrl", "rctrl");

  if(button_is_held(".")) {
    if(_id_C1977E8B68ED0D96) {
      if(level._createfx.player_speed < 190)
        level._createfx.player_speed = 190;
      else
        level._createfx.player_speed = level._createfx.player_speed + 10;
    } else
      level._createfx.player_speed = level._createfx.player_speed + 5;

    _id_2397885C1F2BCDDB = 1;
  } else if(button_is_held(",")) {
    if(_id_C1977E8B68ED0D96) {
      if(level._createfx.player_speed > 190)
        level._createfx.player_speed = 190;
      else
        level._createfx.player_speed = level._createfx.player_speed - 10;
    } else
      level._createfx.player_speed = level._createfx.player_speed - 5;

    _id_2397885C1F2BCDDB = 1;
  }

  if(_id_2397885C1F2BCDDB) {
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
    hud = newhudelem();
    hud.alignx = "right";
    hud.foreground = 1;
    hud.fontscale = 1.2;
    hud.alpha = 0.2;
    hud.x = 320;
    hud.y = 420;
    hud_value = newhudelem();
    hud_value.alignx = "left";
    hud_value.foreground = 1;
    hud_value.fontscale = 1.2;
    hud_value.alpha = 0.2;
    hud_value.x = 320;
    hud_value.y = 420;
    hud.hud_value = hud_value;
    level._createfx.player_speed_hud = hud;
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

is_ent_filtered_out(ent, _id_18176E8F61BB2E83) {
  if(_id_18176E8F61BB2E83 != "") {
    if(isDefined(ent.v["type"]) && issubstr(ent.v["type"], _id_18176E8F61BB2E83))
      return 0;
    else if(isDefined(ent.v["fxid"]) && issubstr(ent.v["fxid"], _id_18176E8F61BB2E83))
      return 0;
    else if(isDefined(ent.v["soundalias"]) && issubstr(ent.v["soundalias"], _id_18176E8F61BB2E83))
      return 0;

    return 1;
  }

  return 0;
}

manipulate_createfx_ents(_id_28A98862B74A27D7, _id_24762EC425490DD4, _id_7AFF3F1E76C5C9E3, _id_1A5797AD0580E73F, right) {
  if(!level.createfx_draw_enabled) {
    return;
  }
  if(level._createfx.select_by_name) {
    level._createfx.select_by_name = 0;
    _id_28A98862B74A27D7 = undefined;
  } else if(select_by_substring())
    _id_28A98862B74A27D7 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.createfxent.size; _id_AC0E594AC96AA3A8++) {
    ent = level.createfxent[_id_AC0E594AC96AA3A8];

    if(!ent.drawn) {
      continue;
    }
    if(is_ent_filtered_out(ent, getDvar("createfx_filter"))) {
      continue;
    }
    scale = getdvarfloat("createfx_scaleid");

    if(isDefined(_id_28A98862B74A27D7) && ent == _id_28A98862B74A27D7) {
      if(!scripts\common\createfxmenu::entities_are_selected())
        scripts\common\createfxmenu::display_fx_info(ent);

      if(_id_24762EC425490DD4) {
        _id_915BF244079E233E = index_is_selected(_id_AC0E594AC96AA3A8);
        level.createfx_selecting = !_id_915BF244079E233E;

        if(!_id_1A5797AD0580E73F) {
          _id_C3208E10B4C0C211 = level._createfx.selected_fx_ents.size;
          clear_entity_selection();

          if(_id_915BF244079E233E && _id_C3208E10B4C0C211 == 1)
            select_entity(_id_AC0E594AC96AA3A8, ent);
        }

        toggle_entity_selection(_id_AC0E594AC96AA3A8, ent);
      } else if(_id_7AFF3F1E76C5C9E3) {
        if(_id_1A5797AD0580E73F) {
          if(level.createfx_selecting)
            select_entity(_id_AC0E594AC96AA3A8, ent);

          if(!level.createfx_selecting)
            deselect_entity(_id_AC0E594AC96AA3A8, ent);
        }
      }

      colorindex = "highlighted";
    } else
      colorindex = "default";

    if(index_is_selected(_id_AC0E594AC96AA3A8))
      colorindex = "selected";

    ent createfx_print3d(colorindex, scale, right);
  }
}

draw_origin(scale, colorindex) {
  _id_FBB5190911C15C1B = level.player getvieworigin();
  _id_63C18152B2F66E55 = level.player getplayerangles();
  color = level._createfx.colors[self.v["type"]][colorindex];
  _id_94D86565C4D2C660 = 0;
  _id_27EE0289D942057B = 1;
  angles_offset = (0, 0, 0);
  _id_7F56B9D87F5452AF = distancesquared(_id_FBB5190911C15C1B, self.v["origin"]) < 36864;

  if(_id_7F56B9D87F5452AF) {
    _id_C810D827A05FACC6 = distance(_id_FBB5190911C15C1B, self.v["origin"]);
    _id_997680AC56B8D5E3 = _id_C810D827A05FACC6 / 176;
    _id_94D86565C4D2C660 = 1 - clamp(_id_997680AC56B8D5E3, 0.0, 1.0);
    _id_27EE0289D942057B = clamp(_id_997680AC56B8D5E3, 0.333, 1.0);
    _id_E520906C5F9D7A67 = anglestoright(_id_63C18152B2F66E55) * -4;
    _id_BFF3E0F8DBDBB856 = anglestoup(_id_63C18152B2F66E55) * -4.666;
    angles_offset = _id_E520906C5F9D7A67 + _id_BFF3E0F8DBDBB856;
  }

  if(_id_94D86565C4D2C660 > 0) {
    iswithinfov = scripts\engine\utility::within_fov(_id_FBB5190911C15C1B, _id_63C18152B2F66E55, self.v["origin"], 0.422618);

    if(iswithinfov) {
      _id_9221239482C742C7 = 2.0;
      _id_4F4E413F42197F3E = 4.0;
      forward = anglesToForward(self.v["angles"]);
      forward = forward * (_id_4F4E413F42197F3E * scale);
      right = anglestoright(self.v["angles"]) * -1;
      right = right * (_id_4F4E413F42197F3E * scale);
      up = anglestoup(self.v["angles"]);
      up = up * (_id_4F4E413F42197F3E * scale);
    }
  }
}

createfx_print3d(colorindex, scale, right) {
  draw_origin(scale, colorindex);

  if(self.textalpha > 0) {
    _id_354CB4170C837683 = get_print3d_text();
    _id_19EACE9A3F672446 = right * (_id_354CB4170C837683[0].size * -2.93);
    color = level._createfx.colors[self.v["type"]][colorindex];

    if(isDefined(self.is_playing))
      color = (1, 0.5, 0);

    height = 15;

    foreach(text in _id_354CB4170C837683)
    height = height - 13;

    if(isDefined(self.v["reactive_radius"])) {
      if(self.v["fxid"] == "No FX" && !getdvarint("createfx_vfxonly"))
        return;
    }
  }
}

get_print3d_text() {
  switch (self.v["type"]) {
    case "reactive_fx":
      _id_354CB4170C837683[0] = "reactive sound: " + self.v["soundalias"];

      if(!level.mp_createfx)
        _id_354CB4170C837683[1] = "reactive FX: " + self.v["fxid"];

      return _id_354CB4170C837683;
    case "soundfx":
    case "soundfx_interval":
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

handle_selected_ents(_id_C42084C511513568) {
  if(level._createfx.selected_fx_ents.size > 0) {
    _id_C42084C511513568 = selected_ent_buttons(_id_C42084C511513568);

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

      if(button_is_clicked("enter", "p"))
        reset_axis_of_selected_ents();

      if(button_is_clicked("v"))
        copy_angles_of_selected_ents();

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++)
        level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8] draw_axis();

      if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0)
        _id_C42084C511513568 = 1;
    } else {
      set_tool_hudelem("Mode:", "move");
      _id_22F5978E35BA0E7D = get_selected_move_vector();

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
        ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];

        if(isDefined(ent.model)) {
          continue;
        }
        ent draw_cross();
        ent.v["origin"] = ent.v["origin"] + _id_22F5978E35BA0E7D;
      }

      if(distance((0, 0, 0), _id_22F5978E35BA0E7D) > 0)
        _id_C42084C511513568 = 1;
    }
  } else
    clear_tool_hud();

  return _id_C42084C511513568;
}

selected_ent_buttons(_id_C42084C511513568) {
  if(button_is_clicked("lshift", "rshift", "BUTTON_X"))
    toggle_axismode();

  modify_rate();

  if(button_is_clicked("s"))
    toggle_snap2normal();

  if(button_is_clicked("r"))
    toggle_snap2angle();

  if(button_is_clicked("end", "l")) {
    drop_selection_to_ground();
    _id_C42084C511513568 = 1;
  }

  if(button_is_clicked("tab", "BUTTON_RSHLDR")) {
    move_selection_to_cursor();
    _id_C42084C511513568 = 1;
  }

  if(button_is_clicked("e")) {
    convert_selection_to_exploder();
    _id_C42084C511513568 = 1;
  }

  return _id_C42084C511513568;
}

modify_rate() {
  _id_91B4DBB6A5B68013 = button_is_held("lshift", "rshift");
  _id_C1977E8B68ED0D96 = button_is_held("lctrl", "rctrl");

  if(button_is_clicked("=")) {
    if(_id_91B4DBB6A5B68013)
      level._createfx.rate = level._createfx.rate + 1;
    else if(_id_C1977E8B68ED0D96) {
      if(level._createfx.rate < 1)
        level._createfx.rate = 1;
      else
        level._createfx.rate = level._createfx.rate + 10;
    } else
      level._createfx.rate = level._createfx.rate + 0.1;
  } else if(button_is_clicked("-")) {
    if(_id_91B4DBB6A5B68013)
      level._createfx.rate = level._createfx.rate - 1;
    else if(_id_C1977E8B68ED0D96) {
      if(level._createfx.rate > 1)
        level._createfx.rate = 1;
      else
        level._createfx.rate = 0.1;
    } else
      level._createfx.rate = level._createfx.rate - 0.1;
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

  if(level._createfx.snap2angle >= level._createfx.snap2anglesnaps.size)
    level._createfx.snap2angle = 0;

  set_tool_hudelem("Snap2Angle:", level._createfx.snap2anglesnaps[level._createfx.snap2angle]);
}

copy_angles_of_selected_ents() {
  level notify("new_ent_selection");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];
    ent.v["angles"] = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1].v["angles"];
    ent set_forward_and_up_vectors();
  }

  update_selected_entities();
}

reset_axis_of_selected_ents() {
  level notify("new_ent_selection");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];
    ent.v["angles"] = (0, 0, 0);
    ent set_forward_and_up_vectors();
  }

  update_selected_entities();
}

last_selected_entity_has_changed(_id_AB4C4FF4C79448B2) {
  if(isDefined(_id_AB4C4FF4C79448B2)) {
    if(!scripts\common\createfxmenu::entities_are_selected())
      return 1;
  } else
    return scripts\common\createfxmenu::entities_are_selected();

  return _id_AB4C4FF4C79448B2 != level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}

drop_selection_to_ground() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];
    trace = scripts\engine\trace::_bullet_trace(ent.v["origin"], ent.v["origin"] + (0, 0, -2048), 0, undefined);
    ent.v["origin"] = trace["position"];
  }
}

set_off_exploders() {
  level notify("createfx_exploder_reset");
  exploders = [];

  foreach(ent in level._createfx.selected_fx_ents) {
    if(isDefined(ent.v["exploder"]))
      exploders[ent.v["exploder"]] = 1;
  }

  foreach(key, _ in exploders)
  scripts\engine\utility::exploder(key);
}

draw_distance() {
  count = 0;

  if(getdvarint("createfx_drawdist") == 0) {}

  for(;;) {
    maxdist = getdvarint("createfx_drawdist");
    maxdist = maxdist * maxdist;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.createfxent.size; _id_AC0E594AC96AA3A8++) {
      ent = level.createfxent[_id_AC0E594AC96AA3A8];
      ent.drawn = distancesquared(level.player.origin, ent.v["origin"]) <= maxdist;
      count++;

      if(count > 100) {
        count = 0;
        waitframe();
      }
    }

    if(level.createfxent.size == 0)
      waitframe();
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

rotate_over_time(org, _id_F768BF61E5636B2C) {
  level endon("new_ent_selection");
  timer = 0.1;

  for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < timer * 20; _id_AC0E424AC96A7113++) {
    if(level.selectedrotate_pitch != 0)
      org addpitch(level.selectedrotate_pitch);
    else if(level.selectedrotate_yaw != 0)
      org addyaw(level.selectedrotate_yaw);
    else
      org addroll(level.selectedrotate_roll);

    waitframe();
    org draw_axis();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
      ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];

      if(isDefined(ent.model)) {
        continue;
      }
      ent.v["origin"] = _id_F768BF61E5636B2C[_id_AC0E594AC96AA3A8].origin;
      ent.v["angles"] = _id_F768BF61E5636B2C[_id_AC0E594AC96AA3A8].angles;
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
  name = level._createfx.options[level._createfx.selected_fx_option_index]["name"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.createfxent.size; _id_AC0E594AC96AA3A8++) {
    ent = level.createfxent[_id_AC0E594AC96AA3A8];

    if(!ent_is_selected(ent)) {
      continue;
    }
    ent remove_option(name);
  }

  update_selected_entities();
  clear_settable_fx();
}

remove_option(name) {
  self.v[name] = undefined;
}

delete_selection() {
  _id_BFC65A378A6D8EFE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.createfxent.size; _id_AC0E594AC96AA3A8++) {
    ent = level.createfxent[_id_AC0E594AC96AA3A8];

    if(ent_is_selected(ent)) {
      if(isDefined(ent.loopsound_ent)) {
        ent.loopsound_ent stoploopsound();
        ent.loopsound_ent delete();
      }

      if(isDefined(ent.looper))
        ent.looper delete();

      ent notify("stop_loop");
      continue;
    }

    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = ent;
  }

  level.createfxent = _id_BFC65A378A6D8EFE;
  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
  clear_fx_hudelements();
  remove_axis_model();
}

move_selection_to_cursor() {
  origin = level.createfxcursor["position"];

  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }
  center = get_center_of_array(level._createfx.selected_fx_ents);
  _id_2A83DF6C49112D96 = center - origin;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];

    if(isDefined(ent.model)) {
      continue;
    }
    ent.v["origin"] = ent.v["origin"] - _id_2A83DF6C49112D96;

    if(level._createfx.snap2normal) {
      if(isDefined(level.createfxcursor["normal"]))
        ent.v["angles"] = vectortoangles(level.createfxcursor["normal"]);
    }
  }
}

convert_selection_to_exploder() {
  if(level._createfx.selected_fx_ents.size < 1) {
    return;
  }
  _id_998BE083DDA4BA35 = 0;

  foreach(ent in level._createfx.selected_fx_ents) {
    if(ent.v["type"] == "oneshotfx") {
      _id_998BE083DDA4BA35 = 1;
      createnewexploder_internal(ent);
      continue;
    }
  }

  if(_id_998BE083DDA4BA35) {
    scripts\common\createfxmenu::setmenu("none");
    scripts\common\createfxmenu::display_fx_info(scripts\common\createfxmenu::get_last_selected_ent());
  }
}

select_last_entity() {
  select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
}

select_all_exploders_of_currently_selected(key) {
  _id_2A7F5B00FE422C65 = [];

  foreach(ent in level._createfx.selected_fx_ents) {
    if(!isDefined(ent.v[key])) {
      continue;
    }
    value = ent.v[key];
    _id_2A7F5B00FE422C65[value] = 1;
  }

  foreach(value, _ in _id_2A7F5B00FE422C65) {
    foreach(index, ent in level.createfxent) {
      if(index_is_selected(index)) {
        continue;
      }
      if(!isDefined(ent.v[key])) {
        continue;
      }
      if(ent.v[key] != value) {
        continue;
      }
      select_entity(index, ent);
    }
  }

  update_selected_entities();
}

copy_ents() {
  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }
  array = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];
    _id_0E14905A4CDF3B12 = spawnStruct();
    _id_0E14905A4CDF3B12.v = ent.v;
    _id_0E14905A4CDF3B12 post_entity_creation_function();
    array[array.size] = _id_0E14905A4CDF3B12;
  }

  level.stored_ents = array;
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

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.stored_ents.size; _id_AC0E594AC96AA3A8++)
    add_and_select_entity(level.stored_ents[_id_AC0E594AC96AA3A8]);

  move_selection_to_cursor();
  update_selected_entities();
  level.stored_ents = [];
  copy_ents();
}

add_and_select_entity(ent) {
  level.createfxent[level.createfxent.size] = ent;
  select_last_entity();
}

get_center_of_array(array) {
  center = (0, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    center = (center[0] + array[_id_AC0E594AC96AA3A8].v["origin"][0], center[1] + array[_id_AC0E594AC96AA3A8].v["origin"][1], center[2] + array[_id_AC0E594AC96AA3A8].v["origin"][2]);

  return (center[0] / array.size, center[1] / array.size, center[2] / array.size);
}

goto_selected() {
  origin = undefined;

  if(level._createfx.selected_fx_ents.size > 0)
    origin = get_center_of_array(level._createfx.selected_fx_ents);
  else if(isDefined(level.fx_highlightedent))
    origin = level.fx_highlightedent.v["origin"];

  if(!isDefined(origin)) {
    return;
  }
  angles = vectortoangles(level.player.origin - origin);
  _id_53FD9BCFE97F77D0 = origin + anglesToForward(angles) * 200;
  level.player setOrigin(_id_53FD9BCFE97F77D0 + (0, 0, -60));
  level.player setplayerangles(vectortoangles(origin - _id_53FD9BCFE97F77D0));
}

ent_draw_axis() {
  self endon("death");

  for(;;) {
    draw_axis();
    waitframe();
  }
}

rotation_is_occuring() {
  if(level.selectedrotate_roll != 0)
    return 1;

  if(level.selectedrotate_pitch != 0)
    return 1;

  return level.selectedrotate_yaw != 0;
}

print_fx_options(ent, _id_E9B07E032ACA08A8, autosave) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.options.size; _id_AC0E594AC96AA3A8++) {
    _id_414EEC2F131C45C0 = level._createfx.options[_id_AC0E594AC96AA3A8];
    _id_194D8BC9C448E603 = _id_414EEC2F131C45C0["name"];

    if(!isDefined(ent.v[_id_194D8BC9C448E603])) {
      continue;
    }
    if(!scripts\common\createfxmenu::mask(_id_414EEC2F131C45C0["mask"], ent.v["type"])) {
      continue;
    }
    if(!level.mp_createfx) {
      if(scripts\common\createfxmenu::mask("fx", ent.v["type"]) && _id_194D8BC9C448E603 == "fxid") {
        continue;
      }
      if(ent.v["type"] == "exploder" && _id_194D8BC9C448E603 == "exploder") {
        continue;
      }
      key = ent.v["type"] + "/" + _id_194D8BC9C448E603;

      if(isDefined(level._createfx.defaults[key]) && level._createfx.defaults[key] == ent.v[_id_194D8BC9C448E603])
        continue;
    }

    if(_id_414EEC2F131C45C0["type"] == "string") {
      _id_0DD683497230EAE5 = ent.v[_id_194D8BC9C448E603] + "";

      if(_id_0DD683497230EAE5 == "nil") {
        continue;
      }
      cfxprintln(_id_E9B07E032ACA08A8 + "ent.v[ \"" + _id_194D8BC9C448E603 + "\" ] = \"" + ent.v[_id_194D8BC9C448E603] + "\";");
      continue;
    }

    cfxprintln(_id_E9B07E032ACA08A8 + "ent.v[ \"" + _id_194D8BC9C448E603 + "\" ] = " + ent.v[_id_194D8BC9C448E603] + ";");
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

    waitframe();
  }

  self.textalpha = 1;
}

clear_settable_fx() {
  level.createfx_inputlocked = 0;
  level._createfx.selected_fx_option_index = undefined;
  reset_fx_hud_colors();
}

reset_fx_hud_colors() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.hudelem_count; _id_AC0E594AC96AA3A8++)
    level._createfx.hudelems[_id_AC0E594AC96AA3A8][0].color = (1, 1, 1);
}

toggle_entity_selection(index, ent) {
  if(isDefined(level._createfx.selected_fx[index]))
    deselect_entity(index, ent);
  else
    select_entity(index, ent);
}

select_entity(index, ent) {
  if(isDefined(level._createfx.selected_fx[index])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  ent thread entity_highlight_enable();
  level._createfx.selected_fx[index] = 1;
  level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = ent;
}

ent_is_highlighted(ent) {
  if(!isDefined(level.fx_highlightedent))
    return 0;

  return ent == level.fx_highlightedent;
}

deselect_entity(index, ent) {
  if(!isDefined(level._createfx.selected_fx[index])) {
    return;
  }
  clear_settable_fx();
  level notify("new_ent_selection");
  level._createfx.selected_fx[index] = undefined;

  if(!ent_is_highlighted(ent))
    ent thread entity_highlight_disable();

  _id_BFC65A378A6D8EFE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    if(level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8] != ent)
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];
  }

  level._createfx.selected_fx_ents = _id_BFC65A378A6D8EFE;
}

index_is_selected(index) {
  return isDefined(level._createfx.selected_fx[index]);
}

ent_is_selected(ent) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    if(level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8] == ent)
      return 1;
  }

  return 0;
}

clear_entity_selection() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    if(!ent_is_highlighted(level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8]))
      level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8] thread entity_highlight_disable();
  }

  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
}

draw_axis() {}

set_axis_model(model) {
  if(!isDefined(level._createfx.axis))
    level._createfx.axis = spawn("script_model", (0, 0, 0));
  else if(level._createfx.axis.model != model)
    level._createfx.axis setModel(model);
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

  if(level._createfx.drawaxis > 2)
    level._createfx.drawaxis = 0;

  if(level._createfx.drawaxis != 1)
    remove_axis_model();
}

createfx_centerprint(text) {
  thread createfx_centerprint_thread(text);
}

createfx_centerprint_thread(text) {
  level notify("new_createfx_centerprint");
  level endon("new_createfx_centerprint");
  wait 4.5;
}

get_selected_move_vector() {
  yaw = level.player getplayerangles()[1];
  angles = (0, yaw, 0);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  _id_E3A465F047ABD9FE = 0;
  rate = level._createfx.rate;

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedmove_forward < 0)
      level.selectedmove_forward = 0;

    level.selectedmove_forward = level.selectedmove_forward + rate;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedmove_forward > 0)
      level.selectedmove_forward = 0;

    level.selectedmove_forward = level.selectedmove_forward - rate;
  } else
    level.selectedmove_forward = 0;

  if(buttondown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedmove_right < 0)
      level.selectedmove_right = 0;

    level.selectedmove_right = level.selectedmove_right + rate;
  } else if(buttondown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedmove_right > 0)
      level.selectedmove_right = 0;

    level.selectedmove_right = level.selectedmove_right - rate;
  } else
    level.selectedmove_right = 0;

  if(buttondown("BUTTON_Y")) {
    if(level.selectedmove_up < 0)
      level.selectedmove_up = 0;

    level.selectedmove_up = level.selectedmove_up + rate;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedmove_up > 0)
      level.selectedmove_up = 0;

    level.selectedmove_up = level.selectedmove_up - rate;
  } else
    level.selectedmove_up = 0;

  _id_16290C9DDA466BCE = (0, 0, 0);
  _id_16290C9DDA466BCE = _id_16290C9DDA466BCE + forward * level.selectedmove_forward;
  _id_16290C9DDA466BCE = _id_16290C9DDA466BCE + right * level.selectedmove_right;
  _id_16290C9DDA466BCE = _id_16290C9DDA466BCE + up * level.selectedmove_up;
  return _id_16290C9DDA466BCE;
}

set_anglemod_move_vector() {
  rate = level._createfx.rate;
  _id_3FD677B10BC04831 = level._createfx.snap2anglesnaps[level._createfx.snap2angle];

  if(_id_3FD677B10BC04831 != 0)
    rate = 0;

  if(buttondown("kp_uparrow", "DPAD_UP")) {
    if(level.selectedrotate_pitch < 0)
      level.selectedrotate_pitch = 0;

    level.selectedrotate_pitch = level.selectedrotate_pitch + _id_3FD677B10BC04831 + rate;
  } else if(buttondown("kp_downarrow", "DPAD_DOWN")) {
    if(level.selectedrotate_pitch > 0)
      level.selectedrotate_pitch = 0;

    level.selectedrotate_pitch = level.selectedrotate_pitch - _id_3FD677B10BC04831 - rate;
  } else
    level.selectedrotate_pitch = 0;

  if(buttondown("kp_leftarrow", "DPAD_LEFT")) {
    if(level.selectedrotate_yaw < 0)
      level.selectedrotate_yaw = 0;

    level.selectedrotate_yaw = level.selectedrotate_yaw + _id_3FD677B10BC04831 + rate;
  } else if(buttondown("kp_rightarrow", "DPAD_RIGHT")) {
    if(level.selectedrotate_yaw > 0)
      level.selectedrotate_yaw = 0;

    level.selectedrotate_yaw = level.selectedrotate_yaw - _id_3FD677B10BC04831 - rate;
  } else
    level.selectedrotate_yaw = 0;

  if(buttondown("BUTTON_Y")) {
    if(level.selectedrotate_roll < 0)
      level.selectedrotate_roll = 0;

    level.selectedrotate_roll = level.selectedrotate_roll + _id_3FD677B10BC04831 + rate;
  } else if(buttondown("BUTTON_B")) {
    if(level.selectedrotate_roll > 0)
      level.selectedrotate_roll = 0;

    level.selectedrotate_roll = level.selectedrotate_roll - _id_3FD677B10BC04831 - rate;
  } else
    level.selectedrotate_roll = 0;
}

update_selected_entities() {
  _id_DFBF17DFA0D31EFE = 0;

  foreach(ent in level._createfx.selected_fx_ents) {
    if(ent.v["type"] == "reactive_fx")
      _id_DFBF17DFA0D31EFE = 1;

    ent[[level.func_updatefx]]();
  }

  if(_id_DFBF17DFA0D31EFE)
    refresh_reactive_fx_ents();
}

stop_fx_looper() {
  if(isDefined(self.looper))
    self.looper delete();

  stop_loopsound();
}

stop_loopsound() {
  self notify("stop_loop");
}

func_get_level_fx() {
  if(!isDefined(level._effect_keys))
    keys = getarraykeys(level._effect);
  else {
    keys = getarraykeys(level._effect);

    if(keys.size == level._effect_keys.size)
      return level._effect_keys;
  }

  keys = scripts\engine\utility::alphabetize(keys);
  level._effect_keys = keys;
  return keys;
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

  foreach(ent in level.createfxent) {
    if(ent.v["type"] == "reactive_fx") {
      ent set_forward_and_up_vectors();
      ent scripts\common\fx::add_reactive_fx();
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
    center = get_center_of_array(level._createfx.selected_fx_ents);
    org = spawn("script_origin", center);
    org.v["angles"] = level._createfx.selected_fx_ents[0].v["angles"];
    org.v["origin"] = center;
    _id_F768BF61E5636B2C = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
      _id_F768BF61E5636B2C[_id_AC0E594AC96AA3A8] = spawn("script_origin", level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8].v["origin"]);
      _id_F768BF61E5636B2C[_id_AC0E594AC96AA3A8].angles = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8].v["angles"];
      _id_F768BF61E5636B2C[_id_AC0E594AC96AA3A8] linkTo(org);
    }

    rotate_over_time(org, _id_F768BF61E5636B2C);
    org delete();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F768BF61E5636B2C.size; _id_AC0E594AC96AA3A8++)
      _id_F768BF61E5636B2C[_id_AC0E594AC96AA3A8] delete();
  } else if(level._createfx.selected_fx_ents.size == 1) {
    ent = level._createfx.selected_fx_ents[0];
    _id_F768BF61E5636B2C = spawn("script_origin", (0, 0, 0));
    _id_F768BF61E5636B2C.angles = ent.v["angles"];

    if(level.selectedrotate_pitch != 0)
      _id_F768BF61E5636B2C addpitch(level.selectedrotate_pitch);
    else if(level.selectedrotate_yaw != 0)
      _id_F768BF61E5636B2C addyaw(level.selectedrotate_yaw);
    else
      _id_F768BF61E5636B2C addroll(level.selectedrotate_roll);

    ent.v["angles"] = _id_F768BF61E5636B2C.angles;
    _id_F768BF61E5636B2C delete();
    waitframe();
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

generate_fx_log(autosave) {}

write_log(array, type, autosave, _id_331D6624FF42AD58) {
  _id_E9B07E032ACA08A8 = "\t";
  cfxprintlnstart();
  cfxprintln("cfxprintln("#include scripts\\engine\\utility;"); cfxprintln("#include scripts\\common\\utility;"); cfxprintln("#include scripts\\common\\createfx;\n"); cfxprintln(""); cfxprintln("main()"); cfxprintln("{"); cfxprintln(_id_E9B07E032ACA08A8 + "foreach(e in array) {
    if(level.createfx_loopcounter > 16) {
      level.createfx_loopcounter = 0;
      wait 0.1;
    }

    level.createfx_loopcounter++;

    if(getdvarint("scr_map_exploder_dump")) {
      if(!isDefined(e.model))
        continue;
    } else if(isDefined(e.model)) {
      continue;
    }
    if(e.v["type"] == "oneshotfx")
      cfxprintln(_id_E9B07E032ACA08A8 + "ent = createOneshotEffect( \"" + e.v["fxid"] + "\" );");

    if(e.v["type"] == "loopfx")
      cfxprintln(_id_E9B07E032ACA08A8 + "ent = createLoopEffect( \"" + e.v["fxid"] + "\" );");

    if(e.v["type"] == "exploder") {
      if(isDefined(e.v["exploder"]) && !level.mp_createfx)
        cfxprintln(_id_E9B07E032ACA08A8 + "ent = createExploderEx( \"" + e.v["fxid"] + "\", \"" + e.v["exploder"] + "\" );");
      else
        cfxprintln(_id_E9B07E032ACA08A8 + "ent = createExploder( \"" + e.v["fxid"] + "\" );");
    }

    if(e.v["type"] == "soundfx")
      cfxprintln(_id_E9B07E032ACA08A8 + "ent = createLoopSound();");

    if(e.v["type"] == "soundfx_interval")
      cfxprintln(_id_E9B07E032ACA08A8 + "ent = createIntervalSound();");

    if(e.v["type"] == "reactive_fx") {
      if(type == "fx" && e.v["fxid"] != "No FX" && !level.mp_createfx)
        cfxprintln(_id_E9B07E032ACA08A8 + "ent = createReactiveEnt( \"" + e.v["fxid"] + "\" );");
      else if(type == "sound" && e.v["fxid"] == "No FX")
        cfxprintln(_id_E9B07E032ACA08A8 + "ent = createReactiveEnt();");
      else
        continue;
    }

    cfxprintln(_id_E9B07E032ACA08A8 + "ent set_origin_and_angles( " + e.v["origin"] + ", " + e.v["angles"] + " );"); print_fx_options(e, _id_E9B07E032ACA08A8, autosave); cfxprintln("");
  }

  cfxprintln("}");
  cfxprintln(" ");
  cfxprintlnend(autosave, _id_331D6624FF42AD58, type);
}

createfx_adjust_array() {
  limit = 0.1;

  foreach(ent in level.createfxent) {
    origin = [];
    angles = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
      origin[_id_AC0E594AC96AA3A8] = ent.v["origin"][_id_AC0E594AC96AA3A8];
      angles[_id_AC0E594AC96AA3A8] = ent.v["angles"][_id_AC0E594AC96AA3A8];

      if(origin[_id_AC0E594AC96AA3A8] < limit && origin[_id_AC0E594AC96AA3A8] > limit * -1)
        origin[_id_AC0E594AC96AA3A8] = 0;

      if(angles[_id_AC0E594AC96AA3A8] < limit && angles[_id_AC0E594AC96AA3A8] > limit * -1)
        angles[_id_AC0E594AC96AA3A8] = 0;
    }

    ent.v["origin"] = (origin[0], origin[1], origin[2]);
    ent.v["angles"] = (angles[0], angles[1], angles[2]);
  }
}

get_createfx_array(type) {
  types = get_createfx_types(type);
  array = [];

  foreach(index, _ in types)
  array[index] = [];

  foreach(ent in level.createfxent) {
    _id_36FFCEE6C004B3A4 = 0;

    foreach(index, type in types) {
      if(ent.v["type"] != type) {
        continue;
      }
      _id_36FFCEE6C004B3A4 = 1;
      array[index][array[index].size] = ent;
      break;
    }
  }

  _id_055F75D9F16D814F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < types.size; _id_AC0E594AC96AA3A8++) {
    foreach(ent in array[_id_AC0E594AC96AA3A8])
    _id_055F75D9F16D814F[_id_055F75D9F16D814F.size] = ent;
  }

  return _id_055F75D9F16D814F;
}

get_createfx_types(type) {
  types = [];

  if(type == "fx") {
    types[0] = "oneshotfx";
    types[1] = "loopfx";
    types[2] = "exploder";
    types[3] = "reactive_fx";
  } else {
    types[0] = "soundfx";
    types[1] = "soundfx_interval";
    types[2] = "reactive_fx";
  }

  return types;
}

check_reactive_fx_type(ent, type) {
  if(ent.v["fxid"] != "No FX" && type == "fx")
    return 1;

  if(ent.v["fxid"] == "No FX" && type == "sound")
    return 1;

  return 0;
}

is_createfx_type(ent, type) {
  types = get_createfx_types(type);

  if(ent.v["type"] == "reactive_fx") {
    if(check_reactive_fx_type(ent, type))
      return 1;
    else
      return 0;
  }

  foreach(t in types) {
    if(ent.v["type"] == t)
      return 1;
  }

  return 0;
}

createfx_filter_types() {
  types = [];
  types[types.size] = "soundfx";
  types[types.size] = "oneshotfx";
  types[types.size] = "exploder";
  types[types.size] = "soundfx_interval";
  types[types.size] = "reactive_fx";

  if(!level.mp_createfx)
    types[types.size] = "loopfx";

  array = [];

  foreach(index, _ in types)
  array[index] = [];

  foreach(ent in level.createfxent) {
    _id_36FFCEE6C004B3A4 = 0;

    foreach(index, type in types) {
      if(ent.v["type"] != type) {
        continue;
      }
      _id_36FFCEE6C004B3A4 = 1;
      array[index][array[index].size] = ent;
      break;
    }
  }

  _id_055F75D9F16D814F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < types.size; _id_AC0E594AC96AA3A8++) {
    foreach(ent in array[_id_AC0E594AC96AA3A8])
    _id_055F75D9F16D814F[_id_055F75D9F16D814F.size] = ent;
  }

  level.createfxent = _id_055F75D9F16D814F;
}

cfxprintlnstart() {
  scripts\engine\utility:: fileprint_launcher_start_file();
}

cfxprintln(string) {
  scripts\engine\utility:: fileprint_launcher( string );
}

cfxprintlnend(autosave, _id_331D6624FF42AD58, type) {
  _id_AE8D497AE110B85C = 1;

  if(_id_331D6624FF42AD58 != "" || autosave)
    _id_AE8D497AE110B85C = 0;

  if(scripts\common\utility::issp()) {
    _id_608A7AA6A524529D = level.script + _id_331D6624FF42AD58 + "_" + type + ".gsc";

    if(autosave)
      _id_608A7AA6A524529D = "backup_" + type + ".gsc";
  } else {
    _id_608A7AA6A524529D = level.script + _id_331D6624FF42AD58 + "_" + type + ".gsc";

    if(autosave)
      _id_608A7AA6A524529D = "backup.gsc";
  }

  _id_51CE59302DC1069D = get_raw_or_devraw_subdir();
  _id_E47CF6F2FC269250 = get_gamemode_subdir();
  scripts\engine\utility:: fileprint_launcher_end_file( "/share/" + _id_51CE59302DC1069D + "/scripts/" + _id_E47CF6F2FC269250 + "/maps/" + level.script + "/gen/" + _id_608A7AA6A524529D, _id_AE8D497AE110B85C );
}

get_raw_or_devraw_subdir() {
  if(isDefined(level.createfx_devraw_map) && level.createfx_devraw_map)
    return "devraw";
  else
    return "raw";
}

get_gamemode_subdir() {
  if(scripts\common\utility::iscp())
    return "cp";
  else if(scripts\common\utility::issp())
    return "sp";
  else
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
  add_kb_button("lshift");
  add_kb_button("rshift");
  add_kb_button("lctrl");
  add_kb_button("rctrl");
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

locked(name) {
  if(isDefined(level._createfx.lockedlist[name]))
    return 0;

  return kb_locked(name);
}

kb_locked(name) {
  return level.createfx_inputlocked && isDefined(level.button_is_kb[name]);
}

add_button(name) {
  if(locked(name)) {
    return;
  }
  if(!isDefined(level.buttonisheld[name])) {
    if(level.player buttonPressed(name)) {
      level.buttonisheld[name] = 1;
      level.buttonclick[name] = 1;
    }
  } else if(!level.player buttonPressed(name))
    level.buttonisheld[name] = undefined;
}

add_kb_button(name) {
  level.button_is_kb[name] = 1;
  add_button(name);
}

buttondown(button, _id_F60F56F759583AB5) {
  return buttonpressed_internal(button) || buttonpressed_internal(_id_F60F56F759583AB5);
}

buttonpressed_internal(button) {
  if(!isDefined(button))
    return 0;

  if(kb_locked(button))
    return 0;

  return level.player buttonPressed(button);
}

button_is_held(name, _id_58B953B7CF8F4D68, _id_58B954B7CF8F4F9B) {
  if(isDefined(_id_58B954B7CF8F4F9B)) {
    if(isDefined(level.buttonisheld[_id_58B954B7CF8F4F9B]))
      return 1;
  }

  if(isDefined(_id_58B953B7CF8F4D68)) {
    if(isDefined(level.buttonisheld[_id_58B953B7CF8F4D68]))
      return 1;
  }

  return isDefined(level.buttonisheld[name]);
}

button_is_clicked(name, _id_58B953B7CF8F4D68, _id_58B954B7CF8F4F9B) {
  if(isDefined(_id_58B954B7CF8F4F9B)) {
    if(isDefined(level.buttonclick[_id_58B954B7CF8F4F9B]))
      return 1;
  }

  if(isDefined(_id_58B953B7CF8F4D68)) {
    if(isDefined(level.buttonclick[_id_58B953B7CF8F4D68]))
      return 1;
  }

  return isDefined(level.buttonclick[name]);
}

init_huds() {
  level._createfx.hudelems = [];
  level._createfx.hudelem_count = 30;

  if(level.mp_createfx)
    level._createfx.hudelem_count = 16;

  _id_33D665A8348C47BD = [];
  _id_33D664A8348C458A = [];
  _id_33D665A8348C47BD[0] = 0;
  _id_33D664A8348C458A[0] = 0;
  _id_33D665A8348C47BD[1] = 1;
  _id_33D664A8348C458A[1] = 1;
  _id_33D665A8348C47BD[2] = -2;
  _id_33D664A8348C458A[2] = 1;
  _id_33D665A8348C47BD[3] = 1;
  _id_33D664A8348C458A[3] = -1;
  _id_33D665A8348C47BD[4] = -2;
  _id_33D664A8348C458A[4] = -1;
  level.cleartextmarker = newhudelem();
  level.cleartextmarker.alpha = 0;
  level.cleartextmarker.archived = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.hudelem_count; _id_AC0E594AC96AA3A8++) {
    _id_9AF634FE97C006F5 = [];

    for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 1; _id_AC0E424AC96A7113++) {
      _id_7D5D0059E2ECD538 = newhudelem();
      _id_7D5D0059E2ECD538.alignx = "left";
      _id_7D5D0059E2ECD538.archived = 0;
      _id_7D5D0059E2ECD538.location = 0;
      _id_7D5D0059E2ECD538.foreground = 1;
      _id_7D5D0059E2ECD538.fontscale = 1.4;
      _id_7D5D0059E2ECD538.sort = 20 - _id_AC0E424AC96A7113;
      _id_7D5D0059E2ECD538.alpha = 1;
      _id_7D5D0059E2ECD538.x = 0 + _id_33D665A8348C47BD[_id_AC0E424AC96A7113];
      _id_7D5D0059E2ECD538.y = 60 + _id_33D664A8348C458A[_id_AC0E424AC96A7113] + _id_AC0E594AC96AA3A8 * 15;

      if(_id_AC0E424AC96A7113 > 0)
        _id_7D5D0059E2ECD538.color = (0, 0, 0);

      _id_9AF634FE97C006F5[_id_9AF634FE97C006F5.size] = _id_7D5D0059E2ECD538;
    }

    level._createfx.hudelems[_id_AC0E594AC96AA3A8] = _id_9AF634FE97C006F5;
  }

  hud = newhudelem();
  hud.archived = 0;
  hud.alignx = "center";
  hud.location = 0;
  hud.foreground = 1;
  hud.fontscale = 1.4;
  hud.sort = 20;
  hud.alpha = 1;
  hud.x = 320;
  hud.y = 40;
  level.createfx_centerprint = hud;
}

init_crosshair() {
  crosshair = newhudelem();
  crosshair.archived = 0;
  crosshair.location = 0;
  crosshair.alignx = "center";
  crosshair.aligny = "middle";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 1;
  crosshair.x = 320;
  crosshair.y = 233;
}

clear_fx_hudelements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.hudelem_count; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 1; _id_AC0E424AC96A7113++) {}
  }

  level.fxhudelements = 0;
}

set_fx_hudelement(text) {
  for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 1; _id_AC0E424AC96A7113++) {}

  level.fxhudelements++;
}

init_tool_hud() {
  if(!isDefined(level._createfx.tool_hudelems))
    level._createfx.tool_hudelems = [];

  if(!isDefined(level._createfx.tool_hud_visible))
    level._createfx.tool_hud_visible = 1;

  if(!isDefined(level._createfx.tool_hud))
    level._createfx.tool_hud = "";
}

new_tool_hud(name) {
  foreach(_id_FE8F7703F6313ED4, hud in level._createfx.tool_hudelems) {
    if(isDefined(hud.value_hudelem))
      hud.value_hudelem destroy();

    hud destroy();
    level._createfx.tool_hudelems[_id_FE8F7703F6313ED4] = undefined;
  }

  level._createfx.tool_hud = name;
}

current_mode_hud(name) {
  return level._createfx.tool_hud == name;
}

clear_tool_hud() {
  new_tool_hud("");
}

new_tool_hudelem(n) {
  hud = newhudelem();
  hud.archived = 0;
  hud.alignx = "left";
  hud.location = 0;
  hud.foreground = 1;
  hud.fontscale = 1.2;
  hud.alpha = 1;
  hud.x = 0;
  hud.y = 320 + n * 15;
  return hud;
}

get_tool_hudelem(name) {
  if(isDefined(level._createfx.tool_hudelems[name]))
    return level._createfx.tool_hudelems[name];

  return undefined;
}

set_tool_hudelem(_id_06B5C8034010B9BA, value) {
  if(level.mp_createfx) {
    return;
  }
  hud = get_tool_hudelem(_id_06B5C8034010B9BA);

  if(!isDefined(hud)) {
    hud = new_tool_hudelem(level._createfx.tool_hudelems.size);
    level._createfx.tool_hudelems[_id_06B5C8034010B9BA] = hud;
    hud.text = _id_06B5C8034010B9BA;
  }

  if(isDefined(value)) {
    if(isDefined(hud.value_hudelem))
      _id_194685C0017BA3C8 = hud.value_hudelem;
    else {
      _id_194685C0017BA3C8 = new_tool_hudelem(level._createfx.tool_hudelems.size);
      _id_194685C0017BA3C8.x = _id_194685C0017BA3C8.x + 100;
      _id_194685C0017BA3C8.y = hud.y;
      hud.value_hudelem = _id_194685C0017BA3C8;
    }

    if(isDefined(_id_194685C0017BA3C8.text) && _id_194685C0017BA3C8.text == value) {
      return;
    }
    _id_194685C0017BA3C8.text = value;
  }
}

select_by_substring() {
  _id_848AB95939DCA3CC = getDvar("select_by_substring");

  if(_id_848AB95939DCA3CC == "")
    return 0;

  setDvar("select_by_substring", "");
  _id_9EAB1F284573CC85 = [];

  foreach(_id_AC0E594AC96AA3A8, ent in level.createfxent) {
    if(issubstr(ent.v["fxid"], _id_848AB95939DCA3CC))
      _id_9EAB1F284573CC85[_id_9EAB1F284573CC85.size] = _id_AC0E594AC96AA3A8;
  }

  if(_id_9EAB1F284573CC85.size == 0)
    return 0;

  deselect_all_ents();
  select_index_array(_id_9EAB1F284573CC85);

  foreach(index in _id_9EAB1F284573CC85) {
    ent = level.createfxent[index];
    select_entity(index, ent);
  }

  return 1;
}

select_index_array(_id_9EAB1F284573CC85) {
  foreach(index in _id_9EAB1F284573CC85) {
    ent = level.createfxent[index];
    select_entity(index, ent);
  }
}

deselect_all_ents() {
  foreach(_id_AC0E594AC96AA3A8, ent in level._createfx.selected_fx_ents)
  deselect_entity(_id_AC0E594AC96AA3A8, ent);
}