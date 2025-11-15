/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_sp_usmc_force_b.gsc
********************************************************/

main() {
  self setModel("body_sp_usmc_force_b");
  self attach("head_sp_usmc_force_chad", "", true);
  self.headModel = "head_sp_usmc_force_chad";
  self.voice = "american";
}

precache() {
  precacheModel("body_sp_usmc_force_b");
  precacheModel("head_sp_usmc_force_chad");
}