/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\debug_menu.gsc
***********************************************/

function init_menus() {
  level.menu_sys = [];
  level.menu_sys["current_menu"] = spawnStruct();
  init_buttons();
  thread menu_input();
}

function add_menu(var0, var1, var2) {
  if(menu_exists(var0)) {
    return;
  }

  level.menu_sys[var0] = spawnStruct();
  level.menu_sys[var0].title = var1;
  level.menu_sys[var0].page = 0;
  level.menu_sys[var0].can_exit = istrue(var2);
}

function menu_exists(var0) {
  return isDefined(level.menu_sys[var0]);
}

function add_menuoptions(var0, var1, var2, var3, var4) {
  if(!isDefined(level.menu_sys[var0].options)) {
    level.menu_sys[var0].options = [];
    level.menu_sys[var0].optionsvalue = [];
  }

  var5 = level.menu_sys[var0].options.size;
  level.menu_sys[var0].options[var5] = var1;
  level.menu_sys[var0].function[var5] = var2;
  level.menu_sys[var0].backfunction[var5] = var3;

  if(isDefined(var4)) {
    level.menu_sys[var0].optionsvalue[var5] = var4;
    return;
  }
}

function add_menuent(var0, var1) {
  level.menu_sys[var0].ent = var1;
}

function add_menu_child(var0, var1, var2, var3, var4) {
  if(!isDefined(level.menu_sys[var1])) {
    add_menu(var1, var2);
  }

  level.menu_sys[var1].parent_menu = var0;

  if(!isDefined(level.menu_sys[var0].children_menu)) {
    level.menu_sys[var0].children_menu = [];
  }

  if(!isDefined(var3)) {
    var5 = level.menu_sys[var0].children_menu.size;
  } else {
    var5 = var4;
  }

  level.menu_sys[var1].children_menu[var5] = var2;

  if(isDefined(var5)) {
    if(!isDefined(level.menu_sys[var1].children_func)) {
      level.menu_sys[var1].children_func = [];
    }

    level.menu_sys[var1].children_func[var5] = var5;
    return;
  }
}

function enable_menu(var0) {
  disable_menu("current_menu");

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor.current_pos = 0;
    menu_cursor_resetpos();
  }

  level.menu_sys["current_menu"].title = set_menu_hudelem(level.menu_sys[var0].title, "title");
  level.menu_sys["current_menu"].menu_name = var0;

  if(isDefined(level.menu_sys[var0].options)) {
    draw_menu_options(var0);
  }

  if(isDefined(level.menu_sys[var0].ent)) {
    level.menu_sys["current_menu"].ent = level.menu_sys[var0].ent;
  }

  menu_cursor();
  menu_highlight("current_menu", level.menu_cursor.current_pos);
}

function exit_menu() {
  level notify("exit_menu");
  level.exitmenu = 1;
}

function draw_menu_options(var0) {
  var1 = level.menu_sys[var0].options;
  var2 = level.menu_sys[var0].page;

  for(var3 = 0; var3 < 20 && var3 + var2 * 20 < var1.size; var3++) {
    var4 = var3 + var2 * 20;
    var5 = var4 + 1 + ". " + var1[var4];
    level.menu_sys["current_menu"].options[var3] = set_menu_hudelem(var5, "options", int(25) * var3);

    if(isDefined(level.menu_sys[var0].optionsvalue[var4])) {
      var6 = level.menu_sys[var0].optionsvalue[var4];
      var7 = set_menu_hudelem(var6, "value", int(25) * var3);

      if(scripts\common\utility::iscp()) {
        var7.x += int(247.5);
      } else {
        var7.x += int(207.5);
      }

      level.menu_sys["current_menu"].optionsvalue[var3] = var7;
    }
  }

  if(var1.size > 20) {
    var5 = "";

    if(var2 > 0) {
      var5 += "<-- Prev ";
    }

    if(var2 < floor(var1.size / 20)) {
      var5 += "Next -->";
    }

    if(var5 != "") {
      level.menu_sys["current_menu"].options[var3] = set_menu_hudelem(var5, "options", int(25) * var3);
      var3++;
    }
  }

  if(level.menu_sys[var0].can_exit) {
    level.menu_sys["current_menu"].options[var3] = set_menu_hudelem("Exit", "options", int(25) * var3);
    return;
  }
}

