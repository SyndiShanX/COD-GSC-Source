/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\starts.gsc
*********************************************/

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
  var_0 = getEntArray("script_origin_start_nogame", "classname");
  if(!var_0.size) {
    return;
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_startname)) {
      continue;
    }

    scripts\sp\utility::func_1749("no_game_" + var_2.script_startname, ::func_10CBC);
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
  var_0 = getEntArray("script_origin_start_nogame", "classname");
  if(!var_0.size) {
    return;
  }

  var_0 = sortbydistance(var_0, level.player.origin);
  if(level.var_10CDA == "no_game") {
    level.player scripts\sp\utility::func_11633(var_0[0]);
    return;
  }

  var_1 = getsubstr(level.var_10CDA, 8);
  var_2 = 0;
  foreach(var_4 in var_0) {
    if(!isDefined(var_4.script_startname)) {
      continue;
    }

    if(var_1 != var_4.script_startname) {
      continue;
    }

    if(isDefined(var_4.physics_raycast)) {
      visionsetnaked(var_4.physics_raycast, 0);
    }

    level.player scripts\sp\utility::func_11633(var_4);
    var_2 = 1;
    break;
  }

  if(!var_2) {
    level.player scripts\sp\utility::func_11633(var_0[0]);
  }
}

func_10CBC() {
  scripts\engine\utility::array_call(getaiarray(), ::delete);
  scripts\engine\utility::array_call(getspawnerarray(), ::delete);
  var_0 = [];
  var_0["trigger_multiple_createart_transient"] = ::scripts\sp\trigger::func_1272E;
  foreach(var_4, var_2 in var_0) {
    var_3 = getEntArray(var_4, "classname");
    scripts\engine\utility::array_levelthread(var_3, var_2);
  }
}

func_10CAD() {}

func_7CA2() {
  var_0 = [];
  for(var_1 = 0; var_1 < level.var_10C58.size; var_1++) {
    var_0[var_0.size] = level.var_10C58[var_1]["name"];
  }

  return var_0;
}

func_56CC() {
  if(level.var_10C58.size <= 0) {
    return;
  }

  var_0 = func_7CA2();
  var_0[var_0.size] = "default";
  var_0[var_0.size] = "cancel";
  var_1 = func_10C9D();
  var_2 = func_4959("Selected Start:", -1);
  var_2.color = (1, 1, 1);
  var_3 = [];
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];
    var_6 = "[" + var_0[var_4] + "]";
    if(var_5 != "cancel" && var_5 != "default") {
      if(isDefined(level.var_10BA8[var_5]["start_loc_string"])) {
        var_6 = var_6 + " -> ";
        var_6 = var_6 + level.var_10BA8[var_5]["start_loc_string"];
      }
    }

    var_3[var_3.size] = var_6;
  }

  var_7 = var_0.size - 1;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  while(var_7 > 0) {
    if(var_0[var_7] == level.var_10CDA) {
      var_10 = 1;
      break;
    }

    var_7--;
  }

  if(!var_10) {
    var_7 = var_0.size - 1;
  }

  func_10C9E(var_1, var_3, var_7);
  var_11 = var_7;
  for(;;) {
    if(var_11 != var_7) {
      func_10C9E(var_1, var_3, var_7);
      var_11 = var_7;
    }

    if(!var_8) {
      if(level.player buttonPressed("UPARROW") || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("APAD_UP")) {
        var_8 = 1;
        var_7--;
      }
    } else if(!level.player buttonPressed("UPARROW") && !level.player buttonPressed("DPAD_UP") && !level.player buttonPressed("APAD_UP")) {
      var_8 = 0;
    }

    if(!var_9) {
      if(level.player buttonPressed("DOWNARROW") || level.player buttonPressed("DPAD_DOWN") || level.player buttonPressed("APAD_DOWN")) {
        var_9 = 1;
        var_7++;
      }
    } else if(!level.player buttonPressed("DOWNARROW") && !level.player buttonPressed("DPAD_DOWN") && !level.player buttonPressed("APAD_DOWN")) {
      var_9 = 0;
    }

    if(var_7 < 0) {
      var_7 = var_0.size - 1;
    }

    if(var_7 >= var_0.size) {
      var_7 = 0;
    }

    if(level.player buttonPressed("BUTTON_B")) {
      func_10C18(var_1, var_2);
      break;
    }

    if(level.player buttonPressed("kp_enter") || level.player buttonPressed("BUTTON_A") || level.player buttonPressed("enter")) {
      if(var_0[var_7] == "cancel") {
        func_10C18(var_1, var_2);
        break;
      }

      setDvar("start", var_0[var_7]);
      map_restart();
    }

    wait(0.05);
  }
}

func_10C9D() {
  var_0 = [];
  for(var_1 = 0; var_1 < 11; var_1++) {
    var_2 = func_4959("", var_1);
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

func_10C9E(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_3 + var_2 - 5;
    if(isDefined(var_1[var_4])) {
      var_5 = var_1[var_4];
    } else {
      var_5 = "";
    }

    var_0[var_3] settext(var_5);
  }
}

func_10C18(var_0, var_1) {
  var_1 destroy();
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] destroy();
  }
}

