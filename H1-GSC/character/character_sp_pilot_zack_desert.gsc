/********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_pilot_zack_desert.gsc
********************************************************/

main() {
  self setmodel("body_sp_cobra_pilot_desert_zack");
  self attach("head_sp_cobra_pilot_zack_wglasses", "", 1);
  self.headmodel = "head_sp_cobra_pilot_zack_wglasses";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_cobra_pilot_desert_zack");
  precachemodel("head_sp_cobra_pilot_zack_wglasses");
}