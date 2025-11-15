/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\starts.gsc
*********************************/

func_9766() {
  scripts\engine\utility::flag_init("start_is_set");
  setdvarifuninitialized("feedback", 0);
  scripts\sp\utility::func_1749("no_game", ::func_10CBC);
  func_171D();
}

func_57C6() {
  thread func_8960();
  func_57A1();
}

func_171D() {
  var_00 = getEntArray("script_origin_start_nogame", "classname");
  if(!var_00.size) {
    return;
  }

  foreach(var_02 in var_00) {
    if(!isDefined(var_02.script_startname)) {
      continue;
    }

    scripts\sp\utility::func_1749("no_game_" + var_02.script_startname, ::func_10CBC);
  }
}

func_57A1() {
  if(!func_9C4B()) {
    return;
  }

  setsaveddvar("ufoHitsTriggers", "1");
  if(isDefined(level.var_4C63)) {
    level[[level.var_4C63]]();
  }

  scripts\sp\loadout::func_12867();
  lib_0A2F::func_96FD();
  scripts\sp\audio::init_audio();
  scripts\sp\global_fx::main();
  func_57A2();
  scripts\engine\utility::array_call(getEntArray("truckjunk", "targetname"), ::delete);
  scripts\engine\utility::array_call(getEntArray("truckjunk", "script_noteworthy"), ::delete);
  level waittill("eternity");
}

func_57A2() {
  var_00 = getEntArray("script_origin_start_nogame", "classname");
  if(!var_00.size) {
    return;
  }

  var_00 = sortbydistance(var_00, level.player.origin);
  if(level.var_10CDA == "no_game") {
    level.player scripts\sp\utility::func_11633(var_00[0]);
    return;
  }

  var_01 = getsubstr(level.var_10CDA, 8);
  var_02 = 0;
  foreach(var_04 in var_00) {
    if(!isDefined(var_04.script_startname)) {
      continue;
    }

    if(var_01 != var_04.script_startname) {
      continue;
    }

    if(isDefined(var_04.physics_raycast)) {
      visionsetnaked(var_04.physics_raycast, 0);
    }

    level.player scripts\sp\utility::func_11633(var_04);
    var_02 = 1;
    break;
  }

  if(!var_02) {
    level.player scripts\sp\utility::func_11633(var_00[0]);
  }
}

func_10CBC() {
  scripts\engine\utility::array_call(getaiarray(), ::delete);
  scripts\engine\utility::array_call(getspawnerarray(), ::delete);
  var_00 = [];
  var_00["trigger_multiple_createart_transient"] = ::scripts\sp\trigger::func_1272E;
  foreach(var_04, var_02 in var_00) {
    var_03 = getEntArray(var_04, "classname");
    scripts\engine\utility::array_levelthread(var_03, var_02);
  }
}

func_10CAD() {}

func_7CA2() {
  var_00 = [];
  for(var_01 = 0; var_01 < level.var_10C58.size; var_01++) {
    var_00[var_00.size] = level.var_10C58[var_01]["name"];
  }

  return var_00;
}

