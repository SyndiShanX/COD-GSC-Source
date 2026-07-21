/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_globalthreat.gsc
***********************************************/

main() {
  level.globalthreatlevel = spawnStruct();
  level.globalthreatlevel.value = 0;
  level.globalthreatlevel.timer = 0;
  level.globalthreatlevel.timer_enabled = 0;
  level thread timer_loop();
}

timer_loop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(istrue(level.globalthreatlevel.timer_enabled)) {
      level.globalthreatlevel.timer = level.globalthreatlevel.timer + 1;

      if(level.globalthreatlevel.timer >= 360) {
        level.globalthreatlevel.timer = 0;
        increase_threatlevel(1);
      }
    }

    wait 1;
  }
}

increased_threatlevel_effects() {
  if(1)
    return;
}

increase_threatlevel(var_0, var_1) {
  if(isDefined(var_0)) {
    if(level.globalthreatlevel.value + var_0 <= 1000) {
      if(isDefined(var_1) && var_1 > 0) {
        for(var_2 = 0; var_2 < var_1; var_2++) {
          level.globalthreatlevel.value = level.globalthreatlevel.value + int(var_0 / var_1);
          wait(var_0 / var_1);
        }
      } else
        level.globalthreatlevel.value = level.globalthreatlevel.value + int(var_0);

      increased_threatlevel_effects();
    }
  }
}

decrease_threatlevel(var_0, var_1) {
  if(isDefined(var_0)) {
    if(level.globalthreatlevel.value - var_0 >= 0) {
      if(isDefined(var_1) && var_1 > 0) {
        for(var_2 = 0; var_2 < var_1; var_2++) {
          level.globalthreatlevel.value = level.globalthreatlevel.value - int(var_0 / var_1);
          wait(var_0 / var_1);
        }
      } else
        level.globalthreatlevel.value = level.globalthreatlevel.value - int(var_0);
    }
  }
}

get_threatlevel() {
  return level.globalthreatlevel.value;
}

start_globalthreat_timer() {
  level.globalthreatlevel.timer_enabled = 1;
}

pause_globalthreat_timer() {
  level.globalthreatlevel.timer_enabled = 0;
}

get_globalthreat_timer_paused() {
  return level.globalthreatlevel.timer_enabled;
}