/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2064.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_female_a_tac4");
  self attach("head_female_bc_03", "", 1);
  self.headmodel = "head_female_bc_03";
  self.hatmodel = "head_female_bc_03_hat";
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
  precachemodel("body_un_crew_ship_female_a_tac4");
  precachemodel("head_female_bc_03");
  precachemodel("head_female_bc_03_hat");
}