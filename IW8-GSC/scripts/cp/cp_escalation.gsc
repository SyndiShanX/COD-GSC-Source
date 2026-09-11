/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_escalation.gsc
***********************************************/

function main() {
  level.escalation_level = 0;
  level.escalation_counter = 0;
  level.min_escalation_level_override = getdvarint("scr_min_escalation_level", 0);
}

function escalation_level_clamp(var_0) {
  return clamp(var_0, get_min_escalation_level(), get_max_escalation_level());
}

function increment_escalation_level() {
  level.escalation_level = int(escalation_level_clamp(level.escalation_level + 1));
}

function decrement_escalation_level() {
  level.escalation_level = int(escalation_level_clamp(level.escalation_level - 1));
}

function set_to_max_escalation() {
  level.escalation_level = int(escalation_level_clamp(get_max_escalation_level()));
}

function set_to_min_escalation() {
  level.escalation_level = int(escalation_level_clamp(get_min_escalation_level()));
}

function get_max_escalation_level() {
  return getdvarint("scr_max_escalation_level", 5);
}

function get_max_escalation_decay_start() {
  return getdvarint("scr_max_escalation_decay_start", 10);
}

function get_max_escalation_decay_rate() {
  return getdvarint("scr_max_escalation_decay_rate", 1);
}

function get_min_escalation_level() {
  var_0 = getdvarint("scr_min_escalation_level", 0);

  if(level.min_escalation_level_override != var_0) {
    var_0 = level.min_escalation_level_override;
  }

  return var_0;
}

function get_escalation_counter() {
  return level.escalation_counter;
}

function increase_minimum_escalation_level(var_0) {
  level.min_escalation_level_override = escalation_level_clamp(var_0);
}

function increase_escalation_counter() {
  var_0 = level.escalation_counter + 0.1;
  level.escalation_counter = escalation_level_clamp(var_0);

  if(int(level.escalation_counter) > level.escalation_level) {
    increment_escalation_level();
    return;
  }
}

function decrease_escalation_counter() {
  var_0 = level.escalation_counter - 0.1;
  level.escalation_counter = escalation_level_clamp(var_0);

  if(int(level.escalation_counter) < level.escalation_level) {
    decrement_escalation_level();
    return;
  }
}

function handle_escalation_on_death() {
  level endon("game_ended");
  level notify("handle_escalation_on_death");
  level endon("handle_escalation_on_death");
  increase_escalation_counter();
  wait get_max_escalation_decay_start();

  while(get_escalation_counter() > 0) {
    decrease_escalation_counter();
    wait get_max_escalation_decay_rate();
  }
}