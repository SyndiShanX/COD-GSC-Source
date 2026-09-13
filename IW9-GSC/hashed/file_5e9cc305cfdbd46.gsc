/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5e9cc305cfdbd46.gsc
***********************************************/

main() {
  self.animationarchetype = "jailer_baton";
  self.voice = "german";
  self setModel("body_mp_gulag_jugg_light_basebody");
  self attach("head_mp_gulag_jugg_minotavr", "", 1);
  self.headmodel = "head_mp_gulag_jugg_minotavr";
  self.hatmodel = "hat_mp_gulag_jugg_gasmask";
  self attach(self.hatmodel);
  self setclothtype("nylon");
  self _meth_8ABE5A968CC3C220("scubagr");
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
  precachemodel("body_mp_gulag_jugg_light_basebody");
  precachemodel("head_mp_gulag_jugg_minotavr");
  precachemodel("hat_mp_gulag_jugg_gasmask");
}

_id_8168FBF6282D398B() {
  precache();
}