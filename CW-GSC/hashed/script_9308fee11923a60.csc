/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_9308fee11923a60.csc
***********************************************/

#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_b2add33c;

function event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "" + # "hash_699685336205339b", 1, 1, "int", &function_6020a772, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_1cf7ea5253c0a857", 1, 1, "int", &function_a1fa260e, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_2833af7211f19903", 1, 2, "int", &function_8c61edee, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7434dc21c6d7b515", 1, 2, "int", &function_3f561fa0, 0, 0);
  clientfield::register("vehicle", "" + # "hash_2c70ab0c21e69749", 1, 1, "int", &function_5bdf2437, 0, 0);
  util::waitforclient(0);
}

function function_6020a772(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    self.var_d6775c7 = util::playFXOnTag(fieldname, "sr/fx9_harvester_extraction_full_red", self, "tag_origin");
    self.var_eaf10c71 = self playLoopSound(#"hash_62a04f01f0efe5c7");
    return;
  }

  if(isDefined(self.var_d6775c7)) {
    stopfx(fieldname, self.var_d6775c7);
    self.var_d6775c7 = undefined;
  }

  if(isDefined(self.var_eaf10c71)) {
    self stoploopsound(self.var_eaf10c71);
    self.var_eaf10c71 = undefined;
  }
}

function function_a1fa260e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    self.var_ab01a657 = util::playFXOnTag(fieldname, "sr/fx9_harvester_extraction_full", self, "tag_origin");
    self.var_d7fa595b = self playLoopSound(#"hash_1be8fbcbcd0a09e1");
    return;
  }

  if(isDefined(self.var_ab01a657)) {
    stopfx(fieldname, self.var_ab01a657);
    self.var_ab01a657 = undefined;
  }

  if(isDefined(self.var_d7fa595b)) {
    self stoploopsound(self.var_d7fa595b);
    self.var_d7fa595b = undefined;
  }
}

