/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_quest.gsc
***********************************************/

func_9700() {
  level.var_13F4D = [];
  level.var_13F1B = [];
  level.var_13F4C = [];
  level.num_of_quest_pieces_completed = 0;
}

func_10CEF() {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  foreach(var_2, var_1 in level.var_13F4D) {
    level thread start_quest_line(var_2);
  }
}

start_quest_line(var_0) {
  var_1 = level.var_13F4D[var_0];
  level.var_13F4C[var_0] = -1;
  foreach(var_4, var_3 in var_1) {
    level.var_13F1B[var_0] = var_4;
    [[var_3.init_func]]();
    if(func_FF37(var_0, var_4)) {
      [[var_3.var_DB5D]]();
    }

    [[var_3.var_446D]]();
  }
}

register_quest_step(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.var_13F4D[var_0])) {
    level.var_13F4D[var_0] = [];
  }

  if(!isDefined(level.var_13F4C[var_0])) {
    level.var_13F4C[var_0] = -1;
  }

  var_8 = spawnStruct();
  var_8.init_func = var_2;
  var_8.var_DB5D = var_3;
  var_8.var_446D = var_4;
  var_8.var_4EB1 = var_5;
  level.var_13F4D[var_0][var_1] = var_8;
  level thread add_devgui_entries(var_0, var_1, var_6, var_7);
}

add_devgui_entries(var_0, var_1, var_2, var_3) {
  wait(3);
  if(!isDefined(var_2)) {
    var_2 = "";
  }

  if(!isDefined(var_3)) {
    var_3 = "";
  }

  if(level.script == "cp_town") {
    if(var_1 == 0) {
      var_4 = "devgui_cmd \"Town:5\Quests\" + var_2 + " - " + var_0 + "\Step " + var_1 + 1 + " - " + var_3 + "\0 - Complete This Step\" \"set scr_complete_quest_step " + var_0 + "_" + var_1 + "\" \n";
      addentrytodevgui(var_4);
      return;
    }

    var_4 = "devgui_cmd \"Town:5\Quests\" + var_3 + " - " + var_1 + "\Step " + var_2 + 1 + " - " + var_4 + "\0 - Jump To This Step\" \"set scr_complete_quest_step " + var_1 + "_" + var_2 - 1 + "\" \n";
    addentrytodevgui(var_4);
    var_4 = "devgui_cmd \"Town:5\Quests\" + var_2 + " - " + var_0 + "\Step " + var_1 + 1 + " - " + var_3 + "\1 - Complete This Step\" \"set scr_complete_quest_step " + var_0 + "_" + var_1 + "\" \n";
    addentrytodevgui(var_4);
  }
}

func_FF37(var_0, var_1) {
  return var_1 > level.var_13F4C[var_0];
}

quest_line_exist(var_0) {
  return isDefined(level.var_13F4D[var_0]);
}

addentrytodevgui(var_0) {}