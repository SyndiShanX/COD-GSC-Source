/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1150.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_095F::main());
  self attach("head_sc_male_11_dusty", "", 1);
  self.headmodel = "head_sc_male_11_dusty";
  self.hatmodel = "head_sc_male_11_bg_hair_male_a_black_dusty";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_095F::main());
  precachemodel("head_sc_male_11_dusty");
  precachemodel("head_sc_male_11_bg_hair_male_a_black_dusty");
}