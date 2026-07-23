/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_arab_civilian_d.gsc
********************************************************/

main() {
  self setModel("character_arab_civilian_lowres_d");
  self.voice = "arab";
}

precache() {
  precacheModel("character_arab_civilian_lowres_d");
}