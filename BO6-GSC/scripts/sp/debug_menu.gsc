/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\debug_menu.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace debug_menu;

function init_menus(var_bed80ca198ef16b = 0) {
  utility::flag_init("b\x8e\x85ip\xdb\xec\x17\n\xe3v\xb6\x15\xd9{\x10");
  level.menu_sys = [];
  level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"] = spawnStruct();
  vidwidth = getdvarint(@ "vid_width", 1920);
  vidheight = getdvarint(@ "vid_height", 1080);
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"] = spawnStruct();
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings = [];
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].basecharwidth = 8;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0] = spawnStruct();
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0].menu_fontscale = 1.25;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0].var_2d838ae258511c51 = 18 * level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0].menu_fontscale;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0].var_6a93de87dd341c50 = [1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3];
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0].var_b5edb765b3202194 = 120;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0].var_f0febab094d5a40 = 20 + level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[0].var_b5edb765b3202194;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1] = spawnStruct();
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1].menu_fontscale = 2;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1].var_2d838ae258511c51 = 18 * level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1].menu_fontscale;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1].var_6a93de87dd341c50 = [1.5, 2, 3, 4, 6];
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1].var_b5edb765b3202194 = 180;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1].var_f0febab094d5a40 = 20 + level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[1].var_b5edb765b3202194;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2] = spawnStruct();
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2].menu_fontscale = 4;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2].var_2d838ae258511c51 = 18 * level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2].menu_fontscale;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2].var_6a93de87dd341c50 = [3, 4, 6, 8, 10];
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2].var_b5edb765b3202194 = 240;
  level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2].var_f0febab094d5a40 = 20 + level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[2].var_b5edb765b3202194;

  if(isDefined(vidheight)) {
    if(vidheight >= 2561) {
      level.var_d66835adb277b829 = 2;
    } else if(vidheight >= 1081) {
      level.var_d66835adb277b829 = 1;
    } else {
      level.var_d66835adb277b829 = 0;
    }
  } else {
    level.var_d66835adb277b829 = 0;
  }

  level.var_d66835adb277b829 = 0;
  level.var_1a2964ce71b1ea2 = 1;
  function_7a273026aee55652(level.var_d66835adb277b829);
  init_buttons();

  if(istrue(var_bed80ca198ef16b)) {
    level thread function_ae6cd338632c587a();
  }

  level thread menu_input();
  utility::flag_set("b\x8e\x85ip\xdb\xec\x17\n\xe3v\xb6\x15\xd9{\x10");
}

function function_e389e69fca2755e5(index = level.var_d66835adb277b829) {
  if(!isDefined(index)) {
    return;
  }

  return level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].fontsettings[index];
}

function function_7a273026aee55652(index = level.var_d66835adb277b829) {
  fontstruct = function_e389e69fca2755e5(index);
  level.fontinfo = fontstruct;
  level.menu_fontscale = fontstruct.menu_fontscale;
  level.var_2d838ae258511c51 = fontstruct.var_2d838ae258511c51;
  level.var_6a93de87dd341c50 = fontstruct.var_6a93de87dd341c50;
  level.var_156f599edad73cfd = fontstruct.var_6a93de87dd341c50[level.var_1a2964ce71b1ea2] * level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].basecharwidth;
  level.var_488329529499c33d = fontstruct.var_b5edb765b3202194;
  level.var_f0febab094d5a40 = fontstruct.var_f0febab094d5a40;
  return fontstruct;
}

function function_ae6cd338632c587a() {
  level waittill("\xcacc\x03\xac\x0f\xa9\x9fj\x93)\x9d\xbd\xcb\xf0\xa4\xe2", var_b5128184fe690601);
  add_menuoptions(var_b5128184fe690601, "\xb6\xe1\xea\xf9\xe9\x14\x80:L\xaa\xa3\xba :-\x84s\x8f\xa9\x94d\x1f\b,\\(\xd91\x8e\xda\xf7\xea\x91O\x14tu\x84\xdf\xf7\x9d\xc9\xcd2>\xe6}*\xb9\x89\"\r\f;", &function_32e6900a6ef8bd1a, &function_d383405c3c18a42e);
  enable_menu(var_b5128184fe690601);
}

function function_32e6900a6ef8bd1a() {
  function_cefc276690b54272(1);
}

function function_d383405c3c18a42e() {
  function_cefc276690b54272(0);
}

