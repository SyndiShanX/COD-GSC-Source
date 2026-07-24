/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2262.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_sdf_army_light_2_kotch");
  self attach("head_sdf_kotch_hqss", "", 1);
  self.headmodel = "head_sdf_kotch_hqss";
  self.hatmodel = "helmet_sdf_army_kotch";
  self attach(self.hatmodel);
  self._id_A489 = "sdf_army_boost_pack_zerog_snow";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "setdef";
  self _meth_82C6("vestheavy");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_sdf_army_light_2_kotch");
  precachemodel("head_sdf_kotch_hqss");
  precachemodel("helmet_sdf_army_kotch");
  precachemodel("sdf_army_boost_pack_zerog_snow");
}