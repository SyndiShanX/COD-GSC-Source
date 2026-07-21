/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_escalation.gsc
***********************************************/

main() {
  level.escalation_level = 0;
  level.escalation_counter = 0;
  level.min_escalation_level_override = getdvarint("_encstr_8553192646BB2738F9337950BF0B7189522B93A09D013961CE37E8", 0);
}

escalation_level_clamp(var_0) {
  return clamp(var_0, get_min_escalation_level(), get_max_escalation_level());
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
  return getdvarint("_encstr_86A71993C99ED7F5B8499FAD37C0BE434F838ADAF0E0D32F386BD4", 5);
}

get_max_escalation_decay_start() {
  return getdvarint("_encstr_8C881F03DE23173DA398A11AD8FF7693393D9187E02E23C74F78CBB1B0F9AE1333", 10);
}

get_max_escalation_decay_rate() {
  return getdvarint("_encstr_8B821ECD3639FA5B58C37DACB9362C1B851D4BDBCDAF46AC8D2CCBEB3985E859", 1);
}

get_min_escalation_level() {
  var_0 = getdvarint("_encstr_8553192646BB2738F9337950BF0B7189522B93A09D013961CE37E8", 0);

  if(level.min_escalation_level_override != var_0)
    var_0 = level.min_escalation_level_override;

  return var_0;
}

get_escalation_counter() {
  return level.escalation_counter;
}

increase_minimum_escalation_level(var_0) {
  level.min_escalation_level_override = escalation_level_clamp(var_0);
}

increase_escalation_counter() {
  var_0 = level.escalation_counter + 0.1;
  level.escalation_counter = escalation_level_clamp(var_0);

  if(int(level.escalation_counter) > level.escalation_level)
    increment_escalation_level();
}

decrease_escalation_counter() {
  var_0 = level.escalation_counter - 0.1;
  level.escalation_counter = escalation_level_clamp(var_0);

  if(int(level.escalation_counter) < level.escalation_level)
    decrement_escalation_level();
}

handle_escalation_on_death() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_929E1B294162923069E7EDDB61F8F3D10454FFEDEF2F4EA108E786B3FA");
  level endon("_encstr_929E1B294162923069E7EDDB61F8F3D10454FFEDEF2F4EA108E786B3FA");
  increase_escalation_counter();
  wait(get_max_escalation_decay_start());

  while(get_escalation_counter() > 0) {
    decrease_escalation_counter();
    wait(get_max_escalation_decay_rate());
  }
}