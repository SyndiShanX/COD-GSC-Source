/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_opforce_f.gsc
************************************************/

main() {
  self setmodel("body_ultra_nationalist_assault_f");
  self attach("head_ultra_nationalist_gasmask", "", 1);
  self.headmodel = "head_ultra_nationalist_gasmask";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ultra_nationalist_assault_f");
  precachemodel("head_ultra_nationalist_gasmask");
}