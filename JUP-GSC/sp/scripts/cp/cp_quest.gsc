/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_quest.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_quest;

function init_quest_system() {
  level.zombie_quests = [];
  level.zombie_current_quest_step_index = [];
  level.zombie_quest_complete_up_to_quest_step_index = [];
  level.num_of_quest_pieces_completed = 0;
}

function start_quest_system() {
  level thread debug_activation(@ "hash_e9b5bb932cba9edc", &function_b537ff3784cebcc6);

  if(is_codxp()) {
    return;
  }

  foreach(var_509f0abe2daf407f in level.zombie_quests) {
    level thread start_quest_line(quest_name);
  }
}

function start_quest_line(quest_name) {
  var_509f0abe2daf407f = level.zombie_quests[quest_name];
  level.zombie_quest_complete_up_to_quest_step_index[quest_name] = -1;

  foreach(step_index, var_d785e0bc38b7afad in var_509f0abe2daf407f) {
    level.zombie_current_quest_step_index[quest_name] = step_index;
    [[var_d785e0bc38b7afad.init_func]]();

    if(should_do_quest_step_func(quest_name, step_index)) {
      [[var_d785e0bc38b7afad.quest_step_func]]();
    }

    [[var_d785e0bc38b7afad.complete_func]]();
  }
}

function register_quest_step(quest_name, step_index, init_func, quest_step_func, complete_func, debug_beat_func) {
  if(!isDefined(level.zombie_quests[quest_name])) {
    level.zombie_quests[quest_name] = [];
  }

  if(!isDefined(level.zombie_quest_complete_up_to_quest_step_index[quest_name])) {
    level.zombie_quest_complete_up_to_quest_step_index[quest_name] = -1;
  }

  var_d785e0bc38b7afad = spawnStruct();
  var_d785e0bc38b7afad.init_func = init_func;
  var_d785e0bc38b7afad.quest_step_func = quest_step_func;
  var_d785e0bc38b7afad.complete_func = complete_func;
  var_d785e0bc38b7afad.debug_beat_func = debug_beat_func;
  level.zombie_quests[quest_name][step_index] = var_d785e0bc38b7afad;
}

function should_do_quest_step_func(quest_name, step_index) {
  return step_index > level.zombie_quest_complete_up_to_quest_step_index[quest_name];
}

function quest_line_exist(quest_name) {
  return isDefined(level.zombie_quests[quest_name]);
}

function function_b537ff3784cebcc6(var_989eaba483ac52da) {
  var_989eaba483ac52da = strtok(var_989eaba483ac52da, "<dev string:x1c>");
  quest_name = var_989eaba483ac52da[0];
  complete_up_to_quest_step_index = int(var_989eaba483ac52da[1]);

  if(!isDefined(level.zombie_current_quest_step_index[quest_name])) {
    return;
  }

  current_quest_step_index = level.zombie_current_quest_step_index[quest_name];

  if(current_quest_step_index > complete_up_to_quest_step_index) {
    iprintlnbold("<dev string:x1e>" + quest_name + "<dev string:x42>");
    return;
  }

  level.zombie_quest_complete_up_to_quest_step_index[quest_name] = complete_up_to_quest_step_index;
  var_92e889285ed0b482 = level.zombie_quests[quest_name][current_quest_step_index];
  [[var_92e889285ed0b482.debug_beat_func]]();
}

# /