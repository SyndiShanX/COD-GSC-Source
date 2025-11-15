/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_sp_opforce_derik.gsc
********************************************************/

main() {
  self setModel("body_sp_opforce_f");
  self attach("head_sp_opforce_derik_body_f", "", true);
  self.headModel = "head_sp_opforce_derik_body_f";
  self.voice = "russian";
}

precache() {
  precacheModel("body_sp_opforce_f");
  precacheModel("head_sp_opforce_derik_body_f");
}