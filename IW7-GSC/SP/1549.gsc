/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1549.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_firejack_med");
  self attach("head_bg_var_head_sc_engineering_mate_head_male_bc_04_beard", "", 1);
  self.headmodel = "head_bg_var_head_sc_engineering_mate_head_male_bc_04_beard";
  scripts\code\character::attachhat("alias_hats_navy_engineering_mate", _id_0996::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_crew_ship_firejack_med");
  precachemodel("head_bg_var_head_sc_engineering_mate_head_male_bc_04_beard");
  scripts\code\character::precachemodelarray(_id_0996::main());
}