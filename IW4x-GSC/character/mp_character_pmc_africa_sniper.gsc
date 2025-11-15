/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_pmc_africa_sniper.gsc
********************************************************/

main() {
  self setModel("mp_body_ally_pmc_sniper");
  self setviewmodel("viewhands_pmc");
  self.voice = "taskforce";
}

precache() {
  precachemodel("mp_body_ally_pmc_sniper");
  precachemodel("viewhands_pmc");
}