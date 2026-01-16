/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_ct_william.gsc
*****************************************************/

main() {
  self setmodel("body_sas_ct_assault_william");
  self attach("head_sas_ct_assault_william", "", 1);
  self.headmodel = "head_sas_ct_assault_william";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_ct_assault_william");
  precachemodel("head_sas_ct_assault_william");
}