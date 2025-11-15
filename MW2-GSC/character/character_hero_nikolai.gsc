/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_nikolai.gsc
********************************************************/

main() {
  self setModel("body_hero_nikolai");
  self attach("head_hero_nikolai", "", true);
  self.headModel = "head_hero_nikolai";
  self.voice = "russian";
}

precache() {
  precacheModel("body_hero_nikolai");
  precacheModel("head_hero_nikolai");
}