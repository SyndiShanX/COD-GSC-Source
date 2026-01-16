/*************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_pilot_velinda_desert_d.gsc
*************************************************************/

main() {
  self setmodel("body_sp_cobra_pilot_desert_velinda_burned");
  self attach("head_sp_cobra_pilot_velinda_damaged", "", 1);
  self.headmodel = "head_sp_cobra_pilot_velinda_damaged";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_cobra_pilot_desert_velinda_burned");
  precachemodel("head_sp_cobra_pilot_velinda_damaged");
}