/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\panama_3.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\panama_3_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\panama_3_amb;

main() {
  clientscripts\panama_3_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\panama_3_amb::main();
  register_clientflag_callback("scriptmover", 1, ::toggle_extra_cam);
  register_clientflag_callback("scriptmover", 13, ::blood_pool);
  waitforclient(0);

  println("*** Client : panama_3 running...");
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

blood_pool(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");

  println("**** setting blood pool - client****");

  unused = 0;
  n_transition_time = 10;
  s_timer = new_timer();

  do {
    wait 0.01;
    n_current_time = s_timer get_time_in_seconds();
    n_delta_val = lerpfloat(0, 0.9, n_current_time / n_transition_time);
    self setshaderconstant(localclientnum, 0, n_delta_val, unused, unused, unused);
  }
  while(n_current_time < n_transition_time);
}