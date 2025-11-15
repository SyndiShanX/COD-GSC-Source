/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2611.gsc
***************************************/

init_menu() {
  level._createfx.options = [];
  addoption("string", "fxid", "FX id", "nil", "fx");
  addoption("float", "delay", "Repeat rate\start delay", 0.5, "fx");
  addoption("string", "flag", "Flag", "nil", "exploder");

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
  addoption("string", "soundalias", "Soundalias", "nil", "all");
  addoption("string", "loopsound", "Loopsound", "nil", "exploder");
  addoption("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", ::input_reactive_radius);

  if(!level.mp_createfx) {
    addoption("string", "rumble", "Rumble", "nil", "exploder");
    addoption("int", "stopable", "Can be stopped from script", "1", "all");
  }

  level.effect_list_offset = 0;
  level.effect_list_offset_max = 10;

  if(level.mp_createfx)
    level.effect_list_offset_max = 6;

  level.createfxmasks = [];
  level.createfxmasks["all"] = [];
  level.createfxmasks["all"]["exploder"] = 1;
  level.createfxmasks["all"]["oneshotfx"] = 1;
  level.createfxmasks["all"]["loopfx"] = 1;
  level.createfxmasks["all"]["soundfx"] = 1;
  level.createfxmasks["all"]["soundfx_interval"] = 1;
  level.createfxmasks["all"]["reactive_fx"] = 1;
  level.createfxmasks["fx"] = [];
  level.createfxmasks["fx"]["exploder"] = 1;
  level.createfxmasks["fx"]["oneshotfx"] = 1;
  level.createfxmasks["fx"]["loopfx"] = 1;

  if(!level.mp_createfx)
    level.createfxmasks["fx"]["reactive_fx"] = 1;

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
  var_00 = [];
  var_0["creation"] = ::menu_create_select;
  var_0["create_oneshot"] = ::menu_create;
  var_0["create_loopfx"] = ::menu_create;
  var_0["change_fxid"] = ::menu_create;
  var_0["none"] = ::menu_none;
  var_0["add_options"] = ::menu_add_options;
  var_0["select_by_name"] = ::menu_select_by_name;
  level._createfx.menus = var_00;
}

menu(var_00) {
  return level.create_fx_menu == var_00;
}

setmenu(var_00) {
  level.create_fx_menu = var_00;
}

create_fx_menu() {
  if(scripts\common\createfx::button_is_clicked("escape", "x")) {
    exit_menu();
    return;
  }

  if(isDefined(level._createfx.menus[level.create_fx_menu]))
    [[level._createfx.menus[level.create_fx_menu]]]();
}

menu_create_select() {
  if(!isDefined(level._createfx.menu_create_select)) {
    level._createfx.menu_create_select = [];
    var_00 = [];
    var_0["1"] = ::buttonpress_create_oneshot;

    if(!level.mp_createfx) {
      var_0["2"] = ::buttonpress_create_loopfx;
      var_0["3"] = ::buttonpress_create_loopsound;
      var_0["4"] = ::buttonpress_create_exploder;
      var_0["5"] = ::buttonpress_create_interval_sound;
      var_0["6"] = ::buttonpress_create_reactiveent;
    } else {
      var_0["2"] = ::buttonpress_create_loopsound;
      var_0["3"] = ::buttonpress_create_exploder;
      var_0["4"] = ::buttonpress_create_interval_sound;
      var_0["5"] = ::buttonpress_create_reactiveent;
    }

    level._createfx.menu_create_select = var_00;
  }

  foreach(var_03, var_02 in level._createfx.menu_create_select) {
    if(scripts\common\createfx::button_is_clicked(var_03)) {
      [
        [var_02]
      ]();
      return;
    }
  }
}

buttonpress_create_oneshot() {
  setmenu("create_oneshot");
  draw_effects_list();
}

buttonpress_create_loopfx() {
  setmenu("create_loopfx");
  draw_effects_list();
}

buttonpress_create_loopsound() {
  setmenu("create_loopsound");
  var_00 = scripts\common\createfx::createloopsound();
  finish_creating_entity(var_00);
}

buttonpress_create_exploder() {
  setmenu("create_exploder");
  var_00 = scripts\common\createfx::createnewexploder();
  finish_creating_entity(var_00);
}

