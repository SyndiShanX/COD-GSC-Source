/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_vip_pres.gsc
********************************************/

main() {
  self setModel("body_civ_vip_president");
  self attach("head_civ_vip_president", "", 1);
  self.headmodel = "head_civ_vip_president";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_civ_vip_president");
  precachemodel("head_civ_vip_president");
}