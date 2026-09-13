/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_69a4e67b9721af2d.gsc
***********************************************/

main() {
  self.animationarchetype = "soldier";
  self.voice = "alqatala";
  self setModel("body_mp_hadir_iw9_1_1_cp");
  self attach("head_hero_hadir", "", 1);
  self.headmodel = "head_hero_hadir";
  self setclothtype("vestlight");
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
  precachemodel("body_mp_hadir_iw9_1_1_cp");
  precachemodel("head_hero_hadir");
}

_id_8168FBF6282D398B() {
  precache();
}