/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_45457f1953c82ec5.gsc
***********************************************/

main() {
  self.animationarchetype = "elite_01";
  self.voice = "alqatala";
  self setModel("body_sp_opforce_al_qatala_tier_3_strike_1_1");
  scripts\code\character::attachhead("heads_iw9_enemy_aq_tier3_1", _id_4A7BA708170190F6::main());
  self setclothtype("vestlight");
  self _meth_8ABE5A968CC3C220("milmedgr");
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
  precachemodel("body_sp_opforce_al_qatala_tier_3_strike_1_1");
  scripts\code\character::precachemodelarray(_id_4A7BA708170190F6::main());
}

_id_8168FBF6282D398B() {
  precache();
}