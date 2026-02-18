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
  clientfield::register("actor", "mechz_ft", 1, 1, "int", &namespace_e0c51a8c::function_3fb58860, 0, 0);
  clientfield::register("actor", "mechz_faceplate_detached", 1, 1, "int", &namespace_e0c51a8c::function_e7cbec57, 0, 0);
  clientfield::register("actor", "mechz_powercap_detached", 1, 1, "int", &namespace_e0c51a8c::function_e364c573, 0, 0);
  clientfield::register("actor", "mechz_claw_detached", 1, 1, "int", &namespace_e0c51a8c::function_fbdc5222, 0, 0);
  clientfield::register("actor", "mechz_115_gun_firing", 1, 1, "int", &namespace_e0c51a8c::function_b17ecff3, 0, 0);
  clientfield::register("actor", "mechz_headlamp_off", 1, 2, "int", &namespace_e0c51a8c::mechz_headlamp_off, 0, 0);
  clientfield::register("actor", "mechz_long_jump", 1, 1, "counter", &namespace_e0c51a8c::mechz_long_jump, 0, 0);
  clientfield::register("actor", "mechz_jetpack_explosion", 1, 1, "int", &namespace_e0c51a8c::mechz_jetpack_explosion, 0, 0);
  clientfield::register("actor", "mechz_face", 1, 3, "int", &namespace_e0c51a8c::function_624ec357, 0, 0);
  ai::add_archetype_spawn_function(#"mechz", &namespace_e0c51a8c::function_b8b1efcd);
  precache();
  level.var_bfb097e0 = [];
  level.var_bfb097e0[1] = "ai_face_zombie_generic_attack_1";
  level.var_bfb097e0[2] = "ai_face_zombie_generic_death_1";
  level.var_bfb097e0[3] = "ai_face_zombie_generic_idle_1";
  level.var_bfb097e0[4] = "ai_face_zombie_generic_pain_1";
}

