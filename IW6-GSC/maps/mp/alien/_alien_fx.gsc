/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_alien_fx.gsc
***************************************/

#include maps\mp\alien\_utility;

main() {
  init_fx();
}

init_fx() {
  level._effect["vfx_scrnfx_alien_spitter_mist"] = LoadFX("vfx/gameplay/screen_effects/vfx_scrnfx_alien_spitter_mist");
  level._effect["vfx_scrnfx_alien_blood"] = LoadFX("vfx/gameplay/screen_effects/vfx_scrnfx_alien_blood");
  level._effect["vfx_scrnfx_tocam_slidedust_m"] = LoadFX("vfx/gameplay/screen_effects/vfx_scrnfx_tocam_slidedust_m");
  level._effect["vfx_melee_blood_spray"] = LoadFX("vfx/gameplay/screen_effects/vfx_melee_blood_spray");
  level._effect["vfx_blood_hit_left"] = LoadFX("vfx/gameplay/screen_effects/vfx_blood_hit_left");
  level._effect["vfx_blood_hit_right"] = LoadFX("vfx/gameplay/screen_effects/vfx_blood_hit_right");
  level._effect["vfx_alien_spitter_hit_left"] = LoadFX("vfx/gameplay/screen_effects/vfx_alien_spitter_hit_left");
  level._effect["vfx_alien_spitter_hit_right"] = LoadFX("vfx/gameplay/screen_effects/vfx_alien_spitter_hit_right");
  level._effect["vfx_alien_spitter_hit_center"] = LoadFX("vfx/gameplay/screen_effects/vfx_alien_spitter_hit_center");
}

alien_fire_on() {
  if(!isDefined(self.is_burning)) {
    self.is_burning = 0;
  }
  self.is_burning++;

  if(self.is_burning == 1) {
    self SetScriptablePartState("body", "burning");

  }
}

alien_fire_off() {
  self.is_burning--;
  if(self.is_burning > 0) {
    return;
  }
  self.is_burning = undefined;
  self notify("fire_off");
  self SetScriptablePartState("body", "normal");
}

disable_fx_on_death() {
  self SetScriptablePartState("body", "normal");
}

fx_stun_damage() {
  if(self get_alien_type() == "minion") {
    return;
  }
  self endon("death");
  self SetScriptablePartState("body", "shocked");
  wait 0.5;
  if(IsAlive(self)) {
    self SetScriptablePartState("body", "normal");
  }
}

alien_cloak_fx_on() {
  if(!isDefined(self.is_cloaking)) {
    self.is_cloaking = 0;
  }

  self playSound("alien_teleport");
  self.is_cloaking++;

  if(self.is_cloaking == 1) {
    self SetScriptablePartState("body", "normal");
  }
}

alien_cloak_fx_off() {
  self.is_cloaking--;
  if(self.is_cloaking > 0) {
    return;
  }
  self playSound("alien_teleport_appear");

  self.is_cloaking = undefined;
  self SetScriptablePartState("body", "normal");
}