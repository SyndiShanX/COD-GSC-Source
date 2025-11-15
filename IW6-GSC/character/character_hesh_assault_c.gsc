/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_assault_c.gsc
**************************************************/

main() {
  self setModel("body_hesh_assault_a");
  self attach("head_hesh_assault_x", "", 1);
  self.headmodel = "head_hesh_assault_x";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_hesh_assault_a");
  precachemodel("head_hesh_assault_x");
}