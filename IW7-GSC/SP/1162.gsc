/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1162.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0952::main());
  self attach("head_female_bc_02_dusty", "", 1);
  self.headmodel = "head_female_bc_02_dusty";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian_female";
  self.voice = "unitednationsfemale";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0952::main());
  precachemodel("head_female_bc_02_dusty");
}