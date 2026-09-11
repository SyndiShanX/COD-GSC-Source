/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\starts.gsc
***********************************************/

function init_starts() {
  scripts\engine\utility::flag_init("start_is_set");
  setdvarifuninitialized("feedback", 0);
  scripts\engine\sp\utility::add_start("no_game", &start_nogame);
  add_no_game_starts();
}

function do_starts() {
  thread handle_starts();
  do_no_game_start();
}

function add_no_game_starts() {
  var0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var0.size) {
    return;
  }

  foreach(var2 in var0) {
    if(!isDefined(var2.script_startname)) {
      continue;
    }

    scripts\engine\sp\utility::add_start("no_game_" + var2.script_startname, &start_nogame);
  }
}

function do_no_game_start() {
  if(!is_no_game_start()) {
    return;
  }

  setsaveddvar("NRTOOSORMS", "1");

  if(isDefined(level.custom_no_game_setupfunc)) {
    level[[level.custom_no_game_setupfunc]]();
  }

  scripts\sp\audio::init_audio();
  scripts\sp\global_fx::main();
  do_no_game_start_teleport();
  scripts\engine\utility::array_call(getEntArray("truckjunk", "targetname"), &delete);
  scripts\engine\utility::array_call(getEntArray("truckjunk", "script_noteworthy"), &delete);
  level waittill("eternity");
}

function do_no_game_start_teleport() {
  var0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var0.size) {
    return;
  }

  var0 = sortbydistance(var0, level.player.origin);

  if(level.start_point == "no_game") {
    level.player scripts\engine\sp\utility::teleport_player(var0[0]);
    return;
  }

  var1 = getsubstr(level.start_point, 8);
  var2 = 0;

  foreach(var4 in var0) {
    if(!isDefined(var4.script_startname)) {
      continue;
    }

    if(var1 != var4.script_startname) {
      continue;
    }

    if(isDefined(var4.script_visionset)) {
      visionsetnaked(var4.script_visionset, 0);
    }

    level.player scripts\engine\sp\utility::teleport_player(var4);
    var2 = 1;
    break;
  }

  if(!var2) {
    level.player scripts\engine\sp\utility::teleport_player(var0[0]);
    return;
  }
}

function start_nogame() {
  if(getdvarint("scr_debug_spawnAIMode") > 0) {
    var0 = getspawnerarray();

    foreach(var2 in var0) {
      var2.target = undefined;
      var2.targetname = undefined;
    }
  } else {
    scripts\engine\utility::array_call(getspawnerarray(), &delete);
  }

  scripts\engine\utility::array_call(getaiarray(), &delete);
  var4 = [];
  GscBinSkip0(0x2e, "trigger_multiple_createart_transient", &scripts\sp\trigger::trigger_createart_transient);
}

function start_menu() {}

function get_start_dvars() {
  var0 = [];

  for(var1 = 0; var1 < level.start_functions.size; var1++) {
    var0 = level.start_functions[var1]["name"];
  }

  return var0;
}

function display_starts() {
  if(level.start_functions.size <= 0) {
    return;
  }

  var0 = get_start_dvars();
  GscBinSkip0(0x2e, var0.size, "default");
}

function start_list_menu() {
  var0 = [];

  for(var1 = 0; var1 < 11; var1++) {
    var2 = create_start("", var1);
    var0 = var2;
  }

  return var0;
}

function start_list_settext(var0, var1, var2) {
  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var3 + var2 - 5;

    if(isDefined(var1[var4])) {
      var5 = var1[var4];
    } else {
      var5 = "";
    }

    var0[var3] settext(var5);
  }
}

function start_display_cleanup(var0, var1) {
  var1 destroy();

  for(var2 = 0; var2 < var0.size; var2++) {
    var0[var2] destroy();
  }
}

function start_load_transients() {
  var0 = [];

  if(isloadingsavegame()) {
    var0 = getsavegametransients();
  } else {
    if(level.start_point != "default") {
      var1 = level.start_arrays[level.start_point];

      if(isDefined(var1["transient"])) {
        var2 = var1["transient"];

        if(isstring(var2)) {
          if(var2 == "none") {
            var0 = [];
          } else {
            var3 = makealtweapon();
            var4 = "none";

            foreach(var6 in var3) {
              if(var2 == var6) {
                var4 = var2;
                break;
              }
            }

            if(var4 == "none") {
              var0 = [var2];
            } else {
              var0 = gettransientsetnames(var4);
            }
          }
        } else if(isarray(var2)) {
          var0 = var2;
        }
      }
    }

    foreach(var9 in var0) {
      if(!isspleveltransient(var9)) {
        scripts\engine\utility::error("add_start() list has a non SP level transient in it: " + var9);
      }
    }
  }

  if(var0.size > 0) {
    loadstartpointtransients(var0);

    foreach(var12 in var0) {
      scripts\engine\utility::flag_set(var12 + "_loaded");
    }

    level notify("new_transient_loaded");
    return;
  }

  clearstartpointtransients();
}

