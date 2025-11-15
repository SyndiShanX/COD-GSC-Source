/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elias_wood_shotgun_b.gsc
********************************************************/

main() {
  self setModel("body_elias_wood_shotgun_a");
  self attach("head_elias_wood_head_b", "", 1);
  self.headmodel = "head_elias_wood_head_b";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_elias_wood_shotgun_a");
  precachemodel("head_elias_wood_head_b");
}