/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_zakhaev_onearm.gsc
*****************************************************/

main() {
  self setmodel("body_zakhaev_imran_onearm");
  self attach("head_zakhaev_imran", "", 1);
  self.headmodel = "head_zakhaev_imran";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_zakhaev_imran_onearm");
  precachemodel("head_zakhaev_imran");
}