/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2007.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09E2::main());
  self attach("head_bg_var_head_sc_female_14_head_sc_female_05", "", 1);
  self.headmodel = "head_bg_var_head_sc_female_14_head_sc_female_05";
  scripts\code\character::attachhat("alias_hats_mars_female_14_female_05", _id_098B::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09E2::main());
  precachemodel("head_bg_var_head_sc_female_14_head_sc_female_05");
  scripts\code\character::precachemodelarray(_id_098B::main());
}