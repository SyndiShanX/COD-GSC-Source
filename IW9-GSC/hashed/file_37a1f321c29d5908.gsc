/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_37a1f321c29d5908.gsc
***********************************************/

main() {
  self.animationarchetype = "riotshield";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(_id_591AEB2489068597::main());
  self attach("head_nvg_sp_opforce_al_qatala_tier_3_1", "", 1);
  self.headmodel = "head_nvg_sp_opforce_al_qatala_tier_3_1";
  self setclothtype("flowing");
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
  scripts\code\character::precachemodelarray(_id_591AEB2489068597::main());
  precachemodel("head_nvg_sp_opforce_al_qatala_tier_3_1");
}

_id_8168FBF6282D398B() {
  precache();
}