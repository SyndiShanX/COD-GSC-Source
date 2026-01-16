/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_angola_woods.gsc
********************************************/

main() {
  self setmodel("c_usa_angola_woods_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_angola_woods_fb");
}