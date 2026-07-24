/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1099.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0960::main());
  self attach("head_bg_var_head_bg_male_06_head_male_bc_04", "", 1);
  self.headmodel = "head_bg_var_head_bg_male_06_head_male_bc_04";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0960::main());
  precachemodel("head_bg_var_head_bg_male_06_head_male_bc_04");
}