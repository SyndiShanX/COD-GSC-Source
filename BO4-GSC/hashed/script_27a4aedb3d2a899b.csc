/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_27a4aedb3d2a899b.csc
***********************************************/

#include script_5f90a0e71aee1dc4;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace namespace_90b0490e;

preload() {
  level._effect[#"hash_5167810d20f56cde"] = #"hash_ea58012779b62a6";
  level._effect[#"hash_7076baef5f9776c0"] = #"hash_5a0d3d80e5fadfe8";
  level._effect[#"hash_5a1b907f8cfb78f9"] = #"hash_1fe7b0ba967e52f6";
  namespace_bd74bbd2::register(#"sc_mk2z_1", 20000, "sc_mk2z_1", level._effect[#"hash_5167810d20f56cde"], level._effect[#"hash_7076baef5f9776c0"]);
  namespace_bd74bbd2::register(#"sc_mk2z_2", 20000, "sc_mk2z_2", level._effect[#"hash_5167810d20f56cde"], level._effect[#"hash_7076baef5f9776c0"]);
  namespace_bd74bbd2::register(#"sc_mk2z_3", 20000, "sc_mk2z_3", level._effect[#"hash_5167810d20f56cde"], level._effect[#"hash_7076baef5f9776c0"]);
  clientfield::register("scriptmover", "" + #"hash_2184dd4e9090521f", 20000, 1, "int", &function_7cd6e78c, 0, 0);
}

function_7cd6e78c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_5a1b907f8cfb78f9"], self, "tag_origin");
  }
}