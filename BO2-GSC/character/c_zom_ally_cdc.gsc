/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_ally_cdc.gsc
****************************************/

main() {
  self setmodel("c_zom_player_cdc_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_cdc_fb");
}