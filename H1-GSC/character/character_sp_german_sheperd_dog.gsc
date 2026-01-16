/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_german_sheperd_dog.gsc
*********************************************************/

main() {
  self setmodel("german_sheperd_dog");
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("german_sheperd_dog");
}