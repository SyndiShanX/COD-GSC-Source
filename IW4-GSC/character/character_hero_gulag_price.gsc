/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_gulag_price.gsc
********************************************************/

main() {
  self setModel("body_hero_price_gulag");
  self attach("head_hero_price_gulag", "", true);
  self.headModel = "head_hero_price_gulag";
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_hero_price_gulag");
  precacheModel("head_hero_price_gulag");
}