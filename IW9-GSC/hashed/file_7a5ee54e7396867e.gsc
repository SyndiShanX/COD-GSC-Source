/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7a5ee54e7396867e.gsc
***********************************************/

main() {
  self.animationarchetype = "soldier";
  self.voice = "shadowcompany";
  scripts\code\character::setmodelfromarray(_id_689A7BC0535AD987::main());
  scripts\code\character::attachhead("heads_iw9_enemy_biolab_tier2_1", _id_0E9C5C1271EF75A6::main());
  self setclothtype("flowing");
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
  scripts\code\character::precachemodelarray(_id_689A7BC0535AD987::main());
  scripts\code\character::precachemodelarray(_id_0E9C5C1271EF75A6::main());
}

_id_8168FBF6282D398B() {
  precache();
}