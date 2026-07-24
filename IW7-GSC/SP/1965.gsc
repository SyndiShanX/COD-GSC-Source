/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1965.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09DE::main());
  self attach("head_bg_var_head_male_bc_03_head_sc_engineering_mate", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_03_head_sc_engineering_mate";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09DE::main());
  precachemodel("head_bg_var_head_male_bc_03_head_sc_engineering_mate");
}