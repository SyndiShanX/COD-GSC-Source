/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 985.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_094B::main());
  scripts\code\character::attachhead("alias_bg_female_heads_drone", _id_092A::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian_female";
  self.voice = "unitednationsfemale";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_094B::main());
  scripts\code\character::precachemodelarray(_id_092A::main());
}