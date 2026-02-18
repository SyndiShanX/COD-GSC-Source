/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_d85a41a4c7247ce.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace namespace_fa1c4f0a;

function event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "" + # "portal", 1, 1, "int", &portal_fx, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_2a7da9a87ecef87b", 1, 1, "int", &function_36ab0d37, 0, 0);
  clientfield::register("scriptmover", "" + # "payload_teleport", 1, 2, "int", &function_5884461e, 0, 0);
  clientfield::register("toplayer", "" + # "portal_blur", 1, 1, "int", &function_fa7a206b, 0, 0);
  clientfield::register("scriptmover", "" + # "portal_shockwave", 1, 1, "counter", &function_96636479, 0, 0);
  clientfield::register("vehicle", "" + # "teleport_trail", 1, 1, "int", &function_691412b4, 0, 0);
  clientfield::register("vehicle", "" + # "payload_health", 1, 1, "counter", &function_612a9925, 0, 0);
  clientfield::register("vehicle", "" + # "payload_activate", 1, 1, "int", &payload_activate, 0, 0);
  clientfield::register("vehicle", "" + # "payload_scan", 1, 1, "counter", &payload_scan, 0, 0);
  clientfield::register("vehicle", "" + # "payload_running", 1, 1, "int", &function_89fa474d, 0, 0);
  clientfield::register("vehicle", "" + # "payload_enter", 1, 1, "int", &function_41bc60b6, 0, 0);
  callback::on_vehicle_spawned(&on_vehicle_spawned);
  util::waitforclient(0);
}

function private on_vehicle_spawned(localclientnum) {
  if(self.vehicletype === # "hash_d069dee6a0076c8") {
    if(self function_b835102b()) {
      self function_3f24c5a(1);
    }

    self.stunnedcallback = &stunnedcallback;
    self function_1f0c7136(0);
    self setanim("p9_fxanim_sv_payload_atv_static_anim");
  }
}

function function_41bc60b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(isDefined(self gettagorigin("tag_body_animate"))) {
      self.var_ced8ba73 = function_239993de(fieldname, "sr/fx9_obj_payload_aether_portal_veh_interact_lg", self, "tag_body_animate");
    }

    return;
  }

  if(isDefined(self.var_ced8ba73)) {
    stopfx(fieldname, self.var_ced8ba73);
    self.var_ced8ba73 = undefined;
  }
}

function function_89fa474d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(isDefined(self.var_956e61df)) {
      killfx(fieldname, self.var_956e61df);
      self.var_956e61df = undefined;
    }

    if(isDefined(self gettagorigin("tag_body_animate"))) {
      self.var_bd74ce24 = function_239993de(fieldname, "sr/fx9_veh_payload_light_side", self, "tag_body_animate");
    }

    if(isDefined(self.var_cba3a992)) {
      killfx(fieldname, self.var_cba3a992);
      self.var_cba3a992 = undefined;
    }

    if(isDefined(self gettagorigin("tag_fx_headlight_left"))) {
      self.var_d811dda6 = function_239993de(fieldname, "sr/fx9_veh_payload_light_top_green", self, "tag_fx_headlight_left");
    }

    if(isDefined(self.var_e818b36c)) {
      stopfx(fieldname, self.var_e818b36c);
      self.var_e818b36c = undefined;
    }

    wait 0.25;

    if(isDefined(self.var_e818b36c)) {
      stopfx(fieldname, self.var_e818b36c);
      self.var_e818b36c = undefined;
    }

    return;
  }

  if(isDefined(self.var_bd74ce24)) {
    killfx(fieldname, self.var_bd74ce24);
    self.var_bd74ce24 = undefined;
  }

  if(isDefined(self gettagorigin("tag_body_animate"))) {
    self.var_956e61df = function_239993de(fieldname, "sr/fx9_veh_payload_light_brake_side", self, "tag_body_animate");
  }

  if(isDefined(self.var_d811dda6)) {
    killfx(fieldname, self.var_d811dda6);
    self.var_d811dda6 = undefined;
  }

  if(isDefined(self gettagorigin("tag_fx_headlight_left"))) {
    self.var_cba3a992 = function_239993de(fieldname, "sr/fx9_veh_payload_light_top_red", self, "tag_fx_headlight_left");
  }
}

function payload_scan(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(isalive(self)) {
    self clearanim("p9_fxanim_sv_payload_atv_loop_anim", 0.2);
  }

  wait 0.15;

  if(isalive(self)) {
    self setanim("p9_fxanim_sv_payload_atv_extend_anim");
  }

  wait getanimlength("p9_fxanim_sv_payload_atv_extend_anim") + 0.5;

  if(isalive(self)) {
    self clearanim("p9_fxanim_sv_payload_atv_extend_anim", 0.2);
  }

  wait 0.15;

  if(isalive(self)) {
    self setanim("p9_fxanim_sv_payload_atv_extend_loop_anim");
  }

  wait 1;

  if(isalive(self)) {
    self clearanim("p9_fxanim_sv_payload_atv_extend_loop_anim", 0.2);
  }

  wait 0.15;

  if(isalive(self)) {
    self setanim("p9_fxanim_sv_payload_atv_retract_anim");
  }

  wait getanimlength("p9_fxanim_sv_payload_atv_retract_anim") + 0.5;

  if(isalive(self)) {
    self clearanim("p9_fxanim_sv_payload_atv_retract_anim", 0.25);
  }

  wait 0.15;

  if(isalive(self)) {
    self setanim("p9_fxanim_sv_payload_atv_loop_anim");
  }
}

function payload_activate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(isalive(self)) {
    self clearanim("p9_fxanim_sv_payload_atv_static_anim", 0.2);
  }

  wait 0.15;

  if(isalive(self)) {
    self setanim("p9_fxanim_sv_payload_atv_initiate_anim");
  }

  wait getanimlength("p9_fxanim_sv_payload_atv_initiate_anim") + 1;

  if(isalive(self)) {
    self clearanim("p9_fxanim_sv_payload_atv_initiate_anim", 0.2);
  }

  wait 0.15;

  if(isalive(self)) {
    self setanim("p9_fxanim_sv_payload_atv_loop_anim");
    v_org = self gettagorigin("tag_camera_d0");

    if(isDefined(v_org)) {
      function_239993de(bwastimejump, "sr/fx9_veh_payload_light_camera", self, "tag_camera_d0");
    }
  }
}

function function_612a9925(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_1f0c7136(3);
}

function stunnedcallback(localclientnum, val) {
  self setstunned(val);
}

function function_5884461e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    function_239993de(fieldname, "sr/fx9_obj_payload_teleport_depart", self, "tag_origin");
    return;
  }

  if(bwastimejump == 2) {
    self.var_c25fe395 = util::playFXOnTag(fieldname, "sr/fx9_obj_payload_aether_portal_pillar", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_c25fe395)) {
    stopfx(fieldname, self.var_c25fe395);
    self.var_c25fe395 = undefined;
  }
}

function function_96636479(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(bwastimejump, "sr/fx9_obj_payload_aether_portal_exp_buildup", self, "tag_origin");
}

function function_fa7a206b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {
    if(function_65b9eb0f(fieldname)) {
      return;
    }

    self postfx::playpostfxbundle(#"pstfx_speedblur");
    self function_116b95e5(#"pstfx_speedblur", #"inner mask", 0.3);
    self function_116b95e5(#"pstfx_speedblur", #"outer mask", 0.8);
    self thread function_d233fb1f();
    return;
  }

  if(function_65b9eb0f(fieldname)) {
    return;
  }

  self notify(#"stop_blur");
  wait 0.5;
  self function_116b95e5(#"pstfx_speedblur", #"blur", 0);
  self postfx::exitpostfxbundle(#"pstfx_speedblur");
}

function function_d233fb1f() {
  self endon(#"death", #"disconnect", #"stop_blur");
  var_9b8a1091 = 0.01;

  while(true) {
    self function_116b95e5(#"pstfx_speedblur", #"blur", var_9b8a1091);
    wait 0.08;

    if(var_9b8a1091 < 0.3) {
      var_9b8a1091 += 0.01;
    }
  }
}

function portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_ae8b25ed = util::playFXOnTag(fieldname, "sr/fx9_obj_payload_aether_portal", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_ae8b25ed)) {
    stopfx(fieldname, self.var_ae8b25ed);
  }
}

function function_36ab0d37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_2d3c8170 = util::playFXOnTag(fieldname, "sr/fx9_obj_payload_aether_rift", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_2d3c8170)) {
    stopfx(fieldname, self.var_2d3c8170);
  }

  function_239993de(fieldname, "sr/fx9_obj_payload_aether_rift_close", self, "tag_origin");
}

function function_691412b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {
    if(isDefined(self gettagorigin("tag_body_animate"))) {
      self.var_942f8233 = util::playFXOnTag(fieldname, "sr/fx9_obj_payload_aether_portal_veh_trail", self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_942f8233)) {
    stopfx(fieldname, self.var_942f8233);
  }

  if(isDefined(self gettagorigin("tag_body_animate"))) {
    self.var_e818b36c = util::playFXOnTag(fieldname, "sr/fx9_obj_payload_aether_portal_veh_trail_impact", self, "tag_origin");
  }
}