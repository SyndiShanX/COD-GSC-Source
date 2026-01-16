/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_al_asad_dmg.gsc
**************************************************/

main() {
  self setmodel("body_sp_arab_regular_al_asad_beatup");
  self attach("head_khaled_alasad_beatup", "", 1);
  self.headmodel = "head_khaled_alasad_beatup";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_al_asad_beatup");
  precachemodel("head_khaled_alasad_beatup");
}