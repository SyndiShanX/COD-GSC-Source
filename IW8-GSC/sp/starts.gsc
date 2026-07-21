/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\starts.gsc
***********************************************/

init_starts() {
  scripts\engine\utility::flag_init("start_is_set");
  setdvarifuninitialized("feedback", 0);
  scripts\engine\sp\utility::add_start("no_game", ::start_nogame);
  add_no_game_starts();
}

do_starts() {
  thread handle_starts();
  do_no_game_start();
}

add_no_game_starts() {
  var_0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var_0.size) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_startname)) {
      continue;
    }
    scripts\engine\sp\utility::add_start("no_game_" + var_2.script_startname, ::start_nogame);
  }
}

do_no_game_start() {
  if(!is_no_game_start()) {
    return;
  }
  setsaveddvar("NRTOOSORMS", "1");

  if(isDefined(level.custom_no_game_setupfunc))
    level[[level.custom_no_game_setupfunc]]();

  scripts\sp\audio::init_audio();
  scripts\sp\global_fx::main();
  do_no_game_start_teleport();
  scripts\engine\utility::array_call(getEntArray("truckjunk", "targetname"), ::delete);
  scripts\engine\utility::array_call(getEntArray("truckjunk", "script_noteworthy"), ::delete);
  level waittill("eternity");
}

do_no_game_start_teleport() {
  var_0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var_0.size) {
    return;
  }
  var_0 = sortbydistance(var_0, level.player.origin);

  if(level.start_point == "no_game") {
    level.player scripts\engine\sp\utility::teleport_player(var_0[0]);
    return;
  }

  var_1 = getsubstr(level.start_point, 8);
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.script_startname)) {
      continue;
    }
    if(var_1 != var_4.script_startname) {
      continue;
    }
    if(isDefined(var_4.script_visionset))
      visionsetnaked(var_4.script_visionset, 0);

    level.player scripts\engine\sp\utility::teleport_player(var_4);
    var_2 = 1;
    break;
  }

  if(!var_2)
    level.player scripts\engine\sp\utility::teleport_player(var_0[0]);
}

start_nogame() {
  if(getdvarint("scr_debug_spawnAIMode") > 0) {
    var_0 = getspawnerarray();

    foreach(var_2 in var_0) {
      var_2.target = undefined;
      var_2.targetname = undefined;
    }
  } else
    scripts\engine\utility::array_call(getspawnerarray(), ::delete);

  scripts\engine\utility::array_call(getaiarray(), ::delete);
  var_4 = [];
  var_4["trigger_multiple_createart_transient"] = scripts\sp\trigger::trigger_createart_transient;

  foreach(var_8, var_6 in var_4) {
    var_7 = getEntArray(var_8, "classname");
    scripts\engine\utility::array_levelthread(var_7, var_6);
  }
}

start_menu() {}

get_start_dvars() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.start_functions.size; var_1++)
    var_0[var_0.size] = level.start_functions[var_1]["name"];

  return var_0;
}

