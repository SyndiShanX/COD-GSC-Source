/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_hand_charon.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_hand_charon;

autoexec __init__system__() {
  system::register(#"zm_weap_hand_charon", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "charon_pool", 16000, 1, "int", &function_a083252d, 0, 0);
  clientfield::register("scriptmover", "charon_shoot", 16000, 1, "counter", &function_3762b44b, 0, 0);
  clientfield::register("scriptmover", "" + #"charon_impact", 16000, 2, "int", &function_12c042fc, 0, 0);
  clientfield::register("allplayers", "charon_flash", 16000, 1, "int", &function_3b17ff6f, 0, 0);
  clientfield::register("actor", "" + #"charon_death", 16000, 1, "counter", &function_120153b7, 0, 0);
  clientfield::register("actor", "" + #"charon_zombie_impact", 16000, 1, "counter", &function_b10c4057, 0, 0);
  clientfield::register("actor", "" + #"charon_pool_victim", 16000, 1, "int", &function_d64a6790, 0, 0);
  level._effect[#"charon_proj"] = #"hash_4952906e2b897ac8";
  level._effect[#"charon_proj_charged"] = #"hash_3a0c132d4e39ba81";
  level._effect[#"charon_proj_impact"] = #"hash_25c4a39b373bfc67";
  level._effect[#"hash_3a8801fc057183dc"] = #"hash_237010c93c358590";
  level._effect[#"hash_4ce416875acfbfab"] = #"hash_6c9f6d6353ff3c71";
  level._effect[#"hash_4cdd0a875ac98c99"] = #"hash_6ca6596354053923";
  level._effect[#"charon_pool"] = #"hash_3d88b8f128288ebe";
  level._effect[#"charon_impact_torso"] = #"hash_6937321c4a8e7349";
  level._effect[#"hash_74d5f15912f2e8ee"] = #"hash_7fca1782163cbb01";
  level._effect[#"hash_779c72a2983289e3"] = #"hash_55d06957e137b062";
  level._effect[#"hash_e84c5306b5ffdf7"] = #"hash_b3bc039e7aca94";
  level._effect[#"hash_4c22be78d74e1de8"] = #"hash_1e3e41de01894921";
  level._effect[#"hash_1bce475aa707ac4c"] = #"hash_5dab3144897e562f";
  level._effect[#"hash_322a2cba1a33e239"] = #"hash_4611402cb26df20";
  level._effect[#"hash_355fbaf759524a7c"] = #"hash_6d56f51f9b1fabaa";
  level._effect[#"hash_1b9a6c3712623d2b"] = #"hash_2ea0cefc397c3d81";
  level._effect[#"hash_2bb39e5073633f5b"] = #"hash_31e7c5600f464e95";
  level._effect[#"charon_impact_death"] = #"hash_30db2fdbdde25718";
  level._effect[#"hash_42346aa652a33c7b"] = #"hash_590a0c54ac9607c";
  level._effect[#"hash_288e913e9e23bec4"] = #"hash_623c4ff75bcaa1a9";
  level._effect[#"hash_206cb9f0d25ae508"] = #"hash_65cea36e2f1cd4c7";
  level._effect[#"hash_7f04d5cd3f06a37d"] = #"hash_413a7f11167bdef8";
  level._effect[#"charon_drag_waist"] = #"hash_2a095e7cd20884a9";
  level._effect[#"charon_pool_death"] = #"hash_33cedc8be1b46bed";
  level._effect[#"charon_drag_puddle"] = #"hash_214db8c579b8672b";
  level._effect[#"charon_impact_zombie"] = #"hash_8f0bc31efc7463e";
}

function_c9df2670(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.n_fx = playFX(localclientnum, level._effect[#"charon_drag_puddle"], self.origin + (0, 0, 4), anglestoup(self.angles));
    return;
  }

  if(isDefined(self.n_fx)) {
    stopfx(localclientnum, self.n_fx);
    self.n_fx = undefined;
  }
}

function_d64a6790(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self zm_utility::good_barricade_damaged(localclientnum);

    if(isDefined(self gettagorigin("j_eyeball_le"))) {
      var_3231a850 = util::playFXOnTag(localclientnum, level._effect[#"charon_pool_death"], self, "j_eyeball_le");
    }

    n_fx = playFX(localclientnum, level._effect[#"charon_drag_puddle"], self.origin, anglestoup(self.angles));
    wait 0.75;

    if(isDefined(self)) {
      self playrenderoverridebundle(#"hash_429426f01ad84c8b");

      if(isDefined(self gettagorigin("j_spine4"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_355fbaf759524a7c"], self, "j_spine4");
      }

      if(isDefined(self gettagorigin("j_elbow_le"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_74d5f15912f2e8ee"], self, "j_elbow_le");
      }

      if(isDefined(self gettagorigin("j_elbow_ri"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_779c72a2983289e3"], self, "j_elbow_ri");
      }

      if(isDefined(self gettagorigin("j_hip_le"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_e84c5306b5ffdf7"], self, "j_hip_le");
      }

      if(isDefined(self gettagorigin("j_hip_ri"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_4c22be78d74e1de8"], self, "j_hip_ri");
      }

      if(isDefined(self gettagorigin("j_knee_le"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_1bce475aa707ac4c"], self, "j_knee_le");
      }

      if(isDefined(self gettagorigin("j_knee_ri"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_322a2cba1a33e239"], self, "j_knee_ri");
      }

      if(isDefined(self gettagorigin("j_spinelower"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_1b9a6c3712623d2b"], self, "j_spinelower");
      }

      if(isDefined(self gettagorigin("j_head"))) {
        util::playFXOnTag(localclientnum, level._effect[#"hash_2bb39e5073633f5b"], self, "j_head");
      }
    }

    wait 1.35;

    if(isDefined(var_3231a850)) {
      killfx(localclientnum, var_3231a850);
    }

    wait 0.9;

    if(isDefined(n_fx)) {
      stopfx(localclientnum, n_fx);
      n_fx = undefined;
    }
  }
}

function_3762b44b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"charon_proj"], self, "tag_origin");

  if(!isDefined(self.var_69754745)) {
    self.var_69754745 = self playLoopSound(#"hash_60a1a9475224f99");
  }
}

function_120153b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self zm_utility::good_barricade_damaged(localclientnum);
  self playrenderoverridebundle(#"hash_429426f01ad84c8b");

  if(isDefined(self gettagorigin("j_spine4"))) {
    util::playFXOnTag(localclientnum, level._effect[#"charon_impact_torso"], self, "j_spine4");
    util::playFXOnTag(localclientnum, level._effect[#"charon_impact_death"], self, "j_spine4");
    wait 0.75;
    util::playFXOnTag(localclientnum, level._effect[#"hash_355fbaf759524a7c"], self, "j_spine4");
  }

  if(isDefined(self gettagorigin("j_elbow_le"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_74d5f15912f2e8ee"], self, "j_elbow_le");
  }

  if(isDefined(self gettagorigin("j_elbow_ri"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_779c72a2983289e3"], self, "j_elbow_ri");
  }

  if(isDefined(self gettagorigin("j_hip_le"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_e84c5306b5ffdf7"], self, "j_hip_le");
  }

  if(isDefined(self gettagorigin("j_hip_ri"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_4c22be78d74e1de8"], self, "j_hip_ri");
  }

  if(isDefined(self gettagorigin("j_knee_le"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_1bce475aa707ac4c"], self, "j_knee_le");
  }

  if(isDefined(self gettagorigin("j_knee_ri"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_322a2cba1a33e239"], self, "j_knee_ri");
  }

  if(isDefined(self gettagorigin("j_spinelower"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_1b9a6c3712623d2b"], self, "j_spinelower");
  }

  if(isDefined(self gettagorigin("j_head"))) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_2bb39e5073633f5b"], self, "j_head");
  }
}

function_b10c4057(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(isDefined(self gettagorigin("j_spine4"))) {
    v_org = self gettagorigin("j_spine4");
  } else {
    str_tag = self zm_utility::function_467efa7b();

    if(!isDefined(str_tag)) {
      v_org = self.origin;
    } else {
      v_org = self gettagorigin(str_tag);
    }
  }

  if(!isDefined(v_org)) {
    return;
  }

  playFX(localclientnum, level._effect[#"charon_impact_zombie"], v_org, anglesToForward(self.angles));
  playSound(localclientnum, #"hash_1178a0c11728dc62", self.origin);
}

function_12c042fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self gettagorigin("j_wingulna_le"))) {
    v_org = self gettagorigin("j_h_neck_lower");
  } else if(isDefined(self gettagorigin("j_spine4"))) {
    v_org = self gettagorigin("j_spine4");
  } else {
    v_org = self.origin;
  }

  v_forward = anglesToForward(self.angles) * 1000 + self.origin;
  v_back = anglesToForward(self.angles) * -100 + self.origin;
  a_trace = bulletTrace(v_back, v_forward, 0, self);

  if(isDefined(a_trace[#"normal"])) {
    v_ang = a_trace[#"normal"];
  } else {
    v_ang = anglesToForward(self.angles) * -1;
  }

  if(newval == 1) {
    playFX(localclientnum, level._effect[#"charon_proj_impact"], v_org, v_ang);
  } else if(newval == 2) {
    playFX(localclientnum, level._effect[#"hash_3a8801fc057183dc"], v_org, v_ang);
  }

  playSound(localclientnum, #"hash_5674d8ca7846c4a5", self.origin);
}

function_3b17ff6f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(!self hasdobj(localclientnum)) {
    return;
  }

  if(isDefined(self.fx_muzzle_flash)) {
    deletefx(localclientnum, self.fx_muzzle_flash);
    self.fx_muzzle_flash = undefined;
  }

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(newval == 1) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(viewmodelhastag(localclientnum, "tag_flash")) {
        self.fx_muzzle_flash = playviewmodelfx(localclientnum, level._effect[#"hash_4ce416875acfbfab"], "tag_flash");
      }

      return;
    }

    if(isDefined(self gettagorigin("tag_flash"))) {
      self.fx_muzzle_flash = util::playFXOnTag(localclientnum, level._effect[#"hash_4cdd0a875ac98c99"], self, "tag_flash");
    }
  }
}

function_a083252d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.var_8dddfdd2)) {
    stopfx(localclientnum, self.var_8dddfdd2);
    self.var_8dddfdd2 = undefined;
  }

  if(newval) {
    self.var_8dddfdd2 = util::playFXOnTag(localclientnum, level._effect[#"charon_pool"], self, "tag_origin");

    if(!isDefined(self.var_97807834)) {
      self playSound(localclientnum, #"hash_309ccaa2cf6590f1");
      self.var_97807834 = self playLoopSound(#"hash_23338cb2b8ef2117");
    }

    return;
  }

  if(isDefined(self.var_8dddfdd2)) {
    stopfx(localclientnum, self.var_8dddfdd2);
    self.var_8dddfdd2 = undefined;
  }

  if(isDefined(self.var_97807834)) {
    self playSound(localclientnum, #"hash_73cf0fb013e9af90");
    self stoploopsound(self.var_97807834);
    self.var_97807834 = undefined;
  }
}