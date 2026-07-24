/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1312.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0938::main());
  self attach("head_bg_var_head_sc_kloos_head_sc_male_24", "", 1);
  self.headmodel = "head_bg_var_head_sc_kloos_head_sc_male_24";
  scripts\code\character::attachhat("alias_hats_sdf_crew_ship_kloos_male_24", _id_09B8::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "setdef";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0938::main());
  precachemodel("head_bg_var_head_sc_kloos_head_sc_male_24");
  scripts\code\character::precachemodelarray(_id_09B8::main());
}