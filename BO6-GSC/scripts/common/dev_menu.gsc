/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\dev_menu.gsc
***************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace dev_menu;

function init_menus(x_override, y_override, scaleoverride, var_8cf6b924ba902a0e) {
  level.dev_menu = spawnStruct();
  level.dev_menu.menus = [];
  level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"] = spawnStruct();
  init_buttons();
  level thread menu_input();
  level thread aspectratio_thread();
  level.dev_menu.var_9afacda00d6eb16c = scaleoverride ?? 1.25;
  level.dev_menu.var_c73836446dccdccd = x_override ?? 20;
  level.dev_menu.var_d477ffd494bf756 = y_override ?? 300;
  level.dev_menu.var_4d9118f19c2cdc65 = var_8cf6b924ba902a0e ?? 20;
  level.dev_menu.var_64ceb35457878086 = level.dev_menu.var_c73836446dccdccd + 200 * level.dev_menu.var_9afacda00d6eb16c;
  level.dev_menu.var_ffdd7721d452570b = 20 * level.dev_menu.var_9afacda00d6eb16c;
}

function add_menu(menu_name, title, can_exit) {
  if(menu_exists(menu_name)) {
    println("<dev string:x24>" + menu_name + "<dev string:x40>");
    return;
  }

  menu = spawnStruct();
  menu.title = title;
  menu.page = 0;
  menu.can_exit = istrue(can_exit);
  level.dev_menu.menus[menu_name] = menu;
}

function menu_exists(menu_name) {
  return isDefined(level.dev_menu.menus[menu_name]);
}

function add_menuoptions(menu_name, option_text, func, back_func, value) {
  menu = level.dev_menu.menus[menu_name];

  if(!isDefined(menu.options)) {
    menu.options = [];
    menu.optionsvalue = [];
  }

  num = level.dev_menu.menus[menu_name].options.size;
  menu.options[num] = option_text;
  menu.function[num] = func;
  menu.backfunction[num] = back_func;

  if(isDefined(value)) {
    menu.optionsvalue[num] = value;
  }
}

function function_f85391c689ef70db(menu_name, option_text, amount, value) {
  menu = level.dev_menu.menus[menu_name];

  if(!isDefined(menu.options)) {
    menu.options = [];
    menu.optionsvalue = [];
  }

  num = menu.options.size;
  menu.options[num] = option_text;
  menu.var_508d2ce9e6961d32[num] = amount;

  if(isDefined(value)) {
    menu.optionsvalue[num] = value;
  }
}

function add_menuent(menu_name, ent) {
  level.dev_menu.menus[menu_name].ent = ent;
}

function add_menu_child(parent_menu, child_menu, child_title, var_2d98f8c038ba13c9, func) {
  if(!isDefined(level.dev_menu.menus[child_menu])) {
    add_menu(child_menu, child_title);
  }

  level.dev_menu.menus[child_menu].parent_menu = parent_menu;

  if(!isDefined(level.dev_menu.menus[parent_menu].children_menu)) {
    level.dev_menu.menus[parent_menu].children_menu = [];
  }

  if(!isDefined(var_2d98f8c038ba13c9)) {
    size = level.dev_menu.menus[parent_menu].children_menu.size;
  } else {
    size = var_2d98f8c038ba13c9;
  }

  level.dev_menu.menus[parent_menu].children_menu[size] = child_menu;

  if(isDefined(func)) {
    if(!isDefined(level.dev_menu.menus[parent_menu].children_func)) {
      level.dev_menu.menus[parent_menu].children_func = [];
    }

    level.dev_menu.menus[parent_menu].children_func[size] = func;
  }
}

function enable_menu(menu_name) {
  disable_menu("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH");

  if(isDefined(level.dev_menu.menu_cursor)) {
    level.dev_menu.menu_cursor.current_pos = 0;
    menu_cursor_resetpos();
  }

  level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].title = set_menu_hudelem(level.dev_menu.menus[menu_name].title, "\xf3\xc4\xb0&&");
  level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name = menu_name;

  if(isDefined(level.dev_menu.menus[menu_name].options)) {
    draw_menu_options(menu_name);
  }

  if(isDefined(level.dev_menu.menus[menu_name].ent)) {
    level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].ent = level.dev_menu.menus[menu_name].ent;
  }

  menu_cursor();
  menu_highlight("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH", level.dev_menu.menu_cursor.current_pos);
}

