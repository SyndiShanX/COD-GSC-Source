/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_rorke_basic_b.gsc
*************************************************/

main() {
  self setModel("body_rorke_basic_b");
  self attach("head_rorke_basic", "", 1);
  self.headmodel = "head_rorke_basic";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_rorke_basic_b");
  precachemodel("head_rorke_basic");
}