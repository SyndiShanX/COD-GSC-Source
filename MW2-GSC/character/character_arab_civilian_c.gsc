/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_arab_civilian_c.gsc
********************************************************/

main() {
  self setModel("character_arab_civilian_lowres_c");
  self.voice = "arab";
}

precache() {
  precacheModel("character_arab_civilian_lowres_c");
}