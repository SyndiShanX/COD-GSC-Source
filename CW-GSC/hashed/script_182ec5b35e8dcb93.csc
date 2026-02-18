/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_182ec5b35e8dcb93.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_19c99142;

function private autoexec __init__system__() {
  system::register(#"hash_2f2eba883d5db256", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!isarchetypeloaded(#"soa")) {
    return;
  }

  clientfield::register("actor", "soaBindTurnCF", 14000, 1, "int", &function_2f78a02, 0, 0);
  clientfield::register("actor", "soaBindProcessCF", 14000, 1, "int", &function_5371f7c0, 0, 0);
  clientfield::register("actor", "soaHeadGlowCF", 14000, 2, "int", &function_5652dbd9, 0, 0);
  clientfield::register("actor", "soaSpawnCompleteCF", 14000, 2, "int", &function_eb1701af, 0, 0);
  clientfield::register("actor", "soaDeathDissolveCF", 14000, 2, "int", &function_911b2ccd, 0, 0);
  clientfield::register("actor", "soaHealthStateCF", 14000, 2, "int", &function_56f7804f, 0, 0);
  clientfield::register("actor", "soaLifeDrainBeamKillCF", 14000, 1, "counter", &function_e397a6bd, 0, 0);
  clientfield::register("toplayer", "soaLifeDrainPostFXCF", 13000, 1, "int", &function_4d8337d3, 0, 0);
  clientfield::register("scriptmover", "soaLifeDrainEntCF", 13000, 2, "int", &function_537e9ae2, 0, 0);
  ai::add_archetype_spawn_function(#"soa", &function_ad30d4e8);
}

function function_ad30d4e8(localclientnum) {
  util::lock_model("c_t9_zmb_son_of_orda_body");
  util::lock_model("c_t9_zmb_son_of_orda_exposed_1");
  util::lock_model("c_t9_zmb_son_of_orda_exposed_2");
  util::lock_model("c_t9_zmb_son_of_orda_3_ww1");
  self callback::add_entity_callback(#"death", &function_1fb3829a);
  self function_e3c02e96(self);
  util::playFXOnTag(localclientnum, #"hash_770fa6ce7ea7aa9d", self, "j_elbow_le");
  util::playFXOnTag(localclientnum, #"hash_1bfa334f4aec5d6", self, "j_elbow_ri");
  util::playFXOnTag(localclientnum, #"hash_6a0de53a6edeffa1", self, "j_head");
  util::playFXOnTag(localclientnum, #"hash_3a4336d2b9df1d18", self, "j_hip_le");
  util::playFXOnTag(localclientnum, #"hash_309145b38054fcd", self, "j_hip_ri");
  util::playFXOnTag(localclientnum, #"hash_29a38a1359a23386", self, "j_spine4");
  util::playFXOnTag(localclientnum, #"hash_7b9d0af952543875", self, "j_spinelower");
  util::playFXOnTag(localclientnum, #"hash_2960ffd6d6e1574b", self, "j_knee_le");
  util::playFXOnTag(localclientnum, #"hash_7889993702834cd4", self, "j_knee_ri");
  util::playFXOnTag(localclientnum, #"hash_487d787325b816f1", self, "j_shoulder_le");
  util::playFXOnTag(localclientnum, #"hash_185191d316944452", self, "j_shoulder_ri");
}

function function_e3c02e96(var_a6027132) {
  var_a6027132.var_f2fd8d37 = self playLoopSound(#"hash_dcd4267947eee6b", 0.5);
  var_a6027132.var_8ca8e6f6 = self playLoopSound(#"hash_4c4b041e443c131e", 0.5);
}

function function_911f421(localclientnum, entity) {
  fx = "zm_ai/fx9_soo_amb_torso";

  if(!is_true(entity.turned)) {
    if(entity.health_state === 1) {
      fx = "zm_ai/fx9_soo_amb_torso_health_md";
    } else if(entity.health_state === 2) {
      fx = "zm_ai/fx9_soo_amb_torso_health_low";
    }
  } else {
    fx = "zm_ai/fx9_soo_amb_torso_brain_rot";

    if(entity.health_state === 1) {
      fx = "zm_ai/fx9_soo_amb_torso_health_md_brain_rot";
    } else if(entity.health_state === 2) {
      fx = "zm_ai/fx9_soo_amb_torso_health_low_brain_rot";
    }
  }

  if(entity.var_e602ced3 !== fx) {
    if(isDefined(entity.var_e602ced3)) {
      stopfx(localclientnum, entity.var_e602ced3);
    }

    entity.var_e602ced3 = util::playFXOnTag(localclientnum, fx, entity, "j_spine4");
  }
}

function function_1fb3829a(params) {
  util::unlock_model("c_t9_zmb_son_of_orda_body");
  util::unlock_model("c_t9_zmb_son_of_orda_exposed_1");
  util::unlock_model("c_t9_zmb_son_of_orda_exposed_2");
  util::unlock_model("c_t9_zmb_son_of_orda_3_ww1");
  self callback::function_52ac9652(#"death", &function_1fb3829a);
}

function function_911b2ccd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_e54c053a)) {
    self function_f6e99a8d(self.var_e54c053a);
    self.var_e54c053a = undefined;
  }

  if(isDefined(self.var_678bc6e2)) {
    self function_f6e99a8d(self.var_678bc6e2);
    self.var_678bc6e2 = undefined;
  }

  if(bwastimejump == 1) {
    self playrenderoverridebundle(#"hash_7ea5a307c8e67de5");

    if(isDefined(self.var_e602ced3)) {
      stopfx(fieldname, self.var_e602ced3);
    }

    if(isDefined(self.var_d85437d9)) {
      stopfx(fieldname, self.var_d85437d9);
    }

    function_4df8409a(fieldname, self);
    return;
  }

  if(bwastimejump == 2) {
    self stoprenderoverridebundle(#"hash_7ea5a307c8e67de5");
  }
}

function function_56f7804f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.health_state = bwastimejump;
    function_911f421(fieldname, self);
  }
}

function function_2f78a02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!gibclientutils::isgibbed(fieldname, self, 8)) {
      if(isDefined(self.archetype)) {
        if(isDefined(self gettagorigin("j_eyeball_le"))) {
          self.var_73ef2da4 = util::playFXOnTag(fieldname, "zm_ai/fx9_soo_bound_zmb_amb", self, "j_eyeball_le");
          self.var_2902afa2 = util::playFXOnTag(fieldname, "zm_ai/fx9_soo_bound_zmb_amb_torso", self, "j_spine4");
          self playrenderoverridebundle("rob_zm_eyes_red", "j_head");
          self playSound(0, #"hash_1acd324b4672becf");
          self.var_abab51d = self playLoopSound(#"hash_20db2e8e590b6ef1");
        }
      }
    }

    return;
  }

  if(isDefined(self.var_73ef2da4)) {
    stopfx(fieldname, self.var_73ef2da4);
    self stoprenderoverridebundle("rob_zm_eyes_red", "j_head");
    self.var_73ef2da4 = undefined;
    self stoploopsound(self.var_abab51d);
  }

  if(isDefined(self.var_2902afa2)) {
    stopfx(fieldname, self.var_2902afa2);
    self.var_2902afa2 = undefined;
  }
}

function function_5371f7c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!gibclientutils::isgibbed(fieldname, self, 8)) {
      if(isDefined(self.archetype)) {
        if(isDefined(self gettagorigin("j_eyeball_le"))) {
          self.var_a4bce1b8 = util::playFXOnTag(fieldname, #"hash_10cd81bd433479d3", self, "j_eyeball_le");
          self playSound(0, #"hash_7aee01e204808ac5");
        }
      }
    }

    return;
  }

  if(isDefined(self.var_a4bce1b8)) {
    stopfx(fieldname, self.var_a4bce1b8);
    self.var_a4bce1b8 = undefined;
  }
}

function function_5652dbd9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_e54c053a)) {
    self stoprenderoverridebundle(self.var_e54c053a);
  }

  if(isDefined(self.var_678bc6e2)) {
    self stoprenderoverridebundle(self.var_678bc6e2);
  }

  if(bwastimejump === 1) {
    self.var_e54c053a = # "hash_5dcba3b7909e1875";
    self playrenderoverridebundle(self.var_e54c053a);
    self.var_d85437d9 = util::playFXOnTag(fieldname, #"hash_45f8a66512a7a19", self, "tag_fx_head_weakspot");
    return;
  }

  if(bwastimejump === 2) {
    self.var_e54c053a = # "hash_38230a889a981e29";
    self.turned = 1;
    self playrenderoverridebundle(self.var_e54c053a);
    self.var_d85437d9 = util::playFXOnTag(fieldname, #"hash_d740b2ea6034927", self, "tag_fx_head_weakspot");
    function_911f421(fieldname, self);
  }
}

function function_eb1701af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    function_911f421(fieldname, self);
    self.var_678bc6e2 = # "hash_7ea5a307c8e67de5";
    self playSound(0, #"hash_5e60a3bcdfbb4bfd");
    self playrenderoverridebundle(#"hash_1e377d2a6063925e");
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_678bc6e2)) {
      self function_f6e99a8d(self.var_678bc6e2);
    }
  }
}

function function_e397a6bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    function_4df8409a(fieldname, self);
  }
}

function function_4d8337d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  postfx = # "hash_12a02eb276dac7ab";

  if(bwastimejump) {
    if(isDefined(self.var_51dd9721) && postfx::function_556665f2(self.var_51dd9721)) {
      postfx::stoppostfxbundle(self.var_51dd9721);
    }

    self postfx::playpostfxbundle(postfx);
    self playSound(0, #"hash_52762fd483a6e3fa");
    self.var_e950e4a8 = self playLoopSound(#"hash_48762d210569c49");
    return;
  }

  self postfx::stoppostfxbundle(postfx);

  if(isDefined(self.var_51dd9721) && !postfx::function_556665f2(self.var_51dd9721)) {
    postfx::playpostfxbundle(self.var_51dd9721);
  }

  self playSound(0, #"hash_4a5adfe85c2cb7da");
  self stoploopsound(self.var_e950e4a8);
}

function function_537e9ae2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    soa = self getlinkedent();

    if(isDefined(soa)) {
      level.var_65331992 = soa;
    }

    return;
  }

  if(bwastimejump === 2) {
    var_ae236771 = self getlinkedent();

    if(isDefined(var_ae236771) && isDefined(level.var_65331992)) {
      function_4df8409a(fieldname, level.var_65331992);

      if(!isDefined(var_ae236771.var_89b07175)) {
        var_ae236771.var_89b07175 = [];
      }

      var_f63cd008 = "beam9_zm_soo_drain_health";
      var_b3c64082 = "beam9_zm_soo_drain_health_blood";

      if(function_27673a7(fieldname) === var_ae236771 && !isthirdperson(fieldname)) {
        var_f63cd008 = "beam9_zm_soo_drain_health_1p";
        var_b3c64082 = "beam9_zm_soo_drain_health_blood_1p";
      }

      target_tag = "j_spine4";

      if(!var_ae236771 isPlayer() && !var_ae236771 isai()) {
        target_tag = "tag_origin";
      }

      var_8e463967 = level.var_65331992 beam::launch(level.var_65331992, "tag_fx_hand_ri_palm", var_ae236771, target_tag, var_f63cd008, 1);
      var_ca8291ac = level.var_65331992 beam::launch(level.var_65331992, "tag_fx_hand_ri_palm", var_ae236771, target_tag, var_b3c64082, 1);
      var_6a339072 = {
        #primary: var_8e463967, #secondary: var_ca8291ac, #var_cff90d98: level.var_65331992, #target_ent: var_ae236771
      };
      var_ae236771.var_89b07175[var_ae236771.var_89b07175.size] = var_6a339072;
      level.var_65331992.var_74fefd81 = var_6a339072;
    }
  }
}

function function_4df8409a(localclientnum, entity) {
  if(isDefined(entity.var_74fefd81)) {
    if(isDefined(entity.var_74fefd81.target_ent)) {
      arrayremovevalue(entity.var_74fefd81.target_ent.var_89b07175, entity.var_74fefd81);
      beam::function_47deed80(localclientnum, entity.var_74fefd81.primary, entity);
      beam::function_47deed80(localclientnum, entity.var_74fefd81.secondary, entity);
    }

    entity.var_74fefd81 = undefined;
  }
}