/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23448.gsc
**************************************/

main() {
  self setModel("body_warlord");
  self attach("head_warlord", "", 1);
  self.headmodel = "head_warlord";
  self.voice = "african";
}

precache() {
  precachemodel("body_warlord");
  precachemodel("head_warlord");
}