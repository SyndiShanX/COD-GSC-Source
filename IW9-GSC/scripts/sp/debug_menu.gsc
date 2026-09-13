/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\debug_menu.gsc
***********************************************/

init_menus() {
  level.menu_sys = [];
  level.menu_sys["current_menu"] = spawnStruct();
  init_buttons();
  level thread menu_input();
}

add_menu(menu_name, title, can_exit) {
  if(menu_exists(menu_name)) {
    return;
  }
  level.menu_sys[menu_name] = spawnStruct();
  level.menu_sys[menu_name].title = title;
  level.menu_sys[menu_name].page = 0;
  level.menu_sys[menu_name].can_exit = istrue(can_exit);
}

menu_exists(menu_name) {
  return isDefined(level.menu_sys[menu_name]);
}

add_menuoptions(menu_name, _id_C2884C14A260A4D6, func, _id_25B53F3C4B509CF9, value) {
  if(!isDefined(level.menu_sys[menu_name].options)) {
    level.menu_sys[menu_name].options = [];
    level.menu_sys[menu_name].optionsvalue = [];
  }

  num = level.menu_sys[menu_name].options.size;
  level.menu_sys[menu_name].options[num] = _id_C2884C14A260A4D6;
  level.menu_sys[menu_name].function[num] = func;
  level.menu_sys[menu_name].backfunction[num] = _id_25B53F3C4B509CF9;

  if(isDefined(value))
    level.menu_sys[menu_name].optionsvalue[num] = value;
}

add_menuent(menu_name, ent) {
  level.menu_sys[menu_name].ent = ent;
}

add_menu_child(parent_menu, _id_A0A956E4D3E6ABDD, _id_49AF6558486460EC, _id_3403DDE8C1F8F138, func) {
  if(!isDefined(level.menu_sys[_id_A0A956E4D3E6ABDD]))
    add_menu(_id_A0A956E4D3E6ABDD, _id_49AF6558486460EC);

  level.menu_sys[_id_A0A956E4D3E6ABDD].parent_menu = parent_menu;

  if(!isDefined(level.menu_sys[parent_menu].children_menu))
    level.menu_sys[parent_menu].children_menu = [];

  if(!isDefined(_id_3403DDE8C1F8F138))
    _id_A61C75B156FC1EE0 = level.menu_sys[parent_menu].children_menu.size;
  else
    _id_A61C75B156FC1EE0 = _id_3403DDE8C1F8F138;

  level.menu_sys[parent_menu].children_menu[_id_A61C75B156FC1EE0] = _id_A0A956E4D3E6ABDD;

  if(isDefined(func)) {
    if(!isDefined(level.menu_sys[parent_menu].children_func))
      level.menu_sys[parent_menu].children_func = [];

    level.menu_sys[parent_menu].children_func[_id_A61C75B156FC1EE0] = func;
  }
}

enable_menu(menu_name) {
  disable_menu("current_menu");

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor.current_pos = 0;
    menu_cursor_resetpos();
  }

  level.menu_sys["current_menu"].title = set_menu_hudelem(level.menu_sys[menu_name].title, "title");
  level.menu_sys["current_menu"].menu_name = menu_name;

  if(isDefined(level.menu_sys[menu_name].options))
    draw_menu_options(menu_name);

  if(isDefined(level.menu_sys[menu_name].ent))
    level.menu_sys["current_menu"].ent = level.menu_sys[menu_name].ent;

  menu_cursor();
  menu_highlight("current_menu", level.menu_cursor.current_pos);
}

exit_menu() {
  level notify("exit_menu");
  level.exitmenu = 1;
}

