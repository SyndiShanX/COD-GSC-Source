/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_eye_candy.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_eye_candy;

function autoexec __init__sytem__() {
  system::register("zm_bgb_eye_candy", &__init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_eye_candy", "activated");
  visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_1", 21000, 31, undefined, "zm_bgb_candy_yellowz");
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_1", 21000, 1, "pstfx_zm_bgb_eye_candy_yellow");
  duplicate_render::set_dr_filter_framebuffer("e_c_1", 35, "eye_candy_1", undefined, 0, "mc/zombie_candy_mode_yellow", 0);
  visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_2", 21000, 31, undefined, "zm_bgb_candy_greenz");
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_2", 21000, 1, "pstfx_zm_bgb_eye_candy_green");
  duplicate_render::set_dr_filter_framebuffer("e_c_2", 35, "eye_candy_2", undefined, 0, "mc/zombie_candy_mode_green", 0);
  visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_3", 21000, 31, undefined, "zm_bgb_candy_purplez");
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_3", 21000, 1, "pstfx_zm_bgb_eye_candy_purple");
  duplicate_render::set_dr_filter_framebuffer("e_c_3", 35, "eye_candy_3", undefined, 0, "mc/zombie_candy_mode_purple", 0);
  visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_4", 21000, 31, undefined, "zm_bgb_candy_bluez");
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_4", 21000, 1, "pstfx_zm_bgb_eye_candy_blue");
  duplicate_render::set_dr_filter_framebuffer("e_c_4", 35, "eye_candy_4", undefined, 0, "mc/zombie_candy_mode_blue", 0);
  n_bits = getminbitcountfornum(5);
  clientfield::register("toplayer", "eye_candy_render", 21000, n_bits, "int", &function_7021da92, 0, 0);
  clientfield::register("actor", "eye_candy_active", 21000, 1, "int", &function_697cc62, 0, 0);
  clientfield::register("vehicle", "eye_candy_active", 21000, 1, "int", &function_697cc62, 0, 0);
}

function function_7021da92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval > 0) {
    self.var_73021e86 = "eye_candy_" + newval;
    self function_a358ec33(localclientnum);
  } else {
    self function_c1a20a24(localclientnum);
  }
}

function function_a358ec33(localclientnum) {
  var_307a62d0 = getEntArray(localclientnum);
  foreach(entity in var_307a62d0) {
    if(isDefined(entity.var_d8bd114f) && entity.var_d8bd114f && isDefined(self.var_73021e86)) {
      entity function_56029f33(localclientnum, 1, self.var_73021e86);
    }
  }
}

function function_c1a20a24(localclientnum) {
  var_307a62d0 = getEntArray(localclientnum);
  foreach(entity in var_307a62d0) {
    if(isDefined(entity.var_d8bd114f) && entity.var_d8bd114f) {
      entity function_56029f33(localclientnum, 0);
    }
  }
  self.var_73021e86 = undefined;
}

function function_697cc62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  level flagsys::wait_till("duplicaterender_registry_ready");
  assert(isDefined(self), "");
  if(newval == 0) {
    self.var_d8bd114f = 0;
    self function_56029f33(localclientnum, 0);
  } else {
    self.var_d8bd114f = 1;
    player = getlocalplayer(localclientnum);
    if(isDefined(player.var_73021e86)) {
      self function_56029f33(localclientnum, 1, player.var_73021e86);
    }
  }
}

function function_56029f33(localclientnum, b_enabled, var_73021e86) {
  if(isDefined(self.var_73021e86)) {
    self duplicate_render::set_dr_flag(self.var_73021e86, 0);
    self.var_73021e86 = undefined;
  }
  if(isDefined(b_enabled) && b_enabled && isDefined(var_73021e86)) {
    self duplicate_render::set_dr_flag(var_73021e86, 1);
    self.var_73021e86 = var_73021e86;
  }
  self duplicate_render::update_dr_filters(localclientnum);
}