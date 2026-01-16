/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_createdynents.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init_once() {
  precacheshader("white");
  dyn_models = getdynmodels();
  dyn_models = [];

  for(i = 0; i < dyn_models.size; i++) {
    if(isDefined(dyn_models[i]))
      precachemodel(dyn_models[i]);
  }

  misc_models = getmiscmodels();
  misc_models = [];

  for(i = 0; i < misc_models.size; i++) {
    if(isDefined(misc_models[i]))
      precachemodel(misc_models[i]);
  }

  level.model_names["dynent"] = [];
  level.model_names["destructible"] = [];
  level.model_names["miscmodel"] = [];
  level.models["dynent"] = [];
  level.models["destructible"] = [];
  level.models["miscmodel"] = [];
  level.dynent_groups = [];
  level.all_objects = [];
  setup_groups();
  dyn_models = getdynmodels();
  dyn_models = [];

  for(i = 0; i < dyn_models.size; i++) {
    if(isDefined(dyn_models[i])) {
      add_model_to_group(dyn_models[i]);
      add_name(dyn_models[i], "dynent");
    }
  }

  misc_models = getmiscmodels();
  misc_models = [];

  for(i = 0; i < misc_models.size; i++)
    add_name(misc_models[i], "miscmodel");

  destructible_defs = getdestructibledefs();

  for(i = 0; i < destructible_defs.size; i++)
    add_name(destructible_defs[i], "destructible");
}

