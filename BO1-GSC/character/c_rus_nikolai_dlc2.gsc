/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_rus_nikolai_dlc2.gsc
********************************************/

main() {
  self setModel("c_rus_nikolai_dlc2_body");
  self.voice = "russian";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_rus_nikolai_dlc2_body");
}