draw_menu_options(menu_name) {
  options = level.menu_sys[menu_name].options;
  page = level.menu_sys[menu_name].page;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 20 && _id_AC0E594AC96AA3A8 + page * 20 < options.size; _id_AC0E594AC96AA3A8++) {
    _id_F74C5BF60242A508 = _id_AC0E594AC96AA3A8 + page * 20;
    text = _id_F74C5BF60242A508 + 1 + ". " + options[_id_F74C5BF60242A508];
    level.menu_sys["current_menu"].options[_id_AC0E594AC96AA3A8] = set_menu_hudelem(text, "options", int(25.0) * _id_AC0E594AC96AA3A8);

    if(isDefined(level.menu_sys[menu_name].optionsvalue[_id_F74C5BF60242A508])) {
      val = level.menu_sys[menu_name].optionsvalue[_id_F74C5BF60242A508];
      hud = set_menu_hudelem(val, "value", int(25.0) * _id_AC0E594AC96AA3A8);

      if(scripts\common\utility::iscp())
        hud.x = hud.x + int(247.5);
      else
        hud.x = hud.x + int(207.5);

      level.menu_sys["current_menu"].optionsvalue[_id_AC0E594AC96AA3A8] = hud;
    }
  }

  if(options.size > 20) {
    text = "";

    if(page > 0)
      text = text + "<-- Prev ";

    if(page < floor(options.size / 20))
      text = text + "Next -->";

    if(text != "") {
      level.menu_sys["current_menu"].options[_id_AC0E594AC96AA3A8] = set_menu_hudelem(text, "options", int(25.0) * _id_AC0E594AC96AA3A8);
      _id_AC0E594AC96AA3A8++;
    }
  }

  if(level.menu_sys[menu_name].can_exit)
    level.menu_sys["current_menu"].options[_id_AC0E594AC96AA3A8] = set_menu_hudelem("Exit", "options", int(25.0) * _id_AC0E594AC96AA3A8);
}

disable_menu(menu_name) {
  level notify("stop_all_menus");

  if(isDefined(level.menu_sys[menu_name])) {
    if(isDefined(level.menu_sys[menu_name].title))
      level.menu_sys[menu_name].title scripthuddestroy();

    if(isDefined(level.menu_sys[menu_name].options))
      clear_menu_options(menu_name);
  }

  level.menu_sys[menu_name].title = undefined;
  level.menu_sys[menu_name].menu_name = undefined;
  level.menu_sys[menu_name].ent = undefined;

  if(isDefined(level.menu_cursor))
    level.menu_cursor scripthuddestroy();
}

clear_menu_options(menu_name) {
  options = level.menu_sys[menu_name].options;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < options.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(options[_id_AC0E594AC96AA3A8].extrahuds)) {
      foreach(_id_F15D5D95A99A98DE in options[_id_AC0E594AC96AA3A8].extrahuds) {
        if(isDefined(_id_F15D5D95A99A98DE))
          _id_F15D5D95A99A98DE scripthuddestroy();
      }
    }

    options[_id_AC0E594AC96AA3A8] scripthuddestroy();

    if(!isDefined(level.menu_sys[menu_name].optionsvalue)) {
      continue;
    }
    if(isDefined(level.menu_sys[menu_name].optionsvalue[_id_AC0E594AC96AA3A8]))
      level.menu_sys[menu_name].optionsvalue[_id_AC0E594AC96AA3A8] scripthuddestroy();
  }

  level.menu_sys[menu_name].options = [];

  if(isDefined(level.menu_sys[menu_name].optionsvalue))
    level.menu_sys[menu_name].optionsvalue = [];
}

destroy_menu(menu_name) {
  level.menu_sys[menu_name] = undefined;
}

set_menu_hudelem(text, type, _id_827F335C2225D1EA) {
  if(scripts\common\utility::iscp())
    x = 60;
  else
    x = 20;

  y = 300;

  if(type == "title")
    scale = 1.375;
  else {
    scale = 1.25;
    y = y + int(25.0);
  }

  if(!isDefined(_id_827F335C2225D1EA))
    _id_827F335C2225D1EA = 0;

  y = y + _id_827F335C2225D1EA;
  return set_scripthud(text, x, y, scale);
}

set_hudelem(text, x, y, scale, alpha, sort) {
  if(!isDefined(alpha))
    alpha = 1;

  if(!isDefined(scale))
    scale = 1;

  if(!isDefined(sort))
    sort = 20;

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

    if(isnumber(text))
      hud setvalue(text);
    else
      hud clearalltextafterhudelem();
  }

  return hud;
}

set_scripthud(text, x, y, scale, _id_BF304CC4AF304224) {
  if(!isDefined(scale))
    scale = 2;

  hud = newscripthud();
  hud.x = x;
  hud.y = y;
  hud.scale = scale;

  if(isDefined(text))
    hud.text = text;

  if(isDefined(_id_BF304CC4AF304224)) {
    r = scripts\engine\math::lerp(hud.color[0] * 0.5, hud.color[0], _id_BF304CC4AF304224);
    g = scripts\engine\math::lerp(hud.color[1] * 0.5, hud.color[1], _id_BF304CC4AF304224);
    b = scripts\engine\math::lerp(hud.color[2] * 0.5, hud.color[2], _id_BF304CC4AF304224);
    hud.color = (r, g, b);
  }

  return hud;
}

