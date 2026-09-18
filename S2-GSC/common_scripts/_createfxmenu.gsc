/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_createfxmenu.gsc
*********************************************/

init_menu() {
  level._createfx.options = [];
  func_09DD("vector", "origin", "Origin", (0, 0, 0), "fx", 1);
  func_09DD("vector", "angles", "Angles", (0, 0, 0), "fx", 1);
  func_09DD("string", "fxid", "FX id", "nil", "fx");
  func_09DD("float", "delay", "Repeat rate/start delay", 0.5, "fx");
  func_09DD("string", "flag", "Flag", "nil", "exploder");
  func_09DD("string", "platform", "Platform", "all", "all");
  if(!level.mp_createfx) {
    func_09DD("string", "firefx", "2nd FX id", "nil", "exploder");
    func_09DD("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
    func_09DD("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
    func_09DD("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
    func_09DD("float", "damage", "Radius damage", 150, "exploder");
    func_09DD("float", "damage_radius", "Radius of radius damage", 250, "exploder");
    func_09DD("string", "earthquake", "Earthquake", "nil", "exploder");
    func_09DD("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
  }

  func_09DD("float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval");
  func_09DD("float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval");
  func_09DD("int", "repeat", "Number of times to repeat", 5, "exploder");
  func_09DD("string", "exploder", "Exploder", "1", "exploder");
  func_884C();
  func_09DD("string", "soundalias", "Soundalias", "nil", "all");
  func_09DD("string", "loopsound", "Loopsound", "nil", "exploder");
  func_09DD("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", undefined, ::func_53BD);
  func_09DD("string", "ambiencename", "Ambience Name", "nil", "soundfx_dynamic");
  func_09DD("int", "dynamic_distance", "Dynamic Max Distance", 1000, "soundfx_dynamic");
  if(!level.mp_createfx) {
    func_09DD("string", "rumble", "Rumble", "nil", "exploder");
    func_09DD("int", "stoppable", "Can be stopped from script", "1", "all");
    func_09DD("string", "end_notify", "End notify", "nil", "all");
    func_09DD("int", "stopable", "Stopable", "0", "all");
  }

  level.effect_list_offset = 0;
  level.var_359E = 8;
  level.var_359C = 0;
  level.var_4CAD = 0;
  level.var_4CAE = 12;
  level.createfx_help_active = 0;
  level.createfx_menu_list_active = 0;
  level.var_2809 = [];
  level.var_2809["all"] = [];
  level.var_2809["all"]["exploder"] = 1;
  level.var_2809["all"]["oneshotfx"] = 1;
  level.var_2809["all"]["loopfx"] = 1;
  level.var_2809["all"]["soundfx"] = 1;
  level.var_2809["all"]["soundfx_interval"] = 1;
  level.var_2809["all"]["reactive_fx"] = 1;
  level.var_2809["all"]["soundfx_dynamic"] = 1;
  level.var_2809["fx"] = [];
  level.var_2809["fx"]["exploder"] = 1;
  level.var_2809["fx"]["oneshotfx"] = 1;
  level.var_2809["fx"]["loopfx"] = 1;
  level.var_2809["exploder"] = [];
  level.var_2809["exploder"]["exploder"] = 1;
  level.var_2809["loopfx"] = [];
  level.var_2809["loopfx"]["loopfx"] = 1;
  level.var_2809["oneshotfx"] = [];
  level.var_2809["oneshotfx"]["oneshotfx"] = 1;
  level.var_2809["soundfx"] = [];
  level.var_2809["soundfx"]["soundalias"] = 1;
  level.var_2809["soundfx_interval"] = [];
  level.var_2809["soundfx_interval"]["soundfx_interval"] = 1;
  level.var_2809["reactive_fx"] = [];
  level.var_2809["reactive_fx"]["reactive_fx"] = 1;
  level.var_2809["soundfx_dynamic"] = [];
  level.var_2809["soundfx_dynamic"]["soundfx_dynamic"] = 1;
  var_00 = [];
  var_00["creation"] = ::func_610C;
  var_00["create_oneshot"] = ::func_610B;
  var_00["create_loopfx"] = ::func_610B;
  var_00["change_fxid"] = ::func_610B;
  var_00["none"] = ::func_610F;
  var_00["add_options"] = ::func_6109;
  var_00["select_by_name"] = ::func_6110;
  level._createfx.var_6115 = var_00;
}

func_6108(param_00) {
  return level.create_fx_menu == param_00;
}

setmenu(param_00) {
  level.create_fx_menu = param_00;
}

create_fx_menu() {
  if(common_scripts\_createfx::button_is_clicked("escape", "x")) {
    func_0624();
    return;
  }

  if(isDefined(level._createfx.var_6115[level.create_fx_menu])) {
    [[level._createfx.var_6115[level.create_fx_menu]]]();
  }
}

func_610C() {
  if(common_scripts\_createfx::button_is_clicked("1")) {
    setmenu("create_oneshot");
    draw_effects_list();
    return;
  }

  if(common_scripts\_createfx::button_is_clicked("2")) {
    setmenu("create_loopfx");
    draw_effects_list();
    return;
  }

  if(common_scripts\_createfx::button_is_clicked("3")) {
    setmenu("create_loopsound");
    var_00 = common_scripts\_createfx::createloopsound();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::button_is_clicked("4")) {
    setmenu("create_exploder");
    var_00 = common_scripts\_createfx::createnewexploder();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::button_is_clicked("5")) {
    setmenu("create_interval_sound");
    var_00 = common_scripts\_createfx::createintervalsound();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::button_is_clicked("6")) {
    var_00 = common_scripts\_createfx::createreactiveent();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::button_is_clicked("7")) {
    var_00 = common_scripts\_createfx::createdynamicambience();
    func_3B9F(var_00);
    return;
  }
}

func_610B() {
  level.createfx_menu_list_active = 1;
  if(func_66A4()) {
    func_50F2();
    draw_effects_list();
  } else if(func_76D5()) {
    func_2B75();
    draw_effects_list();
  }

  func_610D();
}

func_610F() {
  if(common_scripts\_createfx::button_is_clicked("m")) {
    func_50F2();
  }

  func_610A();
  if(entities_are_selected()) {
    var_00 = get_last_selected_ent();
    if(!isDefined(level.last_displayed_ent) || var_00 != level.last_displayed_ent || level._createfx.justconvertedoneshot == 1) {
      display_fx_info(var_00);
      level.last_displayed_ent = var_00;
      level._createfx.justconvertedoneshot = 0;
    }

    if(common_scripts\_createfx::button_is_clicked("a")) {
      common_scripts\_createfx::clear_settable_fx();
      setmenu("add_options");
      return;
    }

    return;
  }

  level.last_displayed_ent = undefined;
}

func_6109() {
  if(!entities_are_selected()) {
    common_scripts\_createfx::clear_fx_hudelements();
    setmenu("none");
    return;
  }

  func_2FF5(get_last_selected_ent());
  if(func_66A4()) {
    func_50F2();
  }
}

func_6110() {
  if(func_66A4()) {
    func_50F2();
    draw_effects_list("Select by name");
  } else if(func_76D5()) {
    func_2B75();
    draw_effects_list("Select by name");
  }

  select_by_name();
}

func_66A4() {
  return common_scripts\_createfx::button_is_clicked("rightarrow");
}

func_76D5() {
  return common_scripts\_createfx::button_is_clicked("leftarrow");
}

func_0624() {
  common_scripts\_createfx::clear_fx_hudelements();
  common_scripts\_createfx::clear_entity_selection();
  common_scripts\_createfx::update_selected_ents();
  setmenu("none");
}

func_610D() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = common_scripts\_createfx::func_get_level_fx();
  for(var_03 = level.effect_list_offset; var_03 < var_02.size; var_03++) {
    var_00 = var_00 + 1;
    var_04 = var_00;
    if(var_04 == 10) {
      var_04 = 0;
    }

    if(common_scripts\_createfx::button_is_clicked(var_04 + "")) {
      var_01 = var_02[var_03];
      break;
    }

    if(var_00 > level.var_359E) {
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }

  if(func_6108("change_fxid")) {
    func_0F2A(func_4265("fxid"), var_01);
    level.effect_list_offset = 0;
    common_scripts\_createfx::clear_fx_hudelements();
    setmenu("none");
    level.createfx_menu_list_active = 0;
    level.createfx_last_movement_timer = 0;
    return;
  }

  var_05 = undefined;
  if(func_6108("create_loopfx")) {
    var_05 = common_scripts\utility::func_2814(var_01);
  }

  if(func_6108("create_oneshot")) {
    var_05 = common_scripts\utility::func_281B(var_01);
  }

  func_3B9F(var_05);
}

func_3B9F(param_00) {
  param_00.v["angles"] = vectortoangles(param_00.v["origin"] + (0, 0, 100) - param_00.v["origin"]);
  param_00 common_scripts\_createfx::post_entity_creation_function();
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

func_610A() {
  if(!level._createfx.selected_fx_ents.size) {
    return;
  }

  var_00 = 0;
  var_01 = 0;
  var_02 = get_last_selected_ent();
  for(var_03 = 0; var_03 < level._createfx.options.size; var_03++) {
    var_04 = level._createfx.options[var_03];
    if(!isDefined(var_02.v[var_04["name"]])) {
      continue;
    }

    var_00++;
    if(var_00 < level.effect_list_offset) {
      continue;
    }

    var_01++;
    var_05 = var_01;
    if(var_05 == 10) {
      var_05 = 0;
    }

    if(common_scripts\_createfx::button_is_clicked(var_05 + "")) {
      func_769E(var_04, var_01);
      break;
    }

    if(var_01 > level.var_359E) {
      var_06 = 1;
      break;
    }
  }
}

func_769E(param_00, param_01) {
  if(param_00["name"] == "fxid") {
    setmenu("change_fxid");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = 1;
  level._createfx.hudelems[param_01 + 1].color = (1, 1, 0);
  if(isDefined(param_00["input_func"])) {
    thread[[param_00["input_func"]]](param_01 + 1);
  } else {
    common_scripts\_createfx::createfx_centerprint("To set " + param_00["description"] + ", type /fx newvalue. To remove " + param_00["description"] + ", type /fx del");
  }

  func_8542(param_00["name"]);
  setDvar("fx", "nil");
}

menu_fx_option_set() {
  if(getDvar("fx") == "nil") {
    return;
  }

  if(getDvar("fx") == "del") {
    common_scripts\_createfx::remove_selected_option();
    return;
  }

  var_00 = func_431E();
  var_01 = undefined;
  if(var_00["type"] == "string") {
    var_01 = getDvar("fx");
  }

  if(var_00["type"] == "int") {
    var_01 = getdvarint("fx");
  }

  if(var_00["type"] == "float") {
    var_01 = getdvarfloat("fx");
  }

  if(var_00["type"] == "vector") {
    var_01 = getdvarvector("fx");
  }

  if(isDefined(var_01)) {
    func_0F2A(var_00, var_01);
    return;
  }

  setDvar("fx", "nil");
}

func_0F2A(param_00, param_01) {
  common_scripts\_createfx::save_undo_buffer();
  for(var_02 = 0; var_02 < level._createfx.selected_fx_ents.size; var_02++) {
    var_03 = level._createfx.selected_fx_ents[var_02];
    if(mask(param_00["mask"], var_03.v["type"])) {
      var_03.v[param_00["name"]] = param_01;
    }
  }

  level.last_displayed_ent = undefined;
  common_scripts\_createfx::update_selected_ents();
  common_scripts\_createfx::clear_settable_fx();
  if(param_00["name"] == "origin") {
    level.createfx_last_movement_timer = 0;
    common_scripts\_createfx::frame_selected();
  }

  if(param_00["name"] == "angles") {
    level.createfx_last_movement_timer = 0;
  }

  common_scripts\_createfx::save_redo_buffer();
}

func_8542(param_00) {
  for(var_01 = 0; var_01 < level._createfx.options.size; var_01++) {
    if(level._createfx.options[var_01]["name"] != param_00) {
      continue;
    }

    level._createfx.selected_fx_option_index = var_01;
    return;
  }
}

func_431E() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

mask(param_00, param_01) {
  return isDefined(level.var_2809[param_00][param_01]);
}

func_09DD(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = [];
  var_07["type"] = param_00;
  var_07["name"] = param_01;
  var_07["description"] = param_02;
  var_07["default"] = param_03;
  var_07["mask"] = param_04;
  if(isDefined(param_05) && param_05) {
    var_07["nowrite"] = 1;
  } else {
    var_07["nowrite"] = 0;
  }

  if(isDefined(param_06)) {
    var_07["input_func"] = param_06;
  }

  level._createfx.options[level._createfx.options.size] = var_07;
}

func_4265(param_00) {
  for(var_01 = 0; var_01 < level._createfx.options.size; var_01++) {
    if(level._createfx.options[var_01]["name"] == param_00) {
      return level._createfx.options[var_01];
    }
  }
}

func_53BD(param_00) {
  for(;;) {
    wait 0.05;
    if(level.player buttonpresseddevonly("escape") || level.player buttonpresseddevonly("x")) {
      break;
    }

    var_01 = 0;
    if(level.player buttonpresseddevonly("-")) {
      var_01 = -10;
    } else if(level.player buttonpresseddevonly("=")) {
      var_01 = 10;
    }

    if(var_01 != 0) {
      foreach(var_03 in level._createfx.selected_fx_ents) {
        if(isDefined(var_03.v["reactive_radius"])) {
          var_03.v["reactive_radius"] = var_03.v["reactive_radius"] + var_01;
          var_03.v["reactive_radius"] = clamp(var_03.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  common_scripts\_createfx::update_selected_ents();
  common_scripts\_createfx::clear_settable_fx();
}

func_2FF5(param_00) {
  level.createfx_menu_list_active = 1;
  common_scripts\_createfx::clear_fx_hudelements();
  common_scripts\_createfx::set_fx_hudelement("Name: " + param_00.v["fxid"]);
  common_scripts\_createfx::set_fx_hudelement("Type: " + param_00.v["type"]);
  common_scripts\_createfx::set_fx_hudelement("Origin: " + param_00.v["origin"]);
  common_scripts\_createfx::set_fx_hudelement("Angles: " + param_00.v["angles"]);
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  if(level.effect_list_offset >= level._createfx.options.size) {
    level.effect_list_offset = 0;
  }

  for(var_04 = 0; var_04 < level._createfx.options.size; var_04++) {
    var_05 = level._createfx.options[var_04];
    if(isDefined(param_00.v[var_05["name"]])) {
      continue;
    }

    if(!mask(var_05["mask"], param_00.v["type"])) {
      continue;
    }

    var_01++;
    if(var_01 < level.effect_list_offset) {
      continue;
    }

    if(var_02 >= level.var_359E) {
      continue;
    }

    var_02++;
    var_06 = var_02;
    if(var_06 == 10) {
      var_06 = 0;
    }

    if(common_scripts\_createfx::button_is_clicked(var_06 + "")) {
      func_0952(var_05);
      func_6114();
      level.last_displayed_ent = undefined;
      return;
    }

    common_scripts\_createfx::set_fx_hudelement(var_06 + ". " + var_05["description"]);
  }

  if(var_01 > level.var_359E) {
    level.var_359C = var_01;
    common_scripts\_createfx::set_fx_hudelement("(->) More >");
  }

  common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
}

func_0952(param_00) {
  var_01 = undefined;
  for(var_02 = 0; var_02 < level._createfx.selected_fx_ents.size; var_02++) {
    var_03 = level._createfx.selected_fx_ents[var_02];
    if(mask(param_00["mask"], var_03.v["type"])) {
      var_03.v[param_00["name"]] = param_00["default"];
    }
  }
}

func_6114() {
  level.effect_list_offset = 0;
  common_scripts\_createfx::clear_fx_hudelements();
  setmenu("none");
}

display_fx_info(param_00) {
  if(!func_6108("none")) {
    return;
  }

  if(level.createfx_help_active) {
    return;
  }

  common_scripts\_createfx::clear_fx_hudelements();
  common_scripts\_createfx::set_fx_hudelement("Name: " + param_00.v["fxid"]);
  common_scripts\_createfx::set_fx_hudelement("Type: " + param_00.v["type"]);
  if(entities_are_selected()) {
    var_01 = 0;
    var_02 = 0;
    var_03 = 0;
    for(var_04 = 0; var_04 < level._createfx.options.size; var_04++) {
      var_05 = level._createfx.options[var_04];
      if(!isDefined(param_00.v[var_05["name"]])) {
        continue;
      }

      var_01++;
      if(var_01 < level.effect_list_offset) {
        continue;
      }

      var_02++;
      common_scripts\_createfx::set_fx_hudelement(var_02 + ". " + var_05["description"] + ": " + param_00.v[var_05["name"]]);
      if(var_02 > level.var_359E) {
        var_03 = 1;
        break;
      }
    }

    if(var_01 > level.var_359E) {
      level.var_359C = var_01;
      common_scripts\_createfx::set_fx_hudelement("(->) More >");
    }

    common_scripts\_createfx::set_fx_hudelement("(a) Add >");
    common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
    return;
  }

  var_01 = 0;
  var_03 = 0;
  for(var_04 = 0; var_04 < level._createfx.options.size; var_04++) {
    var_05 = level._createfx.options[var_04];
    if(!isDefined(param_00.v[var_05["name"]])) {
      continue;
    }

    var_01++;
    common_scripts\_createfx::set_fx_hudelement(var_05["description"] + ": " + param_00.v[var_05["name"]]);
    if(var_01 > level._createfx.hudelem_count) {
      break;
    }
  }
}

display_current_translations() {
  var_00 = get_last_selected_ent();
  if(isDefined(var_00)) {
    display_fx_info(var_00);
  }
}

draw_effects_list(param_00) {
  common_scripts\_createfx::clear_fx_hudelements();
  var_01 = 0;
  var_02 = 0;
  var_03 = common_scripts\_createfx::func_get_level_fx();
  level.var_359C = var_03.size;
  if(!isDefined(param_00)) {
    param_00 = "Pick an effect";
  }

  common_scripts\_createfx::set_fx_hudelement(param_00 + " [" + level.effect_list_offset + " - " + var_03.size + "]:");
  for(var_04 = level.effect_list_offset; var_04 < var_03.size; var_04++) {
    var_01 = var_01 + 1;
    common_scripts\_createfx::set_fx_hudelement(var_01 + ". " + var_03[var_04]);
    if(var_01 >= level.var_359E) {
      var_02 = 1;
      break;
    }
  }

  if(var_03.size > level.var_359E) {
    common_scripts\_createfx::set_fx_hudelement("(<-) Previous ... More(->)");
  }
}

func_50F2() {
  if(level.effect_list_offset >= level.var_359C - level.var_359E) {
    level.effect_list_offset = 0;
    return;
  }

  level.effect_list_offset = level.effect_list_offset + level.var_359E;
}

func_2B75() {
  if(level.var_359C < level.var_359E) {
    level.effect_list_offset = 0;
    return;
  }

  level.effect_list_offset = level.effect_list_offset - level.var_359E;
  if(level.effect_list_offset < 0) {
    level.effect_list_offset = level.var_359C - level.var_359E;
  }
}

draw_help_list(param_00) {
  common_scripts\_createfx::clear_fx_hudelements();
  var_01 = 0;
  var_02 = level.var_27FA;
  if(!isDefined(param_00)) {
    param_00 = "Help";
  }

  common_scripts\_createfx::set_fx_hudelement("[" + param_00 + "]");
  for(var_03 = level.var_4CAD; var_03 < var_02.size; var_03++) {
    var_01 = var_01 + 1;
    common_scripts\_createfx::set_fx_hudelement(var_02[var_03]);
    if(var_01 >= level.var_4CAE) {
      var_04 = 1;
      break;
    }
  }

  if(var_02.size > level.var_4CAE) {
    level.var_359C = var_02.size;
    common_scripts\_createfx::set_fx_hudelement("(<-) Previous ... More(->)");
  }
}

func_50EE() {
  var_00 = level.var_27FA;
  if(level.var_4CAD >= var_00.size - level.var_4CAE) {
    level.var_4CAD = 0;
    return;
  }

  level.var_4CAD = level.var_4CAD + level.var_4CAE;
}

func_2B74() {
  level.var_4CAD = level.var_4CAD - level.var_4CAE;
  if(level.var_4CAD < 0) {
    var_00 = level.var_27FA;
    level.var_4CAD = var_00.size - level.var_4CAE;
  }
}

help_navigation_buttons() {
  while(level.createfx_help_active == 1) {
    if(func_66A4()) {
      func_50EE();
      draw_help_list();
      wait(0.1);
      continue;
    }

    if(func_76D5()) {
      func_2B74();
      draw_help_list();
      wait(0.1);
    }

    wait 0.05;
  }
}

func_884C() {
  level.var_27FA = ["Insert Insert entity", "F2 Toggle createfx dot and text drawing", "F5 SAVES your work", "ZUndo", "Shift-ZRedo", "FFrames currently selected entities in camera view", "JJumps to next placed instance of selected entity", "Shift-JJumps to previous placed instance of selected entity", "ENDDrop selected entities to the ground", "AAdd option to the selected entities", "BDraw bounding box of valid placeable FX area (MP only)", "PReset the rotation of the selected entities", "ICopy the angles from the most recently selected fx onto all selected fx.", "OOrient all selected fx to point at most recently selected fx.", "SToggle Snap2Normal mode.", "LToggle 90deg Snap mode.", "GSelect all exploders with same exploder num or flag.Select all oneshots of same fxid", "USelect by name list.", "CConvert between One-Shot and Exploder.", "Shift-RRandomize delay for all selected entities", "Delete Kill the selected entities", "ESCAPE Cancel out of option-modify-mode, must have console open", "SPACE or ->Turn on exploders", "<- Turn off exploders", "Dpad Move selected entities on X/Y or rotate pitch/yaw", "A button Toggle the selection of the current entity", "X button Toggle entity rotation mode", "Y button Move selected entites up or rotate roll", "B button Move selected entites down or rotate roll", "R Shoulder Move selected entities to the cursor", "L Shoulder Hold to select multiple entites", "L JoyClick Copy", "R JoyClick Paste", "Ctrl-C Copy", "Ctrl-V Paste", "NUFO", "TToggle Timescale FAST", "YToggle Timescale SLOW", "[Toggle FX Visibility", "]Toggle ShowTris", "VToggle Vector Fields Debug Draw", "F11Toggle FX Profile"];
}

select_by_name() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = common_scripts\_createfx::func_get_level_fx();
  for(var_03 = level.effect_list_offset; var_03 < var_02.size; var_03++) {
    var_00 = var_00 + 1;
    var_04 = var_00;
    if(var_04 == 10) {
      var_04 = 0;
    }

    if(common_scripts\_createfx::button_is_clicked(var_04 + "")) {
      var_01 = var_02[var_03];
      break;
    }

    if(var_00 > level.var_359E) {
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }

  var_05 = [];
  foreach(var_03, var_07 in level.createfxent) {
    if(issubstr(var_07.v["fxid"], var_01)) {
      var_05[var_05.size] = var_03;
    }
  }

  common_scripts\_createfx::deselect_all_ents();
  common_scripts\_createfx::select_index_array(var_05);
  level._createfx.select_by_name = 1;
}

get_last_selected_ent() {
  return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}