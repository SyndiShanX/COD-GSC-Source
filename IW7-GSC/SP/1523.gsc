/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1523.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_mech");
  self attach("head_bg_var_head_male_bc_03_head_male_bc_05", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_03_head_male_bc_05";
  scripts\code\character::attachhat("alias_hats_navy_male_bc_03", _id_09B0::main());
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
  precachemodel("body_un_crew_mech");
  precachemodel("head_bg_var_head_male_bc_03_head_male_bc_05");
  scripts\code\character::precachemodelarray(_id_09B0::main());
}