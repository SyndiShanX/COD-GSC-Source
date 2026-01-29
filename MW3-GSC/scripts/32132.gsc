/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\32132.gsc
**************************************/

main() {
  self setModel("body_fso_suit_a");
  self attach("head_fso_f", "", 1);
  self.headmodel = "head_fso_f";
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_suit_a");
  precachemodel("head_fso_f");
}