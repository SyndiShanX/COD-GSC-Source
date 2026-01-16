/**************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_soldier2_e.gsc
**************************************************************/

main() {
  self setmodel("body_sas_woodland_soldier_02");
  self attach("head_sp_sas_woodland_hugh", "", 1);
  self.headmodel = "head_sp_sas_woodland_hugh";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_woodland_soldier_02");
  precachemodel("head_sp_sas_woodland_hugh");
}