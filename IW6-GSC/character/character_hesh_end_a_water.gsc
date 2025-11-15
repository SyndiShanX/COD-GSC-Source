/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_end_a_water.gsc
****************************************************/

main() {
  self setModel("body_hesh_end_b");
  self attach("head_hesh_end_head_x_water", "", 1);
  self.headmodel = "head_hesh_end_head_x_water";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_hesh_end_b");
  precachemodel("head_hesh_end_head_x_water");
}