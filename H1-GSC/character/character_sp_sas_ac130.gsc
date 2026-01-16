/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_ac130.gsc
************************************************/

main() {
  self setmodel("body_complete_sp_sas_ct_ac130");
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_complete_sp_sas_ct_ac130");
}