/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\starts.gsc
**************************************/

#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\audio;
#using scripts\sp\hud_util;
#using scripts\sp\trigger;
#namespace starts;

function init_starts() {
  utility::flag_init("v8\xdf\xed\x16\x1e~\xb5\xb7\xef\xd0M");
  setdvarifuninitialized(@ "feedback", 0);

  setdvarifuninitialized(@ "hash_db3a10a9091fba59", 0);
  setdvarifuninitialized(@ "hash_7392d6caef3964a1", 0);

  utility_sp::add_start("@w^' \xdaR", &start_nogame);
  add_no_game_starts();
}

function do_starts() {
  thread handle_starts();
  do_no_game_start();
}

function add_no_game_starts() {
  start_spots = getEntArray("\xd7X\xd3\xf2\xc5X\xb2o\xfei\x91\x85s\xc2\xb0njM\ts&\xb5\xbdE\x83\xa0", #classname);

  if(!start_spots.size) {
    return;
  }

  foreach(spot in start_spots) {
    if(!isDefined(spot.script_startname)) {
      continue;
    }

    utility_sp::add_start("\xdd\xa8\xb9'*\x81\xfbW" + spot.script_startname, &start_nogame);
  }
}

function do_no_game_start() {
  if(!is_no_game_start()) {
    return;
  }

  setsaveddvar(@ "hash_1cc4e4a2542af7f5", "\x87");

  if(isDefined(level.custom_no_game_setupfunc)) {
    level[[level.custom_no_game_setupfunc]]();
  }

  audio::init_audio();
  do_no_game_start_teleport();
  utility::array_call(getEntArray("S\x1b\x85\x8b\xd8\x9d\xc5\xd9\xa0", #targetname), &delete);
  utility::array_call(getEntArray("S\x1b\x85\x8b\xd8\x9d\xc5\xd9\xa0", #script_noteworthy), &delete);
  level waittill("~r\xf3|_!\xe8\xb7");
}

function do_no_game_start_teleport() {
  start_spots = getEntArray("\xd7X\xd3\xf2\xc5X\xb2o\xfei\x91\x85s\xc2\xb0njM\ts&\xb5\xbdE\x83\xa0", #classname);

  if(!start_spots.size) {
    return;
  }

  start_spots = sortbydistance(start_spots, level.player.origin);

  if(level.start_point == "@w^' \xdaR") {
    level.player utility_sp::teleport_player(start_spots[0]);
    return;
  }

  var_34af05c0bc21c0a5 = getsubstr(level.start_point, 8);
  found_spot = 0;

  foreach(point in start_spots) {
    if(!isDefined(point.script_startname)) {
      continue;
    }

    if(var_34af05c0bc21c0a5 != point.script_startname) {
      continue;
    }

    if(isDefined(point.script_visionset)) {
      visionsetnaked(point.script_visionset, 0);
    }

    level.player utility_sp::teleport_player(point);
    found_spot = 1;
    break;
  }

  if(!found_spot) {
    level.player utility_sp::teleport_player(start_spots[0]);
  }
}

function start_nogame() {
  if(getdvarint(@ "hash_5d83147342337f0b") > 0) {
    spawners = getspawnerarray();

    foreach(spawner in spawners) {
      spawner.target = undefined;
      spawner.targetname = undefined;
    }
  } else {
    utility::array_call(getspawnerarray(), &delete);
  }

  utility::array_call(getaiarray(), &delete);
  trigger_classes = [];
  trigger_classes["%\xc1\xe4\xa1x\x154 &e\x01\xe3>\xc0\x8c\x99Dvf~\x8a\xcb/h\xbf\x94\xc0\x10z\xb9P\rw\xcdx)"] = &trigger::trigger_createart_transient;

  foreach(function in trigger_classes) {
    triggers = getEntArray(classname, #classname);
    utility::array_levelthread(triggers, function);
  }
}

function start_menu() {
  for(;;) {
    if(getdvarint(@ "debug_start")) {
      setdevdvar(@ "debug_start", 0);
      level.debug.debug_start = 1;
      display_starts();
      level.debug.debug_start = 0;
    }

    wait 0.05;
  }
}

function get_start_dvars() {
  dvars = [];

  for(i = 0; i < level.start_functions.size; i++) {
    dvars[dvars.size] = level.start_functions[i]["\xf4\x1f\x13\xee"];
  }

  return dvars;
}

function display_starts() {
  if(level.start_functions.size <= 0) {
    return;
  }

  dvars = get_start_dvars();
  dvars[dvars.size] = "\x91\xca\xcc\v\xab\xd8:";
  dvars[dvars.size] = "\xb6\x1cl\xdf_b";
  level.player val::set("q\x9e\x88{3\xd7\x11p\xe0\xadoq\xe4`", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
  level.player enableinvulnerability();
  level.player freezecontrols(1);
  elems = start_list_menu();
  title = create_start("\x1a.T7\x06\xdd#\xac*\x89\x1e\x0f\xac?\x9e", -1);
  title.color = (1, 1, 1);
  strings = [];

  for(i = 0; i < dvars.size; i++) {
    dvar = dvars[i];
    start_string = "O" + dvars[i] + "L";
    strings[strings.size] = start_string;
  }

  selected = dvars.size - 1;
  up_pressed = 0;
  down_pressed = 0;
  var_e5d5fb5993a48503 = 0;

  while(selected > 0) {
    if(dvars[selected] == level.start_point) {
      var_e5d5fb5993a48503 = 1;
      break;
    }

    selected--;
  }

  if(!var_e5d5fb5993a48503) {
    selected = dvars.size - 1;
  }

  start_list_settext(elems, strings, selected);
  old_selected = selected;
  last_presstime = 0;

  for(;;) {
    if(old_selected != selected) {
      start_list_settext(elems, strings, selected);
      old_selected = selected;
    }

    if(gettime() - last_presstime > 150) {
      up_pressed = 0;
      down_pressed = 0;
    }

    if(!up_pressed) {
      if(level.player buttonPressed("U((\x94\x92=\xab") || level.player buttonPressed(",\xac\xc2\xa4g\xe6\xf4") || level.player buttonPressed("B\xe5\xd7\x9a$\xc5\xcc")) {
        up_pressed = 1;
        last_presstime = gettime();
        selected--;
      }
    } else if(!level.player buttonPressed("U((\x94\x92=\xab") && !level.player buttonPressed(",\xac\xc2\xa4g\xe6\xf4") && !level.player buttonPressed("B\xe5\xd7\x9a$\xc5\xcc")) {
      up_pressed = 0;
    }

    if(!down_pressed) {
      if(level.player buttonPressed("\xdf\x90\xbe.\x87 k\xccM") || level.player buttonPressed("\x96I\x12H\xa5\xf0z\xe8\x11") || level.player buttonPressed("\xbe4\xc8\xbe\x87\xcc\xeb\xc5\xa1")) {
        down_pressed = 1;
        last_presstime = gettime();
        selected++;
      }
    } else if(!level.player buttonPressed("\xdf\x90\xbe.\x87 k\xccM") && !level.player buttonPressed("\x96I\x12H\xa5\xf0z\xe8\x11") && !level.player buttonPressed("\xbe4\xc8\xbe\x87\xcc\xeb\xc5\xa1")) {
      down_pressed = 0;
    }

    if(selected < 0) {
      selected = dvars.size - 1;
    }

    if(selected >= dvars.size) {
      selected = 0;
    }

    if(level.player buttonPressed("5\xee\xb7\xe0\x1e\nK6") || level.player buttonPressed("\x95n\xc6X8\xac")) {
      start_display_cleanup(elems, title);
      break;
    }

    if(level.player buttonPressed("F\xc1>\xbaaF\xc1P") || level.player buttonPressed("Z\xbb,\x1a\x15\xcf\x1e\xa8") || level.player buttonPressed("b\xd8\x05g8")) {
      if(dvars[selected] == "\xb6\x1cl\xdf_b") {
        start_display_cleanup(elems, title);
        break;
      }

      setDvar(@ "start", dvars[selected]);
      map_restart();
    }

    wait 0.05;
  }

  level.player freezecontrols(0);
  level.player disableinvulnerability();
  level.player val::reset_all("q\x9e\x88{3\xd7\x11p\xe0\xadoq\xe4`");
}

function start_list_menu() {
  hud_array = [];

  for(i = 0; i < 11; i++) {
    hud = create_start("", i);
    hud_array[hud_array.size] = hud;
  }

  return hud_array;
}

function start_list_settext(hud_array, strings, num) {
  for(i = 0; i < hud_array.size; i++) {
    index = i + num - 5;

    if(isDefined(strings[index])) {
      text = strings[index];
    } else {
      text = "";
    }

    hud_array[i] settext(text);
  }
}

function start_display_cleanup(elems, title) {
  title destroy();

  for(i = 0; i < elems.size; i++) {
    elems[i] destroy();
  }
}

function start_load_transients() {
  var_110b20a2acd4c58d = [];

  if(isloadingsavegame()) {
    var_110b20a2acd4c58d = getsavegametransients();
  } else {
    if(level.start_point != "\x91\xca\xcc\v\xab\xd8:") {
      start_array = level.start_arrays[level.start_point];

      if(isDefined(start_array["\xd8\xf4\xc7\x8f2\xdbV\x05\f"])) {
        var_a6028af6b2454854 = start_array["\xd8\xf4\xc7\x8f2\xdbV\x05\f"];

        if(isstring(var_a6028af6b2454854)) {
          if(var_a6028af6b2454854 == "\r+x5") {
            var_110b20a2acd4c58d = [];
          } else {
            set_names = gettransientsetnames();
            set_match = "\r+x5";

            foreach(name in set_names) {
              if(var_a6028af6b2454854 == name) {
                set_match = var_a6028af6b2454854;
                level.transient_sets[var_a6028af6b2454854] = 1;
                break;
              }
            }

            if(set_match == "\r+x5") {
              var_110b20a2acd4c58d = [var_a6028af6b2454854];
            } else {
              var_110b20a2acd4c58d = gettransientsinset(set_match);
            }
          }
        } else if(isarray(var_a6028af6b2454854)) {
          var_110b20a2acd4c58d = var_a6028af6b2454854;
        }
      }
    }

    foreach(entry in var_110b20a2acd4c58d) {
      if(!isspleveltransient(entry)) {
        utility::error("\xbb\xd0\xf2\xe9^\xd3\xb7I\xc2,\xdbc,`\f\xdd\xebd\x1b\x1ell\xff;\x177\x11\xb2\x1b\xa1\x82\xee\xbd\x04\x91$\xbc\xaav+\xd7\xf7\xec!%\xf3\x81\xf8Ax\xc6\x86e" + entry);
      }
    }
  }

  if(var_110b20a2acd4c58d.size > 0) {
    loadstartpointtransients(var_110b20a2acd4c58d);

    foreach(transient in var_110b20a2acd4c58d) {
      utility::flag_set(transient + "y\xdc\xd6\xf3\x01\xab\xc9");
    }

    level notify("\xfb\vn\xf5LoI\xd2\xb7N\xda\xd4\xd7\xb8\xe7\x9b\xe4\xf0,\xa2");
    return;
  }

  clearstartpointtransients();
}

function handle_starts() {
  level.start_struct = spawnStruct();
  setdvarifuninitialized(@ "start", "");

  if(getDvar(@ "hash_7f5c464e214c560c") != "" && getDvar(@ "hash_7f5c464e214c560c") != "\xfe") {
    return;
  }

  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }

  assert(getDvar(@ "jumpto") == "<dev string:x24>", "<dev string:x28>");
  start = tolower(getDvar(@ "start"));
  dvars = get_start_dvars();

  if(isDefined(level.start_point)) {
    start = level.start_point;
  }

  if(getdvarint(@ "feedback")) {
    start = level.feedback_start_point;
  }

  start_index = 0;

  for(i = 0; i < dvars.size; i++) {
    if(start == dvars[i]) {
      start_index = i;
      level.start_point = dvars[i];
      break;
    }
  }

  if(isDefined(level.default_start_override_alt) && !isDefined(level.start_point)) {
    previous_mission = level.player getplayerprogression("\x9c\x80\xf4H)\a{uko\xac\xa2\x10\xcf\xc9\xa3\xa3\xc9\xed\x1a");

    if(isDefined(previous_mission)) {
      tok = strtok(previous_mission, "w");

      if(isDefined(previous_mission) && tok.size > 0) {
        if(tok[0] == "\x10\x96" || tok[0] == "\xa9\xc2") {
          foreach(index, dvar in dvars) {
            if(level.default_start_override_alt == dvar) {
              start_index = index;
              level.start_point = dvar;
              break;
            }
          }
        }
      }
    }
  }

  if(isDefined(level.default_start_override) && !isDefined(level.start_point)) {
    foreach(dvar in dvars) {
      if(level.default_start_override == dvar) {
        start_index = index;
        level.start_point = dvar;
        break;
      }
    }
  }

  if(!isDefined(level.start_point)) {
    if(isDefined(level.default_start)) {
      level.start_point = "\x91\xca\xcc\v\xab\xd8:";
    } else if(level_has_start_points()) {
      level.start_point = level.start_functions[0]["\xf4\x1f\x13\xee"];
    } else {
      level.start_point = "\x91\xca\xcc\v\xab\xd8:";
    }
  }

  start_load_transients();
  waittillframeend();
  utility::flag_set("v8\xdf\xed\x16\x1e~\xb5\xb7\xef\xd0M");
  thread start_menu();
  start_array = level.start_arrays[level.start_point];

  if(isDefined(start_array) && isDefined(start_array["`u\xfdl\x17^\x80h\xd1nG\xa5eQh"])) {
    setomnvar("D\xb3\xbe\x8eX\xbb\x9a\xd1H\x1d\xa2IN", "\xae51W\xac]");
    setsaveddvar(@ "hash_e5e11740f51a39d5", 1);
  } else {
    setomnvar("D\xb3\xbe\x8eX\xbb\x9a\xd1H\x1d\xa2IN", "\xea8\xc1\xbdmL\xb4\x13");
  }

  if(level.start_point == "\x91\xca\xcc\v\xab\xd8:") {
    if(isDefined(level.default_start)) {
      level thread[[level.default_start]]();
    }
  } else {
    start_array = level.start_arrays[level.start_point];

    thread indicate_start(level.start_point);
    thread function_14cc7cba615cc7ea();

    function_ae9d7aed84ab7e65();
    thread[[start_array["}\xdc\xb4\xce\xe1\x0e>y(\xea"]]]();
  }

  if(utility_sp::is_default_start() || getdvarint(@ "fpstool_run")) {
    string = get_string_for_starts(dvars);
    setDvar(@ "start", string);
  }

  if(getdvarint(@ "fpstool_run")) {
    setDvar(@ "hash_46467383874e22fd", "");
  }

  waittillframeend();

  if(isloadingsavegame()) {
    wait 0.1;
  }

  var_86ff52c7abec9047 = [];

  if(!utility_sp::is_default_start() && level.start_point != "@w^' \xdaR") {
    time = gettime();

    for(i = 0; i < level.start_functions.size; i++) {
      start_array = level.start_functions[i];

      if(start_array["\xf4\x1f\x13\xee"] == level.start_point) {
        break;
      }

      if(!isDefined(start_array["c\xddez\xb2\xad\xbd\x93\xf6\xf1h\x1a&\x90\x88\xc6"])) {
        continue;
      }

      [[start_array["c\xddez\xb2\xad\xbd\x93\xf6\xf1h\x1a&\x90\x88\xc6"]]]();
    }

    assert(time == gettime(), "<dev string:x50>");
  }

  if(getdvarint(@ "scr_jumpstartpoints", 0) == 1) {
    thread jumpstartpoints();
  }

  for(i = start_index; i < level.start_functions.size; i++) {
    start_array = level.start_functions[i];

    if(!isDefined(start_array["K\x1bpQ'w\xeb\x8f>\xcf"])) {
      continue;
    }

    if(already_ran_function(start_array["K\x1bpQ'w\xeb\x8f>\xcf"], var_86ff52c7abec9047)) {
      continue;
    }

    if(getdvarint(@ "feedback")) {
      feedback_check_start(start_array, i);
    }

    if(getdvarint(@ "fpstool_run") || getdvarint(@ "prof_gameplaygfx")) {
      setDvar(@ "hash_46467383874e22fd", start_array["\xf4\x1f\x13\xee"]);
    }

    analytics::start_point_setup();
    level notify("\x0e])\xd8\xaeH!i>l\xff", start_array["\xf4\x1f\x13\xee"]);
    level.start_struct[[start_array["K\x1bpQ'w\xeb\x8f>\xcf"]]]();
    analytics::start_point_check(start_array["\xf4\x1f\x13\xee"]);
    var_86ff52c7abec9047[var_86ff52c7abec9047.size] = start_array["K\x1bpQ'w\xeb\x8f>\xcf"];

    if(getdvarint(@ "feedback")) {
      feedback_increase_index();
    }
  }
}

function already_ran_function(func, var_86ff52c7abec9047) {
  foreach(logic_function in var_86ff52c7abec9047) {
    if(logic_function == func) {
      return true;
    }
  }

  return false;
}

function get_string_for_starts(dvars) {
  string = "d\\\xe1L\xb0>\xeb\x90\x97\xdeh\x9d\xb9\x84\xb0\xfa\x1f`\xcaHijb\x9d\x80E\xcf\x8b\xd3\xb5\x82\xb3\xdf\a\x80\x17\xb2:\xb8\xad\xed\xfbv\xcc\x9fB$\xee\x95p\x83%\nM\xa2j{\x10\xaf\x14[7dj\x83a<\xf4)r\xb7\x01\xf0\x1f\x14R\xf7\x81\x06\xf8'\x10\xe3^\x8c";

  if(dvars.size) {
    string = "\xdd\xea\x93\xda";

    for(i = dvars.size - 1; i >= 0; i--) {
      string = string + dvars[i] + "\xda";
    }
  }

  setDvar(@ "start", string);
  return string;
}

function create_start(start, index) {
  alpha = 1;
  color = (0.9, 0.9, 0.9);

  if(index != -1) {
    middle = 5;

    if(index != middle) {
      alpha = 1 - abs(middle - index) / middle;
    } else {
      color = (1, 1, 0);
    }
  }

  if(alpha == 0) {
    alpha = 0.05;
  }

  hudelem = newhudelem();
  hudelem.alignx = "=\xff0b";
  hudelem.aligny = "#\xb8\xfd\xf5\x1a@";
  hudelem.x = 80;
  hudelem.y = 80 + index * 18;
  hudelem settext(start);
  hudelem.alpha = 0;
  hudelem.foreground = 1;
  hudelem.color = color;
  hudelem.fontscale = 1.75;
  hudelem fadeovertime(0.5);
  hudelem.alpha = alpha;
  return hudelem;
}

function indicate_start(start) {
  if(istrue(level.var_4154c2b0903e4090)) {
    return;
  }

  if(getdvarint(@ "loc_warningsaserrors")) {
    return;
  }

  if(getdvarint(@ "hash_7392d6caef3964a1") == 1) {
    return;
  }

  hudelem = newhudelem();
  hudelem.alignx = "=\xff0b";
  hudelem.aligny = "#\xb8\xfd\xf5\x1a@";
  hudelem.x = 10;
  hudelem.y = 400;
  hudelem settext(start);
  hudelem.alpha = 0;
  hudelem.fontscale = 3;
  wait 1;
  hudelem fadeovertime(1);
  hudelem.alpha = 1;
  wait 5;
  hudelem fadeovertime(1);
  hudelem.alpha = 0;
  wait 1;
  hudelem destroy();
}

function function_14cc7cba615cc7ea() {
  if(getdvarint(@ "hash_db3a10a9091fba59") == 0) {
    return;
  }

  utility::flag_wait("<dev string:x82>");
  hudelem = newhudelem();
  hudelem.alignx = "<dev string:x92>";
  hudelem.aligny = "<dev string:x9a>";
  hudelem.x = 10;
  hudelem.y = 10;
  hudelem settext(level.start_point);
  hudelem.alpha = 0;
  hudelem.fontscale = 1;
  wait 1;
  hudelem fadeovertime(0.25);
  hudelem.alpha = 1;
  waitframe();

  for(;;) {
    level waittill("<dev string:xa1>", start_point);

    if(isDefined(start_point)) {
      hudelem settext(start_point);
    } else {
      hudelem settext("<dev string:xb0>");
    }

    wait 0.5;
  }
}

function force_start_catchup() {
  level.forced_start_catchup = 1;
}

function is_first_start() {
  if(!level_has_start_points()) {
    return true;
  }

  return level.start_point == level.start_functions[0]["\xf4\x1f\x13\xee"];
}

function is_after_start(name) {
  var_d9c74679c1a746fa = 0;
  name = tolower(name);

  if(level.start_point == name) {
    return 0;
  }

  for(i = 0; i < level.start_functions.size; i++) {
    if(level.start_functions[i]["\xf4\x1f\x13\xee"] == name) {
      var_d9c74679c1a746fa = 1;
      continue;
    }

    if(level.start_functions[i]["\xf4\x1f\x13\xee"] == level.start_point) {
      return var_d9c74679c1a746fa;
    }
  }
}

function create_feedback_starts(sarray) {
  if(!getdvarint(@ "feedback")) {
    return;
  }

  utility::flag_init("\xffm\xdd\xe9h3\x1a\x95\xebt9\xc9\xf3Z\x9a\x95\xa4\xe6\x93\x97\f\xe1Ur\x03 \xa2");
  setdvarifuninitialized(@ "feedback_index", 0);
  setdvarifuninitialized(@ "hash_b9725e2c8d3c3df7", 0);

  if(!getdvarint(@ "hash_b9725e2c8d3c3df7")) {
    setDvar(@ "feedback_index", 0);
  }

  setDvar(@ "hash_b9725e2c8d3c3df7", 0);
  tolower_sarray = [];

  foreach(s in sarray) {
    tolower_sarray[i] = tolower(s);
  }

  thread check_feedback_starts_existance(tolower_sarray);
  level.feedback_starts = tolower_sarray;
  level.feedback_start_point = tolower_sarray[getdvarint(@ "feedback_index")];
}

function create_feedback_context(start_name, context) {
  if(!getdvarint(@ "feedback")) {
    return;
  }

  start_name = tolower(start_name);

  if(!isDefined(level.feedback_context)) {
    level.feedback_context = [];
  }

  level.feedback_context[start_name] = ";\xb9" + context;
}

function create_feedback_endfunc(start_name, end_func, param) {
  if(!getdvarint(@ "feedback")) {
    return;
  }

  start_name = tolower(start_name);
  utility::flag_init(start_name + "n\xb6\xe0\n\xfaF\xa9t");
  thread create_feedback_endfunc_thread(start_name, end_func, param);
}

function display_feedback_context(start_name) {
  if(!isDefined(level.feedback_context)) {
    return;
  }

  if(!isDefined(level.feedback_context[start_name])) {
    return;
  }

  waitframe();

  iprintlnbold(level.feedback_context[start_name]);
}

function create_feedback_endfunc_thread(start_name, end_func, param) {
  level waittill("\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca");

  if(isDefined(param)) {
    [[end_func]](param);
  } else {
    [[end_func]]();
  }

  utility::flag_set(start_name + "n\xb6\xe0\n\xfaF\xa9t");
}

function feedback_check_start(start_array, start_index) {
  if(!isDefined(level.feedback_starts)) {
    return;
  }

  start_name = start_array["\xf4\x1f\x13\xee"];
  index = getdvarint(@ "feedback_index");
  thread feedback_check_endfunc(start_name, index);
  feedback_check_end(start_name, index);
  display_feedback_context(start_name);
}

function feedback_check_endfunc(start_name, index) {
  if(!isDefined(level.feedback_starts[index])) {
    return;
  }

  if(!utility::flag_exist(level.feedback_starts[index] + "n\xb6\xe0\n\xfaF\xa9t")) {
    return;
  }

  utility::flag_set("\xffm\xdd\xe9h3\x1a\x95\xebt9\xc9\xf3Z\x9a\x95\xa4\xe6\x93\x97\f\xe1Ur\x03 \xa2");
  utility::flag_wait(level.feedback_starts[index] + "n\xb6\xe0\n\xfaF\xa9t");
  utility::flag_clear("\xffm\xdd\xe9h3\x1a\x95\xebt9\xc9\xf3Z\x9a\x95\xa4\xe6\x93\x97\f\xe1Ur\x03 \xa2");
  feedback_check_end(start_name, index + 1);
}

function feedback_check_end(start_name, index) {
  if(utility::flag("\xffm\xdd\xe9h3\x1a\x95\xebt9\xc9\xf3Z\x9a\x95\xa4\xe6\x93\x97\f\xe1Ur\x03 \xa2")) {
    return;
  }

  if(!isDefined(level.feedback_starts[index])) {
    iprintlnbold("<dev string:xd4>");

    changelevel("", 0);
    level waittill(")\xb0\x16\xd5YF\xae");
  }

  if(level.feedback_starts[index] != start_name) {
    setDvar(@ "start", level.feedback_starts[index]);
    blackoverlay = hud_util::create_client_overlay("\x8a-\v\xa1\xbd", 0);
    blackoverlay fadeovertime(0.5);
    blackoverlay.alpha = 1;
    wait 0.65;
    setDvar(@ "hash_b9725e2c8d3c3df7", 1);
    map_restart();
    level waittill(")\xb0\x16\xd5YF\xae");
  }
}

function feedback_increase_index() {
  index = getdvarint(@ "feedback_index");
  index++;
  setDvar(@ "feedback_index", index);
}

function check_feedback_starts_existance(feedbackstarts) {
  level waittill("\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca");
  startnamearray = [];

  foreach(startstruct in level.start_arrays) {
    startnamearray[startnamearray.size] = startstruct["\xf4\x1f\x13\xee"];
  }

  foreach(start in feedbackstarts) {
    assert(arraycontains(startnamearray, start), "<dev string:xe7>" + start + "<dev string:xfc>");
  }
}

function add_start_construct(msg, func, optional_func, transient, catchup_function) {
  array = [];
  array["\xf4\x1f\x13\xee"] = msg;
  array["}\xdc\xb4\xce\xe1\x0e>y(\xea"] = func;
  array["K\x1bpQ'w\xeb\x8f>\xcf"] = optional_func;
  array["\xd8\xf4\xc7\x8f2\xdbV\x05\f"] = transient;
  array["c\xddez\xb2\xad\xbd\x93\xf6\xf1h\x1a&\x90\x88\xc6"] = catchup_function;
  return array;
}

function add_start_assert() {
  assert(!isDefined(level.script), "<dev string:x11f>");

  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }
}

function level_has_start_points() {
  return level.start_functions.size > 1;
}

function is_no_game_start() {
  if(isDefined(level.start_point)) {
    return issubstr(level.start_point, "@w^' \xdaR");
  }

  return getDvar(@ "start") == "@w^' \xdaR";
}

function jumpstartpoints() {
  if(level.start_arrays.size <= 1) {
    return;
  }

  var_38160d21ea060310 = getdvarint(@ "hash_12b44c14670814c", 15);

  for(;;) {
    wait var_38160d21ea060310;
    spotindex = randomintrange(0, level.start_arrays.size);

    foreach(startstruct in level.start_arrays) {
      if(spotindex == 0) {
        setDvar(@ "start", startstruct["<dev string:x149>"]);
        break;
      }

      spotindex--;
    }

    map_restart();
  }
}

function event_handler[testautomation] main() {}

function function_b36af97449f31e95() {
  return 1;
}

function function_91cbb9df3b2b4d67() {
  result = 0;
  waitframe();

  if(!level_has_start_points()) {
    return result;
  }

  wait 5;
  startpointactive = tolower(getDvar(@ "start", "<dev string:x24>"));

  if(getsubstr(startpointactive, 0, 3) == "<dev string:x151>") {
    startpointactive = level.start_functions[0]["<dev string:x149>"];
  }

  var_62520979323566d5 = undefined;

  foreach(startfunc in level.start_functions) {
    if(!isDefined(startfunc["<dev string:x149>"])) {
      continue;
    }

    startname = tolower(startfunc["<dev string:x149>"]);

    if(startname == "<dev string:x158>") {
      continue;
    }

    if(startpointactive == "<dev string:x24>" || startname == startpointactive) {
      var_62520979323566d5 = index + 1;
      break;
    }
  }

  if(isDefined(level.start_functions[var_62520979323566d5]) && isDefined(var_62520979323566d5) && isDefined(level.start_functions[var_62520979323566d5]["<dev string:x149>"]) && level.start_functions[var_62520979323566d5]["<dev string:x149>"] != "<dev string:x24>") {
    setDvar(@ "start", level.start_functions[var_62520979323566d5]["<dev string:x149>"]);
    map_restart();
    self waittill("<dev string:x163>");
  }

  return result;
}

# /