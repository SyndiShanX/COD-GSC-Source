/********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_hugh.gsc
********************************************************/

main() {
  self setmodel("body_sp_sas_woodland_support_a");
  self attach("head_sp_sas_woodland_hugh", "", 1);
  self.headmodel = "head_sp_sas_woodland_hugh";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_sas_woodland_support_a");
  precachemodel("head_sp_sas_woodland_hugh");
}