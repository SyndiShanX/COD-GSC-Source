/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_keegan_wood_sniper_b.gsc
********************************************************/

main() {
  self setModel("body_keegan_wood_sniper_a");
  self attach("head_keegan_wood_head_a_skull", "", 1);
  self.headmodel = "head_keegan_wood_head_a_skull";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_keegan_wood_sniper_a");
  precachemodel("head_keegan_wood_head_a_skull");
}