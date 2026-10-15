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
  clientfield::register("scriptmover", "raz_detonate_ground_torpedo", 1, 1, "int", &razclientutils::razdetonategroundtorpedo, 0, 0);
  clientfield::register("scriptmover", "raz_torpedo_play_fx_on_self", 1, 1, "int", &razclientutils::razplayselffx, 0, 0);
  clientfield::register("scriptmover", "raz_torpedo_play_trail", 1, 1, "counter", &razclientutils::raztorpedoplaytrailfx, 0, 0);
  clientfield::register("actor", "raz_gun_weakpoint_hit", 1, 1, "counter", &razclientutils::razgunweakpointhitfx, 0, 0);
  ai::add_archetype_spawn_function(#"raz", &razclientutils::razspawn);
}

function autoexec precache() {
  level._effect[#"fx_mech_foot_step"] = "dlc1/castle/fx_mech_foot_step";
  level._effect[#"fx_raz_mc_shockwave_projectile_impact"] = "zm_ai/fx9_raz_mc_shockwave_projectile_impact";
  level._effect[#"fx_bul_impact_concrete_xtreme"] = "impacts/fx_bul_impact_concrete_xtreme";
  level._effect[#"fx_raz_mc_shockwave_projectile"] = "zm_ai/fx9_raz_mc_shockwave_projectile";
  level._effect[#"fx_raz_dest_weak_point_exp"] = "zm_ai/fx9_raz_dest_weak_point_exp";
  level._effect[#"fx_raz_dest_weak_point_sparking_loop"] = "zm_ai/fx9_raz_dest_weak_point_sparking_loop";
  level._effect[#"fx_raz_dmg_weak_point"] = "zm_ai/fx9_raz_dmg_weak_point";
  level._effect[#"fx_raz_dest_weak_point_exp_generic"] = "zm_ai/fx9_raz_dest_weak_point_exp_generic";
  level._raz_taunts = [];

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_0";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_1";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_2";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_3";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_4";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_5";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_6";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_7";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_8";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_9";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_10";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_11";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_12";

  if(!isDefined(level._raz_taunts)) {
    level._raz_taunts = [];
  } else if(!isarray(level._raz_taunts)) {
    level._raz_taunts = array(level._raz_taunts);
  }

  level._raz_taunts[level._raz_taunts.size] = "vox_mang_mangler_taunt_13";
}

#namespace razclientutils;

function private razspawn(localclientnum) {
  level._footstepcbfuncs[self.archetype] = &razprocessfootstep;
  self thread razplayfireemissiveshader(localclientnum);
  util::waittill_dobj(localclientnum);
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

function private razplayfireemissiveshader(localclientnum) {
  self endon(#"death");

  while(isDefined(self)) {
    self waittill(#"lights_on");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, 1, 1);
    self waittill(#"lights_off");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, 0, 0);
  }
}

function private razplayroarsound(localclientnum) {
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

function razprocessfootstep(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(surface);
  n_dist = distancesquared(notetrack, e_player.origin);
  n_raz_dist = 160000;

  if(n_raz_dist > 0) {
    n_scale = (n_raz_dist - n_dist) / n_raz_dist;
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
    earthquake(surface, earthquake_scale, 0.1, notetrack, n_dist);
  }

  if(n_scale <= 1 && n_scale > 0.8) {
    e_player playRumbleOnEntity(surface, "damage_heavy");
  } else if(n_scale <= 0.8 && n_scale > 0.4) {
    e_player playRumbleOnEntity(surface, "damage_light");
  } else {
    e_player playRumbleOnEntity(surface, "reload_small");
  }

  fx = util::playFXOnTag(surface, level._effect[#"fx_mech_foot_step"], self, bone);
}

function private razdetonategroundtorpedo(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = playFX(wasdemojump, level._effect[#"fx_raz_mc_shockwave_projectile_impact"], self.origin);
}

function private raztorpedoplaytrailfx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = playFX(wasdemojump, level._effect[#"fx_bul_impact_concrete_xtreme"], self.origin);
}

function private razplayselffx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump == 0 && isDefined(self.raz_torpedo_self_fx)) {
    stopfx(fieldname, self.raz_torpedo_self_fx);
    self.raz_torpedo_self_fx = undefined;
  }

  if(wasdemojump == 1 && !isDefined(self.raz_torpedo_self_fx)) {
    self.raz_torpedo_self_fx = util::playFXOnTag(fieldname, level._effect[#"fx_raz_mc_shockwave_projectile"], self, "tag_origin");
  }
}

function private razcreatedynentandlaunch(localclientnum, model, pos, angles, hitpos, vel_factor = 1, direction) {
  if(!isDefined(angles) || !isDefined(hitpos)) {
    return;
  }

  velocity = self getvelocity();
  velocity_normal = vectorNormalize(velocity);
  velocity_length = length(velocity);

  if(isDefined(direction) && direction == "back") {
    launch_dir = anglesToForward(self.angles) * -1;
  } else {
    launch_dir = anglesToForward(self.angles);
  }

  velocity_length *= 0.1;

  if(velocity_length < 10) {
    velocity_length = 10;
  }

  launch_dir = launch_dir * 0.5 + velocity_normal * 0.5;
  launch_dir *= velocity_length;
  createdynentandlaunch(model, pos, angles, hitpos, self.origin, launch_dir * vel_factor);
}

function private razdetachgunfx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = util::playFXOnTag(wasdemojump, level._effect[#"fx_raz_dest_weak_point_exp"], self, "TAG_FX_Shoulder_RI_GIB");
  gun_pos = self gettagorigin("j_elbow_ri");
  gun_ang = self gettagangles("j_elbow_ri");
  gun_core_pos = self gettagorigin("j_shouldertwist_ri_attach");
  gun_core_ang = self gettagangles("j_shouldertwist_ri_attach");
  dynent = razcreatedynentandlaunch(wasdemojump, "c_zom_dlc3_raz_s_armcannon", gun_pos, gun_ang, self.origin, 1.3, "back");
  self playSound(wasdemojump, "zmb_raz_gun_explo", self gettagorigin("tag_eye"));
}

function private razgunweakpointhitfx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx = util::playFXOnTag(wasdemojump, level._effect[#"fx_raz_dmg_weak_point"], self, "j_shoulder_ri");
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