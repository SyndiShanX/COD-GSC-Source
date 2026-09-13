/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_16dc000513f0ec83.gsc
***********************************************/

main() {
  self.animationarchetype = "riotshield";
  self.voice = "cartel";
  scripts\code\character::setmodelfromarray(_id_21BD7CE230EB4444::main());
  scripts\code\character::attachhead("heads_iw9_cartel_tier2_1", _id_398FFA5FAFA17AB9::main());
  self.hatmodel = "hat_russian_army_5_hide";
  self attach(self.hatmodel);
  self setclothtype("cloth");
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
  scripts\code\character::precachemodelarray(_id_21BD7CE230EB4444::main());
  scripts\code\character::precachemodelarray(_id_398FFA5FAFA17AB9::main());
  precachemodel("hat_russian_army_5_hide");
}

_id_8168FBF6282D398B() {
  precache();
}