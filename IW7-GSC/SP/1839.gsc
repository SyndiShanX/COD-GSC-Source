/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1839.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09E2::main());
  self attach("head_bg_var_head_female_bc_02_head_sc_comms_officer_head", "", 1);
  self.headmodel = "head_bg_var_head_female_bc_02_head_sc_comms_officer_head";
  self.hatmodel = "head_female_bc_02_hat";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09E2::main());
  precachemodel("head_bg_var_head_female_bc_02_head_sc_comms_officer_head");
  precachemodel("head_female_bc_02_hat");
}