/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_soapstone.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_sq_modules;

#namespace zm_orange_mq_soapstone;

preload() {
  level._effect[#"soapstone_cold"] = #"hash_75215ea3c21f31d3";
  level._effect[#"soapstone_hot"] = #"hash_7cdf08df557a9b3f";
  init_clientfields();
}

function

init_clientfields() {
  clientfield::register("scriptmover", "soapstone_start_fx", 24000, 2, "int", &soapstone_fx, 0, 0);
}

soapstone_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.fx_glow)) {
    stopfx(localclientnum, self.fx_glow);
    self.fx_glow = undefined;
  }

  if(newval == 1) {
    self.fx_glow = util::playFXOnTag(localclientnum, level._effect[#"soapstone_cold"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    self.fx_glow = util::playFXOnTag(localclientnum, level._effect[#"soapstone_hot"], self, "tag_origin");
  }
}