/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2262.gsc
*********************************************/

main() {
  self setModel("body_sdf_army_light_2_kotch");
  self attach("head_sdf_kotch_hqss", "", 1);
  self.headmodel = "head_sdf_kotch_hqss";
  self.hatmodel = "helmet_sdf_army_kotch";
  self attach(self.hatmodel);
  self.var_A489 = "sdf_army_boost_pack_zerog_snow";
  self attach(self.var_A489);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "soldier";
  self.voice = "setdef";
  self give_explosive_touch_on_revived("vestheavy");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_sdf_army_light_2_kotch");
  precachemodel("head_sdf_kotch_hqss");
  precachemodel("helmet_sdf_army_kotch");
  precachemodel("sdf_army_boost_pack_zerog_snow");
}