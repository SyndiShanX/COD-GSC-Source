/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\monsoon.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\monsoon_fx;
#include clientscripts\_load;
#include clientscripts\_explosive_dart;
#include clientscripts\_audio;
#include clientscripts\monsoon_amb;

main() {
  clientscripts\monsoon_fx::main();
  clientscripts\_load::main();
  clientscripts\_explosive_dart::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\monsoon_amb::main();
  register_clientflag_callback("player", 6, ::toggle_rain_overlay);
  register_clientflag_callback("player", 7, ::toggle_wingsuit_overlay);
  register_clientflag_callback("player", 8, ::toggle_player_binoculars);
  register_clientflag_callback("actor", 12, ::toggle_camo_suit);
  register_clientflag_callback("actor", 10, ::toggle_gas_suit);
  register_clientflag_callback("actor", 11, ::toggle_outline);
  register_clientflag_callback("actor", 14, ::swing_trail_fx);
  register_clientflag_callback("vehicle", 11, ::toggle_outline);
  register_clientflag_callback("vehicle", 12, ::toggle_gas_suit);
  register_clientflag_callback("scriptmover", 1, ::toggle_glove_right);
  register_clientflag_callback("scriptmover", 2, ::toggle_glove_left);
  register_clientflag_callback("scriptmover", 11, ::toggle_outline);
  register_clientflag_callback("scriptmover", 10, ::toggle_data_stream);
  waitforclient(0);

  println("*** Client : monsoon running...");

  init_filter_raindrops(level.localplayers[0]);
  init_filter_squirrel_raindrops(level.localplayers[0]);
  init_filter_binoculars_with_outline(level.localplayers[0]);
  init_monsoon_frost_filter();
}

swing_trail_fx(localclientnum, set, newent) {
  if(set)
    self.trailfx = playfxontag(localclientnum, level._effect["harper_swing_trail"], self, "j_spineupper");
  else if(isDefined(self.trailfx)) {
    stopfx(localclientnum, self.trailfx);
    self.trailfx = undefined;
  }
}

toggle_rain_overlay(localclientnum, set, newent) {
  if(set) {
    println("**** rain overlay on****");

    enable_filter_raindrops(level.localplayers[0], 2);
  } else {
    println("**** rain overlay off****");

    disable_filter_raindrops(level.localplayers[0], 2);
  }
}

toggle_wingsuit_overlay(localclientnum, set, newent) {
  if(set) {
    println("**** wingsuit overlay on****");

    enable_filter_squirrel_raindrops(level.localplayers[0], 3);
  } else {
    println("**** wingsuit overlay off****");

    disable_filter_squirrel_raindrops(level.localplayers[0], 3);
  }
}

toggle_player_binoculars(localclientnum, set, newent) {
  if(set) {
    level.localplayers[0] setsonarenabled(1);
    enable_filter_binoculars_with_outline(level.localplayers[0], 0, 0);
    setworldfogactivebank(localclientnum, 2);
  } else {
    level.localplayers[0] setsonarenabled(0);
    disable_filter_binoculars_with_outline(level.localplayers[0], 0, 0);
    setworldfogactivebank(localclientnum, 1);
  }
}

toggle_camo_suit(localclientnum, set, newent) {
  self endon("death");
  self endon("entityshutdown");
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  s_timer = new_timer();

  if(set) {
    println("**** AI at origin " + self.origin + " camo suit turned off****");

    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0, 1, n_current_time / 3);

      if(isDefined(self))
        self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 3);
  } else {
    println("**** AI at origin " + self.origin + " camo suit turned on****");

    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0, n_current_time / 3);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, 0, 0);
    }
    while(n_current_time < 3);
  }
}

toggle_gas_suit(localclientnum, set, newent) {
  self endon("death");
  self endon("entityshutdown");
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  s_timer = new_timer();

  do {
    wait 0.01;
    n_current_time = s_timer get_time_in_seconds();
    n_delta_val = lerpfloat(0, 0.85, n_current_time / 3);
    self setshaderconstant(localclientnum, 0, 0, 0, n_delta_val, 0);
  }
  while(n_current_time < 3);
}

toggle_outline(localclientnum, set, newent) {
  if(set)
    self sethudoutlinecolor(1);
  else
    self sethudoutlinecolor(0);
}

toggle_data_stream(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  s_timer = new_timer();

  if(set) {
    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0, n_current_time / 0.5);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, n_delta_val, 0);
    }
    while(n_current_time < 0.5);
  } else {
    do {
      wait 0.01;
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0, 1, n_current_time / 0.5);
      self setshaderconstant(localclientnum, 0, n_delta_val, 0, n_delta_val, 0);
    }
    while(n_current_time < 0.5);
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

init_monsoon_frost_filter() {
  level.localplayers[0].frost_filter_duration = 0;
  init_filter_frost(level.localplayers[0]);
}

frost_filter_on() {
  level notify("frost_filter_on");
  enable_filter_frost(level.localplayers[0], 3, 0);
  set_filter_frost_opacity(level.localplayers[0], 3, 0);
}

frost_filter_off() {
  disable_filter_frost(level.localplayers[0], 3);
}

frost_filter_over_time(n_duration, inside_chamber, set) {
  level notify("frost_filter_over_time");
  level endon("frost_filter_over_time");
  frost_filter_on();
  s_timer = new_timer();
  n_frost_filter_intensity = 1;

  if(n_duration > level.localplayers[0].frost_filter_duration)
    level.localplayers[0].frost_filter_duration = n_duration;

  if(set) {
    do {
      wait 0.016667;

      if(isDefined(inside_chamber))
        max_intensity = 0.2;
      else
        max_intensity = 1;

      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0, max_intensity, n_current_time / level.localplayers[0].frost_filter_duration);
      n_frost_filter_intensity = n_delta_val;
      set_filter_frost_opacity(level.localplayers[0], 3, n_frost_filter_intensity);
    }
    while(n_frost_filter_intensity < max_intensity);
  } else {
    do {
      wait 0.016667;

      if(isDefined(inside_chamber))
        max_intensity = 0.2;
      else
        max_intensity = 1;

      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(max_intensity, 0, n_current_time / level.localplayers[0].frost_filter_duration);
      n_frost_filter_intensity = n_delta_val;
      set_filter_frost_opacity(level.localplayers[0], 3, n_frost_filter_intensity);
    }
    while(n_frost_filter_intensity > 0);
  }
}