/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\createfxmenu.gsc
***********************************************/

function init_menu() {
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
  addoption("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", &input_reactive_radius);

  if(!level.mp_createfx) {
    addoption("string", "rumble", "Rumble", "nil", "exploder");
    addoption("int", "stopable", "Can be stopped from script", "1", "all");
  }

  level.effect_list_offset = 0;
  level.effect_list_offset_max = 10;

  if(level.mp_createfx) {
    level.effect_list_offset_max = 6;
  }

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

  if(!level.mp_createfx) {
    level.createfxmasks["fx"]["reactive_fx"] = 1;
  }

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
  var0 = [];
  GscBinSkip0(0x2e, "creation", &menu_create_select);
}

function menu(var0) {
  return level.create_fx_menu == var0;
}

function setmenu(var0) {
  level.create_fx_menu = var0;
}

function create_fx_menu() {
  if(scripts\common\createfx::button_is_clicked("escape", "x")) {
    exit_menu();
    return;
  }

  if(isDefined(level._createfx.menus[level.create_fx_menu])) {
    [[level._createfx.menus[level.create_fx_menu]]]();
    return;
  }
}

function menu_create_select() {
  if(!isDefined(level._createfx.menu_create_select)) {
    level._createfx.menu_create_select = [];
    var0 = [];
    GscBinSkip0(0x2e, "1", &buttonpress_create_oneshot);
  }

  foreach(var2 in level._createfx.menu_create_select) {
    if(scripts\common\createfx::button_is_clicked(var3)) {
      [[var2]]();
      return;
    }
  }
}

function buttonpress_create_oneshot() {
  setmenu("create_oneshot");
  draw_effects_list();
}

function buttonpress_create_loopfx() {
  setmenu("create_loopfx");
  draw_effects_list();
}

function buttonpress_create_loopsound() {
  setmenu("create_loopsound");
  var0 = scripts\common\createfx::createloopsound();
  finish_creating_entity(var0);
}

function buttonpress_create_exploder() {
  setmenu("create_exploder");
  var0 = scripts\common\createfx::createnewexploder();
  finish_creating_entity(var0);
}

function buttonpress_create_interval_sound() {
  setmenu("create_interval_sound");
  var0 = scripts\common\createfx::createintervalsound();
  finish_creating_entity(var0);
}

function buttonpress_create_reactiveent() {
  var0 = scripts\common\createfx::createreactiveent();
  finish_creating_entity(var0);
}

function menu_create() {
  if(next_button()) {
    increment_list_offset();
    draw_effects_list();
  } else if(previous_button()) {
    decrement_list_offset();
    draw_effects_list();
  }

  menu_fx_creation();
}

function menu_none() {
  if(scripts\common\createfx::button_is_clicked("m")) {
    increment_list_offset();
  }

  menu_change_selected_fx();

  if(entities_are_selected()) {
    var0 = get_last_selected_ent();

    if(!isDefined(level.last_displayed_ent) || var0 != level.last_displayed_ent) {
      display_fx_info(var0);
      level.last_displayed_ent = var0;
    }

    if(scripts\common\createfx::button_is_clicked("a")) {
      scripts\common\createfx::clear_settable_fx();
      setmenu("add_options");
      return;
    }

    return;
  }

  level.last_displayed_ent = undefined;
}

function menu_add_options() {
  if(!entities_are_selected()) {
    scripts\common\createfx::clear_fx_hudelements();
    setmenu("none");
    return;
  }

  display_fx_add_options(get_last_selected_ent());

  if(next_button()) {
    increment_list_offset();
    return;
  }
}

function menu_select_by_name() {
  if(next_button()) {
    increment_list_offset();
    draw_effects_list("Select by name");
  } else if(previous_button()) {
    decrement_list_offset();
    draw_effects_list("Select by name");
  }

  select_by_name();
}

function next_button() {
  return scripts\common\createfx::button_is_clicked("rightarrow");
}

function previous_button() {
  return scripts\common\createfx::button_is_clicked("leftarrow");
}

