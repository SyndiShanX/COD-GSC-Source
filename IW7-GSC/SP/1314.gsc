/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1314.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0938::main());
  self attach("head_bg_var_head_sc_male_17_head_sc_male_24", "", 1);
  self.headmodel = "head_bg_var_head_sc_male_17_head_sc_male_24";
  self.hatmodel = "head_sc_male_17_hat_sdf_capital_ship";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "setdef";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0938::main());
  precachemodel("head_bg_var_head_sc_male_17_head_sc_male_24");
  precachemodel("head_sc_male_17_hat_sdf_capital_ship");
}