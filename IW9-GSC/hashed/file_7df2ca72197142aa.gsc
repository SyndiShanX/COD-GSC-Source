/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7df2ca72197142aa.gsc
***********************************************/

main() {
  self.animationarchetype = "soldier";
  self.voice = "shadowcompany";
  self setModel("body_mp_eastern_velikan_1_1");
  self attach("head_mp_eastern_velikan_1_1", "", 1);
  self.headmodel = "head_mp_eastern_velikan_1_1";
  self setclothtype("vestheavy");
  self _meth_8ABE5A968CC3C220("milhvygr");
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
  precachemodel("body_mp_eastern_velikan_1_1");
  precachemodel("head_mp_eastern_velikan_1_1");
}

_id_8168FBF6282D398B() {
  precache();
}