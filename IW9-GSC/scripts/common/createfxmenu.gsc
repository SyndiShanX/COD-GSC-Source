/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\createfxmenu.gsc
***********************************************/

init_menu() {
  level._createfx.options = [];
  addoption("string", "fxid", "FX id", "nil", "fx");
  addoption("float", "delay", "Repeat rate/start delay", 0.5, "fx");
  addoption("string", "flag", "Flag", "nil", "exploder");

  if(!level.mp_createfx) {
    addoption("string", "firefx", "2nd FX id", "nil", "exploder");
    addoption("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
    addoption("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
    addoption("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
    addoption("float", "damage", "Radius damage", 150, "exploder");
    addoption("float", "damage_radius", "Radius of radius damage", 250, "exploder");
    addoption("bool", "envonly", "Environment Pulse Only", 0, "exploder");
    addoption("bool", "dotraces", "Occlusion Trace", 1, "exploder");
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
    _id_FADB44F96AB8EC53 = [];
    _id_FADB44F96AB8EC53["1"] = ::buttonpress_create_oneshot;

    if(!level.mp_createfx) {
      _id_FADB44F96AB8EC53["2"] = ::buttonpress_create_loopfx;
      _id_FADB44F96AB8EC53["3"] = ::buttonpress_create_loopsound;
      _id_FADB44F96AB8EC53["4"] = ::buttonpress_create_exploder;
      _id_FADB44F96AB8EC53["5"] = ::buttonpress_create_interval_sound;
      _id_FADB44F96AB8EC53["6"] = ::buttonpress_create_reactiveent;
    } else {
      _id_FADB44F96AB8EC53["2"] = ::buttonpress_create_loopsound;
      _id_FADB44F96AB8EC53["3"] = ::buttonpress_create_exploder;
      _id_FADB44F96AB8EC53["4"] = ::buttonpress_create_interval_sound;
      _id_FADB44F96AB8EC53["5"] = ::buttonpress_create_reactiveent;
    }

    level._createfx.menu_create_select = _id_FADB44F96AB8EC53;
  }

  foreach(index, func in level._createfx.menu_create_select) {
    if(scripts\common\createfx::button_is_clicked(index)) {
      [[func]]();
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
  ent = scripts\common\createfx::createloopsound();
  finish_creating_entity(ent);
}

buttonpress_create_exploder() {
  setmenu("create_exploder");
  ent = scripts\common\createfx::createnewexploder();
  finish_creating_entity(ent);
}

buttonpress_create_interval_sound() {
  setmenu("create_interval_sound");
  ent = scripts\common\createfx::createintervalsound();
  finish_creating_entity(ent);
}

buttonpress_create_reactiveent() {
  ent = scripts\common\createfx::createreactiveent();
  finish_creating_entity(ent);
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
    _id_F7220250D576EF8D = get_last_selected_ent();

    if(!isDefined(level.last_displayed_ent) || _id_F7220250D576EF8D != level.last_displayed_ent) {
      display_fx_info(_id_F7220250D576EF8D);
      level.last_displayed_ent = _id_F7220250D576EF8D;
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
  count = 0;
  _id_AD1CD7182F378920 = undefined;
  keys = scripts\common\createfx::func_get_level_fx();

  for(_id_AC0E594AC96AA3A8 = level.effect_list_offset; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    count = count + 1;
    _id_7356AB609CFAD76C = count;

    if(_id_7356AB609CFAD76C == 10)
      _id_7356AB609CFAD76C = 0;

    if(scripts\common\createfx::button_is_clicked(_id_7356AB609CFAD76C + "")) {
      _id_AD1CD7182F378920 = keys[_id_AC0E594AC96AA3A8];
      break;
    }

    if(count > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(_id_AD1CD7182F378920)) {
    return;
  }
  if(menu("change_fxid")) {
    apply_option_to_selected_fx(get_option("fxid"), _id_AD1CD7182F378920);
    level.effect_list_offset = 0;
    scripts\common\createfx::clear_fx_hudelements();
    setmenu("none");
    return;
  }

  ent = undefined;

  if(menu("create_loopfx"))
    ent = scripts\engine\utility::createloopeffect(_id_AD1CD7182F378920);

  if(menu("create_oneshot"))
    ent = scripts\engine\utility::createoneshoteffect(_id_AD1CD7182F378920);

  finish_creating_entity(ent);
}

finish_creating_entity(ent) {
  ent.v["angles"] = vectortoangles(ent.v["origin"] + (0, 0, 100) - ent.v["origin"]);

  if(isDefined(level._effect) && isDefined(level._effect[ent.v["fxid"]]) && isvfxfile(level._effect[ent.v["fxid"]]))
    ent.v["angles"] = (0, 0, 0);

  ent scripts\common\createfx::post_entity_creation_function();
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
  count = 0;
  _id_746AA6E7FD75DF62 = 0;
  ent = get_last_selected_ent();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.options.size; _id_AC0E594AC96AA3A8++) {
    _id_414EEC2F131C45C0 = level._createfx.options[_id_AC0E594AC96AA3A8];

    if(!isDefined(ent.v[_id_414EEC2F131C45C0["name"]])) {
      continue;
    }
    count++;

    if(count < level.effect_list_offset) {
      continue;
    }
    _id_746AA6E7FD75DF62++;
    _id_7356AB609CFAD76C = _id_746AA6E7FD75DF62;

    if(_id_7356AB609CFAD76C == 10)
      _id_7356AB609CFAD76C = 0;

    if(scripts\common\createfx::button_is_clicked(_id_7356AB609CFAD76C + "")) {
      prepare_option_for_change(_id_414EEC2F131C45C0, _id_746AA6E7FD75DF62);
      break;
    }

    if(_id_746AA6E7FD75DF62 > level.effect_list_offset_max) {
      _id_1E80B20ECBF1FC44 = 1;
      break;
    }
  }
}

prepare_option_for_change(_id_414EEC2F131C45C0, _id_746AA6E7FD75DF62) {
  if(_id_414EEC2F131C45C0["name"] == "fxid") {
    setmenu("change_fxid");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = 1;
  level._createfx.hudelems[_id_746AA6E7FD75DF62 + 3][0].color = (1, 1, 0);

  if(isDefined(_id_414EEC2F131C45C0["input_func"]))
    thread[[_id_414EEC2F131C45C0["input_func"]]](_id_746AA6E7FD75DF62 + 3);
  else
    scripts\common\createfx::createfx_centerprint("To change " + _id_414EEC2F131C45C0["description"] + " on selected entities, type /fx newvalue");

  set_option_index(_id_414EEC2F131C45C0["name"]);
  setDvar("fx", "nil");
}

menu_fx_option_set() {
  if(getDvar("fx") == "nil") {
    return;
  }
  _id_414EEC2F131C45C0 = get_selected_option();
  _id_8C958BDE9A9F8547 = undefined;

  if(_id_414EEC2F131C45C0["type"] == "string")
    _id_8C958BDE9A9F8547 = getDvar("fx");

  if(_id_414EEC2F131C45C0["type"] == "int")
    _id_8C958BDE9A9F8547 = getdvarint("fx");

  if(_id_414EEC2F131C45C0["type"] == "float")
    _id_8C958BDE9A9F8547 = getdvarfloat("fx");

  if(_id_414EEC2F131C45C0["type"] == "bool") {
    _id_8C958BDE9A9F8547 = getDvar("fx");

    if(_id_8C958BDE9A9F8547 == "0" || _id_8C958BDE9A9F8547 == "false")
      _id_8C958BDE9A9F8547 = 0;
    else
      _id_8C958BDE9A9F8547 = 1;
  }

  apply_option_to_selected_fx(_id_414EEC2F131C45C0, _id_8C958BDE9A9F8547);
}

apply_option_to_selected_fx(_id_414EEC2F131C45C0, _id_8C958BDE9A9F8547) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];

    if(mask(_id_414EEC2F131C45C0["mask"], ent.v["type"]))
      ent.v[_id_414EEC2F131C45C0["name"]] = _id_8C958BDE9A9F8547;
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

set_option_index(name) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.options.size; _id_AC0E594AC96AA3A8++) {
    if(level._createfx.options[_id_AC0E594AC96AA3A8]["name"] != name) {
      continue;
    }
    level._createfx.selected_fx_option_index = _id_AC0E594AC96AA3A8;
    return;
  }
}

get_selected_option() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

mask(type, name) {
  return isDefined(level.createfxmasks[type][name]);
}

addoption(type, name, description, _id_4E94C5615C36AB4E, mask, _id_6E9C9009B1774F6E) {
  _id_414EEC2F131C45C0 = [];
  _id_414EEC2F131C45C0["type"] = type;
  _id_414EEC2F131C45C0["name"] = name;
  _id_414EEC2F131C45C0["description"] = description;
  _id_414EEC2F131C45C0["default"] = _id_4E94C5615C36AB4E;
  _id_414EEC2F131C45C0["mask"] = mask;

  if(isDefined(_id_6E9C9009B1774F6E))
    _id_414EEC2F131C45C0["input_func"] = _id_6E9C9009B1774F6E;

  level._createfx.options[level._createfx.options.size] = _id_414EEC2F131C45C0;
}

get_option(name) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.options.size; _id_AC0E594AC96AA3A8++) {
    if(level._createfx.options[_id_AC0E594AC96AA3A8]["name"] == name)
      return level._createfx.options[_id_AC0E594AC96AA3A8];
  }
}

input_reactive_radius(_id_9F2DAC78DD535831) {
  for(;;) {
    waitframe();

    if(level.player buttonPressed("escape") || level.player buttonPressed("x")) {
      break;
    }

    val = 0;

    if(level.player buttonPressed("-"))
      val = -10;
    else if(level.player buttonPressed("="))
      val = 10;

    if(val != 0) {
      foreach(ent in level._createfx.selected_fx_ents) {
        if(isDefined(ent.v["reactive_radius"])) {
          ent.v["reactive_radius"] = ent.v["reactive_radius"] + val;
          ent.v["reactive_radius"] = clamp(ent.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

display_fx_add_options(ent) {
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("Name: " + ent.v["fxid"]);
  scripts\common\createfx::set_fx_hudelement("Type: " + ent.v["type"]);
  scripts\common\createfx::set_fx_hudelement("Origin: " + ent.v["origin"]);
  scripts\common\createfx::set_fx_hudelement("Angles: " + ent.v["angles"]);
  count = 0;
  _id_746AA6E7FD75DF62 = 0;
  _id_1E80B20ECBF1FC44 = 0;

  if(level.effect_list_offset >= level._createfx.options.size)
    level.effect_list_offset = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.options.size; _id_AC0E594AC96AA3A8++) {
    _id_414EEC2F131C45C0 = level._createfx.options[_id_AC0E594AC96AA3A8];

    if(isDefined(ent.v[_id_414EEC2F131C45C0["name"]])) {
      continue;
    }
    if(!mask(_id_414EEC2F131C45C0["mask"], ent.v["type"])) {
      continue;
    }
    count++;

    if(count < level.effect_list_offset) {
      continue;
    }
    if(_id_746AA6E7FD75DF62 >= level.effect_list_offset_max) {
      continue;
    }
    _id_746AA6E7FD75DF62++;
    _id_7356AB609CFAD76C = _id_746AA6E7FD75DF62;

    if(_id_7356AB609CFAD76C == 10)
      _id_7356AB609CFAD76C = 0;

    if(scripts\common\createfx::button_is_clicked(_id_7356AB609CFAD76C + "")) {
      add_option_to_selected_entities(_id_414EEC2F131C45C0);
      menunone();
      level.last_displayed_ent = undefined;
      return;
    }

    scripts\common\createfx::set_fx_hudelement(_id_7356AB609CFAD76C + ". " + _id_414EEC2F131C45C0["description"]);
  }

  if(count > level.effect_list_offset_max)
    scripts\common\createfx::set_fx_hudelement("(->) More >");

  scripts\common\createfx::set_fx_hudelement("(x) Exit >");
}

add_option_to_selected_entities(_id_414EEC2F131C45C0) {
  _id_8C958BDE9A9F8547 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.selected_fx_ents.size; _id_AC0E594AC96AA3A8++) {
    ent = level._createfx.selected_fx_ents[_id_AC0E594AC96AA3A8];

    if(mask(_id_414EEC2F131C45C0["mask"], ent.v["type"]))
      ent.v[_id_414EEC2F131C45C0["name"]] = _id_414EEC2F131C45C0["default"];
  }
}

menunone() {
  level.effect_list_offset = 0;
  scripts\common\createfx::clear_fx_hudelements();
  setmenu("none");
}

display_fx_info(ent) {
  if(!menu("none")) {
    return;
  }
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("Name: " + ent.v["fxid"]);
  scripts\common\createfx::set_fx_hudelement("Type: " + ent.v["type"]);
  scripts\common\createfx::set_fx_hudelement("Origin: " + ent.v["origin"]);
  scripts\common\createfx::set_fx_hudelement("Angles: " + ent.v["angles"]);

  if(entities_are_selected()) {
    count = 0;
    _id_746AA6E7FD75DF62 = 0;
    _id_1E80B20ECBF1FC44 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.options.size; _id_AC0E594AC96AA3A8++) {
      _id_414EEC2F131C45C0 = level._createfx.options[_id_AC0E594AC96AA3A8];

      if(!isDefined(ent.v[_id_414EEC2F131C45C0["name"]])) {
        continue;
      }
      count++;

      if(count < level.effect_list_offset) {
        continue;
      }
      _id_746AA6E7FD75DF62++;
      scripts\common\createfx::set_fx_hudelement(_id_746AA6E7FD75DF62 + ". " + _id_414EEC2F131C45C0["description"] + ": " + ent.v[_id_414EEC2F131C45C0["name"]]);

      if(_id_746AA6E7FD75DF62 > level.effect_list_offset_max) {
        _id_1E80B20ECBF1FC44 = 1;
        break;
      }
    }

    if(count > level.effect_list_offset_max)
      scripts\common\createfx::set_fx_hudelement("(->) More >");

    scripts\common\createfx::set_fx_hudelement("(a) Add >");
    scripts\common\createfx::set_fx_hudelement("(x) Exit >");
  } else {
    count = 0;
    _id_1E80B20ECBF1FC44 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._createfx.options.size; _id_AC0E594AC96AA3A8++) {
      _id_414EEC2F131C45C0 = level._createfx.options[_id_AC0E594AC96AA3A8];

      if(!isDefined(ent.v[_id_414EEC2F131C45C0["name"]])) {
        continue;
      }
      count++;
      scripts\common\createfx::set_fx_hudelement(_id_414EEC2F131C45C0["description"] + ": " + ent.v[_id_414EEC2F131C45C0["name"]]);

      if(count > level._createfx.hudelem_count) {
        break;
      }
    }
  }
}

draw_effects_list(title) {
  scripts\common\createfx::clear_fx_hudelements();
  count = 0;
  _id_1E80B20ECBF1FC44 = 0;
  keys = scripts\common\createfx::func_get_level_fx();

  if(!isDefined(title))
    title = "Pick an effect";

  scripts\common\createfx::set_fx_hudelement(title + " [" + level.effect_list_offset + " - " + keys.size + "]:");

  for(_id_AC0E594AC96AA3A8 = level.effect_list_offset; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    count = count + 1;
    scripts\common\createfx::set_fx_hudelement(count + ". " + keys[_id_AC0E594AC96AA3A8]);

    if(count >= level.effect_list_offset_max) {
      _id_1E80B20ECBF1FC44 = 1;
      break;
    }
  }

  if(keys.size > level.effect_list_offset_max) {
    scripts\common\createfx::set_fx_hudelement("(->) More >");
    scripts\common\createfx::set_fx_hudelement("(<-) Previous >");
  }
}

increment_list_offset() {
  keys = scripts\common\createfx::func_get_level_fx();

  if(level.effect_list_offset >= keys.size - level.effect_list_offset_max)
    level.effect_list_offset = 0;
  else
    level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}

decrement_list_offset() {
  level.effect_list_offset = level.effect_list_offset - level.effect_list_offset_max;

  if(level.effect_list_offset < 0) {
    keys = scripts\common\createfx::func_get_level_fx();
    level.effect_list_offset = keys.size - level.effect_list_offset_max;
  }
}

select_by_name() {
  count = 0;
  _id_AD1CD7182F378920 = undefined;
  keys = scripts\common\createfx::func_get_level_fx();

  for(_id_AC0E594AC96AA3A8 = level.effect_list_offset; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    count = count + 1;
    _id_7356AB609CFAD76C = count;

    if(_id_7356AB609CFAD76C == 10)
      _id_7356AB609CFAD76C = 0;

    if(scripts\common\createfx::button_is_clicked(_id_7356AB609CFAD76C + "")) {
      _id_AD1CD7182F378920 = keys[_id_AC0E594AC96AA3A8];
      break;
    }

    if(count > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(_id_AD1CD7182F378920)) {
    return;
  }
  _id_9EAB1F284573CC85 = [];

  foreach(_id_AC0E594AC96AA3A8, ent in level.createfxent) {
    if(issubstr(ent.v["fxid"], _id_AD1CD7182F378920))
      _id_9EAB1F284573CC85[_id_9EAB1F284573CC85.size] = _id_AC0E594AC96AA3A8;
  }

  scripts\common\createfx::deselect_all_ents();
  scripts\common\createfx::select_index_array(_id_9EAB1F284573CC85);
  level._createfx.select_by_name = 1;
}

get_last_selected_ent() {
  return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}