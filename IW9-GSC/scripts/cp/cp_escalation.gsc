/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_escalation.gsc
***********************************************/

main() {
  level.escalation_level = 0;
  level.escalation_counter = 0;
  level.min_escalation_level_override = getdvarint("dvar_596EDEC0CDB7175A", 0);
}

escalation_level_clamp(value) {
  return clamp(value, get_min_escalation_level(), get_max_escalation_level());
}

increment_escalation_level() {
  level.escalation_level = int(escalation_level_clamp(level.escalation_level + 1));
}

decrement_escalation_level() {
  level.escalation_level = int(escalation_level_clamp(level.escalation_level - 1));
}

set_to_max_escalation() {
  level.escalation_level = int(escalation_level_clamp(get_max_escalation_level()));
}

set_to_min_escalation() {
  level.escalation_level = int(escalation_level_clamp(get_min_escalation_level()));
}

get_max_escalation_level() {
  return getdvarint("dvar_A8EFE8F1B98E7B38", 5);
}

get_max_escalation_decay_start() {
  return getdvarint("dvar_2BAF3906967BA87F", 10);
}

get_max_escalation_decay_rate() {
  return getdvarint("dvar_B5EFFA98A3F6C6A7", 1);
}

get_min_escalation_level() {
  _id_748A5B6E1EB008F5 = getdvarint("dvar_596EDEC0CDB7175A", 0);

  if(level.min_escalation_level_override != _id_748A5B6E1EB008F5)
    _id_748A5B6E1EB008F5 = level.min_escalation_level_override;

  return _id_748A5B6E1EB008F5;
}

get_escalation_counter() {
  return level.escalation_counter;
}

increase_minimum_escalation_level(_id_6302CA9978061647) {
  level.min_escalation_level_override = escalation_level_clamp(_id_6302CA9978061647);
}

increase_escalation_counter() {
  _id_6302CA9978061647 = level.escalation_counter + 0.1;
  level.escalation_counter = escalation_level_clamp(_id_6302CA9978061647);

  if(int(level.escalation_counter) > level.escalation_level)
    increment_escalation_level();
}

decrease_escalation_counter() {
  _id_6302CA9978061647 = level.escalation_counter - 0.1;
  level.escalation_counter = escalation_level_clamp(_id_6302CA9978061647);

  if(int(level.escalation_counter) < level.escalation_level)
    decrement_escalation_level();
}

handle_escalation_on_death() {
  level endon("game_ended");
  level notify("handle_escalation_on_death");
  level endon("handle_escalation_on_death");
  increase_escalation_counter();
  wait(get_max_escalation_decay_start());

  while(get_escalation_counter() > 0) {
    decrease_escalation_counter();
    wait(get_max_escalation_decay_rate());
  }
}