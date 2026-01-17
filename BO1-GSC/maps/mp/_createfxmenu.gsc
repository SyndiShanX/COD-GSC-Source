/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_createfxmenu.gsc
**************************************/

#include maps\mp\_utility;
#include maps\mp\_createfx;
#include common_scripts\utility;

menu(name) {
  return level.create_fx_menu == name;
}
setmenu(name) {
  level.create_fx_menu = name;
}
create_fx_menu() {
  if(button_is_clicked("escape", "x")) {
    exit_menu();
    return;
  }
  if(menu("creation")) {
    if(button_is_clicked("1")) {
      setmenu("create_oneshot");
      draw_effects_list();
      return;
    }
    if(button_is_clicked("2")) {
      setmenu("create_loopfx");
      draw_effects_list();
      return;
    }
    if(button_is_clicked("3")) {
      setmenu("create_exploder");
      ent = createNewExploder();
      finish_creating_entity(ent);
      return;
    }
    if(button_is_clicked("4")) {
      setmenu("create_loopsound");
      ent = createLoopSound();
      finish_creating_entity(ent);
      return;
    }
  }
  if(menu("create_oneshot") || menu("create_loopfx") || menu("change_fxid")) {
    if(button_is_clicked("rightarrow")) {
      increment_list_offset();
      draw_effects_list();
    }
    if(button_is_clicked("leftarrow")) {
      decrement_list_offset();
      draw_effects_list();
    }
    menu_fx_creation();
  } else if(menu("none")) {
    menu_change_selected_fx();
    if(entities_are_selected()) {
      display_fx_info(get_last_selected_entity());
      if(button_is_clicked("a")) {
        clear_settable_fx();
        setMenu("add_options");
      }
    }
  } else if(menu("add_options")) {
    if(!entities_are_selected()) {
      clear_fx_hudElements();
      setMenu("none");
      return;
    }
    display_fx_add_options(get_last_selected_entity());
    if(button_is_clicked("rightarrow")) {
      increment_list_offset();
    }
    if(button_is_clicked("leftarrow")) {
      decrement_list_offset();
    }
  } else if(menu("jump_to_effect")) {
    if(button_is_clicked("rightarrow")) {
      increment_list_offset();
      draw_effects_list("Select effect to jump to:");
    }
    if(button_is_clicked("leftarrow")) {
      decrement_list_offset();
      draw_effects_list("Select effect to jump to:");
    }
    jump_to_effect();
  } else if(menu("select_by_property")) {
    menu_selection();
    if(button_is_clicked("rightarrow")) {
      increment_list_offset();
    }
    if(button_is_clicked("leftarrow")) {
      decrement_list_offset();
    }
  } else if(menu("change_type")) {
    if(!entities_are_selected()) {
      clear_fx_hudElements();
      setMenu("none");
      return;
    } else {
      menu_fx_type();
    }
  }
}
exit_menu() {
  clear_fx_hudElements();
  clear_entity_selection();
  update_selected_entities();
  setmenu("none");
}
get_last_selected_entity() {
  return level.selected_fx_ents[level.selected_fx_ents.size - 1];
}
menu_fx_creation() {
  count = 0;
  picked_fx = undefined;
  keys = get_level_ambient_fx();
  for(i = level.effect_list_offset; i < keys.size; i++) {
    count = count + 1;
    button_to_check = count;
    if(button_to_check == 10) {
      button_to_check = 0;
    }
    if(button_is_clicked(button_to_check + "") && (!button_is_held("f"))) {
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
  if(menu("create_loopfx")) {
    ent = createLoopEffect(picked_fx);
  }
  if(menu("create_oneshot")) {
    ent = createOneshotEffect(picked_fx);
  }
  finish_creating_entity(ent);
}
finish_creating_entity(ent) {
  ent.v["angles"] = vectortoangles((ent.v["origin"] + (0, 0, 100)) - ent.v["origin"]);
  assert(isDefined(ent));
  ent post_entity_creation_function();
  clear_entity_selection();
  select_last_entity();
  move_selection_to_cursor();
  update_selected_entities();
  setMenu("none");
}
change_effect_to_oneshot(ent) {
  if(ent.v["type"] == "oneshotfx") {
    return;
  }
  if(ent.v["type"] == "exploder") {
    ent.v["exploder"] = undefined;
    ent.v["exploder_type"] = undefined;
    ent.v["soundalias"] = undefined;
  }
  if(!isDefined(ent.v["delay"]) || ent.v["delay"] == 0) {
    ent.v["delay"] = -15;
  }
  ent.v["type"] = "oneshotfx";
}
change_effect_to_loop(ent) {
  if(ent.v["type"] == "loopfx") {
    return;
  }
  if(ent.v["type"] == "exploder") {
    ent.v["exploder"] = undefined;
    ent.v["exploder_type"] = undefined;
    ent.v["soundalias"] = undefined;
  }
  if(!isDefined(ent.v["delay"]) || ent.v["delay"] <= 0) {
    ent.v["delay"] = 1;
  }
  ent.v["type"] = "loopfx";
}
change_effect_to_exploder(ent) {
  if(ent.v["type"] == "exploder") {
    return;
  }
  ent.v["type"] = "exploder";
  if(!isDefined(ent.v["delay"]) || ent.v["delay"] < 0) {
    ent.v["delay"] = 0;
  }
  ent.v["exploder"] = 1;
  ent.v["exploder_type"] = "normal";
}
change_ent_type(newtype) {
  if(newtype == "oneshotfx") {
    for(i = 0; i < level.selected_fx_ents.size; i++) {
      change_effect_to_oneshot(level.selected_fx_ents[i]);
    }
  } else if(newtype == "loopfx") {
    for(i = 0; i < level.selected_fx_ents.size; i++) {
      change_effect_to_loop(level.selected_fx_ents[i]);
    }
  } else if(newtype == "exploder") {
    for(i = 0; i < level.selected_fx_ents.size; i++) {
      change_effect_to_exploder(level.selected_fx_ents[i]);
    }
  }
}
menu_init() {
  level.createFX_options = [];
  addOption("string", "type", "Type", "oneshotfx", "fx");
  addOption("string", "fxid", "Name", "nil", "fx");
  addOption("float", "delay", "Repeat rate/start delay", 0.5, "fx");
  addOption("int", "repeat", "Number of times to repeat", 5, "exploder");
  addOption("float", "delay_min", "Minimum time between repeats", 1, "exploder");
  addOption("float", "delay_max", "Maximum time between repeats", 2, "exploder");
  addOption("float", "fire_range", "Fire damage range", 0, "fx");
  addOption("string", "firefx", "2nd FX id", "nil", "exploder");
  addOption("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
  addOption("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
  addOption("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
  addOption("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
  addOption("string", "rumble", "Rumble", "nil", "exploder");
  addOption("float", "damage", "Radius damage", 150, "exploder");
  addOption("float", "damage_radius", "Radius of radius damage", 250, "exploder");
  addOption("int", "exploder", "Exploder", 1, "exploder");
  addOption("string", "earthquake", "Earthquake", "nil", "exploder");
  addOption("string", "soundalias", "Soundalias", "nil", "all");
  addOption("int", "stoppable", "Can be stopped from script", "1", "all");
  level.effect_list_offset = 0;
  level.effect_list_offset_max = 9;
  level.createfxMasks = [];
  level.createfxMasks["all"] = [];
  level.createfxMasks["all"]["exploder"] = true;
  level.createfxMasks["all"]["oneshotfx"] = true;
  level.createfxMasks["all"]["loopfx"] = true;
  level.createfxMasks["all"]["soundfx"] = true;
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
}
get_last_selected_ent() {
  return level.selected_fx_ents[level.selected_fx_ents.size - 1];
}
entities_are_selected() {
  return level.selected_fx_ents.size > 0;
}
menu_change_selected_fx() {
  if(!level.selected_fx_ents.size) {
    return;
  }
  count = 0;
  drawnCount = 0;
  ent = get_last_selected_ent();
  for(i = 0; i < level.createFX_options.size; i++) {
    option = level.createFX_options[i];
    if(!isDefined(ent.v[option["name"]])) {
      continue;
    }
    count++;
    if(count < level.effect_list_offset) {
      continue;
    }
    drawnCount++;
    button_to_check = drawnCount;
    if(button_to_check == 10) {
      button_to_check = 0;
    }
    if(button_is_clicked(button_to_check + "") && (!button_is_held("f"))) {
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
  if(option["name"] == "type") {
    setMenu("change_type");
    return;
  }
  level.createfx_inputlocked = true;
  set_option_index(option["name"]);
  setdvar("fx", "nil");
  level.createFxHudElements[drawnCount + 3][0].color = (1, 1, 0);
}
menu_fx_option_set() {
  if(GetDvar(#"fx") == "nil") {
    return;
  }
  option = get_selected_option();
  setting = undefined;
  if(option["type"] == "string") {
    setting = GetDvar(#"fx");
  }
  if(option["type"] == "int") {
    setting = GetDvarInt(#"fx");
  }
  if(option["type"] == "float") {
    setting = GetDvarFloat(#"fx");
  }
  apply_option_to_selected_fx(option, setting);
}
menu_fx_type() {
  clear_fx_hudElements();
  set_fx_hudElement("Change effect type to:");
  set_fx_hudElement(" (1) Oneshot");
  set_fx_hudElement(" (2) Looped");
  set_fx_hudElement(" (3) Exploder");
  set_fx_hudElement("(x) Exit >");
  if(button_is_clicked("1") && (!button_is_held("f"))) {
    change_ent_type("oneshotfx");
    setmenu("none");
  } else if(button_is_clicked("2") && (!button_is_held("f"))) {
    change_ent_type("loopfx");
    setmenu("none");
  } else if(button_is_clicked("3") && (!button_is_held("f"))) {
    change_ent_type("exploder");
    setmenu("none");
  }
  if(menu("none")) {
    update_selected_entities();
  }
}
menu_selection() {
  clear_fx_hudElements();
  set_fx_hudElement("Select all by property:");
  drawnCount = 0;
  option_number = 0;
  ent = level.selected_fx_ents[level.selected_fx_ents.size - 1];
  for(i = level.effect_list_offset; i < level.createFX_options.size; i++) {
    if(drawnCount > level.effect_list_offset_max) {
      break;
    }
    if(drawnCount > ent.v.size) {
      break;
    }
    prop_name = level.createFX_options[i]["name"];
    option_number = drawnCount + 1;
    if(isDefined(ent.v[prop_name])) {
      if(button_is_clicked(option_number + "") && (!button_is_held("f"))) {
        level.cfx_selected_prop = prop_name;
        menuNone();
        level.effect_list_offset = 0;
        return;
      }
      prop_desc = level.createFX_options[i]["description"];
      set_fx_hudElement(option_number + ". " + prop_desc + ": " + ent.v[prop_name]);
      drawnCount++;
      continue;
    }
  }
  if(drawnCount > level.effect_list_offset_max) {
    pages = ceil(ent.v.size / level.effect_list_offset_max);
    current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
    set_fx_hudElement("(<-) Page " + current_page + " of " + pages + " (->)");
  }
  set_fx_hudElement("(x) Exit >");
}
apply_option_to_selected_fx(option, setting) {
  for(i = 0; i < level.selected_fx_ents.size; i++) {
    ent = level.selected_fx_ents[i];
    if(mask(option["mask"], ent.v["type"])) {
      ent.v[option["name"]] = setting;
    }
  }
  update_selected_entities();
  clear_settable_fx();
}
set_option_index(name) {
  for(i = 0; i < level.createFX_options.size; i++) {
    if(level.createFX_options[i]["name"] != name) {
      continue;
    }
    level.selected_fx_option_index = i;
    return;
  }
}
get_selected_option() {
  return level.createFX_options[level.selected_fx_option_index];
}
mask(type, name) {
  return isDefined(level.createfxMasks[type][name]);
}
addOption(type, name, description, defaultSetting, mask) {
  option = [];
  option["type"] = type;
  option["name"] = name;
  option["description"] = description;
  option["default"] = defaultSetting;
  option["mask"] = mask;
  level.createFX_options[level.createFX_options.size] = option;
}
get_option(name) {
  for(i = 0; i < level.createFX_options.size; i++) {
    if(level.createFX_options[i]["name"] == name) {
      return level.createFX_options[i];
    }
  }
}
display_fx_info(ent) {
  if(!menu("none")) {
    return;
  }
  clear_fx_hudElements();
  set_fx_hudElement("Selected: " + level.selected_fx_ents.size + " Distance: " + get_distance_from_ent(ent));
  level.createFxHudElements[0][0].color = (1, 1, 0);
  set_fx_hudElement("Name: " + ent.v["fxid"]);
  set_fx_hudElement("Origin: " + ent.v["origin"]);
  set_fx_hudElement("Angles: " + ent.v["angles"]);
  if(entities_are_selected()) {
    count = 0;
    drawnCount = 0;
    more = false;
    for(i = 0; i < level.createFX_options.size; i++) {
      option = level.createFX_options[i];
      if(!isDefined(ent.v[option["name"]])) {
        continue;
      }
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
    if(count > level.effect_list_offset_max) {
      pages = ceil(level.createFX_options.size / level.effect_list_offset_max);
      current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
      set_fx_hudElement("(<-) Page " + current_page + " of " + pages + " (->)");
    }
    set_fx_hudElement("(a) Add >");
    set_fx_hudElement("(x) Exit >");
  } else {
    count = 0;
    more = false;
    for(i = 0; i < level.createFX_options.size; i++) {
      option = level.createFX_options[i];
      if(!isDefined(ent.v[option["name"]])) {
        continue;
      }
      count++;
      set_fx_hudElement(option["description"] + ": " + ent.v[option["name"]]);
      if(count > level.createFx_hudElements) {
        break;
      }
    }
  }
}
display_fx_add_options(ent) {
  assert(menu("add_options"));
  assert(entities_are_selected());
  clear_fx_hudElements();
  set_fx_hudElement("Selected: " + level.selected_fx_ents.size + " Distance: " + get_distance_from_ent(ent));
  level.createFxHudElements[0][0].color = (1, 1, 0);
  set_fx_hudElement("Name: " + ent.v["fxid"]);
  set_fx_hudElement("Origin: " + ent.v["origin"]);
  set_fx_hudElement("Angles: " + ent.v["angles"]);
  count = 0;
  drawnCount = 0;
  more = false;
  if(level.effect_list_offset >= level.createFX_options.size) {
    level.effect_list_offset = 0;
  }
  for(i = 0; i < level.createFX_options.size; i++) {
    option = level.createFX_options[i];
    if(isDefined(ent.v[option["name"]])) {
      continue;
    }
    if(!mask(option["mask"], ent.v["type"])) {
      continue;
    }
    count++;
    if(count < level.effect_list_offset) {
      continue;
    }
    if(drawnCount >= level.effect_list_offset_max) {
      continue;
    }
    drawnCount++;
    button_to_check = drawnCount;
    if(button_to_check == 10) {
      button_to_check = 0;
    }
    if(button_is_clicked(button_to_check + "") && (!button_is_held("f"))) {
      add_option_to_selected_entities(option);
      menuNone();
      return;
    }
    set_fx_hudElement(button_to_check + ". " + option["description"]);
  }
  if(count > level.effect_list_offset_max) {
    pages = ceil(level.createFX_options.size / level.effect_list_offset_max);
    current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
    set_fx_hudElement("(<-) Page " + current_page + " of " + pages + " (->)");
  }
  set_fx_hudElement("(x) Exit >");
}
add_option_to_selected_entities(option) {
  setting = undefined;
  for(i = 0; i < level.selected_fx_ents.size; i++) {
    ent = level.selected_fx_ents[i];
    if(mask(option["mask"], ent.v["type"])) {
      ent.v[option["name"]] = option["default"];
    }
  }
}
menuNone() {
  level.effect_list_offset = 0;
  clear_fx_hudElements();
  setMenu("none");
}
draw_effects_list(title) {
  clear_fx_hudElements();
  if(!isDefined(title)) {
    title = "Pick an effect:";
  }
  set_fx_hudElement(title);
  count = 0;
  more = false;
  keys = get_level_ambient_fx();
  if(level.effect_list_offset >= keys.size) {
    level.effect_list_offset = 0;
  } else if(level.effect_list_offset < 0) {
    level.effect_list_offset = int(floor(keys.size / level.effect_list_offset_max) * level.effect_list_offset_max);
  }
  for(i = level.effect_list_offset; i < keys.size; i++) {
    count = count + 1;
    set_fx_hudElement(count + ". " + keys[i]);
    if(count >= level.effect_list_offset_max) {
      more = true;
      break;
    }
  }
  if(keys.size > level.effect_list_offset_max) {
    pages = ceil(keys.size / level.effect_list_offset_max);
    current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
    set_fx_hudElement("(<-) Page " + current_page + " of " + pages + " (->)");
  }
}
increment_list_offset() {
  level.effect_list_offset += level.effect_list_offset_max;
}
decrement_list_offset() {
  level.effect_list_offset -= level.effect_list_offset_max;
}
jump_to_effect() {
  count = 0;
  picked_fxid = undefined;
  keys = get_level_ambient_fx();
  for(i = level.effect_list_offset; i < keys.size; i++) {
    count = count + 1;
    button_to_check = count;
    if(button_to_check == 10) {
      button_to_check = 0;
    }
    if(button_is_clicked(button_to_check + "") && (!button_is_held("f"))) {
      picked_fxid = keys[i];
      break;
    }
    if(count > level.effect_list_offset_max) {
      break;
    }
  }
  if(!isDefined(picked_fxid)) {
    return;
  }
  clear_entity_selection();
  ent = get_next_ent_with_same_id(-1, picked_fxid);
  if(isDefined(ent)) {
    level.cfx_next_ent = ent;
    move_player_to_next_same_effect();
  } else {}
  level.effect_list_offset = 0;
  clear_fx_hudElements();
  setMenu("none");
}
get_level_ambient_fx() {
  if(!isDefined(level._effect_keys)) {
    keys = getarraykeys(level._effect);
    level._effect_keys = [];
    k = 0;
    for(i = 0; i < keys.size; i++) {
      if(isSubStr(keys[i], "fx_")) {
        level._effect_keys[k] = keys[i];
        k++;
      }
    }
    if(level._effect_keys.size == 0) {
      level._effect_keys = keys;
    }
  }
  return level._effect_keys;
}
get_distance_from_ent(ent) {
  player = get_players()[0];
  return distance(player getEye(), ent.v["origin"]);
}