newscripthud() {
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

scripthudthread() {
  while(self.alive) {
    if(self.alpha > 0) {}

    waitframe();
  }
}

scripthuddestroy() {
  if(!istrue(self.isscripted)) {
    self destroy();
    return;
  }

  self.alive = 0;
}

newscriptcursor(x, y) {
  struct = spawnStruct();
  struct.x = x;
  struct.y = y;
  struct.text = ">";
  struct.color = (0.8, 0.1, 0.1);
  struct.scale = 2;
  struct.isscripted = 1;
  struct.alive = 1;
  struct.alpha = 1;
  struct thread scripthudthread();
  return struct;
}

menu_input() {
  level notify("stop_menu_input");
  level endon("stop_menu_input");

  for(;;) {
    level waittill("menu_button_pressed", _id_7C2DF55215F0A6C1);

    if(!isDefined(level.menu_cursor) || isDefined(level.debug) && isDefined(level.debug.debug_start) && level.debug.debug_start) {
      wait 0.1;
      continue;
    }

    menu_name = level.menu_sys["current_menu"].menu_name;

    if(!isDefined(menu_name)) {
      continue;
    }
    modifiers["shift"] = 0;
    modifiers["ctrl"] = 0;
    modifiers["alt"] = 0;

    if(_id_7C2DF55215F0A6C1 == "dpad_up" || _id_7C2DF55215F0A6C1 == "uparrow") {
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
    } else if(_id_7C2DF55215F0A6C1 == "dpad_down" || _id_7C2DF55215F0A6C1 == "downarrow") {
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
    } else if(_id_7C2DF55215F0A6C1 == "button_a" || _id_7C2DF55215F0A6C1 == "dpad_right" || _id_7C2DF55215F0A6C1 == "dpad_left" || _id_7C2DF55215F0A6C1 == "rightarrow" || _id_7C2DF55215F0A6C1 == "leftarrow") {
      if(_id_7C2DF55215F0A6C1 == "dpad_left" || _id_7C2DF55215F0A6C1 == "leftarrow")
        modifiers["shift"] = 1;

      key = level.menu_cursor.current_pos;
    } else
      key = int(_id_7C2DF55215F0A6C1) - 1;

    if(level.player buttonPressed("lshift") || level.player buttonPressed("rshift"))
      modifiers["shift"] = 1;

    if(level.menu_sys[menu_name].can_exit)
      _id_948956FC01CD486C = 2;
    else
      _id_948956FC01CD486C = 1;

    if(key >= level.menu_sys["current_menu"].options.size)
      continue;
    else if(level.menu_sys[menu_name].can_exit && key == level.menu_sys["current_menu"].options.size - 1) {
      level notify("exit_menu");
      level.exitmenu = 1;
      continue;
    } else if(level.menu_sys[menu_name].options.size > 20 && key == level.menu_sys["current_menu"].options.size - _id_948956FC01CD486C) {
      _id_A0A3F3907785BE0E = 0;

      if(modifiers["shift"] && level.menu_sys[menu_name].page > 0) {
        level.menu_sys[menu_name].page--;
        _id_A0A3F3907785BE0E = 1;
      } else if(!modifiers["shift"] && level.menu_sys[menu_name].page < floor(level.menu_sys[menu_name].options.size / 20)) {
        level.menu_sys[menu_name].page++;
        _id_A0A3F3907785BE0E = 1;
      }

      if(_id_A0A3F3907785BE0E) {
        _id_B423A98E91E3E06E = level.menu_sys["current_menu"].options.size;
        clear_menu_options("current_menu");
        draw_menu_options(menu_name);

        if(level.menu_sys["current_menu"].options.size != _id_B423A98E91E3E06E) {
          level.menu_cursor.y = 300 + (level.menu_sys["current_menu"].options.size - _id_948956FC01CD486C + 1) * int(25.0);
          level.menu_cursor.current_pos = level.menu_sys["current_menu"].options.size - _id_948956FC01CD486C;
        }
      }

      continue;
    } else {
      _id_AB005BB685548F22 = key;
      key = key + level.menu_sys[menu_name].page * 20;
    }

    if(isDefined(level.menu_sys[menu_name].parent_menu) && key == level.menu_sys[menu_name].options.size) {
      level notify("disable " + menu_name);
      level enable_menu(level.menu_sys[menu_name].parent_menu);
    } else if(isDefined(level.menu_sys[menu_name].function) && isDefined(level.menu_sys[menu_name].function[key])) {
      func = undefined;

      if(!modifiers["shift"])
        func = level.menu_sys[menu_name].function[key];
      else if(isDefined(level.menu_sys[menu_name].backfunction))
        func = level.menu_sys[menu_name].backfunction[key];

      if(isDefined(func)) {
        ent = level;

        if(isDefined(level.menu_sys["current_menu"].ent))
          ent = level.menu_sys["current_menu"].ent;

        msg = ent[[func]]();

        if(isDefined(msg)) {
          level.menu_sys["current_menu"].optionsvalue[_id_AB005BB685548F22].text = msg;

          if(isDefined(level.menu_sys["current_menu"].optionsvalue[_id_AB005BB685548F22].isscripted))
            level.menu_sys["current_menu"].optionsvalue[_id_AB005BB685548F22].text = msg;
          else if(isnumber(msg))
            level.menu_sys["current_menu"].optionsvalue[_id_AB005BB685548F22] setvalue(msg);
          else
            level.menu_sys["current_menu"].optionsvalue[_id_AB005BB685548F22] clearalltextafterhudelem();
        }
      }
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
      _id_6A33FC6B173AEB0B = [[func]]();

      if(isDefined(_id_6A33FC6B173AEB0B)) {
        level thread selection_error(_id_6A33FC6B173AEB0B, level.menu_sys["current_menu"].options[_id_AB005BB685548F22].x, level.menu_sys["current_menu"].options[_id_AB005BB685548F22].y);
        continue;
      }
    }

    level enable_menu(level.menu_sys[menu_name].children_menu[key]);
    wait 0.1;
  }
}

menu_highlight(menu_name, index) {
  foreach(hud in level.menu_sys[menu_name].options)
  hud.color = (1, 1, 1);

  if(isDefined(level.menu_sys[menu_name].optionsvalue)) {
    foreach(hud in level.menu_sys[menu_name].optionsvalue)
    hud.color = (1, 1, 1);
  }

  if(isDefined(level.menu_sys[menu_name].optionsvalue) && isDefined(level.menu_sys[menu_name].optionsvalue[index]))
    level.menu_sys[menu_name].optionsvalue[index].color = (1, 1, 0);

  level.menu_sys[menu_name].options[index].color = (1, 1, 0);
}

hud_selector(x, y) {}

hud_selector_fade_out(time) {}

menu_get_selected_optionsvalue(index) {
  if(!isDefined(index))
    index = level.menu_cursor.current_pos;

  return level.menu_sys["current_menu"].optionsvalue[index];
}

_id_FAB54F8BF1F33485(_id_194D8BC9C448E603, value) {
  index = undefined;
  menu = level.menu_sys["current_menu"].menu_name;

  foreach(_id_AC0E594AC96AA3A8, _id_F834BFACD1FBFAC7 in level.menu_sys[menu].options) {
    if(_id_F834BFACD1FBFAC7 == _id_194D8BC9C448E603) {
      index = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  if(!isDefined(index)) {
    return;
  }
  level.menu_sys["current_menu"].optionsvalue[index].text = value;
}

get_current_menu_name() {
  return level.menu_sys["current_menu"].menu_name;
}

menu_get_selected(val) {
  if(!isDefined(val))
    val = level.menu_cursor.current_pos;

  return level.menu_sys["current_menu"].options[val];
}

menu_get_selected_text() {
  val = level.menu_cursor.current_pos;
  return level.menu_sys["current_menu"].options[val].text;
}

selection_error(msg, x, y) {
  hud = set_hudelem(undefined, x - 10, y, 1);

  if(scripts\common\utility::iscp())
    hud setshader("white", int(247.5), 20);
  else
    hud setshader("white", int(207.5), 20);

  hud.color = (0.5, 0, 0);
  hud.alpha = 0.7;

  if(scripts\common\utility::iscp())
    _id_9919866B3AD7D923 = set_hudelem(msg, x + int(247.5), y, 1);
  else
    _id_9919866B3AD7D923 = set_hudelem(msg, x + int(207.5), y, 1);

  _id_9919866B3AD7D923.color = (1, 0, 0);

  if(!isDefined(hud.debug_hudelem))
    hud fadeovertime(3);

  hud.alpha = 0;

  if(!isDefined(_id_9919866B3AD7D923.debug_hudelem))
    _id_9919866B3AD7D923 fadeovertime(3);

  _id_9919866B3AD7D923.alpha = 0;
  wait 3.1;
  hud destroy();
  _id_9919866B3AD7D923 destroy();
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

add_extrahuds(hud) {
  if(!isDefined(self.extrahuds))
    self.extrahuds = [];

  self.extrahuds[self.extrahuds.size] = hud;
}

list_menu(list, x, y, func, sort, _id_1619CB7C9A894084) {
  level endon("stop_all_menus");
  menu = menu_get_selected();

  if(!isDefined(list) || list.size == 0)
    return -1;

  _id_448919804EE75ECC = [];
  _id_C05ED239AE3D7A88 = 25.0;
  _id_C83AA9DBC3654AFA = set_scripthud("->", x - 20, y, 1.25, 1);
  _id_C83AA9DBC3654AFA.color = (0.8, 0.1, 0.1);
  menu add_extrahuds(_id_C83AA9DBC3654AFA);

  if(scripts\common\utility::issp()) {
    _id_BCBCE1F4C2DF63AA = 5;
    _id_827F335C2225D1EA = 2;
  } else {
    _id_BCBCE1F4C2DF63AA = 3;
    _id_827F335C2225D1EA = 1;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BCBCE1F4C2DF63AA; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 == 0)
      alpha = 0.1;
    else if(_id_AC0E594AC96AA3A8 == 1)
      alpha = 0.5;
    else if(_id_AC0E594AC96AA3A8 == 2)
      alpha = 1;
    else if(_id_AC0E594AC96AA3A8 == 3)
      alpha = 0.5;
    else
      alpha = 0.1;

    hud = set_scripthud(list[_id_AC0E594AC96AA3A8], x, y + (_id_AC0E594AC96AA3A8 - _id_827F335C2225D1EA) * _id_C05ED239AE3D7A88, 1.25, alpha);
    menu add_extrahuds(hud);
    _id_448919804EE75ECC = scripts\engine\utility::array_add(_id_448919804EE75ECC, hud);
  }

  if(isDefined(_id_1619CB7C9A894084))
    move_list_menu(_id_448919804EE75ECC, list, _id_1619CB7C9A894084, _id_827F335C2225D1EA);
  else
    move_list_menu(_id_448919804EE75ECC, list, 0, _id_827F335C2225D1EA);

  _id_FFC23ADD66803811 = 0;
  _id_B4E1AAC5196B4EA5 = 0;
  selected = 0;
  level.menu_list_selected = 0;

  if(isDefined(func))
    [[func]](list[_id_FFC23ADD66803811]);

  for(;;) {
    level waittill("menu_button_pressed", key);

    if(!isDefined(level.menu_cursor)) {
      selected = 0;
      break;
    }

    level.menu_list_selected = 1;

    if(any_button_hit(key, "numbers")) {
      break;
    } else if(key == "downarrow" || key == "dpad_down") {
      if(_id_FFC23ADD66803811 >= list.size - 1) {
        _id_FFC23ADD66803811 = 0;
        move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
        continue;
      }

      _id_FFC23ADD66803811++;
      move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
    } else if(key == "uparrow" || key == "dpad_up") {
      if(_id_FFC23ADD66803811 <= 0) {
        _id_FFC23ADD66803811 = list.size - 1;
        move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
        continue;
      }

      _id_FFC23ADD66803811--;
      move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
    } else if(key == "pgup") {
      if(_id_FFC23ADD66803811 <= 0) {
        _id_FFC23ADD66803811 = list.size - 1;
        move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
        continue;
      }

      _id_FFC23ADD66803811 = _id_FFC23ADD66803811 - 5;
      _id_FFC23ADD66803811 = clamp(_id_FFC23ADD66803811, 0, list.size - 1);
      _id_FFC23ADD66803811 = int(_id_FFC23ADD66803811);
      move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
    } else if(key == "pgdn") {
      if(_id_FFC23ADD66803811 >= list.size - 1) {
        _id_FFC23ADD66803811 = 0;
        move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
        continue;
      }

      _id_FFC23ADD66803811 = _id_FFC23ADD66803811 + 5;
      _id_FFC23ADD66803811 = clamp(_id_FFC23ADD66803811, 0, list.size - 1);
      _id_FFC23ADD66803811 = int(_id_FFC23ADD66803811);
      move_list_menu(_id_448919804EE75ECC, list, _id_FFC23ADD66803811, _id_827F335C2225D1EA);
    } else if(key == "enter" || key == "button_a" || key == "dpad_right" || key == "rightarrow") {
      selected = 1;
      break;
    } else if(key == "end" || key == "button_b" || key == "dpad_left" || key == "leftarrow") {
      selected = 0;
      break;
    }

    level notify("scroll_list");

    if(_id_FFC23ADD66803811 != _id_B4E1AAC5196B4EA5) {
      _id_B4E1AAC5196B4EA5 = _id_FFC23ADD66803811;

      if(isDefined(func))
        [[func]](list[_id_FFC23ADD66803811]);
    }

    wait 0.1;
  }

  if(_id_C83AA9DBC3654AFA.isscripted)
    _id_C83AA9DBC3654AFA scripthuddestroy();
  else
    _id_C83AA9DBC3654AFA destroy();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_448919804EE75ECC.size; _id_AC0E594AC96AA3A8++) {
    if(_id_448919804EE75ECC[_id_AC0E594AC96AA3A8].isscripted) {
      _id_448919804EE75ECC[_id_AC0E594AC96AA3A8] scripthuddestroy();
      continue;
    }

    _id_448919804EE75ECC[_id_AC0E594AC96AA3A8] destroy();
  }

  if(selected)
    return _id_FFC23ADD66803811;
}

move_list_menu(_id_448919804EE75ECC, list, num, _id_827F335C2225D1EA) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_448919804EE75ECC.size; _id_AC0E594AC96AA3A8++) {
    index = _id_AC0E594AC96AA3A8 + (num - _id_827F335C2225D1EA);

    if(isDefined(list[index]))
      text = list[index];
    else if(index < 0)
      text = list[list.size + index];
    else
      text = list[index % list.size];

    _id_448919804EE75ECC[_id_AC0E594AC96AA3A8].archived = 0;

    if(isDefined(_id_448919804EE75ECC[_id_AC0E594AC96AA3A8].isscripted)) {
      _id_448919804EE75ECC[_id_AC0E594AC96AA3A8].text = text;
      continue;
    }

    _id_448919804EE75ECC[_id_AC0E594AC96AA3A8] clearalltextafterhudelem();
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

add_universal_button(_id_CCBE539665D51E61, name) {
  if(!isDefined(level.u_buttons[_id_CCBE539665D51E61]))
    level.u_buttons[_id_CCBE539665D51E61] = [];

  if(array_check_for_dupes(level.u_buttons[_id_CCBE539665D51E61], name))
    level.u_buttons[_id_CCBE539665D51E61][level.u_buttons[_id_CCBE539665D51E61].size] = name;
}

array_check_for_dupes(array, single) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(array[_id_AC0E594AC96AA3A8] == single)
      return 0;
  }

  return 1;
}

