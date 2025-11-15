/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ee_tundragun.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_ee_tundragun;

init() {}

play_dynamite_explosion_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"dynamite_explosion"], self, "tag_origin");
}

function_ee32b1b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_281c546a716f0d89"], self, "j_spine4");
}