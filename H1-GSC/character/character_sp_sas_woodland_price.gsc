/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_price.gsc
*********************************************************/

main() {
  self setmodel("body_sas_woodland_assault_a");
  self attach("head_sas_woodland_price", "", 1);
  self.headmodel = "head_sas_woodland_price";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_woodland_assault_a");
  precachemodel("head_sas_woodland_price");
}