clear_universal_buttons(_id_CCBE539665D51E61) {
  level.u_buttons[_id_CCBE539665D51E61] = [];
}

universal_input_loop(_id_CCBE539665D51E61, _id_0202BDD087FA1AE6, _id_0E8BC4850F59AB09, _id_3A96021A0DBE9E74, _id_B0B4000E275F51AA) {
  while(!isDefined(level.player))
    waitframe();

  level endon(_id_0202BDD087FA1AE6);

  if(!isDefined(_id_0E8BC4850F59AB09))
    _id_0E8BC4850F59AB09 = 0;

  _id_34FB06C037BE3746 = _id_CCBE539665D51E61 + "_button_pressed";
  buttons = level.u_buttons[_id_CCBE539665D51E61];
  level.u_buttons_disable[_id_CCBE539665D51E61] = 0;

  for(;;) {
    if(level.u_buttons_disable[_id_CCBE539665D51E61]) {
      waitframe();
      continue;
    }

    if(isDefined(_id_3A96021A0DBE9E74) && !level.player buttonPressed(_id_3A96021A0DBE9E74)) {
      waitframe();
      continue;
    } else if(isDefined(_id_B0B4000E275F51AA) && level.player buttonPressed(_id_B0B4000E275F51AA)) {
      waitframe();
      continue;
    }

    if(_id_0E8BC4850F59AB09 && level.player attackButtonPressed()) {
      level notify(_id_34FB06C037BE3746, "fire");
      wait 0.1;
      continue;
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < buttons.size; _id_AC0E594AC96AA3A8++) {
      if(level.player buttonPressed(buttons[_id_AC0E594AC96AA3A8])) {
        level notify(_id_34FB06C037BE3746, buttons[_id_AC0E594AC96AA3A8]);
        wait 0.1;
        break;
      }
    }

    waitframe();
  }
}

