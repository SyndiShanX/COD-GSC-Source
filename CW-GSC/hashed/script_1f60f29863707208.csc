/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1f60f29863707208.csc
***********************************************/

#using script_51c90b6047d3caf4;
#using script_60793766a26de8df;
#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace zm_platinum_main_quest;

function init() {
  clientfield::register("scriptmover", "" + # "hash_6f292901e2fcaeb3", 24000, getminbitcountfornum(2), "int", &function_48f7c5e6, 0, 0);
  clientfield::register("actor", "" + # "zombie_soul", 24000, 1, "int", &function_bb5d646a, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_31c00da72502364a", 24000, 1, "int", &function_21d26f5b, 0, 0);
  clientfield::register("toplayer", "" + # "hash_5b2bd379d1c938ac", 24000, 1, "int", &function_1cd2646f, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_344c9d30da0bff4f", 24000, 1, "counter", &function_eb8ccdd, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_588a5a1ddff05b46", 24000, 1, "int", &function_a6554e90, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4c1ff67b48ab2fd0", 24000, 1, "int", &function_a342165a, 0, 0);
  clientfield::register("world", "" + # "hash_74ef16bbfe861136", 24000, 1, "int", &function_5907109e, 0, 0);
  clientfield::register("toplayer", "" + # "hash_7f481e663b9fb61b", 24000, 1, "int", &function_fbaa949a, 0, 0);
  clientfield::register("world", "" + # "hash_ec75a4d51d27449", 24000, 1, "int", &function_5cf50136, 0, 0);
  clientfield::register("world", "" + # "hash_42e33e65c5c15242", 24000, 1, "int", &function_2906accd, 0, 0);
  clientfield::register("toplayer", "" + # "hash_67d900e4df2ea942", 24000, 1, "int", &function_6b932134, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_60e4230d63925ac1", 24000, 1, "int", &function_60886116, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6d758f70ffcac945", 24000, 1, "int", &function_f7c615a4, 0, 0);
  clientfield::register("actor", "" + # "hash_3db79576e67b8cbd", 24000, 2, "int", &function_fda7f886, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_1bb601e9156b597c", 24000, 1, "int", &function_1d33d741, 0, 0);
  clientfield::register("world", "" + # "hash_2970fad3e14148a0", 24000, 1, "int", &function_6d56f7a8, 0, 0);
  clientfield::register("world", "" + # "hash_763dd8035e80f7c", 1, 1, "int", &function_44dc8dc9, 0, 0);
  clientfield::register("world", "" + # "hash_71cc27de592d837", 24000, 1, "counter", &function_6774a2f2, 0, 0);
  clientfield::register("world", "" + # "hash_511715e7849a3721", 24000, 1, "int", &function_a28ff742, 0, 0);
  clientfield::register("world", "" + # "hash_3aba3806862f8cd7", 24000, 1, "counter", &function_296ed7c6, 0, 0);
  clientfield::register("world", "" + # "hash_564f26adf2d2fb01", 24000, 1, "int", &function_fb770d12, 0, 0);
  clientfield::register("world", "" + # "hash_2a6acb420c3bb07e", 24000, 1, "int", &function_850f10bc, 0, 0);
  clientfield::register("world", "" + # "hash_43c03ae4aff2ba0", 24000, 3, "int", &function_9b69f640, 0, 0);
  clientfield::register("world", "" + # "hash_1775e41085aba683", 24000, 1, "int", &function_c9b5b294, 0, 0);
  clientfield::register("actor", "" + # "hash_b74182bd1e44a44", 24000, 1, "int", &function_cdc867b2, 0, 0);
  clientfield::register("actor", "" + # "hash_435db79c304e12a5", 24000, 1, "counter", &function_f15a1018, 0, 0);
  clientfield::register("actor", "" + # "hash_3049a409503be8a0", 24000, 1, "int", &function_f471577a, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6d05bbcab1912e5a", 24000, 1, "int", &function_691412b4, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_62ea9298804bdde2", 24000, 1, "int", &function_3b63dde3, 0, 0);
  clientfield::register("world", "" + # "hash_241bea7b7373e633", 24000, 3, "int", &function_faeec0f5, 0, 0);
  clientfield::register("world", "" + # "hash_65c1921bc2c97a5", 24000, 3, "int", &function_d8aa203, 0, 0);
  clientfield::register("world", "" + # "hash_3a68a7b3ab1ec635", 24000, 2, "int", &function_cd21fa0f, 0, 0);
  clientfield::register("world", "" + # "hash_17ccce73f851c91b", 24000, 2, "int", &function_67e36b2b, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5924dea34439fc47", 24000, 1, "counter", &function_3399070d, 0, 0);
  clientfield::register("world", "" + # "hash_4f9ffeb4ee76d72f", 24000, 1, "counter", &function_b7b588dd, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_3bd38f4b718e54ad", 24000, 1, "int", &function_8e8e9b29, 0, 0);
  clientfield::register("toplayer", "" + # "hash_c2f6751024324b7", 24000, getminbitcountfornum(3), "int", &function_f5972a6e, 0, 0);
  clientfield::register("actor", "" + # "hash_59443eb99c2a76a4", 24000, 1, "int", &function_5a35f1c4, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_643cab616f5bd8e4", 24000, 1, "int", &function_8507bd06, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6256b5001ca2ef80", 24000, 2, "int", &function_6bed14f6, 0, 0);
  clientfield::register("world", "" + # "hash_1012bcebf9b9294", 24000, getminbitcountfornum(7), "int", &function_62492e2, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_14e7d597c32c1920", 24000, 1, "int", &function_94836d18, 0, 0);
  clientfield::register("world", "" + # "hash_47b670f2b915b245", 24000, 1, "int", &function_8b5ccf7c, 0, 0);

  if(!zm_utility::is_ee_enabled()) {
    return;
  }
}

function function_48f7c5e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 0) {
    if(isDefined(self.var_358ffe83)) {
      stopfx(fieldname, self.var_358ffe83);
      self.var_358ffe83 = undefined;
    }

    if(isDefined(self.var_3e9015dc)) {
      foreach(var_358ffe83 in self.var_3e9015dc) {
        stopfx(fieldname, var_358ffe83);
      }

      self.var_3e9015dc = undefined;
    }

    if(isDefined(self.var_a15fac69)) {
      self stoploopsound(self.var_a15fac69);
      self.var_a15fac69 = undefined;
    }
  }

  if(bwasdemojump == 1) {
    self.var_358ffe83 = util::playFXOnTag(fieldname, #"hash_79325355eac1745d", self, "tag_origin");
    self.var_a15fac69 = self playLoopSound(#"hash_5dae854b31b8e900");
    return;
  }

  if(bwasdemojump == 2) {
    self.var_3e9015dc = [];

    for(i = 1; i <= 3; i++) {
      if(!isDefined(self.var_3e9015dc)) {
        self.var_3e9015dc = [];
      } else if(!isarray(self.var_3e9015dc)) {
        self.var_3e9015dc = array(self.var_3e9015dc);
      }

      self.var_3e9015dc[self.var_3e9015dc.size] = util::playFXOnTag(fieldname, #"hash_20f7216d647052a0", self, "tag_canister_fx_0" + i);
    }

    self.var_a15fac69 = self playLoopSound(#"hash_5dae854b31b8e900");
  }
}

function function_94836d18(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.ambient_fx = util::playFXOnTag(fieldname, #"hash_25da9ddc0835c46e", self, "tag_origin");

    if(!isDefined(self.var_a5cf26d2)) {
      self.var_a5cf26d2 = self playLoopSound(#"hash_2bd7f8325af7d792");
    }

    return;
  }

  if(isDefined(self.ambient_fx)) {
    stopfx(fieldname, self.ambient_fx);
    self.ambient_fx = undefined;
  }

  if(isDefined(self.var_a5cf26d2)) {
    self stoploopsound(self.var_a5cf26d2);
    self.var_a5cf26d2 = undefined;
  }
}

function function_bb5d646a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level endon(#"end_game");
  self util::waittill_dobj(bwasdemojump);

  if(!isDefined(self) || !isDefined(self.origin)) {
    return;
  }

  e_fx = util::spawn_model(bwasdemojump, "tag_origin", self gettagorigin("J_Spine4"));
  playSound(bwasdemojump, #"hash_10f64731553b9b9d", e_fx.origin);
  e_fx.sound_id = e_fx playLoopSound(#"hash_1cefc6f663a17a63");
  var_f0029f2 = struct::get_array("harvesting_unit", "targetname");
  harvesting_unit = arraygetclosest(self.origin, var_f0029f2);
  util::playFXOnTag(bwasdemojump, #"hash_61e3c7a179d7cdfb", e_fx, "tag_origin");
  e_fx moveto(e_fx.origin + (0, 0, 40), 0.8);
  wait 0.75;
  n_time = distance(e_fx.origin, harvesting_unit.origin) / 400;
  e_fx moveto(harvesting_unit.origin + (0, 0, 32), n_time);
  e_fx waittill(#"movedone");
  util::playFXOnTag(bwasdemojump, #"hash_4d1d38d5da4d929b", e_fx, "tag_origin");
  e_fx stoploopsound(e_fx.sound_id);
  playSound(bwasdemojump, #"hash_150b4ab213c5864", e_fx.origin);
  wait 0.3;
  e_fx delete();
}

function function_21d26f5b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(bwasdemojump) {
    playSound(fieldname, #"hash_2adefaf3eba2a739", self.origin + (0, 0, 30));
    self.var_f11dc183 = playFX(fieldname, #"hash_4e0a101bea0199df", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_1cd2646f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(function_65b9eb0f(fieldname)) {
      return;
    }

    if(self isPlayer()) {
      self.var_726a59ef = playfxoncamera(fieldname, #"sr/fx9_camera_canister_in_hand", (0, 0, 0), (1, 0, 0), (0, 0, 1));
      self postfx::playpostfxbundle(#"pstfx_retrieve");
      self.var_51dd9721 = # "pstfx_retrieve";

      if(!isDefined(self.var_fbd5f7c8)) {
        self.var_fbd5f7c8 = util::playFXOnTag(fieldname, #"sr/fx9_obj_retrieval_container_gas_trail", self, "tag_stowed_back");
      }

      if(!isDefined(self.var_e53a5eb7)) {
        self playSound(fieldname, #"hash_22a6864697c92c12");
        self.var_e53a5eb7 = self playLoopSound(#"hash_6d68538eca6c8226");
      }
    }

    return;
  }

  if(function_65b9eb0f(fieldname)) {
    return;
  }

  if(self isPlayer()) {
    if(isDefined(self.var_726a59ef)) {
      stopfx(fieldname, self.var_726a59ef);
      self.var_726a59ef = undefined;
    }

    if(isDefined(self.var_fbd5f7c8)) {
      stopfx(fieldname, self.var_fbd5f7c8);
      self.var_fbd5f7c8 = undefined;
    }

    if(isDefined(self.var_e53a5eb7)) {
      self playSound(fieldname, #"hash_211ebca22128a977");
      self stoploopsound(self.var_e53a5eb7);
      self.var_e53a5eb7 = undefined;
    }

    self postfx::stoppostfxbundle(#"pstfx_retrieve");
    self.var_51dd9721 = undefined;
  }
}

function function_eb8ccdd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  playFX(bwasdemojump, #"zombie/fx9_player_shockwave_retrieval", self.origin, (180, 0, 0));
  self playSound(bwasdemojump, #"hash_5db462e1df5084e7");
  self playrumbleonentity(bwasdemojump, "damage_heavy");
}

function function_a6554e90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(bwasdemojump) {
    self.var_4663acbd = util::playFXOnTag(fieldname, #"hash_63c0e2a86db81a8f", self, "tag_fire");
    self.var_9c8960aa = self playLoopSound(#"hash_62481d2d8c46e073");
    self playSound(fieldname, #"hash_75cde2584278cf07");
    wait 2;

    if(isDefined(self.var_4663acbd)) {
      stopfx(fieldname, self.var_4663acbd);
      self.var_4663acbd = undefined;
    }

    self stoploopsound(self.var_9c8960aa);
  }
}

function function_5907109e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    var_f7e00fc2 = struct::get("pl_dv_collide_loc", "targetname");
    self.var_89711106 = playFX(fieldname, #"hash_548d3260a719a126", var_f7e00fc2.origin, anglesToForward(var_f7e00fc2.angles), (0, 0, 1));
    playSound(fieldname, #"hash_3dcbd3c8335a5f78", var_f7e00fc2.origin);
    e_player = function_5c10bd79(fieldname);
    earthquake(fieldname, 1, 0.5, e_player.origin, 512);
    e_player playrumbleonentity(fieldname, "damage_heavy");
    return;
  }

  if(isDefined(self.var_89711106)) {
    stopfx(fieldname, self.var_89711106);
    self.var_89711106 = undefined;
  }
}

function function_a342165a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.trail_fx = util::playFXOnTag(fieldname, #"hash_3dad79ca7ca879b5", self, "tag_origin");
    return;
  }

  if(isDefined(self.trail_fx)) {
    stopfx(fieldname, self.trail_fx);
    self.trail_fx = undefined;
  }
}

function function_fbaa949a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(function_65b9eb0f(fieldname)) {
      return;
    }

    if(self isPlayer()) {
      self postfx::playpostfxbundle(#"hash_322f5c345aeb8647");
    }
  }
}

function function_2906accd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    var_9f3ab0a1 = struct::get("hidden_stone_wall_break_fx_pos", "targetname");
    playFX(fieldname, #"hash_1c26f553c4b2dc42", var_9f3ab0a1.origin, anglesToForward(var_9f3ab0a1.angles), (0, 0, 1));
  }
}

function function_5cf50136(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    var_9f3ab0a1 = struct::get("hidden_door_fx_pos", "targetname");
    var_9f3ab0a1.fx = playFX(fieldname, #"hash_3426faf35f3452fe", var_9f3ab0a1.origin, anglesToForward(var_9f3ab0a1.angles), (0, 0, 1));
    return;
  }

  if(isDefined(var_9f3ab0a1.fx)) {
    stopfx(fieldname, var_9f3ab0a1.fx);
    var_9f3ab0a1.fx = undefined;
  }
}

function function_b7b588dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_9f3ab0a1 = struct::get("hidden_door_fx_pos", "targetname");
  var_9f3ab0a1.fx = playFX(bwasdemojump, #"hash_1d44bbada6bc060f", var_9f3ab0a1.origin, anglesToForward(var_9f3ab0a1.angles), (0, 0, 1));
}

function function_6b932134(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(function_65b9eb0f(fieldname)) {
      return;
    }

    if(self isPlayer()) {
      self postfx::playpostfxbundle(#"hash_e558f1af2e97e11");

      if(!isDefined(self.var_e53a5eb7)) {
        self playSound(fieldname, #"hash_36ce9a2becbdedf8");
        self.var_e53a5eb7 = self playLoopSound(#"hash_5f907df8d3aecf08");
      }
    }

    return;
  }

  if(function_65b9eb0f(fieldname)) {
    return;
  }

  if(self isPlayer()) {
    if(isDefined(self.var_e53a5eb7)) {
      self playSound(fieldname, #"hash_53c470cf8ee70cc9");
      self stoploopsound(self.var_e53a5eb7);
      self.var_e53a5eb7 = undefined;
    }

    self postfx::stoppostfxbundle(#"hash_e558f1af2e97e11");
  }
}

function function_60886116(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_3e3964d7 = playFX(fieldname, #"sr/fx9_hvt_aether_beam", self.origin, anglestoup(self.angles));

    if(!isDefined(self.var_7f6cb624)) {
      self playSound(fieldname, #"hash_62101ae824e3101a");
      self.var_7f6cb624 = self playLoopSound(#"hash_234e4f385aba4fae");
    }

    wait 2.5;
    self.var_ae8b25ed = playFX(fieldname, #"sr/fx9_hvt_aether_portal_spawn", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  self.var_1c6eb712 = playFX(fieldname, #"sr/fx9_hvt_aether_portal_close", self.origin, anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(self.var_3e3964d7)) {
    stopfx(fieldname, self.var_3e3964d7);
    self.var_3e3964d7 = undefined;
  }

  if(isDefined(self.var_ae8b25ed)) {
    stopfx(fieldname, self.var_ae8b25ed);
    self.var_ae8b25ed = undefined;
  }

  if(isDefined(self.var_7f6cb624)) {
    self playSound(fieldname, #"hash_7e2855c20a4abd8f");
    self stoploopsound(self.var_7f6cb624);
    self.var_7f6cb624 = undefined;
  }

  wait 2;

  if(isDefined(self.var_1c6eb712)) {
    stopfx(fieldname, self.var_1c6eb712);
    self.var_1c6eb712 = undefined;
  }
}

function function_f7c615a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_c03e08db = [];

    for(i = 1; i < 5; i++) {
      var_595bfc16 = util::playFXOnTag(fieldname, #"hash_4cf94ac460739f33", self, "tag_car_wheel_0" + i);

      if(!isDefined(self.var_c03e08db)) {
        self.var_c03e08db = [];
      } else if(!isarray(self.var_c03e08db)) {
        self.var_c03e08db = array(self.var_c03e08db);
      }

      if(!isinarray(self.var_c03e08db, var_595bfc16)) {
        self.var_c03e08db[self.var_c03e08db.size] = var_595bfc16;
      }
    }

    return;
  }

  if(isarray(self.var_c03e08db) && self.var_c03e08db.size != 0) {
    foreach(fx in self.var_c03e08db) {
      if(isDefined(fx)) {
        stopfx(fieldname, fx);
      }
    }
  }
}

function function_fda7f886(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_201d2739 = util::playFXOnTag(fieldname, #"hash_2e517469dd5a1d80", self, "tag_sync");
    self.var_35cdbe97 = util::playFXOnTag(fieldname, #"hash_4bb5e33e54f79389", self, "tag_le_foot_fx");
    self.var_35febefd = util::playFXOnTag(fieldname, #"hash_4bb5e33e54f79389", self, "tag_ri_foot_fx");
    self.var_d20df142 = util::playFXOnTag(fieldname, #"hash_3af12fbe32571a41", self, "tag_L_hand_fx");
    self.var_de688a0b = util::playFXOnTag(fieldname, #"hash_3af12fbe32571a41", self, "tag_R_hand_fx");
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_201d2739)) {
      stopfx(fieldname, self.var_201d2739);
      self.var_201d2739 = undefined;
    }
  }

  if(bwastimejump == 3) {
    if(isDefined(self.var_35cdbe97)) {
      stopfx(fieldname, self.var_35cdbe97);
      self.var_35cdbe97 = undefined;
    }

    if(isDefined(self.var_35febefd)) {
      stopfx(fieldname, self.var_35febefd);
      self.var_35febefd = undefined;
    }

    if(isDefined(self.var_d20df142)) {
      stopfx(fieldname, self.var_d20df142);
      self.var_d20df142 = undefined;
    }

    if(isDefined(self.var_de688a0b)) {
      stopfx(fieldname, self.var_de688a0b);
      self.var_de688a0b = undefined;
    }
  }
}

function function_1d33d741(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.explosion_fx = playFX(fieldname, #"hash_426578cff4c27b01", self.origin);
  }
}

function function_6d56f7a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    var_3b1d1169 = getent(fieldname, "lab_second_hidden_door", "targetname");
    var_3b1d1169.rob = # "hash_7f1bc2146f524d7c";
    var_3b1d1169.reveal = 1;
    var_3b1d1169.brightness = 0;
    var_3b1d1169 playrenderoverridebundle(var_3b1d1169.rob);
    var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"alpha", var_3b1d1169.reveal);
    var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"brightness", var_3b1d1169.brightness);
    var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"tint", var_3b1d1169.brightness);
  }
}

function function_6774a2f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_3b1d1169 = getent(bwastimejump, "lab_second_hidden_door", "targetname");
  level notify(#"hash_39278a16dce99955");

  if(isDefined(var_3b1d1169.brightness)) {
    var_3b1d1169.brightness += 0.025;

    if(var_3b1d1169.brightness < 0) {
      var_3b1d1169.brightness = 0;
    } else if(var_3b1d1169.brightness > 1) {
      var_3b1d1169.brightness = 1;
    }

    var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"brightness", var_3b1d1169.brightness);
    var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"tint", var_3b1d1169.brightness);
  }

  if(!is_true(var_3b1d1169.var_d280dacf) && !is_true(var_3b1d1169.var_3bfeafe1)) {
    var_3b1d1169.var_d280dacf = 1;
    soundloopemitter("zmb_mq_stp1_door_burn_lp", (-2739, 14319, -320));
  }
}

function function_a28ff742(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");

  if(bwastimejump == 1) {
    forcestreamxmodel(#"p9_zm_platinum_lab_hidden_metal_door_04");
    var_3b1d1169 = getent(fieldname, "lab_second_hidden_door", "targetname");
    var_3b1d1169.var_3bfeafe1 = 1;

    if(is_true(var_3b1d1169.var_d280dacf)) {
      soundstoploopemitter("zmb_mq_stp1_door_burn_lp", (-2739, 14319, -320));
      var_3b1d1169.var_d280dacf = 0;
    }

    playSound(fieldname, #"hash_18233b644512c916", (-2739, 14319, -320));

    while(var_3b1d1169.reveal > 0) {
      var_3b1d1169.reveal -= 0.05;
      var_3b1d1169.brightness -= 0.05;
      wait 0.1;

      if(var_3b1d1169.reveal < 0) {
        var_3b1d1169.reveal = 0;
      } else if(var_3b1d1169.reveal > 1) {
        var_3b1d1169.reveal = 1;
      }

      var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"alpha", var_3b1d1169.reveal);
      var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"brightness", var_3b1d1169.brightness);
      var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"tint", var_3b1d1169.brightness);
    }

    var_3b1d1169 setModel(#"p9_zm_platinum_lab_hidden_metal_door_04");
    var_3b1d1169 solid();
  }
}

function function_44dc8dc9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!function_148ccc79(fieldname, #"hash_5e358762e4678906")) {
      function_a837926b(fieldname, #"hash_5e358762e4678906");
    }

    return;
  }

  if(function_148ccc79(fieldname, #"hash_5e358762e4678906")) {
    codestoppostfxbundlelocal(fieldname, #"hash_5e358762e4678906");
  }
}

function function_296ed7c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game", #"hash_39278a16dce99955");
  self notify("5c5fc7b7296d62c4");
  self endon("5c5fc7b7296d62c4");

  if(bwastimejump == 1) {
    var_3b1d1169 = getent(fieldname, "lab_second_hidden_door", "targetname");

    if(is_true(var_3b1d1169.var_d280dacf)) {
      soundstoploopemitter("zmb_mq_stp1_door_burn_lp", (-2739, 14319, -320));
      var_3b1d1169.var_d280dacf = 0;
    }

    while(var_3b1d1169.brightness > 0) {
      var_3b1d1169.brightness -= 0.01;
      wait 0.02;

      if(var_3b1d1169.brightness < 0) {
        var_3b1d1169.brightness = 0;
      } else if(var_3b1d1169.brightness > 1) {
        var_3b1d1169.brightness = 1;
      }

      var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"brightness", var_3b1d1169.brightness);
      var_3b1d1169 function_78233d29(var_3b1d1169.rob, "", #"tint", var_3b1d1169.brightness);
    }
  }
}

function function_fb770d12(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");

  if(bwastimejump == 1) {
    var_3b1d1169 = getent(fieldname, "tempest_lure_lid", "targetname");
    var_3b1d1169 rotateto((0, 300, 0), 1);
    var_3b1d1169 playSound(fieldname, #"hash_6f2d121185d8149d");
  }
}

function function_9b69f640(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.var_22850ca8.var_1b9261c playSound(fieldname, #"hash_598a90ee6c5183cf");

  if(bwastimejump == 1) {
    level.var_22850ca8.var_1b9261c setModel(#"hash_7877c50fda0f0d20");
    level.var_22850ca8.mdl_arrow setModel(#"tag_origin");
    level.var_22850ca8.var_db5e020 setModel(#"hash_52dd90e46d69e98a");
  }

  if(bwastimejump == 2) {
    level.var_22850ca8.var_1b9261c setModel(#"hash_533d072922b40b93");
    level.var_22850ca8.var_5564475e setModel(#"hash_67fca6298eb533dd");
  }

  if(bwastimejump == 3) {
    level.var_22850ca8.var_1b9261c setModel(#"hash_7877c50fda0f0d20");
    level.var_22850ca8.var_ca773186 setModel(#"hash_19534a72be3ca913");
  }

  if(bwastimejump == 4) {
    level.var_22850ca8.var_1b9261c setModel(#"hash_7877c50fda0f0d20");
    level.var_22850ca8.var_5564475e setModel(#"hash_443aa647fe9c3e99");
  }

  if(bwastimejump == 5) {
    level.var_22850ca8.var_1b9261c setModel(#"hash_7877c50fda0f0d20");
    level.var_22850ca8.var_ca773186 setModel(#"tag_origin");
  }

  if(bwastimejump == 6) {
    level.var_22850ca8.var_1b9261c setModel(#"hash_7877c50fda0f0d20");
    level.var_22850ca8.var_5564475e setModel(#"tag_origin");
  }
}

function function_850f10bc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");
  level.var_22850ca8 = struct::get("train_station_screen", "targetname");

  if(bwastimejump == 1) {
    level.var_22850ca8.mdl_screen = util::spawn_model(fieldname, #"hash_8eb7a2b6b496587", level.var_22850ca8.origin, level.var_22850ca8.angles);
    level.var_22850ca8.var_1b9261c = util::spawn_model(fieldname, #"tag_origin", level.var_22850ca8.origin, level.var_22850ca8.angles);
    level.var_22850ca8.mdl_arrow = util::spawn_model(fieldname, #"tag_origin", level.var_22850ca8.origin, level.var_22850ca8.angles);
    level.var_22850ca8.var_ca773186 = util::spawn_model(fieldname, #"tag_origin", level.var_22850ca8.origin, level.var_22850ca8.angles);
    level.var_22850ca8.var_5564475e = util::spawn_model(fieldname, #"tag_origin", level.var_22850ca8.origin, level.var_22850ca8.angles);
    level.var_22850ca8.var_db5e020 = util::spawn_model(fieldname, #"tag_origin", level.var_22850ca8.origin, level.var_22850ca8.angles);
  }
}

function function_c9b5b294(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");
  var_96ab0838 = getent(fieldname, "railway_switch_mdl", "targetname");

  if(bwastimejump == 0) {
    playSound(fieldname, #"hash_28cf0abbf826d676", var_96ab0838.origin);
    var_96ab0838 rotateto((0, 270, 140), 1);
  }

  if(bwastimejump == 1) {
    playSound(fieldname, #"hash_1199afea16cbe3e2", var_96ab0838.origin);
    var_96ab0838 rotateto((0, 270, -140), 1);
    wait 1;
    playSound(fieldname, #"hash_32c95b8a98c5c138", var_96ab0838.origin);
  }
}

function function_cdc867b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump) {
    if(!isDefined(self.var_bb6d69f0)) {
      self.var_bb6d69f0 = playFX(fieldname, #"sr/fx9_hvt_aether_portal_spawn", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    return;
  }

  if(isDefined(self.var_bb6d69f0)) {
    stopfx(fieldname, self.var_bb6d69f0);
    self.var_bb6d69f0 = undefined;
  }

  var_4776f2b8 = playFX(fieldname, #"sr/fx9_hvt_aether_portal_close", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  level thread function_2f3f5638(fieldname, var_4776f2b8);
}

function function_2f3f5638(localclientnum, var_4776f2b8) {
  wait 2;

  if(isDefined(var_4776f2b8)) {
    stopfx(localclientnum, var_4776f2b8);
    var_4776f2b8 = undefined;
  }
}

function function_f15a1018(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);
  playFX(bwastimejump, #"sr/fx9_hvt_aether_portal_exp", self.origin + (0, 0, 32), anglesToForward(self.angles), anglestoup(self.angles));
  self playSound(bwastimejump, #"hash_591b69e6e55b5eb1");
}

function function_f471577a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_27b51434 = util::playFXOnTag(fieldname, #"sr/fx9_hvt_aether_beam_distant", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_27b51434)) {
    stopfx(fieldname, self.var_27b51434);
    self.var_27b51434 = undefined;
  }
}

function function_691412b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_942f8233 = util::playFXOnTag(fieldname, #"sr/fx9_hvt_aether_move_trail", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_942f8233)) {
    stopfx(fieldname, self.var_942f8233);
  }
}

function function_3b63dde3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_98606953 = util::playFXOnTag(fieldname, #"hash_26f283d1d7fafb9a", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_98606953)) {
    stopfx(fieldname, self.var_98606953);
    self.var_98606953 = undefined;
    self.var_98606953 = util::playFXOnTag(fieldname, #"hash_20a1fdf82dfef8c", self, "tag_origin");
  }
}

function function_faeec0f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 || bwastimejump == 2 || bwastimejump == 3) {
    s_canister = function_83257eca(bwastimejump);
    var_e8a5ef56 = struct::get("nuke_warhead", "targetname");
    s_canister.mdl = util::spawn_model(fieldname, #"p9_zm_platinum_harvest_canister_off", s_canister.origin, s_canister.angles);

    switch (bwastimejump) {
      case 1:
        s_canister.mdl.origin = var_e8a5ef56.mdl gettagorigin("tag_centera");
        break;
      case 2:
        s_canister.mdl.origin = var_e8a5ef56.mdl gettagorigin("tag_centerb");
        break;
      case 3:
        s_canister.mdl.origin = var_e8a5ef56.mdl gettagorigin("tag_centerc");
        break;
      default:
        break;
    }
  }

  if(bwastimejump == 4 || bwastimejump == 5 || bwastimejump == 6) {
    switch (bwastimejump) {
      case 4:
        index = 1;
        break;
      case 5:
        index = 2;
        break;
      case 6:
        index = 3;
        break;
      default:
        break;
    }

    s_canister = function_83257eca(index);

    if(isDefined(s_canister.mdl)) {
      playSound(fieldname, #"hash_4886352431f9e6e9", s_canister.mdl.origin + (0, 0, 5));
    }

    if(isDefined(s_canister.mdl)) {
      s_canister.mdl delete();
    }
  }

  if(bwastimejump == 7) {
    var_e8a5ef56 = struct::get("nuke_warhead", "targetname");
    var_e8a5ef56.mdl = util::spawn_model(fieldname, #"hash_3b8343c4b360376f", var_e8a5ef56.origin, var_e8a5ef56.angles);
    var_e8a5ef56.mdl.origin = (-2737.5, 14414, -539.5);
    var_324a4a44 = struct::get("nuke_warhead_riser", "targetname");
    var_324a4a44.mdl = util::spawn_model(fieldname, #"hash_33b9cfeab1d8bc73", var_e8a5ef56.mdl gettagorigin("tag_center") + (0, 0, -5), var_e8a5ef56.angles);
    var_324a4a44.mdl linkto(var_e8a5ef56.mdl);

    for(i = 1; i < 4; i++) {
      switch (i) {
        case 1:
          tag = "tag_centera";
          break;
        case 2:
          tag = "tag_centerb";
          break;
        case 3:
          tag = "tag_centerc";
          break;
        default:
          break;
      }

      s_canister = function_83257eca(i);
      s_canister.mdl = util::spawn_model(fieldname, #"p9_zm_platinum_harvest_canister", var_e8a5ef56.mdl gettagorigin(tag) + (0, 0, -8), s_canister.angles);
    }
  }
}

function function_83257eca(index) {
  var_9ec97f7c = struct::get_array("harvester_canister", "targetname");

  foreach(s_canister in var_9ec97f7c) {
    if(s_canister.script_int == index) {
      return s_canister;
    }
  }
}

function function_d8aa203(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");

  if(bwastimejump == 1 || bwastimejump == 2 || bwastimejump == 3) {
    s_canister = function_83257eca(bwastimejump);

    if(isDefined(s_canister.mdl)) {
      s_canister.mdl moveto(s_canister.mdl.origin + (0, 0, 8), 3);
      playSound(fieldname, #"hash_2eedbe412ecac84", s_canister.mdl.origin + (0, 0, 12));
    }
  }

  if(bwastimejump == 4) {
    var_e8a5ef56 = struct::get("nuke_warhead_riser", "targetname");

    if(isDefined(var_e8a5ef56.mdl)) {
      var_e8a5ef56.mdl moveto(var_e8a5ef56.mdl.origin + (0, 0, 4), 3);
      playSound(fieldname, #"hash_552ec912f6cad0a0", var_e8a5ef56.mdl.origin + (0, 0, 8));
    }
  }
}

function function_cd21fa0f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 || bwastimejump == 2 || bwastimejump == 3) {
    switch (bwastimejump) {
      case 1:
        tag = "tag_centera";
        break;
      case 2:
        tag = "tag_centerb";
        break;
      case 3:
        tag = "tag_centerc";
        break;
      default:
        break;
    }

    s_canister = function_83257eca(bwastimejump);
    var_e8a5ef56 = struct::get("nuke_warhead", "targetname");
    s_canister.var_358ffe83 = playFX(fieldname, #"hash_79325355eac1745d", var_e8a5ef56.mdl gettagorigin(tag), anglesToForward(s_canister.angles), anglestoup(s_canister.angles));
  }
}

function function_67e36b2b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 || bwastimejump == 2 || bwastimejump == 3) {
    switch (bwastimejump) {
      case 1:
        tag = "tag_centera";
        break;
      case 2:
        tag = "tag_centerb";
        break;
      case 3:
        tag = "tag_centerc";
        break;
      default:
        break;
    }

    s_canister = function_83257eca(bwastimejump);
    var_e8a5ef56 = struct::get("nuke_warhead", "targetname");

    if(isDefined(var_e8a5ef56.mdl)) {
      s_canister.mdl = util::spawn_model(fieldname, #"p9_zm_platinum_harvest_canister_off", var_e8a5ef56.mdl gettagorigin(tag), s_canister.angles);
      playSound(fieldname, #"hash_69316011334b8a63", s_canister.mdl.origin + (0, 0, 8));
      s_canister.mdl.soundid = s_canister.mdl playLoopSound(#"hash_5dae854b31b8e900");
      s_canister.var_358ffe83 = playFX(fieldname, #"hash_79325355eac1745d", var_e8a5ef56.mdl gettagorigin(tag), anglesToForward(s_canister.angles), anglestoup(s_canister.angles));
    }
  }
}

function function_3399070d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 0) {
    if(isDefined(self.var_aa0f357b)) {
      stopfx(fieldname, self.var_aa0f357b);
      self.var_aa0f357b = undefined;
    }
  }

  if(bwasdemojump == 1) {
    self.var_aa0f357b = playFX(fieldname, #"hash_396e69899f0afe91", self.origin, anglesToForward(self.angles), (0, 0, 1));
  }
}

function function_8e8e9b29(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.var_56084a = util::playFXOnTag(fieldname, #"hash_19e2d43cc6351213", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_56084a)) {
    stopfx(fieldname, self.var_56084a);
    self.var_56084a = undefined;
  }

  self.var_b0c6224c = util::playFXOnTag(fieldname, #"hash_22bc6ecd8add0844", self, "tag_origin");
}

function function_f5972a6e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_5dc01646)) {
    self stoprumble(fieldname, self.var_5dc01646);
    self.var_5dc01646 = undefined;
  }

  if(bwasdemojump > 0) {
    switch (bwasdemojump) {
      case 1:
        str_rumble = # "hash_65da6011d5335d33";
        break;
      case 2:
        str_rumble = # "hash_65da6111d5335ee6";
        break;
      case 3:
        str_rumble = # "hash_65da6211d5336099";
        break;
    }

    if(isDefined(str_rumble)) {
      self playrumblelooponentity(fieldname, str_rumble);
      self.var_5dc01646 = str_rumble;
    }
  }
}

function function_5a35f1c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.burst_fx = util::playFXOnTag(fieldname, #"hash_7e653f6a9652a1ed", self, "J_Helm");
    self.var_5e62f52f = util::playFXOnTag(fieldname, #"hash_3294af84456e3b6a", self, "J_Helm_FX");
  }
}

function function_8507bd06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 0) {
    if(isDefined(self.smoke_fx)) {
      stopfx(fieldname, self.smoke_fx);
      self.smoke_fx = undefined;
    }

    if(isDefined(self.smoke_sfx)) {
      self stoploopsound(self.smoke_sfx);
      self.smoke_sfx = undefined;
    }
  }

  if(bwasdemojump == 1) {
    self.smoke_fx = playFX(fieldname, #"hash_27265ab68f59e1c4", self.origin + (0, 0, 32), (0, 0, 1), (1, 0, 0));
    self.smoke_sfx = self playLoopSound(#"hash_6caa04f1e36c6d2a");
  }
}

function function_6bed14f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 0) {
    if(isDefined(self.light_fx)) {
      stopfx(fieldname, self.light_fx);
      self.light_fx = undefined;
    }
  }

  if(bwasdemojump == 1) {
    if(isDefined(self.light_fx)) {
      stopfx(fieldname, self.light_fx);
      self.light_fx = undefined;
    }

    self.light_fx = playFX(fieldname, #"hash_23d8166ccf961045", self.origin, anglesToForward(self.angles), (0, 0, 1));
  }

  if(bwasdemojump == 2) {
    if(isDefined(self.light_fx)) {
      stopfx(fieldname, self.light_fx);
      self.light_fx = undefined;
    }

    self.light_fx = playFX(fieldname, #"hash_5674f495d16b6b44", self.origin, anglesToForward(self.angles), (0, 0, 1));
  }

  if(bwasdemojump == 3) {
    if(isDefined(self.light_fx)) {
      stopfx(fieldname, self.light_fx);
      self.light_fx = undefined;
    }

    self.light_fx = playFX(fieldname, #"hash_40e6967eb0a4d624", self.origin, anglesToForward(self.angles), (0, 0, 1));
  }
}

function function_62492e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      forcestreamxmodel(#"hash_18ea421c8e112587");
      break;
    case 2:
      forcestreamxmodel(#"hash_18ea3f1c8e11206e");
      stopforcestreamingxmodel(#"hash_18ea421c8e112587");
      break;
    case 3:
      forcestreamxmodel(#"p9_zm_platinum_intel_documents_r_05");
      stopforcestreamingxmodel(#"hash_18ea3f1c8e11206e");
      break;
    case 4:
      forcestreamxmodel(#"p9_zm_platinum_intel_documents_r_06");
      stopforcestreamingxmodel(#"p9_zm_platinum_intel_documents_r_05");
      break;
    case 5:
      forcestreamxmodel(#"p9_zm_platinum_intel_documents_r_07");
      stopforcestreamingxmodel(#"p9_zm_platinum_intel_documents_r_06");
      break;
    case 6:
      forcestreamxmodel(#"p9_zm_platinum_personal_computer_screen_05");
      stopforcestreamingxmodel(#"p9_zm_platinum_intel_documents_r_07");
      break;
    case 7:
      forcestreamxmodel(#"hash_18ea3d1c8e111d08");
      forcestreamxmodel(#"hash_18ea3e1c8e111ebb");
      stopforcestreamingxmodel(#"p9_zm_platinum_personal_computer_screen_05");
      break;
    case 0:
      stopforcestreamingxmodel(#"hash_18ea3d1c8e111d08");
      stopforcestreamingxmodel(#"hash_18ea3e1c8e111ebb");
      stopforcestreamingxmodel(#"hash_18ea421c8e112587");
      stopforcestreamingxmodel(#"hash_18ea3f1c8e11206e");
      stopforcestreamingxmodel(#"p9_zm_platinum_personal_computer_screen_05");
      stopforcestreamingxmodel(#"p9_zm_platinum_intel_documents_r_05");
      stopforcestreamingxmodel(#"p9_zm_platinum_intel_documents_r_06");
      stopforcestreamingxmodel(#"p9_zm_platinum_intel_documents_r_07");
      break;
  }
}

function function_8b5ccf7c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    forcestreamxmodel(#"p9_zm_platinum_lab_hidden_metal_door_01");
    return;
  }

  stopforcestreamingxmodel(#"p9_zm_platinum_lab_hidden_metal_door_01");
}