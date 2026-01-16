/**********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_pilot_zack_desert_d.gsc
**********************************************************/

main() {
  self setmodel("body_sp_cobra_pilot_desert_zack_burned");
  self attach("head_sp_cobra_pilot_zack_wglasses", "", 1);
  self.headmodel = "head_sp_cobra_pilot_zack_wglasses";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_cobra_pilot_desert_zack_burned");
  precachemodel("head_sp_cobra_pilot_zack_wglasses");
}