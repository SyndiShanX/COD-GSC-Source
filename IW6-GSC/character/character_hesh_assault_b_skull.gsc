/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_assault_b_skull.gsc
********************************************************/

main() {
  self setModel("body_hesh_assault_a");
  self attach("head_hesh_assault_xb_skull", "", 1);
  self.headmodel = "head_hesh_assault_xb_skull";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_hesh_assault_a");
  precachemodel("head_hesh_assault_xb_skull");
}