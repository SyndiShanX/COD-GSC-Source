/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ee_yellow_snow.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_sq_modules;

#namespace zm_orange_ee_yellow_snow;

preload() {
  level._effect[#"campfire_soul"] = #"hash_59977c4c851916e0";
  level._effect[#"hash_6d2d7bab75c2c0"] = #"hash_1a06427eff8dfe13";
  level._effect[#"campfire_flames"] = #"hash_487863cb3f012833";
  level._effect[#"snowpile_swap"] = #"hash_6d8c75ffdf65fe0";
  init_clientfields();
  forcestreamxmodel("p8_zm_ora_specimen_container_lrg_cracked");
  forcestreamxmodel("p8_zm_ora_specimen_container_lrg_dmg");
  forcestreamxmodel("p8_zm_ora_yellow_snowball_pile");
}

function

init_clientfields() {
  zm_sq_modules::function_d8383812(#"snowball_campfire_1", 24000, "snowball_campfire_1", 400, level._effect[#"campfire_soul"], level._effect[#"hash_6d2d7bab75c2c0"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"snowball_campfire_2", 24000, "snowball_campfire_2", 400, level._effect[#"campfire_soul"], level._effect[#"hash_6d2d7bab75c2c0"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"snowball_campfire_3", 24000, "snowball_campfire_3", 400, level._effect[#"campfire_soul"], level._effect[#"hash_6d2d7bab75c2c0"], undefined, undefined, 1);
  clientfield::register("scriptmover", "fx8_reward_brazier_fire_blue", 24000, 1, "int", &campfire_flames, 0, 0);
  clientfield::register("scriptmover", "fx8_snowpile_swap", 24000, 1, "int", &snowpile_swap, 0, 0);
  clientfield::register("toplayer", "spleen_carry_sound", 20000, 1, "int", &spleen_carry_sound, 0, 0);
}

campfire_flames(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.fx_sparks = util::playFXOnTag(localclientnum, level._effect[#"campfire_flames"], self, "tag_origin");
  }
}

snowpile_swap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.fx_sparks = util::playFXOnTag(localclientnum, level._effect[#"snowpile_swap"], self, "tag_origin");
  }
}

spleen_carry_sound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_b93060b3 = self playLoopSound(#"hash_59783b8d2accba79");
    return;
  }

  self playSound(localclientnum, #"hash_37f5db96bc2147cd");
  self stoploopsound(self.var_b93060b3);
  self.var_b93060b3 = undefined;
}