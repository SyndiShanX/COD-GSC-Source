/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_677379a420006e12.gsc
***********************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "shadowcompany";
  scripts\code\character::setmodelfromarray(_id_2392966A8013DF29::main());
  scripts\code\character::attachhead("heads_iw9_enemy_pmc_tier3", _id_77E16AE71F2F8F7A::main());
  self setclothtype("vestheavy");
  self _meth_8ABE5A968CC3C220("millghtgr");
  self _meth_1863F51C1339D80F("none");

  if(issentient(self))
    self sethitlocdamagetable("ai_lochit_dmgtable");
}

#using_animtree("generic_human");

_id_951CCE2992B1B0E2() {
  main();
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self useanimtree(#animtree);
}

_id_8EE09B8CB8661567() {
  main();
}

precache() {}

_id_430419022A9C3FFE() {
  precache();
  scripts\code\character::precachemodelarray(_id_2392966A8013DF29::main());
  scripts\code\character::precachemodelarray(_id_77E16AE71F2F8F7A::main());
}

_id_8168FBF6282D398B() {
  precache();
}