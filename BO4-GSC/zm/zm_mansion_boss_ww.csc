/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_boss_ww.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace mansion_boss_ww;

autoexec __init__system__() {
  system::register(#"mansion_boss_ww", &__init__, undefined, undefined);
}

__init__() {
  init_clientfields();
  init_fx();
}

init_clientfields() {
  clientfield::register("world", "" + #"hash_2709d50a7b0a2b01", 8000, 1, "int", &function_6e123c7b, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_87483ed44cb2791", 8000, 1, "int", &function_a346a156, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_69c1868b7a8a7beb", 8000, 1, "int", &function_72efa790, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_1bf2c2f62ad1bf56", 8000, 1, "int", &function_931bac5a, 0, 0);
  clientfield::register("scriptmover", "bs_sigil_fx", 8000, 3, "int", &function_1d15a456, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_5cca35fc43fa51e6", 8000, 3, "int", &function_444660d9, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_6ad20bd0d84e8602", 8000, 1, "int", &function_abea158a, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_4ca506515aec02d3", 8000, 1, "int", &function_b5901c02, 0, 0);
  clientfield::register("allplayers", "pstfx_zm_man_targeted_cf", 8000, 1, "int", &function_2a48bf1c, 0, 0);
}

init_fx() {
  level._effect[#"hash_1e4fa83f4db14c46"] = #"hash_40a93ef9da58e006";
  level._effect[#"fx8_boss_eye_glow"] = #"hash_1cd0bfd0a3ff1817";
  level._effect[#"hash_420110993bafb86b"] = #"hash_4edfb7b10f36a12b";
  level._effect[#"hash_3665813f5609df50"] = #"hash_105035871586710";
  level._effect[#"hash_2699e8762805fbdc"] = #"hash_f378b1b7c38569c";
  level._effect[#"hash_4cd18caca0e2880b"] = #"hash_155810298f5c76cb";
  level._effect[#"hash_4d8984a98c0beba2"] = #"hash_ea19875e4f1d962";
  level._effect[#"hash_24ce7f381d2f1ff5"] = #"hash_4ca6f513f26662b5";
}

function_6e123c7b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_a5777754(localclientnum, "boss_arena");
}

function_a346a156(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self thread function_f389e70d(localclientnum);

  if(newval == 1) {
    self playrenderoverridebundle(#"hash_c5c4890c94eb1c7");
    playSound(localclientnum, #"hash_8fc267f3e184882", self.origin);
    return;
  }

  self stoprenderoverridebundle(#"hash_c5c4890c94eb1c7");
  playSound(localclientnum, #"hash_f5264369f84b89b", self.origin);
}

function_72efa790(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self thread function_f389e70d(localclientnum);

  if(newval == 1) {
    self playrenderoverridebundle(#"hash_6a2d3edbb0f2c98d");
    return;
  }

  self stoprenderoverridebundle(#"hash_6a2d3edbb0f2c98d");
}

function_f389e70d(localclientnum) {
  self endon(#"death");

  if(!isDefined(self.var_aac4aa35)) {
    self.var_aac4aa35 = util::playFXOnTag(localclientnum, level._effect[#"fx8_boss_eye_glow"], self, "tag_eye");
  } else {
    if(isDefined(self.var_aac4aa35)) {
      stopfx(localclientnum, self.var_aac4aa35);
    }

    self.var_aac4aa35 = undefined;
  }

  self.var_e0580f33 = util::playFXOnTag(localclientnum, level._effect[#"hash_1e4fa83f4db14c46"], self, "j_spine4");
  wait 0.5;

  if(isDefined(self.var_e0580f33)) {
    stopfx(localclientnum, self.var_e0580f33);
  }

  self.var_e0580f33 = undefined;
}

function_931bac5a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self mapshaderconstant(localclientnum, 0, "ScriptVector4", 0, 1, 0, 0);
    return;
  }

  self mapshaderconstant(localclientnum, 0, "ScriptVector4", 0, 0, 0, 0);
}

function_1d15a456(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_aa8c0343)) {
    stopfx(localclientnum, self.var_aa8c0343);
  }

  switch (newval) {
    case 1:
      self.var_aa8c0343 = playFX(localclientnum, level._effect[#"hash_2699e8762805fbdc"], self.origin, anglesToForward(self.angles));
      audio::playloopat(#"hash_868fc0612e15eaf", self.origin + (0, 0, 50));
      audio::stoploopat(#"hash_3fdf4ea8be67182e", self.origin + (0, 0, 50));
      playSound(localclientnum, #"hash_c22b771ecbf8bb6", self.origin + (0, 0, 50));
      break;
    case 2:
      self.var_aa8c0343 = playFX(localclientnum, level._effect[#"hash_3665813f5609df50"], self.origin, anglesToForward(self.angles));
      audio::stoploopat(#"hash_868fc0612e15eaf", self.origin + (0, 0, 50));
      audio::playloopat(#"hash_3fdf4ea8be67182e", self.origin + (0, 0, 50));
      playSound(localclientnum, #"hash_24d107d1b3a13829", self.origin + (0, 0, 50));
      break;
    case 3:
      self.var_aa8c0343 = playFX(localclientnum, level._effect[#"hash_4cd18caca0e2880b"], self.origin, anglesToForward(self.angles));
      audio::stoploopat(#"hash_868fc0612e15eaf", self.origin + (0, 0, 50));
      audio::stoploopat(#"hash_3fdf4ea8be67182e", self.origin + (0, 0, 50));
      break;
  }
}

function_444660d9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_69ab30d0)) {
    self stoprenderoverridebundle(self.var_69ab30d0, "ROOT");
  }

  self.var_69ab30d0 = undefined;

  switch (newval) {
    case 0:
      return;
    case 1:
      self.var_69ab30d0 = #"hash_7de33b7647f4c33a";
      break;
    case 2:
      self.var_69ab30d0 = #"hash_7de33a7647f4c187";
      break;
    case 3:
      self.var_69ab30d0 = #"hash_7de3397647f4bfd4";
      break;
  }

  if(!isDefined(self.var_69ab30d0)) {
    self.var_69ab30d0 = #"hash_7de33b7647f4c33a";
  }

  self playrenderoverridebundle(self.var_69ab30d0, "ROOT");
}

function_abea158a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_e6b19280 = util::playFXOnTag(localclientnum, level._effect[#"hash_4d8984a98c0beba2"], self, "tag_fx");
    return;
  }

  if(isDefined(self.var_e6b19280)) {
    stopfx(localclientnum, self.var_e6b19280);
  }

  self.var_e6b19280 = undefined;
}

function_b5901c02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_7a21c346 = util::playFXOnTag(localclientnum, level._effect[#"hash_24ce7f381d2f1ff5"], self, "tag_fx");
    return;
  }

  if(isDefined(self.var_7a21c346)) {
    stopfx(localclientnum, self.var_7a21c346);
  }

  self.var_7a21c346 = undefined;
}

function_2a48bf1c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self zm_utility::function_f8796df3(localclientnum)) {
    return;
  }

  if(newval) {
    self thread postfx::playpostfxbundle(#"pstfx_zm_man_targeted");
    return;
  }

  self thread postfx::exitpostfxbundle(#"pstfx_zm_man_targeted");
}