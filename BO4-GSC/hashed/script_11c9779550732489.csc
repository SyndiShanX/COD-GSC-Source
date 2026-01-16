/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_11c9779550732489.csc
***********************************************/

#include scripts\core_common\animation_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace namespace_42cc2819;

autoexec __init__system__() {
  system::register(#"hash_77ae506b4db4f2ce", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "" + #"hash_11ff39a3100ac894", 1, 1, "int", &function_e7b6c72b, 0, 0);
  clientfield::register("toplayer", "" + #"hash_37c33178198d54e4", 1, 1, "int", &function_2a127860, 0, 0);
  clientfield::register("toplayer", "" + #"hash_5d9808a62579e894", 1, 1, "int", &function_f0e07568, 0, 0);
  clientfield::register("toplayer", "" + #"hash_4ec2b359458774e4", 1, 1, "int", &function_7353e021, 0, 0);
  clientfield::register("toplayer", "" + #"hash_4724376be4e925a3", 1, 1, "int", &function_3b405536, 0, 0);
  clientfield::register("toplayer", "" + #"hash_1aa1c7790dc67d1e", 1, 1, "int", &function_46b21d8a, 0, 0);
  clientfield::register("toplayer", "" + #"hash_7cdfc8f4819bab2e", 1, 1, "int", &function_73ca75df, 0, 0);
  clientfield::register("toplayer", "" + #"hash_61ed2f45564d54f9", 1, 1, "int", &function_fa6bb35e, 0, 0);
  clientfield::register("toplayer", "" + #"totem_fall", 1, 1, "int", &totem_fall, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_2a7ceb22f84e5aa9", 1, 1, "int", &function_85aab97f, 0, 0);
  level._effect[#"hash_1aa1c7790dc67d1e"] = #"hash_2a9ea20e6cb5f0fb";
  level._effect[#"hash_7cdfc8f4819bab2e"] = #"hash_e1bfaf62712f587";
  level._effect[#"hash_61ed2f45564d54f9"] = #"hash_5531980ba0ce0b70";
  level._effect[#"blood_rise"] = #"hash_56628b3f5bc6da0d";
  level._effect[#"blood_splash"] = #"hash_4d27fd6de25c639b";
}

function_e7b6c72b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_8d97f43e)) {
    var_1eaed254 = struct::get("s_g_r_sp2");
    self.var_8d97f43e = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin, var_1eaed254.angles);
  }

  if(newval) {
    self.var_8d97f43e show();
    return;
  }

  self.var_8d97f43e hide();
}

function_2a127860(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_c7b21349)) {
    var_1eaed254 = struct::get("s_r_s_sp2");
    self.var_c7b21349 = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin, var_1eaed254.angles);
  }

  if(newval) {
    self.var_c7b21349 show();
    return;
  }

  self.var_c7b21349 hide();
}

function_f0e07568(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_477a641f)) {
    var_1eaed254 = struct::get("s_acid_trap_place_loc");
    self.var_477a641f = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin, var_1eaed254.angles);
  }

  if(newval) {
    self.var_477a641f show();
    playSound(0, #"hash_52b00c7836adfd1e", var_1eaed254.origin);
    return;
  }

  self.var_477a641f hide();
}

function_7353e021(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_a86cb7e0)) {
    var_1eaed254 = struct::get("s_spin_trap_place_loc");
    self.var_a86cb7e0 = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin - (0, 0, 3), var_1eaed254.angles);
  }

  if(newval) {
    self.var_a86cb7e0 show();
    playSound(0, #"hash_52b00c7836adfd1e", var_1eaed254.origin);
    return;
  }

  self.var_a86cb7e0 hide();
}

function_3b405536(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_40bb11af)) {
    var_1eaed254 = struct::get("s_fan_trap_place_loc");
    self.var_40bb11af = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin - (0, 0, 3), var_1eaed254.angles);
  }

  if(newval) {
    self.var_40bb11af show();
    playSound(0, #"hash_52b00c7836adfd1e", var_1eaed254.origin);
    return;
  }

  self.var_40bb11af hide();
}

function_46b21d8a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_1eaed254 = struct::get("s_spin_trap_place_loc");
  self.var_73fb3946 = playFX(localclientnum, level._effect[#"hash_1aa1c7790dc67d1e"], var_1eaed254.origin - (0, 0, 3));
  playSound(0, #"hash_3375efdd38e50fb8", var_1eaed254.origin);
}

function_73ca75df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_1eaed254 = struct::get("s_acid_trap_place_loc");
  self.var_9c0a6f6d = playFX(localclientnum, level._effect[#"hash_7cdfc8f4819bab2e"], var_1eaed254.origin);
  playSound(0, #"hash_3375efdd38e50fb8", var_1eaed254.origin);
}

function_fa6bb35e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_1eaed254 = struct::get("s_fan_trap_place_loc");
  self.var_c61d3d80 = playFX(localclientnum, level._effect[#"hash_61ed2f45564d54f9"], var_1eaed254.origin - (0, 0, 3));
  playSound(0, #"hash_3375efdd38e50fb8", var_1eaed254.origin);
}

totem_fall(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_e9af628d = struct::get("mdl_d_w_i_k_t");
  s_destination = struct::get(var_e9af628d.target);
  mdl_totem = util::spawn_model(localclientnum, #"hash_3964c81546296b78", var_e9af628d.origin, var_e9af628d.angles);
  mdl_totem moveto(s_destination.origin, 1);
}

function_85aab97f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_f383d0c1)) {
    killfx(localclientnum, self.var_f383d0c1);
    self.var_f383d0c1 = undefined;
  }

  if(isDefined(self.var_53b18c8d)) {
    killfx(localclientnum, self.var_53b18c8d);
    self.var_53b18c8d = undefined;
  }

  if(newval) {
    var_3bda41ab = struct::get("s_white_metal_splash");
    self.var_f383d0c1 = util::playFXOnTag(localclientnum, level._effect[#"blood_rise"], self, "tag_spork");
    self.var_53b18c8d = playFX(localclientnum, level._effect[#"blood_splash"], var_3bda41ab.origin);
  }
}