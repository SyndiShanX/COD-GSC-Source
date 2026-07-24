/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1749.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_medic_drk");
  self attach("head_bg_var_head_sc_engineering_mate_head_male_bc_01", "", 1);
  self.headmodel = "head_bg_var_head_sc_engineering_mate_head_male_bc_01";
  self.hatmodel = "head_sc_engineering_mate_breathing_mask";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_crew_medic_drk");
  precachemodel("head_bg_var_head_sc_engineering_mate_head_male_bc_01");
  precachemodel("head_sc_engineering_mate_breathing_mask");
}