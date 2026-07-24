/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1795.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_medic");
  self attach("head_bg_var_head_male_bc_05_head_sc_male_20", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_05_head_sc_male_20";
  self.hatmodel = "head_male_bc_05_bg_hair_male_mask_a_brown";
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
  precachemodel("body_un_crew_medic");
  precachemodel("head_bg_var_head_male_bc_05_head_sc_male_20");
  precachemodel("head_male_bc_05_bg_hair_male_mask_a_brown");
}