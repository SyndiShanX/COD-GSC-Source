/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_1.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\la_argus;
#include clientscripts\la_1_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\la_1_amb;
#include clientscripts\_driving_fx;
#include clientscripts\_apc_cougar_ride;
#include clientscripts\_claw_grenade;

main() {
  clientscripts\la_1_fx::main();
  clientscripts\_load::main();
  setsaveddvar("r_extracam_lod_scale", 1.0);
  set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewbody");
  level thread clientscripts\_audio::audio_init(0);
  level thread clientscripts\la_1_amb::main();
  clientscripts\_driving_fx::init();
  clientscripts\_apc_cougar_ride::init();
  clientscripts\_claw_grenade::main();
  register_clientflag_callback("vehicle", 13, ::window_reflection_blur);
  register_clientflag_callback("scriptmover", 1, ::toggle_extra_cam);
  register_clientflag_callback("scriptmover", 2, ::animate_data_glove_hologram);
  waitforclient(0);

  println("*** Client : la_1 running...");

  level thread setup_fullscreen_postfx();
  level thread sam_screen();
  level thread sonar_on_nofity();
  level thread sonar_off_nofity();
}

setup_fullscreen_postfx() {
  waitforclient(0);
  init_sam_hud_damage();
}

sam_screen() {
  while(true) {
    level waittill("sam_on");
    start_hud_outline();
    level waittill("sam_off");
    stop_hud_outline();
  }
}

stop_hud_outline() {
  println("*** STOP HUD ***");

  level.localplayers[0] setsonarenabled(0);
}

start_hud_outline() {
  println("*** START HUD ***");

  level.localplayers[0] setsonarenabled(1);
}

animate_data_glove_hologram(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector7");

  println("**** setting reflection blur - client****");

  n_time = 3;
  s_timer = new_timer();

  do {
    n_current_time = s_timer get_time_in_seconds();
    n_val = lerpfloat(-0.2, 0.3, n_current_time / n_time);
    self setshaderconstant(localclientnum, 0, n_val, 0, 0, 0);
    wait 0.01;
  }
  while(n_current_time < n_time);
}

toggle_extra_cam(localclientnum, set, newent) {
  if(!isDefined(level.extracamactive))
    level.extracamactive = 0;

  if(!level.extracamactive && set) {
    println("**** extra cam on - client****");

    level.extracamactive = 1;
    self isextracam(localclientnum);
  } else if(level.extracamactive && !set) {
    println("**** extra cam on - client****");

    stopextracam(localclientnum);
    level.extracamactive = 0;
  }
}

window_reflection_blur(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");

  println("**** setting reflection blur - client****");

  n_blur_time = 0.5;
  s_timer = new_timer();

  do {
    wait 0.01;
    n_current_time = s_timer get_time_in_seconds();
    n_blur_val = lerpfloat(0, 1, n_current_time / n_blur_time);
    self setshaderconstant(localclientnum, 0, n_blur_val, 0, 0, 0);
  }
  while(n_current_time < n_blur_time);
}

get_time_delta() {
  t_now = getrealtime();
  t_delta = 0;

  if(isDefined(self.n_last_get_time)) {
    t_delta = t_now - self.n_last_get_time;

    if(t_delta >= 500)
      t_delta = 0;
  }

  self.n_last_get_time = t_now;
  return t_delta;
}

sonar_on_nofity() {
  while(true) {
    level waittill("sonar_on", localclientnum);
    sonar_on(localclientnum);
    wait 0.05;
  }
}

sonar_off_nofity() {
  while(true) {
    level waittill("sonar_off", localclientnum);
    sonar_off(localclientnum);
    wait 0.05;
  }
}

sonar_on(localclientnum) {
  level thread sonar_fade(localclientnum, 1);
}

sonar_off(localclientnum) {
  level thread sonar_fade(localclientnum, 0);
}

sonar_fade(localclientnum, sonar_turning_on) {
  if(sonar_turning_on)
    enable_filter_sonar_glass(level.localplayers[0], 0, 0);

  starttime = getrealtime();
  currenttime = starttime;
  elapsedtime = 0;

  if(sonar_turning_on) {
    delaydark = 1.0;
    delaysonar = 2.0;
    delaytotal = delaydark + delaysonar;

    while(elapsedtime < delaytotal) {
      wait 0.01;
      currenttime = getrealtime();
      elapsedtime = (currenttime - starttime) / 1000.0;

      if(elapsedtime > delaytotal)
        elapsedtime = delaytotal;

      if(elapsedtime < delaydark)
        set_filter_sonar_reveal_amount(level.localplayers[0], 0, elapsedtime / delaydark * 0.5);
      else {
        println("csc " + localclientnum + " : turn sonar on");

        level.localplayers[0] setsonarenabled(1);
        set_filter_sonar_reveal_amount(level.localplayers[0], 0, (elapsedtime - delaydark) / delaysonar * 0.5 + 0.5);
      }
    }
  } else {
    delaydark = 0.0;
    delaysonar = 2.0;
    delaytotal = delaydark + delaysonar;

    while(elapsedtime < delaytotal) {
      wait 0.01;
      currenttime = getrealtime();
      elapsedtime = (currenttime - starttime) / 1000.0;

      if(elapsedtime > delaytotal)
        elapsedtime = delaytotal;

      if(elapsedtime < delaysonar)
        set_filter_sonar_reveal_amount(level.localplayers[0], 0, 1 - elapsedtime / delaysonar * 0.5);
      else {
        println("csc " + localclientnum + " : turn sonar off");

        level.localplayers[0] setsonarenabled(0);
        set_filter_sonar_reveal_amount(level.localplayers[0], 0, 0.5 - (elapsedtime - delaysonar) * 0.5);
      }
    }
  }

  if(!sonar_turning_on)
    disable_filter_sonar_glass(level.localplayers[0], 0, 0);
}

init_sam_hud_damage() {
}

sam_damage() {
}