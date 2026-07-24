/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1306.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_sdf_capital_ship_captain");
  self attach("head_sc_male_24", "", 1);
  self.headmodel = "head_sc_male_24";
  self.hatmodel = "head_sc_male_24_bg_hair_male_c_black";
  self attach(self.hatmodel);
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
  precachemodel("head_sc_male_24");
  precachemodel("head_sc_male_24_bg_hair_male_c_black");
}