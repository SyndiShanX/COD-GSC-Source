/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\karma_utility.csc
*******************************************/

#include clientscripts\_utility;

autoexec _karma_utility() {
  register_clientflag_callback("actor", 4, ::set_id_shader);
}

set_id_shader(localclientnum, set, newent) {
  if(set)
    lerp_shader_constant(localclientnum, 2, "ScriptVector3", 2, 0.01, 1);
  else
    lerp_shader_constant(localclientnum, 2, "ScriptVector3", 2, 0.01, 0);
}

screen_flash() {
  playsound(0, "evt_smashcut_flash", (0, 0, 0));
  screen_flash_dvar();
}

screen_flash_dvar() {
  n_exposure = getdvarfloat(#"r_exposureValue");
  setdvar("r_exposureTweak", 1);
  setdvarfloat("r_exposureValue", -6);
  wait(frames(2));
  lerp_dvar("r_exposureValue", -6, n_exposure, frames(2.5 - 1.0), 0);
  setdvar("r_exposureTweak", 0);
}

screen_flash_visionset() {
  str_vision_set = getvisionsetnaked(0);
  visionsetnaked(0, "karma_flash", 0);
  wait(frames(2));
  visionsetnaked(0, str_vision_set, frames(2.5 - 1.0));
}

frames(n_frame_count) {
  return n_frame_count * 0.01666;
}