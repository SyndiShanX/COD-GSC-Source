/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3874cfa9b4b053cf.gsc
***********************************************/

main() {
  self.animationarchetype = "juggernaut";
  self.voice = "alqatala";
  self setModel("body_sp_opforce_aq_jugg_basebody");
  self attach("head_sp_opforce_aq_jugg", "", 1);
  self.headmodel = "head_sp_opforce_aq_jugg";
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
  precachemodel("body_sp_opforce_aq_jugg_basebody");
  precachemodel("head_sp_opforce_aq_jugg");
}

_id_8168FBF6282D398B() {
  precache();
}