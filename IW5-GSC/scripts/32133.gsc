/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\32133.gsc
**************************************/

main() {
  self setModel("body_fso_suit_a");
  self attach("head_fso_c", "", 1);
  self.headmodel = "head_fso_c";
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_suit_a");
  precachemodel("head_fso_c");
}