main() {
  while(getdvar(#"_id_C33E3082") != "1")
    wait 1;

  if(!isDefined(level.script))
    level.script = tolower(getdvar(#"mapname"));

  waittillframeend;
  wait 1;
  wait_for_first_player();
  players = get_players();
  level.debug_player = players[0];
  level set_default_path();
  level set_crosshair();
  level init();
  level setup_menus();
  level setup_menu_buttons();
  level thread menu_input();
  level setup_xform_menu();
}

set_crosshair() {
  crosshair = newdebughudelem();
  crosshair.location = 0;
  crosshair.alignx = "center";
  crosshair.aligny = "middle";
  crosshair.foreground = 1;
  crosshair.fontscale = 2;
  crosshair.sort = 20;
  crosshair.alpha = 1;
  crosshair.x = 320;
  crosshair.y = 233;
  crosshair settext(".");
}

setup_groups() {
  level.model_group_map = [];
  level.dynent_groups = [];
  level.groups = [];
  level.model_group_map["p_glo_gascan"] = "p_glo";
  level.model_group_map["p_glo_cinder_block"] = "p_glo";
  level.model_group_map["p_jun_fruit_apple"] = "fruits";
  level.model_group_map["p_jun_fruit_pineapple"] = "fruits";
}

add_to_group(group, model) {
  if(isDefined(level.groups[group])) {
    if(check_for_dupes(level.groups[group], model))
      level.groups[group][level.groups[group].size] = model;
  } else {
    level.dynent_groups[level.dynent_groups.size] = group;
    level.groups[group][0] = model;
  }

}

add_model_to_group(model) {
  if(isDefined(level.model_group_map[model]))
    add_to_group(level.model_group_map[model], model);
  else
    add_to_group("miscmodel", model);
}

init() {
  level.highlighted = [];
  level.rotate_highlighted = [];
}

add_to_dynent_group(dynent_name) {
  if(check_for_dupes(level.dynent_groups, dynent_name))
    level.dynent_groups[level.dynent_groups.size] = dynent_name;
}

add_to_all_objects() {
  if(check_for_dupes(level.all_objects, self))
    level.all_objects[level.all_objects.size] = self;
}

remove_from_all_objects() {
  if(level.all_objects.size > 0)
    arrayremovevalue(level.all_objects, self);
}

add_name(name, type) {
  if(check_for_dupes(level.model_names[type], name))
    level.model_names[type][level.model_names[type].size] = name;
}

add_model(type) {
  if(check_for_dupes(level.models[type], self))
    level.models[type][level.models[type].size] = self;
}

check_for_dupes(array, single) {
  for(i = 0; i < array.size; i++) {
    if(array[i] == single)
      return false;
  }

  return true;
}

setup_menus() {
  level.menu_sys = [];
  level.menu_sys["current_menu"] = spawnstruct();
  add_menu("choose_mode", "Choose Mode:");
  add_menuoptions("choose_mode", "Dyn Ents Mode");
  add_menuoptions("choose_mode", "Destructibles Mode");
  add_menuoptions("choose_mode", "Misc Models Mode");
  add_menuoptions("choose_mode", "Toggle Help Hud", ::toggle_xform_hud);
  add_menuoptions("choose_mode", "Quit", ::quit);
  add_menu_child("choose_mode", "dynent_mode", "Dyn Ents Mode");
  set_no_back_menu("dynent_mode");
  add_menuoptions("dynent_mode", "Select Model", ::select_dynent_from_list);
  add_menuoptions("dynent_mode", "Select Group", ::select_dynent_group);
  add_menuoptions("dynent_mode", "Place Model", ::place_dynent);
  add_menuoptions("dynent_mode", "Place Copy", ::place_dynent_copy);
  add_menuoptions("dynent_mode", "Spray Selected", ::spray_model);
  add_menuoptions("dynent_mode", "Select Mode");
  add_menuoptions("dynent_mode", "Save", ::save_dynents);
  add_menuoptions("dynent_mode", "Back", ::selected_back);
  add_menu_child("dynent_mode", "dynent_select_menu", "Dyn Ents->Select Mode:", 5, ::select_dynents);
  add_menuoptions("dynent_select_menu", "Move");
  add_menuoptions("dynent_select_menu", "Copy");
  add_menuoptions("dynent_select_menu", "Delete", ::delete_model);
  add_menuoptions("dynent_select_menu", "Save");
  add_menu_child("dynent_select_menu", "dynent_move_menu", "Dyn Ents->Move Selected:", 0, ::move_model);
  set_no_back_menu("dynent_move_menu");
  add_menuoptions("dynent_move_menu", "Place Model", ::place_dynent);
  add_menuoptions("dynent_move_menu", "Copy Model", ::place_dynent_copy);
  add_menuoptions("dynent_move_menu", "Back", ::selected_back);
  add_menu_child("dynent_select_menu", "dynent_copy_menu", "Dyn Ents->Copy Selected:", 1, ::copy_dynent);
  set_no_back_menu("dynent_copy_menu");
  add_menuoptions("dynent_copy_menu", "Place Model", ::place_dynent);
  add_menuoptions("dynent_copy_menu", "Place Copy", ::place_dynent_copy);
  add_menuoptions("dynent_copy_menu", "Back", ::selected_back);
  add_menu_child("dynent_select_menu", "selected_dynent_save_menu", "Dyn Ents->Save Selected:", 3, ::selected_dynent_save);
  add_menuoptions("selected_dynent_save_menu", "Highlight", ::selected_save_highlight);
  add_menuoptions("selected_dynent_save_menu", "Save Selected", ::save_dynent_highlighted);
  add_menu_child("choose_mode", "destructible_mode", "Destructibles Mode");
  add_menuoptions("destructible_mode", "Select Model", ::select_destructible_from_list);
  add_menuoptions("destructible_mode", "Place Model", ::place_destructible);
  add_menuoptions("destructible_mode", "Place Copy", ::place_destructible_copy);
  add_menuoptions("destructible_mode", "Select Mode");
  add_menuoptions("destructible_mode", "Save", ::save_destructibles);
  add_menu_child("destructible_mode", "destructible_select_menu", "Destructibles->Select Mode:", 3, ::select_destructibles);
  add_menuoptions("destructible_select_menu", "Move");
  add_menuoptions("destructible_select_menu", "Copy");
  add_menuoptions("destructible_select_menu", "Delete", ::delete_model);
  add_menuoptions("destructible_select_menu", "Save");
  add_menu_child("destructible_select_menu", "destructible_move_menu", "Destructibles->Move Selected:", 0, ::move_model);
  set_no_back_menu("destructible_move_menu");
  add_menuoptions("destructible_move_menu", "Place Model", ::place_destructible);
  add_menuoptions("destructible_move_menu", "Copy Model", ::place_destructible_copy);
  add_menuoptions("destructible_move_menu", "Back", ::selected_back);
  add_menu_child("destructible_select_menu", "destructible_copy_menu", "Destructibles->Copy Selected:", 1, ::copy_destructible);
  set_no_back_menu("destructible_copy_menu");
  add_menuoptions("destructible_copy_menu", "Place Model", ::place_destructible);
  add_menuoptions("destructible_copy_menu", "Place Copy", ::place_destructible_copy);
  add_menuoptions("destructible_copy_menu", "Back", ::selected_back);
  add_menu_child("destructible_select_menu", "selected_destructible_save_menu", "Destructibles->Save Selected:", 3, ::selected_destructible_save);
  add_menuoptions("selected_destructible_save_menu", "Highlight", ::selected_save_highlight);
  add_menuoptions("selected_destructible_save_menu", "Save Selected", ::save_destructible_highlighted);
  add_menu_child("choose_mode", "miscmodel_menu", "Misc Models Mode");
  add_menuoptions("miscmodel_menu", "Select Model", ::select_miscmodel_from_list);
  add_menuoptions("miscmodel_menu", "Place Model", ::place_miscmodel);
  add_menuoptions("miscmodel_menu", "Place Copy", ::place_miscmodel_copy);
  add_menuoptions("miscmodel_menu", "Select Mode");
  add_menuoptions("miscmodel_menu", "Save", ::save_miscmodels);
  add_menu_child("miscmodel_menu", "miscmodel_select_menu", "Misc Model->Select Mode:", 3, ::select_miscmodels);
  add_menuoptions("miscmodel_select_menu", "Move");
  add_menuoptions("miscmodel_select_menu", "Copy");
  add_menuoptions("miscmodel_select_menu", "Delete", ::delete_model);
  add_menuoptions("miscmodel_select_menu", "Save");
  add_menu_child("miscmodel_select_menu", "miscmodel_move_menu", "Misc Model->Move Selected:", 0, ::move_model);
  set_no_back_menu("miscmodel_move_menu");
  add_menuoptions("miscmodel_move_menu", "Place Model", ::place_miscmodel);
  add_menuoptions("miscmodel_move_menu", "Copy Model", ::place_miscmodel_copy);
  add_menuoptions("miscmodel_move_menu", "Back", ::selected_back);
  add_menu_child("miscmodel_select_menu", "miscmodel_copy_menu", "Misc Model->Copy Selected:", 1, ::copy_miscmodel);
  set_no_back_menu("miscmodel_copy_menu");
  add_menuoptions("miscmodel_copy_menu", "Place Model", ::place_miscmodel);
  add_menuoptions("miscmodel_copy_menu", "Place Copy", ::place_miscmodel_copy);
  add_menuoptions("miscmodel_copy_menu", "Back", ::selected_back);
  add_menu_child("miscmodel_select_menu", "selected_miscmodel_save_menu", "Misc Model->Save Selected:", 3, ::selected_miscmodel_save);
  add_menuoptions("selected_miscmodel_save_menu", "Highlight", ::selected_save_highlight);
  add_menuoptions("selected_miscmodel_save_menu", "Save Selected", ::save_miscmodel_highlighted);
  enable_menu("choose_mode");
}

add_menu(menu_name, title) {
  if(isDefined(level.menu_sys[menu_name])) {
    println("^1level.menu_sys[" + menu_name + "] already exists, change the menu_name");
    return;
  }

  level.menu_sys[menu_name] = spawnstruct();
  level.menu_sys[menu_name].title = "none";
  level.menu_sys[menu_name].title = title;
}

add_menuoptions(menu_name, option_text, func) {
  if(!isDefined(level.menu_sys[menu_name].options))
    level.menu_sys[menu_name].options = [];

  num = level.menu_sys[menu_name].options.size;
  level.menu_sys[menu_name].options[num] = option_text;
  level.menu_sys[menu_name].function[num] = func;
}

add_menu_child(parent_menu, child_menu, child_title, child_number_override, func) {
  if(!isDefined(level.menu_sys[child_menu]))
    add_menu(child_menu, child_title);

  level.menu_sys[child_menu].parent_menu = parent_menu;

  if(!isDefined(level.menu_sys[parent_menu].children_menu))
    level.menu_sys[parent_menu].children_menu = [];

  if(!isDefined(child_number_override))
    size = level.menu_sys[parent_menu].children_menu.size;
  else
    size = child_number_override;

  level.menu_sys[parent_menu].children_menu[size] = child_menu;

  if(isDefined(func)) {
    if(!isDefined(level.menu_sys[parent_menu].children_func))
      level.menu_sys[parent_menu].children_func = [];

    level.menu_sys[parent_menu].children_func[size] = func;
  }

}

set_no_back_menu(menu_name) {
  level.menu_sys[menu_name].no_back = 1;
}

enable_menu(menu_name) {
  disable_menu("current_menu");

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor.y = 130;
    level.menu_cursor.current_pos = 0;
  }

  level.menu_sys["current_menu"].title = set_menu_hudelem(level.menu_sys[menu_name].title, "title");
  level.menu_sys["current_menu"].menu_name = menu_name;
  back_option_num = 0;

  if(isDefined(level.menu_sys[menu_name].options)) {
    options = level.menu_sys[menu_name].options;

    for(i = 0; i < options.size; i++) {
      text = i + 1 + ". " + options[i];
      level.menu_sys["current_menu"].options[i] = set_menu_hudelem(text, "options", 20 * i);
      back_option_num = i;
    }
  }

  if(isDefined(level.menu_sys[menu_name].parent_menu) && !isDefined(level.menu_sys[menu_name].no_back)) {
    back_option_num++;
    text = back_option_num + 1 + ". " + "Back";
    level.menu_sys["current_menu"].options[back_option_num] = set_menu_hudelem(text, "options", 20 * back_option_num);
  }

}

disable_menu(menu_name) {
  if(isDefined(level.menu_sys[menu_name])) {
    if(isDefined(level.menu_sys[menu_name].title))
      level.menu_sys[menu_name].title destroy();

    if(isDefined(level.menu_sys[menu_name].options)) {
      options = level.menu_sys[menu_name].options;

      for(i = 0; i < options.size; i++)
        options[i] destroy();
    }
  }

  level.menu_sys[menu_name].title = undefined;
  level.menu_sys[menu_name].options = [];
}

set_menu_hudelem(text, type, y_offset) {
  y = 100;

  if(isDefined(type) && type == "title")
    scale = 2;
  else {
    scale = 1.3;
    y = y + 30;
  }

  if(!isDefined(y_offset))
    y_offset = 0;

  y = y + y_offset;
  return set_hudelem(text, 10, y, scale);
}

set_hudelem(text, x, y, scale, alpha) {
  if(!isDefined(alpha))
    alpha = 1;

  if(!isDefined(scale))
    scale = 1;

  hud = newdebughudelem();
  hud.location = 0;
  hud.alignx = "left";
  hud.aligny = "middle";
  hud.foreground = 1;
  hud.fontscale = scale;
  hud.sort = 20;
  hud.alpha = alpha;
  hud.x = x;
  hud.y = y;
  hud.og_scale = scale;

  if(isDefined(text))
    hud settext(text);

  return hud;
}

menu_input() {
  level endon("stop_createdynents");

  while(true) {
    level waittill("menu_button_pressed", keystring);
    menu_name = level.menu_sys["current_menu"].menu_name;

    if(keystring == "dpad_up" || keystring == "uparrow") {
      if(level.menu_cursor.current_pos > 0) {
        level.menu_cursor.y = level.menu_cursor.y - 20;
        level.menu_cursor.current_pos--;
      } else {
        level.menu_cursor.y = 130 + 20 * (level.menu_sys["current_menu"].options.size - 1);
        level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - 1;
      }

      continue;
    } else if(keystring == "dpad_down" || keystring == "downarrow") {
      if(level.menu_cursor.current_pos < level.menu_sys["current_menu"].options.size - 1) {
        level.menu_cursor.y = level.menu_cursor.y + 20;
        level.menu_cursor.current_pos++;
      } else {
        level.menu_cursor.y = 130;
        level.menu_cursor.current_pos = 0;
      }

      continue;
    } else if(keystring == "button_a" || keystring == "enter")
      key = level.menu_cursor.current_pos;
    else
      key = int(keystring) - 1;

    if(key > level.menu_sys[menu_name].options.size)
      continue;
    else if(isDefined(level.menu_sys[menu_name].parent_menu) && key == level.menu_sys[menu_name].options.size) {
      level notify("disable " + menu_name);
      level enable_menu(level.menu_sys[menu_name].parent_menu);
    } else if(isDefined(level.menu_sys[menu_name].function) && isDefined(level.menu_sys[menu_name].function[key])) {
      level.menu_sys["current_menu"].options[key] thread hud_selector(level.menu_sys["current_menu"].options[key].x, level.menu_sys["current_menu"].options[key].y);

      if(isDefined(level.menu_sys[menu_name].func_key) && isDefined(level.menu_sys[menu_name].func_key[key]) && level.menu_sys[menu_name].func_key[key] == keystring)
        error_msg = level[[level.menu_sys[menu_name].function[key]]]();
      else
        error_msg = level[[level.menu_sys[menu_name].function[key]]]();

      level thread hud_selector_fade_out();

      if(isDefined(error_msg))
        level thread selection_error(error_msg, level.menu_sys["current_menu"].options[key].x, level.menu_sys["current_menu"].options[key].y);
    }

    if(!isDefined(level.menu_sys[menu_name].children_menu))
      continue;
    else if(!isDefined(level.menu_sys[menu_name].children_menu[key]))
      continue;
    else if(!isDefined(level.menu_sys[level.menu_sys[menu_name].children_menu[key]])) {
      continue;
    }
    if(isDefined(level.menu_sys[menu_name].children_func) && isDefined(level.menu_sys[menu_name].children_func[key])) {
      func = level.menu_sys[menu_name].children_func[key];
      error_msg = [
        [func]
      ]();

      if(isDefined(error_msg)) {
        level thread selection_error(error_msg, level.menu_sys["current_menu"].options[key].x, level.menu_sys["current_menu"].options[key].y);
        continue;
      }
    }

    level enable_menu(level.menu_sys[menu_name].children_menu[key]);
  }

}

force_menu_back() {
  level endon("stop_createdynents");
  wait 0.1;
  menu_name = level.menu_sys["current_menu"].menu_name;
  key = level.menu_sys[menu_name].options.size;
  key++;
  keys[1] = "1";
  keys[2] = "2";
  keys[3] = "3";
  keys[4] = "4";
  keys[5] = "5";
  keys[6] = "6";
  keys[7] = "7";
  keys[8] = "8";
  keys[9] = "9";

  if(key > 0 && key < 10)
    key = keys[key];

  level notify("menu_button_pressed", key);
}

list_menu(list, x, y, scale, func) {
  hud_array = [];

  for(i = 0; i < list.size; i++) {
    alpha = 1 / (i + 1);

    if(alpha < 0.2)
      alpha = 0.1;

    hud = set_hudelem(list[i], x, y + i * 15, scale, alpha);
    hud_array[hud_array.size] = hud;
  }

  current_num = 0;
  old_num = 0;
  selected = 0;
  [[func]](list[current_num]);

  while(true) {
    level waittill("menu_button_pressed", key);

    if(any_button_hit(key, "numbers")) {
      break;
    } else if(key == "downarrow" || key == "dpad_down") {
      if(current_num >= hud_array.size - 1) {
        continue;
      }
      current_num++;
      move_list_menu(hud_array, "down", 15, current_num);
    } else if(key == "uparrow" || key == "dpad_up") {
      if(current_num <= 0) {
        continue;
      }
      current_num--;
      move_list_menu(hud_array, "up", 15, current_num);
    } else if(key == "enter" || key == "button_a") {
      selected = 1;
      break;
    }

    level notify("scroll_list");

    if(current_num != old_num) {
      old_num = current_num;
      [
        [func]
      ](list[current_num]);
    }
  }

  for(i = 0; i < hud_array.size; i++)
    hud_array[i] destroy();

  if(selected)
    return current_num;
}

move_list_menu(hud_array, dir, space, num) {
  if(dir == "up")
    movement = space;
  else
    movement = space * -1;

  for(i = 0; i < hud_array.size; i++) {
    hud_array[i] moveovertime(0.1);
    hud_array[i].y = hud_array[i].y + movement;
    temp = i - num;

    if(temp < 0)
      temp = temp * -1;

    alpha = 1 / (temp + 1);

    if(alpha < 0.2)
      alpha = 0.1;

    hud_array[i] fadeovertime(0.1);
    hud_array[i].alpha = alpha;
  }

}

hud_selector(x, y) {
  level endon("stop_createdynents");

  if(isDefined(level.hud_selector))
    level thread hud_selector_fade_out();

  level.menu_cursor.alpha = 0;
  level.hud_selector = set_hudelem(undefined, x - 10, y, 1);
  level.hud_selector setshader("white", 125, 20);
  level.hud_selector.color = (1, 1, 0.5);
  level.hud_selector.alpha = 0.5;
  level.hud_selector.sort = 10;
}

hud_selector_fade_out(time) {
  level endon("stop_createdynents");

  if(!isDefined(time))
    time = 0.25;

  level.menu_cursor.alpha = 0.5;
  hud = level.hud_selector;
  level.hud_selector = undefined;
  hud fadeovertime(time);
  hud.alpha = 0;
  wait(time + 0.1);
  hud destroy();
}

selection_error(msg, x, y) {
  level endon("stop_createdynents");
  hud = set_hudelem(undefined, x - 10, y, 1);
  hud setshader("white", 110, 20);
  hud.color = vectorscale((1, 0, 0), 0.5);
  hud.alpha = 0.7;
  error_hud = set_hudelem(msg, x + 110, y, 1);
  error_hud.color = (1, 0, 0);
  hud fadeovertime(3);
  hud.alpha = 0;
  error_hud fadeovertime(3);
  error_hud.alpha = 0;
  wait 3.1;
  hud destroy();
  error_hud destroy();
}

hud_font_scaler(mult) {
  level endon("stop_createdynents");
  self notify("stop_fontscaler");
  self endon("death");
  self endon("stop_fontscaler");
  og_scale = self.og_scale;

  if(!isDefined(mult))
    mult = 1.5;

  self.fontscale = og_scale * mult;
  dif = og_scale - self.fontscale;
  dif = dif / (1 * 20);

  for(i = 0; i < 1 * 20; i++) {
    self.fontscale = self.fontscale + dif;
    wait 0.05;
  }

}

update_selected_object_position() {
  object = level.selected_object;

  if(isDefined(object)) {
    forward = anglestoforward(level.debug_player getplayerangles());
    vector = level.debug_player geteye() + vectorscale(forward, 5000);
    trace = bullettrace(level.debug_player geteye(), vector, 0, self);

    if(trace["fraction"] != 1) {
      vector = trace["position"] + (0, 0, level.selected_object_z_offset);

      if(vector != object.origin) {
        object moveto(vector, 0.1);
        object waittill("movedone");
      }
    }

    wait 0.1;
  }

}

move_selected_object(with_trace) {
  level endon("stop_createdynents");
  self notify("stop_move_selected_object");
  self endon("stop_move_selected_object");
  self endon("unlink_selected_object");
  self endon("death");

  if(!isDefined(with_trace))
    with_trace = 0;

  while(true) {
    forward = anglestoforward(level.debug_player getplayerangles());

    if(with_trace) {
      vector = level.debug_player geteye() + vectorscale(forward, 5000);
      trace = bullettrace(level.debug_player geteye(), vector, 0, self);

      if(trace["fraction"] == 1) {
        wait 0.1;
        continue;
      } else
        vector = trace["position"];

      vector = vector + (0, 0, level.selected_object_z_offset);
    } else
      vector = level.debug_player geteye() + vectorscale(forward, level.selected_object_dist);

    if(vector != self.origin) {
      self moveto(vector, 0.1);
      self waittill("movedone");
    } else
      wait 0.1;
  }

}

get_random_model() {
  count = level.groups[level.selected_group].size;
  return level.groups[level.selected_group][randomintrange(0, count)];
}

spray_model() {
  level.spray = [];

  if(isDefined(level.selected_object) && !isDefined(level.selected_group)) {
    level.spray = [];
    level.spray["model"] = level.selected_object.model;
    level.selected_object delete();
  } else if(isDefined(level.selected_group)) {
    level.spray = [];
    level.spray["model"] = get_random_model();

    if(isDefined(level.selected_object)) {
      level.selected_object delete();
      level.selected_object = undefined;
    }
  } else
    return "ERROR: Select Model or Group first!";

  level.spray["rate"] = 0.25;
  level.spray["power"] = 1000;
  spray_buttons();
  spray_hud();
  level thread spray_trajectory();

  while(true) {
    level waittill("spray_button_pressed", key);

    if(key == "fire") {
      do_spray_model();

      if(isDefined(level.selected_group)) {
        level.spray["model"] = get_random_model();
        level.spray_hud["model"] settext(level.spray["model"]);
        level.spray_hud["model"] thread hud_font_scaler();
      }

      wait(level.spray["rate"] - 0.1);
    } else if(key == "uparrow" || key == "dpad_up") {
      level.spray["power"] = level.spray["power"] + 50;

      if(level.spray["power"] > 5000)
        level.spray["power"] = 5000;

      level.spray_hud["power"] settext(level.spray["power"]);
      level.spray_hud["power"] thread hud_font_scaler();
      wait 0.05;
    } else if(key == "downarrow" || key == "dpad_down") {
      level.spray["power"] = level.spray["power"] - 50;

      if(level.spray["power"] < 50)
        level.spray["power"] = 50;

      level.spray_hud["power"] settext(level.spray["power"]);
      level.spray_hud["power"] thread hud_font_scaler();
      wait 0.05;
    } else if(key == "leftarrow" || key == "dpad_left") {
      level.spray["rate"] = level.spray["rate"] - 0.05;

      if(level.spray["rate"] < 0.25)
        level.spray["rate"] = 0.25;

      level.spray_hud["rate"] settext(level.spray["rate"]);
      level.spray_hud["rate"] thread hud_font_scaler();
      wait 0.05;
    } else if(key == "rightarrow" || key == "dpad_right") {
      level.spray["rate"] = level.spray["rate"] + 0.05;

      if(level.spray["rate"] > 1)
        level.spray["rate"] = 1;

      level.spray_hud["rate"] settext(level.spray["rate"]);
      level.spray_hud["rate"] thread hud_font_scaler();
      wait 0.05;
    } else if(key == "button_lshldr" || key == "button_rshldr") {
      if(isDefined(level.selected_group)) {
        level.spray["model"] = get_random_model();
        level.spray_hud["model"] settext(level.spray["model"]);
        level.spray_hud["model"] thread hud_font_scaler();
        wait 0.05;
      }
    } else if(key == "end" || key == "button_b") {
      break;
    }
  }

  level notify("stop_spray");
  remove_hud("spray_hud");
}

do_spray_model() {
  forward = anglestoforward(level.debug_player getplayerangles());
  vector = level.debug_player geteye() + vectorscale(forward, 48);
  object = spawn("script_model", vector);
  object setmodel(level.spray["model"]);
  velocity = vectorscale(forward, level.spray["power"]);
  object physicslaunch(object.origin, velocity);
  object store_model("dynent");
}

spray_trajectory() {
  level endon("stop_createdynents");
  level endon("stop_spray");
  time_inc = 1.0 / 10;
  og_time_inc = time_inc;

  while(true) {
    time_inc = og_time_inc;
    forward = anglestoforward(level.debug_player getplayerangles());
    velocity = vectorscale(forward, level.spray["power"]);
    sub_vel = vectorscale(velocity, time_inc);
    start_pos = level.debug_player geteye() + vectorscale(forward, 48);
    gravity = getdvarint(#"bg_gravity");

    for(i = 1; i < 10 + 1; i++) {
      pos = start_pos + vectorscale(sub_vel, i);
      pos = pos - (0, 0, 0.5 * gravity * (time_inc * time_inc));
      print3d(pos, ".", (1, 1, 0));
      time_inc = time_inc + og_time_inc;
    }

    wait 0.05;
  }

}

spray_hud() {
  level.spray_hud = [];
  hud = new_hud("spray_hud", undefined, 0, 400, 1);
  hud setshader("white", 145, 58);
  hud.alignx = "left";
  hud.aligny = "top";
  hud.sort = 10;
  hud.alpha = 0.6;
  hud.color = vectorscale((0, 0, 1), 0.5);
  hud = new_hud("spray_hud", "Model:", 319, 385, 1.2);
  hud.alignx = "right";
  level.spray_hud["model"] = new_hud("spray_hud", level.spray["model"], 321, 385, 1.2);
  level.spray_hud["model"].alignx = "left";
  hud = new_hud("spray_hud", "Rate:", 319, 400, 1.2);
  hud.alignx = "right";
  level.spray_hud["rate"] = new_hud("spray_hud", level.spray["rate"], 321, 400, 1.2);
  level.spray_hud["rate"].alignx = "left";
  hud = new_hud("spray_hud", "Power:", 319, 415, 1.2);
  hud.alignx = "right";
  level.spray_hud["power"] = new_hud("spray_hud", level.spray["power"], 321, 415, 1.2);
  level.spray_hud["power"].alignx = "left";
  new_hud("spray_hud", "FIRE", 0 + 5, 400 + 10, 1);
  new_hud("spray_hud", "LEFT/RIGHT", 0 + 5, 400 + 20, 1);
  new_hud("spray_hud", "UP/DOWN", 0 + 5, 400 + 30, 1);

  if(isDefined(level.selected_group)) {
    new_hud("spray_hud", "Bumpers", 0 + 5, 400 + 40, 1);
    new_hud("spray_hud", "B", 0 + 5, 400 + 50, 1);
  } else
    new_hud("spray_hud", "B", 0 + 5, 400 + 40, 1);

  new_hud("spray_hud", "- Spray Object", 0 + 60, 400 + 10, 1);
  new_hud("spray_hud", "- Inc/Dec Rate", 0 + 60, 400 + 20, 1);
  new_hud("spray_hud", "- Inc/Dec Power", 0 + 60, 400 + 30, 1);

  if(isDefined(level.selected_group)) {
    new_hud("spray_hud", "- Change model", 0 + 60, 400 + 40, 1);
    new_hud("spray_hud", "- Quit", 0 + 60, 400 + 50, 1);
  } else
    new_hud("spray_hud", "- Quit", 0 + 60, 400 + 40, 1);
}

spray_buttons() {
  clear_universal_buttons("spray");
  add_universal_button("spray", "dpad_up");
  add_universal_button("spray", "dpad_down");
  add_universal_button("spray", "dpad_left");
  add_universal_button("spray", "dpad_right");
  add_universal_button("spray", "button_b");
  add_universal_button("spray", "button_lshldr");
  add_universal_button("spray", "button_rshldr");
  level thread universal_input_loop("spray", "stop_spray", 1);
}

add_universal_button(button_group, name) {
  if(!isDefined(level.u_buttons[button_group]))
    level.u_buttons[button_group] = [];

  if(check_for_dupes(level.u_buttons[button_group], name))
    level.u_buttons[button_group][level.u_buttons[button_group].size] = name;
}

clear_universal_buttons(button_group) {
  level.u_buttons[button_group] = [];
}

universal_input_loop(button_group, end_on, use_attackbutton, mod_button, no_mod_button) {
  level endon("stop_createdynents");
  level endon(end_on);

  if(!isDefined(use_attackbutton))
    use_attackbutton = 0;

  notify_name = button_group + "_button_pressed";
  buttons = level.u_buttons[button_group];
  level.u_buttons_disable[button_group] = 0;

  while(true) {
    if(level.u_buttons_disable[button_group]) {
      wait 0.05;
      continue;
    }

    if(isDefined(mod_button) && !level.debug_player buttonpressed(mod_button)) {
      wait 0.05;
      continue;
    } else if(isDefined(no_mod_button) && level.debug_player buttonpressed(no_mod_button)) {
      wait 0.05;
      continue;
    }

    if(use_attackbutton && level.debug_player attackbuttonpressed()) {
      level notify(notify_name, "fire");
      wait 0.15;
      continue;
    }

    for(i = 0; i < buttons.size; i++) {
      if(level.debug_player buttonpressed(buttons[i])) {
        level notify(notify_name, buttons[i]);
        wait 0.15;
        break;
      }
    }

    wait 0.05;
  }

}

disable_buttons(button_group) {
  level.u_buttons_disable[button_group] = 1;
}

enable_buttons(button_group) {
  wait 1;
  level.u_buttons_disable[button_group] = 0;
}

select_dynent_group() {
  level.dyn_ent_selected_group = undefined;
  y = level.menu_sys["current_menu"].options[0].y;

  if(!isDefined(level.dynent_groups)) {
    return;
  }
  arrow_hud = set_hudelem("-------->", 120, y, 1.3);
  selected = list_menu(level.dynent_groups, 180, y, 1.3, ::group_selected);

  if(!isDefined(selected))
    level notify("stop_select_group");
  else
    level.dyn_ent_selected_group = level.dynent_groups[selected];

  arrow_hud destroy();
}

group_selected(group_name) {
  level.selected_group = group_name;
}

remove_hud(hud_name) {
  if(!isDefined(level.hud_array[hud_name])) {
    return;
  }
  huds = level.hud_array[hud_name];

  for(i = 0; i < huds.size; i++)
    destroy_hud(huds[i]);

  level.hud_array[hud_name] = undefined;
}

new_hud(hud_name, msg, x, y, scale) {
  if(!isDefined(level.hud_array))
    level.hud_array = [];

  if(!isDefined(level.hud_array[hud_name]))
    level.hud_array[hud_name] = [];

  hud = set_hudelem(msg, x, y, scale);
  level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
  return hud;
}

object_highlight(objects) {
  level endon("stop_createdynents");
  level endon("stop_select_model");
  dot = 0.85;
  highlighted_object = undefined;
  forward = anglestoforward(level.debug_player getplayerangles());

  for(i = 0; i < objects.size; i++) {
    if(!isDefined(objects[i].select_scale))
      objects[i] select_icon_think();

    ent = objects[i];
    difference = vectornormalize(ent.origin - (level.debug_player.origin + vectorscale((0, 0, 1), 55.0)));
    newdot = vectordot(forward, difference);

    if(newdot < dot) {
      continue;
    }
    dot = newdot;
    highlighted_object = ent;
  }

  if(isDefined(highlighted_object)) {
    highlighted_object.select_scale = 3;
    highlighted_object.select_color = level.selected_color;
    level.highlighted_object = highlighted_object;

    for(i = 0; i < objects.size; i++) {
      if(objects[i] == highlighted_object) {
        continue;
      }
      objects[i].select_scale = 1;
      objects[i].select_color = level.unselected_color;
    }
  }

}

selected_delete(no_force_back) {
  if(isDefined(level.selected_object)) {
    level.selected_object remove_from_all_objects();
    level.selected_object remove_model("dynent");
    level.selected_object remove_model("destructible");
    level.selected_object remove_model("miscmodel");
    level.selected_object notify("unlink_selected_object");
    level.selected_object notify("stop_move");
    level.selected_object notify("stop_move_selected_object");
    level.selected_object delete();
    level.selected_object = undefined;

    if(!isDefined(no_force_back) || !no_force_back)
      level thread force_menu_back();
  }

}

selected_back() {
  if(isDefined(level.selected_object)) {
    if(isDefined(level.selected_object.old_origin)) {
      level.selected_object notify("unlink_selected_object");
      level.selected_object.origin = level.selected_object.old_origin;
      level thread force_menu_back();
      level.selected_object = undefined;
    } else
      selected_delete();
  } else
    level thread force_menu_back();
}

selected_save_highlight(key) {
  if(isDefined(level.highlighted_object)) {
    object = level.highlighted_object;

    if(isDefined(object.save_selected)) {
      object remove_highlighted();
      object.save_selected = 0;
      object notify("stop_save_highlight");
    } else {
      object add_highlighted();
      object.save_selected = 1;
      object thread save_highlight_loop();
    }

    wait 0.1;
  }

}

save_highlight_loop() {
  level endon("stop_createdynents");
  self endon("stop_save_highlight");

  while(true) {
    print3d(self.origin, "S", (0, 1, 0), 1);
    wait 0.05;
  }

}

add_highlighted() {
  level.highlighted[level.highlighted.size] = self;
}

remove_highlighted() {
  arrayremovevalue(level.highlighted, self);
}

selected_models_save_thread(type) {
  level endon("stop_createdynents");
  level waittill("disable selected_" + type + "_save_menu");

  for(i = 0; i < level.models[type].size; i++)
    level.models[type][i] remove_save_stat();
}

selected_dynent_save() {
  level.highlighted = [];
  level thread selected_models_save_thread("dynent");
}

selected_destructible_save() {
  level.highlighted = [];
  level thread selected_models_save_thread("destructible");
}

selected_miscmodel_save() {
  level.highlighted = [];
  level thread selected_models_save_thread("miscmodel");
}

remove_save_stat() {
  self notify("stop_save_highlight");
  self.save_selected = 0;
}

save_dynent_highlighted() {
  if(level.highlighted.size > 0)
    return save_master("Save Selected DynEnts?", "dynents_selected", level.highlighted, "dynent");
}

save_destructible_highlighted() {
  if(level.highlighted.size > 0)
    return save_master("Save Selected Destructibles?", "detructibles_selected", level.highlighted, "destructible");
}

save_miscmodel_highlighted() {
  if(level.highlighted.size > 0)
    return save_master("Save Selected Misc_Models?", "miscmodels_selected", level.highlighted, "miscmodel");
}

setup_menu_buttons() {
  clear_universal_buttons("menu");
  menu_cursor();
  add_universal_button("menu", "dpad_up");
  add_universal_button("menu", "dpad_down");
  add_universal_button("menu", "dpad_left");
  add_universal_button("menu", "dpad_right");
  add_universal_button("menu", "button_a");
  add_universal_button("menu", "button_b");
  add_universal_button("menu", "1");
  add_universal_button("menu", "2");
  add_universal_button("menu", "3");
  add_universal_button("menu", "4");
  add_universal_button("menu", "5");
  add_universal_button("menu", "6");
  add_universal_button("menu", "7");
  add_universal_button("menu", "8");
  add_universal_button("menu", "9");
  add_universal_button("menu", "0");
  add_universal_button("menu", "downarrow");
  add_universal_button("menu", "uparrow");
  add_universal_button("menu", "leftarrow");
  add_universal_button("menu", "rightarrow");
  add_universal_button("menu", "enter");
  add_universal_button("menu", "end");
  add_universal_button("menu", "backspace");
  level thread universal_input_loop("menu", "never", undefined, undefined, "button_ltrig");
}

menu_cursor() {
  level.menu_cursor = set_hudelem(undefined, 0, 130, 1.3);
  level.menu_cursor setshader("white", 125, 20);
  level.menu_cursor.color = (1, 0.5, 0);
  level.menu_cursor.alpha = 0.5;
  level.menu_cursor.sort = 1;
  level.menu_cursor.current_pos = 0;
}

any_button_hit(button_hit, type) {
  buttons = [];

  if(type == "numbers") {
    buttons[0] = "0";
    buttons[1] = "1";
    buttons[2] = "2";
    buttons[3] = "3";
    buttons[4] = "4";
    buttons[5] = "5";
    buttons[6] = "6";
    buttons[7] = "7";
    buttons[8] = "8";
    buttons[9] = "9";
  } else
    buttons = level.buttons;

  for(i = 0; i < buttons.size; i++) {
    if(button_hit == buttons[i])
      return true;
  }

  return false;
}

setup_xform_menu() {
  level.selected_object_z_offset = 0;
  level.selected_object_dist = 48;
  setup_xform_buttons();
  level thread xform_input_handler();
  level.xform_hud_active = 0;
  toggle_xform_hud();
}

toggle_xform_hud() {
  level.xform_hud_active = !level.xform_hud_active;

  if(level.xform_hud_active) {
    x = 640 - 120;
    y = 480 - 90 - 25;
    hud = new_hud("xform_hud", undefined, x, y, 1);
    hud setshader("white", 120, 90);
    hud.alignx = "left";
    hud.aligny = "top";
    hud.sort = 10;
    hud.alpha = 0.6;
    hud.color = vectorscale((0, 0, 1), 0.5);
    new_hud("xform_hud", "BUMPERS", x + 5, y + 10, 1);
    new_hud("xform_hud", "Up / Down", x + 60, y + 10, 1);
    y = y + 3;
    new_hud("xform_hud", "(HOLD LTrigger) +", x + 5, y + 20, 1);
    y = y + 3;
    new_hud("xform_hud", "Y/A", x + 5, y + 30, 1);
    new_hud("xform_hud", "X/B", x + 5, y + 40, 1);
    new_hud("xform_hud", "BUMPERS", x + 5, y + 50, 1);
    new_hud("xform_hud", "L3", x + 5, y + 60, 1);
    new_hud("xform_hud", "- Pitch", x + 60, y + 30, 1);
    new_hud("xform_hud", "- Yaw", x + 60, y + 40, 1);
    new_hud("xform_hud", "- Roll", x + 60, y + 50, 1);
    new_hud("xform_hud", "- Zero Out", x + 60, y + 60, 1);
  } else
    remove_hud("xform_hud");
}

setup_xform_buttons() {
  clear_universal_buttons("xform");
  add_universal_button("xform", "button_a");
  add_universal_button("xform", "button_b");
  add_universal_button("xform", "button_x");
  add_universal_button("xform", "button_y");
  add_universal_button("xform", "button_lshldr");
  add_universal_button("xform", "button_rshldr");
  add_universal_button("xform", "button_lstick");
  level thread universal_input_loop("xform", "never", 1);
}

xform_input_handler() {
  level endon("stop_createdynents");

  while(true) {
    level waittill("xform_button_pressed", key);
    object = level.selected_object;

    if(!isDefined(object))
      object = level.highlighted_object;

    if(!level.debug_player buttonpressed("button_ltrig")) {
      if(key == "button_rshldr") {
        level.selected_object_z_offset = level.selected_object_z_offset + 4;
        update_selected_object_position();
      } else if(key == "button_lshldr") {
        level.selected_object_z_offset = level.selected_object_z_offset - 4;
        update_selected_object_position();
      }
    } else if(isDefined(object)) {
      if(key == "button_b")
        object devaddyaw(2);
      else if(key == "button_x")
        object devaddyaw(2 * -1);
      else if(key == "button_y")
        object devaddpitch(2 * -1);
      else if(key == "button_a")
        object devaddpitch(2);
      else if(key == "button_lshldr")
        object devaddroll(2 * -1);
      else if(key == "button_rshldr")
        object devaddroll(2);
      else if(key == "button_lstick")
        object.angles = (0, 0, 0);
    }

    wait 0.1;
  }

}

place(type) {
  if(isDefined(level.selected_object)) {
    level.selected_object notify("unlink_selected_object");
    level notify("stop_move");
    level.selected_object add_model(type);
    level.selected_object = undefined;
  }

}

place_copy(type) {
  if(isDefined(level.selected_object)) {
    level.selected_object notify("unlink_selected_object");

    if(type == "destructible")
      model_name = level.selected_object getdestructiblename();
    else
      model_name = level.selected_object.model;

    level.selected_object add_model(type);
    angles = level.selected_object.angles;
    level.selected_object = undefined;
    spawn_selected_object(model_name, 1, type);
    level.selected_object.angles = angles;
  }

}

place_dynent() {
  place("dynent");
}

place_destructible() {
  place("destructible");
}

place_miscmodel() {
  place("miscmodel");
}

place_dynent_copy() {
  place_copy("dynent");
}

place_destructible_copy() {
  place_copy("destructible");
}

place_miscmodel_copy() {
  place_copy("miscmodel");
}

select_dynent_from_list() {
  y = level.menu_sys["current_menu"].options[0].y;
  arrow_hud = set_hudelem("-------->", 120, y, 1.3);
  list_menu(level.model_names["dynent"], 180, y, 1.3, ::spawn_dynent);
  level.selected_group = undefined;
  arrow_hud destroy();
}

select_destructible_from_list() {
  y = level.menu_sys["current_menu"].options[0].y;
  arrow_hud = set_hudelem("-------->", 120, y, 1.3);
  list_menu(level.model_names["destructible"], 180, y, 1.3, ::spawn_destructible);
  level.selected_group = undefined;
  arrow_hud destroy();
}

select_miscmodel_from_list() {
  y = level.menu_sys["current_menu"].options[0].y;
  arrow_hud = set_hudelem("-------->", 120, y, 1.3);
  list_menu(level.model_names["miscmodel"], 180, y, 1.3, ::spawn_miscmodel);
  arrow_hud destroy();
}

spawn_selected_object(model_name, with_trace, type) {
  if(isDefined(level.selected_object))
    level.selected_object delete();

  forward = anglestoforward(level.debug_player getplayerangles());
  vector = level.debug_player geteye() + vectorscale(forward, level.selected_object_dist);

  if(isDefined(type) && type == "destructible")
    level.selected_object = codespawn("script_model", vector, 0, 0, 0, model_name);
  else {
    level.selected_object = spawn("script_model", vector);
    level.selected_object setmodel(model_name);
  }

  level.select_group = undefined;
  level.selected_object thread move_selected_object(with_trace);
}

spawn_dynent(model_name) {
  spawn_selected_object(model_name, 1, "dynent");
}

spawn_miscmodel(model_name) {
  spawn_selected_object(model_name, 1, "miscmodel");
}

spawn_destructible(model_name) {
  spawn_selected_object(model_name, 1, "destructible");
}

move_model() {
  if(isDefined(level.highlighted_object)) {
    level.selected_object = level.highlighted_object;
    level.selected_object.old_origin = level.selected_object.origin;
    level.selected_object thread move_selected_object(1);
    level thread move_model_thread();
  }

}

move_model_thread() {
  level endon("stop_createdynents");
  level waittill("stop_move");
  level thread force_menu_back();
}

copy_model(type) {
  if(isDefined(level.highlighted_object)) {
    model_origin = level.highlighted_object.origin;

    if(type == "destructible") {
      model_name = level.highlighted_object getdestructiblename();
      level.selected_object = codespawn("script_model", model_origin, 0, 0, 0, model_name);
    } else {
      model_name = level.highlighted_object.model;
      level.selected_object = spawn("script_model", model_origin);
      level.selected_object setmodel(model_name);
    }

    level.selected_object.old_origin = level.selected_object.origin;
    level.selected_object thread move_selected_object(1);
    level thread copy_thread();
  }

}

copy_dynent() {
  copy_model("dynent");
}

copy_destructible() {
  copy_model("destructible");
}

copy_miscmodel() {
  copy_model("miscmodel");
}

copy_thread() {
  level endon("stop_createdynents");
  level waittill("stop_move");
  level thread force_menu_back();
}

select_dynents() {
  select("dynent");
}

select_destructibles() {
  select("destructible");
}

select_miscmodels() {
  select("miscmodel");
}

select(type) {
  if(level.models[type].size > 0)
    level thread select_model_thread(type);
}

draw_selectables(objects) {
  for(i = 0; i < objects.size; i++)
    objects[i] thread select_icon_think();
}

select_icon_think() {
  level endon("stop_createdynents");
  self endon("death");
  self notify("only_one_icon_think_thread");
  self endon("only_one_icon_think_thread");
  level endon("stop_select_model");

  if(!isDefined(self.select_scale))
    self.select_scale = 1;

  self.select_color = level.unselected_color;

  while(true) {
    print3d(self.origin, ".", self.select_color, 1, self.select_scale);
    wait 0.05;
  }

}

delete_model() {
  if(isDefined(level.highlighted_object)) {
    level.highlighted_object remove_from_all_objects();
    level.highlighted_object remove_model("dynent");
    level.highlighted_object remove_model("destructible");
    level.highlighted_object remove_model("miscmodel");
    level.highlighted_object delete();
    level.selected_object = undefined;
  }

}

select_model_thread(type) {
  level endon("stop_createdynents");
  selected_delete(1);
  level.unselected_color = (1, 1, 1);
  level.selected_color = (1, 1, 0);
  draw_selectables(level.models[type]);
  level thread select_main_thread(type);
  level waittill("disable " + type + "_select_menu");
  level notify("stop_select_model");
}

select_main_thread(type) {
  level endon("stop_createdynents");
  level endon("stop_select_model");
  level.highlighted_object = undefined;
  level.selected_object = undefined;

  while(true) {
    if(!isDefined(level.selected_object))
      level thread object_highlight(level.models[type]);

    wait 0.05;
  }

}

set_default_path() {
  if(!isDefined(level.path))
    level.path = "prop_man/" + level.script + "/";
}

store_model(type) {
  self add_to_all_objects();
  level.models[type][level.models[type].size] = self;
}

remove_model(type) {
  arrayremovevalue(level.models[type], self);
}

save_dynents() {
  if(level.models["dynent"].size > 0)
    return save_master("Save All DynEnts?", "dynents_all", level.models["dynent"], "dynent");
}

save_destructibles() {
  if(level.models["destructible"].size > 0)
    return save_master("Save All Destructibles?", "destructibles_all", level.models["destructible"], "destructible");
}

save_miscmodels() {
  selected_delete(1);

  if(level.models["miscmodel"].size > 0)
    return save_master("Save All misc models?", "miscmodels_all", level.models["miscmodel"], "miscmodel");
}

save_master(save_msg, filename, save_array, type) {
  disable_buttons("menu");
  disable_buttons("rotate");
  disable_buttons("prop");
  level.debug_player freezecontrols(1);
  save_buttons();
  filename = filename + ".map";
  save_dialog(save_msg, filename);
  yes_key = "button_x";
  no_key = "button_b";

  while(true) {
    level waittill("save_button_pressed", key);

    if(key == yes_key) {
      level thread save_selector(level.save_yes_hud.x, level.save_yes_hud.y, 40);
      check = save(save_array, filename, type);

      if(isDefined(check) && check != "failed")
        level thread save_complete(check);
      else
        level thread save_failed();

      break;
    } else if(key == no_key) {
      save_selector(level.save_no_hud.x, level.save_no_hud.y, 40);
      break;
    }
  }

  level notify("stop_savebutton_loop");
  remove_hud("save");
  level.debug_player freezecontrols(0);
  level thread enable_buttons("menu");
  level thread enable_buttons("rotate");
  level thread enable_buttons("prop");
}

save_dialog(msg, filename) {
  if(!isDefined(level.save_hud_x))
    level.save_hud_x = 0;

  if(!isDefined(level.save_hud_y))
    level.save_hud_y = 300;

  x = level.save_hud_x;
  y = level.save_hud_y;
  hud = new_hud("save", undefined, x + 640 * 0.5, y, 1);
  hud setshader("white", 640, 100);
  hud.alignx = "center";
  hud.aligny = "top";
  hud.color = (0.55, 0.29, 0);
  hud.alpha = 0.85;
  hud.sort = 30;
  hud = new_hud("save", msg, x + 10, y + 10, 1.3);
  hud.sort = 35;
  prefix = "Path: xenonOutput/scriptdata/";
  hud = new_hud("save", prefix + level.path + filename, x + 10, y + 30, 1.1);
  hud.sort = 35;
  yes_hud = "Yes [X]";
  no_hud = "No [B]";
  level.save_yes_hud = new_hud("save", yes_hud, x + 640 * 0.5 - 50, y + 90, 1.3);
  level.save_yes_hud.alignx = "center";
  level.save_yes_hud.sort = 35;
  level.save_no_hud = new_hud("save", no_hud, x + 640 * 0.5 + 50, y + 90, 1.3);
  level.save_no_hud.alignx = "center";
  level.save_no_hud.sort = 35;
}

destroy_hud(hud) {
  if(isDefined(hud))
    hud destroy();
}

save_complete(msg) {
  hud = set_hudelem("Save Successful", 320, 100, 1.5);
  hud.alignx = "center";
  hud.color = (0, 1, 0);
  hud_msg = set_hudelem(msg, 320, 120, 1.3);
  hud_msg.alignx = "center";
  hud_msg.color = (1, 1, 1);
  wait 2;
  hud fadeovertime(3);
  hud.alpha = 0;
  hud_msg fadeovertime(3);
  hud_msg.alpha = 0;
  wait 3;
  hud destroy();
  hud_msg destroy();
}

save_failed() {
  hud = set_hudelem("Save Failed!", 320, 100, 1.5);
  hud.alignx = "center";
  hud.color = (1, 0, 0);
  wait 1;
  hud fadeovertime(3);
  hud.alpha = 0;
  wait 3;
  hud destroy();
}

save_selector(x, y, width) {
  hud = set_hudelem(undefined, x, y, 1);
  hud.alignx = "center";
  hud setshader("white", width, 20);
  hud.color = (1, 1, 0.5);
  hud.alpha = 0.5;
  hud.sort = 10;
  hud fadeovertime(0.25);
  hud.alpha = 0;
  wait 0.35;
  hud destroy();
}

save(model_array, filename, type) {
  level.fullpath_file = level.path + filename;

  if(!isDefined(type))
    type = "dynent";

  spawnflags = 0;

  if(type == "dynent")
    spawnflags = 1;

  file = openfile(level.fullpath_file, "write");
  assert(file != -1, "File not writeable (maybe you should check it out): " + level.fullpath_file);
  fprintln(file, "// entity 0");
  fprintln(file, "{");
  fprintln(file, "\"classname\" \"worldspawn\"");
  fprintln(file, "}");

  if(type == "dynent")
    classname = "dyn_model";
  else
    classname = "misc_model";

  for(i = 0; i < model_array.size; i++) {
    fprintln(file, "{");
    fprintln(file, "\"angles\" \"" + model_array[i].angles[0] + " " + model_array[i].angles[1] + " " + model_array[i].angles[2] + "\"");
    fprintln(file, "\"origin\" \"" + model_array[i].origin[0] + " " + model_array[i].origin[1] + " " + model_array[i].origin[2] + "\"");

    if(type == "destructible") {
      fprintln(file, "\"model\" \"" + model_array[i].model + "\"");
      fprintln(file, "\"classname\" \"script_model\"");
      ddef = model_array[i] getdestructiblename();
      fprintln(file, "\"destructibledef\" \"" + ddef + "\"");
    } else {
      fprintln(file, "\"model\" \"" + model_array[i].model + "\"");

      if(spawnflags == 1)
        fprintln(file, "\"spawnflags\" \"2\"");

      fprintln(file, "\"classname\" \"" + classname + "\"");
    }

    fprintln(file, "}");
    fprintln(file, "");
  }

  saved = closefile(file);
  assert(saved == 1, "File not saved (see above message?): " + level.fullpath_file);

  if(saved)
    return level.fullpath_file;
  else
    return "failed";
}

save_buttons() {
  clear_universal_buttons("save");
  add_universal_button("save", "button_x");
  add_universal_button("save", "button_b");
  level thread universal_input_loop("save", "stop_savebutton_loop");
}

quit() {
  if(level.xform_hud_active)
    toggle_xform_hud();

  level.hud_selector destroy();
  disable_menu("current_menu");
  level.menu_sys = [];
  adddebugcommand("set propman 0");
  wait 1;
  adddebugcommand("noclip");
  wait 1;
  thread main();
  level notify("stop_createdynents");
}