/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2fbd61c3675dc7ca.csc
***********************************************/

#using script_669cea9418ec7fe2;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_4e8d47b1;

function init() {
  clientfield::register("toplayer", "" + # "hash_529b556128a8587d", 24000, 1, "int", &function_ff7f32ae, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4a3af1d46621f069", 24000, 1, "int", &function_910d2164, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_45d9cedaf4fb4aa2", 24000, 1, "int", &function_7e8bc554, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4a7733d2f4b25e81", 24000, 1, "int", &function_b42a918, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_41ba39a474a3503f", 24000, getminbitcountfornum(2), "int", &function_adfd1e5b, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_2951f2625695bd6b", 24000, getminbitcountfornum(2), "int", &function_7c865e3a, 0, 0);
  clientfield::register("world", "" + # "hash_74c14ea3fcc781ea", 24000, getminbitcountfornum(2), "int", &function_fa856271, 0, 0);
  clientfield::register("actor", "" + # "hash_636aa4e3dd50512a", 24000, 1, "counter", &function_d51885ac, 0, 0);
  clientfield::register("actor", "" + # "hash_498f233d25448db3", 24000, 1, "int", &function_f0e25204, 0, 0);
  clientfield::register("actor", "" + # "hash_5f6e0119d9eee00c", 24000, getminbitcountfornum(2), "int", &function_1e07ed6f, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_78efd0fabb77e1ea", 24000, 1, "int", &function_ab446ca9, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7006a5e1e75527f3", 24000, 1, "int", &function_92c90a4f, 0, 0);
  clientfield::register("toplayer", "" + # "hash_45456ed33ab0037a", 24000, getminbitcountfornum(2), "int", &function_55488fca, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_bae11639a0dd182", 24000, 1, "int", &function_8f860b91, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_57e0dbfd7a91b69d", 24000, 1, "int", &function_90383e67, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7cd1cb3f455a77cf", 24000, 1, "int", &function_63f6e3bf, 0, 0);
  clientfield::register("world", "" + # "hash_4b15b3ade2772206", 24000, getminbitcountfornum(2), "int", &function_ab0de377, 0, 0);
  clientfield::register("toplayer", "" + # "hash_7857b61586fd957b", 24000, 1, "int", &function_5477ed5b, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_765ec7ef8a874f2a", 24000, 1, "int", &function_7c29d2b9, 0, 0);
  clientfield::register("world", "" + # "hash_3c1773045b663eac", 24000, 1, "counter", &function_ec198408, 0, 0);
  level.var_ecc60e04 = zm_corrupted_health_bar::register();
}

function function_ff7f32ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self setdamagedirectionindicator(1);
    return;
  }

  self setdamagedirectionindicator(0);
}

function function_910d2164(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_23e0d95c)) {
      self.var_23e0d95c = util::playFXOnTag(fieldname, #"sr/fx9_hvt_aether_portal_spawn", self, "tag_origin");
    }

    if(!isDefined(self.var_2095c8d1)) {
      self playSound(fieldname, #"hash_2acf7e3b4d9caf20");
      self.var_2095c8d1 = self playLoopSound(#"hash_a0772e7b77f2cd0");
    }

    wait 1;

    if(isDefined(self.var_23e0d95c)) {
      killfx(fieldname, self.var_23e0d95c);
      self.var_23e0d95c = undefined;
    }

    if(!isDefined(self.var_b55b7d2c)) {
      self.var_b55b7d2c = util::playFXOnTag(fieldname, #"sr/fx9_hvt_aether_move_trail", self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_23e0d95c)) {
    killfx(fieldname, self.var_23e0d95c);
    self.var_23e0d95c = undefined;
  }

  if(isDefined(self.var_2095c8d1)) {
    self playSound(fieldname, #"hash_60da5cd1a4e517a4");
    self stoploopsound(self.var_2095c8d1);
    self.var_2095c8d1 = undefined;
  }

  if(isDefined(self.var_b55b7d2c)) {
    playFX(fieldname, #"sr/fx9_hvt_aether_portal_close", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    stopfx(fieldname, self.var_b55b7d2c);
    self.var_b55b7d2c = undefined;
  }
}

function function_7e8bc554(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(level.var_75a7d6)) {
      level.var_75a7d6 = spawnStruct();
    }

    level.var_75a7d6.var_b39864d6 = self;

    if(!isDefined(self.var_c0a463e1)) {
      self.var_c0a463e1 = util::playFXOnTag(fieldname, #"hash_5be13a4419fa55fb", self, "j_spine4");
    }

    if(!isDefined(self.var_335c2bf0)) {
      self.var_335c2bf0 = util::playFXOnTag(fieldname, #"hash_4804636147cd94f2", self, "tag_eye");
    }

    return;
  }

  if(isDefined(self.var_c0a463e1)) {
    stopfx(fieldname, self.var_c0a463e1);
    self.var_c0a463e1 = undefined;
  }

  if(isDefined(self.var_335c2bf0)) {
    stopfx(fieldname, self.var_335c2bf0);
    self.var_335c2bf0 = undefined;
  }
}

function function_b42a918(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_491b980f)) {
      self playSound(fieldname, #"hash_5bde8748cc69381b");
      self.var_491b980f = self playLoopSound(#"hash_5bbf9148cc4e988a");
    }

    level thread function_b1dafc36(fieldname, self);
    return;
  }

  self notify(#"shield_down");

  if(isDefined(self.var_7a65e941)) {
    stopfx(fieldname, self.var_7a65e941);
    self.var_7a65e941 = undefined;
    playFX(fieldname, #"hash_1dd0c8b4b0fe470f", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }

  if(isDefined(self.var_491b980f)) {
    self stoploopsound(self.var_491b980f);
    self.var_491b980f = undefined;
    self playSound(fieldname, #"hash_72b7532d47bd53ee");
  }
}

function function_b1dafc36(localclientnum, mdl_shield) {
  if(!(isDefined(localclientnum) && isDefined(mdl_shield))) {
    return;
  }

  level endon(#"end_game");
  mdl_shield endon(#"death", #"shield_down");

  if(!isDefined(mdl_shield.var_7a65e941)) {
    playFX(localclientnum, #"hash_c315bd992f8066e", mdl_shield.origin, anglesToForward(mdl_shield.angles), anglestoup(mdl_shield.angles));
    wait 0.1;

    if(!isDefined(mdl_shield.var_7a65e941)) {
      mdl_shield.var_7a65e941 = playFX(localclientnum, #"hash_5ebd1476e8d77d48", mdl_shield.origin, anglesToForward(mdl_shield.angles), anglestoup(mdl_shield.angles));
    }
  }
}

function function_adfd1e5b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    if(!isDefined(self.var_9603e45f)) {
      self.var_9603e45f = playFX(fieldname, #"hash_111ade9d8d5d637a", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    if(!isDefined(self.var_15039a49)) {
      self playSound(fieldname, #"hash_2acf7e3b4d9caf20");
      self.var_15039a49 = self playLoopSound(#"hash_a0772e7b77f2cd0");
    }

    return;
  }

  if(bwasdemojump == 2) {
    if(!isDefined(self.var_9603e45f)) {
      self.var_9603e45f = playFX(fieldname, #"hash_111ade9d8d5d637a", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    if(!isDefined(self.var_15039a49)) {
      self playSound(fieldname, #"hash_1e3422ea889ea71e");
      self.var_15039a49 = self playLoopSound(#"hash_34c2153dde27eda2");
      self.var_ecf22cc9 = 1;
    }

    return;
  }

  if(isDefined(self.var_9603e45f)) {
    stopfx(fieldname, self.var_9603e45f);
    self.var_9603e45f = undefined;
  }

  if(isDefined(self.var_15039a49)) {
    var_6fa5e5b7 = # "hash_60da5cd1a4e517a4";

    if(is_true(self.var_ecf22cc9)) {
      var_6fa5e5b7 = # "hash_4dd42218144c8aa6";
    }

    self playSound(fieldname, var_6fa5e5b7);
    self stoploopsound(self.var_15039a49);
    self.var_15039a49 = undefined;
  }
}

function function_7c865e3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_76156b5f)) {
    stopfx(fieldname, self.var_76156b5f);
    self.var_76156b5f = undefined;
  }

  if(bwasdemojump > 0) {
    switch (bwasdemojump) {
      case 1:
        self.var_76156b5f = playFX(fieldname, #"hash_3cccd2d1a3de040", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
        break;
      case 2:
        self.var_76156b5f = playFX(fieldname, #"hash_20e36d2c5d741431", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
        break;
    }
  }
}

function function_fa856271(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_5fe5469 = struct::get(#"hash_354e705e79fe06be");

  if(isDefined(var_5fe5469)) {
    if(bwasdemojump == 1) {
      if(isDefined(var_5fe5469.var_19a4610b)) {
        deletefx(fieldname, var_5fe5469.var_19a4610b);
        var_5fe5469.var_19a4610b = undefined;
      }

      if(is_true(var_5fe5469.var_6badbd3e)) {
        var_5fe5469.var_6badbd3e = 0;
        soundstoplineemitter(#"hash_5c41490e65574ff8", (-2732, 15359, -346), (-2739, 16001, -346));
      }

      if(!isDefined(var_5fe5469.var_2e4e34b8)) {
        var_5fe5469.var_2e4e34b8 = playFX(fieldname, #"hash_2dfa091ea0178210", var_5fe5469.origin, anglesToForward(var_5fe5469.angles), anglestoup(var_5fe5469.angles));
      }

      if(!isDefined(var_5fe5469.var_19a4610b)) {
        var_5fe5469.var_19a4610b = playFX(fieldname, #"hash_5fc1d30d5faed916", var_5fe5469.origin, anglesToForward(var_5fe5469.angles), anglestoup(var_5fe5469.angles));
      }

      if(!is_true(var_5fe5469.var_61cce39d)) {
        var_5fe5469.var_61cce39d = 1;
        soundlineemitter(#"hash_2f4159fb0e4926bd", (-2732, 15359, -346), (-2739, 16001, -346));
      }

      if(!is_true(var_5fe5469.var_eff3437b)) {
        var_5fe5469.var_eff3437b = 1;
        soundlineemitter(#"hash_c6b813a63490e1c", (-2732, 15359, -346), (-2739, 16001, -346));
      }

      return;
    }

    if(bwasdemojump == 2) {
      if(isDefined(var_5fe5469.var_19a4610b)) {
        deletefx(fieldname, var_5fe5469.var_19a4610b);
        var_5fe5469.var_19a4610b = undefined;
      }

      if(is_true(var_5fe5469.var_eff3437b)) {
        var_5fe5469.var_eff3437b = 0;
        soundstoplineemitter(#"hash_c6b813a63490e1c", (-2732, 15359, -346), (-2739, 16001, -346));
      }

      if(!isDefined(var_5fe5469.var_2e4e34b8)) {
        var_5fe5469.var_2e4e34b8 = playFX(fieldname, #"hash_2dfa091ea0178210", var_5fe5469.origin, anglesToForward(var_5fe5469.angles), anglestoup(var_5fe5469.angles));
      }

      if(!isDefined(var_5fe5469.var_19a4610b)) {
        var_5fe5469.var_19a4610b = playFX(fieldname, #"hash_73401686a9756f9a", var_5fe5469.origin, anglesToForward(var_5fe5469.angles), anglestoup(var_5fe5469.angles));
      }

      if(!is_true(var_5fe5469.var_61cce39d)) {
        var_5fe5469.var_61cce39d = 1;
        soundlineemitter(#"hash_2f4159fb0e4926bd", (-2732, 15359, -346), (-2739, 16001, -346));
      }

      if(!is_true(var_5fe5469.var_6badbd3e)) {
        var_5fe5469.var_6badbd3e = 1;
        soundlineemitter(#"hash_5c41490e65574ff8", (-2732, 15359, -346), (-2739, 16001, -346));
        playSound(fieldname, #"hash_7f3850912c836968", (-2732, 15359, -346));
      }

      return;
    }

    if(isDefined(var_5fe5469.var_2e4e34b8)) {
      stopfx(fieldname, var_5fe5469.var_2e4e34b8);
      var_5fe5469.var_2e4e34b8 = undefined;
    }

    if(isDefined(var_5fe5469.var_19a4610b)) {
      stopfx(fieldname, var_5fe5469.var_19a4610b);
      var_5fe5469.var_19a4610b = undefined;
    }

    if(is_true(var_5fe5469.var_eff3437b)) {
      var_5fe5469.var_eff3437b = 0;
      soundstoplineemitter(#"hash_c6b813a63490e1c", (-2732, 15359, -346), (-2739, 16001, -346));
    }

    if(is_true(var_5fe5469.var_6badbd3e)) {
      var_5fe5469.var_6badbd3e = 0;
      soundstoplineemitter(#"hash_5c41490e65574ff8", (-2732, 15359, -346), (-2739, 16001, -346));
    }

    if(is_true(var_5fe5469.var_61cce39d)) {
      var_5fe5469.var_eff3437b = 0;
      soundstoplineemitter(#"hash_2f4159fb0e4926bd", (-2732, 15359, -346), (-2739, 16001, -346));
    }
  }
}

function function_d51885ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  v_origin = self.origin;
  v_forward = anglesToForward(self.angles);
  v_up = anglestoup(self.angles);
  n_fx = playFX(bwasdemojump, #"sr/fx9_obj_payload_aether_rift", v_origin, v_forward, v_up);
  wait 1;
  playFX(bwasdemojump, #"sr/fx9_obj_payload_aether_rift_close", v_origin, v_forward, v_up);
  killfx(bwasdemojump, n_fx);
}

function function_f0e25204(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_99c4ce87 = {
      #ai_target: self
    };
    level thread function_526b12c4(fieldname, self.var_99c4ce87);
    return;
  }

  if(isDefined(self.var_99c4ce87)) {
    self.var_99c4ce87 flag::set(#"stop");
  }
}

function function_526b12c4(localclientnum, var_99c4ce87) {
  for(var_b39864d6 = level.var_75a7d6.var_b39864d6; !isDefined(var_b39864d6); var_b39864d6 = level.var_75a7d6.var_b39864d6) {
    waitframe(1);
  }

  ai_target = var_99c4ce87.ai_target;

  if(!var_99c4ce87 flag::get(#"stop") && isalive(ai_target)) {
    mdl_beam = util::spawn_model(localclientnum, #"tag_origin");
    mdl_beam linkto(ai_target, "j_spine4");
    mdl_beam playSound(localclientnum, #"hash_52762fd483a6e3fa");
    mdl_beam.var_c7c0197d = mdl_beam playLoopSound(#"hash_48762d210569c49");
    beam::launch(var_b39864d6, "j_spine4", mdl_beam, "tag_origin", "beam9_zm_soo_drain_health", 1);

    while(!var_99c4ce87 flag::get(#"stop") && isalive(ai_target)) {
      waitframe(1);
    }

    mdl_beam playSound(localclientnum, #"hash_4a5adfe85c2cb7da");
    mdl_beam stoploopsound(mdl_beam.var_c7c0197d);
    mdl_beam unlink();
    beam::kill(var_b39864d6, "j_spine4", mdl_beam, "tag_origin", "beam9_zm_soo_drain_health");
    mdl_beam delete();
  }

  var_99c4ce87 struct::delete();
}

function function_1e07ed6f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 0:
      if(isDefined(self.var_2ff79f4f)) {
        stopfx(fieldname, self.var_2ff79f4f);
        self.var_2ff79f4f = undefined;
      }

      if(isDefined(self.var_407bbdf1)) {
        stopfx(fieldname, self.var_407bbdf1);
        self.var_407bbdf1 = undefined;
      }

      if(isDefined(self.var_3e5319de)) {
        self stoploopsound(self.var_3e5319de);
        self.var_3e5319de = undefined;
      }

      break;
    case 1:
      self playSound(fieldname, #"hash_6a8d5841140aeb5a");
      self.var_3e5319de = self playLoopSound(#"zmb_hellhound_loop_fire");
      break;
    case 2:
      if(isDefined(self.var_3e5319de)) {
        self stoploopsound(self.var_3e5319de);
        self.var_3e5319de = undefined;
      }

      self.var_407bbdf1 = util::playFXOnTag(fieldname, #"hash_1ece705913b0c51f", self, "j_spine4");
      break;
  }
}

function function_ab446ca9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_3a930436)) {
      self.var_3a930436 = util::playFXOnTag(fieldname, #"hash_fbbbc78fd7a92c2", self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_3a930436)) {
    stopfx(fieldname, self.var_3a930436);
    self.var_3a930436 = undefined;
  }
}

function function_92c90a4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_b57c337d)) {
      self.var_b57c337d = util::playFXOnTag(fieldname, #"hash_5df0a4ec3990860d", self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_b57c337d)) {
    stopfx(fieldname, self.var_b57c337d);
    self.var_b57c337d = undefined;
  }
}

function function_55488fca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(function_148ccc79(fieldname, #"hash_4a8a66363bf60fc1")) {
    codestoppostfxbundlelocal(fieldname, #"hash_4a8a66363bf60fc1");
  }

  if(function_148ccc79(fieldname, #"hash_6cb7165a57e6c770")) {
    codestoppostfxbundlelocal(fieldname, #"hash_6cb7165a57e6c770");
  }

  if(bwasdemojump > 0) {
    switch (bwasdemojump) {
      case 1:
        function_a837926b(fieldname, #"hash_4a8a66363bf60fc1");
        break;
      case 2:
        function_a837926b(fieldname, #"hash_6cb7165a57e6c770");
        break;
    }
  }
}

function function_8f860b91(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_e1b47bf)) {
      self.var_e1b47bf = util::playFXOnTag(fieldname, #"hash_504ddcf9ded4217c", self, "j_spine4");
    }

    if(!isDefined(self.var_ede94553)) {
      self.var_ede94553 = util::playFXOnTag(fieldname, #"hash_76a978e60d0e9ec1", self, "j_wrist_ri");
    }

    if(!isDefined(self.var_966bbf56)) {
      self.var_966bbf56 = util::playFXOnTag(fieldname, #"hash_4e5beb6703d25d5a", self, "j_wrist_ri");
    }

    if(!isDefined(self.var_60af28a9)) {
      self.var_60af28a9 = util::playFXOnTag(fieldname, #"hash_76a978e60d0e9ec1", self, "j_wrist_le");
    }

    if(!isDefined(self.var_694fe2b3)) {
      self.var_694fe2b3 = util::playFXOnTag(fieldname, #"hash_4e5beb6703d25d5a", self, "j_wrist_le");
    }

    level thread function_ab076c2e(fieldname, self);
    return;
  }

  if(isDefined(self.var_e1b47bf)) {
    stopfx(fieldname, self.var_e1b47bf);
    self.var_e1b47bf = undefined;
  }

  if(isDefined(self.var_ede94553)) {
    stopfx(fieldname, self.var_ede94553);
    self.var_ede94553 = undefined;
  }

  if(isDefined(self.var_966bbf56)) {
    stopfx(fieldname, self.var_966bbf56);
    self.var_966bbf56 = undefined;
  }

  if(isDefined(self.var_60af28a9)) {
    stopfx(fieldname, self.var_60af28a9);
    self.var_60af28a9 = undefined;
  }

  if(isDefined(self.var_694fe2b3)) {
    stopfx(fieldname, self.var_694fe2b3);
    self.var_694fe2b3 = undefined;
  }

  self notify(#"hash_1b3f15a04bc4d158");
  self stoprumble(fieldname, #"hash_23123e376b6cba91");
}

function function_ab076c2e(localclientnum, var_b39864d6) {
  if(!isDefined(var_b39864d6)) {
    return;
  }

  var_b39864d6 endon(#"death", #"hash_1b3f15a04bc4d158");
  var_b39864d6 playrumblelooponentity(localclientnum, #"hash_23123e376b6cba91");

  while(true) {
    var_b39864d6 playSound(localclientnum, #"hash_5de409a4b5a08239");
    wait 1;
  }
}

function function_90383e67(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_f252bba1)) {
      self.var_f252bba1 = util::playFXOnTag(fieldname, #"sr/fx9_hvt_aether_move_trail", self, "tag_origin");
    }

    if(!isDefined(self.var_fd2eefef)) {
      self playSound(fieldname, #"hash_5be3120a37873d9e");
      self.var_fd2eefef = self playLoopSound(#"hash_734cc0f685efb122");
    }

    return;
  }

  if(isDefined(self.var_f252bba1)) {
    stopfx(fieldname, self.var_f252bba1);
    self.var_f252bba1 = undefined;
  }

  if(isDefined(self.var_fd2eefef)) {
    self playSound(fieldname, #"hash_2758a7e5c0fac58b");
    self stoploopsound(self.var_fd2eefef);
    self.var_fd2eefef = undefined;
  }
}

function function_63f6e3bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!isDefined(self.var_7b99b6db)) {
      self.var_7b99b6db = playFX(fieldname, #"hash_5899b16f93de1dfd", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    return;
  }

  if(isDefined(self.var_7b99b6db)) {
    stopfx(fieldname, self.var_7b99b6db);
    self.var_7b99b6db = undefined;
  }
}

function function_ab0de377(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    switch (bwasdemojump) {
      case 1:
        var_3de77b5f = # "hash_6c62fd85414863a8";
        break;
      case 2:
        var_3de77b5f = # "hash_61d6690f3e92388a";
        break;
    }

    if(isDefined(var_3de77b5f)) {
      var_4263f449 = struct::get_array(var_3de77b5f);

      foreach(s_wall in var_4263f449) {
        if(isDefined(s_wall.fx) && !isDefined(s_wall.var_3483ac7b)) {
          var_2fd02f35 = undefined;

          switch (s_wall.fx) {
            case # "a":
              var_2fd02f35 = # "hash_303939bfec2470d3";
              break;
            case # "b":
              var_2fd02f35 = # "hash_30393abfec247286";
              break;
            case # "c":
              var_2fd02f35 = # "hash_30393bbfec247439";
              break;
            case # "d":
              var_2fd02f35 = # "hash_30393cbfec2475ec";
              break;
          }

          if(isDefined(var_2fd02f35)) {
            s_wall.var_3483ac7b = playFX(fieldname, var_2fd02f35, s_wall.origin, anglesToForward(s_wall.angles), anglestoup(s_wall.angles));
          }
        }
      }
    }

    return;
  }

  var_4263f449 = arraycombine(struct::get_array(#"hash_6c62fd85414863a8"), struct::get_array(#"hash_61d6690f3e92388a"));

  foreach(s_wall in var_4263f449) {
    if(isDefined(s_wall.var_3483ac7b)) {
      stopfx(fieldname, s_wall.var_3483ac7b);
      s_wall.var_3483ac7b = undefined;
    }
  }
}

function function_5477ed5b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(!self postfx::function_556665f2(#"hash_7fbc9bc489aea188")) {
      self postfx::playpostfxbundle(#"hash_7fbc9bc489aea188");
    }

    return;
  }

  if(self postfx::function_556665f2(#"hash_7fbc9bc489aea188")) {
    self postfx::exitpostfxbundle(#"hash_7fbc9bc489aea188");
  }
}

function function_7c29d2b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self playrenderoverridebundle(#"hash_6f9116d2e7ae0b59", "tag_rob_wire_electric_arcs");
    return;
  }

  self stoprenderoverridebundle(#"hash_6f9116d2e7ae0b59", "tag_rob_wire_electric_arcs");
}

function function_ec198408(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_e8a5ef56 = struct::get(#"nuke_warhead");

  if(isDefined(var_e8a5ef56.mdl)) {
    var_e8a5ef56.mdl hide();
  }

  var_324a4a44 = struct::get(#"nuke_warhead_riser");

  if(isDefined(var_324a4a44.mdl)) {
    var_324a4a44.mdl hide();
  }

  foreach(s_canister in struct::get_array(#"harvester_canister")) {
    if(isDefined(s_canister.mdl)) {
      s_canister.mdl hide();
    }

    if(isDefined(s_canister.var_358ffe83)) {
      stopfx(bwasdemojump, s_canister.var_358ffe83);
      s_canister.var_358ffe83 = undefined;
    }
  }
}