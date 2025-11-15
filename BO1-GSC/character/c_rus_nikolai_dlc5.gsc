/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_rus_nikolai_dlc5.gsc
********************************************/

main() {
  self setModel("c_rus_nikolai_dlc5_body");
  self.headModel = "c_rus_nikolai_dlc5_head";
  self attach(self.headModel, "", true);
  self.voice = "russian";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_rus_nikolai_dlc5_body");
  precacheModel("c_rus_nikolai_dlc5_head");
}