display_starts() {
  if(level.start_functions.size <= 0) {
    return;
  }
  var_0 = get_start_dvars();
  var_0[var_0.size] = "default";
  var_0[var_0.size] = "cancel";
  level.player enableinvulnerability();
  level.player freezecontrols(1);
  var_1 = start_list_menu();
  var_2 = create_start("Selected Start:", -1);
  var_2.color = (1, 1, 1);
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];
    var_6 = "[" + var_0[var_4] + "]";

    if(var_5 != "cancel" && var_5 != "default") {
      if(isDefined(level.start_arrays[var_5]["start_loc_string"])) {
        var_6 = var_6 + " -> ";
        var_6 = var_6 + level.start_arrays[var_5]["start_loc_string"];
      }
    }

    var_3[var_3.size] = var_6;
  }

  var_7 = var_0.size - 1;
  var_8 = 0;
  var_9 = 0;

  for(var_10 = 0; var_7 > 0; var_7--) {
    if(var_0[var_7] == level.start_point) {
      var_10 = 1;
      break;
    }
  }

  if(!var_10)
    var_7 = var_0.size - 1;

  start_list_settext(var_1, var_3, var_7);
  var_11 = var_7;
  var_12 = 0;

  for(;;) {
    if(var_11 != var_7) {
      start_list_settext(var_1, var_3, var_7);
      var_11 = var_7;
    }

    if(gettime() - var_12 > 150) {
      var_8 = 0;
      var_9 = 0;
    }

    if(!var_8) {
      if(level.player buttonPressed("UPARROW") || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("APAD_UP")) {
        var_8 = 1;
        var_12 = gettime();
        var_7--;
      }
    } else if(!level.player buttonPressed("UPARROW") && !level.player buttonPressed("DPAD_UP") && !level.player buttonPressed("APAD_UP"))
      var_8 = 0;

    if(!var_9) {
      if(level.player buttonPressed("DOWNARROW") || level.player buttonPressed("DPAD_DOWN") || level.player buttonPressed("APAD_DOWN")) {
        var_9 = 1;
        var_12 = gettime();
        var_7++;
      }
    } else if(!level.player buttonPressed("DOWNARROW") && !level.player buttonPressed("DPAD_DOWN") && !level.player buttonPressed("APAD_DOWN"))
      var_9 = 0;

    if(var_7 < 0)
      var_7 = var_0.size - 1;

    if(var_7 >= var_0.size)
      var_7 = 0;

    if(level.player buttonPressed("BUTTON_B") || level.player buttonPressed("escape")) {
      start_display_cleanup(var_1, var_2);
      break;
    }

    if(level.player buttonPressed("kp_enter") || level.player buttonPressed("BUTTON_A") || level.player buttonPressed("enter")) {
      if(var_0[var_7] == "cancel") {
        start_display_cleanup(var_1, var_2);
        break;
      }

      setDvar("start", var_0[var_7]);
      map_restart();
    }

    wait 0.05;
  }

  level.player freezecontrols(0);
  level.player disableinvulnerability();
}

start_list_menu() {
  var_0 = [];

  for(var_1 = 0; var_1 < 11; var_1++) {
    var_2 = create_start("", var_1);
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

start_list_settext(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_3 + (var_2 - 5);

    if(isDefined(var_1[var_4]))
      var_5 = var_1[var_4];
    else
      var_5 = "";

    var_0[var_3] settext(var_5);
  }
}

start_display_cleanup(var_0, var_1) {
  var_1 destroy();

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] destroy();
}

start_load_transients() {
  var_0 = [];

  if(isloadingsavegame())
    var_0 = getsavegametransients();
  else {
    if(level.start_point != "default") {
      var_1 = level.start_arrays[level.start_point];

      if(isDefined(var_1["transient"])) {
        var_2 = var_1["transient"];

        if(isstring(var_2)) {
          if(var_2 == "none")
            var_0 = [];
          else {
            var_3 = makealtweapon();
            var_4 = "none";

            foreach(var_6 in var_3) {
              if(var_2 == var_6) {
                var_4 = var_2;
                break;
              }
            }

            if(var_4 == "none")
              var_0 = [var_2];
            else
              var_0 = gettransientsetnames(var_4);
          }
        } else if(isarray(var_2))
          var_0 = var_2;
      }
    }

    foreach(var_9 in var_0) {
      if(!isspleveltransient(var_9))
        scripts\engine\utility::error("add_start() list has a non SP level transient in it: " + var_9);
    }
  }

  if(var_0.size > 0) {
    loadstartpointtransients(var_0);

    foreach(var_12 in var_0)
    scripts\engine\utility::flag_set(var_12 + "_loaded");

    level notify("new_transient_loaded");
  } else
    clearstartpointtransients();
}

