/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1183.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("civ_miner_01_body");
  self attach("head_sc_male_11", "", 1);
  self.headmodel = "head_sc_male_11";
  self.hatmodel = "head_sc_male_11_bg_hair_male_a_black";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("civ_miner_01_body");
  precachemodel("head_sc_male_11");
  precachemodel("head_sc_male_11_bg_hair_male_a_black");
}