/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_kick_assault_a.gsc
**************************************************/

main() {
  self setModel("body_kick_assault_a");
  self attach("head_kick_assault_head_a", "", 1);
  self.headmodel = "head_kick_assault_head_a";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_kick_assault_a");
  precachemodel("head_kick_assault_head_a");
}