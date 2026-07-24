/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2119.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_female_bdu_med");
  self attach("head_sc_female_05", "", 1);
  self.headmodel = "head_sc_female_05";
  scripts\code\character::attachhat("alias_hats_marine_female_05_hair", _id_0978::main());
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
  precachemodel("body_un_marines_female_bdu_med");
  precachemodel("head_sc_female_05");
  scripts\code\character::precachemodelarray(_id_0978::main());
}