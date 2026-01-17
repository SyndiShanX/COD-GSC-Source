/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\mechz.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace mechz;

function autoexec main() {
  clientfield::register("actor", "mechz_ft", 5000, 1, "int", &mechzclientutils::mechzflamethrowercallback, 0, 0);
  clientfield::register("actor", "mechz_faceplate_detached", 5000, 1, "int", &mechzclientutils::mechz_detach_faceplate, 0, 0);
  clientfield::register("actor", "mechz_powercap_detached", 5000, 1, "int", &mechzclientutils::mechz_detach_powercap, 0, 0);
  clientfield::register("actor", "mechz_claw_detached", 5000, 1, "int", &mechzclientutils::mechz_detach_claw, 0, 0);
  clientfield::register("actor", "mechz_115_gun_firing", 5000, 1, "int", &mechzclientutils::mechz_115_gun_muzzle_flash, 0, 0);
  clientfield::register("actor", "mechz_rknee_armor_detached", 5000, 1, "int", &mechzclientutils::mechz_detach_rknee_armor, 0, 0);
  clientfield::register("actor", "mechz_lknee_armor_detached", 5000, 1, "int", &mechzclientutils::mechz_detach_lknee_armor, 0, 0);
  clientfield::register("actor", "mechz_rshoulder_armor_detached", 5000, 1, "int", &mechzclientutils::mechz_detach_rshoulder_armor, 0, 0);
  clientfield::register("actor", "mechz_lshoulder_armor_detached", 5000, 1, "int", &mechzclientutils::mechz_detach_lshoulder_armor, 0, 0);
  clientfield::register("actor", "mechz_headlamp_off", 5000, 2, "int", &mechzclientutils::mechz_headlamp_off, 0, 0);
  clientfield::register("actor", "mechz_face", 1, 3, "int", &mechzclientutils::mechzfacecallback, 0, 0);
  ai::add_archetype_spawn_function("mechz", &mechzclientutils::mechzspawn);
  level._mechz_face = [];
  level._mechz_face[1] = "ai_face_zombie_generic_attack_1";
  level._mechz_face[2] = "ai_face_zombie_generic_death_1";
  level._mechz_face[3] = "ai_face_zombie_generic_idle_1";
  level._mechz_face[4] = "ai_face_zombie_generic_pain_1";
}

function autoexec precache() {
  level._effect["fx_mech_wpn_flamethrower"] = "dlc1/castle/fx_mech_wpn_flamethrower";
  level._effect["fx_mech_dmg_armor_face"] = "dlc1/castle/fx_mech_dmg_armor_face";
  level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
  level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
  level._effect["fx_wpn_115_muz"] = "dlc1/castle/fx_wpn_115_muz";
  level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
  level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
  level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
  level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
  level._effect["fx_mech_head_light"] = "dlc1/castle/fx_mech_head_light";
  level._effect["fx_mech_dmg_sparks"] = "dlc1/castle/fx_mech_dmg_sparks";
  level._effect["fx_mech_dmg_knee_sparks"] = "dlc1/castle/fx_mech_dmg_knee_sparks";
  level._effect["fx_mech_dmg_sparks"] = "dlc1/castle/fx_mech_dmg_sparks";
  level._effect["fx_mech_foot_step"] = "dlc1/castle/fx_mech_foot_step";
  level._effect["fx_mech_light_dmg"] = "dlc1/castle/fx_mech_light_dmg";
  level._effect["fx_mech_foot_step_steam"] = "dlc1/castle/fx_mech_foot_step_steam";
  level._effect["fx_mech_dmg_body_light"] = "dlc1/castle/fx_mech_dmg_body_light";
}

#namespace mechzclientutils;

function private mechzspawn(localclientnum) {
  level._footstepcbfuncs[self.archetype] = &mechzprocessfootstep;
  level thread mechzsndcontext(self);
  self.headlight_fx = playFXOnTag(localclientnum, level._effect["fx_mech_head_light"], self, "tag_headlamp_FX");
  self.headlamp_on = 1;
}

function mechzsndcontext(mechz) {
  wait(1);
  if(isDefined(mechz)) {
    mechz setsoundentcontext("movement", "normal");
  }
}

function mechzprocessfootstep(localclientnum, pos, surface, notetrack, bone) {
  e_player = getlocalplayer(localclientnum);
  n_dist = distancesquared(pos, e_player.origin);
  n_mechz_dist = 1000000;
  if(n_mechz_dist > 0) {
    n_scale = (n_mechz_dist - n_dist) / n_mechz_dist;
  } else {
    return;
  }
  if(n_scale > 1 || n_scale < 0) {
    return;
  }
  if(n_scale <= 0.01) {
    return;
  }
  earthquake_scale = n_scale * 0.1;
  if(earthquake_scale > 0.01) {
    e_player earthquake(earthquake_scale, 0.1, pos, n_dist);
  }
  if(n_scale <= 1 && n_scale > 0.8) {
    e_player playrumbleonentity(localclientnum, "shotgun_fire");
  } else {
    if(n_scale <= 0.8 && n_scale > 0.4) {
      e_player playrumbleonentity(localclientnum, "damage_heavy");
    } else {
      e_player playrumbleonentity(localclientnum, "reload_small");
    }
  }
  fx = playFXOnTag(localclientnum, level._effect["fx_mech_foot_step"], self, bone);
  if(bone == "j_ball_le") {
    steam_bone = "tag_foot_steam_le";
  } else {
    steam_bone = "tag_foot_steam_ri";
  }
  steam_fx = playFXOnTag(localclientnum, level._effect["fx_mech_foot_step_steam"], self, steam_bone);
}