function function_cefc276690b54272(increase = 1) {
  if(istrue(increase)) {
    newindex = level.var_1a2964ce71b1ea2 + 1;

    if(newindex == level.var_6a93de87dd341c50.size) {
      newindex = 0;
    }
  } else {
    newindex = level.var_1a2964ce71b1ea2 - 1;

    if(newindex < 0) {
      newindex = level.var_6a93de87dd341c50.size - 1;
    }
  }

  level.menu_fontscale = level.var_6a93de87dd341c50[newindex];
  level.var_1a2964ce71b1ea2 = newindex;
  currentmenu = level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name;
  level.var_156f599edad73cfd = level.var_6a93de87dd341c50[level.var_1a2964ce71b1ea2] * level.menu_sys["S\xaa]T%\xda\xf3y\xdaz'\xaf\xf4"].basecharwidth;
  enable_menu(currentmenu, level.menu_cursor.current_pos);
}

function add_menu(menu_name, title, can_exit) {
  if(menu_exists(menu_name)) {
    println("<dev string:x24>" + menu_name + "<dev string:x3a>");
    return;
  }

  level.menu_sys[menu_name] = spawnStruct();
  level.menu_sys[menu_name].title = title;
  level.menu_sys[menu_name].page = 0;
  level.menu_sys[menu_name].can_exit = istrue(can_exit);
  level notify("t\x81\xc6wNe\x7fO\x86\x1dx\xd5+\xcd\xce\x1a", menu_name);
}

function menu_exists(menu_name) {
  return isDefined(level.menu_sys[menu_name]);
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

function add_menuent(menu_name, ent) {
  level.menu_sys[menu_name].ent = ent;
}

function add_menu_child(parent_menu, child_menu, child_title, var_2d98f8c038ba13c9, func) {
  if(!isDefined(level.menu_sys[child_menu])) {
    add_menu(child_menu, child_title);
  }

  level.menu_sys[child_menu].parent_menu = parent_menu;

  if(!isDefined(level.menu_sys[parent_menu].children_menu)) {
    level.menu_sys[parent_menu].children_menu = [];
  }

  if(!isDefined(var_2d98f8c038ba13c9)) {
    size = level.menu_sys[parent_menu].children_menu.size;
  } else {
    size = var_2d98f8c038ba13c9;
  }

  level.menu_sys[parent_menu].children_menu[size] = child_menu;

  if(isDefined(func)) {
    if(!isDefined(level.menu_sys[parent_menu].children_func)) {
      level.menu_sys[parent_menu].children_func = [];
    }

    level.menu_sys[parent_menu].children_func[size] = func;
  }
}

function enable_menu(menu_name, cursorpos = undefined) {
  disable_menu("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH");

  if(isDefined(cursorpos)) {
    var_66b3128a4f34d42e = level.menu_cursor.y;
  }

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor.current_pos = 0;
    menu_cursor_resetpos();
  }

  level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].title = set_menu_hudelem(level.menu_sys[menu_name].title, "\xf3\xc4\xb0&&");
  level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name = menu_name;

  if(isDefined(level.menu_sys[menu_name].options)) {
    draw_menu_options(menu_name);
  }

  if(isDefined(level.menu_sys[menu_name].ent)) {
    level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].ent = level.menu_sys[menu_name].ent;
  }

  menu_cursor();
  menu_highlight("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH", level.menu_cursor.current_pos);

  if(isDefined(cursorpos)) {
    level.menu_cursor.current_pos = cursorpos;
    level.menu_cursor.y = var_66b3128a4f34d42e;
    menu_highlight("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH", cursorpos);
  }

  level notify("\xcacc\x03\xac\x0f\xa9\x9fj\x93)\x9d\xbd\xcb\xf0\xa4\xe2", menu_name);
}

function exit_menu() {
  level notify("\xf6\x86**Q\xde\xaa8C");
  level.exitmenu = 1;
}

