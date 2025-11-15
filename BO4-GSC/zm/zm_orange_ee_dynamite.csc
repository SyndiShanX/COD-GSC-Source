/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ee_dynamite.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_ee_dynamite;

init() {
  level._effect[#"hash_281c546a716f0d89"] = #"hash_29df8e00a5429cf0";
  level._effect[#"dynamite_explosion"] = #"hash_eb0cf9b1e7697fb";
  level._effect[#"hash_463a8d75b304b3d5"] = #"hash_e52765b1b6a1c81";
  clientfield::register("scriptmover", "" + #"dynamite_explosion_fx", 24000, 1, "counter", &play_dynamite_explosion_fx, 0, 0);
  clientfield::register("actor", "" + #"hash_6adfdd12c9656e1c", 24000, 1, "int", &function_ee32b1b8, 0, 0);
  clientfield::register("actor", "" + #"hash_147a734966a62e10", 24000, 1, "counter", &function_baf2de8d, 0, 0);
  forcestreamxmodel("p8_zm_ora_dynamite_barrier_destroyed");
}

play_dynamite_explosion_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, level._effect[#"dynamite_explosion"], self.origin, anglestoright(self.angles));
}

function_ee32b1b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_31d7361d)) {
    stopfx(localclientnum, self.var_31d7361d);
    self.var_31d7361d = undefined;
  }

  if(newval > 0) {
    self.var_31d7361d = util::playFXOnTag(localclientnum, level._effect[#"hash_281c546a716f0d89"], self, "j_spine4");
  }
}

function_baf2de8d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_463a8d75b304b3d5"], self, "j_spine4");
}