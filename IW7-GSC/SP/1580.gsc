/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1580.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_firejack");
  self attach("head_sc_male_20", "", 1);
  self.headmodel = "head_sc_male_20";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_crew_ship_firejack");
  precachemodel("head_sc_male_20");
}