/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_quest.gsc
***********************************************/

init_quest_system() {
  level.zombie_quests = [];
  level.zombie_current_quest_step_index = [];
  level.zombie_quest_complete_up_to_quest_step_index = [];
  level.num_of_quest_pieces_completed = 0;
}

start_quest_system() {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }
  foreach(var_2, var_1 in level.zombie_quests)
  level thread start_quest_line(var_2);
}

start_quest_line(var_0) {
  var_1 = level.zombie_quests[var_0];
  level.zombie_quest_complete_up_to_quest_step_index[var_0] = -1;

  foreach(var_4, var_3 in var_1) {
    level.zombie_current_quest_step_index[var_0] = var_4;
    [[var_3.init_func]]();

    if(should_do_quest_step_func(var_0, var_4))
      [[var_3.quest_step_func]]();

    [[var_3.complete_func]]();
  }
}

register_quest_step(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.zombie_quests[var_0]))
    level.zombie_quests[var_0] = [];

  if(!isDefined(level.zombie_quest_complete_up_to_quest_step_index[var_0]))
    level.zombie_quest_complete_up_to_quest_step_index[var_0] = -1;

  var_6 = spawnStruct();
  var_6.init_func = var_2;
  var_6.quest_step_func = var_3;
  var_6.complete_func = var_4;
  var_6.debug_beat_func = var_5;
  level.zombie_quests[var_0][var_1] = var_6;
}

should_do_quest_step_func(var_0, var_1) {
  return var_1 > level.zombie_quest_complete_up_to_quest_step_index[var_0];
}

quest_line_exist(var_0) {
  return isDefined(level.zombie_quests[var_0]);
}