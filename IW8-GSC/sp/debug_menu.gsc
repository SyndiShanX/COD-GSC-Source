/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\debug_menu.gsc
***********************************************/

init_menus() {
  level.menu_sys = [];
  level.menu_sys["current_menu"] = spawnStruct();
  init_buttons();
  level thread menu_input();
}

add_menu(var_0, var_1, var_2) {
  if(menu_exists(var_0)) {
    return;
  }
  level.menu_sys[var_0] = spawnStruct();
  level.menu_sys[var_0].title = var_1;
  level.menu_sys[var_0].page = 0;
  level.menu_sys[var_0].can_exit = istrue(var_2);
}

menu_exists(var_0) {
  return isDefined(level.menu_sys[var_0]);
}

add_menuoptions(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.menu_sys[var_0].options)) {
    level.menu_sys[var_0].options = [];
    level.menu_sys[var_0].optionsvalue = [];
  }

  var_5 = level.menu_sys[var_0].options.size;
  level.menu_sys[var_0].options[var_5] = var_1;
  level.menu_sys[var_0].function[var_5] = var_2;
  level.menu_sys[var_0].backfunction[var_5] = var_3;

  if(isDefined(var_4))
    level.menu_sys[var_0].optionsvalue[var_5] = var_4;
}

add_menuent(var_0, var_1) {
  level.menu_sys[var_0].ent = var_1;
}

add_menu_child(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.menu_sys[var_1]))
    add_menu(var_1, var_2);

  level.menu_sys[var_1].parent_menu = var_0;

  if(!isDefined(level.menu_sys[var_0].children_menu))
    level.menu_sys[var_0].children_menu = [];

  if(!isDefined(var_3))
    var_5 = level.menu_sys[var_0].children_menu.size;
  else
    var_5 = var_3;

  level.menu_sys[var_0].children_menu[var_5] = var_1;

  if(isDefined(var_4)) {
    if(!isDefined(level.menu_sys[var_0].children_func))
      level.menu_sys[var_0].children_func = [];

    level.menu_sys[var_0].children_func[var_5] = var_4;
  }
}

enable_menu(var_0) {
  disable_menu("current_menu");

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor.current_pos = 0;
    menu_cursor_resetpos();
  }

  level.menu_sys["current_menu"].title = set_menu_hudelem(level.menu_sys[var_0].title, "title");
  level.menu_sys["current_menu"].menu_name = var_0;

  if(isDefined(level.menu_sys[var_0].options))
    draw_menu_options(var_0);

  if(isDefined(level.menu_sys[var_0].ent))
    level.menu_sys["current_menu"].ent = level.menu_sys[var_0].ent;

  menu_cursor();
  menu_highlight("current_menu", level.menu_cursor.current_pos);
}

exit_menu() {
  level notify("exit_menu");
  level.exitmenu = 1;
}

draw_menu_options(var_0) {
  var_1 = level.menu_sys[var_0].options;
  var_2 = level.menu_sys[var_0].page;

  for(var_3 = 0; var_3 < 20 && var_3 + var_2 * 20 < var_1.size; var_3++) {
    var_4 = var_3 + var_2 * 20;
    var_5 = var_4 + 1 + ". " + var_1[var_4];
    level.menu_sys["current_menu"].options[var_3] = set_menu_hudelem(var_5, "options", int(25.0) * var_3);

    if(isDefined(level.menu_sys[var_0].optionsvalue[var_4])) {
      var_6 = level.menu_sys[var_0].optionsvalue[var_4];
      var_7 = set_menu_hudelem(var_6, "value", int(25.0) * var_3);

      if(scripts\common\utility::iscp())
        var_7.x = var_7.x + int(247.5);
      else
        var_7.x = var_7.x + int(207.5);

      level.menu_sys["current_menu"].optionsvalue[var_3] = var_7;
    }
  }

  if(var_1.size > 20) {
    var_5 = "";

    if(var_2 > 0)
      var_5 = var_5 + "<-- Prev ";

    if(var_2 < floor(var_1.size / 20))
      var_5 = var_5 + "Next -->";

    if(var_5 != "") {
      level.menu_sys["current_menu"].options[var_3] = set_menu_hudelem(var_5, "options", int(25.0) * var_3);
      var_3++;
    }
  }

  if(level.menu_sys[var_0].can_exit)
    level.menu_sys["current_menu"].options[var_3] = set_menu_hudelem("Exit", "options", int(25.0) * var_3);
}

