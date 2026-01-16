/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_dlc_mech.gsc
****************************************/

main() {
  self setmodel("c_zom_mech_body");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_mech_body");
}