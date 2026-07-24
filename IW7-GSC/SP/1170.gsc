/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1170.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_094E::main());
  self attach("head_sc_female_13_dusty", "", 1);
  self.headmodel = "head_sc_female_13_dusty";
  self.hatmodel = "head_sc_female_13_bg_hair_female_a_black_dusty";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian_female";
  self.voice = "unitednationsfemale";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_094E::main());
  precachemodel("head_sc_female_13_dusty");
  precachemodel("head_sc_female_13_bg_hair_female_a_black_dusty");
}