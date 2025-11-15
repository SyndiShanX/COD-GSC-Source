/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_udt_assault_a_skull.gsc
************************************************************/

main() {
  self setModel("body_hesh_udt_assault_ax");
  self attach("head_hesh_udt_head_x_skull", "", 1);
  self.headmodel = "head_hesh_udt_head_x_skull";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_hesh_udt_assault_ax");
  precachemodel("head_hesh_udt_head_x_skull");
}