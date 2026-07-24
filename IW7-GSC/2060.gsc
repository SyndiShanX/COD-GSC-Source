/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2060.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09E0::main());
  self attach("head_female_bc_01", "", 1);
  self.headmodel = "head_female_bc_01";
  self.hatmodel = "head_bg_comms_officer_hair_a_brown";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09E0::main());
  precachemodel("head_female_bc_01");
  precachemodel("head_bg_comms_officer_hair_a_brown");
}