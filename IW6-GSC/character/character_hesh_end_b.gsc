/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_end_b.gsc
**********************************************/

main() {
  self setModel("body_hesh_end_a");
  self attach("head_hesh_end_head_xb", "", 1);
  self.headmodel = "head_hesh_end_head_xb";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_hesh_end_a");
  precachemodel("head_hesh_end_head_xb");
}