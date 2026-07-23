/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\24539.gsc
**************************************/

main() {
  self setModel("body_fso_suit_a");
  self attach("head_london_male_b", "", 1);
  self.headmodel = "head_london_male_b";
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_suit_a");
  precachemodel("head_london_male_b");
}