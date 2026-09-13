/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_52f72c2e5da46164.gsc
***********************************************/

main() {
  self.animationarchetype = "rusher";
  self.voice = "shadowcompany";
  self setModel("body_wz_opforce_shadow_company_armored_rusher_1_1");
  self attach("head_sp_opforce_shadow_company_armored_ar_1_2", "", 1);
  self.headmodel = "head_sp_opforce_shadow_company_armored_ar_1_2";
  self setclothtype("cloth");
  self _meth_8ABE5A968CC3C220("milmedgr");
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
  precachemodel("body_wz_opforce_shadow_company_armored_rusher_1_1");
  precachemodel("head_sp_opforce_shadow_company_armored_ar_1_2");
}

_id_8168FBF6282D398B() {
  precache();
}