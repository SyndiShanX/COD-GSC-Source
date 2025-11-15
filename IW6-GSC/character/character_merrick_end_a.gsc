/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_end_a.gsc
*************************************************/

main() {
  self setModel("body_merrick_end_a");
  self attach("head_merrick_end_a", "", 1);
  self.headmodel = "head_merrick_end_a";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_merrick_end_a");
  precachemodel("head_merrick_end_a");
}