function disable_menu(var0) {
  level notify("stop_all_menus");

  if(isDefined(level.menu_sys[var0])) {
    if(isDefined(level.menu_sys[var0].title)) {
      scripthuddestroy(level.menu_sys[var0].title);
    }

    if(isDefined(level.menu_sys[var0].options)) {
      clear_menu_options(var0);
    }
  }

  level.menu_sys[var0].title = undefined;
  level.menu_sys[var0].menu_name = undefined;
  level.menu_sys[var0].ent = undefined;

  if(isDefined(level.menu_cursor)) {
    scripthuddestroy(level.menu_cursor);
    return;
  }
}

function clear_menu_options(var0) {
  var1 = level.menu_sys[var0].options;

  for(var2 = 0; var2 < var1.size; var2++) {
    if(isDefined(var1[var2].extrahuds)) {
      foreach(var4 in var1[var2].extrahuds) {
        if(isDefined(var4)) {
          scripthuddestroy(var4);
        }
      }
    }

    scripthuddestroy(var1[var2]);

    if(!isDefined(level.menu_sys[var0].optionsvalue)) {
      continue;
    }

    if(isDefined(level.menu_sys[var0].optionsvalue[var2])) {
      scripthuddestroy(level.menu_sys[var0].optionsvalue[var2]);
    }
  }

  level.menu_sys[var0].options = [];

  if(isDefined(level.menu_sys[var0].optionsvalue)) {
    level.menu_sys[var0].optionsvalue = [];
    return;
  }
}

function destroy_menu(var0) {
  level.menu_sys[var0] = undefined;
}

function set_menu_hudelem(var0, var1, var2) {
  if(scripts\common\utility::iscp()) {
    var3 = 60;
  } else {
    var3 = 20;
  }

  var4 = 300;

  if(var2 == "title") {
    var5 = 1.375;
  } else {
    var5 = 1.25;
    var5 += int(25);
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var5 += var3;
  return set_scripthud(var2, var4, var5, var5);
}

function set_hudelem(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 20;
  }

  var6 = newhudelem();
  var6.location = 0;
  var6.alignx = "left";
  var6.aligny = "bottom";
  var6.vertalign = "fullscreen";
  var6.horzalign = "fullscreen";
  var6.foreground = 1;
  var6.fontscale = var3;
  var6.sort = var5;
  var6.alpha = var4;
  var6.x = var1;
  var6.y = var2;
  var6.og_scale = var3;
  var6.archived = 0;

  if(isDefined(var0)) {
    var6.text = var0;

    if(isnumber(var0)) {
      var6 setvalue(var0);
    } else {
      var6 clearalltextafterhudelem();
    }
  }

  return var6;
}

function set_scripthud(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = 2;
  }

  var5 = newscripthud();
  var5.x = var1;
  var5.y = var2;
  var5.scale = var3;

  if(isDefined(var0)) {
    var5.text = var0;
  }

  if(isDefined(var4)) {
    var6 = scripts\engine\math::lerp(var5.color[0] * 0.6, var5.color[0], var4);
    var7 = scripts\engine\math::lerp(var5.color[1] * 0.6, var5.color[1], var4);
    var8 = scripts\engine\math::lerp(var5.color[2] * 0.6, var5.color[2], var4);
    var5.color = (var6, var7, var8);
  }

  return var5;
}

function newscripthud() {
  var0 = spawnStruct();
  var0.x = 0;
  var0.y = 0;
  var0.text = "";
  var0.color = (1, 1, 1);
  var0.scale = 2;
  var0.isscripted = 1;
  var0.alive = 1;
  thread scripthudthread();
  return var0;
}

