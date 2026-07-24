/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2244.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0942::main());
  self attach("head_sc_male_10", "", 1);
  self.headmodel = "head_sc_male_10";
  self._id_A489 = "pack_un_jackal_pilots";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0942::main());
  precachemodel("head_sc_male_10");
  precachemodel("pack_un_jackal_pilots");
}