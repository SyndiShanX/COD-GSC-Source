/************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_ct_mitchel_nomask.gsc
************************************************************/

main() {
  self setmodel("body_sas_ct_assault_mitchel");
  self attach("head_slum_civ_male_h", "", 1);
  self.headmodel = "head_slum_civ_male_h";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_ct_assault_mitchel");
  precachemodel("head_slum_civ_male_h");
}