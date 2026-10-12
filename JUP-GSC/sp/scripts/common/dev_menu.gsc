/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\dev_menu.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace dev_menu;

function init_menus(x_override, y_override) {
  level.menu_sys = [];
  level.menu_sys["current_menu"] = spawnStruct();
  init_buttons();
  level thread menu_input();
  level.var_9763c66ad9c70c70 = ter_op(isDefined(x_override), x_override, 20);
  level.var_9763c76ad9c70ea3 = ter_op(isDefined(y_override), y_override, 300);
  level.var_714fd3e7aed16e9b = level.var_9763c66ad9c70c70 + 250;
}

function add_menu(menu_name, title, can_exit) {
  if(menu_exists(menu_name)) {
    println("<dev string:x1c>" + menu_name + "<dev string:x2f>");
    return;
  }

  level.menu_sys[menu_name] = spawnStruct();
  level.menu_sys[menu_name].title = title;
  level.menu_sys[menu_name].page = 0;
  level.menu_sys[menu_name].can_exit = istrue(can_exit);
}

function menu_exists(menu_name) {
  return isDefined(level.menu_sys) && isDefined(level.menu_sys[menu_name]);
}

function add_menuoptions(menu_name, option_text, func, back_func, value) {
  if(!isDefined(level.menu_sys[menu_name].options)) {
    level.menu_sys[menu_name].options = [];
    level.menu_sys[menu_name].optionsvalue = [];
  }

  num = level.menu_sys[menu_name].options.size;
  level.menu_sys[menu_name].options[num] = option_text;
  level.menu_sys[menu_name].function[num] = func;
  level.menu_sys[menu_name].backfunction[num] = back_func;

  if(isDefined(value)) {
    level.menu_sys[menu_name].optionsvalue[num] = value;
  }
}

function function_cb4fdb2b85ea70b6(menu_name, option_text, amount, value) {
  if(!isDefined(level.menu_sys[menu_name].options)) {
    level.menu_sys[menu_name].options = [];
    level.menu_sys[menu_name].optionsvalue = [];
  }

  num = level.menu_sys[menu_name].options.size;
  level.menu_sys[menu_name].options[num] = option_text;
  level.menu_sys[menu_name].iterator[num] = amount;

  if(isDefined(value)) {
    level.menu_sys[menu_name].optionsvalue[num] = value;
  }
}

function add_menuent(menu_name, ent) {
  level.menu_sys[menu_name].ent = ent;
}

function add_menu_child(parent_menu, child_menu, child_title, child_number_override, func) {
  if(!isDefined(level.menu_sys[child_menu])) {
    add_menu(child_menu, child_title);
  }

  level.menu_sys[child_menu].parent_menu = parent_menu;

  if(!isDefined(level.menu_sys[parent_menu].children_menu)) {
    level.menu_sys[parent_menu].children_menu = [];
  }

  if(!isDefined(child_number_override)) {
    size = level.menu_sys[parent_menu].children_menu.size;
  } else {
    size = child_number_override;
  }

  level.menu_sys[parent_menu].children_menu[size] = child_menu;

  if(isDefined(func)) {
    if(!isDefined(level.menu_sys[parent_menu].children_func)) {
      level.menu_sys[parent_menu].children_func = [];
    }

    level.menu_sys[parent_menu].children_func[size] = func;
  }
}

function enable_menu(menu_name) {
  disable_menu("current_menu");

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor.current_pos = 0;
    menu_cursor_resetpos();
  }

  level.menu_sys["current_menu"].title = set_menu_hudelem(level.menu_sys[menu_name].title, "title");
  level.menu_sys["current_menu"].menu_name = menu_name;

  if(isDefined(level.menu_sys[menu_name].options)) {
    draw_menu_options(menu_name);
  }

  if(isDefined(level.menu_sys[menu_name].ent)) {
    level.menu_sys["current_menu"].ent = level.menu_sys[menu_name].ent;
  }

  menu_cursor();
  menu_highlight("current_menu", level.menu_cursor.current_pos);
}

function exit_menu() {
  level notify("exit_menu");
  level.exitmenu = 1;
}

