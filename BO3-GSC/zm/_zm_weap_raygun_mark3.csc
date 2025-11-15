/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_raygun_mark3.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _zm_weap_raygun_mark3;

function autoexec __init__sytem__() {
  system::register("zm_weap_raygun_mark3", & __init__, undefined, undefined);
}

function __init__() {
  level.w_raygun_mark3 = getweapon("raygun_mark3");
  level.w_raygun_mark3_upgraded = getweapon("raygun_mark3_upgraded");
  level._effect["raygun_ai_slow_vortex_small"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_sm_hit";
  level._effect["raygun_ai_slow_vortex_large"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_lg_hit";
  level._effect["raygun_slow_vortex_small"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_sm";
  level._effect["raygun_slow_vortex_large"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_lg";
  clientfield::register("scriptmover", "slow_vortex_fx", 12000, 2, "int", & slow_vortex_fx, 0, 0);
  clientfield::register("actor", "ai_disintegrate", 12000, 1, "int", & ai_disintegrate, 0, 0);
  clientfield::register("vehicle", "ai_disintegrate", 12000, 1, "int", & ai_disintegrate, 0, 0);
  clientfield::register("actor", "ai_slow_vortex_fx", 12000, 2, "int", & ai_slow_vortex_fx, 0, 0);
  clientfield::register("vehicle", "ai_slow_vortex_fx", 12000, 2, "int", & ai_slow_vortex_fx, 0, 0);
  visionset_mgr::register_visionset_info("raygun_mark3_vortex_visionset", 1, 30, undefined, "zm_idgun_vortex");
  visionset_mgr::register_overlay_info_style_speed_blur("raygun_mark3_vortex_blur", 1, 30, 0.08, 0.75, 0.9);
  duplicate_render::set_dr_filter_framebuffer("dissolve", 10, "dissolve_on", undefined, 0, "mc/mtl_c_zom_dlc3_zombie_dissolve_base", 0);
  callback::on_localclient_connect( & monitor_raygun_mark3);
}

function is_beam_raygun(weapon) {
  if(weapon === level.w_raygun_mark3 || weapon === level.w_raygun_mark3_upgraded) {
    return true;
  }
  return false;
}

function monitor_raygun_mark3(n_local_client) {
  player = getlocalplayer(n_local_client);
  player endon("death");
  while(true) {
    player waittill("weapon_change", weapon);
    if(is_beam_raygun(weapon)) {
      player mapshaderconstant(n_local_client, 0, "scriptVector2", 0, 1, 0, 0);
      player thread glow_monitor(n_local_client);
    } else {
      player notify("glow_monitor");
      player mapshaderconstant(n_local_client, 0, "scriptVector2", 0, 0, 0, 0);
    }
  }
}

function glow_monitor(n_local_client) {
  self notify("glow_monitor");
  self endon("glow_monitor");
  self endon("death");
  while(true) {
    self waittill_notetrack("clamps_open");
    self mapshaderconstant(n_local_client, 0, "scriptVector2", 0, 0, 0, 0);
    self waittill_notetrack("clamps_close");
    self mapshaderconstant(n_local_client, 0, "scriptVector2", 0, 1, 0, 0);
  }
}

function waittill_notetrack(str_notetrack) {
  self endon("glow_monitor");
  self endon("death");
  while(true) {
    self waittill("notetrack", str_note);
    if(str_note == str_notetrack) {
      return;
    }
  }
}

function slow_vortex_fx(n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump) {
  if(isDefined(self.fx_slow_vortex)) {
    killfx(n_local_client, self.fx_slow_vortex);
  }
  if(n_new) {
    if(n_new == 1) {
      self.fx_slow_vortex = playFXOnTag(n_local_client, level._effect["raygun_slow_vortex_small"], self, "tag_origin");
    } else {
      self.fx_slow_vortex = playFXOnTag(n_local_client, level._effect["raygun_slow_vortex_large"], self, "tag_origin");
      self playrumbleonentity(n_local_client, "artillery_rumble");
    }
    self thread vortex_shake_and_rumble(n_local_client, n_new);
  }
}

function ai_slow_vortex_fx(n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump) {
  if(n_new) {
    if(n_new == 1) {
      self.fx_ai_slow_vortex = playFXOnTag(n_local_client, level._effect["raygun_ai_slow_vortex_small"], self, "J_SpineUpper");
      self thread zombie_blacken(n_local_client, 1);
    } else {
      self.fx_ai_slow_vortex = playFXOnTag(n_local_client, level._effect["raygun_ai_slow_vortex_large"], self, "J_SpineUpper");
      self thread zombie_blacken(n_local_client, 1);
    }
  } else if(isDefined(self.fx_ai_slow_vortex)) {
    killfx(n_local_client, self.fx_ai_slow_vortex);
    self thread zombie_blacken(n_local_client, 0);
  }
}

function vortex_shake_and_rumble(n_local_client, n_damage_level) {
  self notify("vortex_shake_and_rumble");
  self endon("vortex_shake_and_rumble");
  self endon("entity_shutdown");
  if(n_damage_level == 1) {
    str_rumble = "raygun_mark3_vortex_sm";
  } else {
    str_rumble = "raygun_mark3_vortex_lg";
  }
  while(isDefined(self)) {
    self playrumbleonentity(n_local_client, str_rumble);
    wait(0.083);
  }
}

function zombie_blacken(n_local_client, b_blacken) {
  self endon("entity_shutdown");
  if(!isDefined(self.n_blacken)) {
    self.n_blacken = 0;
  }
  if(b_blacken) {
    while(isDefined(self) && self.n_blacken < 1) {
      self.n_blacken = self.n_blacken + 0.2;
      self mapshaderconstant(n_local_client, 0, "scriptVector0", self.n_blacken);
      wait(0.05);
    }
  } else {
    while(isDefined(self) && self.n_blacken > 0) {
      self.n_blacken = self.n_blacken - 0.2;
      self mapshaderconstant(n_local_client, 0, "scriptVector0", self.n_blacken);
      wait(0.05);
    }
  }
}

function ai_disintegrate(n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump) {
  self endon("entity_shutdown");
  self duplicate_render::set_dr_flag("dissolve_on", n_new);
  self duplicate_render::update_dr_filters(n_local_client);
  self.n_dissolve = 1;
  while(isDefined(self) && self.n_dissolve > 0) {
    self mapshaderconstant(n_local_client, 0, "scriptVector0", self.n_dissolve);
    self.n_dissolve = self.n_dissolve - 0.0166;
    wait(0.0166);
  }
  if(isDefined(self)) {
    self mapshaderconstant(n_local_client, 0, "scriptVector0", 0);
  }
}