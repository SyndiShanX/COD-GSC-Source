/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_ct_price.gsc
***************************************************/

main() {
  self setmodel("body_sas_ct_assault_price");
  self attach("head_sas_ct_assault_price_mask_down", "", 1);
  self.headmodel = "head_sas_ct_assault_price_mask_down";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sas_ct_assault_price");
  precachemodel("head_sas_ct_assault_price_mask_down");
}