func_56CC() {
  if(level.var_10C58.size <= 0) {
    return;
  }

  var_00 = func_7CA2();
  var_00[var_00.size] = "default";
  var_00[var_00.size] = "cancel";
  var_01 = func_10C9D();
  var_02 = func_4959("Selected Start:", -1);
  var_02.color = (1, 1, 1);
  var_03 = [];
  for(var_04 = 0; var_04 < var_00.size; var_04++) {
    var_05 = var_00[var_04];
    var_06 = "[" + var_00[var_04] + "]";
    if(var_05 != "cancel" && var_05 != "default") {
      if(isDefined(level.var_10BA8[var_05]["start_loc_string"])) {
        var_06 = var_06 + " -> ";
        var_06 = var_06 + level.var_10BA8[var_05]["start_loc_string"];
      }
    }

    var_03[var_03.size] = var_06;
  }

  var_07 = var_00.size - 1;
  var_08 = 0;
  var_09 = 0;
  var_0A = 0;
  while(var_07 > 0) {
    if(var_00[var_07] == level.var_10CDA) {
      var_0A = 1;
      break;
    }

    var_07--;
  }

  if(!var_0A) {
    var_07 = var_00.size - 1;
  }

  func_10C9E(var_01, var_03, var_07);
  var_0B = var_07;
  for(;;) {
    if(var_0B != var_07) {
      func_10C9E(var_01, var_03, var_07);
      var_0B = var_07;
    }

    if(!var_08) {
      if(level.player buttonpressed("UPARROW") || level.player buttonpressed("DPAD_UP") || level.player buttonpressed("APAD_UP")) {
        var_08 = 1;
        var_07--;
      }
    } else if(!level.player buttonpressed("UPARROW") && !level.player buttonpressed("DPAD_UP") && !level.player buttonpressed("APAD_UP")) {
      var_08 = 0;
    }

    if(!var_09) {
      if(level.player buttonpressed("DOWNARROW") || level.player buttonpressed("DPAD_DOWN") || level.player buttonpressed("APAD_DOWN")) {
        var_09 = 1;
        var_07++;
      }
    } else if(!level.player buttonpressed("DOWNARROW") && !level.player buttonpressed("DPAD_DOWN") && !level.player buttonpressed("APAD_DOWN")) {
      var_09 = 0;
    }

    if(var_07 < 0) {
      var_07 = var_00.size - 1;
    }

    if(var_07 >= var_00.size) {
      var_07 = 0;
    }

    if(level.player buttonpressed("BUTTON_B")) {
      func_10C18(var_01, var_02);
      break;
    }

    if(level.player buttonpressed("kp_enter") || level.player buttonpressed("BUTTON_A") || level.player buttonpressed("enter")) {
      if(var_00[var_07] == "cancel") {
        func_10C18(var_01, var_02);
        break;
      }

      setdvar("start", var_00[var_07]);
      map_restart();
    }

    wait(0.05);
  }
}

func_10C9D() {
  var_00 = [];
  for(var_01 = 0; var_01 < 11; var_01++) {
    var_02 = func_4959("", var_01);
    var_00[var_00.size] = var_02;
  }

  return var_00;
}

func_10C9E(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = var_03 + param_02 - 5;
    if(isDefined(param_01[var_04])) {
      var_05 = param_01[var_04];
    } else {
      var_05 = "";
    }

    param_00[var_03] settext(var_05);
  }
}

func_10C18(param_00, param_01) {
  param_01 destroy();
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    param_00[var_02] destroy();
  }
}

func_10C9F() {
  var_00 = [];
  if(isloadingsavegame()) {
    var_00 = getsavegametransients();
  } else {
    if(level.var_10CDA != "default") {
      var_01 = level.var_10BA8[level.var_10CDA];
      if(isDefined(var_01["transient"])) {
        var_02 = var_01["transient"];
        if(isstring(var_02)) {
          var_00 = [var_02];
        } else if(isarray(var_02)) {
          var_00 = var_02;
        }
      }
    }

    foreach(var_04 in var_00) {
      if(!isspleveltransient(var_04)) {
        scripts\engine\utility::error("add_start() list has a non SP level transient in it: " + var_04);
      }
    }

    if(isDefined(level.var_D9E5["loaded_weapons"])) {
      foreach(var_07 in level.var_D9E5["loaded_weapons"]) {
        if(lib_0A2F::func_9B49(var_07)) {
          var_00[var_00.size] = "weapon_" + var_07 + "_tr";
          continue;
        }

        if(lib_0A2F::func_9B44(var_07)) {
          var_00[var_00.size] = var_07 + "_tr";
        }
      }
    }

    if(isDefined(level.var_D9E5["default_weapon_transients"])) {
      var_00 = scripts\engine\utility::array_combine(var_00, level.var_D9E5["default_weapon_transients"]);
    }
  }

  if(var_00.size > 0) {
    loadstartpointtransients(var_00);
    foreach(var_0A in var_00) {
      scripts\engine\utility::flag_set(var_0A + "_loaded");
    }

    level notify("new_transient_loaded");
    return;
  }

  clearstartpointtransients();
}