func_10C9F() {
  var_0 = [];
  if(isloadingsavegame()) {
    var_0 = getsavegametransients();
  } else {
    if(level.var_10CDA != "default") {
      var_1 = level.var_10BA8[level.var_10CDA];
      if(isDefined(var_1["transient"])) {
        var_2 = var_1["transient"];
        if(isstring(var_2)) {
          var_0 = [var_2];
        } else if(isarray(var_2)) {
          var_0 = var_2;
        }
      }
    }

    foreach(var_4 in var_0) {
      if(!isspleveltransient(var_4)) {
        scripts\engine\utility::error("add_start() list has a non SP level transient in it: " + var_4);
      }
    }

    if(isDefined(level.var_D9E5["loaded_weapons"])) {
      foreach(var_7 in level.var_D9E5["loaded_weapons"]) {
        if(lib_0A2F::func_9B49(var_7)) {
          var_0[var_0.size] = "weapon_" + var_7 + "_tr";
          continue;
        }

        if(lib_0A2F::func_9B44(var_7)) {
          var_0[var_0.size] = var_7 + "_tr";
        }
      }
    }

    if(isDefined(level.var_D9E5["default_weapon_transients"])) {
      var_0 = scripts\engine\utility::array_combine(var_0, level.var_D9E5["default_weapon_transients"]);
    }
  }

  if(var_0.size > 0) {
    loadstartpointtransients(var_0);
    foreach(var_10 in var_0) {
      scripts\engine\utility::flag_set(var_10 + "_loaded");
    }

    level notify("new_transient_loaded");
    return;
  }

  clearstartpointtransients();
}

