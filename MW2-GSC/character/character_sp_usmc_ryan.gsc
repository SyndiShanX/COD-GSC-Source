/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_sp_usmc_ryan.gsc
********************************************************/

main() {
  self setModel("body_sp_usmc_ryan");
  self attach("head_sp_usmc_ryan_ryan_body", "", true);
  self.headModel = "head_sp_usmc_ryan_ryan_body";
  self.voice = "american";
}

precache() {
  precacheModel("body_sp_usmc_ryan");
  precacheModel("head_sp_usmc_ryan_ryan_body");
}