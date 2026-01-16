/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_seal6_drone1.gsc
********************************************/

main() {
  self setmodel("c_usa_seal6_drone_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_seal6_drone_fb");
}