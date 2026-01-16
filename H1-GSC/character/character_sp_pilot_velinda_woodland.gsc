/*************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_pilot_velinda_woodland.gsc
*************************************************************/

main() {
  self setmodel("body_sp_cobra_pilot_woodland_velinda");
  self attach("head_sp_cobra_pilot_velinda", "", 1);
  self.headmodel = "head_sp_cobra_pilot_velinda";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_cobra_pilot_woodland_velinda");
  precachemodel("head_sp_cobra_pilot_velinda");
}