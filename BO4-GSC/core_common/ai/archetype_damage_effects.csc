/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_damage_effects.csc
*******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\util_shared;

#namespace archetype_damage_effects;

class class_d5e9830e {
  var shaderconst;
  var tags;

  constructor() {
    tags = [];
    shaderconst = 0;
  }

}

autoexec main() {
  registerclientfields();
  loadeffects();
}

registerclientfields() {
  clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int", &actor_fire_fx_state, 0, 0);
  clientfield::register("actor", "arch_actor_char", 1, 2, "int", &actor_char, 0, 0);
}

loadeffects() {
  level._effect[#"fire_robot_j_elbow_le_rot_loop"] = #"fire/fx_fire_ai_robot_arm_left_loop";
  level._effect[#"fire_robot_j_elbow_ri_rot_loop"] = #"fire/fx_fire_ai_robot_arm_right_loop";
  level._effect[#"fire_robot_j_shoulder_le_rot_loop"] = #"fire/fx_fire_ai_robot_arm_left_loop";
  level._effect[#"fire_robot_j_shoulder_ri_rot_loop"] = #"fire/fx_fire_ai_robot_arm_right_loop";
  level._effect[#"fire_robot_j_spine4_loop"] = #"fire/fx_fire_ai_robot_torso_loop";
  level._effect[#"fire_robot_j_knee_le_loop"] = #"fire/fx_fire_ai_robot_leg_left_loop";
  level._effect[#"fire_robot_j_knee_ri_loop"] = #"fire/fx_fire_ai_robot_leg_right_loop";
  level._effect[#"fire_robot_j_head_loop"] = #"fire/fx_fire_ai_robot_head_loop";
  level._effect[#"fire_robot_j_elbow_le_rot_os"] = #"fire/fx_fire_ai_robot_arm_left_os";
  level._effect[#"fire_robot_j_elbow_ri_rot_os"] = #"fire/fx_fire_ai_robot_arm_right_os";
  level._effect[#"fire_robot_j_shoulder_le_rot_os"] = #"fire/fx_fire_ai_robot_arm_left_os";
  level._effect[#"fire_robot_j_shoulder_ri_rot_os"] = #"fire/fx_fire_ai_robot_arm_right_os";
  level._effect[#"fire_robot_j_spine4_os"] = #"fire/fx_fire_ai_robot_torso_os";
  level._effect[#"fire_robot_j_knee_le_os"] = #"fire/fx_fire_ai_robot_leg_left_os";
  level._effect[#"fire_robot_j_knee_ri_os"] = #"fire/fx_fire_ai_robot_leg_right_os";
  level._effect[#"fire_robot_j_head_os"] = #"fire/fx_fire_ai_robot_head_os";
  level.var_60a09d68 = [];
  level.var_60a09d68[#"mp_dog"] = [];
  level.var_60a09d68[#"mp_dog"][#"hash_3cf96a0aa8ac919"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"mp_dog"][#"hash_66d60e2138e4f152"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"mp_dog"][#"hash_213857ac6d630ed3"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"mp_dog"][#"hash_6f9163ebf3baeee4"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"mp_dog"][#"hash_67bbf1ab610115b4"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"mp_dog"][#"hash_64c72f1dfecd290c"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"mp_dog"][#"hash_2a4e6916c0772dca"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"mp_dog"][#"hash_64c1f4459de5c8a2"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"human"] = [];
  level.var_60a09d68[#"human"][#"fire_j_elbow_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"human"][#"fire_j_elbow_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
  level.var_60a09d68[#"human"][#"fire_j_shoulder_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
  level.var_60a09d68[#"human"][#"fire_j_shoulder_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
  level.var_60a09d68[#"human"][#"fire_j_spine4_loop"] = #"fire/fx_fire_ai_human_torso_loop";
  level.var_60a09d68[#"human"][#"fire_j_hip_le_loop"] = #"fire/fx_fire_ai_human_hip_left_loop";
  level.var_60a09d68[#"human"][#"fire_j_hip_ri_loop"] = #"fire/fx_fire_ai_human_hip_right_loop";
  level.var_60a09d68[#"human"][#"fire_j_head_loop"] = #"fire/fx_fire_ai_human_head_loop";
  level.var_60a09d68[#"human"][#"fire_j_knee_le_os"] = #"fire/fx_fire_ai_human_leg_left_os";
  level.var_60a09d68[#"human"][#"fire_j_knee_ri_os"] = #"fire/fx_fire_ai_human_leg_right_os";
  level.var_60a09d68[#"human"][#"fire_j_elbow_le_os"] = #"fire/fx_fire_ai_human_arm_left_os";
  level.var_60a09d68[#"human"][#"fire_j_elbow_ri_os"] = #"fire/fx_fire_ai_human_arm_right_os";
  level.var_60a09d68[#"human"][#"fire_j_shoulder_le_os"] = #"fire/fx_fire_ai_human_arm_left_os";
  level.var_60a09d68[#"human"][#"fire_j_shoulder_ri_os"] = #"fire/fx_fire_ai_human_arm_right_os";
  level.var_60a09d68[#"human"][#"fire_j_spine4_os"] = #"fire/fx_fire_ai_human_torso_os";
  level.var_60a09d68[#"human"][#"fire_j_hip_le_os"] = #"fire/fx_fire_ai_human_hip_left_os";
  level.var_60a09d68[#"human"][#"fire_j_hip_ri_os"] = #"fire/fx_fire_ai_human_hip_right_os";
  level.var_60a09d68[#"human"][#"fire_j_head_os"] = #"fire/fx_fire_ai_human_head_os";
  level.var_60a09d68[#"human"][#"fire_j_knee_le_os"] = #"fire/fx_fire_ai_human_leg_left_os";
  level.var_60a09d68[#"human"][#"fire_j_knee_ri_os"] = #"fire/fx_fire_ai_human_leg_right_os";
  level.var_60a09d68[#"human"][#"hash_38690ef2c303b981"] = #"smoke/fx_smk_ai_human_arm_left_os";
  level.var_60a09d68[#"human"][#"hash_1b8ec036e64264e3"] = #"smoke/fx_smk_ai_human_arm_right_os";
  level.var_60a09d68[#"human"][#"hash_93987513d9fcf74"] = #"smoke/fx_smk_ai_human_arm_left_os";
  level.var_60a09d68[#"human"][#"hash_4120bed5ccbd9ada"] = #"hash_508a2d8945b9a938";
  level.var_60a09d68[#"human"][#"hash_2956a5ac1199cb6f"] = #"smoke/fx_smk_ai_human_torso_os";
  level.var_60a09d68[#"human"][#"hash_5156e6a4093a5ef7"] = #"smoke/fx_smk_ai_human_hip_left_os";
  level.var_60a09d68[#"human"][#"hash_577af0103b54f9d5"] = #"smoke/fx_smk_ai_human_hip_right_os";
  level.var_60a09d68[#"human"][#"hash_90fd448cc5848d6"] = #"smoke/fx_smk_ai_human_head_os";
  level.var_60a09d68[#"human"][#"hash_1c2f6725995eb16b"] = #"smoke/fx_smk_ai_human_leg_left_os";
  level.var_60a09d68[#"human"][#"hash_101185c328f39789"] = #"smoke/fx_smk_ai_human_leg_right_os";
}

private _burntag(localclientnum, tag, postfix, prefix) {
  if(isDefined(self) && self hasdobj(localclientnum)) {
    fx_to_play = undefined;

    if(isDefined(level.var_60a09d68) && isDefined(level.var_60a09d68[self.archetype])) {
      fxitem = prefix + tag + postfix;
      fx_to_play = level.var_60a09d68[self.archetype][fxitem];

      if(isDefined(fx_to_play)) {
        return util::playFXOnTag(localclientnum, fx_to_play, self, tag);
      }
    }
  }
}

private _burnstage(localclientnum, tagarray, shouldwait, prefix) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");

  if(!isDefined(prefix)) {
    prefix = "fire_";
  }

  tags = array::randomize(tagarray);

  for(i = 1; i < tags.size; i++) {
    if(tags[i] == "null") {
      continue;
    }

    self.activefx[self.activefx.size] = self _burntag(localclientnum, tags[i], shouldwait ? "_loop" : "_os", prefix);

    if(shouldwait) {
      wait randomfloatrange(0.1, 0.3);
    }
  }

  if(shouldwait) {
    wait randomfloatrange(0, 1);
  }

  if(isDefined(self)) {
    self notify(#"burn_stage_finished");
  }
}

private _burnbody(localclientnum, prefix) {
  self endon(#"death");
  timer = 10;
  bonemodifier = "";

  if(self.archetype == "robot") {
    bonemodifier = "_rot";
    timer = 6;
  }

  if(!isDefined(prefix)) {
    prefix = "fire_";
  }

  var_cdc643c6 = [];

  if(self.archetype == "mp_dog") {
    var_58b4042a = new class_d5e9830e();
    var_58b4042a.tags = array("tag_thigh_str_drvr_le", "tag_thigh_stretch_le", "tag_thigh_str_drvr_ri", "tag_thigh_stretch_ri", "tag_shldr_str_drvr_le", "tag_shoulder_stretch_le", "tag_shldr_str_drvr_ri", "tag_shoulder_stretch_ri");
    array::add(var_cdc643c6, var_58b4042a);
  } else {
    var_58b4042a = new class_d5e9830e();
    var_58b4042a.tags = array("j_elbow_le" + bonemodifier, "j_elbow_ri" + bonemodifier, "null");
    var_58b4042a.shaderconst = 0.2;
    array::add(var_cdc643c6, var_58b4042a);
    var_4d8772cf = new class_d5e9830e();
    var_4d8772cf.tags = array("j_shoulder_le" + bonemodifier, "j_shoulder_ri" + bonemodifier, "null");
    var_4d8772cf.shaderconst = 0.4;
    array::add(var_cdc643c6, var_4d8772cf);
    var_86127c87 = new class_d5e9830e();
    var_86127c87.tags = array("j_spine4", "null");
    var_86127c87.shaderconst = 0.6;
    array::add(var_cdc643c6, var_86127c87);
    var_c65d82a4 = new class_d5e9830e();
    var_c65d82a4.tags = array("j_hip_le", "j_hip_ri", "j_head", "null");
    var_c65d82a4.shaderconst = 0.8;
    array::add(var_cdc643c6, var_c65d82a4);
    var_9e543e79 = new class_d5e9830e();
    var_9e543e79.tags = array("j_knee_le", "j_knee_ri", "null");
    var_9e543e79.shaderconst = 1;
    array::add(var_cdc643c6, var_9e543e79);
  }

  maturemask = 0;

  if(util::is_mature()) {
    maturemask = 1;
  }

  self.activefx = [];

  foreach(var_86661a11 in var_cdc643c6) {
    self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, var_86661a11.tags, 1, prefix);
    self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * var_86661a11.shaderconst);
    self waittill(#"burn_stage_finished");
  }
}

sndstopburnloop(timer) {
  self waittilltimeout(timer, #"death", #"stopburningsounds");

  if(isDefined(self)) {
    if(isDefined(self.burn_loop_sound_handle)) {
      self stoploopsound(self.burn_loop_sound_handle);
    }
  }
}

private _burncorpse(localclientnum) {
  self endon(#"death");
  timer = 10;
  bonemodifier = "";

  if(self.archetype == "robot") {
    bonemodifier = "_rot";
    timer = 3;
  }

  stage1burntags = array("j_elbow_le" + bonemodifier, "j_elbow_ri" + bonemodifier);
  stage2burntags = array("j_shoulder_le" + bonemodifier, "j_shoulder_ri" + bonemodifier);
  stage3burntags = array("j_spine4", "j_spinelower", "null");
  stage4burntags = array("j_hip_le", "j_hip_ri", "j_head");
  stage5burntags = array("j_knee_le", "j_knee_ri");
  self.burn_loop_sound_handle = self playLoopSound(#"chr_burn_npc_loop1", 0.2);
  self thread sndstopburnloop(timer);
  self.activefx = [];
  self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage1burntags, 0);
  self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage2burntags, 0);
  self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage3burntags, 0);
  self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage4burntags, 0);
  self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage5burntags, 0);
  maturemask = 0;

  if(util::is_mature()) {
    maturemask = 1;
  }

  self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * 1);
  wait 20;

  if(isDefined(self)) {
    foreach(fx in self.activefx) {
      stopfx(localclientnum, fx);
      self notify(#"stopburningsounds");
    }

    if(isDefined(self)) {
      self.activefx = [];
    }
  }
}

actor_fire_fx(localclientnum, value, burningduration) {
  switch (value) {
    case 0:
      if(isDefined(self.activefx)) {
        self stopallloopsounds(1);

        foreach(fx in self.activefx) {
          stopfx(localclientnum, fx);
        }
      }

      self.activefx = [];
      break;
    case 1:
      self thread _burnbody(localclientnum);
      break;
    case 2:
      self thread _burnbody(localclientnum);
      break;
    case 3:
      self thread _burnbody(localclientnum, "smolder_");
      break;
  }
}

actor_fire_fx_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self actor_fire_fx(localclientnum, newval, 14);
}

actor_char(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  maturemask = 0;

  if(util::is_mature()) {
    maturemask = 1;
  }

  switch (newval) {
    case 1:
      self thread actorcharrampto(localclientnum, 1);
      break;
    case 0:
      self mapshaderconstant(localclientnum, 0, "scriptVector0", 0);
      break;
    case 2:
      self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * 1);
      break;
  }
}

actorcharrampto(localclientnum, chardesired) {
  self endon(#"death");

  if(!isDefined(self.curcharlevel)) {
    self.curcharlevel = 0;
  }

  maturemask = 0;

  if(util::is_mature()) {
    maturemask = 1;
  }

  if(!isDefined(self.charsteps)) {
    assert(isDefined(chardesired));
    self.charsteps = int(200);
    delta = chardesired - self.curcharlevel;
    self.charinc = delta / self.charsteps;
  }

  while(self.charsteps) {
    self.curcharlevel = math::clamp(self.curcharlevel + self.charinc, 0, 1);
    self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * self.curcharlevel);
    self.charsteps--;
    wait 0.01;
  }
}