func_8960() {
  level.var_10D36 = spawnStruct();
  setdvarifuninitialized("start", "");
  if(getdvar("scr_generateClipModels") != "" && getdvar("scr_generateClipModels") != "0") {
    return;
  }

  if(!isDefined(level.var_10C58)) {
    level.var_10C58 = [];
  }

  var_00 = tolower(getdvar("start"));
  var_01 = func_7CA2();
  if(isDefined(level.var_10CDA)) {
    var_00 = level.var_10CDA;
  }

  if(getdvarint("feedback")) {
    var_00 = level.var_6BC2;
  }

  var_02 = 0;
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    if(var_00 == var_01[var_03]) {
      var_02 = var_03;
      level.var_10CDA = var_01[var_03];
      break;
    }
  }

  if(isDefined(level.var_501A) && !isDefined(level.var_10CDA)) {
    var_04 = level.player _meth_84C6("lastCompletedMission");
    if(isDefined(var_04)) {
      var_05 = strtok(var_04, "_");
      if(isDefined(var_04) && var_05.size > 0) {
        if(var_05[0] == "sa" || var_05[0] == "ja") {
          foreach(var_08, var_07 in var_01) {
            if(level.var_501A == var_07) {
              var_02 = var_08;
              level.var_10CDA = var_07;
              break;
            }
          }
        }
      }
    }
  }

  if(isDefined(level.var_5019) && !isDefined(level.var_10CDA)) {
    foreach(var_08, var_07 in var_01) {
      if(level.var_5019 == var_07) {
        var_02 = var_08;
        level.var_10CDA = var_07;
        break;
      }
    }
  }

  if(!isDefined(level.var_10CDA)) {
    if(isDefined(level.var_5018)) {
      level.var_10CDA = "default";
    } else if(func_ABDA()) {
      level.var_10CDA = level.var_10C58[0]["name"];
    } else {
      level.var_10CDA = "default";
    }
  }

  scripts\sp\loadout::func_12867();
  lib_0A2F::func_96FD();
  lib_0A2F::_meth_82FF();
  lib_0A2F::_meth_8315();
  func_10C9F();
  waittillframeend;
  scripts\engine\utility::flag_set("start_is_set");
  thread func_10CAD();
  var_0A = level.var_10BA8[level.var_10CDA];
  if(isDefined(var_0A) && isDefined(var_0A["start_in_jackal"])) {
    setomnvar("ui_active_hud", "jackal");
    setsaveddvar("spaceship_disableViewModelNotetracks", 1);
  } else {
    setomnvar("ui_active_hud", "infantry");
  }

  if(level.var_10CDA == "default") {
    if(isDefined(level.var_5018)) {
      level thread[[level.var_5018]]();
    }
  } else {
    var_0A = level.var_10BA8[level.var_10CDA];
    thread[[var_0A["start_func"]]]();
  }

  if(scripts\sp\utility::func_9BB5()) {
    var_0B = func_7CB8(var_01);
    setdvar("start", var_0B);
  }

  waittillframeend;
  if(isloadingsavegame()) {
    wait(0.1);
  }

  var_0C = [];
  if(!scripts\sp\utility::func_9BB5() && level.var_10CDA != "no_game") {
    var_0D = gettime();
    for(var_03 = 0; var_03 < level.var_10C58.size; var_03++) {
      var_0A = level.var_10C58[var_03];
      if(var_0A["name"] == level.var_10CDA) {
        break;
      }

      if(!isDefined(var_0A["catchup_function"])) {
        continue;
      }

      [
        [var_0A["catchup_function"]]
      ]();
    }
  }

  for(var_03 = var_02; var_03 < level.var_10C58.size; var_03++) {
    var_0A = level.var_10C58[var_03];
    if(!isDefined(var_0A["logic_func"])) {
      continue;
    }

    if(func_1D3E(var_0A["logic_func"], var_0C)) {
      continue;
    }

    if(getdvarint("feedback")) {
      func_6BBF(var_0A, var_03);
    }

    level.var_10D36[[var_0A["logic_func"]]]();
    var_0C[var_0C.size] = var_0A["logic_func"];
    if(getdvarint("feedback")) {
      func_6BC1();
    }
  }
}