function exit_menu() {
  level notify("\xf6\x86**Q\xde\xaa8C");
  level.dev_menu.exit_requested = 1;
}

function exit_requested() {
  if(istrue(level.dev_menu.exit_requested)) {
    level.dev_menu.exit_requested = undefined;
    return true;
  }

  return false;
}

function draw_menu_options(menu_name) {
  options = level.dev_menu.menus[menu_name].options;
  page = level.dev_menu.menus[menu_name].page;

  for(i = 0; i < level.dev_menu.var_4d9118f19c2cdc65 && i + page * level.dev_menu.var_4d9118f19c2cdc65 < options.size; i++) {
    actual_index = i + page * level.dev_menu.var_4d9118f19c2cdc65;
    text = actual_index + 1 + "M\x93" + options[actual_index];
    level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[i] = set_menu_hudelem(text, "$\xb2N2~\xe8\x82", int(level.dev_menu.var_ffdd7721d452570b) * i);

    if(isDefined(level.dev_menu.menus[menu_name].optionsvalue[actual_index])) {
      val = level.dev_menu.menus[menu_name].optionsvalue[actual_index];
      hud = set_menu_hudelem(val, "\x8ew\n\x8cT", int(level.dev_menu.var_ffdd7721d452570b) * i);
      hud.x += int(level.dev_menu.var_64ceb35457878086);
      level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[i] = hud;
    }
  }

  if(options.size > level.dev_menu.var_4d9118f19c2cdc65) {
    text = "";

    if(page > 0) {
      text += "(\xa7,\xd7\xba\x9d3\x19x\xc8p";
    }

    if(page < floor(options.size / level.dev_menu.var_4d9118f19c2cdc65)) {
      text += "\x87sV/aR7\x1c";
    }

    if(text != "") {
      level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[i] = set_menu_hudelem(text, "$\xb2N2~\xe8\x82", int(level.dev_menu.var_ffdd7721d452570b) * i);
      i++;
    }
  }

  if(level.dev_menu.menus[menu_name].can_exit) {
    level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[i] = set_menu_hudelem("p\xb0\xc0\xda", "$\xb2N2~\xe8\x82", int(level.dev_menu.var_ffdd7721d452570b) * i);
  }
}

function disable_menu(menu_name) {
  level notify("nxG\x9f\xb8J\x16 \x90G9~\xb4N");

  if(menu_name != "\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH" && isDefined(level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name) && level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name != menu_name) {
    println("<dev string:x6b>" + menu_name + "<dev string:x8e>");
    return;
  }

  if(isDefined(level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"])) {
    if(isDefined(level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].title)) {
      level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].title scripthud_destroy();
    }

    if(isDefined(level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options)) {
      clear_menu_options("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH");
    }
  }

  level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].title = undefined;
  level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name = undefined;
  level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].ent = undefined;

  if(isDefined(level.dev_menu.menu_cursor)) {
    level.dev_menu.menu_cursor scripthud_destroy();
    level.dev_menu.menu_cursor = undefined;
  }
}

function clear_menu_options(menu_name) {
  options = level.dev_menu.menus[menu_name].options;

  for(i = 0; i < options.size; i++) {
    if(isDefined(options[i].extrahuds)) {
      foreach(extrahud in options[i].extrahuds) {
        if(isDefined(extrahud)) {
          extrahud scripthud_destroy();
        }
      }
    }

    options[i] scripthud_destroy();

    if(!isDefined(level.dev_menu.menus[menu_name].optionsvalue)) {
      continue;
    }

    if(isDefined(level.dev_menu.menus[menu_name].optionsvalue[i])) {
      level.dev_menu.menus[menu_name].optionsvalue[i] scripthud_destroy();
    }
  }

  level.dev_menu.menus[menu_name].options = [];

  if(isDefined(level.dev_menu.menus[menu_name].optionsvalue)) {
    level.dev_menu.menus[menu_name].optionsvalue = [];
  }
}

