/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_createfxmenu.gsc
********************************************/

init_menu() {
  level._createfx.options = [];
  addoption("vector", "origin", "Origin", (0, 0, 0), "fx", 1);
  addoption("vector", "angles", "Angles", (0, 0, 0), "fx", 1);
  addoption("string", "fxid", "FX id", "nil", "fx");
  addoption("float", "delay", "Repeat rate\start delay", 0.5, "fx");
  addoption("string", "flag", "Flag", "nil", "exploder");
  addoption("string", "platform", "Platform", "all", "all");
  addoption("vector", "tintcolor", "Tint Color", (1, 1, 1), "fx");
  addoption("float", "tintalpha", "Tint Alpha", 1.0, "fx");
  addoption("vector", "fadein", "Fade In(base, range, 0)", (0, 0, 0), "fx");
  addoption("vector", "fadeout", "Fade Out(base, range, 0)", (0, 0, 0), "fx");
  addoption("float", "emissive", "Emissive", 1.0, "fx");
  addoption("float", "sizescale", "Scale", 1.0, "fx");

  if(!level.mp_createfx) {
    addoption("string", "firefx", "2nd FX id", "nil", "exploder");
    addoption("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
    addoption("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
    addoption("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
    addoption("float", "damage", "Radius damage", 150, "exploder");
    addoption("float", "damage_radius", "Radius of radius damage", 250, "exploder");
    addoption("string", "earthquake", "Earthquake", "nil", "exploder");
    addoption("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
  }

  addoption("float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval");
  addoption("float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval");
  addoption("int", "repeat", "Number of times to repeat", 5, "exploder");
  addoption("string", "exploder", "Exploder", "1", "exploder");
  addoption("string", "stop_on_exploder", "Stop on exploder", "1", "all");
  setup_help_keys();
  addoption("string", "soundalias", "Soundalias", "nil", "all");
  addoption("string", "loopsound", "Loopsound", "nil", "exploder");
  addoption("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", undefined, ::input_reactive_radius);
  addoption("string", "ambiencename", "Ambience Name", "nil", "soundfx_dynamic");
  addoption("int", "dynamic_distance", "Dynamic Max Distance", 1000, "soundfx_dynamic");

  if(!level.mp_createfx) {
    addoption("string", "rumble", "Rumble", "nil", "exploder");
    addoption("int", "stoppable", "Can be stopped from script", "1", "all");
  }

  level.effect_list_offset = 0;
  level.effect_list_offset_max = 10;
  level.effect_list_current_size = 0;
  level.help_list_offset = 0;
  level.help_list_offset_max = 20;
  level.createfx_help_active = 0;
  level.createfx_menu_list_active = 0;
  level.createfxmasks = [];
  level.createfxmasks["all"] = [];
  level.createfxmasks["all"]["exploder"] = 1;
  level.createfxmasks["all"]["oneshotfx"] = 1;
  level.createfxmasks["all"]["loopfx"] = 1;
  level.createfxmasks["all"]["soundfx"] = 1;
  level.createfxmasks["all"]["soundfx_interval"] = 1;
  level.createfxmasks["all"]["reactive_fx"] = 1;
  level.createfxmasks["all"]["soundfx_dynamic"] = 1;
  level.createfxmasks["fx"] = [];
  level.createfxmasks["fx"]["exploder"] = 1;
  level.createfxmasks["fx"]["oneshotfx"] = 1;
  level.createfxmasks["fx"]["loopfx"] = 1;
  level.createfxmasks["exploder"] = [];
  level.createfxmasks["exploder"]["exploder"] = 1;
  level.createfxmasks["loopfx"] = [];
  level.createfxmasks["loopfx"]["loopfx"] = 1;
  level.createfxmasks["oneshotfx"] = [];
  level.createfxmasks["oneshotfx"]["oneshotfx"] = 1;
  level.createfxmasks["soundfx"] = [];
  level.createfxmasks["soundfx"]["soundalias"] = 1;
  level.createfxmasks["soundfx_interval"] = [];
  level.createfxmasks["soundfx_interval"]["soundfx_interval"] = 1;
  level.createfxmasks["reactive_fx"] = [];
  level.createfxmasks["reactive_fx"]["reactive_fx"] = 1;
  level.createfxmasks["soundfx_dynamic"] = [];
  level.createfxmasks["soundfx_dynamic"]["soundfx_dynamic"] = 1;
  var_0 = [];
  var_0["creation"] = ::menu_create_select;
  var_0["create_oneshot"] = ::menu_create;
  var_0["create_loopfx"] = ::menu_create;
  var_0["change_fxid"] = ::menu_create;
  var_0["none"] = ::menu_none;
  var_0["add_options"] = ::menu_add_options;
  var_0["select_by_name"] = ::menu_select_by_name;
  level._createfx.menus = var_0;
}

menu(var_0) {
  return level.create_fx_menu == var_0;
}

setmenu(var_0) {
  level.create_fx_menu = var_0;
}

create_fx_menu() {
  if(common_scripts\_createfx::button_is_clicked("escape", "x")) {
    _exit_menu();
    return;
  }

  if(isdefined(level._createfx.menus[level.create_fx_menu]))
    [[level._createfx.menus[level.create_fx_menu]]]();
}

menu_create_select() {
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
    finish_creating_entity(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("4")) {
    setmenu("create_exploder");
    var_0 = common_scripts\_createfx::createnewexploder();
    finish_creating_entity(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("5")) {
    setmenu("create_interval_sound");
    var_0 = common_scripts\_createfx::createintervalsound();
    finish_creating_entity(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("6")) {
    var_0 = common_scripts\_createfx::createreactiveent();
    finish_creating_entity(var_0);
    return;
  } else if(common_scripts\_createfx::button_is_clicked("7")) {
    var_0 = common_scripts\_createfx::createdynamicambience();
    finish_creating_entity(var_0);
    return;
  }
}

menu_create() {
  level.createfx_menu_list_active = 1;

  if(next_button()) {
    increment_list_offset();
    draw_effects_list();
  } else if(previous_button()) {
    decrement_list_offset();
    draw_effects_list();
  }

  menu_fx_creation();
}

menu_none() {
  if(common_scripts\_createfx::button_is_clicked("m"))
    increment_list_offset();

  menu_change_selected_fx();

  if(entities_are_selected()) {
    var_0 = get_last_selected_ent();

    if(!isdefined(level.last_displayed_ent) || var_0 != level.last_displayed_ent || level._createfx.justconvertedoneshot == 1) {
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

menu_add_options() {
  if(!entities_are_selected()) {
    common_scripts\_createfx::clear_fx_hudelements();
    setmenu("none");
    return;
  }

  display_fx_add_options(get_last_selected_ent());

  if(next_button())
    increment_list_offset();
}

menu_select_by_name() {
  if(next_button()) {
    increment_list_offset();
    draw_effects_list("Select by name");
  } else if(previous_button()) {
    decrement_list_offset();
    draw_effects_list("Select by name");
  }

  select_by_name();
}

next_button() {
  return common_scripts\_createfx::button_is_clicked("rightarrow");
}

previous_button() {
  return common_scripts\_createfx::button_is_clicked("leftarrow");
}

_exit_menu() {
  common_scripts\_createfx::clear_fx_hudelements();
  common_scripts\_createfx::clear_entity_selection();
  common_scripts\_createfx::update_selected_entities();
  setmenu("none");
}

menu_fx_creation() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = common_scripts\_createfx::func_get_level_fx();

  for (var_3 = level.effect_list_offset; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10)
      var_4 = 0;

    if(common_scripts\_createfx::button_is_clicked(var_4 + "")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isdefined(var_1)) {
    return;
  }
  if(menu("change_fxid")) {
    apply_option_to_selected_fx(get_option("fxid"), var_1);
    level.effect_list_offset = 0;
    common_scripts\_createfx::clear_fx_hudelements();
    setmenu("none");
    level.createfx_menu_list_active = 0;
    level.createfx_last_movement_timer = 0;
    return;
  }

  var_5 = undefined;

  if(menu("create_loopfx"))
    var_5 = common_scripts\utility::createloopeffect(var_1);

  if(menu("create_oneshot"))
    var_5 = common_scripts\utility::createoneshoteffect(var_1);

  finish_creating_entity(var_5);
}

finish_creating_entity(var_0) {
  var_0.v["angles"] = vectortoangles(var_0.v["origin"] + (0, 0, 100) - var_0.v["origin"]);
  var_0 common_scripts\_createfx::post_entity_creation_function();
  common_scripts\_createfx::clear_entity_selection();
  common_scripts\_createfx::select_last_entity();
  common_scripts\_createfx::move_selection_to_cursor();
  common_scripts\_createfx::update_selected_entities();
  setmenu("none");
  level.createfx_menu_list_active = 0;
}

entities_are_selected() {
  return level._createfx.selected_fx_ents.size > 0;
}

menu_change_selected_fx() {
  if(!level._createfx.selected_fx_ents.size) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = get_last_selected_ent();

  for (var_3 = 0; var_3 < level._createfx.options.size; var_3++) {
    var_4 = level._createfx.options[var_3];

    if(!isdefined(var_2.v[var_4["name"]])) {
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
      prepare_option_for_change(var_4, var_1);
      break;
    }

    if(var_1 > level.effect_list_offset_max) {
      var_6 = 1;
      break;
    }
  }
}

prepare_option_for_change(var_0, var_1) {
  if(var_0["name"] == "fxid") {
    setmenu("change_fxid");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = 1;
  level._createfx.hudelems[var_1 + 1][0].color = (1, 1, 0);

  if(isdefined(var_0["input_func"]))
    thread[[var_0["input_func"]]](var_1 + 1);
  else
    common_scripts\_createfx::createfx_centerprint("To set " + var_0["description"] + ", type \fx newvalue. To remove " + var_0["description"] + ", type \fx del");

  set_option_index(var_0["name"]);
  setdvar("fx", "nil");
}

menu_fx_option_set() {
  if(getdvar("fx") == "nil") {
    return;
  }
  if(getdvar("fx") == "del")
    common_scripts\_createfx::remove_selected_option();
  else {
    var_0 = get_selected_option();
    var_1 = undefined;

    if(var_0["type"] == "string")
      var_1 = getdvar("fx");

    if(var_0["type"] == "int")
      var_1 = getdvarint("fx");

    if(var_0["type"] == "float")
      var_1 = getdvarfloat("fx");

    if(var_0["type"] == "vector")
      var_1 = getdvarvector("fx");

    if(isdefined(var_1)) {
      apply_option_to_selected_fx(var_0, var_1);
      return;
    }

    setdvar("fx", "nil");
  }
}

apply_option_to_selected_fx(var_0, var_1) {
  common_scripts\_createfx::save_undo_buffer();

  for (var_2 = 0; var_2 < level._createfx.selected_fx_ents.size; var_2++) {
    var_3 = level._createfx.selected_fx_ents[var_2];

    if(mask(var_0["mask"], var_3.v["type"]))
      var_3.v[var_0["name"]] = var_1;
  }

  level.last_displayed_ent = undefined;
  common_scripts\_createfx::update_selected_entities();
  common_scripts\_createfx::clear_settable_fx();

  if(var_0["name"] == "origin") {
    level.createfx_last_movement_timer = 0;
    common_scripts\_createfx::frame_selected();
  }

  if(var_0["name"] == "angles")
    level.createfx_last_movement_timer = 0;

  common_scripts\_createfx::save_redo_buffer();
}

set_option_index(var_0) {
  for (var_1 = 0; var_1 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_1]["name"] != var_0) {
      continue;
    }
    level._createfx.selected_fx_option_index = var_1;
    return;
  }
}

get_selected_option() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

mask(var_0, var_1) {
  return isdefined(level.createfxmasks[var_0][var_1]);
}

addoption(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_7["type"] = var_0;
  var_7["name"] = var_1;
  var_7["description"] = var_2;
  var_7["default"] = var_3;
  var_7["mask"] = var_4;

  if(isdefined(var_5) && var_5)
    var_7["nowrite"] = 1;
  else
    var_7["nowrite"] = 0;

  if(isdefined(var_6))
    var_7["input_func"] = var_6;

  level._createfx.options[level._createfx.options.size] = var_7;
}

get_option(var_0) {
  for (var_1 = 0; var_1 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_1]["name"] == var_0)
      return level._createfx.options[var_1];
  }
}

input_reactive_radius(var_0) {
  for (;;) {
    wait 0.05;

    if(level.player buttonpressed("escape") || level.player buttonpressed("x")) {
      break;
    }

    var_1 = 0;

    if(level.player buttonpressed("-"))
      var_1 = -10;
    else if(level.player buttonpressed("="))
      var_1 = 10;

    if(var_1 != 0) {
      foreach(var_3 in level._createfx.selected_fx_ents) {
        if(isdefined(var_3.v["reactive_radius"])) {
          var_3.v["reactive_radius"] = var_3.v["reactive_radius"] + var_1;
          var_3.v["reactive_radius"] = clamp(var_3.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  common_scripts\_createfx::update_selected_entities();
  common_scripts\_createfx::clear_settable_fx();
}

display_fx_add_options(var_0) {
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

  for (var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
    var_5 = level._createfx.options[var_4];

    if(isdefined(var_0.v[var_5["name"]])) {
      continue;
    }
    if(!mask(var_5["mask"], var_0.v["type"])) {
      continue;
    }
    var_1++;

    if(var_1 < level.effect_list_offset) {
      continue;
    }
    if(var_2 >= level.effect_list_offset_max) {
      continue;
    }
    var_2++;
    var_6 = var_2;

    if(var_6 == 10)
      var_6 = 0;

    if(common_scripts\_createfx::button_is_clicked(var_6 + "")) {
      add_option_to_selected_entities(var_5);
      menunone();
      level.last_displayed_ent = undefined;
      return;
    }

    common_scripts\_createfx::set_fx_hudelement(var_6 + ". " + var_5["description"]);
  }

  if(var_1 > level.effect_list_offset_max) {
    level.effect_list_current_size = var_1;
    common_scripts\_createfx::set_fx_hudelement("(->) More >");
  }

  common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
}

add_option_to_selected_entities(var_0) {
  var_1 = undefined;

  for (var_2 = 0; var_2 < level._createfx.selected_fx_ents.size; var_2++) {
    var_3 = level._createfx.selected_fx_ents[var_2];

    if(mask(var_0["mask"], var_3.v["type"]))
      var_3.v[var_0["name"]] = var_0["default"];
  }
}

menunone() {
  level.effect_list_offset = 0;
  common_scripts\_createfx::clear_fx_hudelements();
  setmenu("none");
}

display_fx_info(var_0) {
  if(!menu("none")) {
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

    for (var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
      var_5 = level._createfx.options[var_4];

      if(!isdefined(var_0.v[var_5["name"]])) {
        continue;
      }
      var_1++;

      if(var_1 < level.effect_list_offset) {
        continue;
      }
      var_2++;
      common_scripts\_createfx::set_fx_hudelement(var_2 + ". " + var_5["description"] + ": " + var_0.v[var_5["name"]]);

      if(var_2 > level.effect_list_offset_max) {
        var_3 = 1;
        break;
      }
    }

    if(var_1 > level.effect_list_offset_max) {
      level.effect_list_current_size = var_1;
      common_scripts\_createfx::set_fx_hudelement("(->) More >");
    }

    common_scripts\_createfx::set_fx_hudelement("(a) Add >");
    common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
  } else {
    var_1 = 0;
    var_3 = 0;

    for (var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
      var_5 = level._createfx.options[var_4];

      if(!isdefined(var_0.v[var_5["name"]])) {
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

display_current_translation() {
  var_0 = get_last_selected_ent();

  if(isdefined(var_0))
    display_fx_info(var_0);
}

draw_effects_list(var_0) {
  common_scripts\_createfx::clear_fx_hudelements();
  var_1 = 0;
  var_2 = 0;
  var_3 = common_scripts\_createfx::func_get_level_fx();
  level.effect_list_current_size = var_3.size;

  if(!isdefined(var_0))
    var_0 = "Pick an effect";

  common_scripts\_createfx::set_fx_hudelement(var_0 + " [" + level.effect_list_offset + " - " + var_3.size + "]:");

  for (var_4 = level.effect_list_offset; var_4 < var_3.size; var_4++) {
    var_1 = var_1 + 1;
    common_scripts\_createfx::set_fx_hudelement(var_1 + ". " + var_3[var_4]);

    if(var_1 >= level.effect_list_offset_max) {
      var_2 = 1;
      break;
    }
  }

  if(var_3.size > level.effect_list_offset_max) {
    common_scripts\_createfx::set_fx_hudelement("(->) More >");
    common_scripts\_createfx::set_fx_hudelement("(<-) Previous >");
  }
}

increment_list_offset() {
  if(level.effect_list_offset >= level.effect_list_current_size - level.effect_list_offset_max)
    level.effect_list_offset = 0;
  else
    level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}

decrement_list_offset() {
  if(level.effect_list_current_size < level.effect_list_offset_max)
    level.effect_list_offset = 0;
  else {
    level.effect_list_offset = level.effect_list_offset - level.effect_list_offset_max;

    if(level.effect_list_offset < 0)
      level.effect_list_offset = level.effect_list_current_size - level.effect_list_offset_max;
  }
}

draw_help_list(var_0) {
  common_scripts\_createfx::clear_fx_hudelements();
  var_1 = 0;
  var_2 = level.createfx_help_keys;

  if(!isdefined(var_0))
    var_0 = "Help";

  common_scripts\_createfx::set_fx_hudelement("[" + var_0 + "]");

  for (var_3 = level.help_list_offset; var_3 < var_2.size; var_3++) {
    var_1 = var_1 + 1;
    common_scripts\_createfx::set_fx_hudelement(var_2[var_3]);

    if(var_1 >= level.help_list_offset_max) {
      var_4 = 1;
      break;
    }
  }

  if(var_2.size > level.help_list_offset_max) {
    level.effect_list_current_size = var_2.size;
    common_scripts\_createfx::set_fx_hudelement("(->) More >");
    common_scripts\_createfx::set_fx_hudelement("(<-) Previous >");
  }
}

increment_help_list_offset() {
  var_0 = level.createfx_help_keys;

  if(level.help_list_offset >= var_0.size - level.help_list_offset_max)
    level.help_list_offset = 0;
  else
    level.help_list_offset = level.help_list_offset + level.help_list_offset_max;
}

decrement_help_list_offset() {
  level.help_list_offset = level.help_list_offset - level.help_list_offset_max;

  if(level.help_list_offset < 0) {
    var_0 = level.createfx_help_keys;
    level.help_list_offset = var_0.size - level.help_list_offset_max;
  }
}

help_navigation_buttons() {
  while (level.createfx_help_active == 1) {
    if(next_button()) {
      increment_help_list_offset();
      draw_help_list();
      wait 0.1;
    } else if(previous_button()) {
      decrement_help_list_offset();
      draw_help_list();
      wait 0.1;
    }

    waitframe();
  }
}

setup_help_keys() {
  level.createfx_help_keys = ["Insert Insert entity", "F2 Toggle createfx dot and text drawing", "F5 SAVES your work", "ZUndo", "Shift-ZRedo", "FFrames currently selected entities in camera view", "ENDDrop selected entities to the ground", "AAdd option to the selected entities", "PReset the rotation of the selected entities", "VCopy the angles from the most recently selected fx onto all selected fx.", "OOrient all selected fx to point at most recently selected fx.", "SToggle Snap2Normal mode.", "LToggle 90deg Snap mode.", "GSelect all effects in level of same exploder or flag as selected.", "USelect by name list.", "CConvert One-Shot to Exploder.", "Delete Kill the selected entities", "ESCAPE Cancel out of option-modify-mode, must have console open", "SPACE or ->Turn on exploders", "<- Turn off exploders", "Dpad Move selected entities on X\Y or rotate pitch\yaw", "A button Toggle the selection of the current entity", "X button Toggle entity rotation mode", "Y button Move selected entites up or rotate roll", "B button Move selected entites down or rotate roll", "R Shoulder Move selected entities to the cursor", "L Shoulder Hold to select multiple entites", "L JoyClick Copy", "R JoyClick Paste", "Ctrl-C Copy", "Ctrl-V Paste", "NUFO", "TToggle Timescale FAST", "YToggle Timescale SLOW", "[ Toggle FX Visibility", "]Toggle ShowTris", "F11Toggle FX Profile"];
}

select_by_name() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = common_scripts\_createfx::func_get_level_fx();

  for (var_3 = level.effect_list_offset; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10)
      var_4 = 0;

    if(common_scripts\_createfx::button_is_clicked(var_4 + "")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isdefined(var_1)) {
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