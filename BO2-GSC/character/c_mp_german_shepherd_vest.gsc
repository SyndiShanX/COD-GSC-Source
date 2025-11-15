/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mp_german_shepherd_vest.gsc
***************************************************/

main() {
  self setModel("german_shepherd_vest");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("german_shepherd_vest");
}