disable_menu(var_0) {
  level notify("stop_all_menus");

  if(isDefined(level.menu_sys[var_0])) {
    if(isDefined(level.menu_sys[var_0].title))
      level.menu_sys[var_0].title scripthuddestroy();

    if(isDefined(level.menu_sys[var_0].options))
      clear_menu_options(var_0);
  }

  level.menu_sys[var_0].title = undefined;
  level.menu_sys[var_0].menu_name = undefined;
  level.menu_sys[var_0].ent = undefined;

  if(isDefined(level.menu_cursor))
    level.menu_cursor scripthuddestroy();
}

clear_menu_options(var_0) {
  var_1 = level.menu_sys[var_0].options;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].extrahuds)) {
      foreach(var_4 in var_1[var_2].extrahuds) {
        if(isDefined(var_4))
          var_4 scripthuddestroy();
      }
    }

    var_1[var_2] scripthuddestroy();

    if(!isDefined(level.menu_sys[var_0].optionsvalue)) {
      continue;
    }
    if(isDefined(level.menu_sys[var_0].optionsvalue[var_2]))
      level.menu_sys[var_0].optionsvalue[var_2] scripthuddestroy();
  }

  level.menu_sys[var_0].options = [];

  if(isDefined(level.menu_sys[var_0].optionsvalue))
    level.menu_sys[var_0].optionsvalue = [];
}

destroy_menu(var_0) {
  level.menu_sys[var_0] = undefined;
}

set_menu_hudelem(var_0, var_1, var_2) {
  if(scripts\common\utility::iscp())
    var_3 = 60;
  else
    var_3 = 20;

  var_4 = 300;

  if(var_1 == "title")
    var_5 = 1.375;
  else {
    var_5 = 1.25;
    var_4 = var_4 + int(25.0);
  }

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = var_4 + var_2;
  return set_scripthud(var_0, var_3, var_4, var_5);
}

set_hudelem(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_5))
    var_5 = 20;

  var_6 = newhudelem();
  var_6.location = 0;
  var_6.alignx = "left";
  var_6.aligny = "bottom";
  var_6.vertalign = "fullscreen";
  var_6.horzalign = "fullscreen";
  var_6.foreground = 1;
  var_6.fontscale = var_3;
  var_6.sort = var_5;
  var_6.alpha = var_4;
  var_6.x = var_1;
  var_6.y = var_2;
  var_6.og_scale = var_3;
  var_6.archived = 0;

  if(isDefined(var_0)) {
    var_6.text = var_0;

    if(isnumber(var_0))
      var_6 setvalue(var_0);
    else
      var_6 clearalltextafterhudelem();
  }

  return var_6;
}

set_scripthud(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 2;

  var_5 = newscripthud();
  var_5.x = var_1;
  var_5.y = var_2;
  var_5.scale = var_3;

  if(isDefined(var_0))
    var_5.text = var_0;

  if(isDefined(var_4)) {
    var_6 = scripts\engine\math::lerp(var_5.color[0] * 0.6, var_5.color[0], var_4);
    var_7 = scripts\engine\math::lerp(var_5.color[1] * 0.6, var_5.color[1], var_4);
    var_8 = scripts\engine\math::lerp(var_5.color[2] * 0.6, var_5.color[2], var_4);
    var_5.color = (var_6, var_7, var_8);
  }

  return var_5;
}

newscripthud() {
  var_0 = spawnStruct();
  var_0.x = 0;
  var_0.y = 0;
  var_0.text = "";
  var_0.color = (1, 1, 1);
  var_0.scale = 2;
  var_0.isscripted = 1;
  var_0.alive = 1;
  var_0 thread scripthudthread();
  return var_0;
}

scripthudthread() {
  while(self.alive)
    waitframe();
}

scripthuddestroy() {
  if(!istrue(self.isscripted)) {
    self destroy();
    return;
  }

  self.alive = 0;
}