function draw_menu_options(menu_name) {
  options = level.menu_sys[menu_name].options;
  page = level.menu_sys[menu_name].page;

  for(i = 0; i < 20 && i + page * 20 < options.size; i++) {
    actual_index = i + page * 20;
    text = actual_index + 1 + "M\x93" + options[actual_index];
    level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[i] = set_menu_hudelem(text, "$\xb2N2~\xe8\x82", int(level.var_2d838ae258511c51) * i);

    if(isDefined(level.menu_sys[menu_name].optionsvalue[actual_index])) {
      val = level.menu_sys[menu_name].optionsvalue[actual_index];
      stringlength = text.size;
      var_fc2fe75425fd2e98 = stringlength * level.var_156f599edad73cfd;
      xoffset = level.var_f0febab094d5a40 + var_fc2fe75425fd2e98;
      hud = set_menu_hudelem(val, "\x8ew\n\x8cT", int(level.var_2d838ae258511c51) * i, xoffset);
      hud.x = xoffset;
      level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[i] = hud;
    }
  }

  if(options.size > 20) {
    text = "";

    if(page > 0) {
      text += "(\xa7,\xd7\xba\x9d3\x19x\xc8p";
    }

    if(page < floor(options.size / 20)) {
      text += "\x87sV/aR7\x1c";
    }

    if(text != "") {
      level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[i] = set_menu_hudelem(text, "$\xb2N2~\xe8\x82", int(level.var_2d838ae258511c51) * i);
      i++;
    }
  }

  if(level.menu_sys[menu_name].can_exit) {
    level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[i] = set_menu_hudelem("p\xb0\xc0\xda", "$\xb2N2~\xe8\x82", int(level.var_2d838ae258511c51) * i);
  }
}

