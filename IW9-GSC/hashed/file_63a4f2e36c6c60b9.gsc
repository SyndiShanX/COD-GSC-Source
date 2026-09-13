/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_63a4f2e36c6c60b9.gsc
***********************************************/

main() {
  self.animationarchetype = "civilian_dmz_hostage";
  self.voice = "fsa";
  scripts\code\character::setmodelfromarray(_id_2F86BFCF149EC57E::main());
  self attach("head_hostage_hood_01", "", 1);
  self.headmodel = "head_hostage_hood_01";
  self setclothtype("flowing");
  self _meth_8ABE5A968CC3C220("millghtgr");
  self _meth_1863F51C1339D80F("none");

  if(issentient(self))
    self sethitlocdamagetable("ai_lochit_dmgtable");
}

#using_animtree("generic_human");

_id_951CCE2992B1B0E2() {
  main();
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self useanimtree(#animtree);
}

_id_8EE09B8CB8661567() {
  main();
}

precache() {}

_id_430419022A9C3FFE() {
  precache();
  scripts\code\character::precachemodelarray(_id_2F86BFCF149EC57E::main());
  precachemodel("head_hostage_hood_01");
}

_id_8168FBF6282D398B() {
  precache();
}