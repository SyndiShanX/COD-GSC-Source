/******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_ct_benjamin.gsc
******************************************************/

main() {
  self setmodel("body_sas_ct_assault_benjamin");
  self attach("head_sas_ct_assault_benjamin", "", 1);
  self.headmodel = "head_sas_ct_assault_benjamin";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_ct_assault_benjamin");
  precachemodel("head_sas_ct_assault_benjamin");
}