func_1D3E(param_00, param_01) {
  foreach(var_03 in param_01) {
    if(var_03 == param_00) {
      return 1;
    }
  }

  return 0;
}

func_7CB8(param_00) {
  var_01 = " ** No starts have been set up for this map with scriptssputility::add_start().";
  if(param_00.size) {
    var_01 = " ** ";
    for(var_02 = param_00.size - 1; var_02 >= 0; var_02--) {
      var_01 = var_01 + param_00[var_02] + " ";
    }
  }

  setdvar("start", var_01);
  return var_01;
}

func_4959(param_00, param_01) {
  var_02 = 1;
  var_03 = (0.9, 0.9, 0.9);
  if(param_01 != -1) {
    var_04 = 5;
    if(param_01 != var_04) {
      var_02 = 1 - abs(var_04 - param_01) / var_04;
    } else {
      var_03 = (1, 1, 0);
    }
  }

  if(var_02 == 0) {
    var_02 = 0.05;
  }

  var_05 = newhudelem();
  var_05.alignx = "left";
  var_05.aligny = "middle";
  var_05.x = 80;
  var_05.y = 80 + param_01 * 18;
  var_05 settext(param_00);
  var_05.alpha = 0;
  var_05.foreground = 1;
  var_05.color = var_03;
  var_05.fontscale = 1.75;
  var_05 fadeovertime(0.5);
  var_05.alpha = var_02;
  return var_05;
}

func_9403(param_00) {
  var_01 = newhudelem();
  var_01.alignx = "left";
  var_01.aligny = "middle";
  var_01.x = 10;
  var_01.y = 400;
  var_01 settext(param_00);
  var_01.alpha = 0;
  var_01.fontscale = 3;
  wait(1);
  var_01 fadeovertime(1);
  var_01.alpha = 1;
  wait(5);
  var_01 fadeovertime(1);
  var_01.alpha = 0;
  wait(1);
  var_01 destroy();
}

func_7292() {
  level.var_72AD = 1;
}

func_9BE4() {
  if(!func_ABDA()) {
    return 1;
  }

  return level.var_10CDA == level.var_10C58[0]["name"];
}

func_9B52(param_00) {
  var_01 = 0;
  if(level.var_10CDA == param_00) {
    return 0;
  }

  for(var_02 = 0; var_02 < level.var_10C58.size; var_02++) {
    if(level.var_10C58[var_02]["name"] == param_00) {
      var_01 = 1;
      continue;
    }

    if(level.var_10C58[var_02]["name"] == level.var_10CDA) {
      return var_01;
    }
  }
}

func_48E4(param_00) {
  if(!getdvarint("feedback")) {
    return;
  }

  scripts\engine\utility::flag_init("feedback_waiting_on_endFunc");
  setdvarifuninitialized("feedback_index", 0);
  setdvarifuninitialized("setting_feedback_start", 0);
  if(!getdvarint("setting_feedback_start")) {
    setdvar("feedback_index", 0);
  }

  setdvar("setting_feedback_start", 0);
  var_01 = [];
  foreach(var_04, var_03 in param_00) {
    var_01[var_04] = tolower(var_03);
  }

  thread func_3D73(var_01);
  level.var_6BC3 = var_01;
  level.var_6BC2 = var_01[getdvarint("feedback_index")];
}

