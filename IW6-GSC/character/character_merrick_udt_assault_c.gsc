/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_udt_assault_c.gsc
*********************************************************/

main() {
  self setModel("body_merrick_udt_assault_b");
  self attach("head_merrick_udt_head_c", "", 1);
  self.headmodel = "head_merrick_udt_head_c";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_merrick_udt_assault_b");
  precachemodel("head_merrick_udt_head_c");
}