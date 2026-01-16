/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_zakhaevs_son.gsc
***************************************************/

main() {
  self setmodel("body_zakhaev_viktor");
  self attach("head_zakhaev_viktor", "", 1);
  self.headmodel = "head_zakhaev_viktor";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_zakhaev_viktor");
  precachemodel("head_zakhaev_viktor");
}