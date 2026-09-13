/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_38f587124ef1391b.gsc
***********************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(_id_578D8178A691F2C8::main());
  scripts\code\character::attachhead("heads_iw9_enemy_aq_ar_4", _id_41B0172FF5413553::main());
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
  scripts\code\character::precachemodelarray(_id_578D8178A691F2C8::main());
  scripts\code\character::precachemodelarray(_id_41B0172FF5413553::main());
}

_id_8168FBF6282D398B() {
  precache();
}