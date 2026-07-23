/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_sp_usmc_zach_goggles.gsc
********************************************************/

main() {
  self setModel("body_sp_usmc_zach");
  self attach("head_sp_usmc_zach_zach_body_goggles", "", true);
  self.headModel = "head_sp_usmc_zach_zach_body_goggles";
  self.voice = "american";
}

precache() {
  precacheModel("body_sp_usmc_zach");
  precacheModel("head_sp_usmc_zach_zach_body_goggles");
}