function private mechzflamethrowercallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (newvalue) {
    case 1: {
      self.fire_beam_id = beamlaunch(localclientnum, self, "tag_flamethrower_fx", undefined, "none", "flamethrower_beam_3p_zm_mechz");
      self playSound(0, "wpn_flame_thrower_start_mechz");
      self.sndloopid = self playLoopSound("wpn_flame_thrower_loop_mechz");
      break;
    }
    case 0: {
      self notify("stopflamethrower");
      if(isDefined(self.fire_beam_id)) {
        beamkill(localclientnum, self.fire_beam_id);
        self playSound(0, "wpn_flame_thrower_stop_mechz");
        self stoploopsound(self.sndloopid);
      }
      break;
    }
  }
}

function mechz_detach_faceplate(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  pos = self gettagorigin("j_faceplate");
  ang = self gettagangles("j_faceplate");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_zom_mech_faceplate", pos, ang, self.origin, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor_face"], self, "j_faceplate");
  self setsoundentcontext("movement", "loud");
  self playSound(0, "zmb_ai_mechz_faceplate");
}

function mechz_detach_powercap(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  pos = self gettagorigin("tag_powersupply");
  ang = self gettagangles("tag_powersupply");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_zom_mech_powersupply_cap", pos, ang, self.origin, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "tag_powersupply");
  self playSound(0, "zmb_ai_mechz_destruction");
  self.mechz_powercore_fx = playFXOnTag(localclientnum, level._effect["fx_mech_dmg_body_light"], self, "tag_powersupply");
}

function mechz_detach_claw(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(level.mechz_detach_claw_override)) {
    self[[level.mechz_detach_claw_override]](localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump);
    return;
  }
  pos = self gettagorigin("tag_gun_spin");
  ang = self gettagangles("tag_gun_spin");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_zom_mech_gun_barrel", pos, ang, self.origin, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "tag_gun_spin");
  self playSound(0, "zmb_ai_mechz_destruction");
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "tag_gun_spin");
}

function mechz_115_gun_muzzle_flash(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  playFXOnTag(localclientnum, level._effect["fx_wpn_115_muz"], self, "tag_gun_barrel2");
}

function mechz_detach_rknee_armor(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  pos = self gettagorigin("j_knee_attach_ri");
  ang = self gettagangles("j_knee_attach_ri");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_knee_right", pos, ang, pos, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_knee_attach_ri");
  self playSound(0, "zmb_ai_mechz_destruction");
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_knee_sparks"], self, "j_knee_attach_ri");
}

function mechz_detach_lknee_armor(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  pos = self gettagorigin("j_knee_attach_le");
  ang = self gettagangles("j_knee_attach_le");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_knee_left", pos, ang, pos, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_knee_attach_le");
  self playSound(0, "zmb_ai_mechz_destruction");
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_knee_sparks"], self, "j_knee_attach_le");
}

function mechz_detach_rshoulder_armor(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  pos = self gettagorigin("j_shoulderarmor_ri");
  ang = self gettagangles("j_shoulderarmor_ri");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_shoulder_right", pos, ang, pos, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_shoulderarmor_ri");
  self playSound(0, "zmb_ai_mechz_destruction");
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "j_shoulderarmor_ri");
}

function mechz_detach_lshoulder_armor(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  pos = self gettagorigin("j_shoulderarmor_le");
  ang = self gettagangles("j_shoulderarmor_le");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_shoulder_left", pos, ang, pos, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_shoulderarmor_le");
  self playSound(0, "zmb_ai_mechz_destruction");
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "j_shoulderarmor_le");
}

function mechz_headlamp_off(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(self.headlamp_on === 1 && newvalue != 0 && isDefined(self.headlight_fx)) {
    stopfx(localclientnum, self.headlight_fx);
    self.headlamp_on = 0;
    if(newvalue == 2) {
      playFXOnTag(localclientnum, level._effect["fx_mech_foot_step"], self, "tag_headlamp_fx");
    }
  }
}

function private mechzfacecallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    if(isDefined(self.prevfaceanim)) {
      self clearanim(self.prevfaceanim, 0.2);
    }
    faceanim = level._mechz_face[newvalue];
    self setanim(faceanim, 1, 0.2, 1);
    self.prevfaceanim = faceanim;
  }
}