buttonpress_create_interval_sound() {
  setmenu("create_interval_sound");
  var_00 = scripts\common\createfx::createintervalsound();
  finish_creating_entity(var_00);
}

buttonpress_create_reactiveent() {
  var_00 = scripts\common\createfx::createreactiveent();
  finish_creating_entity(var_00);
}

menu_create() {
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
  if(scripts\common\createfx::button_is_clicked("m"))
    increment_list_offset();

  menu_change_selected_fx();

  if(entities_are_selected()) {
    var_00 = get_last_selected_ent();

    if(!isDefined(level.last_displayed_ent) || var_00 != level.last_displayed_ent) {
      display_fx_info(var_00);
      level.last_displayed_ent = var_00;
    }

    if(scripts\common\createfx::button_is_clicked("a")) {
      scripts\common\createfx::clear_settable_fx();
      setmenu("add_options");
      return;
    }
  } else
    level.last_displayed_ent = undefined;
}

menu_add_options() {
  if(!entities_are_selected()) {
    scripts\common\createfx::clear_fx_hudelements();
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
  return scripts\common\createfx::button_is_clicked("rightarrow");
}

previous_button() {
  return scripts\common\createfx::button_is_clicked("leftarrow");
}

exit_menu() {
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::clear_entity_selection();
  scripts\common\createfx::update_selected_entities();
  setmenu("none");
}

menu_fx_creation() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = scripts\common\createfx::func_get_level_fx();

  for(var_03 = level.effect_list_offset; var_03 < var_2.size; var_3++) {
    var_00 = var_00 + 1;
    var_04 = var_00;

    if(var_04 == 10)
      var_04 = 0;

    if(scripts\common\createfx::button_is_clicked(var_04 + "")) {
      var_01 = var_2[var_03];
      break;
    }

    if(var_00 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }
  if(menu("change_fxid")) {
    apply_option_to_selected_fx(get_option("fxid"), var_01);
    level.effect_list_offset = 0;
    scripts\common\createfx::clear_fx_hudelements();
    setmenu("none");
    return;
  }

  var_05 = undefined;

  if(menu("create_loopfx"))
    var_05 = scripts\engine\utility::createloopeffect(var_01);

  if(menu("create_oneshot"))
    var_05 = scripts\engine\utility::createoneshoteffect(var_01);

  finish_creating_entity(var_05);
}

finish_creating_entity(var_00) {
  var_0.v["angles"] = vectortoangles(var_0.v["origin"] + (0, 0, 100) - var_0.v["origin"]);

  if(isDefined(level._effect) && isDefined(level._effect[var_0.v["fxid"]]) && isvfxfile(level._effect[var_0.v["fxid"]]))
    var_0.v["angles"] = (0, 0, 0);

  var_00 scripts\common\createfx::post_entity_creation_function();
  scripts\common\createfx::clear_entity_selection();
  scripts\common\createfx::select_last_entity();
  scripts\common\createfx::move_selection_to_cursor();
  scripts\common\createfx::update_selected_entities();
  setmenu("none");
}

entities_are_selected() {
  return level._createfx.selected_fx_ents.size > 0;
}

menu_change_selected_fx() {
  if(!level._createfx.selected_fx_ents.size) {
    return;
  }
  var_00 = 0;
  var_01 = 0;
  var_02 = get_last_selected_ent();

  for(var_03 = 0; var_03 < level._createfx.options.size; var_3++) {
    var_04 = level._createfx.options[var_03];

    if(!isDefined(var_2.v[var_4["name"]])) {
      continue;
    }
    var_0++;

    if(var_00 < level.effect_list_offset) {
      continue;
    }
    var_1++;
    var_05 = var_01;

    if(var_05 == 10)
      var_05 = 0;

    if(scripts\common\createfx::button_is_clicked(var_05 + "")) {
      prepare_option_for_change(var_04, var_01);
      break;
    }

    if(var_01 > level.effect_list_offset_max) {
      var_06 = 1;
      break;
    }
  }
}

prepare_option_for_change(var_00, var_01) {
  if(var_0["name"] == "fxid") {
    setmenu("change_fxid");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = 1;
  level._createfx.hudelems[var_01 + 3][0].color = (1, 1, 0);

  if(isDefined(var_0["input_func"]))
    thread[[var_0["input_func"]]](var_01 + 3);
  else
    scripts\common\createfx::createfx_centerprint("To change " + var_0["description"] + " on selected entities, type \fx newvalue");

  set_option_index(var_0["name"]);
  setdvar("fx", "nil");
}

menu_fx_option_set() {
  if(getdvar("fx") == "nil") {
    return;
  }
  var_00 = get_selected_option();
  var_01 = undefined;

  if(var_0["type"] == "string")
    var_01 = getdvar("fx");

  if(var_0["type"] == "int")
    var_01 = getdvarint("fx");

  if(var_0["type"] == "float")
    var_01 = getdvarfloat("fx");

  apply_option_to_selected_fx(var_00, var_01);
}

apply_option_to_selected_fx(var_00, var_01) {
  for(var_02 = 0; var_02 < level._createfx.selected_fx_ents.size; var_2++) {
    var_03 = level._createfx.selected_fx_ents[var_02];

    if(mask(var_0["mask"], var_3.v["type"]))
      var_3.v[var_0["name"]] = var_01;
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

set_option_index(var_00) {
  for(var_01 = 0; var_01 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_01]["name"] != var_00) {
      continue;
    }
    level._createfx.selected_fx_option_index = var_01;
    return;
  }
}

get_selected_option() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

mask(var_00, var_01) {
  return isDefined(level.createfxmasks[var_00][var_01]);
}

addoption(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = [];
  var_6["type"] = var_00;
  var_6["name"] = var_01;
  var_6["description"] = var_02;
  var_6["default"] = var_03;
  var_6["mask"] = var_04;

  if(isDefined(var_05))
    var_6["input_func"] = var_05;

  level._createfx.options[level._createfx.options.size] = var_06;
}

get_option(var_00) {
  for(var_01 = 0; var_01 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_01]["name"] == var_00)
      return level._createfx.options[var_01];
  }
}

