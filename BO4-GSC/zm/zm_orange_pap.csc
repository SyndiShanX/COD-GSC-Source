/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_pap.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace zm_orange_pap;

init() {
  init_clientfields();
  level._effect[#"hash_604a40ef1ed899a4"] = #"hash_7d36c353ea2640ad";
  level._effect[#"hash_74f5897234e8d579"] = #"hash_59c49f21e6675534";
}

init_clientfields() {
  clientfield::register("world", "zm_orange_extinguish_fire", 24000, 2, "counter", &function_f65638a4, 0, 0);
  clientfield::register("scriptmover", "zm_orange_pap_rock_glow", 24000, 1, "int", &function_50758ed4, 0, 0);
}

function_f65638a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    s_fx = struct::get("fire_extinguisher_l_fx_struct", "targetname");
    playFX(localclientnum, level._effect[#"hash_604a40ef1ed899a4"], s_fx.origin, anglesToForward(s_fx.angles));
    return;
  }

  if(newval == 2) {
    s_fx = struct::get("fire_extinguisher_r_fx_struct", "targetname");
    playFX(localclientnum, level._effect[#"hash_604a40ef1ed899a4"], s_fx.origin, anglesToForward(s_fx.angles));
  }
}

function_50758ed4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_74f5897234e8d579"], self, "tag_origin");
}