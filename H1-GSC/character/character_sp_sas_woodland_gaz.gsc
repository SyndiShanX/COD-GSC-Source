/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_gaz.gsc
*******************************************************/

main() {
  self setmodel("body_sas_woodland_gaz");
  self attach("head_sas_woodland_gaz", "", 1);
  self.headmodel = "head_sas_woodland_gaz";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_woodland_gaz");
  precachemodel("head_sas_woodland_gaz");
}