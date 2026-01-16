/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_opforce_vip.gsc
**************************************************/

main() {
  self setmodel("body_spetsnaz_nikolai_informant");
  self attach("head_russian_loyalist_beatup_nikolai", "", 1);
  self.headmodel = "head_russian_loyalist_beatup_nikolai";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_spetsnaz_nikolai_informant");
  precachemodel("head_russian_loyalist_beatup_nikolai");
}