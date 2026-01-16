/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_al_asad.gsc
**********************************************/

main() {
  self setmodel("body_sp_arab_regular_al_asad");
  self attach("head_khaled_alasad", "", 1);
  self.headmodel = "head_khaled_alasad";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_al_asad");
  precachemodel("head_khaled_alasad");
}