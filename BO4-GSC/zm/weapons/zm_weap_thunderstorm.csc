/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_thunderstorm.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_thunderstorm;

autoexec __init__system__() {
  system::register(#"zm_weap_thunderstorm", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("scriptmover", "" + #"aoe_indicator", 16000, 1, "counter", &aoe_indicator_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"electric_storm", 16000, 1, "int", &electric_storm_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_7006a7d528a6f05c", 16000, 3, "int", &function_6e837718, 0, 0);
  clientfield::register("actor", "" + #"hash_51b05e5d116438a9", 16000, 3, "int", &function_46a56fe2, 0, 0);
  clientfield::register("actor", "" + #"hash_561a1fd86bc1a53a", 16000, 1, "int", &function_ab086ad8, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_43cf6c236d2e9ba", 16000, 1, "counter", &function_acecb36a, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_1187b848bf7868c5", 16000, 1, "int", &function_5b4619, 0, 0);
  level._effect[#"electric_storm"] = #"hash_162a58538b5d6db0";
  level._effect[#"hash_11c14ffaefdfd970"] = #"hash_515548ac872ebd06";
  level._effect[#"hash_3d5823fb08a48ea1"] = #"hash_58e484ac8b26c8ef";
  level._effect[#"hash_6da9e29916d2ac16"] = #"hash_7668b8e00c2854ae";
  level._effect[#"hash_43cf6c236d2e9ba"] = #"hash_7d7d5c3856622734";
  level._effect[#"electrocute"] = #"hash_5aa1120d061d1f6c";
  level._effect[#"aoe_marker"] = #"hash_211c80023671737b";
  level._effect[#"hash_6bfee027c13054b6"] = #"hash_2dc8e3470244bf1c";
  level._effect[#"hash_788ff1a315628747"] = #"hash_661f2c77e14f0edf";
  level._effect[#"pegasus_teleport"] = #"hash_5f7d8c231fbcf09e";
}

__main__() {
  if(!zm_weapons::is_weapon_included(getweapon(#"thunderstorm"))) {
    return;
  }
}

function_ab086ad8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self gettagorigin("j_eyeball_le"))) {
      self.var_1550c80f = util::playFXOnTag(localclientnum, level._effect[#"hemera_proj_death_head"], self, "j_eyeball_le");
    } else if(isDefined(self gettagorigin("j_head"))) {
      self.var_1550c80f = util::playFXOnTag(localclientnum, level._effect[#"hemera_proj_death_head"], self, "j_head");
    }

    return;
  }

  if(isDefined(self) && isDefined(self.var_1550c80f)) {
    deletefx(localclientnum, self.var_1550c80f);
    self.var_1550c80f = undefined;
  }
}

aoe_indicator_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::playFXOnTag(localclientnum, level._effect[#"aoe_marker"], self, "tag_origin");
}

electric_storm_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0:
      if(isDefined(self.var_d00cf6ff)) {
        stopfx(localclientnum, self.var_d00cf6ff);
        self.var_d00cf6ff = undefined;
      }

      break;
    case 1:
      self.var_d00cf6ff = playFX(localclientnum, level._effect[#"electric_storm"], self.origin + (0, 0, 180), self.angles);
      break;
  }
}

function_acecb36a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_43cf6c236d2e9ba"], self, "tag_origin");
}

function_6e837718(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.var_667af8b4[newval] = self;

  if(isDefined(self gettagorigin("j_h_chest"))) {
    playFX(localclientnum, level._effect[#"pegasus_teleport"], self gettagorigin("j_h_chest"), self gettagangles("j_h_chest"));
    return;
  }

  if(newval == 5) {
    playFX(localclientnum, level._effect[#"pegasus_teleport"], self.origin);
  }
}

function_46a56fe2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!isDefined(level.var_667af8b4)) {
    return;
  }

  var_10d4f67d = level.var_667af8b4[newval];

  if(!isDefined(var_10d4f67d)) {
    return;
  }

  if(!newval) {
    return;
  }

  var_10d4f67d endon(#"death");
  v_left = var_10d4f67d gettagorigin("j_feather_le_10");
  v_right = var_10d4f67d gettagorigin("j_feather_ri_10");

  if(distancesquared(v_left, self.origin) < distancesquared(v_right, self.origin)) {
    str_tag = "j_feather_le_10";
  } else {
    str_tag = "j_feather_ri_10";
  }

  level beam::launch(var_10d4f67d, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike", 1);
  self playSound(localclientnum, #"hash_61c057ffadb7a5af");
  wait 0.3;
  level beam::kill(var_10d4f67d, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike");
}

function_5b4619(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_788ff1a315628747"], self, "tag_fx_ball");
  util::playFXOnTag(localclientnum, level._effect[#"hash_6bfee027c13054b6"], self, "tag_fx_ball");
}