/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_opforce_e.gsc
************************************************/

main() {
  self setmodel("body_ultra_nationalist_assault_e");
  self attach("head_ultra_nationalist_beret", "", 1);
  self.headmodel = "head_ultra_nationalist_beret";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ultra_nationalist_assault_e");
  precachemodel("head_ultra_nationalist_beret");
}