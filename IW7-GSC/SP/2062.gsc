/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2062.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_b_tac2");
  self attach("head_male_bc_05", "", 1);
  self.headmodel = "head_male_bc_05";
  self.hatmodel = "head_male_bc_05_hat";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_crew_ship_b_tac2");
  precachemodel("head_male_bc_05");
  precachemodel("head_male_bc_05_hat");
}