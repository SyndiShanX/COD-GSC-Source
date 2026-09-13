/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6bf1d587aa0e25ca.gsc
***********************************************/

main() {
  self.animationarchetype = "rusher";
  self.voice = "alqatala";
  self setModel("fullbody_zombie_a");
  self setclothtype("flowing");
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
  precachemodel("fullbody_zombie_a");
}

_id_8168FBF6282D398B() {
  precache();
}