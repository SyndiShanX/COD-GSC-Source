/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_german_shepherd.gsc
*******************************************************/

main() {
  self setmodel("german_shepherd");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("german_shepherd");
}