input_reactive_radius(var_00) {
  for(;;) {
    wait 0.05;

    if(level.player buttonpressed("escape") || level.player buttonpressed("x")) {
      break;
    }
    var_01 = 0;

    if(level.player buttonpressed("-"))
      var_01 = -10;
    else if(level.player buttonpressed("="))
      var_01 = 10;

    if(var_01 != 0) {
      foreach(var_03 in level._createfx.selected_fx_ents) {
        if(isDefined(var_3.v["reactive_radius"])) {
          var_3.v["reactive_radius"] = var_3.v["reactive_radius"] + var_01;
          var_3.v["reactive_radius"] = clamp(var_3.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

display_fx_add_options(var_00) {
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("Name: " + var_0.v["fxid"]);
  scripts\common\createfx::set_fx_hudelement("Type: " + var_0.v["type"]);
  scripts\common\createfx::set_fx_hudelement("Origin: " + var_0.v["origin"]);
  scripts\common\createfx::set_fx_hudelement("Angles: " + var_0.v["angles"]);
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;

  if(level.effect_list_offset >= level._createfx.options.size)
    level.effect_list_offset = 0;

  for(var_04 = 0; var_04 < level._createfx.options.size; var_4++) {
    var_05 = level._createfx.options[var_04];

    if(isDefined(var_0.v[var_5["name"]])) {
      continue;
    }
    if(!mask(var_5["mask"], var_0.v["type"])) {
      continue;
    }
    var_1++;

    if(var_01 < level.effect_list_offset) {
      continue;
    }
    if(var_02 >= level.effect_list_offset_max) {
      continue;
    }
    var_2++;
    var_06 = var_02;

    if(var_06 == 10)
      var_06 = 0;

    if(scripts\common\createfx::button_is_clicked(var_06 + "")) {
      add_option_to_selected_entities(var_05);
      menunone();
      level.last_displayed_ent = undefined;
      return;
    }

    scripts\common\createfx::set_fx_hudelement(var_06 + ". " + var_5["description"]);
  }

  if(var_01 > level.effect_list_offset_max)
    scripts\common\createfx::set_fx_hudelement("(->) More >");

  scripts\common\createfx::set_fx_hudelement("(x) Exit >");
}

add_option_to_selected_entities(var_00) {
  var_01 = undefined;

  for(var_02 = 0; var_02 < level._createfx.selected_fx_ents.size; var_2++) {
    var_03 = level._createfx.selected_fx_ents[var_02];

    if(mask(var_0["mask"], var_3.v["type"]))
      var_3.v[var_0["name"]] = var_0["default"];
  }
}

menunone() {
  level.effect_list_offset = 0;
  scripts\common\createfx::clear_fx_hudelements();
  setmenu("none");
}

display_fx_info(var_00) {
  if(!menu("none")) {
    return;
  }
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("Name: " + var_0.v["fxid"]);
  scripts\common\createfx::set_fx_hudelement("Type: " + var_0.v["type"]);
  scripts\common\createfx::set_fx_hudelement("Origin: " + var_0.v["origin"]);
  scripts\common\createfx::set_fx_hudelement("Angles: " + var_0.v["angles"]);

  if(entities_are_selected()) {
    var_01 = 0;
    var_02 = 0;
    var_03 = 0;

    for(var_04 = 0; var_04 < level._createfx.options.size; var_4++) {
      var_05 = level._createfx.options[var_04];

      if(!isDefined(var_0.v[var_5["name"]])) {
        continue;
      }
      var_1++;

      if(var_01 < level.effect_list_offset) {
        continue;
      }
      var_2++;
      scripts\common\createfx::set_fx_hudelement(var_02 + ". " + var_5["description"] + ": " + var_0.v[var_5["name"]]);

      if(var_02 > level.effect_list_offset_max) {
        var_03 = 1;
        break;
      }
    }

    if(var_01 > level.effect_list_offset_max)
      scripts\common\createfx::set_fx_hudelement("(->) More >");

    scripts\common\createfx::set_fx_hudelement("(a) Add >");
    scripts\common\createfx::set_fx_hudelement("(x) Exit >");
  } else {
    var_01 = 0;
    var_03 = 0;

    for(var_04 = 0; var_04 < level._createfx.options.size; var_4++) {
      var_05 = level._createfx.options[var_04];

      if(!isDefined(var_0.v[var_5["name"]])) {
        continue;
      }
      var_1++;
      scripts\common\createfx::set_fx_hudelement(var_5["description"] + ": " + var_0.v[var_5["name"]]);

      if(var_01 > level._createfx.hudelem_count) {
        break;
      }
    }
  }
}

draw_effects_list(var_00) {
  scripts\common\createfx::clear_fx_hudelements();
  var_01 = 0;
  var_02 = 0;
  var_03 = scripts\common\createfx::func_get_level_fx();

  if(!isDefined(var_00))
    var_00 = "Pick an effect";

  scripts\common\createfx::set_fx_hudelement(var_00 + " [" + level.effect_list_offset + " - " + var_3.size + "]:");

  for(var_04 = level.effect_list_offset; var_04 < var_3.size; var_4++) {
    var_01 = var_01 + 1;
    scripts\common\createfx::set_fx_hudelement(var_01 + ". " + var_3[var_04]);

    if(var_01 >= level.effect_list_offset_max) {
      var_02 = 1;
      break;
    }
  }

  if(var_3.size > level.effect_list_offset_max) {
    scripts\common\createfx::set_fx_hudelement("(->) More >");
    scripts\common\createfx::set_fx_hudelement("(<-) Previous >");
  }
}

increment_list_offset() {
  var_00 = scripts\common\createfx::func_get_level_fx();

  if(level.effect_list_offset >= var_0.size - level.effect_list_offset_max)
    level.effect_list_offset = 0;
  else
    level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}

decrement_list_offset() {
  level.effect_list_offset = level.effect_list_offset - level.effect_list_offset_max;

  if(level.effect_list_offset < 0) {
    var_00 = scripts\common\createfx::func_get_level_fx();
    level.effect_list_offset = var_0.size - level.effect_list_offset_max;
  }
}

select_by_name() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = scripts\common\createfx::func_get_level_fx();

  for(var_03 = level.effect_list_offset; var_03 < var_2.size; var_3++) {
    var_00 = var_00 + 1;
    var_04 = var_00;

    if(var_04 == 10)
      var_04 = 0;

    if(scripts\common\createfx::button_is_clicked(var_04 + "")) {
      var_01 = var_2[var_03];
      break;
    }

    if(var_00 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }
  var_05 = [];

  foreach(var_03, var_07 in level.createfxent) {
    if(issubstr(var_7.v["fxid"], var_01))
      var_5[var_5.size] = var_03;
  }

  scripts\common\createfx::deselect_all_ents();
  scripts\common\createfx::select_index_array(var_05);
  level._createfx.select_by_name = 1;
}

get_last_selected_ent() {
  return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}