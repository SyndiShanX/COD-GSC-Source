/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1316b4ed28fbc6f9.gsc
***********************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "russian";
  self setModel("body_dmz_opforce_unidentified_iw9_tier_1_3_1");
  self attach("head_dmz_opforce_unidentified_iw9_tier_1_3_1", "", 1);
  self.headmodel = "head_dmz_opforce_unidentified_iw9_tier_1_3_1";
  self setclothtype("nylon");
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
  precachemodel("body_dmz_opforce_unidentified_iw9_tier_1_3_1");
  precachemodel("head_dmz_opforce_unidentified_iw9_tier_1_3_1");
}

_id_8168FBF6282D398B() {
  precache();
}