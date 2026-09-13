/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_cp_usmc_basic_ar_4.gsc
******************************************************/

main() {
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setModel("body_usmc_basic_ar_4");
  scripts\code\character::attachhead("heads_usmc_male", xmodelalias\heads_usmc_male::main());
  self.hatmodel = "helmet_usmc_basic_ar_4";
  self attach(self.hatmodel);
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
  precachemodel("body_usmc_basic_ar_4");
  scripts\code\character::precachemodelarray(xmodelalias\heads_usmc_male::main());
  precachemodel("helmet_usmc_basic_ar_4");
}

_id_8168FBF6282D398B() {
  precache();
}