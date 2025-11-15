/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_german_shepherd.gsc
******************************************************/

main() {
  self setModel("german_shepherd");
  self.voice = "american";
}

precache() {
  precacheModel("german_shepherd");
}