/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_ct_mitchel.gsc
*****************************************************/

main() {
  self setmodel("body_sas_ct_assault_mitchel");
  self attach("head_sas_ct_assault_mitchel", "", 1);
  self.headmodel = "head_sas_ct_assault_mitchel";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_ct_assault_mitchel");
  precachemodel("head_sas_ct_assault_mitchel");
}