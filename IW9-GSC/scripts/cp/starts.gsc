/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\starts.gsc
***********************************************/

init_starts() {
  scripts\engine\utility::flag_init("start_is_set");
  scripts\cp\utility::add_start("no_game", ::start_nogame);
  add_no_game_starts();
}

start_nogame() {}

do_starts() {
  thread handle_starts();
  do_no_game_start();
}

add_no_game_starts() {
  _id_66AB67677B93DD3D = getEntArray("script_origin_start_nogame", "classname");

  if(!_id_66AB67677B93DD3D.size) {
    return;
  }
  foreach(_id_0C3EA9B1A20FF199 in _id_66AB67677B93DD3D) {
    if(!isDefined(_id_0C3EA9B1A20FF199.script_startname)) {
      continue;
    }
    scripts\cp\utility::add_start("no_game_" + _id_0C3EA9B1A20FF199.script_startname, ::start_nogame);
  }
}

do_no_game_start() {
  if(!is_no_game_start()) {
    return;
  }
  level waittill("eternity");
}

start_menu() {}

get_start_dvars() {
  _id_09A8C945FE45C8E5 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.start_functions.size; _id_AC0E594AC96AA3A8++)
    _id_09A8C945FE45C8E5[_id_09A8C945FE45C8E5.size] = level.start_functions[_id_AC0E594AC96AA3A8]["name"];

  return _id_09A8C945FE45C8E5;
}

display_starts() {
  if(level.start_functions.size <= 0) {
    return;
  }
  _id_09A8C945FE45C8E5 = get_start_dvars();
  _id_09A8C945FE45C8E5[_id_09A8C945FE45C8E5.size] = "default";
  _id_09A8C945FE45C8E5[_id_09A8C945FE45C8E5.size] = "cancel";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    level.players[_id_AC0E594AC96AA3A8] freezecontrols(1);

  _id_2E5F671F800DB00F = start_list_menu();
  title = create_start("Selected Start:", -1);
  title.color = (1, 1, 1);
  strings = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_09A8C945FE45C8E5.size; _id_AC0E594AC96AA3A8++) {
    dvar = _id_09A8C945FE45C8E5[_id_AC0E594AC96AA3A8];
    _id_16EE78BE2C1E34B5 = "[" + _id_09A8C945FE45C8E5[_id_AC0E594AC96AA3A8] + "]";
    strings[strings.size] = _id_16EE78BE2C1E34B5;
  }

  selected = _id_09A8C945FE45C8E5.size - 1;
  _id_AFE3F74CC0310E71 = 0;
  _id_3A509549F27FE5C0 = 0;

  for(_id_23C24FAF493B443A = 0; selected > 0; selected--) {
    if(_id_09A8C945FE45C8E5[selected] == level.start_point) {
      _id_23C24FAF493B443A = 1;
      break;
    }
  }

  if(!_id_23C24FAF493B443A)
    selected = _id_09A8C945FE45C8E5.size - 1;

  start_list_settext(_id_2E5F671F800DB00F, strings, selected);
  _id_BE30910D301F5836 = selected;
  _id_1A6F1E60B90FBE7C = 0;

  for(;;) {
    if(_id_BE30910D301F5836 != selected) {
      start_list_settext(_id_2E5F671F800DB00F, strings, selected);
      _id_BE30910D301F5836 = selected;
    }

    if(gettime() - _id_1A6F1E60B90FBE7C > 150) {
      _id_AFE3F74CC0310E71 = 0;
      _id_3A509549F27FE5C0 = 0;
    }

    if(!_id_AFE3F74CC0310E71) {
      if(level.player buttonPressed("UPARROW") || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("APAD_UP")) {
        _id_AFE3F74CC0310E71 = 1;
        _id_1A6F1E60B90FBE7C = gettime();
        selected--;
      }
    } else if(!level.player buttonPressed("UPARROW") && !level.player buttonPressed("DPAD_UP") && !level.player buttonPressed("APAD_UP"))
      _id_AFE3F74CC0310E71 = 0;

    if(!_id_3A509549F27FE5C0) {
      if(level.player buttonPressed("DOWNARROW") || level.player buttonPressed("DPAD_DOWN") || level.player buttonPressed("APAD_DOWN")) {
        _id_3A509549F27FE5C0 = 1;
        _id_1A6F1E60B90FBE7C = gettime();
        selected++;
      }
    } else if(!level.player buttonPressed("DOWNARROW") && !level.player buttonPressed("DPAD_DOWN") && !level.player buttonPressed("APAD_DOWN"))
      _id_3A509549F27FE5C0 = 0;

    if(selected < 0)
      selected = _id_09A8C945FE45C8E5.size - 1;

    if(selected >= _id_09A8C945FE45C8E5.size)
      selected = 0;

    if(level.player buttonPressed("BUTTON_B") || level.player buttonPressed("escape")) {
      start_display_cleanup(_id_2E5F671F800DB00F, title);
      break;
    }

    if(level.player buttonPressed("kp_enter") || level.player buttonPressed("BUTTON_A") || level.player buttonPressed("enter")) {
      if(_id_09A8C945FE45C8E5[selected] == "cancel") {
        start_display_cleanup(_id_2E5F671F800DB00F, title);
        break;
      }

      setDvar("start", _id_09A8C945FE45C8E5[selected]);
      map_restart();
    }

    wait 0.05;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    level.players[_id_AC0E594AC96AA3A8] freezecontrols(0);
}

