/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2798e0663d81aa5.gsc
***********************************************/

main() {
  self.animationarchetype = "soldier";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(_id_08D309061EFD73B8::main());
  scripts\code\character::attachhead("heads_iw9_enemy_aq_tier2_1", _id_6385D36B67D7DADD::main());
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
  scripts\code\character::precachemodelarray(_id_08D309061EFD73B8::main());
  scripts\code\character::precachemodelarray(_id_6385D36B67D7DADD::main());
}

_id_8168FBF6282D398B() {
  precache();
}