function handle_starts() {
  level.start_struct = spawnStruct();
  setdvarifuninitialized("start", "");

  if(getDvar("scr_generateClipModels") != "" && getDvar("scr_generateClipModels") != "0") {
    return;
  }

  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }

  var0 = tolower(getDvar("start"));
  var1 = get_start_dvars();

  if(isDefined(level.start_point)) {
    var0 = level.start_point;
  }

  if(getdvarint("feedback")) {
    var0 = level.feedback_start_point;
  }

  var2 = 0;

  for(var3 = 0; var3 < var1.size; var3++) {
    if(var0 == var1[var3]) {
      var2 = var3;
      level.start_point = var1[var3];
      break;
    }
  }

  if(isDefined(level.default_start_override_alt) && !isDefined(level.start_point)) {
    var4 = level.player getplayerprogression("lastCompletedMission");

    if(isDefined(var4)) {
      var5 = strtok(var4, "_");

      if(isDefined(var4) && var5.size > 0) {
        if(var5[0] == "sa" || var5[0] == "ja") {
          foreach(var8, var7 in var1) {
            if(level.default_start_override_alt == var7) {
              var2 = var8;
              level.start_point = var7;
              break;
            }
          }
        }
      }
    }
  }

  if(isDefined(level.default_start_override) && !isDefined(level.start_point)) {
    foreach(var7 in var1) {
      if(level.default_start_override == var7) {
        var2 = var8;
        level.start_point = var7;
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
  scripts\engine\utility::flag_set("start_is_set");
  thread start_menu();
  var10 = level.start_arrays[level.start_point];

  if(isDefined(var10) && isDefined(var10["start_in_jackal"])) {
    setomnvar("ui_active_hud", "jackal");
    setsaveddvar("NKKRMOROTS", 1);
  } else {
    setomnvar("ui_active_hud", "infantry");
  }

  if(level.start_point == "default") {
    if(isDefined(level.default_start)) {
      level thread[[level.default_start]]();
    }
  } else {
    var10 = level.start_arrays[level.start_point];
    GscBinSkip1(0x74, var10["start_func"]);
  }

  if(scripts\engine\sp\utility::is_default_start()) {
    var11 = get_string_for_starts(var1);
    setDvar("start", var11);
  }

  waittillframeend();

  if(isloadingsavegame()) {
    wait 0.1;
  }

  var12 = [];

  if(!scripts\engine\sp\utility::is_default_start() && level.start_point != "no_game") {
    var13 = gettime();

    for(var3 = 0; var3 < level.start_functions.size; var3++) {
      var10 = level.start_functions[var3];

      if(var10["name"] == level.start_point) {
        break;
      }

      if(!isDefined(var10["catchup_function"])) {
        continue;
      }

      [[var10["catchup_function"]]]();
    }
  }

  for(var3 = var2; var3 < level.start_functions.size; var3++) {
    var10 = level.start_functions[var3];

    if(!isDefined(var10["logic_func"])) {
      continue;
    }

    if(already_ran_function(var10["logic_func"], var12)) {
      continue;
    }

    if(getdvarint("feedback")) {
      feedback_check_start(var10, var3);
    }

    scripts\sp\analytics::start_point_setup();
    level.start_struct[[var10["logic_func"]]]();
    scripts\sp\analytics::start_point_check(var10["name"]);
    GscBinSkip0(0x2e, var12.size, var10["logic_func"]);
  }
}

function already_ran_function(var0, var1) {
  foreach(var3 in var1) {
    if(var3 == var0) {
      return true;
    }
  }

  return false;
}

function get_string_for_starts(var0) {
  var1 = " ** No starts have been set up for this map with scriptsenginesputility::add_start().";

  if(var0.size) {
    var1 = " ** ";

    for(var2 = var0.size - 1; var2 >= 0; var2--) {
      var1 = var1 + var0[var2] + " ";
    }
  }

  setDvar("start", var1);
  return var1;
}

function create_start(var0, var1) {
  var2 = 1;
  var3 = (0.9, 0.9, 0.9);

  if(var1 != -1) {
    var4 = 5;

    if(var1 != var4) {
      var2 = 1 - abs(var4 - var1) / var4;
    } else {
      var3 = (1, 1, 0);
    }
  }

  if(var2 == 0) {
    var2 = 0.05;
  }

  var5 = newhudelem();
  var5.alignx = "left";
  var5.aligny = "middle";
  var5.x = 80;
  var5.y = 80 + var1 * 18;
  var5 settext(var0);
  var5.alpha = 0;
  var5.foreground = 1;
  var5.color = var3;
  var5.fontscale = 1.75;
  var5 fadeovertime(0.5);
  var5.alpha = var2;
  return var5;
}

function indicate_start(var0) {
  var1 = newhudelem();
  var1.alignx = "left";
  var1.aligny = "middle";
  var1.x = 10;
  var1.y = 400;
  var1 settext(var0);
  var1.alpha = 0;
  var1.fontscale = 3;
  wait 1;
  var1 fadeovertime(1);
  var1.alpha = 1;
  wait 5;
  var1 fadeovertime(1);
  var1.alpha = 0;
  wait 1;
  var1 destroy();
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

function is_after_start(var0) {
  var1 = 0;

  if(level.start_point == var0) {
    return 0;
  }

  for(var2 = 0; var2 < level.start_functions.size; var2++) {
    if(level.start_functions[var2]["name"] == var0) {
      var1 = 1;
      continue;
    }

    if(level.start_functions[var2]["name"] == level.start_point) {
      return var1;
    }
  }
}

function create_feedback_starts(var0) {
  if(!getdvarint("feedback")) {
    return;
  }

  scripts\engine\utility::flag_init("feedback_waiting_on_endFunc");
  setdvarifuninitialized("feedback_index", 0);
  setdvarifuninitialized("setting_feedback_start", 0);

  if(!getdvarint("setting_feedback_start")) {
    setDvar("feedback_index", 0);
  }

  setDvar("setting_feedback_start", 0);
  var1 = [];

  foreach(var3 in var0) {
    var1 = tolower(var3);
  }

  thread check_feedback_starts_existance(var1);
  level.feedback_starts = var1;
  level.feedback_start_point = var1[getdvarint("feedback_index")];
}

function create_feedback_context(var0, var1) {
  if(!getdvarint("feedback")) {
    return;
  }

  var0 = tolower(var0);

  if(!isDefined(level.feedback_context)) {
    level.feedback_context = [];
  }

  level.feedback_context[var0] = "^3" + var1;
}

function create_feedback_endfunc(var0, var1, var2) {
  if(!getdvarint("feedback")) {
    return;
  }

  var0 = tolower(var0);
  scripts\engine\utility::flag_init(var0 + "_endFunc");
  thread create_feedback_endfunc_thread(var0, var1, var2);
}

function display_feedback_context(var0) {
  if(!isDefined(level.feedback_context)) {
    return;
  }

  if(!isDefined(level.feedback_context[var0])) {
    return;
  }

  waitframe();
}

function create_feedback_endfunc_thread(var0, var1, var2) {
  level waittill("load_finished");

  if(isDefined(var2)) {
    [[var1]](var2);
  } else {
    [[var1]]();
  }

  scripts\engine\utility::flag_set(var0 + "_endFunc");
}

function feedback_check_start(var0, var1) {
  if(!isDefined(level.feedback_starts)) {
    return;
  }

  var2 = var0["name"];
  var3 = getdvarint("feedback_index");
  thread feedback_check_endfunc(var2, var3);
  feedback_check_end(var2, var3);
  display_feedback_context(var2);
}

function feedback_check_endfunc(var0, var1) {
  if(!isDefined(level.feedback_starts[var1])) {
    return;
  }

  if(!scripts\engine\utility::flag_exist(level.feedback_starts[var1] + "_endFunc")) {
    return;
  }

  scripts\engine\utility::flag_set("feedback_waiting_on_endFunc");
  scripts\engine\utility::flag_wait(level.feedback_starts[var1] + "_endFunc");
  scripts\engine\utility::flag_clear("feedback_waiting_on_endFunc");
  feedback_check_end(var0, var1 + 1);
}

function feedback_check_end(var0, var1) {
  if(scripts\engine\utility::flag("feedback_waiting_on_endFunc")) {
    return;
  }

  if(!isDefined(level.feedback_starts[var1])) {
    changelevel("", 0);
    level waittill("forever");
  }

  if(level.feedback_starts[var1] != var0) {
    setDvar("start", level.feedback_starts[var1]);
    var2 = scripts\sp\hud_util::create_client_overlay("black", 0);
    var2 fadeovertime(0.5);
    var2.alpha = 1;
    wait 0.65;
    setDvar("setting_feedback_start", 1);
    map_restart();
    level waittill("forever");
    return;
  }
}

function feedback_increase_index() {
  var0 = getdvarint("feedback_index");
  var0++;
  setDvar("feedback_index", var0);
}

function check_feedback_starts_existance(var0) {
  level waittill("load_finished");
  var1 = [];

  foreach(var3 in level.start_arrays) {
    var1 = var3["name"];
  }

  foreach(var6 in var0) {}
}

function add_start_construct(var0, var1, var2, var3, var4, var5) {
  var6 = [];
  GscBinSkip0(0x2e, "name", var0);
}

function add_start_assert() {
  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
    return;
  }
}

function level_has_start_points() {
  return level.start_functions.size > 1;
}

function is_no_game_start() {
  if(isDefined(level.start_point)) {
    return issubstr(level.start_point, "no_game");
  }

  return getDvar("start") == "no_game";
}