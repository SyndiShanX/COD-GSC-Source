/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_captain_anderson.gsc
************************************************/

main() {
  self setmodel("c_usa_captain_anderson_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_captain_anderson_fb");
}