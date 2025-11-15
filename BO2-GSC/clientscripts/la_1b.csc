/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_1b.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\la_argus;
#include clientscripts\la_1b_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\la_1b_amb;
#include clientscripts\_fire_direction;
#include clientscripts\_claw_grenade;
#include clientscripts\_footsteps;

main() {
  clientscripts\la_1b_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\la_1b_amb::main();
  thread clientscripts\_fire_direction::init();
  clientscripts\_claw_grenade::main();
  register_clientflag_callback("scriptmover", 2, ::animate_data_glove_hologram);
  waitforclient(0);

  println("*** Client : la_1b running...");

  level thread setup_fullscreen_postfx();
  level thread sam_screen();
  clientscripts\_footsteps::registeraitypefootstepcb("Enemy_Manticore_LA_BigDog", clientscripts\_footsteps::bigdogfootstepcbfunc);
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

setup_fullscreen_postfx() {
  waitforclient(0);
  init_filter_sonar(level.localplayers[0]);
  init_filter_hud_outline(level.localplayers[0]);
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

  disable_filter_hud_outline(level.localplayers[0], 0, 0);
  level.localplayers[0] setsonarenabled(0);
}

start_hud_outline() {
  println("*** START HUD ***");

  enable_filter_hud_outline(level.localplayers[0], 0, 0);
  level.localplayers[0] setsonarenabled(1);
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

init_sam_hud_damage() {
  level thread sam_damage();
}

sam_damage() {
}