/**************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_soldier2_c.gsc
**************************************************************/

main() {
  self setmodel("body_sas_woodland_soldier_02");
  self attach("head_sas_ct_assault_charles_nomask", "", 1);
  self.headmodel = "head_sas_ct_assault_charles_nomask";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_woodland_soldier_02");
  precachemodel("head_sas_ct_assault_charles_nomask");
}