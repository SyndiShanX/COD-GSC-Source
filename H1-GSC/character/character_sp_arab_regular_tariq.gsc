/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_arab_regular_tariq.gsc
*********************************************************/

main() {
  self setmodel("body_sp_arab_regular_tariq");
  self attach("head_sp_arab_regular_tariq", "", 1);
  self.headmodel = "head_sp_arab_regular_tariq";
  self.hatmodel = "helmet_sp_arab_regular_tariq";
  self attach(self.hatmodel);
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_tariq");
  precachemodel("head_sp_arab_regular_tariq");
  precachemodel("helmet_sp_arab_regular_tariq");
}