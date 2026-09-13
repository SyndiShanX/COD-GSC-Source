/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_quest.gsc
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
  foreach(_id_5BF8777B9B155D99, _id_509F0ABE2DAF407F in level.zombie_quests)
  level thread start_quest_line(_id_5BF8777B9B155D99);
}

start_quest_line(_id_5BF8777B9B155D99) {
  _id_509F0ABE2DAF407F = level.zombie_quests[_id_5BF8777B9B155D99];
  level.zombie_quest_complete_up_to_quest_step_index[_id_5BF8777B9B155D99] = -1;

  foreach(_id_72D6784B01700D48, _id_D785E0BC38B7AFAD in _id_509F0ABE2DAF407F) {
    level.zombie_current_quest_step_index[_id_5BF8777B9B155D99] = _id_72D6784B01700D48;
    [[_id_D785E0BC38B7AFAD.init_func]]();

    if(should_do_quest_step_func(_id_5BF8777B9B155D99, _id_72D6784B01700D48))
      [[_id_D785E0BC38B7AFAD.quest_step_func]]();

    [[_id_D785E0BC38B7AFAD.complete_func]]();
  }
}

register_quest_step(_id_5BF8777B9B155D99, _id_72D6784B01700D48, init_func, quest_step_func, complete_func, debug_beat_func) {
  if(!isDefined(level.zombie_quests[_id_5BF8777B9B155D99]))
    level.zombie_quests[_id_5BF8777B9B155D99] = [];

  if(!isDefined(level.zombie_quest_complete_up_to_quest_step_index[_id_5BF8777B9B155D99]))
    level.zombie_quest_complete_up_to_quest_step_index[_id_5BF8777B9B155D99] = -1;

  _id_D785E0BC38B7AFAD = spawnStruct();
  _id_D785E0BC38B7AFAD.init_func = init_func;
  _id_D785E0BC38B7AFAD.quest_step_func = quest_step_func;
  _id_D785E0BC38B7AFAD.complete_func = complete_func;
  _id_D785E0BC38B7AFAD.debug_beat_func = debug_beat_func;
  level.zombie_quests[_id_5BF8777B9B155D99][_id_72D6784B01700D48] = _id_D785E0BC38B7AFAD;
}

should_do_quest_step_func(_id_5BF8777B9B155D99, _id_72D6784B01700D48) {
  return _id_72D6784B01700D48 > level.zombie_quest_complete_up_to_quest_step_index[_id_5BF8777B9B155D99];
}

quest_line_exist(_id_5BF8777B9B155D99) {
  return isDefined(level.zombie_quests[_id_5BF8777B9B155D99]);
}