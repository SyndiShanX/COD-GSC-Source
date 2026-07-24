/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1800.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0939::main());
  scripts\code\character::attachhead("alias_heads_un_crew_ship_bandaged_female_14", _id_09C8::main());
  self.hatmodel = "head_sc_female_14_head_bandage_c";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0939::main());
  scripts\code\character::precachemodelarray(_id_09C8::main());
  precachemodel("head_sc_female_14_head_bandage_c");
}