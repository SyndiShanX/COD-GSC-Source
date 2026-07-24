/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2176.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_bdu");
  self attach("head_bg_var_head_male_bc_01_head_male_bc_05", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_01_head_male_bc_05";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_marines_bdu");
  precachemodel("head_bg_var_head_male_bc_01_head_male_bc_05");
}