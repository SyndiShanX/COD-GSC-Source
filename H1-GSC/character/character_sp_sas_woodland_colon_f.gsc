/***********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_colon_f.gsc
***********************************************************/

main() {
  self setmodel("body_sp_sas_woodland_colon");
  self attach("head_sp_sas_woodland_zied", "", 1);
  self.headmodel = "head_sp_sas_woodland_zied";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_sas_woodland_colon");
  precachemodel("head_sp_sas_woodland_zied");
}