function precache() {
  level._effect[# "fx9_mech_wpn_flamethrower"] = "zm_ai/fx9_mech_wpn_flamethrower";
  level._effect[# "fx9_mech_dmg_armor_face"] = "zm_ai/fx9_mech_dmg_armor_face";
  level._effect[# "fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[# "fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[# "fx9_mech_wpn_mltv_muz"] = "zm_ai/fx9_mech_wpn_mltv_muz";
  level._effect[# "fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[# "fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[# "fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[# "fx9_mech_dmg_armor"] = "zm_ai/fx9_mech_dmg_armor";
  level._effect[# "fx9_mech_head_light"] = "zm_ai/fx9_mech_head_light";
  level._effect[# "fx9_mech_dmg_sparks"] = "zm_ai/fx9_mech_dmg_sparks";
  level._effect[# "fx9_mech_dmg_knee_sparks"] = "zm_ai/fx9_mech_dmg_knee_sparks";
  level._effect[# "fx9_mech_dmg_sparks"] = "zm_ai/fx9_mech_dmg_sparks";
  level._effect[# "fx9_mech_foot_step"] = "zm_ai/fx9_mech_foot_step";
  level._effect[# "fx9_mech_light_dmg"] = "zm_ai/fx9_mech_light_dmg";
  level._effect[# "fx9_mech_foot_step_steam"] = "zm_ai/fx9_mech_foot_step_steam";
  level._effect[# "fx9_mech_dmg_body_light"] = "zm_ai/fx9_mech_dmg_body_light";
  level._effect[# "fx9_mech_jetpack_dest"] = "zm_ai/fx9_mech_jetpack_dest";
  level._effect[# "fx9_mech_power_core_exposed_destroy"] = "zm_ai/fx9_mech_power_core_exposed_destroy";
  level._effect[# "fx9_mech_power_core_exposed"] = "zm_ai/fx9_mech_power_core_exposed";
}

#namespace namespace_e0c51a8c;

function private function_b8b1efcd(localclientnum) {
  level._footstepcbfuncs[self.archetype] = &function_e7aefb0;
  self.var_a0bf769b = util::playFXOnTag(localclientnum, level._effect[# "fx9_mech_head_light"], self, "tag_headlamp_FX");
  self.var_44ac8cdd = 1;
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

function function_e7aefb0(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(surface);
  n_dist = distancesquared(notetrack, e_player.origin);
  var_5fe097a = 1000000;

  if(var_5fe097a > 0) {
    n_scale = n_dist / var_5fe097a;
  } else {
    return;
  }

  if(n_scale > 1 || n_scale <= 0) {
    return;
  }

  var_1826041c = (1 - n_scale) * 0.15;

  if(var_1826041c > 0.01) {
    earthquake(surface, var_1826041c, 0.1, notetrack, 1000);
  }

  if(n_scale <= 1 && n_scale > 0.8) {
    e_player playrumbleonentity(surface, "mechz_footstep_heavy");
  } else if(n_scale <= 0.8 && n_scale > 0.4) {
    e_player playrumbleonentity(surface, "mechz_footstep_medium");
  } else {
    e_player playrumbleonentity(surface, "mechz_footstep_light");
  }

  fx = util::playFXOnTag(surface, level._effect[# "fx9_mech_foot_step"], self, bone);

  if(bone == "j_ball_le") {
    var_cdc96555 = "tag_foot_steam_le";
  } else {
    var_cdc96555 = "tag_foot_steam_ri";
  }

  var_c04ea775 = util::playFXOnTag(surface, level._effect[# "fx9_mech_foot_step_steam"], self, var_cdc96555);
}

function private function_3fb58860(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (wasdemojump) {
    case 1:
      self.var_755e43c0 = beamlaunch(fieldname, self, "tag_flamethrower_fx", undefined, "none", "flamethrower_beam_3p_zm_mechz");
      self playSound(0, "zmb_ai_mechz_flame_start");
      self.var_28f02418 = self playLoopSound("zmb_ai_mechz_flame_loop");
      break;
    case 0:
      self notify(#"hash_3998a66b558348cf");

      if(isDefined(self.var_755e43c0)) {
        beamkill(fieldname, self.var_755e43c0);
        self playSound(0, "zmb_ai_mechz_flame_stop");
        self stoploopsound(self.var_28f02418);
      }

      break;
  }
}

function function_e7cbec57(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[# "fx9_mech_dmg_armor_face"], self, "j_spine4");
  self playSound(0, "zmb_ai_mechz_faceplate");
}

function function_e364c573(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[# "fx9_mech_dmg_armor"], self, "tag_powersupply");
  self playSound(0, "zmb_ai_mechz_destruction");
  self.var_34528362 = util::playFXOnTag(wasdemojump, level._effect[# "fx9_mech_dmg_body_light"], self, "tag_powersupply");
  self.var_7280af02 = util::playFXOnTag(wasdemojump, level._effect[# "fx9_mech_power_core_exposed"], self, "j_spine4");
}

function function_fbdc5222(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(level.var_88bea78c)) {
    self[[level.var_88bea78c]](localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump);
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[# "fx9_mech_dmg_armor"], self, "tag_gun_spin");
  self playSound(0, "zmb_ai_mechz_destruction");
  util::playFXOnTag(localclientnum, level._effect[# "fx9_mech_dmg_sparks"], self, "tag_gun_spin");

  if(isDefined(self.var_34528362)) {
    stopfx(localclientnum, self.var_34528362);
  }

  if(isDefined(self.var_7280af02)) {
    stopfx(localclientnum, self.var_7280af02);
  }

  util::playFXOnTag(localclientnum, level._effect[# "fx9_mech_power_core_exposed_destroy"], self, "j_spine4");
}

function function_b17ecff3(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[# "fx9_mech_wpn_mltv_muz"], self, "tag_gun_barrel2");
}

function mechz_jetpack_explosion(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::playFXOnTag(wasdemojump, level._effect[# "fx9_mech_jetpack_dest"], self, "j_spine4");
  self playSound(0, "zmb_ai_mechz_destroy_jetpack");
}

function mechz_headlamp_off(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(self.var_44ac8cdd === 1 && wasdemojump != 0 && isDefined(self.var_a0bf769b)) {
    stopfx(fieldname, self.var_a0bf769b);
    self.var_44ac8cdd = 0;

    if(wasdemojump == 2) {
      util::playFXOnTag(fieldname, level._effect[# "fx9_mech_foot_step"], self, "tag_headlamp_fx");
    }
  }
}

function private mechz_long_jump(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  earthquake(wasdemojump, 0.5, 1, self.origin, 600, 1);
}

function private function_624ec357(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  util::waittill_dobj(fieldname);

  if(wasdemojump && isDefined(self)) {
    if(isDefined(self.var_edad38d7)) {
      self clearanim(self.var_edad38d7, 0.2);
    }

    faceanim = level.var_bfb097e0[wasdemojump];
    self setanim(faceanim, 1, 0.2, 1);
    self.var_edad38d7 = faceanim;
  }
}