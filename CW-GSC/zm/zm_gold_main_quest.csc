/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_gold_main_quest.csc
***********************************************/

#using script_1a6b18d8e5bf3274;
#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace zm_gold_main_quest;

function init() {
  clientfield::register("scriptmover", "" + # "hash_6f292901e2fcaeb3", 16000, 1, "int", &function_48f7c5e6, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5eccf9a3ab802cf7", 16000, 1, "int", &function_568ae388, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_571f15e1b82b6e1e", 16000, 1, "int", &function_78d36eb1, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_13b42b800d7ddc38", 16000, 1, "counter", &function_e959dd37, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4e18b4bbb52e74bb", 16000, 2, "int", &function_db002447, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_a3ff7de846a027f", 16000, 1, "counter", &function_3131e413, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_3ee70ebc06c36969", 16000, 1, "int", &function_e7b6b97f, 0, 0);
  clientfield::register("world", "" + # "hash_493518ca957daaea", 16000, 2, "int", &function_49331ac6, 0, 0);
  clientfield::register("actor", "" + # "hash_7dc2e40e04fdfbad", 16000, 1, "counter", &function_807a046, 0, 0);
  clientfield::register("toplayer", "" + # "hash_5120ca20225a7324", 16000, 1, "counter", &function_95631678, 0, 0);
  clientfield::register("world", "" + # "hash_2e532832d80e7afb", 16000, 1, "int", &function_db150da1, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_33a2a9faed4bf8d9", 16000, 1, "int", &function_9f3ff6fa, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5db889fa88fbbe02", 16000, getminbitcountfornum(4), "int", &function_d3dcbd21, 0, 0);
  clientfield::register("scriptmover", "" + # "dome_shader", 16000, 1, "int", &dome_shader, 0, 0);
  clientfield::register("toplayer", "" + # "hash_d4826b65faa9efb", 16000, 1, "int", &function_996f5d0f, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6ab08e0e1cffcd35", 16000, 1, "int", &function_b66e99f1, 0, 0);
  clientfield::register("world", "" + # "hash_6c7ee343dab35f07", 16000, 1, "int", &function_789ec6a8, 0, 0);

  if(!zm_utility::is_ee_enabled()) {
    return;
  }

  audio::playloopat(#"hash_5486b66cc8fd5daf", (1185, -14801, 7544));
}

function function_48f7c5e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_eb1526b6 = getEntArray(fieldname, "sub_satellite_fx_pos", "targetname");

  if(isDefined(self.var_358ffe83) && bwasdemojump == 0) {
    stopfx(fieldname, self.var_358ffe83);
    self.var_358ffe83 = undefined;

    if(isDefined(var_eb1526b6) && isarray(var_eb1526b6)) {
      foreach(sub_satellite_fx_pos in var_eb1526b6) {
        if(isDefined(sub_satellite_fx_pos.fx)) {
          stopfx(fieldname, sub_satellite_fx_pos.fx);

          if(isDefined(sub_satellite_fx_pos.tag_fx)) {
            sub_satellite_fx_pos.tag_fx delete();
          }

          sub_satellite_fx_pos.fx = undefined;
        }
      }
    }

    soundstoplineemitter(#"hash_243e8130bf816d5a", (478, -15202, 7913), (-2140, -15285, 8125));
    soundstoplineemitter(#"hash_243e8130bf816d5a", (-1414, -12858, 7953), (-2629, -14667, 8124));
    soundstoploopemitter(#"hash_243e8030bf816ba7", (-2420, -15288, 8946));
  }

  if(bwasdemojump == 1) {
    self.var_358ffe83 = playFX(fieldname, #"hash_4b0034bfed0b13a0", self.origin, anglestoup(self.angles), anglesToForward(self.angles));

    foreach(sub_satellite_fx_pos in var_eb1526b6) {
      sub_satellite_fx_pos.tag_fx = sub_satellite_fx_pos util::spawn_model(fieldname, "tag_origin", sub_satellite_fx_pos.origin, sub_satellite_fx_pos.angles);

      if(sub_satellite_fx_pos.script_noteworthy === "a") {
        sub_satellite_fx_pos.fx = util::playFXOnTag(fieldname, #"hash_4142f503f17f18c4", sub_satellite_fx_pos.tag_fx, "tag_origin");
        continue;
      }

      if(sub_satellite_fx_pos.script_noteworthy === "b") {
        sub_satellite_fx_pos.fx = util::playFXOnTag(fieldname, #"hash_4142f803f17f1ddd", sub_satellite_fx_pos.tag_fx, "tag_origin");
      }
    }

    soundlineemitter(#"hash_243e8130bf816d5a", (478, -15202, 7913), (-2140, -15285, 8125));
    soundlineemitter(#"hash_243e8130bf816d5a", (-1414, -12858, 7953), (-2629, -14667, 8124));
    soundloopemitter(#"hash_243e8030bf816ba7", (-2420, -15288, 8946));
    playSound(fieldname, #"hash_4df142dbfba464a5", (-2420, -15288, 8946));
  }
}

function function_568ae388(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_26744ea3) && bwasdemojump == 0) {
    stopfx(fieldname, self.var_26744ea3);
    self.var_26744ea3 = undefined;
  }

  if(isDefined(self.var_9c6901af) && bwasdemojump == 0) {
    self stoploopsound(self.var_9c6901af);
    self.var_9c6901af = undefined;
  }

  if(bwasdemojump == 1) {
    self.var_26744ea3 = util::playFXOnTag(fieldname, #"hash_2a9626fe3370478a", self, "tag_origin");
    self.var_9c6901af = self playLoopSound(#"hash_119a5143df1f68a3");
  }
}

function function_e959dd37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.var_c0bb3c24 = util::playFXOnTag(fieldname, #"hash_2d3f8010b76159ce", self, "tag_origin");
    playSound(fieldname, #"hash_70b219027e1ccc25", self.origin);
  }
}

function function_78d36eb1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self notify(#"hash_3a4fef0fcbf96242");

  if(bwasdemojump == 1) {
    util::playFXOnTag(fieldname, #"wz/fx9_dirtybomb_radiation_zone", self, "tag_origin");
    util::playFXOnTag(fieldname, #"wz/fx9_dirtybomb_radiation_zone_spawn", self, "tag_origin");
    self setcompassicon("ui_icon_minimap_collapse_ring");
    self function_811196d1(0);
    self function_95bc465d(1);
    self function_5e00861(0, 1);
    self function_60212003(1);
    self function_a5edb367(#"death_ring");
    self.var_2c8e49d2 = util::spawn_model(fieldname, #"p8_big_cylinder", self.origin);
    self.var_2c8e49d2 playrenderoverridebundle(#"hash_75168376918f5ab7");
    self.var_2c8e49d2 linkto(self);
    self thread function_1fd7d1f6();
    return;
  }

  self function_811196d1(1);
}

function private function_1fd7d1f6() {
  self endoncallback(&function_ea1d7a10, #"death", #"hash_3a4fef0fcbf96242");

  while(isDefined(self.scale)) {
    if(isDefined(self.var_2c8e49d2)) {
      self.var_2c8e49d2 function_78233d29(#"hash_75168376918f5ab7", "", "Scale", self.scale / 10);
    }

    self function_5e00861(self.scale * 15000 * 2, 1);
    waitframe(1);
  }
}

function private function_ea1d7a10(str_notify) {
  if(isDefined(self.var_2c8e49d2)) {
    self.var_2c8e49d2 stoprenderoverridebundle(#"hash_75168376918f5ab7");
    self.var_2c8e49d2 delete();
  }
}

function function_db002447(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    if(isDefined(self.light_fx)) {
      stopfx(fieldname, self.light_fx);
      self.light_fx = undefined;
    }

    self.light_fx = util::playFXOnTag(fieldname, #"hash_633f2df6ae6816e0", self, "tag_light_green");
    playSound(fieldname, #"hash_20bed6eda7747275", self gettagorigin("tag_light_green"));
    return;
  }

  if(bwasdemojump == 2) {
    if(isDefined(self.light_fx)) {
      stopfx(fieldname, self.light_fx);
      self.light_fx = undefined;
    }

    self.light_fx = util::playFXOnTag(fieldname, #"hash_59733e6d889d820", self, "tag_light_brown");
  }
}

function function_3131e413(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.fx = playFX(fieldname, #"zm_ai/fx9_mimic_prop_spawn_out", self.origin + (0, 0, 15), anglesToForward(self.angles), anglestoup(self.angles));
    playSound(fieldname, #"hash_41dc3cf755c57009", self.origin + (0, 0, 15));
  }
}

function private function_49331ac6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  fx_pos = struct::get("ac_pink_fog_pos", "targetname");

  if(bwasdemojump == 1) {
    if(isDefined(level.var_d7691d5b[fieldname])) {
      stopfx(fieldname, level.var_d7691d5b[fieldname]);
      level.var_d7691d5b[fieldname] = undefined;
    }

    level.var_7c32c8a2[fieldname] = playFX(fieldname, #"hash_104349ebfbff1850", fx_pos.origin, fx_pos.angles);
    return;
  }

  if(bwasdemojump == 2) {
    if(isDefined(level.var_7c32c8a2[fieldname])) {
      stopfx(fieldname, level.var_7c32c8a2[fieldname]);
      level.var_7c32c8a2[fieldname] = undefined;
    }

    level.var_d7691d5b[fieldname] = playFX(fieldname, #"hash_44eda83cbe4d8294", fx_pos.origin, fx_pos.angles);
    return;
  }

  if(isDefined(level.var_7c32c8a2[fieldname])) {
    stopfx(fieldname, level.var_7c32c8a2[fieldname]);
    level.var_7c32c8a2[fieldname] = undefined;
  }

  if(isDefined(level.var_d7691d5b[fieldname])) {
    stopfx(fieldname, level.var_d7691d5b[fieldname]);
    level.var_d7691d5b[fieldname] = undefined;
  }
}

function function_e7b6b97f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 0) {
    if(isDefined(self.var_f6517ec8)) {
      stopfx(fieldname, self.var_f6517ec8);
      self.var_f6517ec8 = undefined;
    }

    if(isDefined(self.var_7aebf849)) {
      self stoploopsound(self.var_7aebf849);
      self.var_7aebf849 = undefined;
    }

    return;
  }

  if(bwasdemojump == 1) {
    self.var_f6517ec8 = playFX(fieldname, #"hash_f84006d38f5f724", self.origin, anglesToForward(self.angles), anglestoup(self.angles));

    if(!isDefined(self.var_7aebf849)) {
      self.var_7aebf849 = self playLoopSound(#"hash_616630af61302134", undefined, (0, 0, 25));
    }
  }
}

function function_807a046(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    util::playFXOnTag(fieldname, #"zm_ai/fx9_mimic_prop_spawn_out", self, "j_spinelower");
  }
}

function function_95631678(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    playSound(fieldname, #"hash_7b48ab684f546cde", (0, 0, 0));
    earthquake(fieldname, 0.25, 4, self.origin, 10000);
    self playrumbleonentity(fieldname, #"hash_7a5e120ae2a2d457");
  }
}

function function_db150da1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_3c563df1 = struct::get("projector_pos", "targetname");

  if(bwasdemojump == 0 && isDefined(var_3c563df1.var_85d0a40f)) {
    function_c22a1ca2(#"hash_52628b1a34838199");
    stopfx(fieldname, var_3c563df1.var_85d0a40f);
    var_3c563df1.var_85d0a40f = undefined;
    return;
  }

  if(bwasdemojump == 1) {
    function_3385d776(#"hash_52628b1a34838199");
    var_3c563df1.var_85d0a40f = playFX(fieldname, #"hash_52628b1a34838199", var_3c563df1.origin, anglesToForward(var_3c563df1.angles), anglestoup(var_3c563df1.angles));
  }
}

function function_9f3ff6fa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    var_78defe05 = self gettagorigin("tag_light");
    var_99387adc = (0, 90, 23);
    self.var_d743d165 = playFX(fieldname, #"hash_3099197b59290f24", var_78defe05, anglesToForward(var_99387adc), anglestoup(var_99387adc));
    return;
  }

  if(isDefined(self.var_d743d165)) {
    stopfx(fieldname, self.var_d743d165);
    self.var_d743d165 = undefined;
  }
}

function function_d3dcbd21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 0:
      if(isDefined(self.var_799cf4f)) {
        stopfx(fieldname, self.var_799cf4f);
        self.var_799cf4f = undefined;
      }

      if(isDefined(self.var_614e859)) {
        playSound(fieldname, #"hash_3d369627caa2ec0e", self.origin + (0, 0, 10));
        self stoploopsound(self.var_614e859);
        self.var_614e859 = undefined;
      }

      return;
    case 1:
      str_fx = # "hash_583109873d692b3d";
      break;
    case 2:
      str_fx = # "hash_3e89c687f8e00739";
      break;
    case 3:
      str_fx = # "hash_7178b6fbac52be02";
      break;
    case 4:
      str_fx = # "hash_bdf528c41738ef5";
      break;
  }

  if(!isDefined(self.var_799cf4f)) {
    self.var_799cf4f = util::playFXOnTag(fieldname, str_fx, self, "tag_origin");
  }

  if(!isDefined(self.var_614e859)) {
    self.var_614e859 = self playLoopSound(#"hash_53037a2c92d808ce", undefined, (0, 0, 10));
  }
}

function dome_shader(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self playrenderoverridebundle(#"hash_33472031c8a872cd");
    self playSound(fieldname, #"hash_1bf3ee4eb2a58e82");
    return;
  }

  self stoprenderoverridebundle(#"hash_33472031c8a872cd");
  self playSound(fieldname, #"hash_3a07d2cfdb8bbda7");
}

function function_996f5d0f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwasdemojump) {
    if(!isDefined(self.var_ca8b5a42)) {
      self.var_ca8b5a42 = playtagfxset(fieldname, #"hash_3fecf62fe603c35e", self);
    }

    if(!isDefined(self.var_79abcb8a)) {
      self.var_79abcb8a = playfxoncamera(fieldname, #"hash_4c2a73ebbc177abd");
    }

    if(!isDefined(self.var_38a54dff)) {
      self playSound(fieldname, #"hash_2769cc33e55105ad");
      self.var_38a54dff = self playLoopSound(#"hash_1bcf487baf93b873");
    }

    return;
  }

  if(isDefined(self.var_ca8b5a42)) {
    foreach(n_fx in self.var_ca8b5a42) {
      stopfx(fieldname, n_fx);
    }

    self.var_ca8b5a42 = undefined;
  }

  if(isDefined(self.var_79abcb8a)) {
    stopfx(fieldname, self.var_79abcb8a);
    self.var_79abcb8a = undefined;
  }

  if(isDefined(self.var_38a54dff)) {
    self playSound(fieldname, #"hash_585da2b2a9d85b4");
    self stoploopsound(self.var_38a54dff);
    self.var_38a54dff = undefined;
  }
}

function function_b66e99f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  a_s_fx = struct::get_array(#"hash_70b3330384335c42");

  if(bwasdemojump) {
    if(!isDefined(self.var_63f32da)) {
      self.var_63f32da = playFX(fieldname, #"hash_1a40f9087395c9d7", self.origin + (0, 0, 12));
    }

    if(!isDefined(self.var_5eec2cf6)) {
      self.var_5eec2cf6 = playFX(fieldname, #"zm_ai/fx9_steiner_rad_bomb_circle_128", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    foreach(s_fx in a_s_fx) {
      if(!isDefined(s_fx.var_bdfdbc4d)) {
        switch (s_fx.str_fx) {
          case # "sm":
            str_fx = # "zm_ai/fx9_steiner_rad_bomb_spot_sm_loop";
            break;
          case # "md":
            str_fx = # "zm_ai/fx9_steiner_rad_bomb_spot_md_loop";
            break;
          case # "lg":
            str_fx = # "zm_ai/fx9_steiner_rad_bomb_spot_lg_loop";
            break;
        }

        s_fx.var_bdfdbc4d = playFX(fieldname, str_fx, s_fx.origin, anglesToForward(s_fx.angles), anglestoup(s_fx.angles));
      }
    }

    if(!isDefined(self.var_636b7150)) {
      self.var_636b7150 = self playLoopSound(#"hash_619b977bec2f141b");
    }

    return;
  }

  if(isDefined(self.var_63f32da)) {
    stopfx(fieldname, self.var_63f32da);
    self.var_63f32da = undefined;
  }

  if(isDefined(self.var_5eec2cf6)) {
    stopfx(fieldname, self.var_5eec2cf6);
    self.var_5eec2cf6 = undefined;
  }

  foreach(s_fx in a_s_fx) {
    if(isDefined(s_fx.var_bdfdbc4d)) {
      stopfx(fieldname, s_fx.var_bdfdbc4d);
      s_fx.var_bdfdbc4d = undefined;
    }
  }

  if(isDefined(self.var_636b7150)) {
    self stoploopsound(self.var_636b7150);
    self.var_636b7150 = undefined;
  }
}

function function_789ec6a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_f1dac484 = struct::get_array("sfx_alarm_exterior", "targetname");
  var_553477e6 = struct::get_array("sfx_alarm_interior", "targetname");

  if(bwasdemojump) {
    foreach(struct in var_f1dac484) {
      soundloopemitter(#"hash_76fa33e1cfb612e0", struct.origin);
    }

    foreach(struct in var_553477e6) {
      soundloopemitter(#"hash_79477ec16ce75a", struct.origin);
    }

    return;
  }

  foreach(struct in var_f1dac484) {
    soundstoploopemitter(#"hash_76fa33e1cfb612e0", struct.origin);
  }

  foreach(struct in var_553477e6) {
    soundstoploopemitter(#"hash_79477ec16ce75a", struct.origin);
  }
}