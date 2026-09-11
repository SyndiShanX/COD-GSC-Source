/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_quest.gsc
***********************************************/

function init_quest_system() {
  level.zombie_quests = [];
  level.zombie_current_quest_step_index = [];
  level.zombie_quest_complete_up_to_quest_step_index = [];
  level.num_of_quest_pieces_completed = 0;
}

function start_quest_system() {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  foreach(var1 in level.zombie_quests) {
    thread start_quest_line(level);
  }
}

function start_quest_line(var0) {
  var1 = level.zombie_quests[var0];
  level.zombie_quest_complete_up_to_quest_step_index[var0] = -1;

  foreach(var3 in var1) {
    level.zombie_current_quest_step_index[var0] = var4;
    [[var3.init_func]]();

    if(should_do_quest_step_func(var0, var4)) {
      [[var3.quest_step_func]]();
    }

    [[var3.complete_func]]();
  }
}

function register_quest_step(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.zombie_quests[var0])) {
    level.zombie_quests[var0] = [];
  }

  if(!isDefined(level.zombie_quest_complete_up_to_quest_step_index[var0])) {
    level.zombie_quest_complete_up_to_quest_step_index[var0] = -1;
  }

  var6 = spawnStruct();
  var6.init_func = var2;
  var6.quest_step_func = var3;
  var6.complete_func = var4;
  var6.debug_beat_func = var5;
  level.zombie_quests[var0][var1] = var6;
}

function should_do_quest_step_func(var0, var1) {
  return var1 > level.zombie_quest_complete_up_to_quest_step_index[var0];
}

function quest_line_exist(var0) {
  return isDefined(level.zombie_quests[var0]);
}