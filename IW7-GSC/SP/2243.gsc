/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2243.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0943::main());
  scripts\code\character::attachhead("heads_un_marines_female", _id_09F4::main());
  self._id_A489 = "pack_female";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednationsfemale";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0943::main());
  scripts\code\character::precachemodelarray(_id_09F4::main());
  precachemodel("pack_female");
}