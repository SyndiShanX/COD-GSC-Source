/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_fuse.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_sq_modules;

#namespace zm_orange_mq_fuse;

preload() {
  level._effect[#"generator_soul"] = #"hash_59977c4c851916e0";
  level._effect[#"hash_25d427b0d162135a"] = #"hash_1a06427eff8dfe13";
  level._effect[#"elemental_shard_glow"] = #"hash_4310e1cb3f897c7c";
  init_clientfields();
}

function

init_clientfields() {
  zm_sq_modules::function_d8383812(#"little_bird_1", 24000, "little_bird_1", 400, level._effect[#"generator_soul"], level._effect[#"hash_25d427b0d162135a"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"little_bird_2", 24000, "little_bird_2", 400, level._effect[#"generator_soul"], level._effect[#"hash_25d427b0d162135a"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"little_bird_3", 24000, "little_bird_3", 400, level._effect[#"generator_soul"], level._effect[#"hash_25d427b0d162135a"], undefined, undefined, 1);
  clientfield::register("scriptmover", "elemental_shard_glow", 24000, 1, "int", &elemental_shard_glow, 0, 0);
}

elemental_shard_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.fx_glow = util::playFXOnTag(localclientnum, level._effect[#"elemental_shard_glow"], self, "tag_origin");
    return;
  }

  stopfx(localclientnum, self.fx_glow);
}