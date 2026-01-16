/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_spetsnaz_ac130.gsc
*****************************************************/

main() {
  self setmodel("body_complete_sp_spetsnaz_boris_sp_ac130");
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_complete_sp_spetsnaz_boris_sp_ac130");
}