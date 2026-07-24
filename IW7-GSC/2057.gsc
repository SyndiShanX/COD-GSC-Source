/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2057.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_a_sys1");
  self attach("head_male_bc_06", "", 1);
  self.headmodel = "head_male_bc_06";
  self.hatmodel = "head_bg_male_06_hair_a_grey";
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
  precachemodel("body_un_crew_ship_a_sys1");
  precachemodel("head_male_bc_06");
  precachemodel("head_bg_male_06_hair_a_grey");
}