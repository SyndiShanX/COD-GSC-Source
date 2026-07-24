/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1948.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09E3::main());
  self attach("head_bg_var_head_male_bc_01_head_male_bc_04_beard", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_01_head_male_bc_04_beard";
  scripts\code\character::attachhat("alias_hats_navy_male_bc_01", _id_09AC::main());
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
  precachemodel("head_bg_var_head_male_bc_01_head_male_bc_04_beard");
  scripts\code\character::precachemodelarray(_id_09AC::main());
}