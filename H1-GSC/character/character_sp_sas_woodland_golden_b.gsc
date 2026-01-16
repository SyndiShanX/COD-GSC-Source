/************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_golden_b.gsc
************************************************************/

main() {
  self setmodel("body_sp_sas_woodland_golden");
  self attach("head_sas_ct_assault_neal_nomask", "", 1);
  self.headmodel = "head_sas_ct_assault_neal_nomask";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_sas_woodland_golden");
  precachemodel("head_sas_ct_assault_neal_nomask");
}