/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elite_pmc_lmg_b_desert_hs.gsc
*************************************************************/

main() {
  self setModel("body_elite_pmc_lmg_b_desert");
  self attach("head_fed_basic_c", "", 1);
  self.headmodel = "head_fed_basic_c";
  self.voice = "russian";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_elite_pmc_lmg_b_desert");
  precachemodel("head_fed_basic_c");
}