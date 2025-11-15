/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_rorke_assault.gsc
*************************************************/

main() {
  self setModel("body_rorke_assault");
  self attach("head_rorke_assault", "", 1);
  self.headmodel = "head_rorke_assault";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_rorke_assault");
  precachemodel("head_rorke_assault");
}