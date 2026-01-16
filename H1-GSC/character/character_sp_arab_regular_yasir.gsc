/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_arab_regular_yasir.gsc
*********************************************************/

main() {
  self setmodel("body_sp_arab_regular_yasir");
  self attach("head_sp_arab_regular_mowrap", "", 1);
  self.headmodel = "head_sp_arab_regular_mowrap";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_yasir");
  precachemodel("head_sp_arab_regular_mowrap");
}