/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1179.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("civ_miner_male");
  scripts\code\character::attachhead("heads_civ_miner_male", _id_09F2::main());
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
  precachemodel("civ_miner_male");
  scripts\code\character::precachemodelarray(_id_09F2::main());
}