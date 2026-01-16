/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_arab_regular_sadiq.gsc
*********************************************************/

main() {
  self setmodel("body_sp_arab_regular_sadiq");
  self attach("head_sp_arab_regular_sadiq", "", 1);
  self.headmodel = "head_sp_arab_regular_sadiq";
  self.hatmodel = "helmet_sp_arab_regular_sadiq";
  self attach(self.hatmodel);
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_sadiq");
  precachemodel("head_sp_arab_regular_sadiq");
  precachemodel("helmet_sp_arab_regular_sadiq");
}