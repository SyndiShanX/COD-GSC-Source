/************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_arab_regular_ski_mask.gsc
************************************************************/

main() {
  self setmodel("body_sp_arab_regular_asad");
  self attach("head_sp_arab_regular_ski_mask", "", 1);
  self.headmodel = "head_sp_arab_regular_ski_mask";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_asad");
  precachemodel("head_sp_arab_regular_ski_mask");
}