/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_al_qatala_desert_ar.gsc
*******************************************************/

main() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setModel("body_al_qatala_desert_01");
  self attach("head_al_qatala_desert_01", "", 1);
  self.headmodel = "head_al_qatala_desert_01";
  self setclothtype("vestlight");
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
  precachemodel("body_al_qatala_desert_01");
  precachemodel("head_al_qatala_desert_01");
}

_id_8168FBF6282D398B() {
  precache();
}