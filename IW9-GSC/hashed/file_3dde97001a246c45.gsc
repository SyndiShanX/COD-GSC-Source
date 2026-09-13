/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3dde97001a246c45.gsc
***********************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setModel("body_sp_opforce_al_qatala_tier_1_fire_1_1");
  scripts\code\character::attachhead("heads_iw9_enemy_aq_firebug", _id_730330E86BC1CD8D::main());
  self setclothtype("flowing");
  self _meth_8ABE5A968CC3C220("strapsgr");
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
  precachemodel("body_sp_opforce_al_qatala_tier_1_fire_1_1");
  scripts\code\character::precachemodelarray(_id_730330E86BC1CD8D::main());
}

_id_8168FBF6282D398B() {
  precache();
}