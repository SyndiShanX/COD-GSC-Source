/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\zombie_vortex.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zombie_vortex;

function autoexec __init__sytem__() {
  system::register("vortex", &__init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_visionset_info("zm_idgun_vortex" + "_visionset", 1, 30, undefined, "zm_idgun_vortex");
  visionset_mgr::register_overlay_info_style_speed_blur("zm_idgun_vortex" + "_blur", 1, 1, 0.08, 0.75, 0.9);
  clientfield::register("scriptmover", "vortex_start", 1, 2, "counter", &start_vortex, 0, 0);
  clientfield::register("allplayers", "vision_blur", 1, 1, "int", &vision_blur, 0, 0);
}

function start_vortex(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self endon("disconnect");
  if(!isDefined(newval) || newval == 0) {
    return;
  }
  e_player = getlocalplayer(localclientnum);
  var_3ea33288 = self.origin;
  newval = newval - oldval;
  if(newval == 2) {
    var_98194156 = "zombie/fx_idgun_vortex_ug_zod_zmb";
    var_89a4c04a = "zombie/fx_idgun_vortex_explo_ug_zod_zmb";
    n_vortex_time = 10;
  } else {
    var_98194156 = "zombie/fx_idgun_vortex_zod_zmb";
    var_89a4c04a = "zombie/fx_idgun_vortex_explo_zod_zmb";
    n_vortex_time = 5;
  }
  vortex_fx_handle = playFX(localclientnum, var_98194156, var_3ea33288);
  setfxignorepause(localclientnum, vortex_fx_handle, 1);
  playSound(0, "wpn_idgun_portal_start", var_3ea33288);
  audio::playloopat("wpn_idgun_portal_loop", var_3ea33288);
  self thread vortex_shake_and_rumble(localclientnum, var_3ea33288);
  self thread function_69096485(localclientnum, vortex_fx_handle, var_3ea33288, var_89a4c04a, n_vortex_time);
}

function vortex_shake_and_rumble(localclientnum, v_vortex_origin) {
  self endon("vortex_stop");
  while(true) {
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
    wait(0.075);
  }
}

function vision_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    enablespeedblur(localclientnum, 0.1, 0.5, 0.75);
  } else {
    disablespeedblur(localclientnum);
  }
}

function function_69096485(localclientnum, vortex_fx_handle, var_3ea33288, var_89a4c04a, n_vortex_time) {
  e_player = getlocalplayer(localclientnum);
  n_starttime = e_player getclienttime();
  n_currtime = e_player getclienttime() - n_starttime;
  n_vortex_time = n_vortex_time * 1000;
  while(isDefined(e_player) && n_currtime < n_vortex_time) {
    wait(0.05);
    if(isDefined(e_player)) {
      n_currtime = e_player getclienttime() - n_starttime;
    }
  }
  stopfx(localclientnum, vortex_fx_handle);
  audio::stoploopat("wpn_idgun_portal_loop", var_3ea33288);
  playSound(0, "wpn_idgun_portal_stop", var_3ea33288);
  wait(0.15);
  self notify("vortex_stop");
  var_7d342267 = playFX(localclientnum, var_89a4c04a, var_3ea33288);
  setfxignorepause(localclientnum, var_7d342267, 1);
  playSound(0, "wpn_idgun_portal_explode", var_3ea33288);
  wait(0.05);
  if(isDefined(self)) {
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_shockwave");
  }
  vision_blur(localclientnum, undefined, 1);
  wait(0.1);
  vision_blur(localclientnum, undefined, 0);
}