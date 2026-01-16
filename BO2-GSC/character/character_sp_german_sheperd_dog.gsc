/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_sp_german_sheperd_dog.gsc
*************************************************************/

main() {
  self setmodel("german_sheperd_dog");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("german_sheperd_dog");
}