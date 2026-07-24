/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2061.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_a_tac1");
  self attach("head_male_bc_01", "", 1);
  self.headmodel = "head_male_bc_01";
  self.hatmodel = "head_male_bc_01_hair";
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
  precachemodel("body_un_crew_ship_a_tac1");
  precachemodel("head_male_bc_01");
  precachemodel("head_male_bc_01_hair");
}