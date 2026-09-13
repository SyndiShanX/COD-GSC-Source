/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_42e4a32f2ae4b5c6.gsc
***********************************************/

main() {
  self.animationarchetype = "soldier_sniper";
  self.voice = "alqatala";
  self setModel("body_mp_eastern_bale_6_1");
  self attach("head_mp_eastern_fireteam_east_nvg_1", "", 1);
  self.headmodel = "head_mp_eastern_fireteam_east_nvg_1";
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
  precachemodel("body_mp_eastern_bale_6_1");
  precachemodel("head_mp_eastern_fireteam_east_nvg_1");
}

_id_8168FBF6282D398B() {
  precache();
}