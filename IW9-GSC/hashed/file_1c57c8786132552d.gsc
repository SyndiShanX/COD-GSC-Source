/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1c57c8786132552d.gsc
***********************************************/

main() {
  self.animationarchetype = "soldier";
  self.voice = "mexicanspecialforces";
  self setModel("body_sp_ally_mex_sf_d");
  self attach("head_sp_ally_mex_sf_d", "", 1);
  self.headmodel = "head_sp_ally_mex_sf_d";
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
  precachemodel("body_sp_ally_mex_sf_d");
  precachemodel("head_sp_ally_mex_sf_d");
}

_id_8168FBF6282D398B() {
  precache();
}