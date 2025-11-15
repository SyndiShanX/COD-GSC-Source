/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_usmc_woodland_specops.gsc
************************************************************/

main() {
  self setModel("body_mp_usmc_woodland_specops");
  self attach("head_mp_usmc_tactical_mich_stripes_nomex", "", true);
  self.headModel = "head_mp_usmc_tactical_mich_stripes_nomex";
  self setViewmodel("viewhands_sas_woodland");
  self.voice = "british";
}

precache() {
  precacheModel("body_mp_usmc_woodland_specops");
  precacheModel("head_mp_usmc_tactical_mich_stripes_nomex");
  precacheModel("viewhands_sas_woodland");
}