/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5d72bf34490e3e19.gsc
***********************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setModel("body_sp_opforce_al_qatala_tier_1_rpg_1_1");
  self attach("head_sp_opforce_al_qatala_ar_2_1", "", 1);
  self.headmodel = "head_sp_opforce_al_qatala_ar_2_1";
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
  precachemodel("body_sp_opforce_al_qatala_tier_1_rpg_1_1");
  precachemodel("head_sp_opforce_al_qatala_ar_2_1");
}

_id_8168FBF6282D398B() {
  precache();
}