handle_starts() {
  level.start_struct = spawnStruct();
  setdvarifuninitialized("start", "");

  if(getDvar("scr_generateClipModels") != "" && getDvar("scr_generateClipModels") != "0") {
    return;
  }
  if(!isDefined(level.start_functions))
    level.start_functions = [];

  var_0 = tolower(getDvar("start"));
  var_1 = get_start_dvars();

  if(isDefined(level.start_point))
    var_0 = level.start_point;

  if(getdvarint("feedback"))
    var_0 = level.feedback_start_point;

  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_0 == var_1[var_3]) {
      var_2 = var_3;
      level.start_point = var_1[var_3];
      break;
    }
  }

  if(isDefined(level.default_start_override_alt) && !isDefined(level.start_point)) {
    var_4 = level.player getplayerprogression("lastCompletedMission");

    if(isDefined(var_4)) {
      var_5 = strtok(var_4, "_");

      if(isDefined(var_4) && var_5.size > 0) {
        if(var_5[0] == "sa" || var_5[0] == "ja") {
          foreach(var_8, var_7 in var_1) {
            if(level.default_start_override_alt == var_7) {
              var_2 = var_8;
              level.start_point = var_7;
              break;
            }
          }
        }
      }
    }
  }

  if(isDefined(level.default_start_override) && !isDefined(level.start_point)) {
    foreach(var_8, var_7 in var_1) {
      if(level.default_start_override == var_7) {
        var_2 = var_8;
        level.start_point = var_7;
        break;
      }
    }
  }

  if(!isDefined(level.start_point)) {
    if(isDefined(level.default_start))
      level.start_point = "default";
    else if(level_has_start_points())
      level.start_point = level.start_functions[0]["name"];
    else
      level.start_point = "default";
  }

  start_load_transients();
  waittillframeend;
  scripts\engine\utility::flag_set("start_is_set");
  thread start_menu();
  var_10 = level.start_arrays[level.start_point];

  if(isDefined(var_10) && isDefined(var_10["start_in_jackal"])) {
    setomnvar("ui_active_hud", "jackal");
    setsaveddvar("NKKRMOROTS", 1);
  } else
    setomnvar("ui_active_hud", "infantry");

  if(level.start_point == "default") {
    if(isDefined(level.default_start))
      level thread[[level.default_start]]();
  } else {
    var_10 = level.start_arrays[level.start_point];
    thread[[var_10["start_func"]]]();
  }

  if(scripts\engine\sp\utility::is_default_start()) {
    var_11 = get_string_for_starts(var_1);
    setDvar("start", var_11);
  }

  waittillframeend;

  if(isloadingsavegame())
    wait 0.1;

  var_12 = [];

  if(!scripts\engine\sp\utility::is_default_start() && level.start_point != "no_game") {
    var_13 = gettime();

    for(var_3 = 0; var_3 < level.start_functions.size; var_3++) {
      var_10 = level.start_functions[var_3];

      if(var_10["name"] == level.start_point) {
        break;
      }

      if(!isDefined(var_10["catchup_function"])) {
        continue;
      }
      [[var_10["catchup_function"]]]();
    }
  }

  for(var_3 = var_2; var_3 < level.start_functions.size; var_3++) {
    var_10 = level.start_functions[var_3];

    if(!isDefined(var_10["logic_func"])) {
      continue;
    }
    if(already_ran_function(var_10["logic_func"], var_12)) {
      continue;
    }
    if(getdvarint("feedback"))
      feedback_check_start(var_10, var_3);

    scripts\sp\analytics::start_point_setup();
    level.start_struct[[var_10["logic_func"]]]();
    scripts\sp\analytics::start_point_check(var_10["name"]);
    var_12[var_12.size] = var_10["logic_func"];

    if(getdvarint("feedback"))
      feedback_increase_index();
  }
}

already_ran_function(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      return 1;
  }

  return 0;
}

get_string_for_starts(var_0) {
  var_1 = " ** No starts have been set up for this map with scriptsenginesputility::add_start().";

  if(var_0.size) {
    var_1 = " ** ";

    for(var_2 = var_0.size - 1; var_2 >= 0; var_2--)
      var_1 = var_1 + var_0[var_2] + " ";
  }

  setDvar("start", var_1);
  return var_1;
}

create_start(var_0, var_1) {
  var_2 = 1;
  var_3 = (0.9, 0.9, 0.9);

  if(var_1 != -1) {
    var_4 = 5;

    if(var_1 != var_4)
      var_2 = 1 - abs(var_4 - var_1) / var_4;
    else
      var_3 = (1, 1, 0);
  }

  if(var_2 == 0)
    var_2 = 0.05;

  var_5 = newhudelem();
  var_5.alignx = "left";
  var_5.aligny = "middle";
  var_5.x = 80;
  var_5.y = 80 + var_1 * 18;
  var_5 settext(var_0);
  var_5.alpha = 0;
  var_5.foreground = 1;
  var_5.color = var_3;
  var_5.fontscale = 1.75;
  var_5 fadeovertime(0.5);
  var_5.alpha = var_2;
  return var_5;
}

indicate_start(var_0) {
  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 400;
  var_1 settext(var_0);
  var_1.alpha = 0;
  var_1.fontscale = 3;
  wait 1;
  var_1 fadeovertime(1);
  var_1.alpha = 1;
  wait 5;
  var_1 fadeovertime(1);
  var_1.alpha = 0;
  wait 1;
  var_1 destroy();
}

force_start_catchup() {
  level.forced_start_catchup = 1;
}

