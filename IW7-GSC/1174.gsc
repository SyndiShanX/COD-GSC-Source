/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1174.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_095D::main());
  scripts\code\character::attachhead("alias_bg_male_heads_drone", _id_0934::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_095D::main());
  scripts\code\character::precachemodelarray(_id_0934::main());
}