start_list_menu() {
  _id_448919804EE75ECC = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 11; _id_AC0E594AC96AA3A8++) {
    hud = create_start("", _id_AC0E594AC96AA3A8);
    _id_448919804EE75ECC[_id_448919804EE75ECC.size] = hud;
  }

  return _id_448919804EE75ECC;
}

start_list_settext(_id_448919804EE75ECC, strings, num) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_448919804EE75ECC.size; _id_AC0E594AC96AA3A8++) {
    index = _id_AC0E594AC96AA3A8 + (num - 5);

    if(isDefined(strings[index]))
      text = strings[index];
    else
      text = "";

    _id_448919804EE75ECC[_id_AC0E594AC96AA3A8] settext(text);
  }
}

start_display_cleanup(_id_2E5F671F800DB00F, title) {
  title destroy();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2E5F671F800DB00F.size; _id_AC0E594AC96AA3A8++)
    _id_2E5F671F800DB00F[_id_AC0E594AC96AA3A8] destroy();
}

handle_starts() {
  level endon("game_ended");
  level.start_struct = spawnStruct();
  setdvarifuninitialized("start", "");

  if(getDvar("scr_generateclipmodels") != "" && getDvar("scr_generateclipmodels") != "0") {
    return;
  }
  if(!isDefined(level.start_functions))
    level.start_functions = [];

  start = tolower(getDvar("start"));

  if(scripts\cp\cp_checkpoint::_id_C506F6B5C63E776C()) {
    return;
  }
  _id_09A8C945FE45C8E5 = get_start_dvars();

  if(isDefined(level.start_point))
    start = level.start_point;

  _id_2F05FDC372F83530 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_09A8C945FE45C8E5.size; _id_AC0E594AC96AA3A8++) {
    if(start == _id_09A8C945FE45C8E5[_id_AC0E594AC96AA3A8]) {
      _id_2F05FDC372F83530 = _id_AC0E594AC96AA3A8;
      level.start_point = _id_09A8C945FE45C8E5[_id_AC0E594AC96AA3A8];
      break;
    }
  }

  if(isDefined(level.default_start_override) && !isDefined(level.start_point)) {
    foreach(index, dvar in _id_09A8C945FE45C8E5) {
      if(level.default_start_override == dvar) {
        _id_2F05FDC372F83530 = index;
        level.start_point = dvar;
        break;
      }
    }
  }

  if(!isDefined(level.start_point)) {
    if(isDefined(level.default_start))
      level.start_point = "default";
    else if(level_has_start_points()) {
      level.start_point = level.start_functions[0]["name"];

      if(is_no_game_start() && level.start_functions.size > 1)
        level.start_point = level.start_functions[1]["name"];
      else
        level.start_point = "default";
    } else
      level.start_point = "default";
  }

  waittillframeend;
  scripts\engine\utility::flag_set("start_is_set");
  thread start_menu();
  _id_D1C6381E96D14169 = level.start_arrays[level.start_point];

  if(level.start_point == "default") {
    if(isDefined(level.default_start))
      level thread[[level.default_start]]();
  } else {
    _id_D1C6381E96D14169 = level.start_arrays[level.start_point];

    if(isDefined(_id_D1C6381E96D14169["start_func"]))
      thread[[_id_D1C6381E96D14169["start_func"]]]();
  }

  if(scripts\cp\utility::is_default_start())
    string = get_string_for_starts(_id_09A8C945FE45C8E5);

  if(getdvarint("fpstool_run")) {
    string = get_string_for_starts(_id_09A8C945FE45C8E5);
    setDvar("start", string);
    setDvar("dvar_46467383874E22FD", "");
  }

  waittillframeend;
  _id_8751813F2DAE82EE = [];

  if(!scripts\cp\utility::is_default_start() && level.start_point != "no_game") {
    time = gettime();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.start_functions.size; _id_AC0E594AC96AA3A8++) {
      _id_D1C6381E96D14169 = level.start_functions[_id_AC0E594AC96AA3A8];

      if(_id_D1C6381E96D14169["name"] == level.start_point) {
        break;
      }

      if(!isDefined(_id_D1C6381E96D14169["catchup_function"])) {
        continue;
      }
      [[_id_D1C6381E96D14169["catchup_function"]]]();
    }
  }

  for(_id_AC0E594AC96AA3A8 = _id_2F05FDC372F83530; _id_AC0E594AC96AA3A8 < level.start_functions.size; _id_AC0E594AC96AA3A8++) {
    _id_D1C6381E96D14169 = level.start_functions[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_D1C6381E96D14169["logic_func"])) {
      continue;
    }
    if(already_ran_function(_id_D1C6381E96D14169["logic_func"], _id_8751813F2DAE82EE)) {
      continue;
    }
    if(getdvarint("fpstool_run") || getdvarint("prof_gameplaygfx"))
      setDvar("dvar_46467383874E22FD", _id_D1C6381E96D14169["name"]);

    level.start_struct[[_id_D1C6381E96D14169["logic_func"]]]();

    if(getdvarint("dvar_47B7445B595408F7", 0) > 0) {
      return;
    }
    _id_8751813F2DAE82EE[_id_8751813F2DAE82EE.size] = _id_D1C6381E96D14169["logic_func"];
  }
}

