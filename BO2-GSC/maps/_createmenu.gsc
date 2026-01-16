/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_createmenu.gsc
**************************************/

#include common_scripts\utility;

add_menu(menu_name, title) {
  if(isDefined(level.menu_sys[menu_name])) {
    println("^1level.menu_sys[" + menu_name + "] already exists, change the menu_name");
    return;
  }

  level.menu_sys[menu_name] = spawnstruct();
  level.menu_sys[menu_name].title = "none";
  level.menu_sys[menu_name].title = title;
}

add_menuoptions(menu_name, option_text, func, key) {
  if(!isDefined(level.menu_sys[menu_name].options))
    level.menu_sys[menu_name].options = [];

  num = level.menu_sys[menu_name].options.size;
  level.menu_sys[menu_name].options[num] = option_text;
  level.menu_sys[menu_name].function[num] = func;

  if(isDefined(key)) {
    if(!isDefined(level.menu_sys[menu_name].func_key))
      level.menu_sys[menu_name].func_key = [];

    level.menu_sys[menu_name].func_key[num] = key;
  }

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

set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem) {
  if(!isDefined(alpha))
    alpha = 1;

  if(!isDefined(scale))
    scale = 1;

  if(!isDefined(sort))
    sort = 20;

  if(isDefined(level.player) && !isDefined(debug_hudelem))
    hud = newclienthudelem(level.player);
  else {
    hud = newdebughudelem();
    hud.debug_hudelem = 1;
  }

  hud.location = 0;
  hud.alignx = "left";
  hud.aligny = "middle";
  hud.foreground = 1;
  hud.fontscale = scale;
  hud.sort = sort;
  hud.alpha = alpha;
  hud.x = x;
  hud.y = y;
  hud.og_scale = scale;

  if(isDefined(text))
    hud settext(text);

  return hud;
}