any_button_hit(_id_BEA0182094E2FEAF, type) {
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

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < buttons.size; _id_AC0E594AC96AA3A8++) {
    if(_id_BEA0182094E2FEAF == buttons[_id_AC0E594AC96AA3A8])
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
  _id_93F306D1E1EE14EE = 0;
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
  setsaveddvar("r_hudOutlineWidth", 2);

  if(isDefined(level.followcam_enabled) && isDefined(level.func["followcam"]))
    [[level.func["followcam"]]](0);
}

force_select(ent) {
  level.force_select_ent = ent;
}

select(ent) {
  deselect();
  ent endon("death");

  if(isnode(ent)) {
    ent notify("stop_highlight");
    ent thread draw_box_forever(ent.origin + (0, 0, 16), 32, (0.2, 1, 0.2), ent.angles, 32, "deselect");
  } else {
    ent hudoutlineenable("outline_nodepth_cyan");
    setsaveddvar("r_hudOutlineWidth", 2);
  }

  ent.selected = 1;
  level.selected = ent;
  wait 1;

  if(isnode(ent)) {
    return;
  }
  ent hudoutlinedisable();
  return;
}

add_selectable(ent) {
  if(!scripts\engine\utility::array_contains(level.selectable_ents, ent))
    level.selectable_ents[level.selectable_ents.size] = ent;
}