function scripthudthread() {
  while(self.alive) {
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

function newscriptcursor(var0, var1) {
  var2 = spawnStruct();
  var2.x = var0;
  var2.y = var1;
  var2.text = ">";
  var2.color = (0.8, 0.1, 0.1);
  var2.scale = 2;
  var2.isscripted = 1;
  var2.alive = 1;
  thread scripthudthread();
  return var2;
}

function menu_input() {
  level notify("stop_menu_input");
  level endon("stop_menu_input");

  for(;;) {
    level waittill("menu_button_pressed", var0);

    if(!isDefined(level.menu_cursor) || isDefined(level.debug) && isDefined(level.debug.debug_start) && level.debug.debug_start) {
      wait 0.1;
      continue;
    }

    var1 = level.menu_sys["current_menu"].menu_name;

    if(!isDefined(var1)) {
      continue;
    }

    var2 = 0;
    var2 = 0;
    var2 = 0;

    if(var0 == "dpad_up" || var0 == "uparrow") {
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
    } else if(var0 == "dpad_down" || var0 == "downarrow") {
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
    } else if(var0 == "button_a" || var0 == "dpad_right" || var0 == "dpad_left" || var0 == "rightarrow" || var0 == "leftarrow") {
      if(var0 == "dpad_left" || var0 == "leftarrow") {
        var2 = 1;
      }

      var3 = level.menu_cursor.current_pos;
    } else {
      var3 = int(var0) - 1;
    }

    if(level.player buttonPressed("lshift") || level.player buttonPressed("rshift")) {
      var2 = 1;
    }

    if(level.menu_sys[var1].can_exit) {
      var4 = 2;
    } else {
      var4 = 1;
    }

    if(var3 >= level.menu_sys["current_menu"].options.size) {
      continue;
    } else if(level.menu_sys[var1].can_exit && var3 == level.menu_sys["current_menu"].options.size - 1) {
      level notify("exit_menu");
      level.exitmenu = 1;
      continue;
    } else if(level.menu_sys[var1].options.size > 20 && var3 == level.menu_sys["current_menu"].options.size - var4) {
      var5 = 0;

      if(var2["shift"] && level.menu_sys[var1].page > 0) {
        level.menu_sys[var1].page--;
        var5 = 1;
      } else if(!var2["shift"] && level.menu_sys[var1].page < floor(level.menu_sys[var1].options.size / 20)) {
        level.menu_sys[var1].page++;
        var5 = 1;
      }

      if(var5) {
        var6 = level.menu_sys["current_menu"].options.size;
        clear_menu_options("current_menu");
        draw_menu_options(var1);

        if(level.menu_sys["current_menu"].options.size != var6) {
          level.menu_cursor.y = 300 + (level.menu_sys["current_menu"].options.size - var4 + 1) * int(25);
          level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - var4;
        }
      }

      continue;
    } else {
      var7 = var3;
      var3 += level.menu_sys[var1].page * 20;
    }

    if(isDefined(level.menu_sys[var1].parent_menu) && var3 == level.menu_sys[var1].options.size) {
      level notify("disable " + var1);
      enable_menu(level, level.menu_sys[var1].parent_menu);
    } else if(isDefined(level.menu_sys[var1].function) && isDefined(level.menu_sys[var1].function[var3])) {
      var8 = undefined;

      if(!var2["shift"]) {
        var8 = level.menu_sys[var1].function[var3];
      } else if(isDefined(level.menu_sys[var1].backfunction)) {
        var8 = level.menu_sys[var1].backfunction[var3];
      }

      if(isDefined(var8)) {
        var9 = level;

        if(isDefined(level.menu_sys["current_menu"].ent)) {
          var9 = level.menu_sys["current_menu"].ent;
        }

        var10 = var9[[var8]]();

        if(isDefined(var10)) {
          level.menu_sys["current_menu"].optionsvalue[var7].text = var10;

          if(isDefined(level.menu_sys["current_menu"].optionsvalue[var7].isscripted)) {
            level.menu_sys["current_menu"].optionsvalue[var7].text = var10;
          } else if(isnumber(var10)) {
            level.menu_sys["current_menu"].optionsvalue[var7] setvalue(var10);
          } else {
            level.menu_sys["current_menu"].optionsvalue[var7] clearalltextafterhudelem();
          }
        }
      }
    }

    if(!isDefined(level.menu_sys[var1].children_menu)) {
      continue;
    } else if(!isDefined(level.menu_sys[var1].children_menu[var3])) {
      continue;
    } else if(!isDefined(level.menu_sys[level.menu_sys[var1].children_menu[var3]])) {
      continue;
    }

    if(isDefined(level.menu_sys[var1].children_func) && isDefined(level.menu_sys[var1].children_func[var3])) {
      var8 = level.menu_sys[var1].children_func[var3];
      var11 = [[var8]]();

      if(isDefined(var11)) {
        thread selection_error(level, var11, level.menu_sys["current_menu"].options[var7].x);
        continue;
      }
    }

    enable_menu(level, level.menu_sys[var1].children_menu[var3]);
    wait 0.1;
  }
}

function menu_highlight(var0, var1) {
  foreach(var3 in level.menu_sys[var0].options) {
    var3.color = (1, 1, 1);
  }

  if(isDefined(level.menu_sys[var0].optionsvalue)) {
    foreach(var3 in level.menu_sys[var0].optionsvalue) {
      var3.color = (1, 1, 1);
    }
  }

  if(isDefined(level.menu_sys[var0].optionsvalue) && isDefined(level.menu_sys[var0].optionsvalue[var1])) {
    level.menu_sys[var0].optionsvalue[var1].color = (1, 1, 0);
  }

  level.menu_sys[var0].options[var1].color = (1, 1, 0);
}

function hud_selector(var0, var1) {}

function hud_selector_fade_out(var0) {}

function menu_get_selected_optionsvalue(var0) {
  if(!isDefined(var0)) {
    var0 = level.menu_cursor.current_pos;
  }

  return level.menu_sys["current_menu"].optionsvalue[var0];
}

function get_current_menu_name() {
  return level.menu_sys["current_menu"].menu_name;
}

function menu_get_selected(var0) {
  if(!isDefined(var0)) {
    var0 = level.menu_cursor.current_pos;
  }

  return level.menu_sys["current_menu"].options[var0];
}

function menu_get_selected_text() {
  var0 = level.menu_cursor.current_pos;
  return level.menu_sys["current_menu"].options[var0].text;
}

function selection_error(var0, var1, var2) {
  var3 = set_hudelem(undefined, var1 - 10, var2, 1);

  if(scripts\common\utility::iscp()) {
    var3 setshader("white", int(247.5), 20);
  } else {
    var3 setshader("white", int(207.5), 20);
  }

  var3.color = (0.5, 0, 0);
  var3.alpha = 0.7;

  if(scripts\common\utility::iscp()) {
    var4 = set_hudelem(var0, var1 + int(247.5), var2, 1);
  } else {
    var4 = set_hudelem(var1, var2 + int(207.5), var3, 1);
  }

  var4.color = (1, 0, 0);

  if(!isDefined(var4.debug_hudelem)) {
    var4 fadeovertime(3);
  }

  var4.alpha = 0;

  if(!isDefined(var4.debug_hudelem)) {
    var4 fadeovertime(3);
  }

  var4.alpha = 0;
  wait 3.1;
  var4 destroy();
  var4 destroy();
}

function menu_cursor() {
  level.menu_cursor = newscriptcursor(0, 300 + int(25));
  level.menu_cursor.current_pos = 0;
  menu_cursor_resetpos();
}

function menu_cursor_resetpos() {
  level.menu_cursor.x = 0;
  level.menu_cursor.y = 300 + int(25) + 6;
}

function add_extrahuds(var0) {
  if(!isDefined(self.extrahuds)) {
    self.extrahuds = [];
  }

  self.extrahuds[self.extrahuds.size] = var0;
}

function list_menu(var0, var1, var2, var3, var4, var5) {
  level endon("stop_all_menus");
  var6 = menu_get_selected();

  if(!isDefined(var0) || var0.size == 0) {
    return -1;
  }

  var7 = [];
  var8 = 25;
  var9 = set_scripthud("->", var1 - 20, var2, 1.25, 1);
  var9.color = (0.8, 0.1, 0.1);
  add_extrahuds(var6, var9);

  if(scripts\common\utility::issp()) {
    var10 = 5;
    var11 = 2;
  } else {
    var10 = 3;
    var11 = 1;
  }

  for(var12 = 0; var12 < var10; var12++) {
    if(var12 == 0) {
      var13 = 0.3;
    } else if(var12 == 1) {
      var13 = 0.6;
    } else if(var12 == 2) {
      var13 = 1;
    } else if(var12 == 3) {
      var13 = 0.6;
    } else {
      var13 = 0.3;
    }

    var14 = set_scripthud(var2[var12], var3, var4 + (var12 - var11) * var10, 1.25, var13);
    add_extrahuds(var8, var14);
    var9 = scripts\engine\utility::array_add(var9, var14);
  }

  if(isDefined(var7)) {
    move_list_menu(var9, var2, var7, var11);
  } else {
    move_list_menu(var9, var2, 0, var11);
  }

  var15 = 0;
  var16 = 0;
  var17 = 0;
  level.menu_list_selected = 0;
  jumpiffalse(isDefined(var5)) LOC_00000155;
  [[var5]](var2[var15]);

  for(;;) {
    level waittill("menu_button_pressed", var18);

    if(!isDefined(level.menu_cursor)) {
      var17 = 0;
      break;
    }

    level.menu_list_selected = 1;

    if(any_button_hit(var18, "numbers")) {
      break;
    } else if(var18 == "downarrow" || var18 == "dpad_down") {
      if(var15 >= var2.size - 1) {
        var15 = 0;
        move_list_menu(var9, var2, var15, var11);
        continue;
      }

      var15++;
      move_list_menu(var9, var2, var15, var11);
    } else if(var18 == "uparrow" || var18 == "dpad_up") {
      if(var15 <= 0) {
        var15 = var2.size - 1;
        move_list_menu(var9, var2, var15, var11);
        continue;
      }

      var15--;
      move_list_menu(var9, var2, var15, var11);
    } else if(var18 == "pgup") {
      if(var15 <= 0) {
        var15 = var2.size - 1;
        move_list_menu(var9, var2, var15, var11);
        continue;
      }

      var15 -= 5;
      var15 = clamp(var15, 0, var2.size - 1);
      var15 = int(var15);
      move_list_menu(var9, var2, var15, var11);
    } else if(var18 == "pgdn") {
      if(var15 >= var2.size - 1) {
        var15 = 0;
        move_list_menu(var9, var2, var15, var11);
        continue;
      }

      var15 += 5;
      var15 = clamp(var15, 0, var2.size - 1);
      var15 = int(var15);
      move_list_menu(var9, var2, var15, var11);
    } else if(var18 == "enter" || var18 == "button_a" || var18 == "dpad_right" || var18 == "rightarrow") {
      var17 = 1;
      break;
    } else if(var18 == "end" || var18 == "button_b" || var18 == "dpad_left" || var18 == "leftarrow") {
      var17 = 0;
      break;
    }

    level notify("scroll_list");

    if(var15 != var16) {
      var16 = var15;

      if(isDefined(var5)) {
        [[var5]](var2[var15]);
      }
    }

    wait 0.1;
  }

  if(var11.isscripted) {
    scripthuddestroy(var11);
  } else {
    var11 destroy();
  }

  for(var12 = 0; var12 < var9.size; var12++) {
    if(var9[var12].isscripted) {
      scripthuddestroy(var9[var12]);
      continue;
    }

    var9[var12] destroy();
  }

  if(var17) {
    return var15;
  }
}

function move_list_menu(var0, var1, var2, var3) {
  for(var4 = 0; var4 < var0.size; var4++) {
    var5 = var4 + var2 - var3;

    if(isDefined(var1[var5])) {
      var6 = var1[var5];
    } else if(var5 < 0) {
      var6 = var1[var1.size + var5];
    } else {
      var6 = var1[var5 % var1.size];
    }

    var0[var4].archived = 0;

    if(isDefined(var0[var4].isscripted)) {
      var0[var4].text = var6;
      continue;
    }

    var0[var4] clearalltextafterhudelem();
  }
}

function can_exit() {
  if(isDefined(level.exitmenu)) {
    level.exitmenu = undefined;
    return true;
  }

  if(isai(self) && !isalive(self)) {
    return true;
  }

  return false;
}

function add_universal_button(var0, var1) {
  if(!isDefined(level.u_buttons[var0])) {
    level.u_buttons[var0] = [];
  }

  if(array_check_for_dupes(level.u_buttons[var0], var1)) {
    level.u_buttons[var0][level.u_buttons[var0].size] = var1;
    return;
  }
}

function array_check_for_dupes(var0, var1) {
  for(var2 = 0; var2 < var0.size; var2++) {
    if(var0[var2] == var1) {
      return false;
    }
  }

  return true;
}

function clear_universal_buttons(var0) {
  level.u_buttons[var0] = [];
}

function universal_input_loop(var0, var1, var2, var3, var4) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level endon(var1);

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var5 = var0 + "_button_pressed";
  var6 = level.u_buttons[var0];
  level.u_buttons_disable[var0] = 0;

  for(;;) {
    if(level.u_buttons_disable[var0]) {
      waitframe();
      continue;
    }

    if(isDefined(var3) && !level.player buttonPressed(var3)) {
      waitframe();
      continue;
    } else if(isDefined(var4) && level.player buttonPressed(var4)) {
      waitframe();
      continue;
    }

    if(var2 && level.player attackButtonPressed()) {
      level notify(var5, "fire");
      wait 0.1;
      continue;
    }

    for(var7 = 0; var7 < var6.size; var7++) {
      if(level.player buttonPressed(var6[var7])) {
        level notify(var5, var6[var7]);
        wait 0.1;
        break;
      }
    }

    waitframe();
  }
}

function any_button_hit(var0, var1) {
  var2 = [];

  if(var1 == "numbers") {
    GscBinSkip0(0x2e, 0, "0");
  }

  var2 = level.buttons;

  for(var3 = 0; var3 < var2.size; var3++) {
    if(var0 == var2[var3]) {
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
  add_universal_button("menu", "downarrow");
  add_universal_button("menu", "uparrow");
  add_universal_button("menu", "leftarrow");
  add_universal_button("menu", "rightarrow");
  add_universal_button("menu", "enter");
  thread universal_input_loop(level, "menu", "never", undefined, undefined);
}

function init_selection_and_cursor() {
  thread input_loop();
  thread cursor();
}

function input_loop() {
  var0 = 0;
  level.g_nextusepress = 0;

  for(;;) {
    if(gettime() > level.g_nextusepress && level.player useButtonPressed() || isDefined(level.force_select_ent)) {
      if(isDefined(level.force_select_ent)) {
        level.highlighted_ent = level.force_select_ent;
      }

      level.g_nextusepress = gettime() + 400;

      if(isDefined(level.highlighted_ent)) {
        if(isDefined(level.highlighted_ent.usefunc)) {
          level.highlighted_ent thread[[level.highlighted_ent.usefunc]]();
        }

        if(isDefined(level.highlighted_ent.onselect)) {
          level.highlighted_ent[[level.highlighted_ent.onselect]]();
        } else if(isDefined(level.highlighted_ent.select_func)) {
          level.highlighted_ent[[level.highlighted_ent.select_func]]();
        }
      }

      if(isDefined(level.force_select_ent)) {
        level.force_select_ent = undefined;
      }

      wait 0.2;
    }

    waitframe();
  }
}

function deselect() {
  if(!isDefined(level.selected)) {
    return;
  }

  if(isDefined(level.selectedhint)) {
    level.selectedhint destroy();
  }

  level notify("deselect");
  level.selected.selected = 0;
  level.selected notify("deselect");

  if(!isnode(level.selected)) {
    level.selected hudoutlinedisable();
  }

  level.selected = undefined;
  setsaveddvar("MKOQSSQKLL", 2);

  if(isDefined(level.followcam_enabled) && isDefined(level.func["followcam"])) {
    [[level.func["followcam"]]](0);
    return;
  }
}

function force_select(var0) {
  level.force_select_ent = var0;
}

function select(var0) {
  deselect();
  var0 endon("death");

  if(isnode(var0)) {
    var0 notify("stop_highlight");
    thread draw_box_forever(var0, var0.origin + (0, 0, 16), 32, (0.2, 1, 0.2), var0.angles, 32);
  } else {
    var0 hudoutlineenable("outline_nodepth_cyan");
    setsaveddvar("MKOQSSQKLL", 2);
  }

  var0.selected = 1;
  level.selected = var0;
  wait 1;

  if(isnode(var0)) {
    return;
  }

  var0 hudoutlinedisable();
}

function add_selectable(var0) {
  if(!scripts\engine\utility::array_contains(level.selectable_ents, var0)) {
    level.selectable_ents[level.selectable_ents.size] = var0;
    return;
  }
}

function remove_selectable(var0) {
  level.selectable_ents = scripts\engine\utility::array_remove(level.selectable_ents, var0);
}

function cleanup_selectable() {
  level.selectable_ents = scripts\engine\utility::array_removeundefined(level.selectable_ents);
}

function selected_hint(var0) {
  var1 = newhudelem();
  var1.y = 460;
  var1.x = 320;
  var1.alpha = 0.8;
  var1.alignx = "center";
  var1.aligny = "middle";
  var1.archived = 0;
  var1 clearalltextafterhudelem();
  level.selectedhint = var1;
}

function cursor() {
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

function cursor_highlight() {
  var0 = level.player getEye();
  var1 = anglesToForward(level.player getplayerangles());
  var0 += var1 * 30;
  var2 = var0 + var1 * 10000;
  var3 = scripts\engine\trace::ray_trace_detail(var0, var2);
  var4 = var3["position"];
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var5 = get_selectable_ent(var0, var2, 40);

  if(isDefined(var5)) {
    draw_highlight(var5);
    level.highlighted_ent = var5;
    return;
  }

  if(distance(var3["position"], var4) < 0.1) {
    if(is_place_clear(var4)) {
      level.cursor_pos = var4;
    }
  }

  draw_axis();
  stop_previous_highlight();
  level.highlighted_ent = undefined;
}

function get_selectable_ent(var0, var1, var2) {
  cleanup_selectable();
  return get_selectable_from_array(level.selectable_ents, level.selected_node, var0, var1, var2);
}

function get_selectable_from_array(var0, var1, var2, var3, var4) {
  var4 = squared(var4);
  var5 = var4;
  var6 = undefined;

  foreach(var8 in var0) {
    var9 = var8.origin;

    if(isent(var8) && isai(var8)) {
      var9 += (0, 0, 40);
    }

    if(isDefined(var1) && var1 == var8) {
      continue;
    }

    var10 = pointonsegmentnearesttopoint(var2, var3, var9);
    var11 = distancesquared(var10, var9);

    if(var11 < var5) {
      var5 = var11;
      var6 = var8;
    }
  }

  return var6;
}

function draw_highlight(var0) {
  var1 = 4;
  var2 = (1, 1, 0.5);
  var3 = 1;
  var4 = 1;

  if(isDefined(var0.is_spawner)) {
    stop_previous_highlight();
    draw_spawner(var0.origin, var0.angles, var2);
    return;
  }

  if(!isDefined(level.selected) && (!isDefined(level.highlighted_ent) || level.highlighted_ent != var0)) {
    stop_previous_highlight();

    if(isDefined(var0.onhighlight)) {
      var0 thread[[var0.onhighlight]]();
    }

    if(isnode(var0)) {
      thread draw_box_forever(var0, var0.origin + (0, 0, 16), 32, (1, 1, 0), var0.angles);
      return;
    }

    var0 hudoutlineenable("outline_nodepth_orange");
    return;
  }
}

function stop_previous_highlight() {
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

function draw_spawner(var0, var1, var2) {
  var3 = var0 + anglesToForward(var1) * 20;
  _draw_arrow(var0 + (0, 0, 36), var3 + (0, 0, 36), var2);
  draw_box(var0, var2, var1, 72);
}

function _draw_arrow(var0, var1, var2) {
  var3 = vectortoangles(var1 - var0);
  var4 = length(var1 - var0);
  var5 = anglesToForward(var3);
  var6 = var5 * var4;
  var7 = 5;
  var8 = var5 * (var4 - var7);
  var9 = anglestoright(var3);
  var10 = var9 * var7 * -1;
  var11 = var9 * var7;
}

function draw_box_forever(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var5)) {
    self endon(var5);
  } else {
    self endon("stop_highlight");
  }

  for(;;) {
    draw_box(var0, var1, var2, var3, var4);
    waitframe();
  }
}

function draw_box(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  if(!isDefined(var1)) {
    var1 = 32;
  }

  if(!isDefined(var4)) {
    var4 = 32;
  }

  var5 = anglesToForward(var3);
}

function draw_axis() {
  var0 = 5;
  var1 = level.cursor_pos;
  var2 = 1;
  var3 = 1;
}

function init_crosshair() {
  if(!scripts\common\utility::issp()) {
    return;
  }

  var0 = newhudelem();
  var0.location = 0;
  var0.alignx = "center";
  var0.aligny = "middle";
  var0.foreground = 1;
  var0.fontscale = 1;
  var0.sort = 20;
  var0.alpha = 1;
  var0.x = 320;
  var0.y = 237;
  var0.archived = 0;
}

function is_place_clear(var0) {
  var1 = getdvarint("ai_place");
  var2 = 6;
  var3 = 360 / var2;
  var4 = squared(0.1);

  for(var5 = 0; var5 < var2; var5++) {
    var6 = (-30, var5 * var3, 0);
    var7 = anglesToForward(var6);
    var8 = var0 + var7 * 30;
    var9 = scripts\engine\trace::ray_trace(var0, var8, undefined, scripts\engine\trace::create_solid_ai_contents(1));
    var10 = var9["position"];
    var11 = distancesquared(var10, var8);

    if(var11 > var4) {
      return false;
    }

    var9 = scripts\engine\trace::ray_trace(var8 + (0, 0, 42), var8, undefined, scripts\engine\trace::create_solid_ai_contents(1));
    var10 = var9["position"];

    if(var11 > var4) {
      return false;
    }
  }

  return true;
}