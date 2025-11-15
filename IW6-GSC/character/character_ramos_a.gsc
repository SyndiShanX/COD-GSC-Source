/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_ramos_a.gsc
*******************************************/

main() {
  self setModel("body_ramos_b");
  self attach("head_ramos_x", "", 1);
  self.headmodel = "head_ramos_x";
  self.voice = "russian";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_ramos_b");
  precachemodel("head_ramos_x");
}