remove_selectable(ent) {
  level.selectable_ents = scripts\engine\utility::array_remove(level.selectable_ents, ent);
}

cleanup_selectable() {
  level.selectable_ents = scripts\engine\utility::array_removeundefined(level.selectable_ents);
}

selected_hint(msg) {
  hud = newhudelem();
  hud.y = 460;
  hud.x = 320;
  hud.alpha = 0.8;
  hud.alignx = "center";
  hud.aligny = "middle";
  hud.archived = 0;
  hud clearalltextafterhudelem();
  level.selectedhint = hud;
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
  start = level.player getEye();
  forward = anglesToForward(level.player getplayerangles());
  start = start + forward * 30;
  end = start + forward * 10000;
  trace = scripts\engine\trace::ray_trace_detail(start, end);
  _id_471E78CDCF5F5667 = trace["position"];
  highlighted_ent = undefined;
  _id_CB575C750E30791F = undefined;
  _id_25631945DE443058 = undefined;
  _id_1F5225000F4BE1F1 = undefined;
  highlighted_ent = get_selectable_ent(start, end, 40);

  if(isDefined(highlighted_ent)) {
    draw_highlight(highlighted_ent);
    level.highlighted_ent = highlighted_ent;
  } else {
    if(distance(trace["position"], _id_471E78CDCF5F5667) < 0.1) {
      if(is_place_clear(_id_471E78CDCF5F5667))
        level.cursor_pos = _id_471E78CDCF5F5667;
    }

    draw_axis();
    stop_previous_highlight();
    level.highlighted_ent = undefined;
  }
}