func_8960() {
  level.var_10D36 = spawnStruct();
  setdvarifuninitialized("start", "");
  if(getDvar("scr_generateClipModels") != "" && getDvar("scr_generateClipModels") != "0") {
    return;
  }

  if(!isDefined(level.var_10C58)) {
    level.var_10C58 = [];
  }

  var_0 = tolower(getDvar("start"));
  var_1 = func_7CA2();
  if(isDefined(level.var_10CDA)) {
    var_0 = level.var_10CDA;
  }

  if(getdvarint("feedback")) {
    var_0 = level.var_6BC2;
  }

  var_2 = 0;
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_0 == var_1[var_3]) {
      var_2 = var_3;
      level.var_10CDA = var_1[var_3];
      break;
    }
  }

  if(isDefined(level.var_501A) && !isDefined(level.var_10CDA)) {
    var_4 = level.player func_84C6("lastCompletedMission");
    if(isDefined(var_4)) {
      var_5 = strtok(var_4, "_");
      if(isDefined(var_4) && var_5.size > 0) {
        if(var_5[0] == "sa" || var_5[0] == "ja") {
          foreach(var_8, var_7 in var_1) {
            if(level.var_501A == var_7) {
              var_2 = var_8;
              level.var_10CDA = var_7;
              break;
            }
          }
        }
      }
    }
  }

  if(isDefined(level.var_5019) && !isDefined(level.var_10CDA)) {
    foreach(var_8, var_7 in var_1) {
      if(level.var_5019 == var_7) {
        var_2 = var_8;
        level.var_10CDA = var_7;
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
  lib_0A2F::func_82FF();
  lib_0A2F::func_8315();
  func_10C9F();
  waittillframeend;
  scripts\engine\utility::flag_set("start_is_set");
  thread func_10CAD();
  var_10 = level.var_10BA8[level.var_10CDA];
  if(isDefined(var_10) && isDefined(var_10["start_in_jackal"])) {
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
    var_10 = level.var_10BA8[level.var_10CDA];
    thread[[var_10["start_func"]]]();
  }

  if(scripts\sp\utility::func_9BB5()) {
    var_11 = func_7CB8(var_1);
    setDvar("start", var_11);
  }

  waittillframeend;
  if(isloadingsavegame()) {
    wait(0.1);
  }

  var_12 = [];
  if(!scripts\sp\utility::func_9BB5() && level.var_10CDA != "no_game") {
    var_13 = gettime();
    for(var_3 = 0; var_3 < level.var_10C58.size; var_3++) {
      var_10 = level.var_10C58[var_3];
      if(var_10["name"] == level.var_10CDA) {
        break;
      }

      if(!isDefined(var_10["catchup_function"])) {
        continue;
      }

      [[var_10["catchup_function"]]]();
    }
  }

  for(var_3 = var_2; var_3 < level.var_10C58.size; var_3++) {
    var_10 = level.var_10C58[var_3];
    if(!isDefined(var_10["logic_func"])) {
      continue;
    }

    if(func_1D3E(var_10["logic_func"], var_12)) {
      continue;
    }

    if(getdvarint("feedback")) {
      func_6BBF(var_10, var_3);
    }

    level.var_10D36[[var_10["logic_func"]]]();
    var_12[var_12.size] = var_10["logic_func"];
    if(getdvarint("feedback")) {
      func_6BC1();
    }
  }
}

func_1D3E(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_7CB8(var_0) {
  var_1 = " ** No starts have been set up for this map with scriptssputility::add_start().";
  if(var_0.size) {
    var_1 = " ** ";
    for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
      var_1 = var_1 + var_0[var_2] + " ";
    }
  }

  setDvar("start", var_1);
  return var_1;
}

func_4959(var_0, var_1) {
  var_2 = 1;
  var_3 = (0.9, 0.9, 0.9);
  if(var_1 != -1) {
    var_4 = 5;
    if(var_1 != var_4) {
      var_2 = 1 - abs(var_4 - var_1) / var_4;
    } else {
      var_3 = (1, 1, 0);
    }
  }

  if(var_2 == 0) {
    var_2 = 0.05;
  }

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

func_9403(var_0) {
  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 400;
  var_1 settext(var_0);
  var_1.alpha = 0;
  var_1.fontscale = 3;
  wait(1);
  var_1 fadeovertime(1);
  var_1.alpha = 1;
  wait(5);
  var_1 fadeovertime(1);
  var_1.alpha = 0;
  wait(1);
  var_1 destroy();
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

func_9B52(var_0) {
  var_1 = 0;
  if(level.var_10CDA == var_0) {
    return 0;
  }

  for(var_2 = 0; var_2 < level.var_10C58.size; var_2++) {
    if(level.var_10C58[var_2]["name"] == var_0) {
      var_1 = 1;
      continue;
    }

    if(level.var_10C58[var_2]["name"] == level.var_10CDA) {
      return var_1;
    }
  }
}

func_48E4(var_0) {
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
  var_1 = [];
  foreach(var_4, var_3 in var_0) {
    var_1[var_4] = tolower(var_3);
  }

  thread func_3D73(var_1);
  level.var_6BC3 = var_1;
  level.var_6BC2 = var_1[getdvarint("feedback_index")];
}

func_48E1(var_0, var_1) {
  if(!getdvarint("feedback")) {
    return;
  }

  var_0 = tolower(var_0);
  if(!isDefined(level.var_6BC0)) {
    level.var_6BC0 = [];
  }

  level.var_6BC0[var_0] = "^3" + var_1;
}

func_48E2(var_0, var_1, var_2) {
  if(!getdvarint("feedback")) {
    return;
  }

  var_0 = tolower(var_0);
  scripts\engine\utility::flag_init(var_0 + "_endFunc");
  thread func_48E3(var_0, var_1, var_2);
}

func_56B5(var_0) {
  if(!isDefined(level.var_6BC0)) {
    return;
  }

  if(!isDefined(level.var_6BC0[var_0])) {
    return;
  }

  scripts\engine\utility::waitframe();
}

func_48E3(var_0, var_1, var_2) {
  level waittill("load_finished");
  if(isDefined(var_2)) {
    [[var_1]](var_2);
  } else {
    [[var_1]]();
  }

  scripts\engine\utility::flag_set(var_0 + "_endFunc");
}

func_6BBF(var_0, var_1) {
  if(!isDefined(level.var_6BC3)) {
    return;
  }

  var_2 = var_0["name"];
  var_3 = getdvarint("feedback_index");
  thread func_6BBE(var_2, var_3);
  func_6BBD(var_2, var_3);
  func_56B5(var_2);
}

func_6BBE(var_0, var_1) {
  if(!isDefined(level.var_6BC3[var_1])) {
    return;
  }

  if(!scripts\engine\utility::flag_exist(level.var_6BC3[var_1] + "_endFunc")) {
    return;
  }

  scripts\engine\utility::flag_set("feedback_waiting_on_endFunc");
  scripts\engine\utility::flag_wait(level.var_6BC3[var_1] + "_endFunc");
  scripts\engine\utility::flag_clear("feedback_waiting_on_endFunc");
  func_6BBD(var_0, var_1 + 1);
}

func_6BBD(var_0, var_1) {
  if(scripts\engine\utility::flag("feedback_waiting_on_endFunc")) {
    return;
  }

  if(!isDefined(level.var_6BC3[var_1])) {
    changelevel("", 0);
    level waittill("forever");
  }

  if(level.var_6BC3[var_1] != var_0) {
    setDvar("start", level.var_6BC3[var_1]);
    var_2 = scripts\sp\hud_util::func_48B7("black", 0);
    var_2 fadeovertime(0.5);
    var_2.alpha = 1;
    wait(0.65);
    setDvar("setting_feedback_start", 1);
    map_restart();
    level waittill("forever");
  }
}

func_6BC1() {
  var_0 = getdvarint("feedback_index");
  var_0++;
  setDvar("feedback_index", var_0);
}

func_3D73(var_0) {
  level waittill("load_finished");
  var_1 = [];
  foreach(var_3 in level.var_10BA8) {
    var_1[var_1.size] = var_3["name"];
  }

  foreach(var_6 in var_0) {}
}

func_174B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_7["name"] = var_0;
  var_7["start_func"] = var_1;
  var_7["start_loc_string"] = var_2;
  var_7["logic_func"] = var_3;
  var_7["transient"] = var_4;
  var_7["catchup_function"] = var_5;
  var_7["start_in_jackal"] = var_6;
  return var_7;
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

  return getDvar("start") == "no_game";
}