/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_hand_ouranos.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\serverfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_hand_ouranos;

autoexec __init__system__() {
  system::register(#"zm_weap_hand_ouranos", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "ouranos_shoot", 16000, 1, "counter", &function_b3ffbfd, 0, 0);
  clientfield::register("scriptmover", "ouranos_impact", 16000, 1, "counter", &ouranos_impact_fx, 0, 0);
  clientfield::register("allplayers", "" + #"ouranos_beam_fire", 16000, 1, "int", &skull_turret_beam_fire, 0, 1);
  clientfield::register("allplayers", "" + #"hash_4fb73e88d45af0ef", 16000, 1, "int", &function_98b06f97, 0, 1);
  clientfield::register("actor", "" + #"ouranos_proj_knock", 16000, getminbitcountfornum(3), "int", &function_a1d614f9, 0, 1);
  clientfield::register("actor", "" + #"ouranos_zombie_impact", 16000, 1, "counter", &function_1322534b, 0, 0);
  serverfield::register("ouranos_feather_hit", 16000, getminbitcountfornum(3), "int");
  level._effect[#"ouranos_wind"] = #"hash_3ee5b689d09f0824";
  level._effect[#"ouranos_trail"] = #"hash_62f4ee1a2e3c46fc";
  level._effect[#"ouranos_impact"] = #"hash_5869597389a55f7b";
  level._effect[#"ouranos_proj_knock"] = #"hash_215ead487c4bef59";
  level._effect[#"ouranos_wind_knock"] = #"hash_4cc40e13ee8dff61";
  level._effect[#"hash_31736c99409b40ef"] = #"hash_44bd80522ac100e7";
}

function_1322534b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self gettagorigin("j_spine4"))) {
    v_org = self gettagorigin("j_spine4");
  } else {
    str_tag = self zm_utility::function_467efa7b();

    if(!isDefined(str_tag)) {
      str_tag = "tag_origin";
    } else {
      v_org = self gettagorigin(str_tag);
    }
  }

  playFX(localclientnum, level._effect[#"ouranos_impact"], v_org, anglesToForward(self.angles));
  playSound(localclientnum, #"hash_3360f981ac697bfe", self.origin);
}

function_a1d614f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self gettagorigin("j_spine4"))) {
    str_tag = "j_spine4";
  } else {
    str_tag = self zm_utility::function_467efa7b();

    if(!isDefined(str_tag)) {
      str_tag = "tag_origin";
    }
  }

  if(newval == 1) {
    self playSound(localclientnum, #"hash_3360f981ac697bfe");
    util::playFXOnTag(localclientnum, level._effect[#"ouranos_proj_knock"], self, str_tag);
    return;
  }

  if(newval == 2) {
    self playSound(localclientnum, #"hash_3360f981ac697bfe");
    util::playFXOnTag(localclientnum, level._effect[#"ouranos_wind_knock"], self, str_tag);
    return;
  }

  if(newval == 3) {
    self playSound(localclientnum, #"hash_3360f981ac697bfe");
    util::playFXOnTag(localclientnum, level._effect[#"ouranos_proj_knock"], self, str_tag);
    self thread function_f89a4434(localclientnum);
  }
}

function_f89a4434(localclientnum) {
  waitframe(1);

  if(!isDefined(self) || !isDefined(self.enemy)) {
    return;
  }

  self endon(#"death");
  self.enemy endon(#"death");
  vol_center = getent(localclientnum, "vol_ww_ouranos_center_fletching", "targetname");
  vol_cliff = getent(localclientnum, "vol_ww_ouranos_cliff_fletching", "targetname");
  vol_serpent = getent(localclientnum, "vol_ww_ouranos_serpent_fletching", "targetname");

  while(isDefined(self)) {
    if(isDefined(vol_center) && istouching(self.origin, vol_center)) {
      if(isDefined(self.enemy)) {
        self.enemy thread function_1ebdc841(1);
        break;
      }
    } else if(isDefined(vol_cliff) && istouching(self.origin, vol_cliff)) {
      if(isDefined(self.enemy)) {
        self.enemy thread function_1ebdc841(2);
        break;
      }
    } else if(isDefined(vol_serpent) && istouching(self.origin, vol_serpent)) {
      if(isDefined(self.enemy)) {
        self.enemy thread function_1ebdc841(3);
        break;
      }
    }

    waitframe(1);
  }
}

function_1ebdc841(n_feather) {
  self endon(#"death");
  self serverfield::set("ouranos_feather_hit", n_feather);
  waitframe(1);
  self serverfield::set("ouranos_feather_hit", 0);
}

function_b3ffbfd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"ouranos_trail"], self, "tag_origin");

  if(!isDefined(self.n_sfx)) {
    self.n_sfx = self playLoopSound(#"hash_166762facd657625");
  }
}

ouranos_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
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

  playFX(localclientnum, level._effect[#"ouranos_impact"], v_org, v_ang);
  playSound(localclientnum, #"hash_d09856cb05b1a39", self.origin);
}

skull_turret_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death", #"disconnect");

  if(newval == 1) {
    if(isDefined(self.var_c400cdd5)) {
      killfx(localclientnum, self.var_c400cdd5);
      self.var_c400cdd5 = undefined;
    }

    if(!self zm_utility::function_f8796df3(localclientnum)) {
      self.var_c400cdd5 = util::playFXOnTag(localclientnum, level._effect[#"hash_31736c99409b40ef"], self, "tag_weapon_right");
    }

    if(!isDefined(self.var_76c23e4c)) {
      self playSound(localclientnum, #"hash_5e5e7d42f62fb92d");
      self.var_76c23e4c = self playLoopSound(#"hash_14ac86ceee99d2f3");
    }

    return;
  }

  if(isDefined(self.var_c400cdd5)) {
    killfx(localclientnum, self.var_c400cdd5);
    self.var_c400cdd5 = undefined;
  }

  if(isDefined(self.var_76c23e4c)) {
    self playSound(localclientnum, #"hash_6b91419f41fc8d34");
    self stoploopsound(self.var_76c23e4c);
    self.var_76c23e4c = undefined;
  }
}

function_98b06f97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.var_76c23e4c)) {
      self playSound(localclientnum, #"hash_5e5e7d42f62fb92d");
      self.var_76c23e4c = self playLoopSound(#"hash_14ac86ceee99d2f3");
    }

    return;
  }

  if(isDefined(self.var_76c23e4c)) {
    self playSound(localclientnum, #"hash_6b91419f41fc8d34");
    self stoploopsound(self.var_76c23e4c);
    self.var_76c23e4c = undefined;
  }
}