already_ran_function(func, _id_8751813F2DAE82EE) {
  foreach(_id_FB707540FFB0FBDA in _id_8751813F2DAE82EE) {
    if(_id_FB707540FFB0FBDA == func)
      return 1;
  }

  return 0;
}

get_string_for_starts(_id_09A8C945FE45C8E5) {
  string = " ** No starts have been set up for this map with scriptsenginecputility::add_start().";

  if(_id_09A8C945FE45C8E5.size) {
    string = " ** ";

    for(_id_AC0E594AC96AA3A8 = _id_09A8C945FE45C8E5.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--)
      string = string + _id_09A8C945FE45C8E5[_id_AC0E594AC96AA3A8] + " ";
  }

  return string;
}

create_start(start, index) {
  alpha = 1;
  color = (0.9, 0.9, 0.9);

  if(index != -1) {
    _id_63E26D5A86AC531C = 5;

    if(index != _id_63E26D5A86AC531C)
      alpha = 1 - abs(_id_63E26D5A86AC531C - index) / _id_63E26D5A86AC531C;
    else
      color = (1, 1, 0);
  }

  if(alpha == 0)
    alpha = 0.05;

  _id_94480E1669B7FF0D = newhudelem();
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "middle";
  _id_94480E1669B7FF0D.x = 80;
  _id_94480E1669B7FF0D.y = 80 + index * 18;
  _id_94480E1669B7FF0D settext(start);
  _id_94480E1669B7FF0D.alpha = 0;
  _id_94480E1669B7FF0D.foreground = 1;
  _id_94480E1669B7FF0D.color = color;
  _id_94480E1669B7FF0D.fontscale = 1.75;
  _id_94480E1669B7FF0D fadeovertime(0.5);
  _id_94480E1669B7FF0D.alpha = alpha;
  return _id_94480E1669B7FF0D;
}

indicate_start(start) {
  _id_94480E1669B7FF0D = newhudelem();
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "middle";
  _id_94480E1669B7FF0D.x = 10;
  _id_94480E1669B7FF0D.y = 400;
  _id_94480E1669B7FF0D settext(start);
  _id_94480E1669B7FF0D.alpha = 0;
  _id_94480E1669B7FF0D.fontscale = 3;
  wait 1;
  _id_94480E1669B7FF0D fadeovertime(1);
  _id_94480E1669B7FF0D.alpha = 1;
  wait 5;
  _id_94480E1669B7FF0D fadeovertime(1);
  _id_94480E1669B7FF0D.alpha = 0;
  wait 1;
  _id_94480E1669B7FF0D destroy();
}

force_start_catchup() {
  level.forced_start_catchup = 1;
}

is_first_start() {
  if(!level_has_start_points())
    return 1;

  return level.start_point == level.start_functions[0]["name"];
}

is_after_start(name) {
  _id_81878D29F5A714F3 = 0;

  if(level.start_point == name)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.start_functions.size; _id_AC0E594AC96AA3A8++) {
    if(level.start_functions[_id_AC0E594AC96AA3A8]["name"] == name) {
      _id_81878D29F5A714F3 = 1;
      continue;
    }

    if(level.start_functions[_id_AC0E594AC96AA3A8]["name"] == level.start_point)
      return _id_81878D29F5A714F3;
  }
}

add_start_construct(msg, func, _id_8A65799B42BD1960, _id_7A3C1094F38EC7D2) {
  array = [];
  array["name"] = msg;
  array["start_func"] = func;
  array["logic_func"] = _id_8A65799B42BD1960;
  array["catchup_function"] = _id_7A3C1094F38EC7D2;
  return array;
}

add_start_assert() {
  if(!isDefined(level.start_functions))
    level.start_functions = [];
}

level_has_start_points() {
  return level.start_functions.size > 1;
}

is_no_game_start() {
  if(isDefined(level.start_point))
    return issubstr(level.start_point, "no_game");
  else
    return getDvar("start") == "no_game";
}