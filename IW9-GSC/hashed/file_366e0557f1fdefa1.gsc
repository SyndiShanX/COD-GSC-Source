/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_366e0557f1fdefa1.gsc
***********************************************/

main() {
  self.animationarchetype = "riotshield";
  self.voice = "cartel";
  scripts\code\character::setmodelfromarray(_id_0140294642DAC186::main());
  scripts\code\character::attachhead("heads_iw9_cartel_tier1_4", _id_53F747BC4F90051F::main());
  self setclothtype("cloth");
  self _meth_8ABE5A968CC3C220("none");
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
  scripts\code\character::precachemodelarray(_id_0140294642DAC186::main());
  scripts\code\character::precachemodelarray(_id_53F747BC4F90051F::main());
}

_id_8168FBF6282D398B() {
  precache();
}