/********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_arab_regular_asad.gsc
********************************************************/

main() {
  self setmodel("body_sp_arab_regular_asad");
  self attach("head_sp_arab_regular_asad", "", 1);
  self.headmodel = "head_sp_arab_regular_asad";
  self.hatmodel = "helmet_sp_arab_regular_asad";
  self attach(self.hatmodel);
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_asad");
  precachemodel("head_sp_arab_regular_asad");
  precachemodel("helmet_sp_arab_regular_asad");
}