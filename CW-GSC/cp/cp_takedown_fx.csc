/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_fx.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using script_dfd475a961626c7;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;
#namespace cp_takedown_fx;

function private autoexec __init__system__() {
  system::register(#"cp_takedown_fx", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  function_bc948200();
}

function private function_fa076c68() {
  vehicle::add_vehicletype_callback(#"hash_1598bee2e954e43a", &function_54f94439);
  vehicle::add_vehicletype_callback(#"hash_46249425f37afc74", &function_5f6bf482);
  vehicle::add_vehicletype_callback(#"hash_1d28a638b43b4117", &function_d7fc17ab);
}

function private function_bc948200() {
  clientfield::register("scriptmover", "clf_billiardslight_client_register", 1, 1, "int", &function_efaa9fbd, 0, 0);
  clientfield::register("scriptmover", "clf_billiardslight_fx", 1, 1, "int", &function_786ac693, 0, 0);
  clientfield::register("scriptmover", "clf_cargoplane_client_register", 1, 1, "int", &function_a9581e24, 0, 0);
  clientfield::register("scriptmover", "clf_cargoplane_door_sparks", 1, 1, "int", &function_49365e3b, 0, 0);
  clientfield::register("scriptmover", "clf_cargoplane_landing_lights", 1, 1, "int", &function_5caef633, 0, 0);
  clientfield::register("scriptmover", "clf_cargoplane_nav_lights", 1, 1, "int", &function_c4178945, 0, 0);
  clientfield::register("vehicle", "clf_rccar_fxstate", 1, 8, "int", &function_b68c2eb9, 0, 0);
  clientfield::register("vehicle", "clf_bronco_roof_lights", 1, 1, "int", &function_979cbf76, 0, 0);
  clientfield::register("vehicle", "clf_bronco_cab_lights", 1, 1, "int", &function_f6936758, 0, 0);
  clientfield::register("vehicle", "clf_whizbyfx_bronco", 1, 1, "int", &function_92a58466, 0, 0);
  clientfield::register("toplayer", "clf_postfx_rccar", 1, 1, "int", &function_a4c9adb9, 0, 0);
  clientfield::register("toplayer", "clf_postfx_transition", 1, 1, "int", &function_f14b954c, 0, 0);
  clientfield::register("toplayer", "clf_postfx_rooftop_slide", 1, 1, "int", &function_636d3664, 0, 0);
  clientfield::register("toplayer", "clf_footstep_override", 1, 1, "int", &function_4a75f4b6, 0, 0);
  clientfield::register("actor", "clf_rob_snipercam_blood", 1, 2, "int", &function_d1374213, 0, 0);
}

function private function_4a75f4b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_907070de("<dev string:x38>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    function_27d5cafd(#"hash_6596d53586d3ef06", #"hash_6596d53586d3ef06");
    return;
  }

  function_27d5cafd();
}

function private function_efaa9fbd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  level._fx.var_6e8a28b6 = self;
}

function private function_786ac693(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:x51>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_7ab521db(localclientnum);
    return;
  }

  self notify(#"hash_50cc63ed1ff3cc9a");
}

function private function_7ab521db(localclientnum) {
  self notify(#"hash_6c3d9a30da5f352d");
  fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_hit2_billiards_light", self, "tag_light");
  self thread function_ef765af1(localclientnum, fxid);
}

function private function_ef765af1(localclientnum, fxid) {
  self waittill(#"death", #"hash_6c3d9a30da5f352d", #"hash_50cc63ed1ff3cc9a");
  stopfx(localclientnum, fxid);
}

function private function_a9581e24(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  level._fx.cargo_plane = self;
}

function private function_5caef633(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:x6a>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_9a0e9c31(localclientnum);
    return;
  }

  self notify(#"hash_10d9c330299e2a6d");
}

function private function_9a0e9c31(localclientnum) {
  self notify(#"hash_16331609e21e3a86");
  var_3f79908d = playtagfxset(localclientnum, "fx9_cargo_plane_landing_lights", self);
  self thread function_b053bd08(localclientnum, var_3f79908d);
}

function private function_b053bd08(localclientnum, var_3f79908d) {
  self waittill(#"death", #"hash_16331609e21e3a86", #"hash_10d9c330299e2a6d");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_c4178945(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:x8b>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_54105299(localclientnum);
    return;
  }

  self notify(#"hash_5bd6457a6c206a17");
}

function private function_54105299(localclientnum) {
  self notify(#"hash_8d07a9f3af1838");
  var_3f79908d = playtagfxset(localclientnum, "fx9_cargo_plane_nav_lights", self);
  self thread function_fa38e4db(localclientnum, var_3f79908d);
}

function private function_fa38e4db(localclientnum, var_3f79908d) {
  self waittill(#"death", #"hash_8d07a9f3af1838", #"hash_5bd6457a6c206a17");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_49365e3b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:xa8>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_ad43fc89(localclientnum);
    return;
  }

  self notify(#"hash_3d54cb0fcf6b56fa");
}

function private function_ad43fc89(localclientnum) {
  self notify(#"hash_23f28ccc6f5f0d8d");
  fxid1 = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_takedown_pcrash_cargo_spark_loop_start", self, "tag_gate_flap_01");
  fxid2 = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_takedown_pcrash_cargo_spark_loop_start", self, "tag_gate_flap_02");
  var_929f5b4d = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_takedown_pcrash_cargo_spark_loop_start", self, "tag_gate_flap_03");
  var_a06276d3 = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_takedown_pcrash_cargo_spark_loop_start", self, "tag_gate_flap_04");
  var_d76364c8 = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_hit3_chase_prop_mist", self, "tag_engine_right_01_null");
  var_84e2bfd4 = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_hit3_chase_prop_mist", self, "tag_engine_left_02_null");
  self thread function_9b722964(localclientnum, fxid1, fxid2, var_929f5b4d, var_a06276d3, var_d76364c8, var_84e2bfd4);
}

function private function_9b722964(localclientnum, fxid1, fxid2, var_929f5b4d, var_a06276d3, var_d76364c8, var_84e2bfd4) {
  self waittill(#"death", #"hash_23f28ccc6f5f0d8d", #"hash_3d54cb0fcf6b56fa");
  stopfx(localclientnum, fxid1);
  stopfx(localclientnum, fxid2);
  stopfx(localclientnum, var_929f5b4d);
  stopfx(localclientnum, var_a06276d3);
  stopfx(localclientnum, var_d76364c8);
  stopfx(localclientnum, var_84e2bfd4);
}

function private function_d7fc17ab(localclientnum) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  self util::waittill_dobj(localclientnum);
  level._fx.var_a736d041 = self;
  var_3f79908d = playtagfxset(localclientnum, "fx9_cargo_plane_nav_lights", self);
  self thread function_5445f621(localclientnum, var_3f79908d);
}

function private function_5445f621(localclientnum, var_3f79908d) {
  self waittill(#"death");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_5f6bf482(localclientnum) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  self util::waittill_dobj(localclientnum);
  level._fx.rc_car = self;
  level._fx.rc_car.var_7351c5a = [];
  level._fx.rc_car.var_7351c5a[1] = &function_5c750f8f;
  level._fx.rc_car.var_7351c5a[2] = &function_a718a890;
  level._fx.rc_car.var_7351c5a[4] = &function_2550ab3e;
  level._fx.rc_car.var_7351c5a[8] = &function_3383f5e2;
  level._fx.rc_car.var_7351c5a[16] = &function_4cfdb901;
  level._fx.rc_car.var_7351c5a[32] = &function_4cfdb901;
  level._fx.rc_car.var_7351c5a[64] = &function_4cfdb901;
  level._fx.rc_car.var_7351c5a[128] = &function_51de3dc2;
}

function private function_b68c2eb9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  changed = fieldname ^ bwastimejump;

  if(!changed) {
    return;
  }

  println("<dev string:xc6>");
  println("<dev string:x116>" + fieldname + "<dev string:x12e>" + bwastimejump + "<dev string:x13c>" + changed + "<dev string:x14b>");
  println("<dev string:xc6>");
  var_67e99fbd = 1;

  while(changed >= var_67e99fbd) {
    if(changed &var_67e99fbd) {
      self thread[[level._fx.rc_car.var_7351c5a[var_67e99fbd]]](binitialsnap, bwastimejump);
    }

    var_67e99fbd <<= 1;
  }

  println("<dev string:xc6>");
}

function private function_d4cb569b(localclientnum, fxid, end_notify) {
  self waittill(#"death", #"fx_death", end_notify);
  stopfx(localclientnum, fxid);

  if(isDefined(self.var_2aa68449)) {
    snd::stop(self.var_2aa68449);
    self.var_2aa68449 = undefined;
  }
}

function private function_5c750f8f(localclientnum, state) {
  self notify("1b2da60ebd37930");
  self endon("1b2da60ebd37930");
  self endon(#"death", #"fx_death");

  if(state & 1) {
    println("<dev string:x150>");
    return;
  }

  println("<dev string:x164>");
}

function private function_a718a890(localclientnum, state) {
  self notify("311048a0bc7152f6");
  self endon("311048a0bc7152f6");
  self endon(#"death", #"fx_death");

  if(state & 2) {
    println("<dev string:x179>");
    fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_td_rc_flashlight", self, "tag_fx_flashlight");
    self thread function_d4cb569b(localclientnum, fxid, "stop_flashlight_fx");
    return;
  }

  println("<dev string:x192>");
  self notify(#"stop_flashlight_fx");
}

function private function_2550ab3e(localclientnum, state) {
  self notify("441a582706e2ec76");
  self endon("441a582706e2ec76");
  self endon(#"death", #"fx_death");

  if(state & 4) {
    println("<dev string:x1ac>");
    self thread function_7dc13ec9(localclientnum);
    return;
  }

  println("<dev string:x1c3>");
  self notify(#"hash_28344e38d8947eea");
  self notify(#"stop_blink_fx");
}

function private function_7dc13ec9(localclientnum) {
  self notify("4486f93a90fd6e7");
  self endon("4486f93a90fd6e7");
  self endon(#"death", #"fx_death", #"hash_28344e38d8947eea");

  if(isDefined(level._fx.cargo_plane)) {
    var_3b16b806 = sqr(400);
    var_87c1e213 = sqr(2500);

    while(true) {
      distsqr = distance2dsquared(self.origin, level._fx.cargo_plane.origin);
      self.fx_interval = (distsqr - var_3b16b806) / (var_87c1e213 - var_3b16b806);
      self.fx_interval = max(0.1, min(1, self.fx_interval));
      self notify(#"stop_blink_fx");
      var_b2b52cb5 = self.fx_interval * 0.5;
      util::server_wait(localclientnum, var_b2b52cb5);
      fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_td_rc_light_red", self, "tag_fx_light_rear");
      self thread function_d4cb569b(localclientnum, fxid, "stop_blink_fx");
      snd::play("wpn_tkd_rcxd_detonate_timer", [self, "tag_fx_light_rear"]);
      util::server_wait(localclientnum, var_b2b52cb5);
    }
  }
}

function private function_3383f5e2(localclientnum, state) {
  self notify("7df042faaef394e8");
  self endon("7df042faaef394e8");
  self endon(#"death", #"fx_death");

  if(state & 8) {
    println("<dev string:x1db>");
    fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_td_rc_light_green", self, "tag_fx_light_rear");
    self thread function_d4cb569b(localclientnum, fxid, "stop_proximity_fx");
    self.var_2aa68449 = snd::play("wpn_tkd_rcxd_detonate_timer_ready", [self, "tag_fx_light_rear"]);
    return;
  }

  println("<dev string:x1f3>");
  self notify(#"stop_proximity_fx");
}

function private function_4cfdb901(localclientnum, state) {
  self notify("6b1164a992a5029b");
  self endon("6b1164a992a5029b");
  self endon(#"death", #"fx_death");

  if(state & 16) {
    println("<dev string:x20c>");
    snd::play("wpn_tkd_rcxd_impact_lt");
    fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_td_rc_damage_light", self, "tag_origin");
    self thread function_d4cb569b(localclientnum, fxid, "stop_damage_light_fx");
  } else {
    println("<dev string:x229>");
    self notify(#"stop_damage_light_fx");
  }

  if(state & 32) {
    println("<dev string:x247>");
    snd::play("wpn_tkd_rcxd_impact_md");
    fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_td_rc_damage_medium", self, "tag_origin");
    self thread function_d4cb569b(localclientnum, fxid, "stop_damage_medium_fx");
  } else {
    println("<dev string:x265>");
    self notify(#"stop_damage_medium_fx");
  }

  if(state & 64) {
    println("<dev string:x284>");
    snd::play("wpn_tkd_rcxd_impact_hv");
    fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_td_rc_damage_heavy", self, "tag_origin");
    self thread function_d4cb569b(localclientnum, fxid, "stop_damage_heavy_fx");
    return;
  }

  println("<dev string:x2a1>");
  self notify(#"stop_damage_heavy_fx");
}

function private function_51de3dc2(localclientnum, state) {
  self notify("6db46cb8b5275540");
  self endon("6db46cb8b5275540");

  if(state & 128) {
    println("<dev string:x2bf>");
    fxid = util::playFXOnTag(localclientnum, "maps/cp_takedown/fx9_td_rc_exp_c4", self, "tag_origin");
    self thread function_d4cb569b(localclientnum, fxid, "stop_death_fx");
    return;
  }

  println("<dev string:x2d3>");
  self notify(#"stop_death_fx");
}

function private function_54f94439(localclientnum) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  self util::waittill_dobj(localclientnum);
  level._fx.var_56d8a882 = self;
}

function private function_979cbf76(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:x2e8>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_bc597003(localclientnum);
    return;
  }

  self notify(#"hash_34ad886fbd5f4182");
}

function private function_bc597003(localclientnum) {
  self notify(#"hash_6391f06161389fb");
  var_3f79908d = playtagfxset(localclientnum, "fx9_bronco_roof_lights", self);
  self thread function_b671b8d8(localclientnum, var_3f79908d);
}

function private function_b671b8d8(localclientnum, var_3f79908d) {
  self waittill(#"death", #"hash_6391f06161389fb", #"hash_34ad886fbd5f4182");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_f6936758(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:x302>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_3ff9983b(localclientnum);
    return;
  }

  self notify(#"hash_22f3d135b4aea2a6");
}

function private function_3ff9983b(localclientnum) {
  self notify(#"hash_26c936f0d412b1c9");
  var_3f79908d = playtagfxset(localclientnum, "fx9_bronco_cab_lights", self);
  self thread function_3d982979(localclientnum, var_3f79908d);
}

function private function_3d982979(localclientnum, var_3f79908d) {
  self waittill(#"death", #"hash_26c936f0d412b1c9", #"hash_22f3d135b4aea2a6");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_a4c9adb9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  function_907070de("<dev string:x31b>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  self notify(#"hash_18d68ed133347a19");

  if(newval) {
    self thread function_40f427f7();
    return;
  }

  self thread function_fe60975();
}

function private function_40f427f7() {
  self notify("33575834ba727e2");
  self endon("33575834ba727e2");
  self endon(#"death", #"hash_18d68ed133347a19");

  if(self postfx::function_556665f2("pstfx_vehicle_rcxd_fade_in") || self postfx::function_556665f2("pstfx_speedblur") || self postfx::function_556665f2("pstfx_rain_loop_tkdn_rccar")) {
    self postfx::stoppostfxbundle("pstfx_vehicle_rcxd_fade_in");
    self postfx::stoppostfxbundle("pstfx_speedblur");
    self postfx::stoppostfxbundle("pstfx_rain_loop_tkdn_rccar");
  }

  self postfx::playpostfxbundle("pstfx_vehicle_rcxd_fade_in");
  namespace_a052577e::function_b233d29e(0.5, 0);
  wait 1;
  self postfx::playpostfxbundle("pstfx_speedblur");
  self postfx::playpostfxbundle("pstfx_rain_loop_tkdn_rccar");
  self thread function_23f6671d();
}

function private function_fe60975() {
  self notify("244e3efdeb0cf8b6");
  self endon("244e3efdeb0cf8b6");
  self endon(#"death", #"hash_18d68ed133347a19");
  self postfx::stoppostfxbundle("pstfx_speedblur");
  self postfx::stoppostfxbundle("pstfx_rain_loop_tkdn_rccar");
  self postfx::playpostfxbundle("pstfx_vehicle_rcxd_fade_out");
  namespace_a052577e::function_b233d29e(0.5, 0);
}

function private function_23f6671d() {
  self notify("4e8916e051945f74");
  self endon("4e8916e051945f74");
  self endon(#"death", #"hash_18d68ed133347a19");

  if(!isDefined(level._fx.rc_car)) {
    return;
  }

  self postfx::function_c8b5f318("pstfx_speedblur", "Inner Mask", 0.15);
  self postfx::function_c8b5f318("pstfx_speedblur", "Outer Mask", 0.8);
  self postfx::function_c8b5f318("pstfx_speedblur", "Blur", 0);
  self postfx::function_c8b5f318("pstfx_rain_loop_tkdn_rccar", "Sprite Count Squash", 1);
  setDvar(#"hash_252e699c41531f1a", 2);
  setDvar(#"r_motionblurstrength", 0.2);

  while(true) {
    level._fx.rc_car.velocity = function_72c0c267(level._fx.rc_car getvelocity(), level._fx.rc_car.angles);
    scalar = level._fx.rc_car.velocity[0] / 1100;
    scalar = max(0, min(1, scalar));
    var_75128a58 = 1 - scalar;
    var_69954662 = level._fx.rc_car.velocity[1] / 20;
    var_69954662 = max(-1, min(1, var_69954662));
    var_69954662 *= 0.5;
    var_50bfab0d = level._fx.rc_car.origin + anglesToForward(level._fx.rc_car.angles) * 100 + (0, 0, 15);
    screenpos = self function_a6a764a9(var_50bfab0d, 1);

    if(isDefined(screenpos)) {
      self postfx::function_c8b5f318("pstfx_speedblur", "X Offset", screenpos[0]);
      self postfx::function_c8b5f318("pstfx_speedblur", "Y Offset", screenpos[1]);
      self postfx::function_c8b5f318("pstfx_rain_loop_tkdn_rccar", "Origin X", screenpos[0] + var_69954662);
      self postfx::function_c8b5f318("pstfx_rain_loop_tkdn_rccar", "Origin Y", screenpos[1]);
    }

    self postfx::function_c8b5f318("pstfx_speedblur", "Blur", 0.05 * sqr(scalar));
    self postfx::function_c8b5f318("pstfx_rain_loop_tkdn_rccar", "Sprite Count Squash", sqr(var_75128a58));
    waitframe(1);
  }
}

function private function_92a58466(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    fxid = util::playFXOnTag(fieldname, "maps/cp_takedown/fx9_takedown_rc_view_wisp", self, "tag_origin");
    self thread function_86203754(fieldname, fxid);
    return;
  }

  self notify(#"hash_18ccf59470efbae9");
}

function private function_86203754(localclientnum, fxid) {
  self waittill(#"death", #"hash_18ccf59470efbae9");
  stopfx(localclientnum, fxid);
}

function private function_f14b954c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_907070de("<dev string:x32f>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  self notify(#"hash_6df70d945404449d");

  if(newval) {
    if(self postfx::function_556665f2("pstfx_vehicle_rcxd_fade_in")) {
      self postfx::stoppostfxbundle("pstfx_vehicle_rcxd_fade_in");
    }

    self postfx::playpostfxbundle("pstfx_vehicle_rcxd_fade_in");
    namespace_a052577e::function_b233d29e(0.5, 0);
    return;
  }

  if(self postfx::function_556665f2("pstfx_vehicle_rcxd_fade_out")) {
    self postfx::stoppostfxbundle("pstfx_vehicle_rcxd_fade_out");
  }

  self postfx::playpostfxbundle("pstfx_vehicle_rcxd_fade_out");
  namespace_a052577e::function_b233d29e(0.5, 0);
}

function private function_636d3664(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_907070de("<dev string:x348>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(self postfx::function_556665f2("pstfx_rooftop_slide")) {
    self postfx::stoppostfxbundle("pstfx_rooftop_slide");
  }

  if(newval) {
    self postfx::playpostfxbundle("pstfx_rooftop_slide");
  }
}

function private function_d1374213(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      self function_f6e99a8d("rob_p9_cp_takedown_snipercam_blood_henchman");
      break;
    case 1:
      self playrenderoverridebundle("rob_p9_cp_takedown_snipercam_blood_henchman");
      break;
    case 2:
      self function_f6e99a8d("rob_p9_cp_takedown_snipercam_blood_splatter");
      break;
    case 3:
      self playrenderoverridebundle("rob_p9_cp_takedown_snipercam_blood_splatter");
      break;
  }
}

function private function_907070de(var_55ee7def, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  println("<dev string:x364>" + var_55ee7def + "<dev string:x374>" + localclientnum + "<dev string:x38b>" + oldval + "<dev string:x12e>" + newval + "<dev string:x399>" + bnewent + "<dev string:x3a8>" + binitialsnap + "<dev string:x3bc>" + fieldname + "<dev string:x3cd>" + bwastimejump);
}