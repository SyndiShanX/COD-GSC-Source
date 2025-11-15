/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_lighthouse.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_lighthouse;

autoexec __init__system__() {
  system::register(#"zm_orange_lighthouse", &__init__, undefined, undefined);
}

__init__() {
  init_clientfields();
  init_fx();
  forcestreamxmodel("p8_zm_ora_soapstone_01_hot");
}

init_clientfields() {
  clientfield::register("scriptmover", "lighthouse_on", 24000, 3, "int", &function_6a10478, 0, 0);
  clientfield::register("vehicle", "" + #"hash_19bce46b8ab82440", 24000, 1, "int", &function_c7fb0e97, 0, 0);
  clientfield::register("actor", "" + #"hash_5af1cd27f90895ae", 24000, 1, "counter", &function_a177b2da, 0, 0);
}

init_fx() {
  level._effect[#"lighthouse_beam"] = #"hash_5549637de48b4ff5";
  level._effect[#"hash_4eeea3cde4956976"] = #"hash_52b7a2fb71b00d26";
  level._effect[#"hash_33dbdabd23d73303"] = #"hash_1806470e7079c133";
  level._effect[#"hash_21a180bd19425da5"] = #"hash_5cd0d0e65e6d535";
  level._effect[#"hash_58fef59f738c6315"] = #"explosions/fx8_exp_elec_killstreak";
  level._effect[#"hash_48d5d5ee69c7e417"] = #"hash_64be6c1537ad552e";
  level._effect[#"hash_4d1abbf031ca2c63"] = #"hash_6144e721b78e74a4";
}

function_6a10478(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.fx_id)) {
    stopfx(localclientnum, self.fx_id);

    if(isDefined(self.centerstruct)) {
      self.centerstruct stoploopsound(1);
      self.centerstruct delete();
    }
  }

  switch (newval) {
    case 1:
      if(isDefined(self.centerstruct)) {
        self.centerstruct stoploopsound(1);
        self.centerstruct delete();
      }

      self.fx_id = util::playFXOnTag(localclientnum, level._effect[#"lighthouse_beam"], self, "tag_origin");
      self playSound(localclientnum, #"hash_c28cead5117620");
      self.centerstruct = spawn(0, self.origin, "script_origin");
      self.centerstruct playLoopSound(#"hash_6181b0e69ec35a3b");
      break;
    case 2:
      if(isDefined(self.centerstruct)) {
        self.centerstruct stoploopsound(1);
        self.centerstruct delete();
      }

      self.fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_4eeea3cde4956976"], self, "tag_origin");
      self playSound(localclientnum, #"hash_261c471e4722bb37");
      self.centerstruct = spawn(0, self.origin, "script_origin");
      self.centerstruct playLoopSound(#"hash_b838aafaa7056a0");
      break;
    case 3:
      if(isDefined(self.centerstruct)) {
        self.centerstruct stoploopsound(1);
        self.centerstruct delete();
      }

      self.fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_33dbdabd23d73303"], self, "tag_origin");
      self playSound(localclientnum, #"hash_153e70c4ae966276");
      self.centerstruct = spawn(0, self.origin, "script_origin");
      self.centerstruct playLoopSound(#"hash_764437252a54048d");
      break;
    case 4:
      if(isDefined(self.centerstruct)) {
        self.centerstruct stoploopsound(1);
        self.centerstruct delete();
      }

      self.fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_21a180bd19425da5"], self, "tag_origin");
      self playSound(localclientnum, #"hash_3734fecc702f7cd0");
      self.centerstruct = spawn(0, self.origin, "script_origin");
      self.centerstruct playLoopSound(#"hash_518712532057a8b");
      break;
  }
}

function_a177b2da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_4d1abbf031ca2c63"], self, "j_spine4");
  self playSound(localclientnum, #"hash_24925b24b30b3991");
}

function_c7fb0e97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_85adeb8c)) {
    beamkill(localclientnum, self.var_85adeb8c);
    self.var_85adeb8c = undefined;
  }

  if(isDefined(self.var_9c7e4ef8)) {
    stopfx(localclientnum, self.var_9c7e4ef8);
  }

  if(newval > 0) {
    var_ab11c23d = getent(localclientnum, "lighthouse_light", "targetname");
    self.var_85adeb8c = level beam::function_cfb2f62a(localclientnum, var_ab11c23d, "tag_origin", self, "tag_origin", "beam8_zm_orange_lighthouse_trap_strike");
    self.var_9c7e4ef8 = util::playFXOnTag(localclientnum, level._effect[#"hash_48d5d5ee69c7e417"], self, "tag_origin");
  }
}