function draw_menu_options(menu_name) {
  options = level.menu_sys[menu_name].options;
  page = level.menu_sys[menu_name].page;

  for(i = 0; i < 20 && i + page * 20 < options.size; i++) {
    actual_index = i + page * 20;
    text = actual_index + 1 + ". " + options[actual_index];
    level.menu_sys["current_menu"].options[i] = set_menu_hudelem(text, "options", int(25) * i);

    if(isDefined(level.menu_sys[menu_name].optionsvalue[actual_index])) {
      val = level.menu_sys[menu_name].optionsvalue[actual_index];
      hud = set_menu_hudelem(val, "value", int(25) * i);
      hud.x += int(level.var_714fd3e7aed16e9b);
      level.menu_sys["current_menu"].optionsvalue[i] = hud;
    }
  }

  if(options.size > 20) {
    text = "";

    if(page > 0) {
      text += "<-- Prev ";
    }

    if(page < floor(options.size / 20)) {
      text += "Next -->";
    }

    if(text != "") {
      level.menu_sys["current_menu"].options[i] = set_menu_hudelem(text, "options", int(25) * i);
      i++;
    }
  }

  if(level.menu_sys[menu_name].can_exit) {
    level.menu_sys["current_menu"].options[i] = set_menu_hudelem("Exit", "options", int(25) * i);
  }
}

function disable_menu(menu_name) {
  level notify("stop_all_menus");

  if(isDefined(level.menu_sys[menu_name])) {
    if(isDefined(level.menu_sys[menu_name].title)) {
      level.menu_sys[menu_name].title scripthuddestroy();
    }

    if(isDefined(level.menu_sys[menu_name].options)) {
      clear_menu_options(menu_name);
    }
  }

  level.menu_sys[menu_name].title = undefined;
  level.menu_sys[menu_name].menu_name = undefined;
  level.menu_sys[menu_name].ent = undefined;

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor scripthuddestroy();
  }
}

function clear_menu_options(menu_name) {
  options = level.menu_sys[menu_name].options;

  for(i = 0; i < options.size; i++) {
    if(isDefined(options[i].extrahuds)) {
      foreach(extrahud in options[i].extrahuds) {
        if(isDefined(extrahud)) {
          extrahud scripthuddestroy();
        }
      }
    }

    options[i] scripthuddestroy();

    if(!isDefined(level.menu_sys[menu_name].optionsvalue)) {
      continue;
    }

    if(isDefined(level.menu_sys[menu_name].optionsvalue[i])) {
      level.menu_sys[menu_name].optionsvalue[i] scripthuddestroy();
    }
  }

  level.menu_sys[menu_name].options = [];

  if(isDefined(level.menu_sys[menu_name].optionsvalue)) {
    level.menu_sys[menu_name].optionsvalue = [];
  }
}

function destroy_menu(menu_name) {
  level.menu_sys[menu_name] = undefined;
}

function set_menu_hudelem(text, type, y_offset) {
  x = level.var_9763c66ad9c70c70;
  y = level.var_9763c76ad9c70ea3;

  if(type == "title") {
    scale = 1.375;
  } else {
    scale = 1.25;
    y += int(25);
  }

  if(!isDefined(y_offset)) {
    y_offset = 0;
  }

  y += y_offset;
  return set_scripthud(text, x, y, scale);
}

function set_hudelem(text, x, y, scale, alpha, sort) {
  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(sort)) {
    sort = 20;
  }

  hud = newhudelem();
  hud.location = 0;
  hud.alignx = "left";
  hud.aligny = "bottom";
  hud.vertalign = "fullscreen";
  hud.horzalign = "fullscreen";
  hud.foreground = 1;
  hud.fontscale = scale;
  hud.sort = sort;
  hud.alpha = alpha;
  hud.x = x;
  hud.y = y;
  hud.og_scale = scale;
  hud.archived = 0;

  if(isDefined(text)) {
    hud.text = text;

    if(isnumber(text)) {
      hud setvalue(text);
    } else {
      hud setdevtext(text);

      hud clearalltextafterhudelem();
    }
  }

  return hud;
}

function set_scripthud(text, x, y, scale, alpha) {
  if(!isDefined(scale)) {
    scale = 2;
  }

  hud = newscripthud();
  hud.x = x;
  hud.y = y;
  hud.scale = scale;

  if(isDefined(text)) {
    hud.text = text;
  }

  if(isDefined(alpha)) {
    r = math::lerp(hud.color[0] * 0.6, hud.color[0], alpha);
    g = math::lerp(hud.color[1] * 0.6, hud.color[1], alpha);
    b = math::lerp(hud.color[2] * 0.6, hud.color[2], alpha);
    hud.color = (r, g, b);
  }

  return hud;
}

