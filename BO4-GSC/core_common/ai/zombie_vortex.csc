/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_vortex.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace zombie_vortex;

autoexec __init__system__() {
  system::register(#"vortex", &__init__, undefined, undefined);
}

__init__() {
  visionset_mgr::register_visionset_info("zm_idgun_vortex" + "_visionset", 1, 30, undefined, "zm_idgun_vortex");
  visionset_mgr::register_overlay_info_style_speed_blur("zm_idgun_vortex" + "_blur", 1, 1, 0.08, 0.75, 0.9);
  clientfield::register("scriptmover", "vortex_start", 1, 2, "counter", &start_vortex, 0, 0);
  clientfield::register("allplayers", "vision_blur", 1, 1, "int", &vision_blur, 0, 0);
}

start_vortex(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self endon(#"disconnect");

  if(!isDefined(newval) || newval == 0) {
    return;
  }

  e_player = function_5c10bd79(localclientnum);
  vposition = self.origin;
  newval -= oldval;

  if(newval == 2) {
    registerplayer_lift_clipbamfupdate = "zombie/fx_idgun_vortex_ug_zod_zmb";
    fx_vortex_explosion = "zombie/fx_idgun_vortex_explo_ug_zod_zmb";
    n_vortex_time = 10;
  } else {
    registerplayer_lift_clipbamfupdate = "zombie/fx_idgun_vortex_zod_zmb";
    fx_vortex_explosion = "zombie/fx_idgun_vortex_explo_zod_zmb";
    n_vortex_time = 5;
  }

  vortex_fx_handle = playFX(localclientnum, registerplayer_lift_clipbamfupdate, vposition);
  setfxignorepause(localclientnum, vortex_fx_handle, 1);
  playSound(0, #"wpn_idgun_portal_start", vposition);
  audio::playloopat("wpn_idgun_portal_loop", vposition);
  self thread vortex_shake_and_rumble(localclientnum, vposition);
  self thread function_2dd3c5bc(localclientnum, vortex_fx_handle, vposition, fx_vortex_explosion, n_vortex_time);
}

vortex_shake_and_rumble(localclientnum, v_vortex_origin) {
  self endon(#"vortex_stop");

  while(true) {
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
    wait 0.075;
  }
}

vision_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    enablespeedblur(localclientnum, 0.1, 0.5, 0.75);
    return;
  }

  disablespeedblur(localclientnum);
}

function_2dd3c5bc(localclientnum, vortex_fx_handle, vposition, fx_vortex_explosion, n_vortex_time) {
  e_player = function_5c10bd79(localclientnum);
  n_starttime = e_player getclienttime();
  n_currtime = e_player getclienttime() - n_starttime;
  n_vortex_time = int(n_vortex_time * 1000);

  while(n_currtime < n_vortex_time) {
    waitframe(1);
    n_currtime = e_player getclienttime() - n_starttime;
  }

  stopfx(localclientnum, vortex_fx_handle);
  audio::stoploopat("wpn_idgun_portal_loop", vposition);
  playSound(0, #"wpn_idgun_portal_stop", vposition);
  wait 0.15;
  self notify(#"vortex_stop");
  var_ad8208a9 = playFX(localclientnum, fx_vortex_explosion, vposition);
  setfxignorepause(localclientnum, var_ad8208a9, 1);
  playSound(0, #"wpn_idgun_portal_explode", vposition);
  waitframe(1);
  self playrumbleonentity(localclientnum, "zod_idgun_vortex_shockwave");
  vision_blur(localclientnum, undefined, 1);
  wait 0.1;
  vision_blur(localclientnum, undefined, 0);
}