menu_input() {
  while(true) {
    level waittill("menu_button_pressed", keystring);
    menu_name = level.menu_sys["current_menu"].menu_name;

    if(keystring == "dpad_up" || keystring == "uparrow") {
      if(level.menu_cursor.current_pos > 0) {
        level.menu_cursor.y = level.menu_cursor.y - 20;
        level.menu_cursor.current_pos--;
      } else if(level.menu_cursor.current_pos == 0) {
        level.menu_cursor.y = level.menu_cursor.y + (level.menu_sys["current_menu"].options.size - 1) * 20;
        level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - 1;
      }

      wait 0.1;
      continue;
    } else if(keystring == "dpad_down" || keystring == "downarrow") {
      if(level.menu_cursor.current_pos < level.menu_sys["current_menu"].options.size - 1) {
        level.menu_cursor.y = level.menu_cursor.y + 20;
        level.menu_cursor.current_pos++;
      } else if(level.menu_cursor.current_pos == level.menu_sys["current_menu"].options.size - 1) {
        level.menu_cursor.y = level.menu_cursor.y + level.menu_cursor.current_pos * -20;
        level.menu_cursor.current_pos = 0;
      }

      wait 0.1;
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

    if(!isDefined(level.menu_sys[menu_name].children_menu)) {
      println("^1 " + menu_name + " Menu does not have any children menus, yet");
      continue;
    } else if(!isDefined(level.menu_sys[menu_name].children_menu[key])) {
      println("^1 " + menu_name + " Menu does not have a number " + key + " child menu, yet");
      continue;
    } else if(!isDefined(level.menu_sys[level.menu_sys[menu_name].children_menu[key]])) {
      println("^1 " + level.menu_sys[menu_name].options[key] + " Menu does not exist, yet");
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
    wait 0.1;
  }

}

force_menu_back(waittill_msg) {
  if(isDefined(waittill_msg))
    level waittill(waittill_msg);

  wait 0.1;
  menu_name = level.menu_sys["current_menu"].menu_name;
  key = level.menu_sys[menu_name].options.size;
  key++;

  if(key == 1)
    key = "1";
  else if(key == 2)
    key = "2";
  else if(key == 3)
    key = "3";
  else if(key == 4)
    key = "4";
  else if(key == 5)
    key = "5";
  else if(key == 6)
    key = "6";
  else if(key == 7)
    key = "7";
  else if(key == 8)
    key = "8";
  else if(key == 9)
    key = "9";

  level notify("menu_button_pressed", key);
}

list_menu(list, x, y, scale, func, sort, start_num) {
  if(!isDefined(list) || list.size == 0)
    return -1;

  hud_array = [];

  for(i = 0; i < 5; i++) {
    if(i == 0)
      alpha = 0.3;
    else if(i == 1)
      alpha = 0.6;
    else if(i == 2)
      alpha = 1;
    else if(i == 3)
      alpha = 0.6;
    else
      alpha = 0.3;

    hud = set_hudelem(list[i], x, y + (i - 2) * 15, scale, alpha, sort);
    hud_array[hud_array.size] = hud;
  }

  if(isDefined(start_num))
    new_move_list_menu(hud_array, list, start_num);

  current_num = 0;
  old_num = 0;
  selected = 0;
  level.menu_list_selected = 0;

  if(isDefined(func))
    [[func]](list[current_num]);

  while(true) {
    level waittill("menu_button_pressed", key);
    level.menu_list_selected = 1;

    if(any_button_hit(key, "numbers")) {
      break;
    } else if(key == "downarrow" || key == "dpad_down") {
      if(current_num >= list.size - 1) {
        continue;
      }
      current_num++;
      new_move_list_menu(hud_array, list, current_num);
    } else if(key == "uparrow" || key == "dpad_up") {
      if(current_num <= 0) {
        continue;
      }
      current_num--;
      new_move_list_menu(hud_array, list, current_num);
    } else if(key == "enter" || key == "button_a") {
      selected = 1;
      break;
    } else if(key == "end" || key == "button_b") {
      selected = 0;
      break;
    }

    level notify("scroll_list");

    if(current_num != old_num) {
      old_num = current_num;

      if(isDefined(func))
        [[func]](list[current_num]);
    }

    wait 0.1;
  }

  for(i = 0; i < hud_array.size; i++)
    hud_array[i] destroy();

  if(selected)
    return current_num;
}

new_move_list_menu(hud_array, list, num) {
  for(i = 0; i < hud_array.size; i++) {
    if(isDefined(list[i + (num - 2)]))
      text = list[i + (num - 2)];
    else
      text = "";

    hud_array[i] settext(text);
  }

}

move_list_menu(hud_array, dir, space, num, min_alpha, num_of_fades) {
  if(!isDefined(min_alpha))
    min_alpha = 0;

  if(!isDefined(num_of_fades))
    num_of_fades = 3;

  side_movement = 0;

  if(dir == "right") {
    side_movement = 1;
    movement = space;
  } else if(dir == "left") {
    side_movement = 1;
    movement = space * -1;
  } else if(dir == "up")
    movement = space;
  else
    movement = space * -1;

  for(i = 0; i < hud_array.size; i++) {
    hud_array[i] moveovertime(0.1);

    if(side_movement)
      hud_array[i].x = hud_array[i].x + movement;
    else
      hud_array[i].y = hud_array[i].y + movement;

    temp = i - num;

    if(temp < 0)
      temp = temp * -1;

    alpha = 1 / (temp + 1);

    if(alpha < 1 / num_of_fades)
      alpha = min_alpha;

    if(!isDefined(hud_array[i].debug_hudelem))
      hud_array[i] fadeovertime(0.1);

    hud_array[i].alpha = alpha;
  }

}

hud_selector(x, y) {
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
  if(!isDefined(time))
    time = 0.25;

  level.menu_cursor.alpha = 0.5;
  hud = level.hud_selector;
  level.hud_selector = undefined;

  if(!isDefined(hud.debug_hudelem))
    hud fadeovertime(time);

  hud.alpha = 0;
  wait(time + 0.1);
  hud destroy();
}

selection_error(msg, x, y) {
  hud = set_hudelem(undefined, x - 10, y, 1);
  hud setshader("white", 125, 20);
  hud.color = vectorscale((1, 0, 0), 0.5);
  hud.alpha = 0.7;
  error_hud = set_hudelem(msg, x + 125, y, 1);
  error_hud.color = (1, 0, 0);

  if(!isDefined(hud.debug_hudelem))
    hud fadeovertime(3);

  hud.alpha = 0;

  if(!isDefined(error_hud.debug_hudelem))
    error_hud fadeovertime(3);

  error_hud.alpha = 0;
  wait 3.1;
  hud destroy();
  error_hud destroy();
}

hud_font_scaler(mult) {
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

menu_cursor() {
  level.menu_cursor = set_hudelem(undefined, 0, 130, 1.3);
  level.menu_cursor setshader("white", 125, 20);
  level.menu_cursor.color = (1, 0.5, 0);
  level.menu_cursor.alpha = 0.5;
  level.menu_cursor.sort = 1;
  level.menu_cursor.current_pos = 0;
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

remove_hud(hud_name) {
  if(!isDefined(level.hud_array[hud_name])) {
    return;
  }
  huds = level.hud_array[hud_name];

  for(i = 0; i < huds.size; i++)
    destroy_hud(huds[i]);

  level.hud_array[hud_name] = undefined;
}

destroy_hud(hud) {
  if(isDefined(hud))
    hud destroy();
}

set_menus_pos_by_num(hud_array, num, x, y, space, min_alpha, num_of_fades) {
  if(!isDefined(min_alpha))
    min_alpha = 0.1;

  if(!isDefined(num_of_fades))
    num_of_fades = 3;

  for(i = 0; i < hud_array.size; i++) {
    temp = i - num;
    hud_array[i].y = y + temp * space;

    if(temp < 0)
      temp = temp * -1;

    alpha = 1 / (temp + 1);

    if(alpha < 1 / num_of_fades)
      alpha = min_alpha;

    hud_array[i].alpha = alpha;
  }

}

popup_box(x, y, width, height, time, color, alpha) {
  if(!isDefined(alpha))
    alpha = 0.5;

  if(!isDefined(color))
    color = vectorscale((0, 0, 1), 0.5);

  if(isDefined(level.player))
    hud = newclienthudelem(level.player);
  else {
    hud = newdebughudelem();
    hud.debug_hudelem = 1;
  }

  hud.alignx = "left";
  hud.aligny = "middle";
  hud.foreground = 1;
  hud.sort = 30;
  hud.x = x;
  hud.y = y;
  hud.alpha = alpha;
  hud.color = color;

  if(isDefined(level.player))
    hud.background = newclienthudelem(level.player);
  else {
    hud.background = newdebughudelem();
    hud.debug_hudelem = 1;
  }

  hud.background.alignx = "left";
  hud.background.aligny = "middle";
  hud.background.foreground = 1;
  hud.background.sort = 25;
  hud.background.x = x + 2;
  hud.background.y = y + 2;
  hud.background.alpha = 0.75;
  hud.background.color = (0, 0, 0);
  hud setshader("white", 0, 0);
  hud scaleovertime(time, width, height);
  hud.background setshader("white", 0, 0);
  hud.background scaleovertime(time, width, height);
  wait(time);
  return hud;
}

destroy_popup() {
  self.background scaleovertime(0.25, 0, 0);
  self scaleovertime(0.25, 0, 0);
  wait 0.1;

  if(isDefined(self.background))
    self.background destroy();

  if(isDefined(self))
    self destroy();
}

dialog_text_box(dialog_msg, dialog_msg2, word_length) {
  y = 100;
  hud = new_hud("dialog_box", undefined, 320 - 300 * 0.5, y, 1);
  hud setshader("white", 300, 100);
  hud.aligny = "top";
  hud.color = vectorscale((0, 0, 1), 0.2);
  hud.alpha = 0.85;
  hud.sort = 20;
  hud = new_hud("dialog_box", dialog_msg, 320 - 300 * 0.5 + 10, y + 10, 1.25);
  hud.sort = 25;

  if(isDefined(dialog_msg2)) {
    hud = new_hud("dialog_box", dialog_msg2, 320 - 300 * 0.5 + 10, y + 30, 1.1);
    hud.sort = 25;
  }

  bg2_shader_width = 300 - 20;
  y = 150;
  hud = new_hud("dialog_box", undefined, 320 - bg2_shader_width * 0.5, y, 1);
  hud setshader("white", bg2_shader_width, 20);
  hud.aligny = "top";
  hud.color = (0, 0, 0);
  hud.alpha = 0.85;
  hud.sort = 30;
  cursor_x = 320 - bg2_shader_width * 0.5 + 2;
  cursor_y = y + 8;

  if(level.xenon) {
    hud = new_hud("dialog_box", "Ok [A]", 320 - 50, y + 30, 1.25);
    hud.alignx = "center";
    hud.sort = 25;
    hud = new_hud("dialog_box", "Cancel [Y]", 320 + 50, y + 30, 1.25);
    hud.alignx = "center";
    hud.sort = 25;
  } else {
    hud = new_hud("dialog_box", "Ok [enter]", 320 - 50, y + 30, 1.25);
    hud.alignx = "center";
    hud.sort = 25;
    hud = new_hud("dialog_box", "Cancel [end]", 320 + 50, y + 30, 1.25);
    hud.alignx = "center";
    hud.sort = 25;
  }

  result = dialog_text_box_input(cursor_x, cursor_y, word_length);
  remove_hud("dialog_box");
  return result;
}

dialog_text_box_input(cursor_x, cursor_y, word_length) {
  level.dialog_box_cursor = new_hud("dialog_box", "|", cursor_x, cursor_y, 1.25);
  level.dialog_box_cursor.sort = 75;
  level thread dialog_text_box_cursor();
  dialog_text_box_buttons();
  hud_word = new_hud("dialog_box", "", cursor_x, cursor_y, 1.25);
  hud_word.sort = 75;
  hud_letters = [];
  word = "";

  while(true) {
    level waittill("dialog_box_button_pressed", button);

    if(button == "end" || button == "button_y") {
      word = "-1";
      break;
    } else if(button == "enter" || button == "kp_enter" || button == "button_a") {
      break;
    } else if(button == "backspace" || button == "del") {
      new_word = "";

      for(i = 0; i < word.size - 1; i++)
        new_word = new_word + word[i];

      word = new_word;
    } else if(word.size < word_length)
      word = word + button;

    hud_word settext(word);
    x = cursor_x;

    for(i = 0; i < word.size; i++)
      x = x + get_letter_space(word[i]);

    level.dialog_box_cursor.x = x;
    wait 0.05;
  }

  level notify("stop_dialog_text_box_cursor");
  level notify("stop_dialog_text_input");
  return word;
}

dialog_text_box_buttons() {
  clear_universal_buttons("dialog_text_buttons");
  add_universal_button("dialog_box", "_");
  add_universal_button("dialog_box", "0");
  add_universal_button("dialog_box", "1");
  add_universal_button("dialog_box", "2");
  add_universal_button("dialog_box", "3");
  add_universal_button("dialog_box", "4");
  add_universal_button("dialog_box", "5");
  add_universal_button("dialog_box", "6");
  add_universal_button("dialog_box", "7");
  add_universal_button("dialog_box", "8");
  add_universal_button("dialog_box", "9");
  add_universal_button("dialog_box", "a");
  add_universal_button("dialog_box", "b");
  add_universal_button("dialog_box", "c");
  add_universal_button("dialog_box", "d");
  add_universal_button("dialog_box", "e");
  add_universal_button("dialog_box", "f");
  add_universal_button("dialog_box", "g");
  add_universal_button("dialog_box", "h");
  add_universal_button("dialog_box", "i");
  add_universal_button("dialog_box", "j");
  add_universal_button("dialog_box", "k");
  add_universal_button("dialog_box", "l");
  add_universal_button("dialog_box", "m");
  add_universal_button("dialog_box", "n");
  add_universal_button("dialog_box", "o");
  add_universal_button("dialog_box", "p");
  add_universal_button("dialog_box", "q");
  add_universal_button("dialog_box", "r");
  add_universal_button("dialog_box", "s");
  add_universal_button("dialog_box", "t");
  add_universal_button("dialog_box", "u");
  add_universal_button("dialog_box", "v");
  add_universal_button("dialog_box", "w");
  add_universal_button("dialog_box", "x");
  add_universal_button("dialog_box", "y");
  add_universal_button("dialog_box", "z");
  add_universal_button("dialog_box", "enter");
  add_universal_button("dialog_box", "kp_enter");
  add_universal_button("dialog_box", "end");
  add_universal_button("dialog_box", "backspace");
  add_universal_button("dialog_box", "del");

  if(level.xenon) {
    add_universal_button("dialog_box", "button_a");
    add_universal_button("dialog_box", "button_y");
  }

  level thread universal_input_loop("dialog_box", "stop_dialog_text_input", undefined, undefined);
}

dialog_text_box_cursor() {
  level endon("stop_dialog_text_box_cursor");

  while(true) {
    level.dialog_box_cursor.alpha = 0;
    wait 0.5;
    level.dialog_box_cursor.alpha = 1;
    wait 0.5;
  }

}

get_letter_space(letter) {
  if(letter == "m" || letter == "w" || letter == "_")
    space = 10;
  else if(letter == "e" || letter == "h" || letter == "u" || letter == "v" || letter == "x" || letter == "o")
    space = 7;
  else if(letter == "f" || letter == "r" || letter == "t")
    space = 5;
  else if(letter == "i" || letter == "l")
    space = 4;
  else if(letter == "j")
    space = 3;
  else
    space = 6;

  return space;
}

add_universal_button(button_group, name) {
  if(!isDefined(level.u_buttons[button_group]))
    level.u_buttons[button_group] = [];

  if(array_check_for_dupes(level.u_buttons[button_group], name))
    level.u_buttons[button_group][level.u_buttons[button_group].size] = name;
}

clear_universal_buttons(button_group) {
  level.u_buttons[button_group] = [];
}

universal_input_loop(button_group, end_on, use_attackbutton, mod_button, no_mod_button) {
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

    if(isDefined(mod_button) && !level.player buttonpressed(mod_button)) {
      wait 0.05;
      continue;
    } else if(isDefined(no_mod_button) && level.player buttonpressed(no_mod_button)) {
      wait 0.05;
      continue;
    }

    if(use_attackbutton && level.player attackbuttonpressed()) {
      level notify(notify_name, "fire");
      wait 0.1;
      continue;
    }

    for(i = 0; i < buttons.size; i++) {
      if(level.player buttonpressed(buttons[i])) {
        level notify(notify_name, buttons[i]);
        wait 0.1;
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