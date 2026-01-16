/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_seal80s_mason.gsc
*********************************************/

main() {
  self setmodel("c_usa_seal80s_mason_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_seal80s_mason_fb");
}