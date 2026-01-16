/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_createfxmenu.gsc
********************************************/

#include common_scripts\utility;
#include common_scripts\_createfx;

init_menu() {
  level._createfx.options = [];

  addOption("string", "fxid", "FX id", "nil", "fx");
  addOption("float", "delay", "Repeat rate/start delay", 0.5, "fx");
  addOption("string", "flag", "Flag", "nil", "exploder");

  if(!level.mp_createfx) {
    addOption("string", "firefx", "2nd FX id", "nil", "exploder");
    addOption("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
    addOption("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
    addOption("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
    addOption("float", "damage", "Radius damage", 150, "exploder");
    addOption("float", "damage_radius", "Radius of radius damage", 250, "exploder");
    addOption("string", "earthquake", "Earthquake", "nil", "exploder");
    addOption("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
  }

  addOption("float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval");
  addOption("float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval");
  addOption("int", "repeat", "Number of times to repeat", 5, "exploder");
  addOption("string", "exploder", "Exploder", "1", "exploder");

  addOption("string", "soundalias", "Soundalias", "nil", "all");
  addOption("string", "loopsound", "Loopsound", "nil", "exploder");

  addOption("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", ::input_reactive_radius);

  if(!level.mp_createfx) {
    addOption("string", "rumble", "Rumble", "nil", "exploder");
    addOption("int", "stoppable", "Can be stopped from script", "1", "all");
  }

  level.effect_list_offset = 0;
  level.effect_list_offset_max = 10;

  level.createfxMasks = [];
  level.createfxMasks["all"] = [];
  level.createfxMasks["all"]["exploder"] = true;
  level.createfxMasks["all"]["oneshotfx"] = true;
  level.createfxMasks["all"]["loopfx"] = true;
  level.createfxMasks["all"]["soundfx"] = true;
  level.createfxMasks["all"]["soundfx_interval"] = true;
  level.createfxMasks["all"]["reactive_fx"] = true;

  level.createfxMasks["fx"] = [];
  level.createfxMasks["fx"]["exploder"] = true;
  level.createfxMasks["fx"]["oneshotfx"] = true;
  level.createfxMasks["fx"]["loopfx"] = true;

  level.createfxMasks["exploder"] = [];
  level.createfxMasks["exploder"]["exploder"] = true;

  level.createfxMasks["loopfx"] = [];
  level.createfxMasks["loopfx"]["loopfx"] = true;

  level.createfxMasks["oneshotfx"] = [];
  level.createfxMasks["oneshotfx"]["oneshotfx"] = true;

  level.createfxMasks["soundfx"] = [];
  level.createfxMasks["soundfx"]["soundalias"] = true;

  level.createfxMasks["soundfx_interval"] = [];
  level.createfxMasks["soundfx_interval"]["soundfx_interval"] = true;

  level.createfxMasks["reactive_fx"] = [];
  level.createfxMasks["reactive_fx"]["reactive_fx"] = true;

  menus = [];
  menus["creation"] = ::menu_create_select;
  menus["create_oneshot"] = ::menu_create;
  menus["create_loopfx"] = ::menu_create;
  menus["change_fxid"] = ::menu_create;
  menus["none"] = ::menu_none;
  menus["add_options"] = ::menu_add_options;
  menus["select_by_name"] = ::menu_select_by_name;

  level._createfx.menus = menus;
}

menu(name) {
  return level.create_fx_menu == name;
}

setmenu(name) {
  level.create_fx_menu = name;
}

create_fx_menu() {
  if(button_is_clicked("escape", "x")) {
    _exit_menu();
    return;
  }

  if(isDefined(level._createfx.menus[level.create_fx_menu])) {
    [
      [level._createfx.menus[level.create_fx_menu]]
    ]();
  }
}

menu_create_select() {
  if(button_is_clicked("1")) {
    setmenu("create_oneshot");
    draw_effects_list();
    return;
  } else if(button_is_clicked("2")) {
    setmenu("create_loopsound");
    ent = createLoopSound();
    finish_creating_entity(ent);
    return;
  } else if(button_is_clicked("3")) {
    setmenu("create_exploder");
    ent = createNewExploder();
    finish_creating_entity(ent);
    return;
  } else if(button_is_clicked("4")) {
    setmenu("create_interval_sound");
    ent = createIntervalSound();
    finish_creating_entity(ent);
    return;
  } else if(button_is_clicked("5")) {
    ent = createReactiveEnt();
    finish_creating_entity(ent);
    return;
  }
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
  if(button_is_clicked("m"))
    increment_list_offset();

  menu_change_selected_fx();

  if(entities_are_selected()) {
    last_selected_ent = get_last_selected_ent();

    if(!isDefined(level.last_displayed_ent) || last_selected_ent != level.last_displayed_ent) {
      display_fx_info(last_selected_ent);
      level.last_displayed_ent = last_selected_ent;
    }

    if(button_is_clicked("a")) {
      clear_settable_fx();
      setMenu("add_options");
    }
  } else {
    level.last_displayed_ent = undefined;
  }
}

menu_add_options() {
  if(!entities_are_selected()) {
    clear_fx_hudElements();
    setMenu("none");
    return;
  }

  display_fx_add_options(get_last_selected_ent());
  if(next_button()) {
    increment_list_offset();

  }
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
  return button_is_clicked("rightarrow");
}

previous_button() {
  return button_is_clicked("leftarrow");
}

_exit_menu() {
  clear_fx_hudElements();
  clear_entity_selection();
  update_selected_entities();
  setmenu("none");
}

menu_fx_creation() {
  count = 0;
  picked_fx = undefined;
  keys = func_get_level_fx();

  for(i = level.effect_list_offset; i < keys.size; i++) {
    count = count + 1;
    button_to_check = count;
    if(button_to_check == 10)
      button_to_check = 0;
    if(button_is_clicked(button_to_check + "")) {
      picked_fx = keys[i];
      break;
    }

    if(count > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(picked_fx)) {
    return;
  }
  if(menu("change_fxid")) {
    apply_option_to_selected_fx(get_option("fxid"), picked_fx);
    level.effect_list_offset = 0;
    clear_fx_hudElements();
    setMenu("none");
    return;
  }

  ent = undefined;
  if(menu("create_loopfx"))
    ent = createLoopEffect(picked_fx);
  if(menu("create_oneshot"))
    ent = createOneshotEffect(picked_fx);

  finish_creating_entity(ent);
}

finish_creating_entity(ent) {
  assert(isDefined(ent));
  ent.v["angles"] = vectortoangles((ent.v["origin"] + (0, 0, 100)) - ent.v["origin"]);
  ent post_entity_creation_function();
  clear_entity_selection();
  select_last_entity();
  move_selection_to_cursor();
  update_selected_entities();
  setMenu("none");
}

entities_are_selected() {
  return level._createfx.selected_fx_ents.size > 0;
}

menu_change_selected_fx() {
  if(!level._createfx.selected_fx_ents.size) {
    return;
  }

  count = 0;
  drawnCount = 0;
  ent = get_last_selected_ent();

  for(i = 0; i < level._createfx.options.size; i++) {
    option = level._createfx.options[i];
    if(!isDefined(ent.v[option["name"]]))
      continue;
    count++;
    if(count < level.effect_list_offset) {
      continue;
    }
    drawnCount++;
    button_to_check = drawnCount;
    if(button_to_check == 10)
      button_to_check = 0;

    if(button_is_clicked(button_to_check + "")) {
      prepare_option_for_change(option, drawnCount);
      break;
    }

    if(drawnCount > level.effect_list_offset_max) {
      more = true;
      break;
    }
  }
}

prepare_option_for_change(option, drawnCount) {
  if(option["name"] == "fxid") {
    setMenu("change_fxid");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = true;
  level._createfx.hudelems[drawnCount + 3][0].color = (1, 1, 0);

  if(isDefined(option["input_func"])) {
    thread[[option["input_func"]]](drawnCount + 3);
  } else {
    createfx_centerprint("To change " + option["description"] + " on selected entities, type /fx newvalue");
  }

  set_option_index(option["name"]);
  setdvar("fx", "nil");
}

menu_fx_option_set() {
  if(getdvar("fx") == "nil") {
    return;
  }
  option = get_selected_option();
  setting = undefined;
  if(option["type"] == "string")
    setting = getdvar("fx");
  if(option["type"] == "int")
    setting = getdvarint("fx");
  if(option["type"] == "float")
    setting = getdvarfloat("fx");

  apply_option_to_selected_fx(option, setting);
}

apply_option_to_selected_fx(option, setting) {
  for(i = 0; i < level._createfx.selected_fx_ents.size; i++) {
    ent = level._createfx.selected_fx_ents[i];

    if(mask(option["mask"], ent.v["type"]))
      ent.v[option["name"]] = setting;
  }

  level.last_displayed_ent = undefined;
  update_selected_entities();
  clear_settable_fx();
}

set_option_index(name) {
  for(i = 0; i < level._createfx.options.size; i++) {
    if(level._createfx.options[i]["name"] != name) {
      continue;
    }
    level._createfx.selected_fx_option_index = i;
    return;
  }
}

get_selected_option() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

mask(type, name) {
  return isDefined(level.createfxMasks[type][name]);
}

addOption(type, name, description, defaultSetting, mask, input_func) {
  option = [];
  option["type"] = type;
  option["name"] = name;
  option["description"] = description;
  option["default"] = defaultSetting;
  option["mask"] = mask;

  if(isDefined(input_func)) {
    option["input_func"] = input_func;
  }

  level._createfx.options[level._createfx.options.size] = option;
}

get_option(name) {
  for(i = 0; i < level._createfx.options.size; i++) {
    if(level._createfx.options[i]["name"] == name)
      return level._createfx.options[i];
  }
}

input_reactive_radius(menu_index) {
  level._createfx.hudelems[menu_index][0] SetDevText("Reactive Radius, Press: + OR -");

  while(1) {
    wait(0.05);
    if(level.player ButtonPressed("escape") || level.player ButtonPressed("x")) {
      break;
    }

    val = 0;
    if(level.player ButtonPressed("-"))
      val = -10;
    else if(level.player ButtonPressed("="))
      val = 10;

    if(val != 0) {
      foreach(ent in level._createfx.selected_fx_ents) {
        if(isDefined(ent.v["reactive_radius"])) {
          ent.v["reactive_radius"] += val;
          ent.v["reactive_radius"] = Clamp(ent.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  update_selected_entities();
  clear_settable_fx();
}

display_fx_add_options(ent) {
  assert(menu("add_options"));
  assert(entities_are_selected());

  clear_fx_hudElements();
  set_fx_hudElement("Name: " + ent.v["fxid"]);
  set_fx_hudElement("Type: " + ent.v["type"]);
  set_fx_hudElement("Origin: " + ent.v["origin"]);
  set_fx_hudElement("Angles: " + ent.v["angles"]);

  count = 0;
  drawnCount = 0;
  more = false;

  if(level.effect_list_offset >= level._createfx.options.size)
    level.effect_list_offset = 0;

  for(i = 0; i < level._createfx.options.size; i++) {
    option = level._createfx.options[i];
    if(isDefined(ent.v[option["name"]])) {
      continue;
    }
    if(!mask(option["mask"], ent.v["type"])) {
      continue;
    }
    count++;
    if(count < level.effect_list_offset)
      continue;
    if(drawnCount >= level.effect_list_offset_max) {
      continue;
    }
    drawnCount++;
    button_to_check = drawnCount;
    if(button_to_check == 10)
      button_to_check = 0;
    if(button_is_clicked(button_to_check + "")) {
      add_option_to_selected_entities(option);

      menuNone();
      level.last_displayed_ent = undefined;
      return;
    }

    set_fx_hudElement(button_to_check + ". " + option["description"]);
  }

  if(count > level.effect_list_offset_max)
    set_fx_hudElement("(->) More >");

  set_fx_hudElement("(x) Exit >");
}

add_option_to_selected_entities(option) {
  setting = undefined;
  for(i = 0; i < level._createfx.selected_fx_ents.size; i++) {
    ent = level._createfx.selected_fx_ents[i];

    if(mask(option["mask"], ent.v["type"]))
      ent.v[option["name"]] = option["default"];
  }
}

menuNone() {
  level.effect_list_offset = 0;
  clear_fx_hudElements();
  setMenu("none");
}

display_fx_info(ent) {
  if(!menu("none")) {
    return;
  }
  clear_fx_hudElements();
  set_fx_hudElement("Name: " + ent.v["fxid"]);
  set_fx_hudElement("Type: " + ent.v["type"]);
  set_fx_hudElement("Origin: " + ent.v["origin"]);
  set_fx_hudElement("Angles: " + ent.v["angles"]);

  if(entities_are_selected()) {
    count = 0;
    drawnCount = 0;
    more = false;
    for(i = 0; i < level._createfx.options.size; i++) {
      option = level._createfx.options[i];
      if(!isDefined(ent.v[option["name"]]))
        continue;
      count++;
      if(count < level.effect_list_offset) {
        continue;
      }
      drawnCount++;
      set_fx_hudElement(drawnCount + ". " + option["description"] + ": " + ent.v[option["name"]]);
      if(drawnCount > level.effect_list_offset_max) {
        more = true;
        break;
      }
    }
    if(count > level.effect_list_offset_max)
      set_fx_hudElement("(->) More >");
    set_fx_hudElement("(a) Add >");
    set_fx_hudElement("(x) Exit >");
  } else {
    count = 0;
    more = false;
    for(i = 0; i < level._createfx.options.size; i++) {
      option = level._createfx.options[i];
      if(!isDefined(ent.v[option["name"]]))
        continue;
      count++;
      set_fx_hudElement(option["description"] + ": " + ent.v[option["name"]]);
      if(count > level._createfx.hudelem_count) {
        break;
      }
    }
  }
}

draw_effects_list(title) {
  clear_fx_hudElements();

  count = 0;
  more = false;

  keys = func_get_level_fx();

  if(!isDefined(title)) {
    title = "Pick an effect";
  }

  set_fx_hudElement(title + " [" + level.effect_list_offset + " - " + keys.size + "]:");

  for(i = level.effect_list_offset; i < keys.size; i++) {
    count = count + 1;
    set_fx_hudElement(count + ". " + keys[i]);
    if(count >= level.effect_list_offset_max) {
      more = true;
      break;
    }
  }

  if(keys.size > level.effect_list_offset_max) {
    set_fx_hudElement("(->) More >");
    set_fx_hudElement("(<-) Previous >");
  }
}

increment_list_offset() {
  keys = func_get_level_fx();

  if(level.effect_list_offset >= keys.size - level.effect_list_offset_max) {
    level.effect_list_offset = 0;
  } else {
    level.effect_list_offset += level.effect_list_offset_max;
  }
}

decrement_list_offset() {
  level.effect_list_offset -= level.effect_list_offset_max;

  if(level.effect_list_offset < 0) {
    keys = func_get_level_fx();
    level.effect_list_offset = keys.size - level.effect_list_offset_max;
  }
}

select_by_name() {
  count = 0;
  picked_fx = undefined;
  keys = func_get_level_fx();

  for(i = level.effect_list_offset; i < keys.size; i++) {
    count = count + 1;
    button_to_check = count;
    if(button_to_check == 10)
      button_to_check = 0;
    if(button_is_clicked(button_to_check + "")) {
      picked_fx = keys[i];
      break;
    }

    if(count > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(picked_fx)) {
    return;
  }
  index_array = [];
  foreach(i, ent in level.createFXent) {
    if(IsSubStr(ent.v["fxid"], picked_fx)) {
      index_array[index_array.size] = i;
    }
  }

  deselect_all_ents();
  select_index_array(index_array);

  level._createfx.select_by_name = true;
}

get_last_selected_ent() {
  return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}