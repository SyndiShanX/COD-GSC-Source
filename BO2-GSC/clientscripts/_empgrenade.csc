/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_empgrenade.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_audio;
#include clientscripts\_ambientpackage;

init() {
  level.localplayers[0].emp_filter_duration = 0;
  init_filter_emp(level.localplayers[0]);
}

emp_filter_on() {
  level notify("emp_filter_on");
  enable_filter_emp(level.localplayers[0], 7);
  set_filter_emp_amount(level.localplayers[0], 7, 1);
}

emp_filter_off() {
  disable_filter_emp(level.localplayers[0], 7);
}

emp_filter_over_time(n_duration) {
  level notify("emp_filter_over_time");
  level endon("emp_filter_over_time");
  enable_filter_emp(level.localplayers[0], 7);
  set_filter_emp_amount(level.localplayers[0], 7, 1);
  level.localplayers[0] playsound(0, "wpn_emp_bomb_static_start", (0, 0, 0));
  n_emp_filter_intensity = 1;

  if(n_duration > level.localplayers[0].emp_filter_duration)
    level.localplayers[0].emp_filter_duration = n_duration;

  n_fade_out_step = 0.5 / level.localplayers[0].emp_filter_duration * 0.016667;

  while(n_emp_filter_intensity > 0.5) {
    n_emp_filter_intensity = n_emp_filter_intensity - n_fade_out_step;

    if(n_emp_filter_intensity < 0.5)
      n_emp_filter_intensity = 0.5;

    set_filter_emp_amount(level.localplayers[0], 7, n_emp_filter_intensity);
    level.localplayers[0] playloopsound("wpn_emp_bomb_static_loop");
    wait 0.016667;
  }

  disable_filter_emp(level.localplayers[0], 7);
  level.localplayers[0] playsound(0, "wpn_emp_bomb_static_stop", (0, 0, 0));
}