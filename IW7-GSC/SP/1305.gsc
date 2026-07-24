/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1305.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_sdf_capital_ship_captain");
  self attach("head_sc_male_17", "", 1);
  self.headmodel = "head_sc_male_17";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "setdef";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_sdf_capital_ship_captain");
  precachemodel("head_sc_male_17");
}