function destroy_menu(menu_name) {
  level.dev_menu.menus[menu_name] = undefined;
}

function set_menu_hudelem(text, type, y_offset) {
  x = level.dev_menu.var_c73836446dccdccd;
  y = level.dev_menu.var_d477ffd494bf756;

  if(type == "\xf3\xc4\xb0&&") {
    scale = 1.1 * 1.25;
  } else {
    scale = 1.25;
    y += int(level.dev_menu.var_ffdd7721d452570b);
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

function set_scripthud(text, x, y, scale, alpha) {
  if(!isDefined(scale)) {
    scale = 2;
  }

  hud = new_scripthud();
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

function new_scripthud() {
  struct = spawnStruct();
  struct.x = 0;
  struct.y = 0;
  struct.text = "";
  struct.color = (1, 1, 1);
  struct.scale = 2;
  struct.isscripted = 1;
  struct.alive = 1;
  struct thread scripthud_thread();
  return struct;
}

function aspectratio_thread() {
  level.dev_menu.var_cf9f2e1d82a507e7 = 1;
  level.dev_menu.var_b6924819a6e29d54 = 1;
  level.dev_menu.var_b5032af2bc4bec2c = "Bf";

  while(true) {
    if(isplatformconsole() || getdvarint(@ "hash_8488fe3c45241d55")) {
      [width, height] = function_915c2127a04390ea();

      if(isDefined(width)) {
        window_width = width;
        window_height = height;
      }
    } else {
      window_width = getdvarint(@ "vid_width");
      window_height = getdvarint(@ "vid_height");
    }

    vid_width = window_width;
    vid_height = window_height;
    aspectratio = round(getdvarfloat(@ "cg_aspectratio"), 3);
    windowratio = round(window_width / window_height, 3);

    if(windowratio != aspectratio) {
      if(windowratio < aspectratio) {
        vid_height = int(window_width / aspectratio);
        vid_width = int(vid_height * aspectratio);
      } else {
        vid_width = int(window_height * aspectratio);
        vid_height = int(vid_width / aspectratio);
      }
    }

    level.dev_menu.var_cf9f2e1d82a507e7 = vid_width / 1920;
    level.dev_menu.var_b6924819a6e29d54 = vid_height / 1080;
    wait 0.1;
  }
}

function function_915c2127a04390ea() {
  res = getDvar(@ "r_mode");
  window_width = undefined;
  window_height = undefined;

  if(level.dev_menu.var_b5032af2bc4bec2c != res) {
    level.dev_menu.var_b5032af2bc4bec2c = res;
    toks = strtok(res, "<");

    if(toks.size < 2) {
      return [1920, 1080];
    }

    window_width = int(toks[0]);
    window_height = int(toks[1]);
  }

  return [window_width, window_height];
}

function scripthud_thread() {
  while(self.alive) {
    x = level.dev_menu.var_cf9f2e1d82a507e7 * self.x;
    y = level.dev_menu.var_b6924819a6e29d54 * self.y;
    printtoscreen2d(x, y, self.text, self.color, self.scale * level.dev_menu.var_b6924819a6e29d54);
    waitframe();
  }
}

function scripthud_destroy() {
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
  struct.color = (1, 0, 0);
  struct.scale = 2;
  struct.isscripted = 1;
  struct.alive = 1;
  struct thread scripthud_thread();
  return struct;
}

function menu_input() {
  self notify("\xf2s\xca1P\x10Z\xa5\r\xe4\x1e^L\x03eG");
  self endon("\xf2s\xca1P\x10Z\xa5\r\xe4\x1e^L\x03eG");

  while(true) {
    level waittill("\xc9\x10)\x92\xdeh\xc5\x96\xbb\x82\x15\tC\xe3%\"xq\xb0", keystring);

    if(istrue(level.var_bf00ea08d05137f) || !isDefined(level.dev_menu.menu_cursor) || isDefined(level.debug.debug_start) && level.debug.debug_start) {
      wait 0.1;
      continue;
    }

    menu_name = level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name;

    if(!(isDefined(level.dev_menu.menus[menu_name]) && isDefined(menu_name) && isDefined(level.dev_menu.menus[menu_name].title))) {
      continue;
    }

    modifiers["x{\x90\xaf\xb8"] = 0;
    modifiers["\f\x9f\x05\x12"] = 0;
    modifiers["%m\b"] = 0;

    if(keystring == "\xac\xae\xca\xa5g\xf6\xd4" || keystring == "]8,\x9c\x93\xbd\xbb") {
      if(level.dev_menu.menu_cursor.current_pos > 0) {
        level.dev_menu.menu_cursor.y -= int(level.dev_menu.var_ffdd7721d452570b);
        level.dev_menu.menu_cursor.current_pos--;
      } else if(level.dev_menu.menu_cursor.current_pos == 0) {
        level.dev_menu.menu_cursor.y += (level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) * int(level.dev_menu.var_ffdd7721d452570b);
        level.dev_menu.menu_cursor.current_pos = level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1;
      }

      menu_highlight("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH", level.dev_menu.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(keystring == "\xd6MRJ\xa5p~h\x01" || keystring == "\xdd\x10\xb6\x0e\xa7(\xeb\xceO") {
      if(level.dev_menu.menu_cursor.current_pos < level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) {
        level.dev_menu.menu_cursor.y += int(level.dev_menu.var_ffdd7721d452570b);
        level.dev_menu.menu_cursor.current_pos++;
      } else if(level.dev_menu.menu_cursor.current_pos == level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) {
        level.dev_menu.menu_cursor.y += level.dev_menu.menu_cursor.current_pos * int(level.dev_menu.var_ffdd7721d452570b) * -1;
        level.dev_menu.menu_cursor.current_pos = 0;
      }

      menu_highlight("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH", level.dev_menu.menu_cursor.current_pos);
      wait 0.1;
      continue;
    } else if(keystring == "^\xbfl:\x05\xcb\x1e\x88" || keystring == "\xd8\xd3\xc2\xc5\xf6\xb8\x03\x92U\xee" || keystring == "\x91\xe0,#\xfa\xd8\xb2\xcc:" || keystring == "'\x10O\x94L\xc9\xd6Z\xde\xde" || keystring == "\xd5\xaf\xb0\xb0\x13\xc6#\xfb\xde") {
      if(keystring == "\x91\xe0,#\xfa\xd8\xb2\xcc:" || keystring == "\xd5\xaf\xb0\xb0\x13\xc6#\xfb\xde") {
        modifiers["x{\x90\xaf\xb8"] = 1;
      }

      key = level.dev_menu.menu_cursor.current_pos;
    } else if(keystring == "\xb5\xef\xb6`\x9e\x1aK\x16") {
      exit_menu();
      continue;
    } else {
      key = int(keystring) - 1;
    }

    if(level.player buttonPressed("p\x97\x86\x18\xb9\xf3") || level.player buttonPressed("\x86\xe9\x9a\xb9uI")) {
      modifiers["x{\x90\xaf\xb8"] = 1;
    }

    if(level.dev_menu.menus[menu_name].can_exit) {
      page_offset = 2;
    } else {
      page_offset = 1;
    }

    if(key >= level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size) {
      continue;
    } else if(level.dev_menu.menus[menu_name].can_exit && key == level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - 1) {
      exit_menu();
      continue;
    } else if(level.dev_menu.menus[menu_name].options.size > level.dev_menu.var_4d9118f19c2cdc65 && key == level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - page_offset) {
      newpage = 0;

      if(modifiers["x{\x90\xaf\xb8"] && level.dev_menu.menus[menu_name].page > 0) {
        level.dev_menu.menus[menu_name].page--;
        newpage = 1;
      } else if(!modifiers["x{\x90\xaf\xb8"] && level.dev_menu.menus[menu_name].page < floor(level.dev_menu.menus[menu_name].options.size / level.dev_menu.var_4d9118f19c2cdc65)) {
        level.dev_menu.menus[menu_name].page++;
        newpage = 1;
      }

      if(newpage) {
        old_size = level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size;
        clear_menu_options("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH");
        draw_menu_options(menu_name);

        if(level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size != old_size) {
          level.dev_menu.menu_cursor.y = level.dev_menu.var_d477ffd494bf756 + (level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - page_offset + 1) * int(level.dev_menu.var_ffdd7721d452570b);
          level.dev_menu.menu_cursor.current_pos = level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options.size - page_offset;
        }
      }

      continue;
    } else {
      menu_key = key;
      key += level.dev_menu.menus[menu_name].page * level.dev_menu.var_4d9118f19c2cdc65;
    }

    if(isDefined(level.dev_menu.menus[menu_name].parent_menu) && key == level.dev_menu.menus[menu_name].options.size) {
      level notify(")\xa0\x06\xc8\x90\xa3\xcfa" + menu_name);
      level enable_menu(level.dev_menu.menus[menu_name].parent_menu);
    } else if(isDefined(level.dev_menu.menus[menu_name].function) && isDefined(level.dev_menu.menus[menu_name].function[key])) {
      func = undefined;

      if(!modifiers["x{\x90\xaf\xb8"]) {
        func = level.dev_menu.menus[menu_name].function[key];
      } else if(isDefined(level.dev_menu.menus[menu_name].backfunction)) {
        func = level.dev_menu.menus[menu_name].backfunction[key];
      }

      if(isDefined(func)) {
        ent = level;

        if(isDefined(level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].ent)) {
          ent = level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].ent;
        }

        msg = ent[[func]]();

        if(isDefined(msg)) {
          function_42a8e95dec24a08c(menu_key, msg);
        }
      }
    } else if(isDefined(level.dev_menu.menus[menu_name].var_508d2ce9e6961d32) && isDefined(level.dev_menu.menus[menu_name].var_508d2ce9e6961d32[key])) {
      if(!modifiers["x{\x90\xaf\xb8"]) {
        value = level.dev_menu.menus[menu_name].optionsvalue[key] + level.dev_menu.menus[menu_name].var_508d2ce9e6961d32[key];
      } else {
        value = level.dev_menu.menus[menu_name].optionsvalue[key] - level.dev_menu.menus[menu_name].var_508d2ce9e6961d32[key];
      }

      level.dev_menu.menus[menu_name].optionsvalue[key].text = value;
      level.dev_menu.menus[menu_name].optionsvalue[key] setvalue(value);
    }

    if(!isDefined(level.dev_menu.menus[menu_name].children_menu)) {
      continue;
    } else if(!isDefined(level.dev_menu.menus[menu_name].children_menu[key])) {
      println("<dev string:xa2>" + menu_name + "<dev string:xa9>" + key + "<dev string:xca>");
      continue;
    } else if(!isDefined(level.dev_menu.menus[level.dev_menu.menus[menu_name].children_menu[key]])) {
      println("<dev string:xa2>" + level.dev_menu.menus[menu_name].options[key] + "<dev string:xde>");
      continue;
    }

    if(isDefined(level.dev_menu.menus[menu_name].children_func) && isDefined(level.dev_menu.menus[menu_name].children_func[key])) {
      func = level.dev_menu.menus[menu_name].children_func[key];
      error_msg = [[func]]();

      if(isDefined(error_msg)) {
        level thread selection_error(error_msg, level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[menu_key].x, level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[menu_key].y);
        continue;
      }
    }

    level enable_menu(level.dev_menu.menus[menu_name].children_menu[key]);
    wait 0.1;
  }
}

function menu_highlight(menu_name, index) {
  foreach(hud in level.dev_menu.menus[menu_name].options) {
    hud.color = (1, 1, 1);
  }

  if(isDefined(level.dev_menu.menus[menu_name].optionsvalue)) {
    foreach(hud in level.dev_menu.menus[menu_name].optionsvalue) {
      hud.color = (1, 1, 1);
    }
  }

  if(isDefined(level.dev_menu.menus[menu_name].optionsvalue) && isDefined(level.dev_menu.menus[menu_name].optionsvalue[index])) {
    level.dev_menu.menus[menu_name].optionsvalue[index].color = (1, 1, 0);
  }

  level.dev_menu.menus[menu_name].options[index].color = (1, 1, 0);
}

function hud_selector(x, y) {}

function hud_selector_fade_out(time) {}

function menu_get_selected_optionsvalue(val) {
  if(!isDefined(val)) {
    val = level.dev_menu.menu_cursor.current_pos;
  }

  return level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[val];
}

function function_42a8e95dec24a08c(optionskey, newvalue) {
  if(!isDefined(level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].optionsvalue[optionskey])) {
    return;
  }

  menu = level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"];
  menu.optionsvalue[optionskey].text = newvalue;

  if(isDefined(menu.optionsvalue[optionskey].isscripted)) {
    menu.optionsvalue[optionskey].text = newvalue;
    return;
  }

  if(isnumber(newvalue)) {
    menu.optionsvalue[optionskey] setvalue(newvalue);
    return;
  }

  menu.optionsvalue[optionskey] setdevtext(newvalue);

  menu.optionsvalue[optionskey] clearalltextafterhudelem();
}

function get_current_menu_name() {
  return level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].menu_name;
}

function menu_get_selected(val) {
  if(!isDefined(val)) {
    val = level.dev_menu.menu_cursor.current_pos;
  }

  return level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[val];
}

function menu_get_selected_text() {
  val = level.dev_menu.menu_cursor.current_pos;
  return level.dev_menu.menus["\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH"].options[val].text;
}

function function_6afb2d38e052adcd() {
  return level.dev_menu.menu_cursor.current_pos;
}

function selection_error(msg, x, y) {
  hud = set_hudelem(undefined, x - 10, y, 1);
  hud setshader("e\xac\x11}\xfd", int(level.dev_menu.var_64ceb35457878086), 20);
  hud.color = (0.5, 0, 0);
  hud.alpha = 0.7;
  error_hud = set_hudelem(msg, x + int(level.dev_menu.var_64ceb35457878086), y, 1);
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
  level.dev_menu.menu_cursor = newscriptcursor(0, level.dev_menu.var_d477ffd494bf756 + int(level.dev_menu.var_ffdd7721d452570b));
  level.dev_menu.menu_cursor.current_pos = 0;
  menu_cursor_resetpos();
}

function menu_cursor_resetpos() {
  level.dev_menu.menu_cursor.x = 0;
  level.dev_menu.menu_cursor.y = level.dev_menu.var_d477ffd494bf756 + int(level.dev_menu.var_ffdd7721d452570b) + 6;
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
  space_apart = level.dev_menu.var_ffdd7721d452570b;
  arrow = set_scripthud("\xaa'", x - 20, y, 1.25, 1);
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
    hud_array = utility::array_add(hud_array, hud);
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
    level waittill("\xc9\x10)\x92\xdeh\xc5\x96\xbb\x82\x15\tC\xe3%\"xq\xb0", key);

    if(!isDefined(level.dev_menu.menu_cursor)) {
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
    } else if(key == "b\xd8\x05g8" || key == "^\xbfl:\x05\xcb\x1e\x88" || key == "\xd8\xd3\xc2\xc5\xf6\xb8\x03\x92U\xee") {
      selected = 1;
      break;
    } else if(key == "8\xdb\x90" || key == "\xb5\xef\xb6`\x9e\x1aK\x16" || key == "\x91\xe0,#\xfa\xd8\xb2\xcc:") {
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
    arrow scripthud_destroy();
  } else {
    arrow destroy();
  }

  for(i = 0; i < hud_array.size; i++) {
    if(hud_array[i].isscripted) {
      hud_array[i] scripthud_destroy();
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

    hud_array[i] setdevtext("<dev string:xfb>" + text);

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
  add_universal_button("\xaa\x8a\xddO", "\xb5\xef\xb6`\x9e\x1aK\x16");
  add_universal_button("\xaa\x8a\xddO", "\xdd\x10\xb6\x0e\xa7(\xeb\xceO");
  add_universal_button("\xaa\x8a\xddO", "]8,\x9c\x93\xbd\xbb");
  add_universal_button("\xaa\x8a\xddO", "\xd5\xaf\xb0\xb0\x13\xc6#\xfb\xde");
  add_universal_button("\xaa\x8a\xddO", "'\x10O\x94L\xc9\xd6Z\xde\xde");
  add_universal_button("\xaa\x8a\xddO", "b\xd8\x05g8");
  level thread universal_input_loop("\xaa\x8a\xddO", "e\x14\x16\xc5\xc8", undefined, undefined, "\x809\xc9\xcdXb\x169\xf6\xb9Ba");
}