function exit_menu() {
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::clear_entity_selection();
  scripts\common\createfx::update_selected_entities();
  setmenu("none");
}

function menu_fx_creation() {
  var0 = 0;
  var1 = undefined;
  var2 = scripts\common\createfx::func_get_level_fx();

  for(var3 = level.effect_list_offset; var3 < var2.size; var3++) {
    var0 += 1;
    var4 = var0;

    if(var4 == 10) {
      var4 = 0;
    }

    if(scripts\common\createfx::button_is_clicked(var4 + "")) {
      var1 = var2[var3];
      break;
    }

    if(var0 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(var1)) {
    return;
  }

  if(menu("change_fxid")) {
    apply_option_to_selected_fx(get_option("fxid"), var1);
    level.effect_list_offset = 0;
    scripts\common\createfx::clear_fx_hudelements();
    setmenu("none");
    return;
  }

  var5 = undefined;

  if(menu("create_loopfx")) {
    var5 = scripts\engine\utility::createloopeffect(var1);
  }

  if(menu("create_oneshot")) {
    var5 = scripts\engine\utility::createoneshoteffect(var1);
  }

  finish_creating_entity(var5);
}

function finish_creating_entity(var0) {
  var0.v["angles"] = vectortoangles(var0.v["origin"] + (0, 0, 100) - var0.v["origin"]);

  if(isDefined(level._effect) && isDefined(level._effect[var0.v["fxid"]]) && isvfxfile(level._effect[var0.v["fxid"]])) {
    var0.v["angles"] = (0, 0, 0);
  }

  var0 scripts\common\createfx::post_entity_creation_function();
  scripts\common\createfx::clear_entity_selection();
  scripts\common\createfx::select_last_entity();
  scripts\common\createfx::move_selection_to_cursor();
  scripts\common\createfx::update_selected_entities();
  setmenu("none");
}

function entities_are_selected() {
  return level._createfx.selected_fx_ents.size > 0;
}

function menu_change_selected_fx() {
  if(!level._createfx.selected_fx_ents.size) {
    return;
  }

  var0 = 0;
  var1 = 0;
  var2 = get_last_selected_ent();

  for(var3 = 0; var3 < level._createfx.options.size; var3++) {
    var4 = level._createfx.options[var3];

    if(!isDefined(var2.v[var4["name"]])) {
      continue;
    }

    var0++;

    if(var0 < level.effect_list_offset) {
      continue;
    }

    var1++;
    var5 = var1;

    if(var5 == 10) {
      var5 = 0;
    }

    if(scripts\common\createfx::button_is_clicked(var5 + "")) {
      prepare_option_for_change(var4, var1);
      break;
    }

    if(var1 > level.effect_list_offset_max) {
      var6 = 1;
      break;
    }
  }
}

function prepare_option_for_change(var0, var1) {
  if(var0["name"] == "fxid") {
    setmenu("change_fxid");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = 1;
  level._createfx.hudelems[var1 + 3][0].color = (1, 1, 0);

  if(isDefined(var0["input_func"])) {
    GscBinSkip1(0x74, var0["input_func"], var1 + 3);
  }

  scripts\common\createfx::createfx_centerprint("To change " + var0["description"] + " on selected entities, type /fx newvalue");
  set_option_index(var0["name"]);
  setDvar("fx", "nil");
}

function menu_fx_option_set() {
  if(getDvar("fx") == "nil") {
    return;
  }

  var0 = get_selected_option();
  var1 = undefined;

  if(var0["type"] == "string") {
    var1 = getDvar("fx");
  }

  if(var0["type"] == "int") {
    var1 = getdvarint("fx");
  }

  if(var0["type"] == "float") {
    var1 = getdvarfloat("fx");
  }

  if(var0["type"] == "bool") {
    var1 = getDvar("fx");

    if(var1 == "0" || var1 == "false") {
      var1 = 0;
    } else {
      var1 = 1;
    }
  }

  apply_option_to_selected_fx(var0, var1);
}

function apply_option_to_selected_fx(var0, var1) {
  for(var2 = 0; var2 < level._createfx.selected_fx_ents.size; var2++) {
    var3 = level._createfx.selected_fx_ents[var2];

    if(mask(var0["mask"], var3.v["type"])) {
      var3.v[var0["name"]] = var1;
    }
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

function set_option_index(var0) {
  for(var1 = 0; var1 < level._createfx.options.size; var1++) {
    if(level._createfx.options[var1]["name"] != var0) {
      continue;
    }

    level._createfx.selected_fx_option_index = var1;
    return;
  }
}

function get_selected_option() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

function mask(var0, var1) {
  return isDefined(level.createfxmasks[var0][var1]);
}

function addoption(var0, var1, var2, var3, var4, var5) {
  var6 = [];
  GscBinSkip0(0x2e, "type", var0);
}

function get_option(var0) {
  for(var1 = 0; var1 < level._createfx.options.size; var1++) {
    if(level._createfx.options[var1]["name"] == var0) {
      return level._createfx.options[var1];
    }
  }
}

function input_reactive_radius(var0) {
  for(;;) {
    waitframe();

    if(level.player buttonPressed("escape") || level.player buttonPressed("x")) {
      break;
    }

    var1 = 0;

    if(level.player buttonPressed("-")) {
      var1 = -10;
    } else if(level.player buttonPressed("=")) {
      var1 = 10;
    }

    if(var1 != 0) {
      foreach(var3 in level._createfx.selected_fx_ents) {
        if(isDefined(var3.v["reactive_radius"])) {
          var3.v["reactive_radius"] = var3.v["reactive_radius"] + var1;
          var3.v["reactive_radius"] = clamp(var3.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

function display_fx_add_options(var0) {
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("Name: " + var0.v["fxid"]);
  scripts\common\createfx::set_fx_hudelement("Type: " + var0.v["type"]);
  scripts\common\createfx::set_fx_hudelement("Origin: " + var0.v["origin"]);
  scripts\common\createfx::set_fx_hudelement("Angles: " + var0.v["angles"]);
  var1 = 0;
  var2 = 0;
  var3 = 0;

  if(level.effect_list_offset >= level._createfx.options.size) {
    level.effect_list_offset = 0;
  }

  for(var4 = 0; var4 < level._createfx.options.size; var4++) {
    var5 = level._createfx.options[var4];

    if(isDefined(var0.v[var5["name"]])) {
      continue;
    }

    if(!mask(var5["mask"], var0.v["type"])) {
      continue;
    }

    var1++;

    if(var1 < level.effect_list_offset) {
      continue;
    }

    if(var2 >= level.effect_list_offset_max) {
      continue;
    }

    var2++;
    var6 = var2;

    if(var6 == 10) {
      var6 = 0;
    }

    if(scripts\common\createfx::button_is_clicked(var6 + "")) {
      add_option_to_selected_entities(var5);
      menunone();
      level.last_displayed_ent = undefined;
      return;
    }

    scripts\common\createfx::set_fx_hudelement(var6 + ". " + var5["description"]);
  }

  if(var1 > level.effect_list_offset_max) {
    scripts\common\createfx::set_fx_hudelement("(->) More >");
  }

  scripts\common\createfx::set_fx_hudelement("(x) Exit >");
}

function add_option_to_selected_entities(var0) {
  var1 = undefined;

  for(var2 = 0; var2 < level._createfx.selected_fx_ents.size; var2++) {
    var3 = level._createfx.selected_fx_ents[var2];

    if(mask(var0["mask"], var3.v["type"])) {
      var3.v[var0["name"]] = var0["default"];
    }
  }
}

function menunone() {
  level.effect_list_offset = 0;
  scripts\common\createfx::clear_fx_hudelements();
  setmenu("none");
}

function display_fx_info(var0) {
  if(!menu("none")) {
    return;
  }

  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("Name: " + var0.v["fxid"]);
  scripts\common\createfx::set_fx_hudelement("Type: " + var0.v["type"]);
  scripts\common\createfx::set_fx_hudelement("Origin: " + var0.v["origin"]);
  scripts\common\createfx::set_fx_hudelement("Angles: " + var0.v["angles"]);

  if(entities_are_selected()) {
    var1 = 0;
    var2 = 0;
    var3 = 0;

    for(var4 = 0; var4 < level._createfx.options.size; var4++) {
      var5 = level._createfx.options[var4];

      if(!isDefined(var0.v[var5["name"]])) {
        continue;
      }

      var1++;

      if(var1 < level.effect_list_offset) {
        continue;
      }

      var2++;
      scripts\common\createfx::set_fx_hudelement(var2 + ". " + var5["description"] + ": " + var0.v[var5["name"]]);

      if(var2 > level.effect_list_offset_max) {
        var3 = 1;
        break;
      }
    }

    if(var1 > level.effect_list_offset_max) {
      scripts\common\createfx::set_fx_hudelement("(->) More >");
    }

    scripts\common\createfx::set_fx_hudelement("(a) Add >");
    scripts\common\createfx::set_fx_hudelement("(x) Exit >");
    return;
  }

  var1 = 0;
  var3 = 0;

  for(var4 = 0; var4 < level._createfx.options.size; var4++) {
    var5 = level._createfx.options[var4];

    if(!isDefined(var5.v[var5["name"]])) {
      continue;
    }

    var1++;
    scripts\common\createfx::set_fx_hudelement(var5["description"] + ": " + var5.v[var5["name"]]);

    if(var1 > level._createfx.hudelem_count) {
      break;
    }
  }
}

function draw_effects_list(var0) {
  scripts\common\createfx::clear_fx_hudelements();
  var1 = 0;
  var2 = 0;
  var3 = scripts\common\createfx::func_get_level_fx();

  if(!isDefined(var0)) {
    var0 = "Pick an effect";
  }

  scripts\common\createfx::set_fx_hudelement(var0 + " [" + level.effect_list_offset + " - " + var3.size + "]:");

  for(var4 = level.effect_list_offset; var4 < var3.size; var4++) {
    var1 += 1;
    scripts\common\createfx::set_fx_hudelement(var1 + ". " + var3[var4]);

    if(var1 >= level.effect_list_offset_max) {
      var2 = 1;
      break;
    }
  }

  if(var3.size > level.effect_list_offset_max) {
    scripts\common\createfx::set_fx_hudelement("(->) More >");
    scripts\common\createfx::set_fx_hudelement("(<-) Previous >");
    return;
  }
}

function increment_list_offset() {
  var0 = scripts\common\createfx::func_get_level_fx();

  if(level.effect_list_offset >= var0.size - level.effect_list_offset_max) {
    level.effect_list_offset = 0;
    return;
  }

  level.effect_list_offset += level.effect_list_offset_max;
}

function decrement_list_offset() {
  level.effect_list_offset -= level.effect_list_offset_max;

  if(level.effect_list_offset < 0) {
    var0 = scripts\common\createfx::func_get_level_fx();
    level.effect_list_offset = var0.size - level.effect_list_offset_max;
    return;
  }
}

function select_by_name() {
  var0 = 0;
  var1 = undefined;
  var2 = scripts\common\createfx::func_get_level_fx();

  for(var3 = level.effect_list_offset; var3 < var2.size; var3++) {
    var0 += 1;
    var4 = var0;

    if(var4 == 10) {
      var4 = 0;
    }

    if(scripts\common\createfx::button_is_clicked(var4 + "")) {
      var1 = var2[var3];
      break;
    }

    if(var0 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(var1)) {
    return;
  }

  var5 = [];

  foreach(var3, var7 in level.createfxent) {
    if(issubstr(var7.v["fxid"], var1)) {
      var5 = var3;
    }
  }

  scripts\common\createfx::deselect_all_ents();
  scripts\common\createfx::select_index_array(var5);
  level._createfx.select_by_name = 1;
}

function get_last_selected_ent() {
  return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}