newscriptcursor(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.x = var_0;
  var_2.y = var_1;
  var_2.text = ">";
  var_2.color = (0.8, 0.1, 0.1);
  var_2.scale = 2;
  var_2.isscripted = 1;
  var_2.alive = 1;
  var_2 thread scripthudthread();
  return var_2;
}

menu_input() {
  level notify("stop_menu_input");
  level endon("stop_menu_input");

  for(;;) {
    level waittill("menu_button_pressed", var_0);

    if(!isDefined(level.menu_cursor) || isDefined(level.debug) && isDefined(level.debug.debug_start) && level.debug.debug_start) {
      wait 0.1;
      continue;
    }

    var_1 = level.menu_sys["current_menu"].menu_name;

    if(!isDefined(var_1)) {
      continue;
    }
    var_2["shift"] = 0;
    var_2["ctrl"] = 0;
    var_2["alt"] = 0;

    if(var_0 == "dpad_up" || var_0 == "uparrow") {
      if(level.menu_cursor.current_pos > 0) {
        level.menu_cursor.y = level.menu_cursor.y - int(25.0);
        level.menu_cursor.current_pos--;
      } else if(level.menu_cursor.current_pos == 0) {
        level.menu_cursor.y = level.menu_cursor.y + (level.menu_sys["current_menu"].options.size - 1) * int(25.0);
        level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - 1;
      }

      menu_highlight("current_menu", level.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(var_0 == "dpad_down" || var_0 == "downarrow") {
      if(level.menu_cursor.current_pos < level.menu_sys["current_menu"].options.size - 1) {
        level.menu_cursor.y = level.menu_cursor.y + int(25.0);
        level.menu_cursor.current_pos++;
      } else if(level.menu_cursor.current_pos == level.menu_sys["current_menu"].options.size - 1) {
        level.menu_cursor.y = level.menu_cursor.y + level.menu_cursor.current_pos * int(25.0) * -1;
        level.menu_cursor.current_pos = 0;
      }

      menu_highlight("current_menu", level.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(var_0 == "button_a" || var_0 == "dpad_right" || var_0 == "dpad_left" || var_0 == "rightarrow" || var_0 == "leftarrow") {
      if(var_0 == "dpad_left" || var_0 == "leftarrow")
        var_2["shift"] = 1;

      var_3 = level.menu_cursor.current_pos;
    } else
      var_3 = int(var_0) - 1;

    if(level.player buttonPressed("lshift") || level.player buttonPressed("rshift"))
      var_2["shift"] = 1;

    if(level.menu_sys[var_1].can_exit)
      var_4 = 2;
    else
      var_4 = 1;

    if(var_3 >= level.menu_sys["current_menu"].options.size)
      continue;
    else if(level.menu_sys[var_1].can_exit && var_3 == level.menu_sys["current_menu"].options.size - 1) {
      level notify("exit_menu");
      level.exitmenu = 1;
      continue;
    } else if(level.menu_sys[var_1].options.size > 20 && var_3 == level.menu_sys["current_menu"].options.size - var_4) {
      var_5 = 0;

      if(var_2["shift"] && level.menu_sys[var_1].page > 0) {
        level.menu_sys[var_1].page--;
        var_5 = 1;
      } else if(!var_2["shift"] && level.menu_sys[var_1].page < floor(level.menu_sys[var_1].options.size / 20)) {
        level.menu_sys[var_1].page++;
        var_5 = 1;
      }

      if(var_5) {
        var_6 = level.menu_sys["current_menu"].options.size;
        clear_menu_options("current_menu");
        draw_menu_options(var_1);

        if(level.menu_sys["current_menu"].options.size != var_6) {
          level.menu_cursor.y = 300 + (level.menu_sys["current_menu"].options.size - var_4 + 1) * int(25.0);
          level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - var_4;
        }
      }

      continue;
    } else {
      var_7 = var_3;
      var_3 = var_3 + level.menu_sys[var_1].page * 20;
    }

    if(isDefined(level.menu_sys[var_1].parent_menu) && var_3 == level.menu_sys[var_1].options.size) {
      level notify("disable " + var_1);
      level enable_menu(level.menu_sys[var_1].parent_menu);
    } else if(isDefined(level.menu_sys[var_1].function) && isDefined(level.menu_sys[var_1].function[var_3])) {
      var_8 = undefined;

      if(!var_2["shift"])
        var_8 = level.menu_sys[var_1].function[var_3];
      else if(isDefined(level.menu_sys[var_1].backfunction))
        var_8 = level.menu_sys[var_1].backfunction[var_3];

      if(isDefined(var_8)) {
        var_9 = level;

        if(isDefined(level.menu_sys["current_menu"].ent))
          var_9 = level.menu_sys["current_menu"].ent;

        var_10 = var_9[[var_8]]();

        if(isDefined(var_10)) {
          level.menu_sys["current_menu"].optionsvalue[var_7].text = var_10;

          if(isDefined(level.menu_sys["current_menu"].optionsvalue[var_7].isscripted))
            level.menu_sys["current_menu"].optionsvalue[var_7].text = var_10;
          else if(isnumber(var_10))
            level.menu_sys["current_menu"].optionsvalue[var_7] setvalue(var_10);
          else
            level.menu_sys["current_menu"].optionsvalue[var_7] clearalltextafterhudelem();
        }
      }
    }

    if(!isDefined(level.menu_sys[var_1].children_menu))
      continue;
    else if(!isDefined(level.menu_sys[var_1].children_menu[var_3]))
      continue;
    else if(!isDefined(level.menu_sys[level.menu_sys[var_1].children_menu[var_3]])) {
      continue;
    }
    if(isDefined(level.menu_sys[var_1].children_func) && isDefined(level.menu_sys[var_1].children_func[var_3])) {
      var_8 = level.menu_sys[var_1].children_func[var_3];
      var_11 = [[var_8]]();

      if(isDefined(var_11)) {
        level thread selection_error(var_11, level.menu_sys["current_menu"].options[var_7].x, level.menu_sys["current_menu"].options[var_7].y);
        continue;
      }
    }

    level enable_menu(level.menu_sys[var_1].children_menu[var_3]);
    wait 0.1;
  }
}

menu_highlight(var_0, var_1) {
  foreach(var_3 in level.menu_sys[var_0].options)
  var_3.color = (1, 1, 1);

  if(isDefined(level.menu_sys[var_0].optionsvalue)) {
    foreach(var_3 in level.menu_sys[var_0].optionsvalue)
    var_3.color = (1, 1, 1);
  }

  if(isDefined(level.menu_sys[var_0].optionsvalue) && isDefined(level.menu_sys[var_0].optionsvalue[var_1]))
    level.menu_sys[var_0].optionsvalue[var_1].color = (1, 1, 0);

  level.menu_sys[var_0].options[var_1].color = (1, 1, 0);
}

hud_selector(var_0, var_1) {}

hud_selector_fade_out(var_0) {}

menu_get_selected_optionsvalue(var_0) {
  if(!isDefined(var_0))
    var_0 = level.menu_cursor.current_pos;

  return level.menu_sys["current_menu"].optionsvalue[var_0];
}

get_current_menu_name() {
  return level.menu_sys["current_menu"].menu_name;
}

menu_get_selected(var_0) {
  if(!isDefined(var_0))
    var_0 = level.menu_cursor.current_pos;

  return level.menu_sys["current_menu"].options[var_0];
}

menu_get_selected_text() {
  var_0 = level.menu_cursor.current_pos;
  return level.menu_sys["current_menu"].options[var_0].text;
}

selection_error(var_0, var_1, var_2) {
  var_3 = set_hudelem(undefined, var_1 - 10, var_2, 1);

  if(scripts\common\utility::iscp())
    var_3 setshader("white", int(247.5), 20);
  else
    var_3 setshader("white", int(207.5), 20);

  var_3.color = (0.5, 0, 0);
  var_3.alpha = 0.7;

  if(scripts\common\utility::iscp())
    var_4 = set_hudelem(var_0, var_1 + int(247.5), var_2, 1);
  else
    var_4 = set_hudelem(var_0, var_1 + int(207.5), var_2, 1);

  var_4.color = (1, 0, 0);

  if(!isDefined(var_3.debug_hudelem))
    var_3 fadeovertime(3);

  var_3.alpha = 0;

  if(!isDefined(var_4.debug_hudelem))
    var_4 fadeovertime(3);

  var_4.alpha = 0;
  wait 3.1;
  var_3 destroy();
  var_4 destroy();
}

menu_cursor() {
  level.menu_cursor = newscriptcursor(0, 300 + int(25.0));
  level.menu_cursor.current_pos = 0;
  menu_cursor_resetpos();
}

menu_cursor_resetpos() {
  level.menu_cursor.x = 0;
  level.menu_cursor.y = 300 + int(25.0) + 6;
}

add_extrahuds(var_0) {
  if(!isDefined(self.extrahuds))
    self.extrahuds = [];

  self.extrahuds[self.extrahuds.size] = var_0;
}

list_menu(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("stop_all_menus");
  var_6 = menu_get_selected();

  if(!isDefined(var_0) || var_0.size == 0)
    return -1;

  var_7 = [];
  var_8 = 25.0;
  var_9 = set_scripthud("->", var_1 - 20, var_2, 1.25, 1);
  var_9.color = (0.8, 0.1, 0.1);
  var_6 add_extrahuds(var_9);

  if(scripts\common\utility::issp()) {
    var_10 = 5;
    var_11 = 2;
  } else {
    var_10 = 3;
    var_11 = 1;
  }

  for(var_12 = 0; var_12 < var_10; var_12++) {
    if(var_12 == 0)
      var_13 = 0.3;
    else if(var_12 == 1)
      var_13 = 0.6;
    else if(var_12 == 2)
      var_13 = 1;
    else if(var_12 == 3)
      var_13 = 0.6;
    else
      var_13 = 0.3;

    var_14 = set_scripthud(var_0[var_12], var_1, var_2 + (var_12 - var_11) * var_8, 1.25, var_13);
    var_6 add_extrahuds(var_14);
    var_7 = scripts\engine\utility::array_add(var_7, var_14);
  }

  if(isDefined(var_5))
    move_list_menu(var_7, var_0, var_5, var_11);
  else
    move_list_menu(var_7, var_0, 0, var_11);

  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  level.menu_list_selected = 0;

  if(isDefined(var_3))
    [[var_3]](var_0[var_15]);

  for(;;) {
    level waittill("menu_button_pressed", var_18);

    if(!isDefined(level.menu_cursor)) {
      var_17 = 0;
      break;
    }

    level.menu_list_selected = 1;

    if(any_button_hit(var_18, "numbers")) {
      break;
    } else if(var_18 == "downarrow" || var_18 == "dpad_down") {
      if(var_15 >= var_0.size - 1) {
        var_15 = 0;
        move_list_menu(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15++;
      move_list_menu(var_7, var_0, var_15, var_11);
    } else if(var_18 == "uparrow" || var_18 == "dpad_up") {
      if(var_15 <= 0) {
        var_15 = var_0.size - 1;
        move_list_menu(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15--;
      move_list_menu(var_7, var_0, var_15, var_11);
    } else if(var_18 == "pgup") {
      if(var_15 <= 0) {
        var_15 = var_0.size - 1;
        move_list_menu(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15 = var_15 - 5;
      var_15 = clamp(var_15, 0, var_0.size - 1);
      var_15 = int(var_15);
      move_list_menu(var_7, var_0, var_15, var_11);
    } else if(var_18 == "pgdn") {
      if(var_15 >= var_0.size - 1) {
        var_15 = 0;
        move_list_menu(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15 = var_15 + 5;
      var_15 = clamp(var_15, 0, var_0.size - 1);
      var_15 = int(var_15);
      move_list_menu(var_7, var_0, var_15, var_11);
    } else if(var_18 == "enter" || var_18 == "button_a" || var_18 == "dpad_right" || var_18 == "rightarrow") {
      var_17 = 1;
      break;
    } else if(var_18 == "end" || var_18 == "button_b" || var_18 == "dpad_left" || var_18 == "leftarrow") {
      var_17 = 0;
      break;
    }

    level notify("scroll_list");

    if(var_15 != var_16) {
      var_16 = var_15;

      if(isDefined(var_3))
        [[var_3]](var_0[var_15]);
    }

    wait 0.1;
  }

  if(var_9.isscripted)
    var_9 scripthuddestroy();
  else
    var_9 destroy();

  for(var_12 = 0; var_12 < var_7.size; var_12++) {
    if(var_7[var_12].isscripted) {
      var_7[var_12] scripthuddestroy();
      continue;
    }

    var_7[var_12] destroy();
  }

  if(var_17)
    return var_15;
}

move_list_menu(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_4 + (var_2 - var_3);

    if(isDefined(var_1[var_5]))
      var_6 = var_1[var_5];
    else if(var_5 < 0)
      var_6 = var_1[var_1.size + var_5];
    else
      var_6 = var_1[var_5 % var_1.size];

    var_0[var_4].archived = 0;

    if(isDefined(var_0[var_4].isscripted)) {
      var_0[var_4].text = var_6;
      continue;
    }

    var_0[var_4] clearalltextafterhudelem();
  }
}

can_exit() {
  if(isDefined(level.exitmenu)) {
    level.exitmenu = undefined;
    return 1;
  }

  if(isai(self) && !isalive(self))
    return 1;

  return 0;
}

add_universal_button(var_0, var_1) {
  if(!isDefined(level.u_buttons[var_0]))
    level.u_buttons[var_0] = [];

  if(array_check_for_dupes(level.u_buttons[var_0], var_1))
    level.u_buttons[var_0][level.u_buttons[var_0].size] = var_1;
}

array_check_for_dupes(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1)
      return 0;
  }

  return 1;
}

clear_universal_buttons(var_0) {
  level.u_buttons[var_0] = [];
}

universal_input_loop(var_0, var_1, var_2, var_3, var_4) {
  while(!isDefined(level.player))
    waitframe();

  level endon(var_1);

  if(!isDefined(var_2))
    var_2 = 0;

  var_5 = var_0 + "_button_pressed";
  var_6 = level.u_buttons[var_0];
  level.u_buttons_disable[var_0] = 0;

  for(;;) {
    if(level.u_buttons_disable[var_0]) {
      waitframe();
      continue;
    }

    if(isDefined(var_3) && !level.player buttonPressed(var_3)) {
      waitframe();
      continue;
    } else if(isDefined(var_4) && level.player buttonPressed(var_4)) {
      waitframe();
      continue;
    }

    if(var_2 && level.player attackButtonPressed()) {
      level notify(var_5, "fire");
      wait 0.1;
      continue;
    }

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(level.player buttonPressed(var_6[var_7])) {
        level notify(var_5, var_6[var_7]);
        wait 0.1;
        break;
      }
    }

    waitframe();
  }
}

any_button_hit(var_0, var_1) {
  var_2 = [];

  if(var_1 == "numbers") {
    var_2[0] = "0";
    var_2[1] = "1";
    var_2[2] = "2";
    var_2[3] = "3";
    var_2[4] = "4";
    var_2[5] = "5";
    var_2[6] = "6";
    var_2[7] = "7";
    var_2[8] = "8";
    var_2[9] = "9";
  } else
    var_2 = level.buttons;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_0 == var_2[var_3])
      return 1;
  }

  return 0;
}

init_buttons() {
  clear_universal_buttons("menu");
  add_universal_button("menu", "dpad_up");
  add_universal_button("menu", "dpad_down");
  add_universal_button("menu", "dpad_left");
  add_universal_button("menu", "dpad_right");
  add_universal_button("menu", "downarrow");
  add_universal_button("menu", "uparrow");
  add_universal_button("menu", "leftarrow");
  add_universal_button("menu", "rightarrow");
  add_universal_button("menu", "enter");
  level thread universal_input_loop("menu", "never", undefined, undefined, "button_ltrig");
}

init_selection_and_cursor() {
  thread input_loop();
  thread cursor();
}

input_loop() {
  var_0 = 0;
  level.g_nextusepress = 0;

  for(;;) {
    if(gettime() > level.g_nextusepress && level.player useButtonPressed() || isDefined(level.force_select_ent)) {
      if(isDefined(level.force_select_ent))
        level.highlighted_ent = level.force_select_ent;

      level.g_nextusepress = gettime() + 400;

      if(isDefined(level.highlighted_ent)) {
        if(isDefined(level.highlighted_ent.usefunc))
          level.highlighted_ent thread[[level.highlighted_ent.usefunc]]();

        if(isDefined(level.highlighted_ent.onselect))
          level.highlighted_ent[[level.highlighted_ent.onselect]]();
        else if(isDefined(level.highlighted_ent.select_func))
          level.highlighted_ent[[level.highlighted_ent.select_func]]();
      }

      if(isDefined(level.force_select_ent))
        level.force_select_ent = undefined;

      wait 0.2;
    }

    waitframe();
  }
}

deselect() {
  if(!isDefined(level.selected)) {
    return;
  }
  if(isDefined(level.selectedhint))
    level.selectedhint destroy();

  level notify("deselect");
  level.selected.selected = 0;
  level.selected notify("deselect");

  if(!isnode(level.selected))
    level.selected hudoutlinedisable();

  level.selected = undefined;
  setsaveddvar("MKOQSSQKLL", 2);

  if(isDefined(level.followcam_enabled) && isDefined(level.func["followcam"]))
    [[level.func["followcam"]]](0);
}

force_select(var_0) {
  level.force_select_ent = var_0;
}

select(var_0) {
  deselect();
  var_0 endon("death");

  if(isnode(var_0)) {
    var_0 notify("stop_highlight");
    var_0 thread draw_box_forever(var_0.origin + (0, 0, 16), 32, (0.2, 1, 0.2), var_0.angles, 32, "deselect");
  } else {
    var_0 hudoutlineenable("outline_nodepth_cyan");
    setsaveddvar("MKOQSSQKLL", 2);
  }

  var_0.selected = 1;
  level.selected = var_0;
  wait 1;

  if(isnode(var_0)) {
    return;
  }
  var_0 hudoutlinedisable();
  return;
}

add_selectable(var_0) {
  if(!scripts\engine\utility::array_contains(level.selectable_ents, var_0))
    level.selectable_ents[level.selectable_ents.size] = var_0;
}

remove_selectable(var_0) {
  level.selectable_ents = scripts\engine\utility::array_remove(level.selectable_ents, var_0);
}

cleanup_selectable() {
  level.selectable_ents = scripts\engine\utility::array_removeundefined(level.selectable_ents);
}

selected_hint(var_0) {
  var_1 = newhudelem();
  var_1.y = 460;
  var_1.x = 320;
  var_1.alpha = 0.8;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.archived = 0;
  var_1 clearalltextafterhudelem();
  level.selectedhint = var_1;
}

cursor() {
  level.selectable_ents = [];
  level.cursor_pos = (0, 0, 0);
  init_crosshair();
  level notify("stop_cursor");
  level endon("stop_cursor");

  for(;;) {
    cursor_highlight();
    waitframe();
  }
}

cursor_highlight() {
  var_0 = level.player getEye();
  var_1 = anglesToForward(level.player getplayerangles());
  var_0 = var_0 + var_1 * 30;
  var_2 = var_0 + var_1 * 10000;
  var_3 = scripts\engine\trace::ray_trace_detail(var_0, var_2);
  var_4 = var_3["position"];
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_5 = get_selectable_ent(var_0, var_2, 40);

  if(isDefined(var_5)) {
    draw_highlight(var_5);
    level.highlighted_ent = var_5;
  } else {
    if(distance(var_3["position"], var_4) < 0.1) {
      if(is_place_clear(var_4))
        level.cursor_pos = var_4;
    }

    draw_axis();
    stop_previous_highlight();
    level.highlighted_ent = undefined;
  }
}

get_selectable_ent(var_0, var_1, var_2) {
  cleanup_selectable();
  return get_selectable_from_array(level.selectable_ents, level.selected_node, var_0, var_1, var_2);
}

get_selectable_from_array(var_0, var_1, var_2, var_3, var_4) {
  var_4 = squared(var_4);
  var_5 = var_4;
  var_6 = undefined;

  foreach(var_8 in var_0) {
    var_9 = var_8.origin;

    if(isent(var_8) && isai(var_8))
      var_9 = var_9 + (0, 0, 40);

    if(isDefined(var_1) && var_1 == var_8) {
      continue;
    }
    var_10 = pointonsegmentnearesttopoint(var_2, var_3, var_9);
    var_11 = distancesquared(var_10, var_9);

    if(var_11 < var_5) {
      var_5 = var_11;
      var_6 = var_8;
    }
  }

  return var_6;
}

draw_highlight(var_0) {
  var_1 = 4;
  var_2 = (1, 1, 0.5);
  var_3 = 1;
  var_4 = 1;

  if(isDefined(var_0.is_spawner)) {
    stop_previous_highlight();
    draw_spawner(var_0.origin, var_0.angles, var_2);
  } else if(!isDefined(level.selected) && (!isDefined(level.highlighted_ent) || level.highlighted_ent != var_0)) {
    stop_previous_highlight();

    if(isDefined(var_0.onhighlight))
      var_0 thread[[var_0.onhighlight]]();

    if(isnode(var_0))
      var_0 thread draw_box_forever(var_0.origin + (0, 0, 16), 32, (1, 1, 0), var_0.angles, 32);
    else
      var_0 hudoutlineenable("outline_nodepth_orange");
  }
}

stop_previous_highlight() {
  if(!isDefined(level.highlighted_ent)) {
    return;
  }
  level.highlighted_ent notify("stop_highlight");

  if(isnode(level.highlighted_ent)) {
    return;
  }
  if(isDefined(level.selected) && level.selected == level.highlighted_ent) {
    return;
  }
  level.highlighted_ent hudoutlinedisable();
}

draw_spawner(var_0, var_1, var_2) {
  var_3 = var_0 + anglesToForward(var_1) * 20;
  _draw_arrow(var_0 + (0, 0, 36), var_3 + (0, 0, 36), var_2);
  draw_box(var_0, var_2, var_1, 72);
}

_draw_arrow(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_1 - var_0);
  var_4 = length(var_1 - var_0);
  var_5 = anglesToForward(var_3);
  var_6 = var_5 * var_4;
  var_7 = 5;
  var_8 = var_5 * (var_4 - var_7);
  var_9 = anglestoright(var_3);
  var_10 = var_9 * (var_7 * -1);
  var_11 = var_9 * var_7;
}

draw_box_forever(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5))
    self endon(var_5);
  else
    self endon("stop_highlight");

  for(;;) {
    draw_box(var_0, var_1, var_2, var_3, var_4);
    waitframe();
  }
}

draw_box(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  if(!isDefined(var_1))
    var_1 = 32;

  if(!isDefined(var_4))
    var_4 = 32;

  var_5 = anglesToForward(var_3);
}

draw_axis() {
  var_0 = 5;
  var_1 = level.cursor_pos;
  var_2 = 1;
  var_3 = 1;
}

init_crosshair() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  var_0 = newhudelem();
  var_0.location = 0;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.foreground = 1;
  var_0.fontscale = 1;
  var_0.sort = 20;
  var_0.alpha = 1;
  var_0.x = 320;
  var_0.y = 237;
  var_0.archived = 0;
}

is_place_clear(var_0) {
  var_1 = getdvarint("ai_place");
  var_2 = 6;
  var_3 = 360 / var_2;
  var_4 = squared(0.1);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = (-30, var_5 * var_3, 0);
    var_7 = anglesToForward(var_6);
    var_8 = var_0 + var_7 * 30;
    var_9 = scripts\engine\trace::ray_trace(var_0, var_8, undefined, scripts\engine\trace::create_solid_ai_contents(1));
    var_10 = var_9["position"];
    var_11 = distancesquared(var_10, var_8);

    if(var_11 > var_4)
      return 0;

    var_9 = scripts\engine\trace::ray_trace(var_8 + (0, 0, 42), var_8, undefined, scripts\engine\trace::create_solid_ai_contents(1));
    var_10 = var_9["position"];

    if(var_11 > var_4)
      return 0;
  }

  return 1;
}