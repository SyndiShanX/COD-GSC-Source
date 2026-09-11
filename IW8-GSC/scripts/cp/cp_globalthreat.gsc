/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_globalthreat.gsc
***********************************************/

function main() {
  level.globalthreatlevel = spawnStruct();
  level.globalthreatlevel.value = 0;
  level.globalthreatlevel.timer = 0;
  level.globalthreatlevel.timer_enabled = 0;
  thread timer_loop();
}

function timer_loop() {
  level endon("game_ended");

  for(;;) {
    if(istrue(level.globalthreatlevel.timer_enabled)) {
      level.globalthreatlevel.timer += 1;

      if(level.globalthreatlevel.timer >= 360) {
        level.globalthreatlevel.timer = 0;
        increase_threatlevel(1);
      }
    }

    wait 1;
  }
}

function increased_threatlevel_effects() {
  if(true) {
    return;
  }
}

function increase_threatlevel(var_0, var_1) {
  if(isDefined(var_0)) {
    if(level.globalthreatlevel.value + var_0 <= 1000) {
      if(isDefined(var_1) && var_1 > 0) {
        for(var_2 = 0; var_2 < var_1; var_2++) {
          level.globalthreatlevel.value += int(var_0 / var_1);
          wait var_0 / var_1;
        }
      } else {
        level.globalthreatlevel.value += int(var_0);
      }

      increased_threatlevel_effects();
      return;
    }

    return;
  }
}

function decrease_threatlevel(var_0, var_1) {
  if(isDefined(var_0)) {
    if(level.globalthreatlevel.value - var_0 >= 0) {
      if(isDefined(var_1) && var_1 > 0) {
        for(var_2 = 0; var_2 < var_1; var_2++) {
          level.globalthreatlevel.value -= int(var_0 / var_1);
          wait var_0 / var_1;
        }

        return;
      }

      level.globalthreatlevel.value -= int(var_0);
      return;
    }

    return;
  }
}

function get_threatlevel() {
  return level.globalthreatlevel.value;
}

function start_globalthreat_timer() {
  level.globalthreatlevel.timer_enabled = 1;
}

function pause_globalthreat_timer() {
  level.globalthreatlevel.timer_enabled = 0;
}

function get_globalthreat_timer_paused() {
  return level.globalthreatlevel.timer_enabled;
}