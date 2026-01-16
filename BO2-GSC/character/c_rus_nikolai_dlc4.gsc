/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_rus_nikolai_dlc4.gsc
********************************************/

main() {
  self setmodel("c_zom_tomb_nikolai_fb");
  self.voice = "russian";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_tomb_nikolai_fb");
}