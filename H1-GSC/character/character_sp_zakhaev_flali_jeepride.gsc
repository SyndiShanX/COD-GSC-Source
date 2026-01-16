/*************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_zakhaev_flali_jeepride.gsc
*************************************************************/

main() {
  self setmodel("body_zakhaev_imran_gimp_jeepride");
  self attach("head_zakhaev_imran_jeepride", "", 1);
  self.headmodel = "head_zakhaev_imran_jeepride";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_zakhaev_imran_gimp_jeepride");
  precachemodel("head_zakhaev_imran_jeepride");
}