function newscripthud() {
  struct = spawnStruct();
  struct.x = 0;
  struct.y = 0;
  struct.text = "";
  struct.color = (1, 1, 1);
  struct.scale = 2;
  struct.isscripted = 1;
  struct.alive = 1;
  struct thread scripthudthread();
  return struct;
}

function scripthudthread() {
  while(self.alive) {
    printtoscreen2d(self.x, self.y, self.text, self.color, self.scale);
    waitframe();
  }
}

function scripthuddestroy() {
  if(!istrue(self.isscripted)) {
    self destroy();
    return;
  }

  self.alive = 0;
}

function newscriptcursor(x, y) {
  struct = spawnStruct();
  struct.x = x;
  struct.y = y;
  struct.text = ">";
  struct.color = (1, 0, 0);
  struct.scale = 2;
  struct.isscripted = 1;
  struct.alive = 1;
  struct thread scripthudthread();
  return struct;
}

function menu_input() {
  while(true) {
    level waittill("menu_button_pressed", keystring);

    if(!isDefined(level.menu_cursor) || isDefined(level.debug.debug_start) && level.debug.debug_start) {
      wait 0.1;
      continue;
    }

    menu_name = level.menu_sys["current_menu"].menu_name;

    if(!isDefined(menu_name) || !isDefined(level.menu_sys[menu_name]) || !isDefined(level.menu_sys[menu_name].title)) {
      continue;
    }

    modifiers["shift"] = 0;
    modifiers["ctrl"] = 0;
    modifiers["alt"] = 0;

    if(keystring == "dpad_up" || keystring == "uparrow") {
      if(level.menu_cursor.current_pos > 0) {
        level.menu_cursor.y -= int(25);
        level.menu_cursor.current_pos--;
      } else if(level.menu_cursor.current_pos == 0) {
        level.menu_cursor.y += (level.menu_sys["current_menu"].options.size - 1) * int(25);
        level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - 1;
      }

      menu_highlight("current_menu", level.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(keystring == "dpad_down" || keystring == "downarrow") {
      if(level.menu_cursor.current_pos < level.menu_sys["current_menu"].options.size - 1) {
        level.menu_cursor.y += int(25);
        level.menu_cursor.current_pos++;
      } else if(level.menu_cursor.current_pos == level.menu_sys["current_menu"].options.size - 1) {
        level.menu_cursor.y += level.menu_cursor.current_pos * int(25) * -1;
        level.menu_cursor.current_pos = 0;
      }

      menu_highlight("current_menu", level.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(keystring == "button_a" || keystring == "dpad_right" || keystring == "dpad_left" || keystring == "rightarrow" || keystring == "leftarrow") {
      if(keystring == "dpad_left" || keystring == "leftarrow") {
        modifiers["shift"] = 1;
      }

      key = level.menu_cursor.current_pos;
    } else if(keystring == "button_b") {
      exit_menu();
      continue;
    } else {
      key = int(keystring) - 1;
    }

    if(level.player buttonPressed("lshift") || level.player buttonPressed("rshift")) {
      modifiers["shift"] = 1;
    }

    if(level.menu_sys[menu_name].can_exit) {
      page_offset = 2;
    } else {
      page_offset = 1;
    }

    if(key >= level.menu_sys["current_menu"].options.size) {
      continue;
    } else if(level.menu_sys[menu_name].can_exit && key == level.menu_sys["current_menu"].options.size - 1) {
      exit_menu();
      continue;
    } else if(level.menu_sys[menu_name].options.size > 20 && key == level.menu_sys["current_menu"].options.size - page_offset) {
      newpage = 0;

      if(modifiers["shift"] && level.menu_sys[menu_name].page > 0) {
        level.menu_sys[menu_name].page--;
        newpage = 1;
      } else if(!modifiers["shift"] && level.menu_sys[menu_name].page < floor(level.menu_sys[menu_name].options.size / 20)) {
        level.menu_sys[menu_name].page++;
        newpage = 1;
      }

      if(newpage) {
        old_size = level.menu_sys["current_menu"].options.size;
        clear_menu_options("current_menu");
        draw_menu_options(menu_name);

        if(level.menu_sys["current_menu"].options.size != old_size) {
          level.menu_cursor.y = level.var_9763c76ad9c70ea3 + (level.menu_sys["current_menu"].options.size - page_offset + 1) * int(25);
          level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - page_offset;
        }
      }

      continue;
    } else {
      menu_key = key;
      key += level.menu_sys[menu_name].page * 20;
    }

    if(isDefined(level.menu_sys[menu_name].parent_menu) && key == level.menu_sys[menu_name].options.size) {
      level notify("disable " + menu_name);
      level enable_menu(level.menu_sys[menu_name].parent_menu);
    } else if(isDefined(level.menu_sys[menu_name].function) && isDefined(level.menu_sys[menu_name].function[key])) {
      func = undefined;

      if(!modifiers["shift"]) {
        func = level.menu_sys[menu_name].function[key];
      } else if(isDefined(level.menu_sys[menu_name].backfunction)) {
        func = level.menu_sys[menu_name].backfunction[key];
      }

      if(isDefined(func)) {
        ent = level;

        if(isDefined(level.menu_sys["current_menu"].ent)) {
          ent = level.menu_sys["current_menu"].ent;
        }

        msg = ent[[func]]();

        if(isDefined(msg)) {
          function_fab54f8bf1f33485(menu_key, msg);
        }
      }
    } else if(isDefined(level.menu_sys[menu_name].iterator) && isDefined(level.menu_sys[menu_name].iterator[key])) {
      if(!modifiers["shift"]) {
        value = level.menu_sys[menu_name].optionsvalue[key] + level.menu_sys[menu_name].iterator[key];
      } else {
        value = level.menu_sys[menu_name].optionsvalue[key] - level.menu_sys[menu_name].iterator[key];
      }

      level.menu_sys[menu_name].optionsvalue[key].text = value;
      level.menu_sys[menu_name].optionsvalue[key] setvalue(value);
    }

    if(!isDefined(level.menu_sys[menu_name].children_menu)) {
      continue;
    } else if(!isDefined(level.menu_sys[menu_name].children_menu[key])) {
      println("<dev string:x57>" + menu_name + "<dev string:x5b>" + key + "<dev string:x79>");
      continue;
    } else if(!isDefined(level.menu_sys[level.menu_sys[menu_name].children_menu[key]])) {
      println("<dev string:x57>" + level.menu_sys[menu_name].options[key] + "<dev string:x8a>");
      continue;
    }

    if(isDefined(level.menu_sys[menu_name].children_func) && isDefined(level.menu_sys[menu_name].children_func[key])) {
      func = level.menu_sys[menu_name].children_func[key];
      error_msg = [[func]]();

      if(isDefined(error_msg)) {
        level thread selection_error(error_msg, level.menu_sys["current_menu"].options[menu_key].x, level.menu_sys["current_menu"].options[menu_key].y);
        continue;
      }
    }

    level enable_menu(level.menu_sys[menu_name].children_menu[key]);
    wait 0.1;
  }
}

function menu_highlight(menu_name, index) {
  foreach(hud in level.menu_sys[menu_name].options) {
    hud.color = (1, 1, 1);
  }

  if(isDefined(level.menu_sys[menu_name].optionsvalue)) {
    foreach(hud in level.menu_sys[menu_name].optionsvalue) {
      hud.color = (1, 1, 1);
    }
  }

  if(isDefined(level.menu_sys[menu_name].optionsvalue) && isDefined(level.menu_sys[menu_name].optionsvalue[index])) {
    level.menu_sys[menu_name].optionsvalue[index].color = (1, 1, 0);
  }

  level.menu_sys[menu_name].options[index].color = (1, 1, 0);
}

function hud_selector(x, y) {}

function hud_selector_fade_out(time) {}

function menu_get_selected_optionsvalue(val) {
  if(!isDefined(val)) {
    val = level.menu_cursor.current_pos;
  }

  return level.menu_sys["current_menu"].optionsvalue[val];
}

function function_fab54f8bf1f33485(optionskey, newvalue) {
  if(!isDefined(level.menu_sys["current_menu"].optionsvalue[optionskey])) {
    return;
  }

  level.menu_sys["current_menu"].optionsvalue[optionskey].text = newvalue;

  if(isDefined(level.menu_sys["current_menu"].optionsvalue[optionskey].isscripted)) {
    level.menu_sys["current_menu"].optionsvalue[optionskey].text = newvalue;
    return;
  }

  if(isnumber(newvalue)) {
    level.menu_sys["current_menu"].optionsvalue[optionskey] setvalue(newvalue);
    return;
  }

  level.menu_sys["<dev string:xa4>"].optionsvalue[optionskey] setdevtext(newvalue);

  level.menu_sys["current_menu"].optionsvalue[optionskey] clearalltextafterhudelem();
}

function get_current_menu_name() {
  return level.menu_sys["current_menu"].menu_name;
}

function menu_get_selected(val) {
  if(!isDefined(val)) {
    val = level.menu_cursor.current_pos;
  }

  return level.menu_sys["current_menu"].options[val];
}

function menu_get_selected_text() {
  val = level.menu_cursor.current_pos;
  return level.menu_sys["current_menu"].options[val].text;
}

function selection_error(msg, x, y) {
  hud = set_hudelem(undefined, x - 10, y, 1);
  hud setshader("white", int(level.var_714fd3e7aed16e9b), 20);
  hud.color = (0.5, 0, 0);
  hud.alpha = 0.7;
  error_hud = set_hudelem(msg, x + int(level.var_714fd3e7aed16e9b), y, 1);
  error_hud.color = (1, 0, 0);

  if(!isDefined(hud.debug_hudelem)) {
    hud fadeovertime(3);
  }

  hud.alpha = 0;

  if(!isDefined(error_hud.debug_hudelem)) {
    error_hud fadeovertime(3);
  }

  error_hud.alpha = 0;
  wait 3.1;
  hud destroy();
  error_hud destroy();
}

function menu_cursor() {
  level.menu_cursor = newscriptcursor(0, level.var_9763c76ad9c70ea3 + int(25));
  level.menu_cursor.current_pos = 0;
  menu_cursor_resetpos();
}

function menu_cursor_resetpos() {
  level.menu_cursor.x = 0;
  level.menu_cursor.y = level.var_9763c76ad9c70ea3 + int(25) + 6;
}

function add_extrahuds(hud) {
  if(!isDefined(self.extrahuds)) {
    self.extrahuds = [];
  }

  self.extrahuds[self.extrahuds.size] = hud;
}

function list_menu(list, x, y, func, sort, start_num) {
  level endon("stop_all_menus");
  menu = menu_get_selected();

  if(!isDefined(list) || list.size == 0) {
    return -1;
  }

  hud_array = [];
  space_apart = 25;
  arrow = set_scripthud("->", x - 20, y, 1.25, 1);
  arrow.color = (1, 0, 0);
  menu add_extrahuds(arrow);

  if(utility::issp()) {
    max_items = 5;
    y_offset = 2;
  } else {
    max_items = 3;
    y_offset = 1;
  }

  if(list.size < max_items) {
    max_items = list.size;
    y_offset = int(max_items * 0.5);
  }

  for(i = 0; i < max_items; i++) {
    if(i == 0) {
      alpha = 0.3;
    } else if(i == 1) {
      alpha = 0.6;
    } else if(i == 2) {
      alpha = 1;
    } else if(i == 3) {
      alpha = 0.6;
    } else {
      alpha = 0.3;
    }

    hud = set_scripthud(list[i], x, y + (i - y_offset) * space_apart, 1.25, alpha);

    if(!isDefined(level.tempstruct)) {
      level.tempstruct = [];
    }

    level.tempstruct[level.tempstruct.size] = hud;
    menu add_extrahuds(hud);
    hud_array = array_add(hud_array, hud);
  }

  current_num = 0;
  old_num = 0;
  selected = 0;
  level.menu_list_selected = 0;

  if(isDefined(start_num)) {
    move_list_menu(hud_array, list, start_num, y_offset);
    current_num = start_num;
    old_num = start_num;
  } else {
    move_list_menu(hud_array, list, 0, y_offset);
  }

  if(isDefined(func)) {
    [[func]](list[current_num]);
  }

  while(true) {
    level waittill("menu_button_pressed", key);

    if(!isDefined(level.menu_cursor)) {
      selected = 0;
      break;
    }

    level.menu_list_selected = 1;

    if(any_button_hit(key, "numbers")) {
      break;
    } else if(key == "downarrow" || key == "dpad_down") {
      if(current_num >= list.size - 1) {
        current_num = 0;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num++;
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "uparrow" || key == "dpad_up") {
      if(current_num <= 0) {
        current_num = list.size - 1;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num--;
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "pgup") {
      if(current_num <= 0) {
        current_num = list.size - 1;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num -= 5;
      current_num = clamp(current_num, 0, list.size - 1);
      current_num = int(current_num);
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "pgdn") {
      if(current_num >= list.size - 1) {
        current_num = 0;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num += 5;
      current_num = clamp(current_num, 0, list.size - 1);
      current_num = int(current_num);
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "enter" || key == "button_a" || key == "dpad_right") {
      selected = 1;
      break;
    } else if(key == "end" || key == "button_b" || key == "dpad_left") {
      selected = 0;
      break;
    }

    level notify("scroll_list");

    if(current_num != old_num) {
      old_num = current_num;

      if(isDefined(func)) {
        [[func]](list[current_num]);
      }
    }

    wait 0.1;
  }

  if(arrow.isscripted) {
    arrow scripthuddestroy();
  } else {
    arrow destroy();
  }

  for(i = 0; i < hud_array.size; i++) {
    if(hud_array[i].isscripted) {
      hud_array[i] scripthuddestroy();
      continue;
    }

    hud_array[i] destroy();
  }

  if(selected) {
    return current_num;
  }
}

function move_list_menu(hud_array, list, num, y_offset) {
  for(i = 0; i < hud_array.size; i++) {
    index = i + num - y_offset;

    if(isDefined(list[index])) {
      text = list[index];
    } else if(index < 0) {
      text = list[list.size + index];
    } else {
      text = list[index % list.size];
    }

    hud_array[i].archived = 0;

    if(isDefined(hud_array[i].isscripted)) {
      hud_array[i].text = text;
      continue;
    }

    hud_array[i] setdevtext("<dev string:xb1>" + text);

    hud_array[i] clearalltextafterhudelem();
  }
}

function add_universal_button(button_group, name) {
  if(!isDefined(level.u_buttons[button_group])) {
    level.u_buttons[button_group] = [];
  }

  if(array_check_for_dupes(level.u_buttons[button_group], name)) {
    level.u_buttons[button_group][level.u_buttons[button_group].size] = name;
  }
}

function array_check_for_dupes(array, single) {
  for(i = 0; i < array.size; i++) {
    if(array[i] == single) {
      return false;
    }
  }

  return true;
}

function clear_universal_buttons(button_group) {
  level.u_buttons[button_group] = [];
}

function universal_input_loop(button_group, end_on, use_attackbutton, mod_button, no_mod_button) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level endon(end_on);

  if(!isDefined(use_attackbutton)) {
    use_attackbutton = 0;
  }

  notify_name = button_group + "_button_pressed";
  buttons = level.u_buttons[button_group];
  level.u_buttons_disable[button_group] = 0;

  while(true) {
    if(level.u_buttons_disable[button_group]) {
      waitframe();
      continue;
    }

    if(isDefined(mod_button) && !level.player buttonPressed(mod_button)) {
      waitframe();
      continue;
    } else if(isDefined(no_mod_button) && level.player buttonPressed(no_mod_button)) {
      waitframe();
      continue;
    }

    if(use_attackbutton && level.player attackButtonPressed()) {
      level notify(notify_name, "fire");
      wait 0.1;
      continue;
    }

    for(i = 0; i < buttons.size; i++) {
      if(level.player buttonPressed(buttons[i])) {
        level notify(notify_name, buttons[i]);
        wait 0.1;
        break;
      }
    }

    waitframe();
  }
}

function any_button_hit(button_hit, type) {
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
  } else {
    buttons = level.buttons;
  }

  for(i = 0; i < buttons.size; i++) {
    if(button_hit == buttons[i]) {
      return true;
    }
  }

  return false;
}

function init_buttons() {
  clear_universal_buttons("menu");
  add_universal_button("menu", "dpad_up");
  add_universal_button("menu", "dpad_down");
  add_universal_button("menu", "dpad_left");
  add_universal_button("menu", "dpad_right");
  add_universal_button("menu", "button_b");
  add_universal_button("menu", "downarrow");
  add_universal_button("menu", "uparrow");
  add_universal_button("menu", "leftarrow");
  add_universal_button("menu", "rightarrow");
  add_universal_button("menu", "enter");
  level thread universal_input_loop("menu", "never", undefined, undefined, "button_ltrig");
}