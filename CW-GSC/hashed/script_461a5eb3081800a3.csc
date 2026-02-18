/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_461a5eb3081800a3.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace namespace_bff7ce85;

function event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "" + # "screen_left", 1, 1, "int", &function_471ae845, 0, 0);
  clientfield::register("scriptmover", "" + # "screen_right", 1, 1, "int", &function_fb755c48, 0, 0);
  clientfield::register("scriptmover", "" + # "screen_top", 1, 1, "int", &function_6115628b, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_225aa48dd3b91fe7", 1, 1, "int", &function_9fdbcf3f, 0, 0);
  clientfield::register("scriptmover", "" + # "console_lights", 1, 1, "int", &console_lights, 0, 0);
  clientfield::register("scriptmover", "" + # "console_kill", 1, 1, "counter", &console_kill, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_18bcf106c476dfeb", 1, 1, "counter", &function_32398bfc, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_186c35405f4624bc", 1, 2, "int", &function_968ccb74, 0, 0);
  clientfield::register("vehicle", "" + # "vehicle_teleport", 1, 1, "counter", &function_b0e818e8, 0, 0);
  util::waitforclient(0);
}

function function_6115628b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!is_true(self.var_4839a4f1)) {
      self.var_3310aa30 = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_light_top_red", self, "tag_origin");
      self.var_4839a4f1 = 1;
    } else {
      util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_light_top_green", self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_3310aa30)) {
    stopfx(fieldname, self.var_3310aa30);
    self.var_3310aa30 = undefined;
  }
}

function function_fb755c48(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(isDefined(self.var_52b34507)) {
      stopfx(fieldname, self.var_52b34507);
      self.var_52b34507 = undefined;
    }

    if(!is_true(self.var_71751fa0)) {
      self.var_715359c = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_screen_ri_on", self, "tag_origin");
      self.var_71751fa0 = 1;
    }

    return;
  }

  if(isDefined(self.var_715359c)) {
    stopfx(fieldname, self.var_715359c);
    self.var_715359c = undefined;
  }

  self.var_52b34507 = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_screen_ri_flicker", self, "tag_origin");
}

function function_471ae845(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(isDefined(self.var_c387008e)) {
      stopfx(fieldname, self.var_c387008e);
      self.var_c387008e = undefined;
    }

    if(!is_true(self.var_5e062dbb)) {
      self.var_188a7737 = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_screen_le_on", self, "tag_origin");
      self.var_5e062dbb = 1;
    }

    return;
  }

  if(isDefined(self.var_188a7737)) {
    stopfx(fieldname, self.var_188a7737);
    self.var_188a7737 = undefined;
  }

  self.var_c387008e = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_screen_le_flicker", self, "tag_origin");
}

function function_9fdbcf3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_2a38de43 = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_vat_amb", self, "tag_origin");
    playSound(fieldname, #"hash_4c3810ceaa5ffc33", self.origin + (0, 0, 50));
    self.var_847c4a7c = self playLoopSound(#"hash_17bbbc791e17bbc5", undefined, (0, 0, 50));
    return;
  }

  if(isDefined(self.var_2a38de43)) {
    stopfx(fieldname, self.var_2a38de43);
    self.var_2a38de43 = undefined;
  }

  if(isDefined(self.var_847c4a7c)) {
    self stoploopsound(self.var_847c4a7c);
    self.var_847c4a7c = undefined;
  }

  self.var_dc761849 = self playLoopSound(#"hash_6510ab3b31555de5", undefined, (0, 0, 50));
  playSound(fieldname, #"hash_789c0cb38cd0abb0", self.origin + (0, 0, 50));
  playSound(fieldname, #"hash_61887905bfa93f51", self.origin + (0, 0, 50));
  util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_head_gib", self, "tag_origin");
}

function console_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self endon(#"death");
    self playrenderoverridebundle(#"hash_5e09fb8e239d3dd3");
    self function_78233d29(#"hash_5e09fb8e239d3dd3", "", "Brightness", 1);
    self function_78233d29(#"hash_5e09fb8e239d3dd3", "", "Tint", 1);
    self.var_7cf04bb1 = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_vat_lights", self, "tag_tank_lights_d0");
    playSound(fieldname, #"hash_7907685913534e0", self.origin + (0, 0, 50));
    return;
  }

  self stoprenderoverridebundle(#"hash_5e09fb8e239d3dd3");

  if(isDefined(self.var_7cf04bb1)) {
    stopfx(fieldname, self.var_7cf04bb1);
    self.var_7cf04bb1 = undefined;
  }
}

function function_b0e818e8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(bwastimejump, "sr/fx9_obj_exploitative_teleporting", self, "tag_origin");
}

function console_kill(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(bwastimejump, "explosions/fx8_exp_elec_killstreak", self.origin + (0, 0, 32), anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(self.var_6631a14f)) {
    self stoploopsound(self.var_6631a14f);
    self.var_6631a14f = undefined;
  }

  if(isDefined(self.var_6711e9c2)) {
    self stoploopsound(self.var_6711e9c2);
    self.var_6711e9c2 = undefined;
  }
}

function function_e15dd642(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(bwastimejump, "explosions/fx9_exp_generic_lg", self, "tag_origin");
  playSound(bwastimejump, #"hash_37863fcbc135faa0", self.origin + (0, 0, 50));

  if(isDefined(self.var_6631a14f)) {
    self stoploopsound(self.var_6631a14f);
    self.var_6631a14f = undefined;
  }

  if(isDefined(self.var_6711e9c2)) {
    self stoploopsound(self.var_6711e9c2);
    self.var_6711e9c2 = undefined;
  }
}

function function_32398bfc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(bwastimejump, "sr/fx9_obj_console_defend_dmg_os", self, "tag_origin");
  playSound(bwastimejump, #"hash_1ddeb8af5a217a6e", self.origin + (0, 0, 50));
  self thread function_356a7b78();
}

function function_356a7b78() {
  self notify("1ecded79cbe06af5");
  self endon("1ecded79cbe06af5");

  if(!isDefined(self.var_6631a14f)) {
    self.var_6631a14f = self playLoopSound(#"hash_13e3f89e22beb505", undefined, (0, 0, 50));
  }

  wait 5;

  if(isDefined(self.var_6631a14f)) {
    self stoploopsound(self.var_6631a14f);
    self.var_6631a14f = undefined;
  }
}

function function_968ccb74(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_bccdae1e = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_dmg_state_1", self, "tag_origin");
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_bccdae1e)) {
      stopfx(fieldname, self.var_bccdae1e);
    }

    self.var_f3fe9c83 = util::playFXOnTag(fieldname, "sr/fx9_obj_console_defend_dmg_state_2", self, "tag_origin");

    if(!isDefined(self.var_6711e9c2)) {
      self.var_6711e9c2 = self playLoopSound(#"hash_f32639ea79bff56", undefined, (0, 0, 50));
    }
  }
}