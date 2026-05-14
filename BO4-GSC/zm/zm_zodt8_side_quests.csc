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
#namespace zodt8_side_quests;

init() {
  init_clientfields();
  init_flags();
  init_fx();
}

init_clientfields() {
  clientfield::register("allplayers", "" + #"hash_2c387ea19f228b5d", 1, 1, "int", &function_bfdd6659, 0, 0);
  clientfield::register("allplayers", "" + #"hash_794e5d0769b1d497", 1, 1, "int", &function_54655580, 0, 0);
  clientfield::register("scriptmover", "" + #"vomit_blade_fx", 1, 1, "int", &vomit, 0, 0);
  clientfield::register("scriptmover", "" + #"safe_fx", 1, 1, "int", &safe_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"flare_fx", 1, 2, "int", &flare_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"flare_on_car", 1, 2, "int", &function_563778cc, 0, 0);
  clientfield::register("scriptmover", "" + #"shield_frost_fx", 1, 1, "int", &shield_frost_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"portal_pass", 1, 2, "int", &portal_pass_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"engineer_smoke_fx", 1, 1, "int", &function_34f5c98, 0, 0);
  clientfield::register("scriptmover", "" + #"car_fx", 1, 1, "int", &function_ae668ae9, 0, 0);
  clientfield::register("world", "" + #"engineer_spark_fx", 1, 1, "int", &function_5218405b, 0, 0);
  clientfield::register("world", "" + #"fireworks_fx", 1, 2, "counter", &fireworks_fx, 0, 0);
  clientfield::register("world", "" + #"crash_fx", 1, 1, "int", &car_crash_fx, 0, 0);
  clientfield::register("world", "" + #"hash_4f672a8a7ae530e5", 1, 1, "int", &function_f99ce12b, 0, 0);
}

init_flags() {}

init_fx() {
  level._effect[#"safe_fx"] = #"hash_4bf40208439d50d6";
  level._effect[#"flare_launch_fx"] = #"hash_4b6b503d842bc415";
  level._effect[#"flare_launch_fx_red"] = #"hash_cf3c06e4368bbb1";
  level._effect[#"hash_55ab46637a8fbcb3"] = #"hash_5508b1d8864ee2d2";
  level._effect[#"flare_launch_fx_green"] = #"hash_33da19858ee59385";
  level._effect[#"red_fireworks_fx"] = #"hash_1b5b754131008f70";
  level._effect[#"green_fireworks_fx"] = #"hash_770af2dde4a0938c";
  level._effect[#"blue_fireworks_fx"] = #"hash_41eac18dc72dac23";
  level._effect[#"car_crash_fx"] = #"hash_5e9dff5fcbf30022";
  level._effect[#"shield_impact_fx"] = #"hash_4144490ff4773f4b";
  level._effect[#"portal_pass_fx"] = #"hash_1a3fcc6c808e55eb";
  level._effect[#"hash_51ecda6f24a58d05"] = #"hash_13c3cecd3d059c90";
  level._effect[#"engine_damage_smoke"] = #"hash_706103079a2bdb6d";
  level._effect[#"hash_3524e302fa83d12e"] = #"hash_3a791d490f01f5c7";
  level._effect[#"engine_damage_sparks"] = #"hash_15dc4292340f0f1c";
  level._effect[#"engine_damage_boom"] = #"hash_7691f79bfc16f0bf";
  level._effect[#"car_lights"] = #"hash_335feb1d213c22f6";
  level._effect[#"hash_1c0ed73a9b21a882"] = #"hash_cc7196a44e2fbe3";
  level._effect[#"hash_704d3c12d59fb5d7"] = #"hash_2aabc11b07ad74d8";
  level._effect[#"hash_4ec5da9e09256102"] = #"hash_3063115f97c18abf";
  level._effect[#"vomit_blade_fx_1p"] = #"hash_51ca82e6f2c21354";
  level._effect[#"vomit_blade_fx_3p"] = #"hash_51d16ee6f2c81006";
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
        self.var_37649f83 = playviewmodelfx(localclientnum, level._effect[#"vomit_blade_fx_1p"], "tag_fx");
      }
    } else {
      self.var_37649f83 = util::playFXOnTag(localclientnum, level._effect[#"vomit_blade_fx_3p"], self, "tag_fx");
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
  if(newval && isDefined(level._effect[#"engine_damage_sparks"])) {
    self util::waittill_dobj(localclientnum);
    self.var_f756621f = util::playFXOnTag(localclientnum, level._effect[#"engine_damage_smoke"], self, "tag_origin");
    playFX(localclientnum, level._effect[#"engine_damage_boom"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    playrumbleonposition(localclientnum, #"hash_743b325bf45e1c8c", self.origin);
    playSound(localclientnum, #"hash_188d7d9f6b62346f", (0, 0, 0));
    wait 0.75;

    if(isDefined(self)) {
      playFX(localclientnum, level._effect[#"engine_damage_sparks"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
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

shield_frost_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrenderoverridebundle(#"rob_tricannon_character_ice");
    s_loc = struct::get(#"shield_table_fx");
    playFX(localclientnum, level._effect[#"shield_impact_fx"], s_loc.origin);
    audio::playloopat("zmb_frost_table_loop", self.origin);
  }
}

car_crash_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    s_loc = struct::get(#"car_crash_loc");
    playFX(localclientnum, level._effect[#"car_crash_fx"], s_loc.origin);
  }
}

portal_pass_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_2745e294)) {
    killfx(localclientnum, self.var_2745e294);
    self.var_2745e294 = undefined;
  }

  if(newval == 1) {
    self util::waittill_dobj(localclientnum);
    self.var_2745e294 = util::playFXOnTag(localclientnum, level._effect[#"portal_pass_fx"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    self.var_2745e294 = util::playFXOnTag(localclientnum, level._effect[#"hash_51ecda6f24a58d05"], self, "tag_origin");
    return;
  }

  playFX(localclientnum, level._effect[#"blue_fireworks_fx"], self.origin);
}

sea_walker_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  s_loc = struct::get(#"floaters_fx");

  if(newval == 1) {
    s_loc.fx = playFX(localclientnum, level._effect[#"sea_walker_fx"], s_loc.origin, anglesToForward(s_loc.angles), anglestoup(s_loc.angles));
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
    util::playFXOnTag(localclientnum, level._effect[#"flare_launch_fx"], self, "tag_origin");

    if(newval == 1) {
      if(!isDefined(self.fx)) {
        self.fx = util::playFXOnTag(localclientnum, level._effect[#"flare_launch_fx_red"], self, "tag_origin");
        wait 1.5;

        if(isDefined(self)) {
          playFX(localclientnum, level._effect[#"red_fireworks_fx"], self.origin);
        }
      }
    } else if(newval == 2) {
      if(!isDefined(self.fx)) {
        self.fx = util::playFXOnTag(localclientnum, level._effect[#"flare_launch_fx_green"], self, "tag_origin");
        wait 1.5;

        if(isDefined(self)) {
          playFX(localclientnum, level._effect[#"green_fireworks_fx"], self.origin);
        }
      }
    } else if(newval == 3) {
      if(!isDefined(self.fx)) {
        self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_55ab46637a8fbcb3"], self, "tag_origin");
        wait 1.5;

        if(isDefined(self)) {
          playFX(localclientnum, level._effect[#"blue_fireworks_fx"], self.origin);
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
    playFX(localclientnum, level._effect[#"red_fireworks_fx"], s_loc.origin);
    playSound(0, #"hash_40d3baad4b103e04", s_loc.origin);
    return;
  }

  if(newval == 2) {
    a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
    s_loc = a_s_locs[randomint(a_s_locs.size)];
    playFX(localclientnum, level._effect[#"green_fireworks_fx"], s_loc.origin);
    playSound(0, #"hash_40d3baad4b103e04", s_loc.origin);
    return;
  }

  if(newval == 3) {
    a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
    s_loc = a_s_locs[randomint(a_s_locs.size)];
    playFX(localclientnum, level._effect[#"blue_fireworks_fx"], s_loc.origin);
    playSound(0, #"hash_40d3baad4b103e04", s_loc.origin);
  }
}