is_first_start() {
  if(!level_has_start_points())
    return 1;

  return level.start_point == level.start_functions[0]["name"];
}

is_after_start(var_0) {
  var_1 = 0;

  if(level.start_point == var_0)
    return 0;

  for(var_2 = 0; var_2 < level.start_functions.size; var_2++) {
    if(level.start_functions[var_2]["name"] == var_0) {
      var_1 = 1;
      continue;
    }

    if(level.start_functions[var_2]["name"] == level.start_point)
      return var_1;
  }
}

create_feedback_starts(var_0) {
  if(!getdvarint("feedback")) {
    return;
  }
  scripts\engine\utility::flag_init("feedback_waiting_on_endFunc");
  setdvarifuninitialized("feedback_index", 0);
  setdvarifuninitialized("setting_feedback_start", 0);

  if(!getdvarint("setting_feedback_start"))
    setDvar("feedback_index", 0);

  setDvar("setting_feedback_start", 0);
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_4] = tolower(var_3);

  thread check_feedback_starts_existance(var_1);
  level.feedback_starts = var_1;
  level.feedback_start_point = var_1[getdvarint("feedback_index")];
}

create_feedback_context(var_0, var_1) {
  if(!getdvarint("feedback")) {
    return;
  }
  var_0 = tolower(var_0);

  if(!isDefined(level.feedback_context))
    level.feedback_context = [];

  level.feedback_context[var_0] = "^3" + var_1;
}

create_feedback_endfunc(var_0, var_1, var_2) {
  if(!getdvarint("feedback")) {
    return;
  }
  var_0 = tolower(var_0);
  scripts\engine\utility::flag_init(var_0 + "_endFunc");
  thread create_feedback_endfunc_thread(var_0, var_1, var_2);
}

display_feedback_context(var_0) {
  if(!isDefined(level.feedback_context)) {
    return;
  }
  if(!isDefined(level.feedback_context[var_0])) {
    return;
  }
  waitframe();
}

create_feedback_endfunc_thread(var_0, var_1, var_2) {
  level waittill("load_finished");

  if(isDefined(var_2))
    [[var_1]](var_2);
  else
    [[var_1]]();

  scripts\engine\utility::flag_set(var_0 + "_endFunc");
}

feedback_check_start(var_0, var_1) {
  if(!isDefined(level.feedback_starts)) {
    return;
  }
  var_2 = var_0["name"];
  var_3 = getdvarint("feedback_index");
  thread feedback_check_endfunc(var_2, var_3);
  feedback_check_end(var_2, var_3);
  display_feedback_context(var_2);
}

feedback_check_endfunc(var_0, var_1) {
  if(!isDefined(level.feedback_starts[var_1])) {
    return;
  }
  if(!scripts\engine\utility::flag_exist(level.feedback_starts[var_1] + "_endFunc")) {
    return;
  }
  scripts\engine\utility::flag_set("feedback_waiting_on_endFunc");
  scripts\engine\utility::flag_wait(level.feedback_starts[var_1] + "_endFunc");
  scripts\engine\utility::flag_clear("feedback_waiting_on_endFunc");
  feedback_check_end(var_0, var_1 + 1);
}

feedback_check_end(var_0, var_1) {
  if(scripts\engine\utility::flag("feedback_waiting_on_endFunc")) {
    return;
  }
  if(!isDefined(level.feedback_starts[var_1])) {
    changelevel("", 0);
    level waittill("forever");
  }

  if(level.feedback_starts[var_1] != var_0) {
    setDvar("start", level.feedback_starts[var_1]);
    var_2 = scripts\sp\hud_util::create_client_overlay("black", 0);
    var_2 fadeovertime(0.5);
    var_2.alpha = 1;
    wait 0.65;
    setDvar("setting_feedback_start", 1);
    map_restart();
    level waittill("forever");
  }
}

feedback_increase_index() {
  var_0 = getdvarint("feedback_index");
  var_0++;
  setDvar("feedback_index", var_0);
}

check_feedback_starts_existance(var_0) {
  level waittill("load_finished");
  var_1 = [];

  foreach(var_3 in level.start_arrays)
  var_1[var_1.size] = var_3["name"];

  foreach(var_6 in var_0) {}
}

add_start_construct(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["name"] = var_0;
  var_6["start_func"] = var_1;
  var_6["start_loc_string"] = var_2;
  var_6["logic_func"] = var_3;
  var_6["transient"] = var_4;
  var_6["catchup_function"] = var_5;
  return var_6;
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