func_48E1(param_00, param_01) {
  if(!getdvarint("feedback")) {
    return;
  }

  param_00 = tolower(param_00);
  if(!isDefined(level.var_6BC0)) {
    level.var_6BC0 = [];
  }

  level.var_6BC0[param_00] = "^3" + param_01;
}

func_48E2(param_00, param_01, param_02) {
  if(!getdvarint("feedback")) {
    return;
  }

  param_00 = tolower(param_00);
  scripts\engine\utility::flag_init(param_00 + "_endFunc");
  thread func_48E3(param_00, param_01, param_02);
}

func_56B5(param_00) {
  if(!isDefined(level.var_6BC0)) {
    return;
  }

  if(!isDefined(level.var_6BC0[param_00])) {
    return;
  }

  scripts\engine\utility::waitframe();
}

func_48E3(param_00, param_01, param_02) {
  level waittill("load_finished");
  if(isDefined(param_02)) {
    [[param_01]](param_02);
  } else {
    [[param_01]]();
  }

  scripts\engine\utility::flag_set(param_00 + "_endFunc");
}

func_6BBF(param_00, param_01) {
  if(!isDefined(level.var_6BC3)) {
    return;
  }

  var_02 = param_00["name"];
  var_03 = getdvarint("feedback_index");
  thread func_6BBE(var_02, var_03);
  func_6BBD(var_02, var_03);
  func_56B5(var_02);
}

func_6BBE(param_00, param_01) {
  if(!isDefined(level.var_6BC3[param_01])) {
    return;
  }

  if(!scripts\engine\utility::flag_exist(level.var_6BC3[param_01] + "_endFunc")) {
    return;
  }

  scripts\engine\utility::flag_set("feedback_waiting_on_endFunc");
  scripts\engine\utility::flag_wait(level.var_6BC3[param_01] + "_endFunc");
  scripts\engine\utility::flag_clear("feedback_waiting_on_endFunc");
  func_6BBD(param_00, param_01 + 1);
}

func_6BBD(param_00, param_01) {
  if(scripts\engine\utility::flag("feedback_waiting_on_endFunc")) {
    return;
  }

  if(!isDefined(level.var_6BC3[param_01])) {
    changelevel("", 0);
    level waittill("forever");
  }

  if(level.var_6BC3[param_01] != param_00) {
    setdvar("start", level.var_6BC3[param_01]);
    var_02 = scripts\sp\hud_util::func_48B7("black", 0);
    var_02 fadeovertime(0.5);
    var_02.alpha = 1;
    wait(0.65);
    setdvar("setting_feedback_start", 1);
    map_restart();
    level waittill("forever");
  }
}

func_6BC1() {
  var_00 = getdvarint("feedback_index");
  var_00++;
  setdvar("feedback_index", var_00);
}

func_3D73(param_00) {
  level waittill("load_finished");
  var_01 = [];
  foreach(var_03 in level.var_10BA8) {
    var_01[var_01.size] = var_03["name"];
  }

  foreach(var_06 in param_00) {}
}

func_174B(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = [];
  var_07["name"] = param_00;
  var_07["start_func"] = param_01;
  var_07["start_loc_string"] = param_02;
  var_07["logic_func"] = param_03;
  var_07["transient"] = param_04;
  var_07["catchup_function"] = param_05;
  var_07["start_in_jackal"] = param_06;
  return var_07;
}

func_174A() {
  if(!isDefined(level.var_10C58)) {
    level.var_10C58 = [];
  }
}

func_ABDA() {
  return level.var_10C58.size > 1;
}

func_9C4B() {
  if(isDefined(level.var_10CDA)) {
    return issubstr(level.var_10CDA, "no_game");
  }

  return getdvar("start") == "no_game";
}