/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_side_quests.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace namespace_b45e3f05;

init() {
  init_clientfields();
  init_flags();
  init_fx();
}

init_clientfields() {
  clientfield::register("allplayers", "" + #"hash_2c387ea19f228b5d", 1, 1, "int", &function_bfdd6659, 0, 0);
  clientfield::register("allplayers", "" + #"hash_794e5d0769b1d497", 1, 1, "int", &function_54655580, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_7876f33937c8a764", 1, 1, "int", &vomit, 0, 0);
  clientfield::register("scriptmover", "" + #"safe_fx", 1, 1, "int", &safe_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"flare_fx", 1, 2, "int", &flare_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_2042191a7fc75994", 1, 2, "int", &function_563778cc, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_2ec182fecae80e80", 1, 1, "int", &function_584fb3c8, 0, 0);
  clientfield::register("scriptmover", "" + #"portal_pass", 1, 2, "int", &function_eabe4696, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_1cf8b9339139c50d", 1, 1, "int", &function_34f5c98, 0, 0);
  clientfield::register("scriptmover", "" + #"car_fx", 1, 1, "int", &function_ae668ae9, 0, 0);
  clientfield::register("world", "" + #"hash_1166237b92466ac9", 1, 1, "int", &function_5218405b, 0, 0);
  clientfield::register("world", "" + #"fireworks_fx", 1, 2, "counter", &fireworks_fx, 0, 0);
  clientfield::register("world", "" + #"crash_fx", 1, 1, "int", &function_711366fa, 0, 0);
  clientfield::register("world", "" + #"hash_4f672a8a7ae530e5", 1, 1, "int", &function_f99ce12b, 0, 0);
}

init_flags() {}

init_fx() {
  level._effect[#"safe_fx"] = #"hash_4bf40208439d50d6";
  level._effect[#"hash_3ed9aa5890e4cfd2"] = #"hash_4b6b503d842bc415";
  level._effect[#"hash_21893413efec355e"] = #"hash_cf3c06e4368bbb1";
  level._effect[#"hash_55ab46637a8fbcb3"] = #"hash_5508b1d8864ee2d2";
  level._effect[#"hash_2377de258e66b4ce"] = #"hash_33da19858ee59385";
  level._effect[#"hash_76a20bbf3432c804"] = #"hash_1b5b754131008f70";
  level._effect[#"hash_4817a1dbc7bf4ca4"] = #"hash_770af2dde4a0938c";
  level._effect[#"hash_3ddf14b70581a57"] = #"hash_41eac18dc72dac23";
  level._effect[#"hash_3bfcf7e07661fa18"] = #"hash_5e9dff5fcbf30022";
  level._effect[#"hash_26c9596a43d9be2e"] = #"hash_4144490ff4773f4b";
  level._effect[#"hash_6571250749b2c790"] = #"hash_1a3fcc6c808e55eb";
  level._effect[#"hash_51ecda6f24a58d05"] = #"hash_13c3cecd3d059c90";
  level._effect[#"hash_2f154bbb31e4abaf"] = #"hash_706103079a2bdb6d";
  level._effect[#"hash_3524e302fa83d12e"] = #"hash_3a791d490f01f5c7";
  level._effect[#"hash_2498ee8a7586b418"] = #"hash_15dc4292340f0f1c";
  level._effect[#"hash_16c2570acb38a0ed"] = #"hash_7691f79bfc16f0bf";
  level._effect[#"car_lights"] = #"hash_335feb1d213c22f6";
  level._effect[#"hash_1c0ed73a9b21a882"] = #"hash_cc7196a44e2fbe3";
  level._effect[#"hash_704d3c12d59fb5d7"] = #"hash_2aabc11b07ad74d8";
  level._effect[#"hash_4ec5da9e09256102"] = #"hash_3063115f97c18abf";
  level._effect[#"hash_133983d2bb8a160"] = #"hash_51ca82e6f2c21354";
  level._effect[#"hash_13aa43d2bbed472"] = #"hash_51d16ee6f2c81006";
}

function_f99ce12b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    addzombieboxweapon(getweapon(#"hero_sword_pistol_lv1"), #"wpn_t8_zm_melee_dw_hand_cannon_lvl1_prop_animate", 1);
    addzombieboxweapon(getweapon(#"hero_chakram_lv1"), #"wpn_t8_zm_melee_dw_hand_cannon_lvl1_prop_animate", 1);
    addzombieboxweapon(getweapon(#"hero_scepter_lv1"), #"wpn_t8_zm_melee_staff_ra_lvl1_prop_animate", 0);
    addzombieboxweapon(getweapon(#"hero_hammer_lv1"), #"wpn_t8_zm_melee_hammer_lvl1_prop_animate", 0);
    return;
  }

  removezombieboxweapon(getweapon(#"hero_sword_pistol_lv1"));
  removezombieboxweapon(getweapon(#"hero_chakram_lv1"));
  removezombieboxweapon(getweapon(#"hero_scepter_lv1"));
  removezombieboxweapon(getweapon(#"hero_hammer_lv1"));
}

function_54655580(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrenderoverridebundle(#"rob_tricannon_character_ice");
    return;
  }

  self stoprenderoverridebundle(#"rob_tricannon_character_ice");
}

function_bfdd6659(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(viewmodelhastag(localclientnum, "tag_fx")) {
        self.var_37649f83 = playviewmodelfx(localclientnum, level._effect[#"hash_133983d2bb8a160"], "tag_fx");
      }
    } else {
      self.var_37649f83 = util::playFXOnTag(localclientnum, level._effect[#"hash_13aa43d2bbed472"], self, "tag_fx");
    }

    return;
  }

  if(isDefined(self.var_37649f83)) {
    stopfx(localclientnum, self.var_37649f83);
    self.var_37649f83 = undefined;
  }
}

function_ae668ae9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.n_trail_fx = util::playFXOnTag(localclientnum, level._effect[#"car_lights"], self, "tag_body");
    return;
  }

  if(isDefined(self.n_trail_fx)) {
    killfx(localclientnum, self.n_trail_fx);
    self.n_trail_fx = undefined;
  }
}

function_34f5c98(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && isDefined(level._effect[#"hash_2498ee8a7586b418"])) {
    self util::waittill_dobj(localclientnum);
    self.var_f756621f = util::playFXOnTag(localclientnum, level._effect[#"hash_2f154bbb31e4abaf"], self, "tag_origin");
    playFX(localclientnum, level._effect[#"hash_16c2570acb38a0ed"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    playrumbleonposition(localclientnum, #"hash_743b325bf45e1c8c", self.origin);
    playSound(localclientnum, #"hash_188d7d9f6b62346f", (0, 0, 0));
    wait 0.75;

    if(isDefined(self)) {
      playFX(localclientnum, level._effect[#"hash_2498ee8a7586b418"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    return;
  }

  if(isDefined(self.var_f756621f)) {
    stopfx(localclientnum, self.var_f756621f);
  }
}

function_5218405b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    s_loc = struct::get(#"spark_loc");
    playFX(localclientnum, level._effect[#"hash_3524e302fa83d12e"], s_loc.origin, anglesToForward(s_loc.angles), anglestoup(s_loc.angles));
    wait 0.5;
    playrumbleonposition(localclientnum, #"hash_743b325bf45e1c8c", s_loc.origin);
  }
}

vomit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_39c21153)) {
    stopfx(localclientnum, self.var_39c21153);
    self.var_39c21153 = undefined;
  }

  if(newval) {
    self.var_39c21153 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit_object"], self, "tag_origin");
  }
}

function_584fb3c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrenderoverridebundle(#"rob_tricannon_character_ice");
    s_loc = struct::get(#"hash_583635858828e286");
    playFX(localclientnum, level._effect[#"hash_26c9596a43d9be2e"], s_loc.origin);
    audio::playloopat("zmb_frost_table_loop", self.origin);
  }
}

function_711366fa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    s_loc = struct::get(#"hash_27613769597daaf0");
    playFX(localclientnum, level._effect[#"hash_3bfcf7e07661fa18"], s_loc.origin);
  }
}

function_eabe4696(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_2745e294)) {
    killfx(localclientnum, self.var_2745e294);
    self.var_2745e294 = undefined;
  }

  if(newval == 1) {
    self util::waittill_dobj(localclientnum);
    self.var_2745e294 = util::playFXOnTag(localclientnum, level._effect[#"hash_6571250749b2c790"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    self.var_2745e294 = util::playFXOnTag(localclientnum, level._effect[#"hash_51ecda6f24a58d05"], self, "tag_origin");
    return;
  }

  playFX(localclientnum, level._effect[#"hash_3ddf14b70581a57"], self.origin);
}

function_43425692(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  s_loc = struct::get(#"floaters_fx");

  if(newval == 1) {
    s_loc.fx = playFX(localclientnum, level._effect[#"hash_29d523bd9b3bf58a"], s_loc.origin, anglesToForward(s_loc.angles), anglestoup(s_loc.angles));
    return;
  }

  if(isDefined(s_loc.fx)) {
    stopfx(localclientnum, s_loc.fx);
  }
}

safe_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(newval == 1) {
    if(!isDefined(self.fx)) {
      v_forward = anglesToForward(self.angles);
      v_right = anglestoright(self.angles);
      v_loc = self.origin + v_right * 7;
      v_loc += v_forward * -8;
      self.fx = playFX(localclientnum, level._effect[#"safe_fx"], v_loc, v_forward, anglestoup(self.angles));
    }

    return;
  }

  if(isDefined(self.fx)) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_3ed9aa5890e4cfd2"], self, "tag_origin");

    if(newval == 1) {
      if(!isDefined(self.fx)) {
        self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_21893413efec355e"], self, "tag_origin");
        wait 1.5;

        if(isDefined(self)) {
          playFX(localclientnum, level._effect[#"hash_76a20bbf3432c804"], self.origin);
        }
      }
    } else if(newval == 2) {
      if(!isDefined(self.fx)) {
        self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_2377de258e66b4ce"], self, "tag_origin");
        wait 1.5;

        if(isDefined(self)) {
          playFX(localclientnum, level._effect[#"hash_4817a1dbc7bf4ca4"], self.origin);
        }
      }
    } else if(newval == 3) {
      if(!isDefined(self.fx)) {
        self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_55ab46637a8fbcb3"], self, "tag_origin");
        wait 1.5;

        if(isDefined(self)) {
          playFX(localclientnum, level._effect[#"hash_3ddf14b70581a57"], self.origin);
        }
      }
    }

    return;
  }

  if(isDefined(self.fx)) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

function_563778cc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.fx)) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }

  switch (newval) {
    case 1:
      self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_1c0ed73a9b21a882"], self, "tag_origin");
      break;
    case 2:
      self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_4ec5da9e09256102"], self, "tag_origin");
      break;
    case 3:
      self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_704d3c12d59fb5d7"], self, "tag_origin");
      break;
  }
}

fireworks_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
    s_loc = a_s_locs[randomint(a_s_locs.size)];
    playFX(localclientnum, level._effect[#"hash_76a20bbf3432c804"], s_loc.origin);
    playSound(0, #"hash_40d3baad4b103e04", s_loc.origin);
    return;
  }

  if(newval == 2) {
    a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
    s_loc = a_s_locs[randomint(a_s_locs.size)];
    playFX(localclientnum, level._effect[#"hash_4817a1dbc7bf4ca4"], s_loc.origin);
    playSound(0, #"hash_40d3baad4b103e04", s_loc.origin);
    return;
  }

  if(newval == 3) {
    a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
    s_loc = a_s_locs[randomint(a_s_locs.size)];
    playFX(localclientnum, level._effect[#"hash_3ddf14b70581a57"], s_loc.origin);
    playSound(0, #"hash_40d3baad4b103e04", s_loc.origin);
  }
}