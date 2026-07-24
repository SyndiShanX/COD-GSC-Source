/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1189.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("civ_miner_01_body");
  self attach("head_bg_var_head_sc_male_19_head_sc_ling", "", 1);
  self.headmodel = "head_bg_var_head_sc_male_19_head_sc_ling";
  self.hatmodel = "head_sc_male_19_bg_hair_male_c_black";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("civ_miner_01_body");
  precachemodel("head_bg_var_head_sc_male_19_head_sc_ling");
  precachemodel("head_sc_male_19_bg_hair_male_c_black");
}