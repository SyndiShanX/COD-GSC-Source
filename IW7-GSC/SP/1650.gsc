/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1650.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_medic_female_med");
  self attach("head_bg_var_head_female_bc_01_head_sc_owens", "", 1);
  self.headmodel = "head_bg_var_head_female_bc_01_head_sc_owens";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_crew_medic_female_med");
  precachemodel("head_bg_var_head_female_bc_01_head_sc_owens");
}