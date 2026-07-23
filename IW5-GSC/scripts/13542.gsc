/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\13542.gsc
**************************************/

main() {
  self setModel("body_fso_suit_advisor");
  self attach("head_fso_advisor", "", 1);
  self.headmodel = "head_fso_advisor";
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_suit_advisor");
  precachemodel("head_fso_advisor");
}