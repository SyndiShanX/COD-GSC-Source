/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\so_rts_mp_socotra.csc
***********************************************/

#include clientscripts\_utility;
#include clientscripts\so_rts_mp_socotra_fx;
#include clientscripts\_claw_grenade;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\so_rts_mp_socotra_amb;
#include clientscripts\_so_rts;
#include clientscripts\_footsteps;

main() {
  clientscripts\so_rts_mp_socotra_fx::main();
  clientscripts\_claw_grenade::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\so_rts_mp_socotra_amb::main();
  thread clientscripts\_so_rts::rts_init("generic_filter_rts_hologram_socotra");
  clientscripts\_footsteps::registeraitypefootstepcb("So_Enemy_Bigdog", clientscripts\_footsteps::bigdogfootstepcbfunc);
  register_clientflag_callback("scriptmover", 1, ::toggle_glove_right);
  register_clientflag_callback("scriptmover", 2, ::toggle_glove_left);
  level.gpr_cb = ::gpr_updated;
  thread waitforclient(0);
}

gpr_updated(localclientnum, op, data) {
  switch (op) {
    case 3:
      val = data & 65535;

      if(val == 0)
        self set_bldg_orange(localclientnum);
      else
        self set_bldg_green(localclientnum);

      break;
  }
}

set_bldg_green(localclientnum) {
  self mapshaderconstant(localclientnum, 3, "ScriptVector0");
  self setshaderconstant(localclientnum, 3, 10, 0, 0, 0.5);
}

set_bldg_orange(localclientnum) {
  self mapshaderconstant(localclientnum, 3, "ScriptVector0");
  self setshaderconstant(localclientnum, 3, 0, 0, 10, 0.5);
}

hide_rock_model(rockx, rocky, rockz) {
  smodelindex = findstaticmodelindex((rockx, rocky, rockz));

  if(isDefined(smodelindex)) {
    hidestaticmodel(smodelindex);
    level waittill("intro_rock_show");
    unhidestaticmodel(smodelindex);
  }
}

toggle_glove_right(localclientnum, set, newent) {
  self endon("death");
  self mapshaderconstant(localclientnum, 0, "ScriptVector2");
  s_timer = new_timer();

  if(set) {
    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0, 1, n_current_time / 0.3);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 0.3);
  } else {
    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0, n_current_time / 0.3);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 0.3);
  }
}

toggle_glove_left(localclientnum, set, newent) {
  self endon("death");
  self mapshaderconstant(localclientnum, 1, "ScriptVector3");
  s_timer = new_timer();

  if(set) {
    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0, 1, n_current_time / 0.3);
      self setshaderconstant(localclientnum, 1, 0, 0, n_delta_val, 0);
    }
    while(n_current_time < 0.3);
  } else {
    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0, n_current_time / 0.3);
      self setshaderconstant(localclientnum, 1, 0, 0, n_delta_val, 0);
    }
    while(n_current_time < 0.3);
  }
}