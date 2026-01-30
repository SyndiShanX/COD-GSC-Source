/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_laser2_aud.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  thread watch_for_underwater();
}

watch_for_underwater() {
  level endon("game_ended");
}

start_rough_tide() {
  wait(1.5);
  playSoundAtPos((2382, 44, 140), "mp_laser2_wave_crashes_under_helipad_large");
  wait(5);

  thread play_interval_sound("mp_laser2_wave_crashes_under_helipad", (2265, -273, 184), 12, 15);
  wait(6);

  thread play_interval_sound("mp_laser2_wave_crashes_under_helipad", (2554, 188, 181), 11, 20);
  wait(5);

  thread play_interval_sound("mp_laser2_wave_crashes_under_helipad", (2562, 477, 184), 11, 16);
}

play_interval_sound(alias, org, min_time, max_time) {
  while(true) {
    playSoundAtPos(org, alias);
    msg = level waittill_any_timeout(RandomIntRange(min_time, max_time), "end_high_tide_waves");

    if(msg != "timeout") {
      return;
    }
  }
}