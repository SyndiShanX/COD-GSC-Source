/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\raz.csc
***********************************************/

#using scripts\core_common\ai\archetype_secondary_animations;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace raz;

function autoexec main() {
  clientfield::register("scriptmover", "raz_detonate_ground_torpedo", 1, 1, "int", &namespace_fe3871d9::function_e7290ec2, 0, 0);
  clientfield::register("scriptmover", "raz_torpedo_play_fx_on_self", 1, 1, "int", &namespace_fe3871d9::function_dc17c6d6, 0, 0);
  clientfield::register("scriptmover", "raz_torpedo_play_trail", 1, 1, "counter", &namespace_fe3871d9::function_868b328b, 0, 0);
  clientfield::register("actor", "raz_gun_weakpoint_hit", 1, 1, "counter", &namespace_fe3871d9::function_250b46c7, 0, 0);
  ai::add_archetype_spawn_function(#"raz", &namespace_fe3871d9::function_e94574ae);
}

function autoexec precache() {
  level._effect[#"fx_mech_foot_step"] = "dlc1/castle/fx_mech_foot_step";
  level._effect[#"hash_c824652e58b5fdf"] = "zm_ai/fx9_raz_mc_shockwave_projectile_impact";
  level._effect[#"fx_bul_impact_concrete_xtreme"] = "impacts/fx_bul_impact_concrete_xtreme";
  level._effect[#"hash_7d199c49ab77b780"] = "zm_ai/fx9_raz_mc_shockwave_projectile";
  level._effect[#"hash_494b459d33f13b6"] = "zm_ai/fx9_raz_dest_weak_point_exp";
  level._effect[#"hash_656c73c7e4336a47"] = "zm_ai/fx9_raz_dest_weak_point_sparking_loop";
  level._effect[#"hash_7badd093aab9e236"] = "zm_ai/fx9_raz_dmg_weak_point";
  level._effect[#"hash_4faeb86b1620aac4"] = "zm_ai/fx9_raz_dest_weak_point_exp_generic";
  level.var_b8d03316 = [];

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_0";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_1";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_2";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_3";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_4";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_5";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_6";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_7";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_8";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_9";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_10";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_11";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_12";

  if(!isDefined(level.var_b8d03316)) {
    level.var_b8d03316 = [];
  } else if(!isarray(level.var_b8d03316)) {
    level.var_b8d03316 = array(level.var_b8d03316);
  }

  level.var_b8d03316[level.var_b8d03316.size] = "vox_mang_mangler_taunt_13";
}

#namespace namespace_fe3871d9;

function private function_e94574ae(localclientnum) {
  level._footstepcbfuncs[self.archetype] = &function_525f8122;
  self thread function_3f40a429(localclientnum);
  util::waittill_dobj(localclientnum);
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

function private function_3f40a429(localclientnum) {
  self endon(#"death");

  while(isDefined(self)) {
    self waittill(#"lights_on");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, 1, 1);
    self waittill(#"lights_off");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, 0, 0);
  }
}

function private function_baf6efda(localclientnum) {
  self endon(#"death");

  while(isDefined(self)) {
    self waittill(#"roar");
    self playSound(localclientnum, "vox_raz_exert_enrage", self gettagorigin("tag_eye"));
  }
}

function function_d0d17a03(localclientnum) {
  self endon(#"death");
  self endon(#"hash_44b53862eee262c9");

  while(isDefined(self)) {
    wait randomintrange(2, 9);
    self playSound(localclientnum, "vox_ai_raz_ambient_radio", self gettagorigin("tag_eye"));
    wait 5;
  }
}

function function_525f8122(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(surface);
  n_dist = distancesquared(notetrack, e_player.origin);
  var_775e0d4 = 160000;

  if(var_775e0d4 > 0) {
    n_scale = (var_775e0d4 - n_dist) / var_775e0d4;
  } else {
    return;
  }

  if(n_scale > 1 || n_scale < 0) {
    return;
  }

  if(n_scale <= 0.01) {
    return;
  }

  var_1826041c = n_scale * 0.1;

  if(var_1826041c > 0.01) {
    earthquake(surface, var_1826041c, 0.1, notetrack, n_dist);
  }

  if(n_scale <= 1 && n_scale > 0.8) {
    e_player playrumbleonentity(surface, "damage_heavy");
  } else if(n_scale <= 0.8 && n_scale > 0.4) {
    e_player playrumbleonentity(surface, "damage_light");
  } else {
    e_player playrumbleonentity(surface, "reload_small");
  }

  fx = util::playFXOnTag(surface, level._effect[#"fx_mech_foot_step"], self, bone);
}

function private function_e7290ec2(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = playFX(wasdemojump, level._effect[#"hash_c824652e58b5fdf"], self.origin);
}

function private function_868b328b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = playFX(wasdemojump, level._effect[#"fx_bul_impact_concrete_xtreme"], self.origin);
}

function private function_dc17c6d6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump == 0 && isDefined(self.var_475864c)) {
    stopfx(fieldname, self.var_475864c);
    self.var_475864c = undefined;
  }

  if(wasdemojump == 1 && !isDefined(self.var_475864c)) {
    self.var_475864c = util::playFXOnTag(fieldname, level._effect[#"hash_7d199c49ab77b780"], self, "tag_origin");
  }
}

function private function_16686fd4(localclientnum, model, pos, angles, hitpos, var_243511ab = 1, direction) {
  if(!isDefined(angles) || !isDefined(hitpos)) {
    return;
  }

  velocity = self getvelocity();
  var_9ec7627b = vectornormalize(velocity);
  var_bab6cdb7 = length(velocity);

  if(isDefined(direction) && direction == "back") {
    launch_dir = anglesToForward(self.angles) * -1;
  } else {
    launch_dir = anglesToForward(self.angles);
  }

  var_bab6cdb7 *= 0.1;

  if(var_bab6cdb7 < 10) {
    var_bab6cdb7 = 10;
  }

  launch_dir = launch_dir * 0.5 + var_9ec7627b * 0.5;
  launch_dir *= var_bab6cdb7;
  createdynentandlaunch(model, pos, angles, hitpos, self.origin, launch_dir * var_243511ab);
}

function private function_27830d87(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = util::playFXOnTag(wasdemojump, level._effect[#"hash_494b459d33f13b6"], self, "TAG_FX_Shoulder_RI_GIB");
  var_96f5534c = self gettagorigin("j_elbow_ri");
  var_bcffa218 = self gettagangles("j_elbow_ri");
  var_2c37b16f = self gettagorigin("j_shouldertwist_ri_attach");
  var_7c071f82 = self gettagangles("j_shouldertwist_ri_attach");
  dynent = function_16686fd4(wasdemojump, "c_zom_dlc3_raz_s_armcannon", var_96f5534c, var_bcffa218, self.origin, 1.3, "back");
  self playSound(wasdemojump, "zmb_raz_gun_explo", self gettagorigin("tag_eye"));
}

function private function_250b46c7(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = util::playFXOnTag(wasdemojump, level._effect[#"hash_7badd093aab9e236"], self, "j_shoulder_ri");
}

function private applynewfaceanim(localclientnum, animation) {
  self endon(#"death");

  if(isDefined(animation)) {
    self._currentfaceanim = animation;

    if(self hasdobj(localclientnum) && self hasanimtree()) {
      self setflaggedanimknob("ai_secondary_facial_anim", animation, 1, 0.1, 1);
    }
  }
}

function private clearcurrentfacialanim(localclientnum) {
  if(isDefined(self._currentfaceanim) && self hasdobj(localclientnum) && self hasanimtree()) {
    self clearanim(self._currentfaceanim, 0.2);
  }

  self._currentfaceanim = undefined;
}