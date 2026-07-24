/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1178.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("civ_miner_female");
  self attach("head_sc_owens", "", 1);
  self.headmodel = "head_sc_owens";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("civ_miner_female");
  precachemodel("head_sc_owens");
}