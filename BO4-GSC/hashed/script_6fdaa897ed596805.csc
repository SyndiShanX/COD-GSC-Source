/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_6fdaa897ed596805.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_sq_modules;

#namespace namespace_4b68b2b3;

preload() {
  level._effect[#"pap_soul"] = #"hash_59977c4c851916e0";
  level._effect[#"hash_1549a7f7c4a3d66e"] = #"hash_1a06427eff8dfe13";
  level._effect[#"pap_explosion"] = #"hash_c25bcbc2422f364";
  level._effect[#"pap_fire"] = #"hash_4847c0d5a4c9cd6";
  init_clientfields();
}

function

init_clientfields() {
  zm_sq_modules::function_d8383812(#"sc_pap_beach", 24000, "sc_pap_beach", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_pap_boathouse", 24000, "sc_pap_boathouse", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_pap_ship", 24000, "sc_pap_ship", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_pap_lagoon", 24000, "sc_pap_lagoon", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_pap_island", 24000, "sc_pap_island", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
  clientfield::register("scriptmover", "" + #"hash_411947cf11cffb69", 24000, 1, "int", &pap_explosion, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_249c83f6060ea7ba", 24000, 1, "int", &pap_fire, 0, 0);
}

pap_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.fx_explosion = util::playFXOnTag(localclientnum, level._effect[#"pap_explosion"], self, "tag_origin");
  }
}

pap_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.fx_fire = util::playFXOnTag(localclientnum, level._effect[#"pap_fire"], self, "tag_origin");
  }
}