function function_8c61edee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_660dd3dd = util::playFXOnTag(fieldname, "sr/fx9_harvester_extraction_charge", self, "tag_origin");
    playSound(fieldname, #"hash_117e07746b74905a", self.origin + (0, 0, 25));
    var_b2632866 = struct::get_array("vortex", "targetname");

    if(isDefined(var_b2632866)) {
      var_f3133091 = arraygetclosest(self.origin, var_b2632866);
    }

    v_up = vectornormalize(anglestoup(self.angles)) * 40 + self.origin;

    if(isDefined(var_f3133091) && isDefined(v_up)) {
      self.e_vortex = util::spawn_model(fieldname, "tag_origin", var_f3133091.origin + (0, 0, 50));
      self.var_b5bdd2b9 = util::spawn_model(fieldname, "tag_origin", v_up);
    }

    wait 0.1;

    if(isDefined(self) && isDefined(self.e_vortex) && isDefined(self.var_b5bdd2b9)) {
      self.var_b5bdd2b9.angles = (-90, 0, 0);

      if(bwastimejump == 1) {
        self.var_40433812 = util::playFXOnTag(fieldname, "sr/fx9_harvester_extraction_source_01", self.e_vortex, "tag_origin");
        self.var_221b7b06 = util::playFXOnTag(fieldname, "sr/fx9_harvester_extraction_target_01", self.var_b5bdd2b9, "tag_origin");
        self.var_b3f4d513 = self playLoopSound(#"hash_61133944ebd5c4ea");
      } else {
        wait 0.2;

        if(isDefined(self) && isDefined(self.e_vortex) && isDefined(self.var_b5bdd2b9)) {
          self.var_40433812 = util::playFXOnTag(fieldname, "sr/fx9_harvester_extraction_source_02", self.e_vortex, "tag_origin");
          self.var_221b7b06 = util::playFXOnTag(fieldname, "sr/fx9_harvester_extraction_target_02", self.var_b5bdd2b9, "tag_origin");
          self.var_b3f4d513 = self playLoopSound(#"hash_61133944ebd5c4ea");
        }
      }
    }

    return;
  }

  if(isDefined(self.var_40433812)) {
    stopfx(fieldname, self.var_40433812);
    self.var_40433812 = undefined;
  }

  if(isDefined(self.var_221b7b06)) {
    stopfx(fieldname, self.var_221b7b06);
    self.var_221b7b06 = undefined;
  }

  if(isDefined(self.var_b3f4d513)) {
    self stoploopsound(self.var_b3f4d513);
    self.var_b3f4d513 = undefined;
  }

  wait 0.1;

  if(isDefined(self) && isDefined(self.var_660dd3dd)) {
    stopfx(fieldname, self.var_660dd3dd);
    self.var_660dd3dd = undefined;
  }
}

function function_5bdf2437(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_e794d6cd = util::playFXOnTag(fieldname, "sr/fx9_obj_dark_aether_tornado_prompt", self, "tag_origin");
    playSound(fieldname, #"hash_cc9ea7c69058a60", self.origin + (0, 0, 25));

    if(isDefined(self gettagorigin("tag_body"))) {
      self.var_4ff7bf25 = util::playFXOnTag(fieldname, "vehicle/fx9_vdest_emp_ru_transport_truck", self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_e794d6cd)) {
    stopfx(fieldname, self.var_e794d6cd);
    self.var_e794d6cd = undefined;
  }

  if(isDefined(self.var_4ff7bf25)) {
    stopfx(fieldname, self.var_4ff7bf25);
    self.var_4ff7bf25 = undefined;
  }
}

function function_3f561fa0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    self.var_3c825826 = util::playFXOnTag(fieldname, "sr/fx9_obj_dark_aether_tornado_stage_01", self, "tag_origin");
    self.var_f2e155e9 = util::playFXOnTag(fieldname, "sr/fx9_obj_dark_aether_tornado_range", self, "tag_origin");
    playSound(fieldname, #"hash_1675f638be9b3ef2", self.origin + (0, 0, 25));
    self.var_6ca1bf85 = self playLoopSound(#"hash_2bd7c24a8903f88d");
    return;
  }

  if(bwastimejump === 2) {
    if(isDefined(self.var_3c825826)) {
      stopfx(fieldname, self.var_3c825826);
      self.var_3c825826 = undefined;
    }

    if(isDefined(self.var_6ca1bf85)) {
      self stoploopsound(self.var_6ca1bf85);
      self.var_6ca1bf85 = undefined;
    }

    if(isDefined(self)) {
      self.var_3c825826 = util::playFXOnTag(fieldname, "sr/fx9_obj_dark_aether_tornado_stage_02", self, "tag_origin");
      playSound(fieldname, #"hash_1675f638be9b3ef2", self.origin + (0, 0, 25));
      self.var_6ca1bf85 = self playLoopSound(#"hash_2bd7bf4a8903f374");
    }

    wait 10;

    if(isDefined(self.var_3c825826)) {
      stopfx(fieldname, self.var_3c825826);
      self.var_3c825826 = undefined;
    }

    if(isDefined(self.var_6ca1bf85)) {
      self stoploopsound(self.var_6ca1bf85);
      self.var_6ca1bf85 = undefined;
    }

    if(isDefined(self)) {
      self.var_3c825826 = util::playFXOnTag(fieldname, "sr/fx9_obj_dark_aether_tornado_stage_03", self, "tag_origin");
      playSound(fieldname, #"hash_1675f638be9b3ef2", self.origin + (0, 0, 25));
      self.var_6ca1bf85 = self playLoopSound(#"hash_2bd7c04a8903f527");
    }

    return;
  }

  if(isDefined(self.var_3c825826)) {
    stopfx(fieldname, self.var_3c825826);
    self.var_3c825826 = undefined;
  }

  if(isDefined(self.var_f2e155e9)) {
    stopfx(fieldname, self.var_f2e155e9);
    self.var_f2e155e9 = undefined;
  }

  if(isDefined(self.var_6ca1bf85)) {
    self stoploopsound(self.var_6ca1bf85);
    self.var_6ca1bf85 = undefined;
  }

  playSound(fieldname, #"hash_266828a54f3b3f36", self.origin + (0, 0, 25));
  util::playFXOnTag(fieldname, "sr/fx9_obj_dark_aether_tornado_ending", self, "tag_origin");
}