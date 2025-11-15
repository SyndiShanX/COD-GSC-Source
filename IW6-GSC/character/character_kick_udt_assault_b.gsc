/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_kick_udt_assault_b.gsc
******************************************************/

main() {
  self setModel("body_kick_udt_assault_b");
  self attach("head_kick_udt_head_b", "", 1);
  self.headmodel = "head_kick_udt_head_b";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_kick_udt_assault_b");
  precachemodel("head_kick_udt_head_b");
}