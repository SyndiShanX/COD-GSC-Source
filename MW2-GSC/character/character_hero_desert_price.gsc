/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_desert_price.gsc
********************************************************/

main() {
  self setModel("body_desert_tf141_assault_a");
  self attach("head_hero_price_desert", "", true);
  self.headModel = "head_hero_price_desert";
  self.voice = "seal";
}

precache() {
  precacheModel("body_desert_tf141_assault_a");
  precacheModel("head_hero_price_desert");
}