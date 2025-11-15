/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_sp_usmc_at4.gsc
********************************************************/

main() {
  self setModel("body_sp_usmc_at4");
  self attach("head_sp_usmc_james_james_body", "", true);
  self.headModel = "head_sp_usmc_james_james_body";
  self.voice = "american";
}

precache() {
  precacheModel("body_sp_usmc_at4");
  precacheModel("head_sp_usmc_james_james_body");
}