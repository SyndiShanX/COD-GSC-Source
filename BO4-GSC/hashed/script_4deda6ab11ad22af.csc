/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_4deda6ab11ad22af.csc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_sq_modules;

#namespace namespace_a01a2431;

preload() {
  level._effect[#"hash_445a09d57b925de2"] = #"hash_59977c4c851916e0";
  level._effect[#"hash_22616c5de5b8bbf4"] = #"hash_1a06427eff8dfe13";
  zm_sq_modules::function_d8383812(#"sc_ww_screen1", 20000, "sc_ww_screen1", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_ww_screen2", 20000, "sc_ww_screen2", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_ww_screen3", 20000, "sc_ww_screen3", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_ww_screen4", 20000, "sc_ww_screen4", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
}

soul_release(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_445a09d57b925de2"], self, "tag_origin");
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[#"hash_22616c5de5b8bbf4"], self, "tag_origin");
}