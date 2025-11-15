/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_challenges.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_red_challenges_rewards;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_utility;

#namespace zm_red_challenges;

init() {
  if(zm_utility::is_standard()) {
    return;
  }

  clientfield::register("scriptmover", "" + #"hash_74fc30de57a0657a", 16000, 3, "int", &function_de1bffd6, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_21f5fab6a3d22093", 16000, 3, "int", &function_9ed71eeb, 0, 0);
  clientfield::register("scriptmover", "" + #"keyline_model", 16000, 1, "int", &keyline_model, 0, 0);
  clientfield::register("scriptmover", "" + #"pickup_glow", 16000, 1, "int", &pickup_glow, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_8b48433c3fe40e4", 16000, 3, "int", &function_75ac8f21, 0, 0);
  clientfield::register("toplayer", "" + #"hash_4bde11d71410ea67", 16000, 3, "int", &function_250bbf4e, 0, 0);
  clientfield::register("world", "" + #"cleanup_challenges", 16000, 1, "int", &cleanup_challenges, 0, 0);
  clientfield::register("allplayers", "" + #"hash_47490b879090eb55", 16000, 3, "int", &function_840d5e0b, 0, 0);
  clientfield::register("allplayers", "" + #"hash_7b1dd5c08e2585c", 16000, 3, "int", &function_c63a4f32, 0, 0);
  clientfield::register("scriptmover", "" + #"rob_coals", 16000, 1, "int", &rob_coals, 0, 0);
  level._effect[#"hash_379eadfebd945316"] = #"hash_556b5a8aa255768d";
  level._effect[#"hash_3229d3874a037840"] = #"hash_48053ee21dfed9c9";
  level._effect[#"hash_31c3f08749acf655"] = #"hash_482741e21e1bc548";
  level._effect[#"hash_31c0cd8749aa8505"] = #"hash_482b24e21e1f7cd8";
  level._effect[#"hash_5f92f2e28c7ef455"] = #"hash_13cf1738cd97717e";
  level._effect[#"brazier_fire_blue"] = #"hash_487863cb3f012833";
  level._effect[#"brazier_fire_green"] = #"hash_276c55785b205f4e";
  level._effect[#"hash_533608bb3b3407b6"] = #"hash_4eff7803b81cd67d";
  level._effect[#"brazier_fire_purple"] = #"hash_2a46ebc323110b3d";
  level._effect[#"hash_64a625f8e26e3699"] = #"hash_79207c9d697f9e30";
  level._effect[#"hash_fa374812e6016c9"][1] = #"hash_676d05725a4ffab9";
  level._effect[#"hash_eafc8632695ccef"][1] = #"hash_511e23c849ed0926";
  level._effect[#"hash_fa374812e6016c9"][2] = #"hash_5199aa40f704fb10";
  level._effect[#"hash_eafc8632695ccef"][2] = #"hash_1dfbcfd9b38812ed";
  level._effect[#"hash_fa374812e6016c9"][3] = #"hash_6bfc5d7fce6b2a4e";
  level._effect[#"hash_eafc8632695ccef"][3] = #"maps/zm_red/fx8_soul_charge_purple";
  level._effect[#"hash_fa374812e6016c9"][4] = #"hash_6cfbd6f08cfc2656";
  level._effect[#"hash_eafc8632695ccef"][4] = #"hash_17bb97645fa8148b";
  level._effect[#"pickup_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";
  zm_red_challenges_rewards::init();
  level.var_7987392b = undefined;
}

function_de1bffd6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_36f175fc)) {
    stopfx(localclientnum, self.var_36f175fc);
    self.var_36f175fc = undefined;
  }

  v_pos = self.origin;
  v_up = (1, 0, 0);
  v_forward = (0, 0, 1);

  switch (newval) {
    case 0:
      return;
    case 1:
      level.var_6437d5e7 = 0.002;
      self.var_36f175fc = playFX(localclientnum, level._effect[#"hash_379eadfebd945316"], v_pos, v_up, v_forward);
      break;
    case 2:
      level.var_6437d5e7 = 0.01;
      self.var_36f175fc = playFX(localclientnum, level._effect[#"hash_3229d3874a037840"], v_pos, v_up, v_forward);
      break;
    case 3:
      level.var_6437d5e7 = 0.015;
      self.var_36f175fc = playFX(localclientnum, level._effect[#"hash_31c3f08749acf655"], v_pos, v_up, v_forward);
      break;
    case 4:
      level.var_6437d5e7 = 0.02;
      self.var_36f175fc = playFX(localclientnum, level._effect[#"hash_31c0cd8749aa8505"], v_pos, v_up, v_forward);
      break;
    case 5:
      level.var_6437d5e7 = 0.025;
      self.var_36f175fc = playFX(localclientnum, level._effect[#"hash_5f92f2e28c7ef455"], v_pos, v_up, v_forward);
      break;
  }

  if(isDefined(self.var_b7c1fb99)) {
    self stoploopsound(self.var_b7c1fb99);
    self.var_b7c1fb99 = undefined;
  }

  var_ff01f974 = newval;

  if(level.var_6437d5e7 == 0.025) {
    var_ff01f974 = 4;
  }

  self playSound(localclientnum, #"hash_4b301fe401c4f18");
  self.var_b7c1fb99 = self playLoopSound(#"hash_6143f452bc746a62" + var_ff01f974);
}

function_9ed71eeb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_9c32107c)) {
    stopfx(localclientnum, self.var_9c32107c);
    self.var_9c32107c = undefined;
  }

  v_pos = self.origin + (0, 0, 7);
  v_dir = anglesToForward(self.angles);
  v_pos += v_dir * 9;
  v_up = (0, 0, 1);
  v_forward = (1, 0, 0);

  switch (newval) {
    case 0:
      break;
    case 1:
      self.var_9c32107c = playFX(localclientnum, level._effect[#"hash_64a625f8e26e3699"], v_pos, v_up, v_forward);
      break;
    case 2:
      self.var_9c32107c = playFX(localclientnum, level._effect[#"brazier_fire_blue"], v_pos, v_up, v_forward);
      break;
    case 3:
      self.var_9c32107c = playFX(localclientnum, level._effect[#"brazier_fire_purple"], v_pos, v_up, v_forward);
      break;
    case 4:
      self.var_9c32107c = playFX(localclientnum, level._effect[#"hash_533608bb3b3407b6"], v_pos, v_up, v_forward);
      break;
  }

  if(newval == 0) {
    if(isDefined(self.var_b10399e)) {
      self playSound(localclientnum, #"hash_284f0a411f78c07c");
      self stoploopsound(self.var_b10399e);
      self.var_b10399e = undefined;
    }

    return;
  }

  if(!isDefined(self.var_b10399e)) {
    self playSound(localclientnum, #"hash_6845d8009f05e81c");
    self.var_b10399e = self playLoopSound(#"hash_205cc527b5726b4d");
  }
}

keyline_model(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == oldval) {
    return;
  }

  if(newval) {
    self playrenderoverridebundle(#"rob_sonar_set_friendly");
    return;
  }

  self stoprenderoverridebundle(#"rob_sonar_set_friendly");
}

pickup_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"pickup_glow"], self, "tag_origin");
}

function_75ac8f21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_7987392b)) {
    level.var_7987392b = [];
  }

  self.var_f147da98 = newval;
  level.var_7987392b[level.var_7987392b.size] = self;
}

function_3298ba0(n_index) {
  if(isDefined(level.var_7987392b) && isarray(level.var_7987392b)) {
    foreach(mdl_bowl in level.var_7987392b) {
      if(isDefined(mdl_bowl)) {
        if(mdl_bowl.var_f147da98 == n_index) {
          return mdl_bowl;
        }
      }
    }
  }

  return undefined;
}

function_250bbf4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(newval) {
    mdl_bowl = self function_3298ba0(newval);

    if(isDefined(mdl_bowl)) {
      mdl_bowl playrenderoverridebundle(#"rob_sonar_set_friendly");
    }
  }
}

cleanup_challenges(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.var_7987392b) && isarray(level.var_7987392b)) {
    foreach(mdl_bowl in level.var_7987392b) {
      if(isDefined(mdl_bowl)) {
        mdl_bowl stoprenderoverridebundle(#"rob_sonar_set_friendly");
      }
    }
  }
}

function_840d5e0b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_c68d7a3e = newval;
}

function_c63a4f32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(newval) {
    if(!isDefined(self.var_c68d7a3e)) {
      return;
    }

    n_index = self.var_c68d7a3e;
    mdl_bowl = self function_3298ba0(newval);

    if(!isDefined(mdl_bowl)) {
      return;
    }

    e_fx = spawn(localclientnum, mdl_bowl.origin, "script_model");
    e_fx setModel(#"tag_origin");
    e_fx playSound(localclientnum, "zmb_sq_souls_release");
    e_fx.sfx_id = e_fx playLoopSound(#"zmb_sq_souls_lp");
    util::playFXOnTag(localclientnum, level._effect[#"hash_fa374812e6016c9"][n_index], e_fx, "tag_origin");
    wait 0.3;
    s_target = struct::get("s_apollo_challenge_fx_loc", "targetname");
    power = distance(e_fx.origin, s_target.origin);
    n_time = e_fx fake_physicslaunch(s_target.origin, power, 0.85);
    wait n_time;
    e_fx playSound(localclientnum, "zmb_sq_souls_impact");
    e_fx stoploopsound(e_fx.sfx_id);
    util::playFXOnTag(localclientnum, level._effect[#"hash_eafc8632695ccef"][n_index], e_fx, "tag_origin");
    wait 0.3;
    e_fx delete();
  }
}

fake_physicslaunch(target_pos, power, var_4862f668) {
  start_pos = self.origin;
  gravity = getdvarint(#"bg_gravity", 0) * -1;
  gravity *= var_4862f668;
  dist = distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * time * time;
  velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
  self movegravity(velocity, time);
  return time;
}

rob_coals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread function_4eff20ff();
    return;
  }

  self notify(#"hash_6bc81dae92c4902e");
  self thread function_23333a90();
}

function_4eff20ff() {
  self endon(#"death", #"hash_6bc81dae92c4902e");
  self playrenderoverridebundle("rob_zm_red_cin_coals");
  level.var_75ca8fda = 0;
  level.var_6437d5e7 = 0.002;
  self function_78233d29("rob_zm_red_cin_coals", "", "Brightness", 1);
  self function_78233d29("rob_zm_red_cin_coals", "", "Tint", 1);

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    self function_78233d29("rob_zm_red_cin_coals", "", "Alpha", level.var_75ca8fda);
    level.var_75ca8fda += level.var_6437d5e7;

    if(level.var_75ca8fda >= 1) {
      level.var_75ca8fda = 1;
      level.var_6437d5e7 *= -1;
    } else if(level.var_75ca8fda <= 0.2) {
      level.var_75ca8fda = 0.2;
      level.var_6437d5e7 *= -1;
    }

    waitframe(1);
  }
}

function_23333a90() {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");

  while(level.var_75ca8fda > 0) {
    level.var_75ca8fda -= 0.002;

    if(level.var_75ca8fda < 0) {
      level.var_75ca8fda = 0;
    }

    self function_78233d29("rob_zm_red_cin_coals", "", "Alpha", level.var_75ca8fda);
    waitframe(1);
  }

  self stoprenderoverridebundle("rob_zm_red_cin_coals");
}