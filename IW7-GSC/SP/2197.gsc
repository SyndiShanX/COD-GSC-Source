/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2197.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_bdu");
  self attach("head_bg_var_head_male_bc_04_head_sc_engineering_mate", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_04_head_sc_engineering_mate";
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
  precachemodel("body_un_marines_bdu");
  precachemodel("head_bg_var_head_male_bc_04_head_sc_engineering_mate");
}