/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_zodiac_price.gsc
********************************************************/

main() {
  self setModel("body_desert_tf141_zodiac");
  self attach("head_hero_price_desert", "", true);
  self.headModel = "head_hero_price_desert";
  self.voice = "seal";
}

precache() {
  precacheModel("body_desert_tf141_zodiac");
  precacheModel("head_hero_price_desert");
}