/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_seal_udt_ghost.gsc
********************************************************/

main() {
  self setModel("body_hero_seal_udt_ghost");
  self attach("head_hero_ghost_udt", "", true);
  self.headModel = "head_hero_ghost_udt";
  self.voice = "seal";
}

precache() {
  precacheModel("body_hero_seal_udt_ghost");
  precacheModel("head_hero_ghost_udt");
}