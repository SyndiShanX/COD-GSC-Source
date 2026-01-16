/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mp_german_shepherd_vest.gsc
***************************************************/

main() {
  self setmodel("german_shepherd_vest");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("german_shepherd_vest");
}