function disable_menu(menu_name) {
  level notify("nxG\x9f\xb8J\x16 \x90G9~\xb4N");

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

function set_menu_hudelem(text, type, y_offset, x_offset) {
  if(!isDefined(x_offset)) {
    x = 20;
  } else {
    x = x_offset;
  }

  y = 300;

  if(type == "\xf3\xc4\xb0&&") {
    scale = 1.1 * level.menu_fontscale;
  } else {
    scale = level.menu_fontscale;
    y += int(level.var_2d838ae258511c51);
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
  hud.alignx = "=\xff0b";
  hud.aligny = "\x14#\x01\x89\f\x81";
  hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
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

function set_scripthud(text, x, y, scale, fakealpha) {
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

  if(isDefined(fakealpha)) {
    r = math::lerp(hud.color[0] * 0.5, hud.color[0], fakealpha);
    g = math::lerp(hud.color[1] * 0.5, hud.color[1], fakealpha);
    b = math::lerp(hud.color[2] * 0.5, hud.color[2], fakealpha);
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
  struct.alpha = 1;
  struct.isscripted = 1;
  struct.alive = 1;
  struct thread scripthudthread();
  return struct;
}

function scripthudthread() {
  while(self.alive) {
    if(self.alpha > 0) {
      printtoscreen2d(self.x, self.y, self.text, self.color, self.scale);
    }

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
  struct.text = "[";
  struct.color = (0.8, 0.1, 0.1);
  struct.scale = 2;
  struct.isscripted = 1;
  struct.alive = 1;
  struct.alpha = 1;
  struct thread scripthudthread();
  return struct;
}

function menu_input() {
  level notify("\x05A\x8dCR\x9by J\xf2}axyc");
  level endon("\x05A\x8dCR\x9by J\xf2}axyc");

  while(true) {
    level waittill("\xc9\x10)\x92\xdeh\xc5\x96\xbb\x82\x15\tC\xe3%\"xq\xb0", keystring);

    if(!isDefined(level.menu_cursor) || isDefined(level.debug) && isDefined(level.debug.debug_start) && level.debug.debug_start) {
      wait 0.1;
      continue;
    }

    menu_name = level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name;

    if(!isDefined(menu_name)) {
      continue;
    }

    modifiers["x{\x90\xaf\xb8"] = 0;
    modifiers["\f\x9f\x05\x12"] = 0;
    modifiers["%m\b"] = 0;

    if(keystring == "\xac\xae\xca\xa5g\xf6\xd4" || keystring == "]8,\x9c\x93\xbd\xbb") {
      if(level.menu_cursor.current_pos > 0) {
        level.menu_cursor.y -= int(level.var_2d838ae258511c51);
        level.menu_cursor.current_pos--;
      } else if(level.menu_cursor.current_pos == 0) {
        level.menu_cursor.y += (level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) * int(level.var_2d838ae258511c51);
        level.menu_cursor.current_pos = level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1;
      }

      menu_highlight("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH", level.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(keystring == "\xd6MRJ\xa5p~h\x01" || keystring == "\xdd\x10\xb6\x0e\xa7(\xeb\xceO") {
      if(level.menu_cursor.current_pos < level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) {
        level.menu_cursor.y += int(level.var_2d838ae258511c51);
        level.menu_cursor.current_pos++;
      } else if(level.menu_cursor.current_pos == level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) {
        level.menu_cursor.y += level.menu_cursor.current_pos * int(level.var_2d838ae258511c51) * -1;
        level.menu_cursor.current_pos = 0;
      }

      menu_highlight("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH", level.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(keystring == "^\xbfl:\x05\xcb\x1e\x88" || keystring == "\xd8\xd3\xc2\xc5\xf6\xb8\x03\x92U\xee" || keystring == "\x91\xe0,#\xfa\xd8\xb2\xcc:" || keystring == "'\x10O\x94L\xc9\xd6Z\xde\xde" || keystring == "\xd5\xaf\xb0\xb0\x13\xc6#\xfb\xde") {
      if(keystring == "\x91\xe0,#\xfa\xd8\xb2\xcc:" || keystring == "\xd5\xaf\xb0\xb0\x13\xc6#\xfb\xde") {
        modifiers["x{\x90\xaf\xb8"] = 1;
      }

      key = level.menu_cursor.current_pos;
    } else {
      key = int(keystring) - 1;
    }

    if(level.player buttonPressed("p\x97\x86\x18\xb9\xf3") || level.player buttonPressed("\x86\xe9\x9a\xb9uI")) {
      modifiers["x{\x90\xaf\xb8"] = 1;
    }

    if(level.menu_sys[menu_name].can_exit) {
      page_offset = 2;
    } else {
      page_offset = 1;
    }

    if(key >= level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size) {
      continue;
    } else if(level.menu_sys[menu_name].can_exit && key == level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) {
      level notify("\xf6\x86**Q\xde\xaa8C");
      level.exitmenu = 1;
      continue;
    } else if(level.menu_sys[menu_name].options.size > 20 && key == level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - page_offset) {
      newpage = 0;

      if(modifiers["x{\x90\xaf\xb8"] && level.menu_sys[menu_name].page > 0) {
        level.menu_sys[menu_name].page--;
        newpage = 1;
      } else if(!modifiers["x{\x90\xaf\xb8"] && level.menu_sys[menu_name].page < floor(level.menu_sys[menu_name].options.size / 20)) {
        level.menu_sys[menu_name].page++;
        newpage = 1;
      }

      if(newpage) {
        old_size = level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size;
        clear_menu_options("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH");
        draw_menu_options(menu_name);

        if(level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size != old_size) {
          level.menu_cursor.y = 300 + (level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - page_offset + 1) * int(level.var_2d838ae258511c51);
          level.menu_cursor.current_pos = level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - page_offset;
        }
      }

      continue;
    } else {
      menu_key = key;
      key += level.menu_sys[menu_name].page * 20;
    }

    if(isDefined(level.menu_sys[menu_name].parent_menu) && key == level.menu_sys[menu_name].options.size) {
      level notify(")\xa0\x06\xc8\x90\xa3\xcfa" + menu_name);
      level enable_menu(level.menu_sys[menu_name].parent_menu);
    } else if(isDefined(level.menu_sys[menu_name].function) && isDefined(level.menu_sys[menu_name].function[key])) {
      func = undefined;

      if(!modifiers["x{\x90\xaf\xb8"]) {
        func = level.menu_sys[menu_name].function[key];
      } else if(isDefined(level.menu_sys[menu_name].backfunction)) {
        func = level.menu_sys[menu_name].backfunction[key];
      }

      if(isDefined(func)) {
        ent = level;

        if(isDefined(level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].ent)) {
          ent = level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].ent;
        }

        msg = ent[[func]]();

        if(isDefined(msg)) {
          level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[menu_key].text = msg;

          if(isDefined(level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[menu_key].isscripted)) {
            level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[menu_key].text = msg;
          } else if(isnumber(msg)) {
            level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[menu_key] setvalue(msg);
          } else {
            level.menu_sys["<dev string:x65>"].optionsvalue[menu_key] setdevtext(msg);

            level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[menu_key] clearalltextafterhudelem();
          }
        }
      }
    }

    if(!isDefined(level.menu_sys[menu_name].children_menu)) {
      continue;
    } else if(!isDefined(level.menu_sys[menu_name].children_menu[key])) {
      println("<dev string:x75>" + menu_name + "<dev string:x7c>" + key + "<dev string:x9d>");
      continue;
    } else if(!isDefined(level.menu_sys[level.menu_sys[menu_name].children_menu[key]])) {
      println("<dev string:x75>" + level.menu_sys[menu_name].options[key] + "<dev string:xb1>");
      continue;
    }

    if(isDefined(level.menu_sys[menu_name].children_func) && isDefined(level.menu_sys[menu_name].children_func[key])) {
      func = level.menu_sys[menu_name].children_func[key];
      error_msg = [[func]]();

      if(isDefined(error_msg)) {
        level thread selection_error(error_msg, level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[menu_key].x, level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[menu_key].y);
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

function menu_get_selected_optionsvalue(index) {
  if(!isDefined(index)) {
    index = level.menu_cursor.current_pos;
  }

  return level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[index];
}

function function_42a8e95dec24a08c(optionname, value) {
  index = undefined;
  menu = level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name;

  foreach(optionmenu in level.menu_sys[menu].options) {
    if(optionmenu == optionname) {
      index = i;
      break;
    }
  }

  if(!isDefined(index)) {
    println("<dev string:xce>" + optionname + "<dev string:xe1>");
    return;
  }

  level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[index].text = value;
}

function get_current_menu_name() {
  return level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name;
}

function menu_get_selected(val) {
  if(!isDefined(val)) {
    val = level.menu_cursor.current_pos;
  }

  return level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[val];
}

function menu_get_selected_text() {
  val = level.menu_cursor.current_pos;
  return level.menu_sys["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[val].text;
}

function selection_error(msg, x, y) {
  hud = set_hudelem(undefined, x - 10, y, 1);
  hud setshader("e\xac\x11}\xfd", int(level.var_f0febab094d5a40), 20);
  hud.color = (0.5, 0, 0);
  hud.alpha = 0.7;
  error_hud = set_hudelem(msg, x + int(level.var_f0febab094d5a40), y, 1);
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
  level.menu_cursor = newscriptcursor(0, 300 + int(level.var_2d838ae258511c51));
  level.menu_cursor.current_pos = 0;
  menu_cursor_resetpos();
}

function menu_cursor_resetpos() {
  level.menu_cursor.x = 0;
  level.menu_cursor.y = 300 + int(level.var_2d838ae258511c51) + 6;
}

function add_extrahuds(hud) {
  if(!isDefined(self.extrahuds)) {
    self.extrahuds = [];
  }

  self.extrahuds[self.extrahuds.size] = hud;
}

function list_menu(list, x, y, func, sort, start_num) {
  level endon("nxG\x9f\xb8J\x16 \x90G9~\xb4N");
  menu = menu_get_selected();

  if(!isDefined(list) || list.size == 0) {
    return -1;
  }

  hud_array = [];
  space_apart = level.var_2d838ae258511c51;
  arrow = set_scripthud("\xaa'", x - 20, y, level.menu_fontscale, 1);
  arrow.color = (0.8, 0.1, 0.1);
  menu add_extrahuds(arrow);

  if(utility::issp()) {
    max_items = 5;
    y_offset = 2;
  } else {
    max_items = 3;
    y_offset = 1;
  }

  for(i = 0; i < max_items; i++) {
    if(i == 0) {
      alpha = 0.1;
    } else if(i == 1) {
      alpha = 0.5;
    } else if(i == 2) {
      alpha = 1;
    } else if(i == 3) {
      alpha = 0.5;
    } else {
      alpha = 0.1;
    }

    hud = set_scripthud(list[i], x, y + (i - y_offset) * space_apart, level.menu_fontscale, alpha);
    menu add_extrahuds(hud);
    hud_array = utility::array_add(hud_array, hud);
  }

  if(isDefined(start_num)) {
    move_list_menu(hud_array, list, start_num, y_offset);
  } else {
    move_list_menu(hud_array, list, 0, y_offset);
  }

  current_num = 0;
  old_num = 0;
  selected = 0;
  level.menu_list_selected = 0;

  if(isDefined(func)) {
    [[func]](list[current_num]);
  }

  while(true) {
    level waittill("\xc9\x10)\x92\xdeh\xc5\x96\xbb\x82\x15\tC\xe3%\"xq\xb0", key);

    if(!isDefined(level.menu_cursor)) {
      selected = 0;
      break;
    }

    level.menu_list_selected = 1;

    if(any_button_hit(key, "\x11uK\x17\xa9x\x8d")) {
      break;
    } else if(key == "\xdd\x10\xb6\x0e\xa7(\xeb\xceO" || key == "\xd6MRJ\xa5p~h\x01") {
      if(current_num >= list.size - 1) {
        current_num = 0;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num++;
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "]8,\x9c\x93\xbd\xbb" || key == "\xac\xae\xca\xa5g\xf6\xd4") {
      if(current_num <= 0) {
        current_num = list.size - 1;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num--;
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "\xb0\xeep\x13") {
      if(current_num <= 0) {
        current_num = list.size - 1;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num -= 5;
      current_num = clamp(current_num, 0, list.size - 1);
      current_num = int(current_num);
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "~\x9c\x918") {
      if(current_num >= list.size - 1) {
        current_num = 0;
        move_list_menu(hud_array, list, current_num, y_offset);
        continue;
      }

      current_num += 5;
      current_num = clamp(current_num, 0, list.size - 1);
      current_num = int(current_num);
      move_list_menu(hud_array, list, current_num, y_offset);
    } else if(key == "b\xd8\x05g8" || key == "^\xbfl:\x05\xcb\x1e\x88" || key == "\xd8\xd3\xc2\xc5\xf6\xb8\x03\x92U\xee" || key == "'\x10O\x94L\xc9\xd6Z\xde\xde") {
      selected = 1;
      break;
    } else if(key == "8\xdb\x90" || key == "\xb5\xef\xb6`\x9e\x1aK\x16" || key == "\x91\xe0,#\xfa\xd8\xb2\xcc:" || key == "\xd5\xaf\xb0\xb0\x13\xc6#\xfb\xde") {
      selected = 0;
      break;
    }

    level notify("\xd3/\xa3cS\xca\x16l\x8a-\xe8");

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

    hud_array[i] setdevtext("<dev string:xf5>" + text);

    hud_array[i] clearalltextafterhudelem();
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

function universal_input_loop(button_group, end_on, use_attackbutton, mod_button, var_4c92c05e82385547) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level endon(end_on);

  if(!isDefined(use_attackbutton)) {
    use_attackbutton = 0;
  }

  notify_name = button_group + "\xe6\xb6]\x17\xbdk\xcb\x84G\x06n\x80\x05M\x96";
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
    } else if(isDefined(var_4c92c05e82385547) && level.player buttonPressed(var_4c92c05e82385547)) {
      waitframe();
      continue;
    }

    if(use_attackbutton && level.player attackButtonPressed()) {
      level notify(notify_name, "\xcciN\xca");
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

  if(type == "\x11uK\x17\xa9x\x8d") {
    buttons[0] = "\xfe";
    buttons[1] = "\x87";
    buttons[2] = "\x19";
    buttons[3] = "?";
    buttons[4] = "P";
    buttons[5] = "5";
    buttons[6] = "\xbb";
    buttons[7] = "{";
    buttons[8] = "\f";
    buttons[9] = "i";
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
  clear_universal_buttons("\xaa\x8a\xddO");
  add_universal_button("\xaa\x8a\xddO", "\xac\xae\xca\xa5g\xf6\xd4");
  add_universal_button("\xaa\x8a\xddO", "\xd6MRJ\xa5p~h\x01");
  add_universal_button("\xaa\x8a\xddO", "\x91\xe0,#\xfa\xd8\xb2\xcc:");
  add_universal_button("\xaa\x8a\xddO", "\xd8\xd3\xc2\xc5\xf6\xb8\x03\x92U\xee");
  add_universal_button("\xaa\x8a\xddO", "\xdd\x10\xb6\x0e\xa7(\xeb\xceO");
  add_universal_button("\xaa\x8a\xddO", "]8,\x9c\x93\xbd\xbb");
  add_universal_button("\xaa\x8a\xddO", "\xd5\xaf\xb0\xb0\x13\xc6#\xfb\xde");
  add_universal_button("\xaa\x8a\xddO", "'\x10O\x94L\xc9\xd6Z\xde\xde");
  add_universal_button("\xaa\x8a\xddO", "b\xd8\x05g8");
  level thread universal_input_loop("\xaa\x8a\xddO", "e\x14\x16\xc5\xc8", undefined, undefined, "\x809\xc9\xcdXb\x169\xf6\xb9Ba");
}

function init_selection_and_cursor() {
  thread input_loop();
  thread cursor();
}

function input_loop() {
  var_1cfe1258f3e0eb3b = 0;
  level.g_nextusepress = 0;

  while(true) {
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

  level notify("\xd0B\xc29\xb4\xc6%)");
  level.selected.selected = 0;
  level.selected notify("\xd0B\xc29\xb4\xc6%)");

  if(!isnode(level.selected)) {
    level.selected hudoutlinedisable();
  }

  level.selected = undefined;
  setsaveddvar(@ "hash_3bb847d049003050", 2);

  if(isDefined(level.followcam_enabled) && isDefined(level.func["\xec\x06\x1f\\b7\xd7Q\xe0"])) {
    [[level.func["\xec\x06\x1f\\b7\xd7Q\xe0"]]](0);
  }
}

function force_select(ent) {
  assert(!isDefined(level.force_select_ent), "<dev string:xf9>");
  level.force_select_ent = ent;
}

function select(ent) {
  deselect();
  ent endon("\x1e\xfd\xd1\xa2\a");

  if(isnode(ent)) {
    ent notify("\xef\xc8\xb7o\xe3Xv\xf1\x1b\x91`\xbf\f\xdc");
    ent thread draw_box_forever(ent.origin + (0, 0, 16), 32, (0.2, 1, 0.2), ent.angles, 32, "\xd0B\xc29\xb4\xc6%)");
  } else {
    ent hudoutlineenable("\xff\xed\xc0\xc6\x9f\x15$\xb2%A\xd7G\xb0\x90I]\xb7\xf6\x06\xab");
    setsaveddvar(@ "hash_3bb847d049003050", 2);
  }

  ent.selected = 1;
  level.selected = ent;
  wait 1;

  if(isnode(ent)) {
    return;
  }

  ent hudoutlinedisable();
}

function add_selectable(ent) {
  if(!arraycontains(level.selectable_ents, ent)) {
    level.selectable_ents[level.selectable_ents.size] = ent;
  }
}

function remove_selectable(ent) {
  level.selectable_ents = arrayremove(level.selectable_ents, ent);
}

function cleanup_selectable() {
  level.selectable_ents = utility::array_removeundefined(level.selectable_ents);
}

function selected_hint(msg) {
  hud = newhudelem();
  hud.y = 460;
  hud.x = 320;
  hud.alpha = 0.8;
  hud.alignx = "O\xd5!\xe8\xd4\x9d";
  hud.aligny = "#\xb8\xfd\xf5\x1a@";
  hud.archived = 0;

  hud setdevtext(msg);

  hud clearalltextafterhudelem();
  level.selectedhint = hud;
}

function cursor() {
  level.selectable_ents = [];
  level.cursor_pos = (0, 0, 0);
  init_crosshair();
  level notify("I\x86\x90x\xbdi\xb8\x06\x1a\xbeo");
  level endon("I\x86\x90x\xbdi\xb8\x06\x1a\xbeo");

  while(true) {
    cursor_highlight();
    waitframe();
  }
}

function cursor_highlight() {
  start = level.player getEye();
  forward = anglesToForward(level.player getplayerangles());
  start += forward * 30;
  end = start + forward * 10000;
  trace = trace::ray_trace_detail(start, end);
  phys_trace = trace["\xc1\xbd\xdci\xe8i{7"];
  highlighted_ent = undefined;
  highlighted_node = undefined;
  highlighted_path = undefined;
  var_cc3bc901171ac448 = undefined;
  highlighted_ent = get_selectable_ent(start, end, 40);

  if(isDefined(highlighted_ent)) {
    draw_highlight(highlighted_ent);
    level.highlighted_ent = highlighted_ent;
    return;
  }

  if(distance(trace["\xc1\xbd\xdci\xe8i{7"], phys_trace) < 0.1) {
    if(is_place_clear(phys_trace)) {
      level.cursor_pos = phys_trace;
    }
  }

  draw_axis();
  stop_previous_highlight();
  level.highlighted_ent = undefined;
}

function get_selectable_ent(start, end, max_dist) {
  cleanup_selectable();
  return get_selectable_from_array(level.selectable_ents, level.selected_node, start, end, max_dist);
}

function get_selectable_from_array(array, currselected, start, end, max_dist) {
  max_dist = squared(max_dist);
  dist = max_dist;
  selected = undefined;

  foreach(ent in array) {
    origin = ent.origin;

    if(isent(ent) && isai(ent)) {
      origin += (0, 0, 40);
    }

    if(isDefined(currselected) && currselected == ent) {
      continue;
    }

    point = pointonsegmentnearesttopoint(start, end, origin);
    d = distancesquared(point, origin);

    if(d < dist) {
      dist = d;
      selected = ent;
    }
  }

  return selected;
}

function draw_highlight(ent) {
  range = 4;
  color = (1, 1, 0.5);
  depth = 1;
  duration = 1;

  if(isDefined(ent.is_spawner)) {
    stop_previous_highlight();
    draw_spawner(ent.origin, ent.angles, color);
    return;
  }

  if(!isDefined(level.selected) && (!isDefined(level.highlighted_ent) || level.highlighted_ent != ent)) {
    stop_previous_highlight();

    if(isDefined(ent.onhighlight)) {
      ent thread[[ent.onhighlight]]();
    }

    if(isnode(ent)) {
      ent thread draw_box_forever(ent.origin + (0, 0, 16), 32, (1, 1, 0), ent.angles, 32);
      return;
    }

    ent hudoutlineenable("\xf6\xb2EQ\"\xa9\xc8\xd6t\xd6\xa3\x94\xe8\x95lF>\xdd4\xc4\x14\x94");
  }
}

function stop_previous_highlight() {
  if(!isDefined(level.highlighted_ent)) {
    return;
  }

  level.highlighted_ent notify("\xef\xc8\xb7o\xe3Xv\xf1\x1b\x91`\xbf\f\xdc");

  if(isnode(level.highlighted_ent)) {
    return;
  }

  if(isDefined(level.selected) && level.selected == level.highlighted_ent) {
    return;
  }

  level.highlighted_ent hudoutlinedisable();
}

function draw_spawner(pos, angles, color) {
  end = pos + anglesToForward(angles) * 20;
  _draw_arrow(pos + (0, 0, 36), end + (0, 0, 36), color);
  draw_box(pos, color, angles, 72);
}

function _draw_arrow(start, end, color) {
  angle = vectortoangles(end - start);
  dist = length(end - start);
  forward = anglesToForward(angle);
  forwardfar = forward * dist;
  arrow_size = 5;
  forwardclose = forward * (dist - arrow_size);
  right = anglestoright(angle);
  leftdraw = right * arrow_size * -1;
  rightdraw = right * arrow_size;
  line(start, end, color, 1, 0, 1);
  line(start, start + forwardfar, color, 1, 0, 1);
  line(start + forwardfar, start + forwardclose + rightdraw, color, 1, 0, 1);
  line(start + forwardfar, start + forwardclose + leftdraw, color, 1, 0, 1);
}

function draw_box_forever(pos, width, color, angles, height, end_on) {
  if(isDefined(end_on)) {
    self endon(end_on);
  } else {
    self endon("<dev string:x147>");
  }

  while(true) {
    draw_box(pos, width, color, angles, height);
    waitframe();
  }
}

function draw_box(pos, width, color, angles, height) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(width)) {
    width = 32;
  }

  if(!isDefined(height)) {
    height = 32;
  }

  forward = anglesToForward(angles);
  line(pos, pos + forward * 24, color);
  orientedbox(pos, (width, width, height), angles, color);
}

function draw_axis() {
  size = 5;
  pos = level.cursor_pos;
  color = 1;
  depth = 1;
  debugaxis(pos, (0, 0, 0), size, color, depth);
}

function init_crosshair() {
  if(!utility::issp()) {
    return;
  }

  crosshair = newhudelem();
  crosshair.location = 0;
  crosshair.alignx = "O\xd5!\xe8\xd4\x9d";
  crosshair.aligny = "#\xb8\xfd\xf5\x1a@";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 1;
  crosshair.x = 320;
  crosshair.y = 237;
  crosshair.archived = 0;

  crosshair setdevtext("<dev string:x159>");
}

function is_place_clear(org) {
  debug_lines = getdvarint(@ "ai_place");
  steps = 6;
  chunks = 360 / steps;
  dist_check = squared(0.1);

  for(i = 0; i < steps; i++) {
    angles = (-30, i * chunks, 0);
    forward = anglesToForward(angles);
    endpos = org + forward * 30;
    trace = trace::ray_trace(org, endpos, undefined, trace::create_solid_ai_contents(1));
    pos = trace["\xc1\xbd\xdci\xe8i{7"];
    dist = distancesquared(pos, endpos);

    if(dist > dist_check) {
      if(debug_lines) {
        line(org, endpos, (1, 0, 0));
      }

      return false;
    }

    if(debug_lines) {
      line(org, endpos, (0, 1, 0));
    }

    trace = trace::ray_trace(endpos + (0, 0, 42), endpos, undefined, trace::create_solid_ai_contents(1));
    pos = trace["\xc1\xbd\xdci\xe8i{7"];

    if(dist > dist_check) {
      if(debug_lines) {
        line(pos, endpos, (1, 0, 0));
      }

      return false;
    }

    if(debug_lines) {
      line(endpos + (0, 0, 42), endpos, (0, 1, 0));
    }
  }

  return true;
}