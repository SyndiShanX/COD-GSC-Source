/***********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_afro_01.gsc
***********************************************************/

main() {
  self setmodel("body_sas_woodland_soldier_afro_01");
  self attach("head_sp_sas_woodland_soldier_afro_01", "", 1);
  self.headmodel = "head_sp_sas_woodland_soldier_afro_01";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_woodland_soldier_afro_01");
  precachemodel("head_sp_sas_woodland_soldier_afro_01");
}