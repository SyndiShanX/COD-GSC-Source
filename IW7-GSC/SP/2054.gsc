/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2054.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_female_a_ftl1");
  self attach("head_female_bc_02", "", 1);
  self.headmodel = "head_female_bc_02";
  self.hatmodel = "head_female_bc_02_hat";
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
  precachemodel("body_un_crew_ship_female_a_ftl1");
  precachemodel("head_female_bc_02");
  precachemodel("head_female_bc_02_hat");
}