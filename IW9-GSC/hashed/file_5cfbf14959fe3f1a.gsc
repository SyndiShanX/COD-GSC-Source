/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5cfbf14959fe3f1a.gsc
***********************************************/

main() {
  self.animationarchetype = "riotshield";
  self.voice = "cartel";
  scripts\code\character::setmodelfromarray(_id_7B11CAF880DC4C52::main());
  scripts\code\character::attachhead("heads_iw9_cartel_tier_3_1", _id_1C9A617D1FA2071D::main());
  self setclothtype("leather");
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
  scripts\code\character::precachemodelarray(_id_7B11CAF880DC4C52::main());
  scripts\code\character::precachemodelarray(_id_1C9A617D1FA2071D::main());
}

_id_8168FBF6282D398B() {
  precache();
}