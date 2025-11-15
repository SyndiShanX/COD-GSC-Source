/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_14e736d5e4272b3d.csc
***********************************************/

#include script_5f90a0e71aee1dc4;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace namespace_3b2b9e06;

preload() {
  level._effect[#"hash_707c26879c95b230"] = #"hash_40278bdd6f1bccd4";
  level._effect[#"hash_28331736982b6322"] = #"hash_23c866d50fb30876";
  level._effect[#"hash_5bfd50fb8c3b5ffb"] = #"hash_6b79a8fd6c76e84c";
  level._effect[#"mk2x_guard"] = #"hash_251307aa9b1c5042";
  namespace_bd74bbd2::register(#"sc_mk2x", 20000, "sc_mk2x", level._effect[#"hash_707c26879c95b230"], level._effect[#"hash_28331736982b6322"]);
  clientfield::register("scriptmover", "" + #"hash_56a1bc72bf8de8f1", 20000, 1, "int", &function_7cd6e78c, 0, 0);
  clientfield::register("actor", "" + #"hash_38c69da8fb2b74e4", 20000, 1, "int", &function_fab5ffa, 0, 0);
}

function_7cd6e78c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_5bfd50fb8c3b5ffb"], self, "tag_origin");
  }
}

function_fab5ffa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_fx_tag = self zm_utility::function_467efa7b(1);
    util::playFXOnTag(localclientnum, level._effect[#"mk2x_guard"], self, str_fx_tag);
  }
}