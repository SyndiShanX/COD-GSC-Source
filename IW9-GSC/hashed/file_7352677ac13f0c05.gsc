/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7352677ac13f0c05.gsc
***********************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setModel("body_sp_opforce_al_qatala_ar_2_2");
  scripts\code\character::attachhead("heads_iw9_enemy_aq_ar_2", _id_6EC1F840FC6B3B91::main());
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
  precachemodel("body_sp_opforce_al_qatala_ar_2_2");
  scripts\code\character::precachemodelarray(_id_6EC1F840FC6B3B91::main());
}

_id_8168FBF6282D398B() {
  precache();
}