/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_rorke_assault_nogear_injured.gsc
****************************************************************/

main() {
  self setModel("body_rorke_assault_b_nogear_injured");
  self attach("head_rorke_assault_injured", "", 1);
  self.headmodel = "head_rorke_assault_injured";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_rorke_assault_b_nogear_injured");
  precachemodel("head_rorke_assault_injured");
}