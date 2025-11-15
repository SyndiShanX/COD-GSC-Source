/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_end_a.gsc
**********************************************/

main() {
  self setModel("body_hesh_end_a");
  self attach("head_hesh_end_head_x", "", 1);
  self.headmodel = "head_hesh_end_head_x";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_hesh_end_a");
  precachemodel("head_hesh_end_head_x");
}