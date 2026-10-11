/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\starts.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\audio;
#using scripts\sp\hud_util;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#namespace starts;

function init_starts() {
  flag_init("start_is_set");
  setdvarifuninitialized(@ "feedback", 0);
  add_start("no_game", &start_nogame);
  add_no_game_starts();
}

function do_starts() {
  thread handle_starts();
  do_no_game_start();
}

function add_no_game_starts() {
  start_spots = getEntArray("script_origin_start_nogame", "classname");

  if(!start_spots.size) {
    return;
  }

  foreach(spot in start_spots) {
    if(!isDefined(spot.script_startname)) {
      continue;
    }

    add_start("no_game_" + spot.script_startname, &start_nogame);
  }
}

function do_no_game_start() {
  if(!is_no_game_start()) {
    return;
  }

  setsaveddvar(@ "hash_1cc4e4a2542af7f5", "1");

  if(isDefined(level.custom_no_game_setupfunc)) {
    level[[level.custom_no_game_setupfunc]]();
  }

  scripts\sp\audio::init_audio();
  do_no_game_start_teleport();
  array_call(getEntArray("truckjunk", "targetname"), &delete);
  array_call(getEntArray("truckjunk", "script_noteworthy"), &delete);
  level waittill("eternity");
}

function do_no_game_start_teleport() {
  start_spots = getEntArray("script_origin_start_nogame", "classname");

  if(!start_spots.size) {
    return;
  }

  start_spots = sortbydistance(start_spots, level.player.origin);

  if(level.start_point == "no_game") {
    level.player teleport_player(start_spots[0]);
    return;
  }

  var_23cc4fb96f8e24cc = getsubstr(level.start_point, 8);
  found_spot = 0;

  foreach(point in start_spots) {
    if(!isDefined(point.script_startname)) {
      continue;
    }

    if(var_23cc4fb96f8e24cc != point.script_startname) {
      continue;
    }

    if(isDefined(point.script_visionset)) {
      visionsetnaked(point.script_visionset, 0);
    }

    level.player teleport_player(point);
    found_spot = 1;
    break;
  }

  if(!found_spot) {
    level.player teleport_player(start_spots[0]);
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
    array_call(getspawnerarray(), &delete);
  }

  array_call(getaiarray(), &delete);
  trigger_classes = [];
  trigger_classes["trigger_multiple_createart_transient"] = &scripts\sp\trigger::trigger_createart_transient;

  foreach(function in trigger_classes) {
    triggers = getEntArray(classname, "classname");
    array_levelthread(triggers, function);
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
    dvars[dvars.size] = level.start_functions[i]["name"];
  }

  return dvars;
}

