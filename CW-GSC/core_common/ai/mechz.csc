/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\mechz.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace mechz;

function private autoexec __init__system__() {
  system::register(#"mechz", &init, undefined, undefined, undefined);
}

function init() {
  clientfield::register("actor", "mechz_ft", 1, 1, "int", &mechzclientutils::mechzflamethrowercallback, 0, 0);
  clientfield::register("actor", "mechz_faceplate_detached", 1, 1, "int", &mechzclientutils::mechz_detach_faceplate, 0, 0);
  clientfield::register("actor", "mechz_powercap_detached", 1, 1, "int", &mechzclientutils::mechz_detach_powercap, 0, 0);
  clientfield::register("actor", "mechz_claw_detached", 1, 1, "int", &mechzclientutils::mechz_detach_claw, 0, 0);
  clientfield::register("actor", "mechz_115_gun_firing", 1, 1, "int", &mechzclientutils::mechz_115_gun_muzzle_flash, 0, 0);
  clientfield::register("actor", "mechz_headlamp_off", 1, 2, "int", &mechzclientutils::mechz_headlamp_off, 0, 0);
  clientfield::register("actor", "mechz_long_jump", 1, 1, "counter", &mechzclientutils::mechz_long_jump, 0, 0);
  clientfield::register("actor", "mechz_jetpack_explosion", 1, 1, "int", &mechzclientutils::mechz_jetpack_explosion, 0, 0);
  clientfield::register("actor", "mechz_face", 1, 3, "int", &mechzclientutils::mechzfacecallback, 0, 0);
  ai::add_archetype_spawn_function(#"mechz", &mechzclientutils::mechzspawn);
  precache();
  level._mechz_face = [];
  level._mechz_face[1] = "ai_face_zombie_generic_attack_1";
  level._mechz_face[2] = "ai_face_zombie_generic_death_1";
  level._mechz_face[3] = "ai_face_zombie_generic_idle_1";
  level._mechz_face[4] = "ai_face_zombie_generic_pain_1";
}

function precache() {
  level._effect[#"fx9_mech_wpn_flamethrower"] = "zm_ai/fx9_mech_wpn_flamethrower";
  level._effect[#"fx9_mech_dmg_armor_face"] = "zm_ai/fx9_mech_dmg_armor_face";
  level._effect[#"fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[#"fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[#"fx9_mech_wpn_mltv_muz"] = "zm_ai/fx9_mech_wpn_mltv_muz";
  level._effect[#"fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[#"fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[#"fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[#"fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[#"fx9_mech_head_light"] = "zm_ai/fx9_mech_head_light";
  level._effect[#"fx9_mech_dmg_sparks"] = "zm_ai/fx9_mech_dmg_sparks";
  level._effect[#"fx9_mech_dmg_knee_sparks"] = "zm_ai/fx9_mech_dmg_knee_sparks";
  level._effect[#"fx9_mech_dmg_sparks"] = "zm_ai/fx9_mech_dmg_sparks";
  level._effect[#"fx9_mech_foot_step"] = "zm_ai/fx9_mech_foot_step";
  level._effect[#"fx9_mech_light_dmg"] = "zm_ai/fx9_mech_light_dmg";
  level._effect[#"fx9_mech_foot_step_steam"] = "zm_ai/fx9_mech_foot_step_steam";
  level._effect[#"fx9_mech_dmg_body_light"] = "zm_ai/fx9_mech_dmg_body_light";
  level._effect[#"fx9_mech_jetpack_dest"] = "zm_ai/fx9_mech_jetpack_dest";
  level._effect[#"fx9_mech_power_core_exposed_destroy"] = "zm_ai/fx9_mech_power_core_exposed_destroy";
  level._effect[#"fx9_mech_power_core_exposed"] = "zm_ai/fx9_mech_power_core_exposed";
}

#namespace mechzclientutils;

function private mechzspawn(localclientnum) {
  level._footstepcbfuncs[self.archetype] = &mechzprocessfootstep;
  self.headlight_fx = util::playFXOnTag(localclientnum, level._effect[#"fx9_mech_head_light"], self, "tag_headlamp_FX");
  self.headlamp_on = 1;
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

function mechzprocessfootstep(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(surface);
  n_dist = distancesquared(notetrack, e_player.origin);
  n_mechz_dist = 1000000;

  if(n_mechz_dist > 0) {
    n_scale = n_dist / n_mechz_dist;
  } else {
    return;
  }

  if(n_scale > 1 || n_scale <= 0) {
    return;
  }

  earthquake_scale = (1 - n_scale) * 0.15;

  if(earthquake_scale > 0.01) {
    earthquake(surface, earthquake_scale, 0.1, notetrack, 1000);
  }

  if(n_scale <= 1 && n_scale > 0.8) {
    e_player playRumbleOnEntity(surface, "mechz_footstep_heavy");
  } else if(n_scale <= 0.8 && n_scale > 0.4) {
    e_player playRumbleOnEntity(surface, "mechz_footstep_medium");
  } else {
    e_player playRumbleOnEntity(surface, "mechz_footstep_light");
  }

  fx = util::playFXOnTag(surface, level._effect[#"fx9_mech_foot_step"], self, bone);

  if(bone == "j_ball_le") {
    steam_bone = "tag_foot_steam_le";
  } else {
    steam_bone = "tag_foot_steam_ri";
  }

  steam_fx = util::playFXOnTag(surface, level._effect[#"fx9_mech_foot_step_steam"], self, steam_bone);
}

function private mechzflamethrowercallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (wasdemojump) {
    case 1:
      self.fire_beam_id = beamlaunch(fieldname, self, "tag_flamethrower_fx", undefined, "none", "flamethrower_beam_3p_zm_mechz");
      self playSound(0, "zmb_ai_mechz_flame_start");
      self.sndloopid = self playLoopSound("zmb_ai_mechz_flame_loop");
      break;
    case 0:
      self notify(#"stopflamethrower");

      if(isDefined(self.fire_beam_id)) {
        beamkill(fieldname, self.fire_beam_id);
        self playSound(0, "zmb_ai_mechz_flame_stop");
        self stoploopsound(self.sndloopid);
      }

      break;
  }
}

function mechz_detach_faceplate(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[#"fx9_mech_dmg_armor_face"], self, "j_spine4");
  self playSound(0, "zmb_ai_mechz_faceplate");
}

function mechz_detach_powercap(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[#"fx9_mech_dmg_armor"], self, "tag_powersupply");
  self playSound(0, "zmb_ai_mechz_destruction");
  self.mechz_powercore_fx = util::playFXOnTag(wasdemojump, level._effect[#"fx9_mech_dmg_body_light"], self, "tag_powersupply");
  self.var_7280af02 = util::playFXOnTag(wasdemojump, level._effect[#"fx9_mech_power_core_exposed"], self, "j_spine4");
}

function mechz_detach_claw(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(level.mechz_detach_claw_override)) {
    self[[level.mechz_detach_claw_override]](localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump);
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[#"fx9_mech_dmg_armor"], self, "tag_gun_spin");
  self playSound(0, "zmb_ai_mechz_destruction");
  util::playFXOnTag(localclientnum, level._effect[#"fx9_mech_dmg_sparks"], self, "tag_gun_spin");

  if(isDefined(self.mechz_powercore_fx)) {
    stopfx(localclientnum, self.mechz_powercore_fx);
  }

  if(isDefined(self.var_7280af02)) {
    stopfx(localclientnum, self.var_7280af02);
  }

  util::playFXOnTag(localclientnum, level._effect[#"fx9_mech_power_core_exposed_destroy"], self, "j_spine4");
}

function mechz_115_gun_muzzle_flash(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[#"fx9_mech_wpn_mltv_muz"], self, "tag_gun_barrel2");
}

function mechz_jetpack_explosion(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[#"fx9_mech_jetpack_dest"], self, "j_spine4");
  self playSound(0, "zmb_ai_mechz_destroy_jetpack");
}

function mechz_headlamp_off(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(self.headlamp_on === 1 && wasdemojump != 0 && isDefined(self.headlight_fx)) {
    stopfx(fieldname, self.headlight_fx);
    self.headlamp_on = 0;

    if(wasdemojump == 2) {
      util::playFXOnTag(fieldname, level._effect[#"fx9_mech_foot_step"], self, "tag_headlamp_fx");
    }
  }
}

function private mechz_long_jump(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  earthquake(wasdemojump, 0.5, 1, self.origin, 600, 1);
}

function private mechzfacecallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::waittill_dobj(fieldname);

  if(wasdemojump && isDefined(self)) {
    if(isDefined(self.prevfaceanim)) {
      self clearanim(self.prevfaceanim, 0.2);
    }

    faceanim = level._mechz_face[wasdemojump];
    self setanim(faceanim, 1, 0.2, 1);
    self.prevfaceanim = faceanim;
  }
}