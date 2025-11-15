/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_almagro_assault_a.gsc
*****************************************************/

main() {
  self setModel("body_almagro_assault_a");
  self attach("head_almagro_head_a", "", 1);
  self.headmodel = "head_almagro_head_a";
  self.voice = "shadowcompany";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_almagro_assault_a");
  precachemodel("head_almagro_head_a");
}