/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2006.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09E0::main());
  self attach("head_bg_var_head_sc_female_14_head_sc_female_04", "", 1);
  self.headmodel = "head_bg_var_head_sc_female_14_head_sc_female_04";
  self.hatmodel = "head_sc_female_14_bg_hair_female_mask_c_blonde";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09E0::main());
  precachemodel("head_bg_var_head_sc_female_14_head_sc_female_04");
  precachemodel("head_sc_female_14_bg_hair_female_mask_c_blonde");
}