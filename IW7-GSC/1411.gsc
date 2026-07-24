/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1411.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_mech_female");
  self attach("head_sc_female_04", "", 1);
  self.headmodel = "head_sc_female_04";
  scripts\code\character::attachhat("alias_hats_navy_female_04_hair", _id_099B::main());
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
  precachemodel("body_un_crew_mech_female");
  precachemodel("head_sc_female_04");
  scripts\code\character::precachemodelarray(_id_099B::main());
}