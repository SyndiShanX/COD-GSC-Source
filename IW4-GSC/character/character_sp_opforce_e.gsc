/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_sp_opforce_e.gsc
********************************************************/

main() {
  self setModel("body_sp_opforce_e");
  self attach("head_sp_opforce_justin_beanie_body_e", "", true);
  self.headModel = "head_sp_opforce_justin_beanie_body_e";
  self.voice = "russian";
}

precache() {
  precacheModel("body_sp_opforce_e");
  precacheModel("head_sp_opforce_justin_beanie_body_e");
}