function display_starts() {
  if(level.start_functions.size <= 0) {
    return;
  }

  dvars = get_start_dvars();
  dvars[dvars.size] = "default";
  dvars[dvars.size] = "cancel";
  level.player enableinvulnerability();
  level.player freezecontrols(1);
  elems = start_list_menu();
  title = create_start("Selected Start:", -1);
  title.color = (1, 1, 1);
  strings = [];

  for(i = 0; i < dvars.size; i++) {
    dvar = dvars[i];
    start_string = "[" + dvars[i] + "]";
    strings[strings.size] = start_string;
  }

  selected = dvars.size - 1;
  up_pressed = 0;
  down_pressed = 0;
  var_23c24faf493b443a = 0;

  while(selected > 0) {
    if(dvars[selected] == level.start_point) {
      var_23c24faf493b443a = 1;
      break;
    }

    selected--;
  }

  if(!var_23c24faf493b443a) {
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
      if(level.player buttonPressed("UPARROW") || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("APAD_UP")) {
        up_pressed = 1;
        last_presstime = gettime();
        selected--;
      }
    } else if(!level.player buttonPressed("UPARROW") && !level.player buttonPressed("DPAD_UP") && !level.player buttonPressed("APAD_UP")) {
      up_pressed = 0;
    }

    if(!down_pressed) {
      if(level.player buttonPressed("DOWNARROW") || level.player buttonPressed("DPAD_DOWN") || level.player buttonPressed("APAD_DOWN")) {
        down_pressed = 1;
        last_presstime = gettime();
        selected++;
      }
    } else if(!level.player buttonPressed("DOWNARROW") && !level.player buttonPressed("DPAD_DOWN") && !level.player buttonPressed("APAD_DOWN")) {
      down_pressed = 0;
    }

    if(selected < 0) {
      selected = dvars.size - 1;
    }

    if(selected >= dvars.size) {
      selected = 0;
    }

    if(level.player buttonPressed("BUTTON_B") || level.player buttonPressed("escape")) {
      start_display_cleanup(elems, title);
      break;
    }

    if(level.player buttonPressed("kp_enter") || level.player buttonPressed("BUTTON_A") || level.player buttonPressed("enter")) {
      if(dvars[selected] == "cancel") {
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
  var_37a46a86c391ce84 = [];

  if(isloadingsavegame()) {
    var_37a46a86c391ce84 = getsavegametransients();
  } else {
    if(level.start_point != "default") {
      start_array = level.start_arrays[level.start_point];

      if(isDefined(start_array["transient"])) {
        var_f4322ce4ec225081 = start_array["transient"];

        if(isstring(var_f4322ce4ec225081)) {
          if(var_f4322ce4ec225081 == "none") {
            var_37a46a86c391ce84 = [];
          } else {
            set_names = gettransientsetnames();
            set_match = "none";

            foreach(name in set_names) {
              if(var_f4322ce4ec225081 == name) {
                set_match = var_f4322ce4ec225081;
                level.transient_sets[var_f4322ce4ec225081] = 1;
                break;
              }
            }

            if(set_match == "none") {
              var_37a46a86c391ce84 = [var_f4322ce4ec225081];
            } else {
              var_37a46a86c391ce84 = gettransientsinset(set_match);
            }
          }
        } else if(isarray(var_f4322ce4ec225081)) {
          var_37a46a86c391ce84 = var_f4322ce4ec225081;
        }
      }
    }

    foreach(entry in var_37a46a86c391ce84) {
      if(!isspleveltransient(entry)) {
        error("add_start() list has a non SP level transient in it: " + entry);
      }
    }
  }

  if(var_37a46a86c391ce84.size > 0) {
    loadstartpointtransients(var_37a46a86c391ce84);

    foreach(transient in var_37a46a86c391ce84) {
      flag_set(transient + "_loaded");
    }

    level notify("new_transient_loaded");
    return;
  }

  clearstartpointtransients();
}

function handle_starts() {
  level.start_struct = spawnStruct();
  setdvarifuninitialized(@ "start", "");

  if(getDvar(@ "hash_7f5c464e214c560c") != "" && getDvar(@ "hash_7f5c464e214c560c") != "0") {
    return;
  }

  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }

  assertex(getDvar(@ "jumpto") == "", "Use the START dvar instead of JUMPTO");
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
    previous_mission = level.player getplayerprogression("lastCompletedMission");

    if(isDefined(previous_mission)) {
      tok = strtok(previous_mission, "_");

      if(isDefined(previous_mission) && tok.size > 0) {
        if(tok[0] == "sa" || tok[0] == "ja") {
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
      level.start_point = "default";
    } else if(level_has_start_points()) {
      level.start_point = level.start_functions[0]["name"];
    } else {
      level.start_point = "default";
    }
  }

  start_load_transients();
  waittillframeend();
  flag_set("start_is_set");
  thread start_menu();
  start_array = level.start_arrays[level.start_point];

  if(isDefined(start_array) && isDefined(start_array["start_in_jackal"])) {
    setomnvar("ui_active_hud", "jackal");
    setsaveddvar(@ "hash_e5e11740f51a39d5", 1);
  } else {
    setomnvar("ui_active_hud", "infantry");
  }

  if(level.start_point == "default") {
    if(isDefined(level.default_start)) {
      level thread[[level.default_start]]();
    }
  } else {
    start_array = level.start_arrays[level.start_point];

    thread indicate_start(level.start_point);

    function_d6004361b7a233e4();
    thread[[start_array["start_func"]]]();
  }

  if(is_default_start() || getdvarint(@ "fpstool_run")) {
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

  previously_run_logic_functions = [];

  if(!is_default_start() && level.start_point != "no_game") {
    time = gettime();

    for(i = 0; i < level.start_functions.size; i++) {
      start_array = level.start_functions[i];

      if(start_array["name"] == level.start_point) {
        break;
      }

      if(!isDefined(start_array["catchup_function"])) {
        continue;
      }

      [[start_array["catchup_function"]]]();
    }

    assertex(time == gettime(), "time should not pass in the catchup functions.");
  }

  if(getdvarint(@ "hash_e2f3b4fcea6c0ac6", 0) == 1) {
    thread jumpstartpoints();
  }

  for(i = start_index; i < level.start_functions.size; i++) {
    start_array = level.start_functions[i];

    if(!isDefined(start_array["logic_func"])) {
      continue;
    }

    if(already_ran_function(start_array["logic_func"], previously_run_logic_functions)) {
      continue;
    }

    if(getdvarint(@ "feedback")) {
      feedback_check_start(start_array, i);
    }

    if(getdvarint(@ "fpstool_run") || getdvarint(@ "prof_gameplaygfx")) {
      setDvar(@ "hash_46467383874e22fd", start_array["name"]);
    }

    scripts\sp\analytics::start_point_setup();
    level notify("start_logic", start_array["name"]);
    level.start_struct[[start_array["logic_func"]]]();
    scripts\sp\analytics::start_point_check(start_array["name"]);
    previously_run_logic_functions[previously_run_logic_functions.size] = start_array["logic_func"];

    if(getdvarint(@ "feedback")) {
      feedback_increase_index();
    }
  }
}

function already_ran_function(func, previously_run_logic_functions) {
  foreach(logic_function in previously_run_logic_functions) {
    if(logic_function == func) {
      return true;
    }
  }

  return false;
}

function get_string_for_starts(dvars) {
  string = " ** No starts have been set up for this map with scriptsenginesputility::add_start().";

  if(dvars.size) {
    string = " ** ";

    for(i = dvars.size - 1; i >= 0; i--) {
      string = string + dvars[i] + " ";
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
  hudelem.alignx = "left";
  hudelem.aligny = "middle";
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
  if(istrue(level.var_4c9c84f746d64381)) {
    return;
  }

  if(getdvarint(@ "loc_warningsaserrors")) {
    return;
  }

  hudelem = newhudelem();
  hudelem.alignx = "left";
  hudelem.aligny = "middle";
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

function force_start_catchup() {
  level.forced_start_catchup = 1;
}

function is_first_start() {
  if(!level_has_start_points()) {
    return true;
  }

  return level.start_point == level.start_functions[0]["name"];
}

function is_after_start(name) {
  var_81878d29f5a714f3 = 0;
  name = tolower(name);

  if(level.start_point == name) {
    return 0;
  }

  for(i = 0; i < level.start_functions.size; i++) {
    if(level.start_functions[i]["name"] == name) {
      var_81878d29f5a714f3 = 1;
      continue;
    }

    if(level.start_functions[i]["name"] == level.start_point) {
      return var_81878d29f5a714f3;
    }
  }
}

function create_feedback_starts(sarray) {
  if(!getdvarint(@ "feedback")) {
    return;
  }

  flag_init("feedback_waiting_on_endFunc");
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

  level.feedback_context[start_name] = "^3" + context;
}

function create_feedback_endfunc(start_name, end_func, param) {
  if(!getdvarint(@ "feedback")) {
    return;
  }

  start_name = tolower(start_name);
  flag_init(start_name + "_endFunc");
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
  level waittill("load_finished");

  if(isDefined(param)) {
    [[end_func]](param);
  } else {
    [[end_func]]();
  }

  flag_set(start_name + "_endFunc");
}

function feedback_check_start(start_array, start_index) {
  if(!isDefined(level.feedback_starts)) {
    return;
  }

  start_name = start_array["name"];
  index = getdvarint(@ "feedback_index");
  thread feedback_check_endfunc(start_name, index);
  feedback_check_end(start_name, index);
  display_feedback_context(start_name);
}

function feedback_check_endfunc(start_name, index) {
  if(!isDefined(level.feedback_starts[index])) {
    return;
  }

  if(!flag_exist(level.feedback_starts[index] + "_endFunc")) {
    return;
  }

  flag_set("feedback_waiting_on_endFunc");
  flag_wait(level.feedback_starts[index] + "_endFunc");
  flag_clear("feedback_waiting_on_endFunc");
  feedback_check_end(start_name, index + 1);
}

function feedback_check_end(start_name, index) {
  if(flag("feedback_waiting_on_endFunc")) {
    return;
  }

  if(!isDefined(level.feedback_starts[index])) {
    iprintlnbold("<dev string:x1c>");

    changelevel("", 0);
    level waittill("forever");
  }

  if(level.feedback_starts[index] != start_name) {
    setDvar(@ "start", level.feedback_starts[index]);
    blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
    blackoverlay fadeovertime(0.5);
    blackoverlay.alpha = 1;
    wait 0.65;
    setDvar(@ "hash_b9725e2c8d3c3df7", 1);
    map_restart();
    level waittill("forever");
  }
}

function feedback_increase_index() {
  index = getdvarint(@ "feedback_index");
  index++;
  setDvar(@ "feedback_index", index);
}

function check_feedback_starts_existance(feedbackstarts) {
  level waittill("load_finished");
  startnamearray = [];

  foreach(startstruct in level.start_arrays) {
    startnamearray[startnamearray.size] = startstruct["name"];
  }

  foreach(start in feedbackstarts) {
    assertex(array_contains(startnamearray, start), "FEEDBACK START : " + start + " DOES NOT EXIST IN LEVEL STARTS");
  }
}

function add_start_construct(msg, func, optional_func, transient, catchup_function) {
  array = [];
  array["name"] = msg;
  array["start_func"] = func;
  array["logic_func"] = optional_func;
  array["transient"] = transient;
  array["catchup_function"] = catchup_function;
  return array;
}

function add_start_assert() {
  assertex(!isDefined(level.script), "Can't create starts after load::main()");

  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }
}

function level_has_start_points() {
  return level.start_functions.size > 1;
}

function is_no_game_start() {
  if(isDefined(level.start_point)) {
    return issubstr(level.start_point, "no_game");
  }

  return getDvar(@ "start") == "no_game";
}

function jumpstartpoints() {
  if(level.start_arrays.size <= 1) {
    return;
  }

  var_5047e6f735ee65b1 = getdvarint(@ "hash_12b44c14670814c", 15);

  for(;;) {
    wait var_5047e6f735ee65b1;
    spotindex = randomintrange(0, level.start_arrays.size);

    foreach(startstruct in level.start_arrays) {
      if(spotindex == 0) {
        setDvar(@ "start", startstruct["<dev string:x2c>"]);
        break;
      }

      spotindex--;
    }

    map_restart();
  }
}

# /