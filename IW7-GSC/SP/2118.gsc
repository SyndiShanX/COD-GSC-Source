/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2118.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_female_bdu");
  self attach("head_bg_var_head_sc_female_04_head_sc_female_14", "", 1);
  self.headmodel = "head_bg_var_head_sc_female_04_head_sc_female_14";
  scripts\code\character::attachhat("alias_hats_marine_female_04", _id_0971::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_marines_female_bdu");
  precachemodel("head_bg_var_head_sc_female_04_head_sc_female_14");
  scripts\code\character::precachemodelarray(_id_0971::main());
}