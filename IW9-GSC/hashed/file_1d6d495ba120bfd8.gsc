/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1d6d495ba120bfd8.gsc
***********************************************/

main() {
  self.animationarchetype = "riotshield";
  self.voice = "cartel";
  self setModel("body_sp_opforce_cartel_tier_2_5_1");
  scripts\code\character::attachhead("heads_iw9_cartel_tier2_2", _id_61EFFA7B85F6C4A0::main());
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
  precachemodel("body_sp_opforce_cartel_tier_2_5_1");
  scripts\code\character::precachemodelarray(_id_61EFFA7B85F6C4A0::main());
  precachemodel("hat_russian_army_5_hide");
}

_id_8168FBF6282D398B() {
  precache();
}