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

function increase_threatlevel(var0, var1) {
  if(isDefined(var0)) {
    if(level.globalthreatlevel.value + var0 <= 1000) {
      if(isDefined(var1) && var1 > 0) {
        for(var2 = 0; var2 < var1; var2++) {
          level.globalthreatlevel.value += int(var0 / var1);
          wait var0 / var1;
        }
      } else {
        level.globalthreatlevel.value += int(var0);
      }

      increased_threatlevel_effects();
      return;
    }

    return;
  }
}

function decrease_threatlevel(var0, var1) {
  if(isDefined(var0)) {
    if(level.globalthreatlevel.value - var0 >= 0) {
      if(isDefined(var1) && var1 > 0) {
        for(var2 = 0; var2 < var1; var2++) {
          level.globalthreatlevel.value -= int(var0 / var1);
          wait var0 / var1;
        }

        return;
      }

      level.globalthreatlevel.value -= int(var0);
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