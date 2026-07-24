/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1905.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09DE::main());
  scripts\code\character::attachhead("alias_un_crew_ship_heads_lowbone_male", _id_09EB::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09DE::main());
  scripts\code\character::precachemodelarray(_id_09EB::main());
}