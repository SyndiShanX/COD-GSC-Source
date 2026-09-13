/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_76ff9d81d2c6b83e.gsc
***********************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "cartel";
  scripts\code\character::setmodelfromarray(_id_1CDB2D1C0B02DB5F::main());
  scripts\code\character::attachhead("heads_iw9_cartel_tier1_3", _id_34F543E684830F46::main());
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
  scripts\code\character::precachemodelarray(_id_1CDB2D1C0B02DB5F::main());
  scripts\code\character::precachemodelarray(_id_34F543E684830F46::main());
}

_id_8168FBF6282D398B() {
  precache();
}