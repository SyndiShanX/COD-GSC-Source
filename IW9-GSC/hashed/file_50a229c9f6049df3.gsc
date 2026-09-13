/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_50a229c9f6049df3.gsc
***********************************************/

main() {
  self.animationarchetype = "zombie_lw_br";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(_id_14CE64B7A2175AAB::main());
  self setclothtype("vestlight");
  self _meth_8ABE5A968CC3C220("millghtgr");
  self _meth_1863F51C1339D80F("none");

  if(issentient(self))
    self sethitlocdamagetable("c8_lochit_dmgtable");
}

#using_animtree("zombie");

_id_951CCE2992B1B0E2() {
  main();
  self.bhasthighholster = 0;
  self.animtree = "zombie";
  self useanimtree(#animtree);
}

_id_8EE09B8CB8661567() {
  main();
}

precache() {}

_id_430419022A9C3FFE() {
  precache();
  scripts\code\character::precachemodelarray(_id_14CE64B7A2175AAB::main());
}

_id_8168FBF6282D398B() {
  precache();
}