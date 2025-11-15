/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_sendoff.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_mq_sendoff;

preload() {
  level._effect[#"hash_490bb70162069301"] = #"hash_406e48055b40a506";
  clientfield::register("vehicle", "" + #"wisp_fx", 24000, 1, "int", &function_e5ecfa90, 0, 0);
}

function_e5ecfa90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_490bb70162069301"], self, "tag_origin");
}