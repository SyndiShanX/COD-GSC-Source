/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_ct_neal.gsc
**************************************************/

main() {
  self setmodel("body_sas_ct_assault_neal");
  self attach("head_sas_ct_assault_neal", "", 1);
  self.headmodel = "head_sas_ct_assault_neal";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_ct_assault_neal");
  precachemodel("head_sas_ct_assault_neal");
}