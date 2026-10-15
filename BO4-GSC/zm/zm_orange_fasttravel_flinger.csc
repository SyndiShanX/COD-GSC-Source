/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_fasttravel_flinger.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_fasttravel_flinger;

init() {
  clientfield::register("scriptmover", "gear_box_spark", 24000, 1, "int", &gear_box_spark_fx, 0, 0);
  clientfield::register("scriptmover", "flinger_impact_wood", 24000, 1, "int", &flinger_impact_wood_fx, 0, 0);
  clientfield::register("clientuimodel", "ZMInventoryPersonal.heat_pack", 1, 1, "int", undefined, 0, 0);
  level._effect[#"hash_5bea6497d336bbf"] = #"hash_299249c1ff22e1c2";
  level._effect[#"flinger_impact_wood"] = #"hash_7677e82b27eada6f";
  forcestreamxmodel("p8_zm_ora_crate_wood_01_tall_open_lid_dmg");
}

gear_box_spark_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_91180673 = util::playFXOnTag(localclientnum, level._effect[#"hash_5bea6497d336bbf"], self, "tag_generator");
    return;
  }

  if(isDefined(self.var_91180673)) {
    stopfx(localclientnum, self.var_91180673);
    self.var_91180673 = undefined;
  }
}

flinger_impact_wood_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_91180673 = util::playFXOnTag(localclientnum, level._effect[#"flinger_impact_wood"], self, "tag_origin");
  }
}