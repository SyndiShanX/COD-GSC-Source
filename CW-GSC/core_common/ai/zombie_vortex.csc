/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_vortex.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#namespace zombie_vortex;

function private autoexec __init__system__() {
  system::register(#"vortex", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  visionset_mgr::register_visionset_info("zm_idgun_vortex" + "_visionset", 1, 30, undefined, "zm_idgun_vortex");
  visionset_mgr::register_overlay_info_style_speed_blur("zm_idgun_vortex" + "_blur", 1, 1, 0.08, 0.75, 0.9);
  clientfield::register("scriptmover", "vortex_start", 1, 2, "counter", &start_vortex, 0, 0);
  clientfield::register("allplayers", "vision_blur", 1, 1, "int", &vision_blur, 0, 0);
}

function start_vortex(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self endon(#"disconnect");

  if(!isDefined(bwastimejump) || bwastimejump == 0) {
    return;
  }

  e_player = function_5c10bd79(binitialsnap);
  vposition = self.origin;
  bwastimejump -= fieldname;

  if(bwastimejump == 2) {
    registerplayer_lift_clipbamfupdate = # "zombie/fx_idgun_vortex_ug_zod_zmb";
    fx_vortex_explosion = # "zombie/fx_idgun_vortex_explo_ug_zod_zmb";
    n_vortex_time = 10;
  } else if(bwastimejump == 1) {
    registerplayer_lift_clipbamfupdate = # "hash_12f5667e03414550";
    fx_vortex_explosion = # "hash_23fb7256f9bcc7b2";
    n_vortex_time = 10;
  }

  if(!isDefined(registerplayer_lift_clipbamfupdate)) {
    return;
  }

  if(bwastimejump == 2) {
    vortex_fx_handle = playFX(binitialsnap, registerplayer_lift_clipbamfupdate, vposition);
    audio::playloopat("evt_doa_pickup_vortex_active_lp", vposition);
  } else if(bwastimejump == 1) {
    vortex_fx_handle = playFX(binitialsnap, registerplayer_lift_clipbamfupdate, vposition, (1, 0, 0), (0, 0, 1));
    self.var_ccc1f809 = self playLoopSound(#"hash_67abdd3a81520702");
    self playSound(binitialsnap, #"hash_60f3b643131bd830");
  }

  setfxignorepause(binitialsnap, vortex_fx_handle, 1);

  if(!is_true(level.var_12983b40)) {
    self thread vortex_shake_and_rumble(binitialsnap, vposition);
  }

  self thread function_2dd3c5bc(binitialsnap, vortex_fx_handle, vposition, fx_vortex_explosion, n_vortex_time, bwastimejump);
}

function vortex_shake_and_rumble(localclientnum, v_vortex_origin) {
  self endon(#"vortex_stop");

  while(true) {
    self playrumbleonentity(v_vortex_origin, "zod_idgun_vortex_interior");
    wait 0.075;
  }
}

function vision_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    enablespeedblur(fieldname, 0.1, 0.5, 0.75);
    return;
  }

  disablespeedblur(fieldname);
}

function function_2dd3c5bc(localclientnum, vortex_fx_handle, vposition, fx_vortex_explosion, n_vortex_time, var_c385f09c) {
  n_starttime = gettime();
  n_currtime = gettime() - n_starttime;
  n_vortex_time = int(n_vortex_time * 1000);

  while(n_currtime < n_vortex_time) {
    waitframe(1);
    n_currtime = gettime() - n_starttime;
  }

  stopfx(localclientnum, vortex_fx_handle);
  wait 0.15;
  self notify(#"vortex_stop");

  if(var_c385f09c == 2) {
    var_ad8208a9 = playFX(localclientnum, fx_vortex_explosion, vposition);
    audio::stoploopat("evt_doa_pickup_vortex_active_lp", vposition);
    playSound(0, #"evt_doa_pickup_vortex_explode", vposition);
  } else if(var_c385f09c == 1) {
    var_ad8208a9 = playFX(localclientnum, fx_vortex_explosion, vposition, (1, 0, 0), (0, 0, 1));
    self stoploopsound(self.var_ccc1f809);
    self playSound(localclientnum, #"hash_a594ffd27037691");
  }

  setfxignorepause(localclientnum, var_ad8208a9, 1);
  waitframe(1);

  if(!is_true(level.var_12983b40)) {
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_shockwave");
  }

  vision_blur(localclientnum, undefined, 1);
  wait 0.1;
  vision_blur(localclientnum, undefined, 0);
}