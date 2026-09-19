/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_createfxmenu.gsc
********************************************/

init_menu() {
  level._createfx.options = [];
  _id_09DD("vector", "origin", "Origin", (0, 0, 0), "fx", 1);
  _id_09DD("vector", "angles", "Angles", (0, 0, 0), "fx", 1);
  _id_09DD("string", "fxid", "FX id", "nil", "fx");
  _id_09DD("float", "delay", "Repeat rate/start delay", 0.5, "fx");
  _id_09DD("string", "flag", "Flag", "nil", "exploder");
  _id_09DD("string", "platform", "Platform", "all", "all");

  if(!level.mp_createfx) {
    _id_09DD("string", "firefx", "2nd FX id", "nil", "exploder");
    _id_09DD("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
    _id_09DD("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
    _id_09DD("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
    _id_09DD("float", "damage", "Radius damage", 150, "exploder");
    _id_09DD("float", "damage_radius", "Radius of radius damage", 250, "exploder");
    _id_09DD("string", "earthquake", "Earthquake", "nil", "exploder");
    _id_09DD("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
  }

  _id_09DD("float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval");
  _id_09DD("float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval");
  _id_09DD("int", "repeat", "Number of times to repeat", 5, "exploder");
  _id_09DD("string", "exploder", "Exploder", "1", "exploder");
  _id_884C();
  _id_09DD("string", "soundalias", "Soundalias", "nil", "all");
  _id_09DD("string", "loopsound", "Loopsound", "nil", "exploder");
  _id_09DD("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", undefined, ::_id_53BD);
  _id_09DD("string", "ambiencename", "Ambience Name", "nil", "soundfx_dynamic");
  _id_09DD("int", "dynamic_distance", "Dynamic Max Distance", 1000, "soundfx_dynamic");

  if(!level.mp_createfx) {
    _id_09DD("string", "rumble", "Rumble", "nil", "exploder");
    _id_09DD("int", "stoppable", "Can be stopped from script", "1", "all");
    _id_09DD("string", "end_notify", "End notify", "nil", "all");
    _id_09DD("int", "stopable", "Stopable", "0", "all");
  }

  level.effect_list_offset = 0;
  level._id_359E = 8;
  level._id_359C = 0;
  level._id_4CAD = 0;
  level._id_4CAE = 12;
  level.createfx_help_active = 0;
  level.createfx_menu_list_active = 0;
  level._id_2809 = [];
  level._id_2809["all"] = [];
  level._id_2809["all"]["exploder"] = 1;
  level._id_2809["all"]["oneshotfx"] = 1;
  level._id_2809["all"]["loopfx"] = 1;
  level._id_2809["all"]["soundfx"] = 1;
  level._id_2809["all"]["soundfx_interval"] = 1;
  level._id_2809["all"]["reactive_fx"] = 1;
  level._id_2809["all"]["soundfx_dynamic"] = 1;
  level._id_2809["fx"] = [];
  level._id_2809["fx"]["exploder"] = 1;
  level._id_2809["fx"]["oneshotfx"] = 1;
  level._id_2809["fx"]["loopfx"] = 1;
  level._id_2809["exploder"] = [];
  level._id_2809["exploder"]["exploder"] = 1;
  level._id_2809["loopfx"] = [];
  level._id_2809["loopfx"]["loopfx"] = 1;
  level._id_2809["oneshotfx"] = [];
  level._id_2809["oneshotfx"]["oneshotfx"] = 1;
  level._id_2809["soundfx"] = [];
  level._id_2809["soundfx"]["soundalias"] = 1;
  level._id_2809["soundfx_interval"] = [];
  level._id_2809["soundfx_interval"]["soundfx_interval"] = 1;
  level._id_2809["reactive_fx"] = [];
  level._id_2809["reactive_fx"]["reactive_fx"] = 1;
  level._id_2809["soundfx_dynamic"] = [];
  level._id_2809["soundfx_dynamic"]["soundfx_dynamic"] = 1;
  var_0 = [];
  var_0["creation"] = ::_id_610C;
  var_0["create_oneshot"] = ::_id_610B;
  var_0["create_loopfx"] = ::_id_610B;
  var_0["change_fxid"] = ::_id_610B;
  var_0["none"] = ::_id_610F;
  var_0["add_options"] = ::_id_6109;
  var_0["select_by_name"] = ::_id_6110;
  level._createfx._id_6115 = var_0;
}

_id_6108(var_0) {
  return level.create_fx_menu == var_0;
}

setmenu(var_0) {
  level.create_fx_menu = var_0;
}

create_fx_menu() {
  if(common_scripts\_createfx::button_is_clicked("escape", "x")) {
    _id_0624();
    return;
  }

  if(isDefined(level._createfx._id_6115[level.create_fx_menu]))
    [[level._createfx._id_6115[level.create_fx_menu]]]();
}

_id_610C() {
  if(common_scripts\_createfx::button_is_clicked("1")) {
    setmenu("create_oneshot");
    draw_effects_list();
    return;
  } else if(common_scripts\_createfx::button_is_clicked("2")) {
    setmenu("create_loopfx");
    draw_effects_list();
    return;
  } else if(common_scripts\_createfx::button_is_clicked("3")) {
    setmenu("create_loopsound");
    var_0 = common_scripts\_createfx::createloopsound();
    _id_3B9F(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("4")) {
    setmenu("create_exploder");
    var_0 = common_scripts\_createfx::createnewexploder();
    _id_3B9F(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("5")) {
    setmenu("create_interval_sound");
    var_0 = common_scripts\_createfx::createintervalsound();
    _id_3B9F(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("6")) {
    var_0 = common_scripts\_createfx::createreactiveent();
    _id_3B9F(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("7")) {
    var_0 = common_scripts\_createfx::createdynamicambience();
    _id_3B9F(var_0);
    return;
  }
}

_id_610B() {
  level.createfx_menu_list_active = 1;

  if(_id_66A4()) {
    _id_50F2();
    draw_effects_list();
  } else if(_id_76D5()) {
    _id_2B75();
    draw_effects_list();
  }

  _id_610D();
}

_id_610F() {
  if(common_scripts\_createfx::button_is_clicked("m"))
    _id_50F2();

  _id_610A();

  if(entities_are_selected()) {
    var_0 = get_last_selected_ent();

    if(!isDefined(level.last_displayed_ent) || var_0 != level.last_displayed_ent || level._createfx.justconvertedoneshot == 1) {
      display_fx_info(var_0);
      level.last_displayed_ent = var_0;
      level._createfx.justconvertedoneshot = 0;
    }

    if(common_scripts\_createfx::button_is_clicked("a")) {
      common_scripts\_createfx::clear_settable_fx();
      setmenu("add_options");
      return;
    }
  } else
    level.last_displayed_ent = undefined;
}

_id_6109() {
  if(!entities_are_selected()) {
    common_scripts\_createfx::clear_fx_hudelements();
    setmenu("none");
    return;
  }

  _id_2FF5(get_last_selected_ent());

  if(_id_66A4())
    _id_50F2();
}

_id_6110() {
  if(_id_66A4()) {
    _id_50F2();
    draw_effects_list("Select by name");
  } else if(_id_76D5()) {
    _id_2B75();
    draw_effects_list("Select by name");
  }

  select_by_name();
}

_id_66A4() {
  return common_scripts\_createfx::button_is_clicked("rightarrow");
}

_id_76D5() {
  return common_scripts\_createfx::button_is_clicked("leftarrow");
}

_id_0624() {
  common_scripts\_createfx::clear_fx_hudelements();
  common_scripts\_createfx::clear_entity_selection();
  common_scripts\_createfx::update_selected_ents();
  setmenu("none");
}

_id_610D() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = common_scripts\_createfx::func_get_level_fx();

  for(var_3 = level.effect_list_offset; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10)
      var_4 = 0;

    if(common_scripts\_createfx::button_is_clicked(var_4 + "")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level._id_359E) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(_id_6108("change_fxid")) {
    _id_0F2A(_id_4265("fxid"), var_1);
    level.effect_list_offset = 0;
    common_scripts\_createfx::clear_fx_hudelements();
    setmenu("none");
    level.createfx_menu_list_active = 0;
    level.createfx_last_movement_timer = 0;
    return;
  }

  var_5 = undefined;

  if(_id_6108("create_loopfx"))
    var_5 = common_scripts\utility::_id_2814(var_1);

  if(_id_6108("create_oneshot"))
    var_5 = common_scripts\utility::_id_281B(var_1);

  _id_3B9F(var_5);
}

_id_3B9F(var_0) {
  var_0.v["angles"] = vectortoangles(var_0.v["origin"] + (0, 0, 100) - var_0.v["origin"]);
  var_0 common_scripts\_createfx::post_entity_creation_function();
  common_scripts\_createfx::clear_entity_selection();
  common_scripts\_createfx::select_last_entity();
  common_scripts\_createfx::move_selection_to_cursor();
  common_scripts\_createfx::update_selected_ents();
  setmenu("none");
  level.createfx_menu_list_active = 0;
}

entities_are_selected() {
  return level._createfx.selected_fx_ents.size > 0;
}

_id_610A() {
  if(!level._createfx.selected_fx_ents.size) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = get_last_selected_ent();

  for(var_3 = 0; var_3 < level._createfx.options.size; var_3++) {
    var_4 = level._createfx.options[var_3];

    if(!isDefined(var_2.v[var_4["name"]])) {
      continue;
    }
    var_0++;

    if(var_0 < level.effect_list_offset) {
      continue;
    }
    var_1++;
    var_5 = var_1;

    if(var_5 == 10)
      var_5 = 0;

    if(common_scripts\_createfx::button_is_clicked(var_5 + "")) {
      _id_769E(var_4, var_1);
      break;
    }

    if(var_1 > level._id_359E) {
      var_6 = 1;
      break;
    }
  }
}

_id_769E(var_0, var_1) {
  if(var_0["name"] == "fxid") {
    setmenu("change_fxid");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = 1;
  level._createfx.hudelems[var_1 + 1].color = (1, 1, 0);

  if(isDefined(var_0["input_func"]))
    thread[[var_0["input_func"]]](var_1 + 1);
  else
    common_scripts\_createfx::createfx_centerprint("To set " + var_0["description"] + ", type /fx newvalue. To remove " + var_0["description"] + ", type /fx del");

  _id_8542(var_0["name"]);
  setDvar("fx", "nil");
}

menu_fx_option_set() {
  if(getDvar("fx") == "nil") {
    return;
  }
  if(getDvar("fx") == "del")
    common_scripts\_createfx::remove_selected_option();
  else {
    var_0 = _id_431E();
    var_1 = undefined;

    if(var_0["type"] == "string")
      var_1 = getDvar("fx");

    if(var_0["type"] == "int")
      var_1 = getdvarint("fx");

    if(var_0["type"] == "float")
      var_1 = getdvarfloat("fx");

    if(var_0["type"] == "vector")
      var_1 = _getdvarvector("fx");

    if(isDefined(var_1)) {
      _id_0F2A(var_0, var_1);
      return;
    }

    setDvar("fx", "nil");
  }
}

_id_0F2A(var_0, var_1) {
  common_scripts\_createfx::save_undo_buffer();

  for(var_2 = 0; var_2 < level._createfx.selected_fx_ents.size; var_2++) {
    var_3 = level._createfx.selected_fx_ents[var_2];

    if(mask(var_0["mask"], var_3.v["type"]))
      var_3.v[var_0["name"]] = var_1;
  }

  level.last_displayed_ent = undefined;
  common_scripts\_createfx::update_selected_ents();
  common_scripts\_createfx::clear_settable_fx();

  if(var_0["name"] == "origin") {
    level.createfx_last_movement_timer = 0;
    common_scripts\_createfx::frame_selected();
  }

  if(var_0["name"] == "angles")
    level.createfx_last_movement_timer = 0;

  common_scripts\_createfx::save_redo_buffer();
}

_id_8542(var_0) {
  for(var_1 = 0; var_1 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_1]["name"] != var_0) {
      continue;
    }
    level._createfx.selected_fx_option_index = var_1;
    return;
  }
}

_id_431E() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

mask(var_0, var_1) {
  return isDefined(level._id_2809[var_0][var_1]);
}

_id_09DD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_7["type"] = var_0;
  var_7["name"] = var_1;
  var_7["description"] = var_2;
  var_7["default"] = var_3;
  var_7["mask"] = var_4;

  if(isDefined(var_5) && var_5)
    var_7["nowrite"] = 1;
  else
    var_7["nowrite"] = 0;

  if(isDefined(var_6))
    var_7["input_func"] = var_6;

  level._createfx.options[level._createfx.options.size] = var_7;
}

_id_4265(var_0) {
  for(var_1 = 0; var_1 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_1]["name"] == var_0)
      return level._createfx.options[var_1];
  }
}

_id_53BD(var_0) {
  for(;;) {
    waitframe();

    if(level.player buttonPressed("escape") || level.player buttonPressed("x")) {
      break;
    }

    var_1 = 0;

    if(level.player buttonPressed("-"))
      var_1 = -10;
    else if(level.player buttonPressed("="))
      var_1 = 10;

    if(var_1 != 0) {
      foreach(var_3 in level._createfx.selected_fx_ents) {
        if(isDefined(var_3.v["reactive_radius"])) {
          var_3.v["reactive_radius"] = var_3.v["reactive_radius"] + var_1;
          var_3.v["reactive_radius"] = clamp(var_3.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  common_scripts\_createfx::update_selected_ents();
  common_scripts\_createfx::clear_settable_fx();
}

_id_2FF5(var_0) {
  level.createfx_menu_list_active = 1;
  common_scripts\_createfx::clear_fx_hudelements();
  common_scripts\_createfx::set_fx_hudelement("Name: " + var_0.v["fxid"]);
  common_scripts\_createfx::set_fx_hudelement("Type: " + var_0.v["type"]);
  common_scripts\_createfx::set_fx_hudelement("Origin: " + var_0.v["origin"]);
  common_scripts\_createfx::set_fx_hudelement("Angles: " + var_0.v["angles"]);
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(level.effect_list_offset >= level._createfx.options.size)
    level.effect_list_offset = 0;

  for(var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
    var_5 = level._createfx.options[var_4];

    if(isDefined(var_0.v[var_5["name"]])) {
      continue;
    }
    if(!mask(var_5["mask"], var_0.v["type"])) {
      continue;
    }
    var_1++;

    if(var_1 < level.effect_list_offset) {
      continue;
    }
    if(var_2 >= level._id_359E) {
      continue;
    }
    var_2++;
    var_6 = var_2;

    if(var_6 == 10)
      var_6 = 0;

    if(common_scripts\_createfx::button_is_clicked(var_6 + "")) {
      _id_0952(var_5);
      _id_6114();
      level.last_displayed_ent = undefined;
      return;
    }

    common_scripts\_createfx::set_fx_hudelement(var_6 + ". " + var_5["description"]);
  }

  if(var_1 > level._id_359E) {
    level._id_359C = var_1;
    common_scripts\_createfx::set_fx_hudelement("(->) More >");
  }

  common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
}

_id_0952(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < level._createfx.selected_fx_ents.size; var_2++) {
    var_3 = level._createfx.selected_fx_ents[var_2];

    if(mask(var_0["mask"], var_3.v["type"]))
      var_3.v[var_0["name"]] = var_0["default"];
  }
}

_id_6114() {
  level.effect_list_offset = 0;
  common_scripts\_createfx::clear_fx_hudelements();
  setmenu("none");
}

display_fx_info(var_0) {
  if(!_id_6108("none")) {
    return;
  }
  if(level.createfx_help_active) {
    return;
  }
  common_scripts\_createfx::clear_fx_hudelements();
  common_scripts\_createfx::set_fx_hudelement("Name: " + var_0.v["fxid"]);
  common_scripts\_createfx::set_fx_hudelement("Type: " + var_0.v["type"]);

  if(entities_are_selected()) {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    for(var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
      var_5 = level._createfx.options[var_4];

      if(!isDefined(var_0.v[var_5["name"]])) {
        continue;
      }
      var_1++;

      if(var_1 < level.effect_list_offset) {
        continue;
      }
      var_2++;
      common_scripts\_createfx::set_fx_hudelement(var_2 + ". " + var_5["description"] + ": " + var_0.v[var_5["name"]]);

      if(var_2 > level._id_359E) {
        var_3 = 1;
        break;
      }
    }

    if(var_1 > level._id_359E) {
      level._id_359C = var_1;
      common_scripts\_createfx::set_fx_hudelement("(->) More >");
    }

    common_scripts\_createfx::set_fx_hudelement("(a) Add >");
    common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
  } else {
    var_1 = 0;
    var_3 = 0;

    for(var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
      var_5 = level._createfx.options[var_4];

      if(!isDefined(var_0.v[var_5["name"]])) {
        continue;
      }
      var_1++;
      common_scripts\_createfx::set_fx_hudelement(var_5["description"] + ": " + var_0.v[var_5["name"]]);

      if(var_1 > level._createfx.hudelem_count) {
        break;
      }
    }
  }
}

display_current_translations() {
  var_0 = get_last_selected_ent();

  if(isDefined(var_0))
    display_fx_info(var_0);
}

draw_effects_list(var_0) {
  common_scripts\_createfx::clear_fx_hudelements();
  var_1 = 0;
  var_2 = 0;
  var_3 = common_scripts\_createfx::func_get_level_fx();
  level._id_359C = var_3.size;

  if(!isDefined(var_0))
    var_0 = "Pick an effect";

  common_scripts\_createfx::set_fx_hudelement(var_0 + " [" + level.effect_list_offset + " - " + var_3.size + "]:");

  for(var_4 = level.effect_list_offset; var_4 < var_3.size; var_4++) {
    var_1 = var_1 + 1;
    common_scripts\_createfx::set_fx_hudelement(var_1 + ". " + var_3[var_4]);

    if(var_1 >= level._id_359E) {
      var_2 = 1;
      break;
    }
  }

  if(var_3.size > level._id_359E)
    common_scripts\_createfx::set_fx_hudelement("(<-) Previous ... More(->)");
}

_id_50F2() {
  if(level.effect_list_offset >= level._id_359C - level._id_359E)
    level.effect_list_offset = 0;
  else
    level.effect_list_offset = level.effect_list_offset + level._id_359E;
}

_id_2B75() {
  if(level._id_359C < level._id_359E)
    level.effect_list_offset = 0;
  else {
    level.effect_list_offset = level.effect_list_offset - level._id_359E;

    if(level.effect_list_offset < 0)
      level.effect_list_offset = level._id_359C - level._id_359E;
  }
}

draw_help_list(var_0) {
  common_scripts\_createfx::clear_fx_hudelements();
  var_1 = 0;
  var_2 = level._id_27FA;

  if(!isDefined(var_0))
    var_0 = "Help";

  common_scripts\_createfx::set_fx_hudelement("[" + var_0 + "]");

  for(var_3 = level._id_4CAD; var_3 < var_2.size; var_3++) {
    var_1 = var_1 + 1;
    common_scripts\_createfx::set_fx_hudelement(var_2[var_3]);

    if(var_1 >= level._id_4CAE) {
      var_4 = 1;
      break;
    }
  }

  if(var_2.size > level._id_4CAE) {
    level._id_359C = var_2.size;
    common_scripts\_createfx::set_fx_hudelement("(<-) Previous ... More(->)");
  }
}

_id_50EE() {
  var_0 = level._id_27FA;

  if(level._id_4CAD >= var_0.size - level._id_4CAE)
    level._id_4CAD = 0;
  else
    level._id_4CAD = level._id_4CAD + level._id_4CAE;
}

_id_2B74() {
  level._id_4CAD = level._id_4CAD - level._id_4CAE;

  if(level._id_4CAD < 0) {
    var_0 = level._id_27FA;
    level._id_4CAD = var_0.size - level._id_4CAE;
  }
}

help_navigation_buttons() {
  while(level.createfx_help_active == 1) {
    if(_id_66A4()) {
      _id_50EE();
      draw_help_list();
      wait 0.1;
    } else if(_id_76D5()) {
      _id_2B74();
      draw_help_list();
      wait 0.1;
    }

    waitframe();
  }
}

_id_884C() {
  level._id_27FA = ["Insert Insert entity", "F2 Toggle createfx dot and text drawing", "F5 SAVES your work", "ZUndo", "Shift-ZRedo", "FFrames currently selected entities in camera view", "JJumps to next placed instance of selected entity", "Shift-JJumps to previous placed instance of selected entity", "ENDDrop selected entities to the ground", "AAdd option to the selected entities", "BDraw bounding box of valid placeable FX area (MP only)", "PReset the rotation of the selected entities", "ICopy the angles from the most recently selected fx onto all selected fx.", "OOrient all selected fx to point at most recently selected fx.", "SToggle Snap2Normal mode.", "LToggle 90deg Snap mode.", "GSelect all exploders with same exploder num or flag.Select all oneshots of same fxid", "USelect by name list.", "CConvert between One-Shot and Exploder.", "Shift-RRandomize delay for all selected entities", "Delete Kill the selected entities", "ESCAPE Cancel out of option-modify-mode, must have console open", "SPACE or ->Turn on exploders", "<- Turn off exploders", "Dpad Move selected entities on X/Y or rotate pitch/yaw", "A button Toggle the selection of the current entity", "X button Toggle entity rotation mode", "Y button Move selected entites up or rotate roll", "B button Move selected entites down or rotate roll", "R Shoulder Move selected entities to the cursor", "L Shoulder Hold to select multiple entites", "L JoyClick Copy", "R JoyClick Paste", "Ctrl-C Copy", "Ctrl-V Paste", "NUFO", "TToggle Timescale FAST", "YToggle Timescale SLOW", "[Toggle FX Visibility", "]Toggle ShowTris", "VToggle Vector Fields Debug Draw", "F11Toggle FX Profile"];
}

select_by_name() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = common_scripts\_createfx::func_get_level_fx();

  for(var_3 = level.effect_list_offset; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10)
      var_4 = 0;

    if(common_scripts\_createfx::button_is_clicked(var_4 + "")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level._id_359E) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_5 = [];

  foreach(var_3, var_7 in level.createfxent) {
    if(issubstr(var_7.v["fxid"], var_1))
      var_5[var_5.size] = var_3;
  }

  common_scripts\_createfx::deselect_all_ents();
  common_scripts\_createfx::select_index_array(var_5);
  level._createfx.select_by_name = 1;
}

get_last_selected_ent() {
  return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}