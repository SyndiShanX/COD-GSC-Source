/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\185.gsc
**************************************/

setup_new_eq_settings(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(level.ambient_eq[var_0])) {
    deactivate_index(var_1);
    return 0;
  }

  if(level.eq_track[var_1] == var_0) {
    return 0;
  }
  level.eq_track[var_1] = var_0;
  use_eq_settings(var_0, var_1);
  return 1;
}

use_eq_settings(var_0, var_1) {
  if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  maps\_audio::aud_set_filter(var_0, var_1);
}

deactivate_index(var_0) {
  level.eq_track[var_0] = "";
  level.player deactivateeq(var_0);
}

blend_to_eq_track(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }
  var_3 = 0.05;
  var_4 = var_2 / var_3;
  var_5 = 1 / var_4;

  for(var_6 = 0; var_6 <= 1; var_6 = var_6 + var_5) {
    level.player seteqlerp(var_6, var_0);
    wait(var_3);
  }

  level.player seteqlerp(1, var_0);
}

use_reverb_settings(var_0) {
  if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  maps\_audio_reverb::rvb_start_preset(var_0);
}

deactivate_reverb() {
  maps\_audio_reverb::rvb_deactive_reverb();
}

ambientdelay(var_0, var_1, var_2) {
  maps\_audio::aud_print_warning("ambientDelay called, this is deprecated! Use new preset string tables.");
}

ambientevent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  maps\_audio::aud_print_warning("ambientEvent called, this is deprecated! Use new preset string tables.");
}

ambienteventstart(var_0) {
  maps\_audio::aud_print_warning("ambientEventStart called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
  maps\_utility::set_ambient(var_0);
}

start_ambient_event(var_0) {
  maps\_audio::aud_print_warning("start_ambient_event called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
  maps\_utility::set_ambient(var_0);
}

get_progess(var_0, var_1, var_2, var_3) {
  maps\_utility::get_progress(var_0, var_1, var_3, var_2);
}