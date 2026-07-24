/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1799.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_093A::main());
  scripts\code\character::attachhead("alias_heads_un_crew_ship_bandaged_engineering_mate", _id_09C7::main());
  scripts\code\character::attachhat("alias_hats_un_crew_ship_bandaged_engineering_mate", _id_09BD::main());
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
  scripts\code\character::precachemodelarray(_id_093A::main());
  scripts\code\character::precachemodelarray(_id_09C7::main());
  scripts\code\character::precachemodelarray(_id_09BD::main());
}