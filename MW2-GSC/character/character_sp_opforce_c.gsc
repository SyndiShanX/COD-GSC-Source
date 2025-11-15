/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_sp_opforce_c.gsc
********************************************************/

main() {
  self setModel("body_sp_opforce_c");
  self attach("head_sp_opforce_david_beanie_body_c", "", true);
  self.headModel = "head_sp_opforce_david_beanie_body_c";
  self.voice = "russian";
}

precache() {
  precacheModel("body_sp_opforce_c");
  precacheModel("head_sp_opforce_david_beanie_body_c");
}