/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_traps_firegates.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace namespace_a35b43eb;

autoexec __init__system__() {
  system::register(#"hash_18d1bdf8dbbfec6c", &__init__, undefined, undefined);
}

__init__() {
  init_clientfields();
  level._effect[#"trap_light_green"] = #"hash_3b61ca07c83b7171";
  level._effect[#"trap_light_red"] = #"hash_7534672c207c08ed";
}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"trap_light", 8000, 2, "int", &function_1d5b8b9f, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_17df66ef5f71c0de", 8000, 2, "int", &function_b3f0f5cd, 0, 0);
}

function_1d5b8b9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_d476c975)) {
    stopfx(localclientnum, self.var_d476c975);
    self.var_d476c975 = undefined;
  }

  if(isDefined(self.var_16c041ae)) {
    stopfx(localclientnum, self.var_16c041ae);
    self.var_16c041ae = undefined;
  }

  if(newval == 1) {
    self.var_d476c975 = util::playFXOnTag(localclientnum, level._effect[#"trap_light_green"], self, "light_fx_tag");
    return;
  }

  if(newval == 2) {
    self.var_16c041ae = util::playFXOnTag(localclientnum, level._effect[#"trap_light_red"], self, "light_fx_tag");
  }
}

function_b3f0f5cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_fca46d00)) {
    stopfx(localclientnum, self.var_fca46d00);
    self.var_fca46d00 = undefined;
    stopfx(localclientnum, self.var_f7653c4b);
    self.var_f7653c4b = undefined;
  }

  if(isDefined(self.var_7504a327)) {
    stopfx(localclientnum, self.var_7504a327);
    self.var_7504a327 = undefined;
    stopfx(localclientnum, self.var_5a0ff99d);
    self.var_5a0ff99d = undefined;
  }

  if(newval == 1) {
    self.var_fca46d00 = util::playFXOnTag(localclientnum, level._effect[#"trap_light_green"], self, "j_light_lt");
    self.var_f7653c4b = util::playFXOnTag(localclientnum, level._effect[#"trap_light_green"], self, "j_light_rt");
    return;
  }

  if(newval == 2) {
    self.var_7504a327 = util::playFXOnTag(localclientnum, level._effect[#"trap_light_red"], self, "j_light_lt");
    self.var_5a0ff99d = util::playFXOnTag(localclientnum, level._effect[#"trap_light_red"], self, "j_light_rt");
  }
}