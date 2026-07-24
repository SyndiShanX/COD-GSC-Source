/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2036.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09E3::main());
  self attach("head_bg_var_head_male_bc_02_head_male_bc_04", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_02_head_male_bc_04";
  self.hatmodel = "head_male_bc_02_breathing_mask";
  self attach(self.hatmodel);
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
  scripts\code\character::precachemodelarray(_id_09E3::main());
  precachemodel("head_bg_var_head_male_bc_02_head_male_bc_04");
  precachemodel("head_male_bc_02_breathing_mask");
}