get_selectable_ent(start, end, _id_21B0311D64CADFA2) {
  cleanup_selectable();
  return get_selectable_from_array(level.selectable_ents, level.selected_node, start, end, _id_21B0311D64CADFA2);
}

get_selectable_from_array(array, _id_A7D15C687A065978, start, end, _id_21B0311D64CADFA2) {
  _id_21B0311D64CADFA2 = squared(_id_21B0311D64CADFA2);
  dist = _id_21B0311D64CADFA2;
  selected = undefined;

  foreach(ent in array) {
    origin = ent.origin;

    if(isent(ent) && isai(ent))
      origin = origin + (0, 0, 40);

    if(isDefined(_id_A7D15C687A065978) && _id_A7D15C687A065978 == ent) {
      continue;
    }
    point = pointonsegmentnearesttopoint(start, end, origin);
    _id_AC0E564AC96A9D0F = distancesquared(point, origin);

    if(_id_AC0E564AC96A9D0F < dist) {
      dist = _id_AC0E564AC96A9D0F;
      selected = ent;
    }
  }

  return selected;
}

draw_highlight(ent) {
  range = 4;
  color = (1, 1, 0.5);
  _id_FBEA67E67B07F196 = 1;
  duration = 1;

  if(isDefined(ent.is_spawner)) {
    stop_previous_highlight();
    draw_spawner(ent.origin, ent.angles, color);
  } else if(!isDefined(level.selected) && (!isDefined(level.highlighted_ent) || level.highlighted_ent != ent)) {
    stop_previous_highlight();

    if(isDefined(ent.onhighlight))
      ent thread[[ent.onhighlight]]();

    if(isnode(ent))
      ent thread draw_box_forever(ent.origin + (0, 0, 16), 32, (1, 1, 0), ent.angles, 32);
    else
      ent hudoutlineenable("outline_nodepth_orange");
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

draw_spawner(pos, angles, color) {
  end = pos + anglesToForward(angles) * 20;
  _draw_arrow(pos + (0, 0, 36), end + (0, 0, 36), color);
  draw_box(pos, color, angles, 72);
}

_draw_arrow(start, end, color) {
  angle = vectortoangles(end - start);
  dist = length(end - start);
  forward = anglesToForward(angle);
  _id_4B01E6DB3ABF9DDB = forward * dist;
  _id_6D57DF1B675794B6 = 5;
  _id_3A8939B94BA42EEA = forward * (dist - _id_6D57DF1B675794B6);
  right = anglestoright(angle);
  _id_7B11357F8F8851FE = right * (_id_6D57DF1B675794B6 * -1);
  _id_33B0514767568857 = right * _id_6D57DF1B675794B6;
}

draw_box_forever(pos, width, color, angles, height, _id_0202BDD087FA1AE6) {
  if(isDefined(_id_0202BDD087FA1AE6))
    self endon(_id_0202BDD087FA1AE6);
  else
    self endon("stop_highlight");

  for(;;) {
    draw_box(pos, width, color, angles, height);
    waitframe();
  }
}

draw_box(pos, width, color, angles, height) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  if(!isDefined(width))
    width = 32;

  if(!isDefined(height))
    height = 32;

  forward = anglesToForward(angles);
}

draw_axis() {
  _id_A61C75B156FC1EE0 = 5;
  pos = level.cursor_pos;
  color = 1;
  _id_FBEA67E67B07F196 = 1;
}

init_crosshair() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  crosshair = newhudelem();
  crosshair.location = 0;
  crosshair.alignx = "center";
  crosshair.aligny = "middle";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 1;
  crosshair.x = 320;
  crosshair.y = 237;
  crosshair.archived = 0;
}

is_place_clear(org) {
  _id_7DB9BD50AD5184D0 = getdvarint("ai_place");
  _id_63F445469B886BF8 = 6;
  _id_45A183C0669A828F = 360 / _id_63F445469B886BF8;
  _id_465A06BAE1ABB77E = squared(0.1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    angles = (-30, _id_AC0E594AC96AA3A8 * _id_45A183C0669A828F, 0);
    forward = anglesToForward(angles);
    endpos = org + forward * 30;
    trace = scripts\engine\trace::ray_trace(org, endpos, undefined, scripts\engine\trace::create_solid_ai_contents(1));
    pos = trace["position"];
    dist = distancesquared(pos, endpos);

    if(dist > _id_465A06BAE1ABB77E)
      return 0;

    trace = scripts\engine\trace::ray_trace(endpos + (0, 0, 42), endpos, undefined, scripts\engine\trace::create_solid_ai_contents(1));
    pos = trace["position"];

    if(dist > _id_465A06BAE1ABB77E)
      return 0;
  }

  return 1;
}