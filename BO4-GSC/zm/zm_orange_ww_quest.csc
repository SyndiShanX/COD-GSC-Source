/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ww_quest.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_sq_modules;

#namespace zm_orange_ww_quest;

init() {
  level._effect[#"hash_64578452d3392d94"] = #"hash_26f4e63105355909";
  level._effect[#"hash_171687586f676b43"] = #"hash_59977c4c851916e0";
  level._effect[#"hash_7567992d6a81fd89"] = #"hash_1a06427eff8dfe13";
  clientfield::register("scriptmover", "vril_device_glow", 24000, 1, "int", &_target_saving, 0, 0);
  zm_sq_modules::function_d8383812(#"sc_ww_quest", 24000, "sc_ww_quest", 200, level._effect[#"hash_171687586f676b43"], level._effect[#"hash_7567992d6a81fd89"], undefined, undefined, 1);
}

soul_release(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_171687586f676b43"], self, "tag_origin");
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[#"hash_7567992d6a81fd89"], self, "tag_origin");
}

_target_saving(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_64578452d3392d94"], self, "tag_origin");
  }
}