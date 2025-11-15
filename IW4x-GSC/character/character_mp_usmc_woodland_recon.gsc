/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_usmc_woodland_recon.gsc
**********************************************************/

main() {
  self setModel("body_mp_usmc_woodland_recon");
  self attach("head_mp_usmc_nomex", "", true);
  self.headModel = "head_mp_usmc_nomex";
  self setViewmodel("viewhands_sas_woodland");
  self.voice = "british";
}

precache() {
  precacheModel("body_mp_usmc_woodland_recon");
  precacheModel("head_mp_usmc_nomex");
  precacheModel("viewhands_sas_woodland");
}