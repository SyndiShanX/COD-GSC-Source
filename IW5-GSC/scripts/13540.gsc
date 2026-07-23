/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\13540.gsc
**************************************/

main() {
  self setModel("body_fso_vest_e_dirty");
  self attach("head_fso_commander_hat", "", 1);
  self.headmodel = "head_fso_commander_hat";
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_vest_e_dirty");
  precachemodel("head_fso_commander_hat");
}