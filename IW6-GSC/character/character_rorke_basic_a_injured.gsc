/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_rorke_basic_a_injured.gsc
*********************************************************/

main() {
  self setModel("body_rorke_basic_a_injured");
  self attach("head_rorke_basic_injured", "", 1);
  self.headmodel = "head_rorke_basic_injured";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_rorke_basic_a_injured");
  precachemodel("head_rorke_basic_injured");
}