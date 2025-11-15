/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elite_pmc_assault_a.gsc
*******************************************************/

main() {
  self setModel("fullbody_elite_pmc_assault_a");
  self.voice = "russian";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("fullbody_elite_pmc_assault_a");
}