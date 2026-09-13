/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_678c235c76d4a159.gsc
***********************************************/

main() {
  self.animationarchetype = "suicidebomber";
  self.voice = "alqatala";
  self setModel("body_sp_opforce_al_qatala_ar_3_1_bomber");
  scripts\code\character::attachhead("heads_iw9_enemy_aq_desert_1", _id_1907791B7F8AE026::main());
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
  precachemodel("body_sp_opforce_al_qatala_ar_3_1_bomber");
  scripts\code\character::precachemodelarray(_id_1907791B7F8AE026::main());
}

_id_8168FBF6282D398B() {
  precache();
}